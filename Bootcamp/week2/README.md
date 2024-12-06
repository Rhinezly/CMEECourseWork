# CMEE Week2 Coursework

This directory contains the in-class practices and practicals for biological computating bootcamp week2. The content covers basic Python syntax and structures. All teaching materials and practical questions are on https://themulquabio.github.io/TMQB/intro.html.

All scripts were written and tested using Python 3.12.3, on Visual Studio Code 1.94.2 and the bash terminal on Ubuntu 24.04.1 LTS.

## Usage

---

### Running the scripts

You can run all the scripts without any input. Ensure your working environment is set to the directory containing the scripts (`../week2/code`).

- **From the UNIX shell:**
1. Exit from the Python console using `ctrl+D`, or open a bash terminal.
2. `cd` to the `week2/code` directory. 
3. Run the command:

```bash
python3 ScriptName.py
```

- **Using ipython from the shell:**

```bash
ipython3 ScriptName.py
```

- **From within the ipyhon shell:**
1. Enter `ipython3` from bash 
2. Run the script with:

```ipython
%run Scriptname.py
``` 

Alternatively, some scripts are Python programmes, so you can imprt them and use their built-in functions:

```python
import ScriptName
ScriptName.Function(Argument1, Argument2, ...)
``` 

If no arguments are provided by the user, the function will execute with its default arguments.

To check programme descriptions and functions after importing, you can use `help(ScriptName)` or `?ScriptName` in the python or ipython shell.

---

### Project structure

- `code/`: Contains all scripts for Biological computing in Python 1. Scripts can be used as standalone Python programmes include: `align*.py`, `*control_flow.py`, `boilerplate.py`, `cfexercises1.py` and `oaks_debugme.py`.

- `data/`: Contains the required CSV and FASTA files to run the scripts. 

- `results/`: this directory is initially empty and will store a CSV file `JustOaksData.csv` as the result output from `oaks_debugme.py`.

---

### Dependencies

You need the following Python modules to run the scripts: `csv`, `sys`, `pickle` and `doctest`. To verify if a module is installed, you can use `pip show <module_name>` in the command line, or try importing the module using Python script:

```python
try:
    import <module_name>
    print(f"'{<module_name>}' is installed.")
except ImportError:
    print(f"'{<module_name>}' is not installed.")
```

To install a module, use the following command: 

```bash
sudo apt install python3-<module_name>
```

or 

```bash
pip install <module_name>
```

If you cannot run the `pip` command, you may need to install `pip` first:

```bash
sudo apt-get install python3-pip
```

---

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk