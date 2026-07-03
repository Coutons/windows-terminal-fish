# ──────────────────────────────────────────────────────────
#  terminal-setup — User Configuration
#  Edit this file BEFORE running setup.ps1 to customize
#  your terminal experience.
# ──────────────────────────────────────────────────────────

# ── Shell ─────────────────────────────────────────────────
# Set to $true to install PowerShell 7 alongside 5.1
$InstallPowerShell7 = $true

# ── Prompt (oh-my-posh) ──────────────────────────────────
# Theme name or path to .omp.json file.
# Built-in: jandedobbeleer (default)
# Popular: powerlevel10k_rainbow, blue-owl, agnoster, amro
# Full list: https://ohmyposh.dev/docs/themes
$OhMyPoshTheme = "jandedobbeleer"

# ── Font ──────────────────────────────────────────────────
# Nerd Font to install (used by prompt icons).
# Options: CascadiaCode, FiraCode, JetBrainsMono, Meslo, etc.
$NerdFont = "CascadiaCode"

# ── Fastfetch Logo ────────────────────────────────────────
# Set to "dragon", "small", "none", or path to custom .txt file
$FastfetchLogo = "dragon"

# ── Color Scheme (Windows Terminal) ───────────────────────
# Options: catppuccin-mocha, dracula, gruvbox-dark, tokyo-night
$ColorScheme = "catppuccin-mocha"

# ── Extra Tools (install via winget) ──────────────────────
# These add fish-like CLI tools to Windows
$InstallExtraTools = @{
    zoxide = $true   # smart cd (like fish's autojump)
    bat    = $true   # cat with syntax highlighting
    fd     = $true   # fast find replacement
    fzf    = $true   # fuzzy finder (Ctrl+R, Ctrl+T)
    gsudo  = $true   # sudo for Windows
}

# ── Profile Features ──────────────────────────────────────
# Toggle these PowerShell enhancements on/off
$Features = @{
    # Shell aliases (ll, la, grep, find, touch, which, open)
    Aliases            = $true
    # Zoxide integration (overrides cd)
    ZoxideIntegration  = $true
    # vi-mode key bindings (set to 'Insert' or 'Vi')
    EditMode           = "Insert"
    # Show git status in prompt (requires posh-git)
    GitPrompt          = $true
    # NPM package path helper
    NpmGlobalPath      = $true
}

# ── Window Settings (Windows Terminal) ────────────────────
# Terminal appearance preferences
$Terminal = @{
    FontSize         = 11
    AcrylicOpacity   = 0.85
    UseAcrylic       = $true
    CursorShape      = "bar"   # bar, underscore, filledBox, emptyBox, vintage
}
