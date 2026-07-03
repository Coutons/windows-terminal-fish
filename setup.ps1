#!/usr/bin/env pwsh
<#
.SYNOPSIS
  One-command Windows terminal bootstrap — fish-like PowerShell with
  oh-my-posh, Nerd Font, Catppuccin, and modern CLI tools.

.DESCRIPTION
  Idempotent setup script. Edit config.ps1 first to customize, then
  run this script. Safe to run multiple times.

.PARAMETER NoTools
  Skip installing extra CLI tools (zoxide, bat, fd, fzf, gsudo).

.PARAMETER NoFont
  Skip Nerd Font installation.

.PARAMETER NoProfile
  Skip overwriting the PowerShell profile.

.PARAMETER Theme
  oh-my-posh theme name to use (overrides config.ps1).

.PARAMETER Config
  Path to config file (default: ./config.ps1).

.EXAMPLE
  .\setup.ps1                         # full setup with defaults
  .\setup.ps1 -Theme powerlevel10k_rainbow -NoTools
  .\setup.ps1 -NoFont -NoProfile      # only tools
#>

[CmdletBinding()]
param(
    [switch]$NoTools,
    [switch]$NoFont,
    [switch]$NoProfile,
    [string]$Theme,
    [string]$Config = "$PSScriptRoot\config.ps1"
)

$ErrorActionPreference = 'Stop'

# ---- helpers ---------------------------------------------------------------
function Write-Step($s)  { Write-Host "`n==> $s" -ForegroundColor Cyan }
function Write-OK($s)   { Write-Host "  [+] $s" -ForegroundColor Green }
function Write-Warn($s) { Write-Host "  [!] $s" -ForegroundColor Yellow }

# ---- load config -----------------------------------------------------------
$cfg = @{}
if (Test-Path $Config) {
    . $Config
    $cfg = @{
        InstallPowerShell7 = $InstallPowerShell7
        OhMyPoshTheme      = $OhMyPoshTheme
        NerdFont           = $NerdFont
        FastfetchLogo      = $FastfetchLogo
        ColorScheme        = $ColorScheme
        InstallExtraTools  = $InstallExtraTools
        Features           = $Features
        Terminal           = $Terminal
    }
} else {
    Write-Warn "config.ps1 not found at $Config — using defaults"
}

# override theme via CLI
if ($Theme) { $cfg.OhMyPoshTheme = $Theme }

# ---- paths -----------------------------------------------------------------
$scriptRoot  = Split-Path -Parent $PSCommandPath
$filesDir    = Join-Path $scriptRoot 'files'
$profileDest = $PROFILE
$themeName   = $cfg.OhMyPoshTheme
$themeDest   = Join-Path $env:USERPROFILE ".$themeName.omp.json"
$dragonDest  = Join-Path $env:USERPROFILE '.config\fastfetch\dragon.txt'

# make sure files dir exists
if (!(Test-Path $filesDir)) { New-Item -ItemType Directory -Path $filesDir -Force > $null }

# ============================================================================
#  1. oh-my-posh
# ============================================================================
Write-Step '1/6  Installing oh-my-posh'
winget install JanDeDobbeleer.OhMyPosh -e --source winget --accept-package-agreements 2>&1 | Out-Null
Write-OK 'oh-my-posh installed'

# ============================================================================
#  2. Nerd Font
# ============================================================================
if (-not $NoFont) {
    Write-Step "2/6  Installing $($cfg.NerdFont) Nerd Font"
    oh-my-posh font install $cfg.NerdFont --headless 2>&1 | Out-Null
    Write-OK "$($cfg.NerdFont) Nerd Font installed"
} else { Write-Step '2/6  Skipping font install' }

# ============================================================================
#  3. PSReadLine
# ============================================================================
Write-Step '3/6  Upgrading PSReadLine'
Install-PackageProvider NuGet -Force -Scope CurrentUser 2>&1 | Out-Null
Install-Module PSReadLine -Force -SkipPublisherCheck -Scope CurrentUser -AllowClobber 2>&1 | Out-Null
$prlVer = (Get-Module PSReadLine -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1).Version
Write-OK "PSReadLine $prlVer"

# ============================================================================
#  4. Theme, Profile & Logo
# ============================================================================
Write-Step '4/6  Deploying configuration files'

