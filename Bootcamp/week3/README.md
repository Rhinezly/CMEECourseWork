# CMEE Week3 Coursework

This directory contains the in-class practices for biological computating bootcamp week3. Contents covered R basic syntax and structures, as well as data management and visualization. All the teaching materials and practical questions are on https://themulquabio.github.io/TMQB/intro.html.

All scripts were written and tested using R 4.4.1, on Visual Studio Code 1.94.2, and the bash terminal on Ubuntu 24.04.1 LTS.

## Usage

---

### Running the scripts

You can run all scripts without any input. Ensure your working environment is set to the directory containing the scripts (`../week3/code`).

- From the UNIX shell (R and Python scripts):
1. Exit from the R console using `ctrl+D`, or open a new bash terminal.
2. `cd` to the `week3/code` directory. 
3. Run the command:

```bash
Rscript ScriptName.R
```

```bash
python3 Test.py
```

- From the R command line (R scripts):
1. Enter `R` from bash 
2. Use `setwd()` to change to the `week3/code` directory
3. Run the script using:

```R
source("ScriptName.R")
``` 

Alternatively, if you don't want to change the working directory to `../week3/code`, you can specify the path to the script. For example, use `source("../code/ScriptrName.R")` if you are working from the `data` directory.

---

### Project structure

- `code/`: Contains all in-class scripts and individual practicals for Biological computing in R and Data Management and Visualization. Two additional files, `Test.py` and `Test.R`, demonstrate how to run R code in Python.

- `data/`: Contains the required CSV and TXT files for running the scripts. 

- `results/`: Stores four output PDF files from the data visualization scripts(`Girko.R`, `MyBars.R` and `MyLinReg.R`), one plot `MyFirst-ggplot2-Figure.pdf` generated from qplot exercise (code not included), and the report with plot (`Florida*.pdf`) from the correlation practical (`Florida.R` and `Florida_report.tex`). Running the script `PP_Regression.R` will generate `Predator_Prey_Plot.pdf` and `PP_Regress_Results.csv` in this directory, showing the regression results of Predator mass ~ Prey mass in each Feeding Type × Predator life Stage combination.

---

### Dependencies

You need the following R packages to run the scripts: reshape2, tidyverse, ggplot2, broom and purrr. If these are not already installed, you can install them in R with:

```R
install.packages(c("reshape2", "tidyverse", "ggplot2"))
```

In Ubuntu, you need to launch `sudo R` from bash, then run `install.packages()` to install as needed. You can also install them directly from bash terminal: 

```bash
sudo apt install r-cran-<PackageName>
``` 

If you use RStudio, you can also install packages through the GUI (graphical user interface).

---

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk