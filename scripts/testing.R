# R script to source all files contained in the R
# so that cna be used to test packages

for (file in dir("R")) {
        print(file);
        source(paste0("R/",file))
}
