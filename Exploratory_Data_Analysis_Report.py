import pandas as pd
import numpy as np
from scipy.stats import skew, kurtosis, mode

# Load dataset from Excel file
df = pd.read_excel(r'C:\Users\palni\Downloads\Project 1\Data-set.xlsx')

# Select numeric columns only
numeric_data = df.select_dtypes(include=[np.number])

# Dictionary to store EDA results
eda_results = {}

for col in numeric_data.columns:
    col_data = numeric_data[col].dropna()
    
    # Calculate mode (handle empty cases)
    try:
        mode_value = mode(col_data).mode[0]
    except IndexError:
        mode_value = np.nan
    
    eda_results[col] = {
        'mean': col_data.mean(),
        'median': col_data.median(),
        'mode': mode_value,
        'variance': col_data.var(),
        'std_dev': col_data.std(),
        'range': col_data.max() - col_data.min(),
        'skewness': skew(col_data),
        'kurtosis': kurtosis(col_data)
    }

# Create summary DataFrame
eda_df = pd.DataFrame(eda_results).T

# Save summary to CSV
eda_df.to_csv('eda_summary.csv')

# Display the first few rows
print(eda_df.head())

