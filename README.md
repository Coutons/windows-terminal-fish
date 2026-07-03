# 🐟 Windows Terminal Fish — PowerShell Edition

> **One-command setup** for a beautiful, fish-like PowerShell terminal on Windows.
> oh-my-posh + Catppuccin Mocha + Nerd Font + Modern CLI tools.

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"></a>
  <a href="https://github.com/PowerShell/PowerShell"><img src="https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white" alt="PowerShell"></a>
  <a href="https://www.microsoft.com/windows"><img src="https://img.shields.io/badge/Windows-10%2F11-0078D6?logo=windows&logoColor=white" alt="Windows"></a>
  <a href="https://ohmyposh.dev"><img src="https://img.shields.io/badge/oh--my--posh-29.18%2B-FF6B6B" alt="oh-my-posh"></a>
  <a href="https://github.com/Coutons/windows-terminal-fish"><img src="https://img.shields.io/github/stars/Coutons/windows-terminal-fish?style=flat&logo=github" alt="GitHub Stars"></a>
  <a href="https://github.com/Coutons/windows-terminal-fish/issues"><img src="https://img.shields.io/github/issues/Coutons/windows-terminal-fish" alt="Issues"></a>
  <a href="https://github.com/Coutons/windows-terminal-fish/actions"><img src="https://img.shields.io/badge/status-ready-success" alt="PRs Welcome"></a>
</p>

## ✨ Features

