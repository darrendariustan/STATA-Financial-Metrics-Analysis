/*        __^__                                      __^__
         ( ___ )------------------------------------( ___ )
          | / |     STATA Course: ESADE 2024         | \ |
          | / |            Group Project             | \ |
          |___|       Darren Tan, I-Wen Shih         |___|
         (_____)------------------------------------(_____) 	
		 
*/

// Set up working directory by specifying the paths of your folders as global variables.
global raw_data "C:\Users\acer\OneDrive - Universitat Ramón Llull\Desktop\ESADE_Modules\6_Cross_Term_Courses\1_Stata_Empirical_Finance\Project\raw_data"
global figures "C:\Users\acer\OneDrive - Universitat Ramón Llull\Desktop\ESADE_Modules\6_Cross_Term_Courses\1_Stata_Empirical_Finance\Project\figures"
global tempkeep "C:\Users\acer\OneDrive - Universitat Ramón Llull\Desktop\ESADE_Modules\6_Cross_Term_Courses\1_Stata_Empirical_Finance\Project\tempkeep"
global tables "C:\Users\acer\OneDrive - Universitat Ramón Llull\Desktop\ESADE_Modules\6_Cross_Term_Courses\1_Stata_Empirical_Finance\Project\tables"
global tempfiles "C:\Users\acer\OneDrive - Universitat Ramón Llull\Desktop\ESADE_Modules\6_Cross_Term_Courses\1_Stata_Empirical_Finance\Project\tempfiles"

clear all

use "$raw_data/dataset_1_query_by_fundamentals.dta" , clear

// Step 1: Merging
duplicates report gvkey

// gsort gvkey -fyear
// by gvkey: keep if _n == 1 // need to remove duplicates in dataset_1_query_by_fundamentals in gvkey for m:1 merge. The latest fyear gets retained, and it is no point to bring it over to dataset_3
// save "$tempkeep/dataset_1.dta", replace

use "$raw_data/dataset_2_query_by_ratios.dta" , clear
merge m:m gvkey using "$raw_data/dataset_1_query_by_fundamentals.dta", keepusing(sic naics fyear xrd at conm) // Also only the latest xrd and at gets retained from dataset_1.  My proposal to use rd_sale from dataset_2_query_by_ratios instead.

// Step 2: Keep only useful variables
keep gvkey fyear conm public_date npm opmad gpm roa roe xrd at de_ratio curr_ratio naics sic

// Step 3: Data trimming
keep if sic == "2111" // sic is a string
save "$tempkeep/dataset_3.dta" , replace
drop if missing(npm) | missing(opmad) | missing(gpm) | missing(roa) | missing(roe) | missing(xrd) | missing(at) | missing(de_ratio) | missing(curr_ratio)

// Step 4: Check for data types
compress
* all the numerical variables will remain as doubles rather than floats for precision.
* all dates shall be integers and others will be strings to maintain clarity for what we are going to plot.

// Step 5: Inspect and Log variables if necessary
summarize
gen log_at = log(at)
gen log_xrd = log(xrd)
* Other variables represent ratios or percentages so they already represent normalized values.
label var log_at "Logged Total Assets"
label var log_xrd "Logged R&D Expenditures"
save "$tempkeep/dataset_3_cleaned.dta", replace

// Step 6: Graph without interaction effects

ssc install estout

* Create individual scatter plots with regression lines
eststo clear

foreach yvar in npm opmad gpm roa roe {
    twoway (scatter `yvar' log_xrd) (lfit `yvar' log_xrd), ///
        title("`yvar' vs R&D (log_xrd)") ///
        ytitle("`yvar'") xtitle("R&D (log_xrd)") ///
        legend(off) name(`yvar', replace)
    
    reg `yvar' log_xrd  // Run regression
    eststo `yvar'   // Store regression results
}

* Combine graphs into a single display
grc1leg npm opmad gpm roa roe, ///
    title("Relationship between R&D and Financial Metrics") ///
    graphregion(color(white))

graph save "$figures/Combined_Simple_LR.gph" , replace
graph export "$figures/Combined_Simple_LR.png" , as(png) replace
	
// Step 7: Graph with interaction effects

* Pre-compute interaction terms
gen log_xrd_log_at = log_xrd * log_at
gen log_xrd_de_ratio = log_xrd * de_ratio
gen log_xrd_curr_ratio = log_xrd * curr_ratio

foreach yvar in npm opmad gpm roa roe {
    * Interaction of log_xrd with log_at
    twoway (scatter `yvar' log_xrd) (lfit `yvar' log_xrd_log_at), ///
        title("Interaction: `yvar' vs log_xrd & log_at") ///
        ytitle("`yvar'") xtitle("log_xrd") ///
        legend(off) name(`yvar'_log_xrd_log_at, replace)
    
    * Interaction of log_xrd with de_ratio
    twoway (scatter `yvar' log_xrd) (lfit `yvar' log_xrd_de_ratio), ///
        title("Interaction: `yvar' vs log_xrd & de_ratio") ///
        ytitle("`yvar'") xtitle("log_xrd") ///
        legend(off) name(`yvar'_log_xrd_de_ratio, replace)
    
    * Interaction of log_xrd with curr_ratio
    twoway (scatter `yvar' log_xrd) (lfit `yvar' log_xrd_curr_ratio), ///
        title("Interaction: `yvar' vs log_xrd & curr_ratio") ///
        ytitle("`yvar'") xtitle("log_xrd") ///
        legend(off) name(`yvar'_log_xrd_curr_ratio, replace)
	
	* Combine graphs for the current yvar
    grc1leg `yvar'_log_xrd_log_at `yvar'_log_xrd_de_ratio `yvar'_log_xrd_curr_ratio, ///
        title("Combined Interaction Effects for `yvar'") ///
        name(Combined_`yvar', replace)

	* Save combined graph only
	graph save "$figures/Combined_Interactions_`yvar'.gph", replace
    graph export "$figures/Combined_Interactions_`yvar'.png", as(png) replace
}

// Step 8: Table Regression with interaction effects.

* Clear any existing stored results
eststo clear

* Run regressions for each dependent variable and store results
foreach yvar in npm opmad gpm roa roe {
    reg `yvar' c.log_xrd##c.log_at##c.de_ratio##c.curr_ratio, robust
    eststo `yvar' // Store regression results
	estadd local robust "yes"
}

* Generate a single combined regression table
esttab npm opmad gpm roa roe using "$tables/Regression_Table.rtf", ///
    replace label se star(* 0.10 ** 0.05 *** 0.01) ///
    title("Regression Table for Interactions of log_xrd, log_at, de_ratio, and curr_ratio") ///
    stats(N rmse robust, label("N" "RMSE" "Robust SE")) ///
    legend ///
    rtf ///
    noconstant ///
    mtitles("NPM" "OPMAD" "GPM" "ROA" "ROE")
	
* To save into a tex format:
esttab npm opmad gpm roa roe using "$tables/Regression_Table.tex", ///
    replace label se star(* 0.10 ** 0.05 *** 0.01) ///
    title("Regression Table for Interactions of log_xrd, log_at, de_ratio, and curr_ratio") ///
    stats(N rmse robust, label("N" "RMSE" "Robust SE")) ///
    legend ///
    tex ///
    noconstant ///
    mtitles("NPM" "OPMAD" "GPM" "ROA" "ROE")


