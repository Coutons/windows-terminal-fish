# ──────────────────────────────────────────────────────────
#  fish-like PowerShell profile
#  Part of: terminal-setup
#  Edit config.ps1 to customize, not this file directly.
# ──────────────────────────────────────────────────────────

# ── Fastfetch (system info) ───────────────────────────────
$logoPath = "$env:USERPROFILE\.config\fastfetch\dragon.txt"
$smallLogo = "$env:USERPROFILE\.config\fastfetch\small.txt"
if (Test-Path $logoPath) {
    fastfetch --file-raw $logoPath
} elseif (Test-Path $smallLogo) {
    fastfetch --file-raw $smallLogo
} else {
    fastfetch
}

# ── PSReadLine (latest) ──────────────────────────────────
Import-Module PSReadLine -Force
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle Inline
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# ── oh-my-posh prompt ─────────────────────────────────────
$ompTheme = Get-ChildItem "$env:USERPROFILE\*.omp.json" | Select-Object -First 1
if ($ompTheme) {
    oh-my-posh init pwsh --config $ompTheme.FullName | Invoke-Expression
} else {
    oh-my-posh init pwsh | Invoke-Expression
}

# ── Aliases (fish-like) ──────────────────────────────────
Set-Alias ll    Get-ChildItem -Option AllScope
Set-Alias la    Get-ChildItem -Option AllScope -Force
Set-Alias grep  Select-String -Option AllScope
Set-Alias which Get-Command -Option AllScope
Set-Alias open  Invoke-Item -Option AllScope

function l     { Get-ChildItem -Name }
function touch { New-Item -ItemType File -Path $args -Force }
function ..    { Set-Location .. }
function ...   { Set-Location ..\.. }
function ....  { Set-Location ..\..\.. }

if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ll { eza -la --icons --group-directories-first }
    function la { eza -laa --icons --group-directories-first }
    function l  { eza --icons --group-directories-first }
    function lt { eza -la --icons --group-directories-first --tree }
} elseif (Get-Command lsd -ErrorAction SilentlyContinue) {
    function ll { lsd -la }
    function la { lsd -la }
    function l  { lsd }
}

# ── Zoxide (smart cd) ─────────────────────────────────────
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# ── Npm global path ──────────────────────────────────────
if (Get-Command npm -ErrorAction SilentlyContinue) {
    $npmGlobal = npm prefix -g 2>$null
    if ($npmGlobal -and (Test-Path $npmGlobal)) {
        $env:Path = "$npmGlobal;$(npm root -g 2>$null);$env:Path"
    }
}

# ── Utils ─────────────────────────────────────────────────
function df       { Get-PSDrive -PSProvider FileSystem }
function psaux    { Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 }
function find     { Get-ChildItem -Recurse -Filter $args[0] -ErrorAction SilentlyContinue }
function mkdir    { New-Item -ItemType Directory -Path $args -Force }
function reload   { . $PROFILE }
function edit     { notepad $PROFILE }

# ── Title (shows current dir) ─────────────────────────────
$Host.UI.RawUI.WindowTitle = "PowerShell — $(Get-Location)"
