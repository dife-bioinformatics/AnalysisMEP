## Instructions & checklist for PR author

### Contents of this pull request (tick appropriate)
- [ ] Bug fix
- [ ] New or modified feature
- [ ] Deleted feature
- [ ] Breaking change (fix/feature that would cause existing functionality to not work as expected any more)
- [ ] Refactoring of existing code (outcome of function is the same but internal code of function changed)
- [ ] Changes to test infrastructure
- [ ] Changes to CI pipeline(s)
- [ ] Style changes
- [ ] Changes to documentation

### Brief description of changes
[Add a description of what they have changed]

### Documentation instructions in exported R functions
- [ ] always used the `package::function` style to explicitely use functions
- [ ] used packages or functions from packages were declared in the import(From) field
- [ ] used packages are mentioned in the Imports field in the Description file
- [ ] roxygen2 fields: title, description, details, param(s), return, author, import(From), export
- [ ] Run `devtools::document()` (or use GUI equivalent) and check it builds 

### Testing instructions (tick appropriate)
- [ ] Changes to functions: Have you added/modified unit tests? 
- [ ] Changes to functions: If not (s.a.), can you add a minimal reproducible example (Input - Function Call - Output)
- [ ] Changes to functions: Have you installed the package locally and tried running it? 
- [ ] Run `devtools::check` (or use GUI equivalent) and check it passes without errors or warnings

## Instructions & checklist for PR reviewers
- [ ] Check that the continuous integration checks pass on the pull request branch 
- [ ] Checkout the pull request in a separate branch
- [ ] Run `devtools::build()` and check it builds without errors
- [ ] Run `devtools::check()` and check that all the tests are passed & no warnings given
- [ ] After running `devtools::check()`, are there any notes that can be easily resolved?
- [ ] Review the code and suggest any changes
- [ ] Are all mandatory roxygen2 fields declared?
