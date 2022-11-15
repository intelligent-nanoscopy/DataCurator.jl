## Reusing existing code
Using existing Python or R code arguably could not be simpler:
```toml
actions=["python.meshio.read", "R.base.sum"]
```

### Using Python packages/code
Let's say you have an existing python module which you want to use in the template.
In this example, we'll use `meshio`.
We want to use the function `meshio.read(filename)`
```julia
using DataCurator, PyCall, Conda
Conda.add("meshio", channel="conda-forge")
```
Now you can do in a template
```toml
actions=["python.meshio.read"]
```
You can check if code is picked up
```julia
p=lookup("python.meshio.read")
isnothing(p) ## Should be false
```
This works thanks to [PyCall.jl and Conda.jl](https://github.com/JuliaPy/PyCall.jl)

### Using R in templates
You can use R functions
```julia
using DataCurator
p=lookup("R.base.sum")
isnothing(p) == false #
```
Now you can do in a template
```toml
actions=["R.base.sum"]
```
This assumes R is installed, if not DC will try to install it.
Installing your own R packages is beyond scope of this documentation, if it is available in your R install, the above will work.
See [RCall.jl](https://github.com/JuliaInterop/RCall.jl).


### Extending DataCurator
If you want to add support for your own datatypes or functions, the only thing you need is to make them available to DataCurator. More formally, they need to be in scope.
```julia
using DataCurator
function load_newtype(filename)
        ## Your code here
end
# or
using MyPackage

load_newtype = MyPackage.load_mydata
```
Then
```toml
actions=["load_newtype"]
```
Parameter passing will work, but if you need to change the signature or predefine parameters, you can do so to:
```julia
using DataCurator
function sum_threshold(xs, threshold)
        sum(xs[xs .>= threshold])
end
sum_short = x -> sum_threshold(x, 1)
```
then this is equivalent
```toml
actions=[["sum_threshold", 1]]
```
to
```toml
actions=["sum_short"]
```