* **********************************************************************
* Project: randcoef testing
* Created: April 2020
* Last modified: 04/16/2020 by ET
* Stata v.16.1

* **********************************************************************
* does
    /* randcoef testing script */
	/* check that the ado file to be tested lives as bench/randcoef.ado */

* Tabula rasa
    clear
    discard
    set more            	off

* Set this value to the user currently using this file
    global              	user "et"

* Define root folder globals
    if "$user" == "et" {
        global          	repo "C:/Users/`c(username)'/Desktop/git/randcoef"
    }

* cd to testing directory   /* in this case, cd > dynamic filepaths
                            since Stata will look for .ado files
                            in local repo first
                            */
    cd                      "$repo/bench"

* dependencies
	* for packages/commands, make a local containing any required packages
        local           userpack "tuples"

* TO DO:
    * Build more tests
	* Ideally compare randcoef output to simulation output
	* (a.o.t. current strategy of comparing to existing output)

* **********************************************************************
* Forego version specification for testing
    * global stataVersion 16.1    // set Stata version
    * version $stataVersion

* **********************************************************************
* Check if dependencies installed
	foreach package in `userpack' {
		capture : which `package', all
		if (_rc) {
	        capture window stopbox rusure "You are missing some packages." "Do you want to install `package'?"
	        if _rc == 0 {
	            capture ssc install `package', replace
	            if (_rc) {
	                window stopbox rusure `"This package is not on SSC. Do you want to proceed without it?"'
	            }
	        }
	        else {
	            exit 199
	        }
		}
	}

* **********************************************************************
* Test -randcoef-
	about
	do randcoef.do
