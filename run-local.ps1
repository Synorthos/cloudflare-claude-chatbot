# ============================================================
# Chatbot - local test server (Windows)
#
# 1. Paste your keys between the quotes below.
# 2. Run it:  powershell -ExecutionPolicy Bypass -File .\run-local.ps1
# 3. Open http://127.0.0.1:8788 and chat. Ctrl+C to stop.
#
# SECURITY: NEVER commit this file with real keys in it. For the
# live site, keys are entered in the Cloudflare dashboard as
# secrets (README.md, step 4) - not in any file.
#
# Mac/Linux equivalent:
#   ANTHROPIC_API_KEY=sk-ant-... npx wrangler@latest pages dev . \
#     --kv RATE_LIMIT --port 8788 --binding ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY
# ============================================================

$ANTHROPIC_API_KEY    = ""   # REQUIRED for real replies (sk-ant-api03-...)
$RESEND_API_KEY       = ""   # optional - enables lead emails (re_...)
$LEAD_TO_EMAIL        = ""   # optional - defaults to CONTACT_EMAIL in _worker.js
$FROM_EMAIL           = ""   # optional - defaults to onboarding@resend.dev
$TURNSTILE_SECRET_KEY = ""   # optional - leave empty for local testing

# ------------------------------------------------------------

$bindings = @()
if ($ANTHROPIC_API_KEY) {
    $bindings += @("--binding", "ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY")
} else {
    Write-Warning "ANTHROPIC_API_KEY is empty - the bot will answer every message with its fallback error text."
}
if ($RESEND_API_KEY)       { $bindings += @("--binding", "RESEND_API_KEY=$RESEND_API_KEY") }
if ($LEAD_TO_EMAIL)        { $bindings += @("--binding", "LEAD_TO_EMAIL=$LEAD_TO_EMAIL") }
if ($FROM_EMAIL)           { $bindings += @("--binding", "FROM_EMAIL=$FROM_EMAIL") }
if ($TURNSTILE_SECRET_KEY) { $bindings += @("--binding", "TURNSTILE_SECRET_KEY=$TURNSTILE_SECRET_KEY") }

Set-Location $PSScriptRoot
Write-Host ""
Write-Host "Starting the chatbot locally at http://127.0.0.1:8788  (Ctrl+C to stop)" -ForegroundColor Green
Write-Host ""
npx --yes wrangler@latest pages dev . --kv RATE_LIMIT --port 8788 @bindings
