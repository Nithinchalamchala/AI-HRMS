# 🚀 Quick Deployment Checklist

Use this checklist while following the detailed guide in `VERCEL_RENDER_DEPLOYMENT.md`

## ✅ Pre-Deployment (5 minutes)

- [ ] Code is pushed to GitHub
- [ ] You have accounts on:
  - [ ] GitHub
  - [ ] Render.com
  - [ ] Vercel.com
- [ ] Generate JWT secrets:
  ```bash
  openssl rand -base64 32  # For JWT_SECRET
  openssl rand -base64 32  # For JWT_REFRESH_SECRET
  ```

## 🗄️ Backend on Render (15 minutes)

### Database Setup
- [ ] Create PostgreSQL database on Render
- [ ] Copy Internal Database URL
- [ ] Database is in same region as web service

### Web Service Setup
- [ ] Create Web Service from GitHub repo
- [ ] Configure build settings:
  - Root Directory: `backend`
  - Build Command: `./render-build.sh`
  - Start Command: `npm start`
- [ ] Add environment variables:
  - [ ] `NODE_ENV=production`
  - [ ] `PORT=3000`
  - [ ] `DATABASE_URL=[from database]`
  - [ ] `JWT_SECRET=[generated]`
  - [ ] `JWT_REFRESH_SECRET=[generated]`
  - [ ] `CORS_ORIGIN=https://your-app.vercel.app` (update later)
- [ ] Deploy and wait for build
- [ ] Test health endpoint: `https://your-backend.onrender.com/api/health`

## 🎨 Frontend on Vercel (10 minutes)

- [ ] Import GitHub repository to Vercel
- [ ] Configure project:
  - Framework: `Vite`
  - Root Directory: `frontend`
  - Build Command: `npm run build`
  - Output Directory: `dist`
- [ ] Add environment variables:
  - [ ] `VITE_API_BASE_URL=https://your-backend.onrender.com/api`
  - [ ] `VITE_BLOCKCHAIN_NETWORK=polygon_mumbai`
- [ ] Deploy and wait for build
- [ ] Copy your Vercel URL

## 🔗 Connect Frontend & Backend (5 minutes)

- [ ] Go back to Render backend service
- [ ] Update `CORS_ORIGIN` with your Vercel URL
- [ ] Wait for automatic redeploy
- [ ] Test your app at Vercel URL
- [ ] Try login/register

## 🧪 Testing (10 minutes)

- [ ] Backend health check works
- [ ] Frontend loads without errors
- [ ] Can register new account
- [ ] Can login
- [ ] Can create employee
- [ ] Can create task
- [ ] Dashboard shows data
- [ ] No CORS errors in browser console

## 🎯 Optional Enhancements

- [ ] Seed demo data: Run `npm run seed:prod` in Render shell
- [ ] Set up custom domain on Vercel
- [ ] Set up custom domain on Render
- [ ] Enable Vercel Analytics
- [ ] Set up monitoring/alerts

## 📝 Save These URLs

```
Frontend: https://_____________________.vercel.app
Backend:  https://_____________________.onrender.com
Database: postgresql://_____________________.render.com:5432/_____
```

## 🆘 Common Issues

**Backend won't start?**
- Check Render logs for errors
- Verify DATABASE_URL is correct
- Ensure migrations ran successfully

**Frontend can't connect to backend?**
- Check VITE_API_BASE_URL is correct
- Verify CORS_ORIGIN on backend includes Vercel URL
- Check browser console for errors

**Database connection fails?**
- Use Internal Database URL, not External
- Ensure database and web service in same region
- Check database is running in Render dashboard

**Render free tier sleeping?**
- First request takes 30-60 seconds (cold start)
- Consider upgrading to $7/month for always-on
- Or set up cron job to ping every 14 minutes

---

## 🎉 Success!

Once all checkboxes are complete, your app is live!

**Next Steps:**
1. Share your deployment URLs
2. Test all features thoroughly
3. Monitor logs for any issues
4. Consider upgrading to paid tiers for production use

**Need help?** Check `VERCEL_RENDER_DEPLOYMENT.md` for detailed instructions.
