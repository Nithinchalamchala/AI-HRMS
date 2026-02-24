import { useQuery } from '@tanstack/react-query';
import api from '../lib/api';
import { Users, CheckSquare, TrendingUp, Activity } from 'lucide-react';

export function DashboardPage() {
  const { data: metrics, isLoading } = useQuery({
    queryKey: ['dashboard-metrics'],
    queryFn: async () => {
      const response = await api.get('/dashboard/metrics');
      return response.data.metrics;
    },
  });

  if (isLoading) {
    return <div className="text-center py-12">Loading dashboard...</div>;
  }

  const cards = [
    {
      title: 'Total Employees',
      value: metrics?.totalEmployees || 0,
      icon: Users,
      color: 'bg-blue-500',
    },
    {
      title: 'Active Employees',
      value: metrics?.activeEmployees || 0,
      icon: Activity,
      color: 'bg-green-500',
    },
    {
      title: 'Assigned Tasks',
      value: metrics?.assignedTasks || 0,
      icon: CheckSquare,
      color: 'bg-yellow-500',
    },
    {
      title: 'Completed Tasks',
      value: metrics?.completedTasks || 0,
      icon: TrendingUp,
      color: 'bg-purple-500',
    },
  ];

  return (
    <div>
      <h1 className="text-3xl font-bold text-gray-900 mb-8">Dashboard</h1>

      {/* Metrics Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        {cards.map((card) => {
          const Icon = card.icon;
          return (
            <div key={card.title} className="bg-white rounded-lg shadow p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600 mb-1">{card.title}</p>
                  <p className="text-3xl font-bold text-gray-900">{card.value}</p>
                </div>
                <div className={`${card.color} p-3 rounded-lg`}>
                  <Icon className="text-white" size={24} />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Productivity Indicators */}
      {metrics?.productivityIndicators && (
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-xl font-bold text-gray-900 mb-4">Productivity Indicators</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <p className="text-sm text-gray-600 mb-1">Completion Rate</p>
              <p className="text-2xl font-bold text-gray-900">
                {metrics.productivityIndicators.averageCompletionRate.toFixed(1)}%
              </p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Avg Productivity Score</p>
              <p className="text-2xl font-bold text-gray-900">
                {metrics.productivityIndicators.averageProductivityScore || 'N/A'}
              </p>
            </div>
            <div>
              <p className="text-sm text-gray-600 mb-1">Tasks This Week</p>
              <p className="text-2xl font-bold text-gray-900">
                {metrics.productivityIndicators.tasksCompletedThisWeek}
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
