
* Tabula rasa
    cscript randcoef adofile randcoef

    webuse nlswork
* Make sure it's a panel data set
    qui: xtset          idcode year
    local               panellength = r(tmins) /* Minimum length of panel*/
    assert              `panellength' >= 3

* Keep 5 years of data only
    keep                if year >= 70 & year <76

* Reshape data to wide since -randcoef- takes wide data
    reshape             wide birth_yr - ln_wage          ///
                        , i(idcode) j(year)

* **********************************************************************
* Test if coefficients are correct
* Ideally, should produce simulations to compare results to
* For now, I am assuming coeffs here are correct as a baseline case

* Run rancoef - CRE ("effect" of marriage on wages)
    qui: randcoef       ln_wage*, choice(msp*) method(CRE)
    * Test
        mat                 coefs = e(b)'
        mat li              coefs
        di coefs[1,1]
        assert              reldif(coefs[1,1], -.00783921) < 1e-6

* Run rancoef - CRE ("effect" of marriage on wages), showreg
    qui: randcoef        ln_wage*, choice(msp*) method(CRE) showreg

* Run rancoef - CRE ("effect" of marriage on wages) with controls
    qui:randcoef        ln_wage*, choice(msp*) controls(south*) ///
                        method(CRE)
* Run rancoef - CRE ("effect" of marriage on wages) with controls, showreg
    qui:randcoef        ln_wage*, choice(msp*) controls(south*) ///
                        method(CRE) showreg

* **********************************************************************
* Test that estimates are output correctly
    * Clear existing estimates from memory
        eststo clear
        tempname            b1 b2

    * Use eststo to save result as cre1
        eststo cre1: randcoef        ln_wage*, choice(msp*) controls(south*) ///
                                    method(CRE)

        qui: esttab         cre1
        mat                 `b2' = r(coefs)
        assert              !mi(`b2'[1,1]) /* Not true until esttab success */
