## tags

### list version tags with date



```
❯ git tag -l v13* --format='%(creatordate:short)%09%(refname:strip=2)' 2022-03-11      v13.0.0 2022-06-03      v13.0.1 2022-06-07      v13.0.2 2022-06-30      v13.1.0 2022-06-20      v13.1.0-rc-1 2022-06-22      v13.1.0-rc2
```



**Naming Rule**

Tags for versions MUST start with an `v` 

### how-to determinate, which tags contains an commit?



```
❯ git tag --contains 7f40bceb1f09bf2da2131e40b6efc9d4a0ff6cce v11.5.2.1 v11.5.3 v11.5.eol
```

### how-to determinate, which commit was the last in an deleted folder?



```
❯ git log --pretty=oneline --full-history --all -- "Customers/TUI (41905)"
```

### how-to determinate, which files was changed?

**revision-range: mind the dots!**
The character between two revisions has different meanings:

```
❯ git log foo bar
```

Shows all commits which are **in** *foo* **or** *bar*

```
❯ git log foo...bar
```

Shows all commits **between** *foo* (exclusive) and *bar* (inclusive)

```
❯ git log foo..bar
```

(I have no clue - but it may have an different result)

see [Git - git-log Documentation (git-scm.com)](https://git-scm.com/docs/git-log)


In  combination with PowerShell a query could look as follows:



```
git whatchanged --format=oneline --name-only --no-commit-id origin/master...origin/release/13.2.0 | Sort-Object -Unique | Where-Object {$_ -notlike "*.cs"}
```



```
❯ git whatchanged --format=oneline --name-only --no-commit-id v13.1.0... .\DatabaseInstaller\**\*.md | Sort-Object -Unique DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md DatabaseInstaller/DatabaseScripts/Debitex/DatabaseViews.md
```

### how-to show, what was changed in a file?



```
❯ git diff -U0 v13.1.0... DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md diff --git a/DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md b/DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md index 1d1def0594..59bdf70171 100644 --- a/DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md +++ b/DatabaseInstaller/DatabaseScripts/Debitex/DatabaseScripts.md @@ -1 +1,2 @@ -# DBI-Änderung mit FP10 +# DBI change with FP10 +Starting with FP10, database changes are maintained in individual files below the Database Installer. […]
```

### show the content of an file at an given version



```
❯ git show origin/support/11.11:AssemblyVersionInfo.cs […] [assembly: AssemblyVersion("11.11.5.0")] […]
```



the revision could be a commit-id or everything else what point to an commit-id (branch, tags, relative pointing's…)

- `❯ git show HEAD:AssemblyVersionInfo.cs` → 13.2.0
- `❯ git show HEAD^1:AssemblyVersionInfo.cs` → 13.1.0
- `❯ git show v13.0.2:AssemblyVersionInfo.cs` → 13.0.2
- `❯ git show origin/support/12.5:AssemblyVersionInfo.cs` → 12.5.0
