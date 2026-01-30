import numpy as np
from sklearn.ensemble import IsolationForest

# Anomaly Detection using Isolation Forest
# Fit model to reference values
clf = IsolationForest(contamination=0.01, random_state=42).fit(np.array(ref_values).reshape(-1, 1))

# Predict on current values
is_outlier = (clf.predict(np.array(cur_values).reshape(-1, 1)) == -1)