# download theme if it doesn't exist locally
$themeLocal = Join-Path $filesDir "$themeName.omp.json"
if (-not (Test-Path $themeLocal)) {
    Write-Warn "Theme '$themeName' not found in files/ — downloading from oh-my-posh repo"
    $url = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/$themeName.omp.json"
    try {
        Invoke-WebRequest -Uri $url -OutFile $themeLocal -UseBasicParsing
        Write-OK "Downloaded theme '$themeName'"
    } catch {
        Write-Warn "Failed to download theme, falling back to jandedobbeleer"
        $themeLocal = Join-Path $filesDir 'jandedobbeleer.omp.json'
        if (!(Test-Path $themeLocal)) {
            # download the default
            Invoke-WebRequest -Uri "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json" -OutFile $themeLocal -UseBasicParsing
        }
    }
}
Copy-Item $themeLocal $themeDest -Force
Write-OK "Theme -> $themeDest"

# profile
if (-not $NoProfile) {
    $profileTemplate = Join-Path $filesDir 'Microsoft.PowerShell_profile.ps1'
    if (Test-Path $profileTemplate) {
        Copy-Item $profileTemplate $profileDest -Force
        Write-OK "Profile -> $profileDest"
    }
}

# fastfetch logo
$logoType = $cfg.FastfetchLogo
if ($logoType -and $logoType -ne 'none') {
    if ($logoType -eq 'dragon') {
        $logoFile = Join-Path $filesDir 'dragon.txt'
        if (Test-Path $logoFile) {
            $dragonDir = Split-Path $dragonDest -Parent
            if (!(Test-Path $dragonDir)) { New-Item -ItemType Directory -Path $dragonDir -Force > $null }
            Copy-Item $logoFile $dragonDest -Force
            Write-OK "Logo -> $dragonDest"
        }
    } elseif (Test-Path $logoType) {
        # custom path
        $logoDest = Join-Path $env:USERPROFILE '.config\fastfetch\custom.txt'
        $logoDir = Split-Path $logoDest -Parent
        if (!(Test-Path $logoDir)) { New-Item -ItemType Directory -Path $logoDir -Force > $null }
        Copy-Item $logoType $logoDest -Force
        Write-OK "Custom logo -> $logoDest"
    }
}

# ============================================================================
#  5. Extra CLI Tools
# ============================================================================
if (-not $NoTools) {
    Write-Step '5/6  Installing extra CLI tools'
    $tools = $cfg.InstallExtraTools
    $toolIds = @{
        zoxide = 'ajeetdsouza.zoxide'
        bat    = 'sharkdp.bat'
        fd     = 'sharkdp.fd'
        fzf    = 'junegunn.fzf'
        gsudo  = 'gerardog.gsudo'
    }
    foreach ($name in $tools.Keys) {
        if ($tools[$name] -and $toolIds.ContainsKey($name)) {
            Write-Host "    -> $name ..." -NoNewline
            winget install $toolIds[$name] -e --silent --accept-package-agreements 2>&1 | Out-Null
            Write-Host " OK" -ForegroundColor Green
        }
    }
} else { Write-Step '5/6  Skipping extra tools' }

# ============================================================================
#  6. Optional: PowerShell 7
# ============================================================================
Write-Step '6/6  Finalizing'
if ($cfg.InstallPowerShell7) {
    try {
        $pwshPath = Get-Command pwsh -ErrorAction SilentlyContinue
        if (-not $pwshPath) {
            Write-Host "    -> Installing PowerShell 7 ..." -NoNewline
            winget install Microsoft.PowerShell -e --silent --accept-package-agreements 2>&1 | Out-Null
            Write-Host " OK" -ForegroundColor Green
        } else { Write-OK 'PowerShell 7 already installed' }
    } catch { Write-Warn 'Could not install PowerShell 7' }
}

# ============================================================================
#  Done
# ============================================================================
Write-Step 'Setup complete!'

Write-Host @"

  ───  What's next?  ───────────────────────────────────────

  1. Windows Terminal → Settings → Import terminal-settings.json
     (or manually set font & color scheme — see README)

  2. Reload profile:  . `$PROFILE

  3. If you installed extra tools, restart terminal to use:
       zoxide  → smart cd (z foo, zi foo)
       bat     → cat with syntax highlighting
       fd      → fast find
       fzf     → Ctrl+R history, Ctrl+T files
       gsudo   → sudo for Windows

  4. Run  .\uninstall.ps1  to undo everything.
  ────────────────────────────────────────────────────────
"@
