from datetime import datetime, timedelta

def assess_queue(session=None):
    """Assess Airflow queue backlog during peak windows"""
    start = datetime.now() - timedelta(hours=6)
    queued = session.query(DagRun, TaskInstance) \
        .filter(DagRun.execution_date >= start,
                TaskInstance.state.in_(['queued', 'running'])).all()
    print(f"Queue size: {len(queued)}")
    for dag_run, task in queued:
        print(f"{dag_run.dag_id}.{task.task_id} [{task.state}]")

def set_priorities(session=None):
    """Prioritize critical workflows and pause lower-impact DAGs"""
    for dag_id in ['sap_order', 'stock_prediction']:
        dag = session.query(DagModel).filter_by(dag_id=dag_id).first()
        dag.priority_weight = 10
        session.commit()
    for dag_id in ['inventory_report']:
        dag = session.query(DagModel).filter_by(dag_id=dag_id).first()
        dag.is_paused = True
        session.commit()
