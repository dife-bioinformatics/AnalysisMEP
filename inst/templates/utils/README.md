# EPICP_HSH_Converter

This repository serves 2 purposes:

- automatic quality checks of the EPIC-Potsdam Data Dictionary
- conversion of the EPIC-Potsdam Data Dictionary file into the format necessary for inclusion in the Health Study Hub (https://health-study-hub.de/) as a Dictionary resource 


## Current Status

<details>
<summary>Baseline</summary>

![Baseline_lastTest_badge](status/badges/Baseline_lastTest_badge.svg)

![Baseline_CategorySeparator_badge](status/badges/Baseline_CategorySeparator_badge.svg) 
![Baseline_CategorySeparateWider](status/badges/Baseline_CategorySeparateWider_badge.svg) 
![Baseline_CategoryUnit](status/badges/Baseline_CategoryUnit_badge.svg) 
![Baseline_CategoryValueNumber](status/badges/Baseline_CategoryValueNumber_badge.svg) 
![Baseline_CategoryVariableType](status/badges/Baseline_CategoryVariableType_badge.svg) 
![Baseline_Collection_Events](status/badges/Baseline_Collection_Events_badge.svg) 
![Baseline_Collection_Events_NA](status/badges/Baseline_Collection_Events_NA_badge.svg) 
![Baseline_Collection_Events_Prefix](status/badges/Baseline_Collection_Events_Prefix_badge.svg) 
![Baseline_Datenerhebung_Detail_NA](status/badges/Baseline_Datenerhebung_Detail_NA_badge.svg) 
![Baseline_Datenerhebung_NA](status/badges/Baseline_Datenerhebung_NA_badge.svg) 
![Baseline_derivedVar](status/badges/Baseline_derivedVar_badge.svg) 
![Baseline_EnglishDictionary](status/badges/Baseline_EnglishDictionary_badge.svg) 
![Baseline_HoursMinutesType](status/badges/Baseline_HoursMinutesType_badge.svg) 
![Baseline_ID_Duplicate](status/badges/Baseline_ID_Duplicate_badge.svg) 
![Baseline_ID_NA](status/badges/Baseline_ID_NA_badge.svg) 
![Baseline_Maelstrom_AreaOfInformation_Group](status/badges/Baseline_Maelstrom_AreaOfInformation_Group_badge.svg) 
![Baseline_Maelstrom_AreaOfInformation_SubGroup](status/badges/Baseline_Maelstrom_AreaOfInformation_SubGroup_badge.svg) 
![Baseline_SpaceBeginning](status/badges/Baseline_SpaceBeginning_badge.svg) 
![Baseline_SpaceEnd](status/badges/Baseline_SpaceEnd_badge.svg) 
![Baseline_SpaceMultiple](status/badges/Baseline_SpaceMultiple_badge.svg) 
![Baseline_Themenbereich_NA](status/badges/Baseline_Themenbereich_NA_badge.svg) 
![Baseline_Themenbereich_Vertiefung_NA](status/badges/Baseline_Themenbereich_Vertiefung_NA_badge.svg) 
![Baseline_unitType](status/badges/Baseline_unitType_badge.svg) 
![Baseline_valueType](status/badges/Baseline_valueType_badge.svg) 
![Baseline_VariableName_Duplicate](status/badges/Baseline_VariableName_Duplicate_badge.svg) 
![Baseline_Variablenname_NA](status/badges/Baseline_Variablenname_NA_badge.svg) 


</details>






## Initial Setup
### Replicating the environment
1) Use renv::restore() from the console to replicate the environment. If the renv package is not installed, execute install.packages("renv") first.

### Data Dictionary JSON file
2) Save the newest EPICP data dictionary file in the data folder. The file should contain all collection events and not only the one currently being 
worked on, in order to identify potential issues in other areas.


Name conventions: 

- "EPICP_DD_YYYYMMDDHHMM.json" 


Currently, only the latest DD will be tested. Testing specific files could be added as a feature if that is wanted.


