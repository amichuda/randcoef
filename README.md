# randcoef
A repository that holds the source code for the `randcoef` command in Stata

The Stata journal article for `randcoef` can be found [here](https://www.stata-journal.com/article.html?article=st0517)

## Versions

Currently, there are three versions:

- `master` 
  - contains the published command, but with a change to turn of `mata strict`
- `rank_maxiter` 
  - checks that matrix used in optimization has rank 
  - has an option for maximum iterations for the optimizer
- `multicoll_and_endog_not_dummies` 
  - Adds an error message if multicollinearity stops the optimization
  - Adds an error message choice and endogenopus variables are not dummies
  
I did not merge them together, because it didn't work on all machines that were used. It seems that it needs to be tested.


