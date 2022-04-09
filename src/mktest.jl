using Images
using Logging
using Pkg
Pkg.activate(".")
using DataCurator

IN="testdir"
delete_folder(IN)
delete_folder("outputdir")
mkpath(IN)
mkpath("outputdir")
Images.save(joinpath(IN, "test.tif"), zeros(2,3))
Images.save(joinpath(IN, "test3.tif"), zeros(2,3))
deep = joinpath(IN, "1", "2", "3", "4")
mkpath(deep)
Images.save(joinpath(IN, "1", "test_1.tif"), zeros(20,20))
Images.save(joinpath(IN, "1", "2", "test_1.tif"), zeros(20,20))
Images.save(joinpath(IN, "1", "2", "3", "test_1.tif"), zeros(20,20))
Images.save(joinpath(IN, "1", "2", "3", "4", "test_1.tif"), zeros(20,20))
