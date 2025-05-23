# Data Files

Due to their large size, the data files are not included in this GitHub repository. The analysis uses two primary datasets:

- `dataset_1_query_by_fundamentals.dta` (~51MB)
- `dataset_2_query_by_ratios.dta` (~145MB)

## How to Obtain the Data

To reproduce the analysis:

1. Place the following data files in this directory:
   - `dataset_1_query_by_fundamentals.dta`
   - `dataset_2_query_by_ratios.dta`

2. Update the global path variables in the `project_final.do` file to match your local environment.

## Data Description

- `dataset_1_query_by_fundamentals.dta`: Contains fundamental financial data including R&D expenditures (xrd) and total assets (at).
- `dataset_2_query_by_ratios.dta`: Contains financial ratios and performance metrics (npm, opmad, gpm, roa, roe, etc.).

The analysis focuses on the petroleum extraction industry (SIC code 2111) and examines the relationship between R&D expenditures and various financial performance metrics.
