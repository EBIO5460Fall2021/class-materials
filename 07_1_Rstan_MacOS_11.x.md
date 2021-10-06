# MacOS 11.x (Big Sur) R Toolchain preparation

The R Toolchain installer doesn't seem to work but we have had success with manual installation as follows.

1. Uninstall the toolchain following here: https://thecoatlessprofessor.com/programming/r/uninstalling-the-r-development-toolchain-on-macos/. You may not have the toolchain installed but go through all of these steps anyway to ensure all components are removed.

2. From the Mac terminal: 

  ```bash
  sudo pkgutil --forget com.gnu.gfortran
  ```

3. Reinstall X tools. From the Mac terminal:

  ```bash
  xcode-select --install
  ```

4. From the Mac terminal, verify installation

  ```bash
  gcc --version
  ```

5. If you have an Intel-based Mac, get `gfortran-Intel-11.1-BigSur.dmg` and install it from here: https://github.com/fxcoudert/gfortran-for-macOS/releases. It is possible that `gfortran-8.2-Mojave.dmg` also works as that is what is described in the official R documentation but we found 11.1 to work. If you have one of the new M1 (i.e. ARM) Macs, you probably need to try `gfortran-ARM-11.0-BigSur.dmg` (experimental 2 was the latest version).

6. Install required binary components `pcre2` and `xz` following directions here: https://cran.r-project.org/doc/manuals/r-release/R-admin.html#macOS (i.e. enter the `curl ...` and `sudo tar ...` commands as listed under "For example" into the Mac terminal).

7. Restart R and test that packages can be installed from source

  ```R
  install.packages("jsonlite", type = "source")
  ```

8. Uninstall RStan and reinstall from source as follows, from R:

  ```R
  remove.packages("rstan")
  if (file.exists(".RData")) file.remove(".RData")
  install.packages(c("Rcpp","RcppEigen","RcppParallel","StanHeaders"),type="source")
  install.packages("rstan",type="source")
  ```

9. Enable compiler optimizations for Stan by entering the following in the R console:

```R
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS += -O3 -mtune=native -arch x86_64 -ftemplate-depth-256",
    file = M, sep = "\n", append = FALSE)
```

10. Now try the 8schools example and map2stan.

