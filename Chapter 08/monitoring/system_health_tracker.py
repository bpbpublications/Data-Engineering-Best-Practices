import psutil
import time
from datetime import datetime, timedelta
from dataclasses import dataclass
from typing import Dict, List

@dataclass
class HealthMetric:
    name: str
    current_value: float
    baseline_value: float
    trend_direction: str  # "improving", "stable", "degrading"
    severity: str  # "normal", "warning", "critical"

class SystemHealthTracker:
    def __init__(self):
        self.baseline_metrics = {}
        self.metric_history = []
        
    def collect_current_metrics(self) -> Dict[str, float]:
        """Collect current system performance metrics"""
        return {
            'cpu_percent': psutil.cpu_percent(interval=1),
            'memory_percent': psutil.virtual_memory().percent,
            'disk_usage_percent': psutil.disk_usage('/').used / psutil.disk_usage('/').total * 100
        }
    
    def analyze_health_trends(self) -> List[HealthMetric]:
        """Analyze trends and identify potential issues"""
        current_metrics = self.collect_current_metrics()
        health_analysis = []
        
        for metric_name, current_value in current_metrics.items():
            baseline = self.baseline_metrics.get(metric_name, current_value)
            trend = self._calculate_trend(metric_name)
            severity = self._assess_severity(metric_name, current_value, baseline)
            
            health_analysis.append(HealthMetric(
                name=metric_name,
                current_value=current_value,
                baseline_value=baseline,
                trend_direction=trend,
                severity=severity
            ))
        
        return health_analysis

class ProactiveMaintenanceEngine:
    def __init__(self):
        self.intervention_rules = self._load_intervention_rules()
        
    def evaluate_intervention_needs(self, health_metrics: List[HealthMetric]) -> List[str]:
        """Determine what maintenance actions should be taken"""
        recommended_actions = []
        
        for metric in health_metrics:
            if metric.severity == "warning" and metric.trend_direction == "degrading":
                action = self._get_preventive_action(metric.name)
                if action:
                    recommended_actions.append(action)
        
        return recommended_actions
    
    def _get_preventive_action(self, metric_name: str) -> str:
        """Map metrics to preventive actions"""
        action_mapping = {
            'cpu_percent': 'optimize_query_performance',
            'memory_percent': 'clear_unused_connections',
            'disk_usage_percent': 'cleanup_old_logs'
        }
        return action_mapping.get(metric_name)