| Feature | Description |
|---|---|
| **Fish-like prompt** | oh-my-posh with user, path, git, exec time segments |
| **Syntax highlighting** | PSReadLine inline predictions as you type |
| **History autosuggestions** | Arrow up/down to recall previous commands (like fish) |
| **Nerd Font icons** | Beautiful icons in prompt and file listings |
| **Catppuccin Mocha** | Soft aesthetic color scheme (dark purple-pink) |
| **Modern CLI tools** | zoxide, bat, fd, fzf, gsudo — installed automatically |
| **Dragon ASCII logo** | Custom fastfetch system info with dragon art |
| **Acrylic transparency** | 85% translucent terminal background |
| **Smart cd** | `z folder` jumps to any directory (like fish's autojump) |
| **Fish-like aliases** | `ll`, `la`, `grep`, `find`, `touch`, `which`, `open` |
| **One-command setup** | Run once — repeatable & idempotent |

## 📸 Preview

> **Tip:** Open [`preview.html`](preview.html) in a browser to see a rendered demo.
> To add real screenshots, take a screenshot of your terminal and save as `screenshot-1.png`, `screenshot-1.png`, `screenshot-3.png` in the repo root, then uncomment the images below.

<!-- Uncomment these lines after adding screenshot images:
<p align="center">
  <img src="screenshot-1.png" alt="Terminal with dragon logo and system info" width="80%">
  <br><em>Demo 1: System info with dragon ASCII art</em>
</p>

<p align="center">
  <img src="screenshot-2.png" alt="Fish-like prompt with git status" width="80%">
  <br><em>Demo 2: oh-my-posh fish-like prompt with git branch</em>
</p>

<p align="center">
  <img src="screenshot-3.png" alt="CLI tools in action: bat, fd, fzf" width="80%">
  <br><em>Demo 3: Modern CLI tools — bat, fd, and fzf</em>
</p>
-->

### ASCII preview

```
                   __====-_  _-====___                    user@DESKTOP
          _--^^^#####//      \\#####^^^--_                ─────────────────
       _-^##########// (    ) \\##########^-_             OS  → Windows 11
      -############//  |\^^/|  \\############-            Host → B450M Steel Legend
    _/############//   (@::@)   \\############\_          Kernel → 10.0.26200
   /#############((     \\//     ))#############\         Uptime → 2 days, 9 hours
  -###############\\    (oo)    //###############-        CPU   → AMD Ryzen 5 5600G
 -#################\\  / UUU \  //#################-      GPU   → Radeon Graphics
 -###################\/  (_)  \/###################-      Mem   → 6 GiB / 16 GiB
 #/|##########/\#####(   "/")#####/\##########|\#         Disk  → 68 GiB / 93 GiB
 |/ |#/\#/\#/\/  \#/\##\  ! ' !  /##/\#/  \/\#/\#\|
 ||/  V  V '   '   V  \#\_____/##/  V   '   '  V   \||   jainu in ~/projects
 || \  \  |  |  |  |  |  |  |  |  |  |  |  |  /  / ||    🐍 3.12.0  main ≡ 
 ||  \ | | |  |  |  |  |  |  |  |  |  |  |  | | /  ||    $ ▊
 ```

## 🚀 Quick start

```powershell
# 1. Clone or download this repo
git clone https://github.com/Coutons/windows-terminal-fish.git
cd windows-terminal-fish

# 2. Customize (optional)
notepad config.ps1

# 3. Run setup (as Administrator)
.\setup.ps1

# 4. Import Windows Terminal settings
#    Settings → Open JSON file → paste contents of terminal-settings.json
```

### What gets installed

| Component | Why |
|---|---|
| **oh-my-posh** | Fish-like prompt segments |
| **CaskaydiaCove Nerd Font** | Icons in prompt & terminal |
| **PSReadLine 2.4+** | Inline history + syntax highlighting |
| **PowerShell 7** | Modern PowerShell (optional) |
| **zoxide** | `z folder` — smart directory jumper |
| **bat** | `cat` with syntax highlighting + git gutter |
| **fd** | `find` replacement — fast and intuitive |
| **fzf** | Fuzzy finder — Ctrl+R history, Ctrl+T files |
| **gsudo** | `sudo` for Windows — elevate without new window |

## ⚙️ Customization

Edit **`config.ps1`** before running setup.ps1:

```powershell
# Pick a theme: https://ohmyposh.dev/docs/themes
$OhMyPoshTheme = "powerlevel10k_rainbow"

# Pick a font
$NerdFont = "FiraCode"

# Toggle tools
$InstallExtraTools = @{
    zoxide = $true
    bat    = $true
    fd     = $false     # skip fd
    fzf    = $true
    gsudo  = $false
}
```

### CLI parameters

```powershell
.\setup.ps1 -Theme powerlevel10k_rainbow -NoTools
.\setup.ps1 -NoFont -NoProfile       # only tools
.\setup.ps1 -NoTools -NoFont         # only profile + theme
```

## 📁 Project structure

```
windows-terminal-fish/
├── setup.ps1                         # → Bootstrap installer
├── uninstall.ps1                     # → Cleanup everything
├── config.ps1                        # → User settings (edit this!)
├── terminal-settings.json            # → Windows Terminal config
├── files/
│   ├── Microsoft.PowerShell_profile.ps1  # → PowerShell profile
│   └── *.omp.json                        # → oh-my-posh themes
│   └── *.txt                             # → fastfetch logos
└── README.md
```

## 🔧 Available key bindings

| Key | Action |
|---|---|
| `↑` / `↓` | History search (fish-like partial match) |
| `Tab` | Complete command/argument |
| `Ctrl+R` | Fuzzy history search (if fzf installed) |
| `Ctrl+T` | Fuzzy file search (if fzf installed) |
| `Alt+D` | Duplicate pane (Windows Terminal) |
| `Ctrl+Shift+F` | Find in terminal |

## 🗑️ Uninstall

```powershell
.\uninstall.ps1          # remove everything
.\uninstall.ps1 -KeepProfile   # keep profile, remove tools
.\uninstall.ps1 -KeepTools     # keep tools, remove profile
```

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Coutons/windows-terminal-fish&type=Date)](https://star-history.com/#Coutons/windows-terminal-fish&Date)

## 🤝 Contributing

PRs welcome! Ideas for improvement:
- Add more theme presets
- Multi-profile support (Admin vs normal)
- Linux/macOS variant
- PowerShell module auto-install (posh-git, etc.)

## 📜 License

MIT