### Setup of testing scopes
3) Execute usethis::edit_r_environ(scope = "project") to create an .Renviron file. 
4) In the .Renviron file, add a line: R_CONFIG_ACTIVE = "WHAT-YOU-WANT-TO-TEST"
5) Save the file and restart R as this file will always be loaded when starting RStudio. Press in the top menu "Session" > "Restart R".

Current options for "WHAT-YOU-WANT-TO-TEST" are: "default", "testing" and "production". In the config.yml file, variable configuration for the different options
are shown.

- "default" relates to the options when no specific profile has been set and usually covers everything.
- "testing" relates to a configuration that is useful when actively working on improving certain elements of the DD (e.g. collection events).
- "production" relates to a configuration where the DD items have been finalised. Only DD sections that are mentioned in this config are used for the HSH and User Interface.



Note: 

"testing" definitions in the config.yml file can be changed frequently to most efficiently work on the DD.
"production" settings should be considered more carefully.


### Initiate quality testing
6) Run the command lines found in the "tests/test_initiation.R" file. This should only take a few seconds to complete. Committing and pushing JSON files in the "data" folder
also initiates quality testing but in the cloud through github-actions workflow. This takes considerable more time (~ 4min), since the environment needs to be
created first.


### Inspect testing results
7) In the tests/outcome/YYYYMMDD_HHMMSS folder, the test results will be stored:

- test_results_summary contains an overview of the type of test with binary outcome (OK / Problem)
- problems_detail contains a specific error message for rows where problems occurred
- word_check contains potential wrong spelling in English words
- maelstrom_areaofinformation contains said group and subgroup options + potentially, additional values (e.g. Family History!)


### Add Exceptions of English words to file
8) In tests/expectations, the file English_word_exceptions.xlsx contains entries (e.g. names, common abbreviations such as "BMI") that should not lead 
to a fail run in the automatic check of English words.



## Detailed Information
### renv
The renv package is used to manage the R Project environment package versioning. After pulling the repository, the command renv::restore() should be run
in the console to install all necessary R packages and their version - they are tracked in the renv.lock file.
After installing additional packages through various means (e.g. install.packages, renv::install, remotes::install_github), you should check whether the package 
will be tracked by executing renv::status(). If there are any warnings, read through them. In most cases calling renv::snapshot() in the console will solve them
by creating a new image of necessary packages and store them in the renv.lock file. 

### testing
Unit testing is conducted through a combination of the testthat package and custom code. In the tests/testthat folder, the setup.R file defines the "data" import of the newest JSON file of the Data Dictionary. 
The "test-0Y_XXX.R" files contain the specific tests to check whether set rules will be adhered to. They have been organised into different files
to distinguish between types of rule categories.  
Depending whether the tests succeed or fail, more granular checks are being conducted, in order to identify and label problems for each row. The results of tests are being stored in the tests/outcome folder
in a "date_time" subfolder. Currently, Excel files are being created to show which tests fail and why they are failing alongside words that should be check for the English language.
Exceptions to the English language test, such as names, should be added to the tests/expectations/English_word_Exceptions.xlsx file by copying the cell.
Additionally, some tests have pre-defined objects stored in rds files (tests/expectations). The rds files without a "_test" suffix (e.g. english_dictionary.rds) contain the default expectation. 
They will be loaded before the test suite is run and the same object will be written to the rds file with "_test" suffix (e.g. english_dictionary_test.rds). This is
done because the "expect_equal_to_reference" check whether an object is equal to an rds file will overwrite the "_test" rds file in case they differ. Therefore,
after conclusion of the test, the "_test" rds file will contain a list of entries where problems occurred. To look at them, simply load them into the RStudio
environment.

More documentation on the tests can be found here: XXXXXXXXXXXXXXX (To-Do)

### GitHub-Actions


Needs to be filled out
- CRON
- download
- maelstrom taxonomy
- fwd file and status (config.yml)





