# Financial Metrics Analysis: R&D Impact on Performance

## Project Overview
This repository contains a STATA-based analysis examining the relationship between R&D expenditures and various financial performance metrics in the petroleum extraction industry (SIC code 2111). The analysis explores both direct relationships and interaction effects with other financial variables.

## Authors
- Darren Tan
- I-Wen Shih

## Structure
- **code/**: Contains STATA .do files with the analysis code
- **data/**: Directory for data files (see Data section below)
- **figures/**: Output visualizations showing relationships between variables
- **tables/**: Regression analysis results in various formats
- **docs/**: Final report and additional documentation

## Key Financial Metrics Analyzed
- Net Profit Margin (npm)
- Operating Profit Margin After Depreciation (opmad)
- Gross Profit Margin (gpm)
- Return on Assets (roa)
- Return on Equity (roe)

## Key Variables
- R&D Expenditures (log_xrd)
- Total Assets (log_at)
- Debt-to-Equity Ratio (de_ratio)
- Current Ratio (curr_ratio)

## Analysis Methods
1. **Simple Linear Regression**: Direct relationship between R&D and financial metrics
2. **Interaction Analysis**: How the R&D-performance relationship is moderated by:
   - Company size (total assets)
   - Financial leverage (debt-to-equity ratio)
   - Liquidity (current ratio)
3. **Visualization**: Scatter plots with fitted regression lines
4. **Regression Tables**: Comprehensive analysis of interaction effects

## Data
Due to file size limitations on GitHub, the raw data files are not included in this repository. The analysis uses two primary datasets:
- `dataset_1_query_by_fundamentals.dta` (~51MB)
- `dataset_2_query_by_ratios.dta` (~145MB)

These datasets contain financial fundamentals and ratios for publicly traded companies.

### Data Acquisition
To reproduce the analysis:
1. Place the data files in a local `raw_data` directory
2. Update the global path variables in the `project_final.do` file to match your local environment

## Running the Analysis
1. Install STATA software
2. Update directory paths in `code/project_final.do` to match your local environment
3. Execute the .do file in STATA

## Results
The analysis reveals patterns in how R&D expenditures relate to financial performance in the petroleum extraction industry, with interesting interaction effects based on company size, leverage, and liquidity. See the full report in the docs folder for detailed findings and interpretations.
