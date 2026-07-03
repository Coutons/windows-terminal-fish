#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Undo everything setup.ps1 did — remove tools, config, and profile changes.
#>

param(
    [switch]$KeepProfile,
    [switch]$KeepTools
)

$ErrorActionPreference = 'Stop'

function Write-Step($s) { Write-Host "`n==> $s" -ForegroundColor Cyan }
function Write-OK($s)   { Write-Host "  [+] $s" -ForegroundColor Green }
function Write-Warn($s) { Write-Host "  [!] $s" -ForegroundColor Yellow }

# ---- 1. Uninstall tools ----------------------------------------------------
if (-not $KeepTools) {
    Write-Step 'Removing installed tools'
    $packages = @(
        'JanDeDobbeleer.OhMyPosh'
        'ajeetdsouza.zoxide'
        'sharkdp.bat'
        'sharkdp.fd'
        'junegunn.fzf'
        'gerardog.gsudo'
    )
    foreach ($pkg in $packages) {
        Write-Host "    -> $pkg ..." -NoNewline
        winget uninstall $pkg --silent 2>&1 | Out-Null
        Write-Host " removed" -ForegroundColor Green
    }
} else {
    Write-Step 'Skipping tool removal'
}

# ---- 2. Remove config files ------------------------------------------------
Write-Step 'Removing config files'
$files = @(
    $PROFILE
    (Join-Path $env:USERPROFILE '.jandedobbeleer.omp.json')
    (Join-Path $env:USERPROFILE '.config\fastfetch\dragon.txt')
    (Join-Path $env:USERPROFILE '.config\fastfetch')
)
foreach ($f in $files) {
    if (Test-Path $f) {
        Remove-Item $f -Recurse -Force
        Write-OK "Removed: $f"
    }
}

# ---- 3. Reset profile ------------------------------------------------------
if (-not $KeepProfile) {
    Write-Step 'Resetting PowerShell profile to default'
    if (Test-Path $PROFILE) {
        Set-Content -Path $PROFILE -Value "# Cleaned by uninstall.ps1"
        Write-OK "Profile reset to empty"
    }
}

# ---- 4. Instructions -------------------------------------------------------
Write-Step 'Uninstall complete!'

Write-Host @"

  ───  Manual steps remaining  ────────────────────────────

  1. Open Windows Terminal → Settings → Profiles → Windows PowerShell
     - Reset font to Consolas (default)
     - Remove catppuccin-mocha color scheme if desired

  2. To reset PSReadLine:
       Uninstall-Module PSReadLine -AllVersions -Force
       Install-Module PSReadLine -Force

  3. To remove Nerd Font:
       Open Settings → Personalization → Fonts
       Delete "CaskaydiaCove Nerd Font"
"@
