# 🚀 Deployment Quick Reference Card

## 📦 What You Need

1. **Accounts** (all free):
   - GitHub account
   - Render.com account
   - Vercel.com account

2. **JWT Secrets** (generate these):
   ```bash
   openssl rand -base64 32  # JWT_SECRET
   openssl rand -base64 32  # JWT_REFRESH_SECRET
   ```

---

## 🗄️ Render Backend (15 min)

### Step 1: Create PostgreSQL Database
1. Render Dashboard → New + → PostgreSQL
2. Name: `ai-hrms-db`
3. Region: Oregon (or closest)
4. Plan: Free
5. **Copy Internal Database URL** ⭐

### Step 2: Create Web Service
1. Render Dashboard → New + → Web Service
2. Connect GitHub repo
3. Settings:
   ```
   Name: ai-hrms-backend
   Root Directory: backend
   Build Command: ./render-build.sh
   Start Command: npm start
   ```

4. Environment Variables:
   ```
   NODE_ENV=production
   PORT=3000
   DATABASE_URL=[paste from Step 1]
   JWT_SECRET=[generated secret]
   JWT_REFRESH_SECRET=[generated secret]
   CORS_ORIGIN=https://your-app.vercel.app
   ```

5. Deploy → Wait 5-10 min

6. Test: `https://your-backend.onrender.com/api/health`

---

## 🎨 Vercel Frontend (10 min)

### Step 1: Import Project
1. Vercel Dashboard → Add New → Project
2. Import from GitHub
3. Settings:
   ```
   Framework: Vite
   Root Directory: frontend
   Build Command: npm run build
   Output Directory: dist
   ```

### Step 2: Environment Variables
```
VITE_API_BASE_URL=https://your-backend.onrender.com/api
VITE_BLOCKCHAIN_NETWORK=polygon_mumbai
```

### Step 3: Deploy
1. Click Deploy
2. Wait 2-3 min
3. **Copy your Vercel URL** ⭐

---

## 🔗 Connect Them (5 min)

1. Go back to Render backend
2. Update environment variable:
   ```
   CORS_ORIGIN=https://your-actual-vercel-url.vercel.app
   ```
3. Save (auto-redeploys)
4. Test your app!

---

## ✅ Quick Test

1. Open your Vercel URL
2. Register new account
3. Create an employee
4. Create a task
5. Check dashboard

**No errors?** You're live! 🎉

---

## 🆘 Troubleshooting

**CORS Error?**
→ Update CORS_ORIGIN on Render with exact Vercel URL

**Backend not responding?**
→ Check Render logs, verify DATABASE_URL

**Frontend blank page?**
→ Check browser console, verify VITE_API_BASE_URL

**Render sleeping?**
→ Normal for free tier, first request takes 30-60s

---

## 💰 Costs

**Free Tier** (perfect for demo):
- Render DB: Free
- Render Web: Free (sleeps after 15 min)
- Vercel: Free
- **Total: $0/month**

**Production** (recommended):
- Render DB: $7/month
- Render Web: $7/month (always-on)
- Vercel Pro: $20/month
- **Total: $34/month**

---

## 📝 Save Your URLs

```
Frontend: https://_________________.vercel.app
Backend:  https://_________________.onrender.com
```

---

## 📚 Full Guides

- **Detailed Guide**: `VERCEL_RENDER_DEPLOYMENT.md`
- **Checklist**: `DEPLOYMENT_CHECKLIST.md`
- **Troubleshooting**: See detailed guide

---

**Need help?** Check the full deployment guide for step-by-step instructions with screenshots!
