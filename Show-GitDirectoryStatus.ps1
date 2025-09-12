#Requires -Version 7.3
<#
.SYNOPSIS
    Scans recursively for Git repositories under a specified root directory and summarizes their status.

.DESCRIPTION
    This advanced cmdlet searches for all Git repositories (directories containing a .git folder) under the given root directory.
    For each repository found, it displays the current branch, counts of untracked, modified, added, deleted files, stash count, and remote URL.
    The output is color-coded for quick visual inspection of clean/dirty status and remote presence.

.PARAMETER RootDirectory
    The root directory to scan recursively for Git repositories. Defaults to the user's home directory.

.PARAMETER PassThru
    If specified, returns the raw status objects instead of formatted table output.

.EXAMPLE
    Show-GitDirectoryStatus -RootDirectory "C:\Projects"

.EXAMPLE
    Show-GitDirectoryStatus -PassThru | Where-Object { $_.Untracked.Count -gt 0 }

.NOTES
    Requires Git to be installed and available in the system PATH.
#>

[CmdletBinding()]
param (
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [Alias('Path')]
    [System.IO.DirectoryInfo]$RootDirectory = [System.IO.DirectoryInfo]::new($HOME),
    [switch]$PassThru = $false
)


begin {
    try {
        git --version | Out-Null
    } catch {
        throw 'Git is not installed or not available in PATH.'
    }
    $gitDirectoryStatus = @()

    function Get-GitStatus {
        param (
            [Parameter(Mandatory)]
            [System.IO.DirectoryInfo] $GitDirectory
        )
        
        try {
            $repoPath = $GitDirectory.Parent.FullName
            $status = git -C $repoPath status --porcelain --branch # --show-stash does not work in all git versions
            $stash = git -C $repoPath stash list
            $remote = git -C $repoPath remote get-url origin 2>$null
            [PSCustomObject]@{
                Repository = $repoPath
                Branch     = ($status | Select-String -Pattern '^##' | ForEach-Object { $_.ToString().Trim() }) -replace '^##\s*', ''
                Untracked  = ($status | Where-Object { $_ -match '^\?\?' })
                Modified   = ($status | Where-Object { $_ -match '^[ M]' })
                Added      = ($status | Where-Object { $_ -match '^[A]' })
                Deleted    = ($status | Where-Object { $_ -match '^[D]' })
                Stash      = $stash
                Remote     = $remote ? $remote : 'No remote'
            }
        } catch {
            Write-Warning "Failed to get Git status for $($GitDirectory.FullName): $_"
        }
    }

}

process {
    $gciParams = @{
        Path      = $RootDirectory.FullName
        Recurse   = $true
        Directory = $true
        Force     = $true
        Filter    = '.git'
    }

    $gitDirs = Get-ChildItem @gciParams
    
    foreach ($gitDir in $gitDirs) {
        $progressParams = @{
            Activity        = 'Scanning for Git repositories'
            Status          = "Processing $($gitDir.FullName)"
            PercentComplete = [math]::Round( ($gitDirectoryStatus.Count + 1) / ($gitDirs.Count ) * 100 )
        }
        Write-Progress @progressParams
        $gitDirectoryStatus += Get-GitStatus $gitDir.FullName
    }
}

end {
    if ($PassThru) {
        return $gitDirectoryStatus
        exit 0
    }
    $gitDirectoryStatus | ForEach-Object {
        [PSCustomObject]@{
            Repository = $_.Repository
            Clean      = ($_.Untracked.Count + $_.Modified.Count + $_.Added.Count + $_.Deleted.Count + $_.Stash.Count -eq 0)? "`e[32m✔`e[0m" : "`e[31m✘`e[0m" 
            Branch     = ($_.Branch -match '\[ahead \d+\]') ? "`e[31m$($_.Branch)`e[0m" : $_.Branch
            Untracked  = $_.Untracked.Count
            Modified   = $_.Modified.Count
            Added      = $_.Added.Count
            Deleted    = $_.Deleted.Count
            Stash      = $_.Stash.Count
            Remote     = ($_.Remote -eq 'No remote')? "`e[32m-`e[0m" : $_.Remote
        }
    } | Sort-Object -Property Repository | Format-Table -AutoSize    
}
