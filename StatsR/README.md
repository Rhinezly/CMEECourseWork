# Statistics in R

This directory contains the practicals and assessment work from the course, Statistics in R, in week 5 and 6.

All codes in this project were written and tested using Visual Studio Code 1.94.2 and R 4.4.1.

## Usage

---

### Running the scripts

You can run all scripts without any input. Ensure your working environment is set to the directory containing the scripts (`../code`).

- From the UNIX shell (R and Python scripts):
1. Exit from the R console using `ctrl+D`, or open a new bash terminal.
2. `cd` to the `../code` directory. 
3. Run the command:

```bash
Rscript ScriptName.R
```

- From the R command line (R scripts):
1. Enter `R` from bash 
2. Use `setwd()` to change to the `../code` directory
3. Run the script using:

```R
source("ScriptName.R")
``` 

Alternatively, if you don't want to change the working directory to `../code`, you can specify the path to the script. For example, use `source("../code/ScriptrName.R")` if you are working from the `data` directory.

---

### Project structure

#### Top-level directories

- `assessment/`: Statistical analysis and report for the course assessment.

- `practical/`: Weekly scripts from the in-class handouts.

#### Subdirectories

- `code/`: Includes all scripts and source files.

- `data/`: Contains the required CSV and TXT files for running the scripts, and metadata PDF files for the assessment data. 

- `results/`: Only used in `assessment/`, contains the output generated from the analysis, including visualization, table, and report.

---

### Dependencies

You need to install the following packages in R:

```R
install.packages("dplyr") 
install.packages("lubridate")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("lme4")
install.packages("lmtest")
install.packages("nlme")
install.packages("AICcmodavg")
install.packages("stargazer")
install.packages("sjPlot")
install.packages("plotrix")
install.packages("ggpubr")
install.packages("MASS")
install.packages("ggeffects")
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