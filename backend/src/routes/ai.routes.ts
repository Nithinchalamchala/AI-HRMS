import { Router } from 'express';
import { AIController } from '../controllers/ai.controller';
import { authenticateToken } from '../middleware/auth.middleware';

const router = Router();

// All AI routes require authentication
router.use(authenticateToken);

router.get('/productivity/:employeeId', AIController.getProductivityScore);
router.post('/batch-calculate', AIController.batchCalculate);
router.get('/scores', AIController.getAllScores);

export default router;
