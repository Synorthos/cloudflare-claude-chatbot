# ============================================================
# Chatbot - local test server (Windows)
#
# 1. Copy .dev.vars.example to .dev.vars and paste your keys in there.
#    .dev.vars is gitignored, so your keys never enter git.
# 2. Run it:  powershell -ExecutionPolicy Bypass -File .\run-local.ps1
# 3. Open http://127.0.0.1:8788 and chat. Ctrl+C to stop.
#
# SECURITY: never put real keys in this file - it is tracked in git.
# Keys belong in .dev.vars locally, and in the Cloudflare dashboard as
# secrets for the live site (README.md, step 4).
#
# Mac/Linux equivalent (same .dev.vars file, loaded automatically):
#   npx wrangler@latest pages dev . --kv RATE_LIMIT --port 8788
# ============================================================

Set-Location $PSScriptRoot

if (-not (Test-Path ".dev.vars")) {
    Write-Warning "No .dev.vars found. Copy .dev.vars.example to .dev.vars and add your keys,"
    Write-Warning "or the bot will answer every message with its fallback error text."
} elseif (-not (Select-String -Path ".dev.vars" -Pattern "^\s*ANTHROPIC_API_KEY\s*=\s*\S" -Quiet)) {
    Write-Warning "ANTHROPIC_API_KEY is empty in .dev.vars - the bot will answer every message"
    Write-Warning "with its fallback error text."
}

Write-Host ""
Write-Host "Starting the chatbot locally at http://127.0.0.1:8788  (Ctrl+C to stop)" -ForegroundColor Green
Write-Host ""

# wrangler loads .dev.vars automatically - no keys are passed on the command line
# (they would otherwise land in shell history and the process list).
npx --yes wrangler@latest pages dev . --kv RATE_LIMIT --port 8788
