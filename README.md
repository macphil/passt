# passt

Proven applications, scripts, settings and tools

> **Note**
>
> **passt** means in german _fits_.

I collect here my proven applications, scripts, settings and tools, with which I have had good experiences in the past.
This is of course a purely subjective list and serves mainly as a notepad for me.

## Visual Studio Code

Open Source Sourcecode Editor runs on Windows and Mac
:link: https://code.visualstudio.com/

### Recommended Extensions

- [CodeSnap](https://marketplace.visualstudio.com/items?itemName=adpyke.codesnap)\
  📸 Take beautiful screenshots of your code in VS Code!

- [Edit csv](https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv)\
  This extensions allows you to edit csv files with an excel like table ui

- [Fix JSON](https://marketplace.visualstudio.com/items?itemName=oliversturm.fix-json)\
  `fix-json` uses [jsonic](https://github.com/rjrodger/jsonic) to parse json data in the current editor, then reformats the content using a simple `JSON.stringify` call.

- [FreeMind](https://marketplace.visualstudio.com/items?itemName=DaChuiOpenSource.FreeMind)\
  A mindmap extension for vscode that is easy to use, can be saved, and can be exported to images. Like xmind.

- [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)\
  View a Git Graph of your repository, and easily perform Git actions from the graph. Configurable to look the way you want!

- [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)
  We will enhance your VS Code as the slide deck writer. Mark `marp: true`, and write your deck!

- [Mime Tools](https://marketplace.visualstudio.com/items?itemName=ajogyashree.mimeconvertor)\
  Mime tools for Visual Studio Code. Inspired from Notepad++'s mime tools. Convert to multiple formats

- [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)

- [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

- [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)\
  REST Client allows you to send HTTP request and view the response in Visual Studio Code directly.

- [C# Dev Kit](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit)\
  C# Dev Kit for Visual Studio Code. For an short german introduction, see [C# Entwicklung auf einem mac](wiki.C-sharp-development-on-mac.DE.md).

- [Sort lines](https://marketplace.visualstudio.com/items?itemName=Tyriar.sort-lines)

- [unicode-Substitutions](https://marketplace.visualstudio.com/items?itemName=GlenBuktenica.unicode-substitutions)

- [XML Tools](https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml)

- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)

- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

- [GitHub Markdown Preview](https://marketplace.visualstudio.com/items?itemName=bierner.github-markdown-preview)

- [German - Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-german)

## Windows terminal

:link: [microsoft/terminal: The new Windows Terminal and the original Windows console host, all in the same place! (github.com)](https://github.com/microsoft/terminal)

### Settings

:construction:

### Oh My Posh

[Introduction | Oh My Posh](https://ohmyposh.dev/docs/)

`❯ code $profile` will open the powershell profile file

```powershell
oh-my-posh init pwsh --config C:\git\github\macphil\passt\macphil.omp.json | Invoke-Expression
```

## other tools without further plugins _no strings attached_

Prefer installing it via `choco install <name>`

- [Typora — a markdown editor, markdown reader.](https://typora.io/)

- [TreeSize Free | JAM Software (jam-software.com)](https://www.jam-software.com/treesize_free)

## ssh & co
generate new keypair:
```bash
ssh-keygen -f ~/.ssh/<nickame>.ed25519 -t ed25519 -C <comment>
```
copy public key to `authorized_keys` at nickname:
```
ssh-copy-id -i ~/.ssh/<nickame>.ed25519 user@fqdn.foo.bar.com
```

if ssh-copy-id is not available, copy the content of the **`*.pub`** file into the `.ssh/authorized_keys` file at nickname
```powershell
Get-Content ~/.ssh/<nickame>.ed25519.pub | clip
```

test connection:
```bash
ssh -t git@fqdn.foo.bar.com -p 3456 -i <nickname>.ed25519
```
 something like `shell request failed on channel 0` indicates success

`.ssh/config`:
```txt
Host <nickame>
HostName fqdn.foo.bar.com
Port 3456
User username
IdentityFile  ~/.ssh/<nickame>.ed25519
```

links: 
- <https://www.ssh.com/academy/ssh/keygen>
- <https://www.ssh.com/academy/ssh/copy-id>
- <https://www.ssh.com/academy/ssh/config#listing-of-client-configuration-options>

