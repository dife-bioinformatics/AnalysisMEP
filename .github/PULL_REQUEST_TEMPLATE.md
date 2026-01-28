## Instructions & checklist for PR author

### Description of changes
[Add a description of what they have changed]

### Refactor instructions
- [ ] Removed any client-side code checking whether an object has been successfully created
- [ ] Reviewed code to determine if additional refactoring could reduce calls to server-side package

### Testing instructions
- [ ] Writen client-side unit tests for unhappy flow
- [ ] Run `devtools::test(filter = "smk-|disc|arg")` and check it passes
- [ ] Run `devtools::check(args = '--no-tests')` and check it passes
- [ ] Run `devtools::build()` and check it builds without errors

## Instructions & checklist for PR reviewers
- [ ] Checkout this branch as well as the corresponding branch of dsBase
- [ ] Review the code and suggest any changes
- [ ] Run `devtools::build()` and check it builds without errors
- [ ] Check that the continuous integration checks pass on the pull request branch (see above note on performance checks)
