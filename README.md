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
   - Liquidity position (current ratio)
3. **Visualization**: Scatter plots with fitted regression lines
4. **Regression Tables**: Comprehensive analysis of interaction effects

## Key Findings
Based on our analysis of the petroleum extraction industry (SIC 2111):

1. **R&D Investment Impact**: We found evidence that research and development expenditures have significant relationships with financial performance metrics, particularly when considering interactions with company size and financial structure.

2. **Interaction Effects**: The relationship between R&D and profitability is not uniform across all companies but is moderated by:
   - Company size (total assets): Larger companies may realize different returns on R&D investments compared to smaller firms
   - Financial leverage (debt-to-equity ratio): How a company finances its operations influences the impact of R&D on performance
   - Liquidity (current ratio): A company's short-term financial flexibility affects how R&D translates to performance

3. **Profitability Metrics**: Different profitability metrics (NPM, OPMAD, GPM, ROA, ROE) show varying sensitivity to R&D investments, suggesting that R&D may impact different aspects of financial performance differently.

4. **Industry Specificity**: Our findings are specific to the petroleum extraction industry (SIC 2111), where R&D often focuses on exploration technologies, extraction efficiency, and environmental compliance.

5. **Statistical Significance**: The regression analysis revealed several statistically significant interaction terms, indicating complex relationships between R&D spending and financial outcomes that go beyond simple linear effects.

For detailed statistical results and visual representations, please refer to the figures and tables directories and the full report in the docs folder.

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
