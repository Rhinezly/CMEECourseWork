# Introduction to GIS in R

This directory contains the practicals from the course, Introduction to GIS in R.

All codes in this project were written and tested using Visual Studio Code 1.94.2 and R 4.4.1.

## Usage

---

### Running the scripts

You can run all scripts without any input. Ensure your working environment is set to the directory containing the scripts (`../practical/code`).

- From the UNIX shell (R and Python scripts):
1. Exit from the R console using `ctrl+D`, or open a new bash terminal.
2. `cd` to the `../practical/code` directory. 
3. Run the command:

```bash
Rscript ScriptName.R
```

- From the R command line (R scripts):
1. Enter `R` from bash 
2. Use `setwd()` to change to the `../practical/code` directory
3. Run the script using:

```R
source("ScriptName.R")
``` 

Alternatively, if you don't want to change the working directory to `../code`, you can specify the path to the script. For example, use `source("../code/ScriptrName.R")` if you are working from the `data` directory.

---

### Project structure

#### Subdirectories

- `code/`: Includes all scripts in the practicals.

- `data/`: Contains the required files for running the scripts. 

---

### Dependencies

You need to install the following packages in R:

```R
install.packages('terra')    # Core raster GIS data package
install.packages('sf')       # Core vector GIS data package
install.packages('raster')   # Older raster GIS package required by some packages
install.packages('geodata')  # Data downloader

install.packages('sp')        # Older vector GIS package - replaced by sf in most cases
install.packages('rgdal')     # Interface to the Geospatial Data Abstraction Library
install.packages('lwgeom')    # Lightweight geometry engine

# Practical 1
install.packages('openxlsx')   # Read data from Excel 
install.packages('ggplot2')    # Plotting package
install.packages('gridExtra')  # Extensions to ggplot

# Practical 2
install.packages('dismo')      # Species distribution models
```

In Ubuntu, you need to launch `sudo R` from bash, then run `install.packages()` to install as needed. You can also install them directly from bash terminal: 

```bash
sudo apt install r-cran-<PackageName>
``` 

If you use RStudio, you can also install packages through the GUI(graphical user interface).

---

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk