#!/bin/bash

echo "🔐 Generating JWT Secrets for Deployment"
echo "=========================================="
echo ""
echo "Copy these values to your Render environment variables:"
echo ""
echo "JWT_SECRET:"
openssl rand -base64 32
echo ""
echo "JWT_REFRESH_SECRET:"
openssl rand -base64 32
echo ""
echo "=========================================="
echo "✅ Secrets generated successfully!"
echo ""
echo "Next steps:"
echo "1. Copy these secrets"
echo "2. Add them to Render environment variables"
echo "3. Never commit these to git!"
