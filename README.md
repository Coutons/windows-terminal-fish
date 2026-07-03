# 🐟 Windows Terminal Fish — PowerShell Edition

> **One-command setup** for a beautiful, fish-like PowerShell terminal on Windows.
> oh-my-posh + Catppuccin Mocha + Nerd Font + Modern CLI tools.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)](https://github.com/PowerShell/PowerShell)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6)](https://www.microsoft.com/windows)

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
git clone https://github.com/YOUR_USERNAME/windows-terminal-fish.git
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

## 🤝 Contributing

PRs welcome! Ideas for improvement:
- Add more theme presets
- Multi-profile support (Admin vs normal)
- Linux/macOS variant
- PowerShell module auto-install (posh-git, etc.)

## 📜 License

MIT
