# My CMEE Coursework Repository

This repository is to submit the author's CMEE coursework. It contains in-class practices and practicals from **The Multilingual Quantitative Biologist** online book https://themulquabio.github.io/TMQB/intro.html, and subsequent computational works in other courses.

All codes in this project were written and tested using the bash terminal on Ubuntu 24.04.1 LTS, Visual Studio Code 1.94.2, Python 3.12.3 and R 4.4.1.

## Usage

---

### Running the scripts

Most scripts can be executed directly from the shell:
- Shell script: `bash ScriptName.sh`
- Python script: `python3 ScriptName.py`
- R script: `Rscript ScriptName.R`

Some scripts may require additional or mandotory user input. For example, `python3 ScriptName.py argv1 argv2 ...`.

---

### Project structure

#### Top-level directories

- `Bootcamp/`: Weekly contents in CMEE Bootcamp, three weeks in total.
- `StatsR/`: Two-week contents from Statistics in R, including in-class practicals and assessment.
- `GIS/`: Practicals from GIS week.

#### Subdirectories

- `code/`: Contains all code, scripts and source files. 
- `data/`: Contains the necessary data files to run the code. 
- `results/`: Stores required output, such as visualizations, tables, and reports. Most results are automatically generated in this directory when the assessment script runs.

---

### Dependencies

On Linux, you may install LaTex and R by running the following command: 

- **LaTex:**
```bash
sudo apt install texlive-latex-extra
```

- **R:**
```bash
sudo apt install r-base
```

If you need to install Python modules using package manager `pip`, first install `pip`: 

```bash
sudo apt-get install python3-pip
```

Alternatively, install Python modules directly via the system: 

```bash
sudo apt install python3-<module_name>
```

For more detailed installation instructions for different systems, see https://imperial-fons-computing.github.io/.

Additional specific requirements for each week's courework can be found in the correponding week's `README` file.

---

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk