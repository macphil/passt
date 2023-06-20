# Snippets

## Show default environment variables

### bash:



```yaml
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Show default environment variables (bash)
        run: |
          printenv | grep GITHUB_ | sort
      - name: Show default environment variables (powershell)
        shell: pwsh
        run: |
          Get-Childitem -path env: | Where-Object Name -match "GITHUB_" | Ft -autosize -wrap
```

 

