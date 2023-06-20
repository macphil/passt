> **Warning**
>
> Good source to shoot oneself in the foot
 
 # Delete tags with `-` (usually pre-release-tags)

- local `❯ git tag -l | Select-String '-' | foreach { git tag --delete  $_}`
- remote: `❯ git tag -l | Select-String '-' | foreach { git push --delete origin $_}`

```bash
❯ git tag -l | Select-String '-' | foreach { git tag --delete  $_}
Deleted tag 'v0.2.0-alpha' (was 5ecbd7f)
Deleted tag 'v0.2.0-alpha.1' (was 514f2f4)
Deleted tag 'v0.2.0-alpha.10' (was b9a46b3)
Deleted tag 'v0.2.0-alpha.11' (was 683d4a9)
[…]

❯ git tag -l | Select-String '-' | foreach { git push --delete origin $_}
To https://github.com/shsviveon/proj1329677-ci-cake-frosting.git
 - [deleted]         v0.2.0-alpha
To https://github.com/shsviveon/proj1329677-ci-cake-frosting.git
 - [deleted]         v0.2.0-alpha.1
To https://github.com/shsviveon/proj1329677-ci-cake-frosting.git
 - [deleted]         v0.2.0-alpha.10
[…]
```
