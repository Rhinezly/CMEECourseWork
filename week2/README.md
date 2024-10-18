# CMEE Week2 Coursework

This directory contains the in-class practices and praticals for biological computating bootcamp week2. Contents covered Python basic sytax and structures. All the teaching materials and practical questions are on https://themulquabio.github.io/TMQB/intro.html.

All codes in this project were written in and tested with Python 3.12.3, on Visual Studio Code 1.94.2 and bash terminal of Ubuntu 24.04.1 LTS.

## Usage

### Running the scripts

- You can run all the scripts without any input. Ensure your working environment is where the scripts are (../week2/code).

**From the UNIX shell:**
Open a bash terminal and `cd` to the week2 `code` directory. Then run the command:

`python3 ScriptName.py`

**You can also use ipython from the shell:**

`ipython3 ScriptName.py`

**From within the ipyhon shell:**
Enter `ipython3` from bash and run this command:

`%run Scriptname.py` 

- Alternatively, some scripts are Python programmes, so you can also choose to use their inbuild functions after importing.

`import ScriptName`
`ScriptName.Function(Argument1, Argument2, ...)` 

If no argument entered from user, the function will run by default argument.

You can check programme descriptions and functions after importing, by using `help(ScriptName)` or `?ScriptName` in the python or ipython shell.

For `align_seqs_fasta.py` and `align_seqs_better.py`, specifically, while it could run without explicit inputs, you can choose to input any two fasta sequences in seperate files to be aligned. With shell command, for exmaple:

```bash
python3 align_seqs_fasta.py seq1.fasta seq2.fasta
```

### Project structure

The `code` directory includes all scripts for Biological computing in Python 1. Scripts can be used as Python programmes are: `align*.py`, `*control_flow.py`, `boilerplate.py`, `cfexercises1.py`, `oaks_debugme.py`.

The `data` directory contains neccessary CSV and FASTA files to run the scripts. The `results` directory is empty and will hold a binary file `my_best_align` as resulting output from `align_seqs_better.py`.

### Dependencies

Python modules `csv`, `sys`, `pickle`, `doctest` need to be installed if not already on the device or Python environment. You can check whether a module is installed using `pip show <module_name>` in the command line, or try importing the module using Python script:

```python
try:
    import <module_name>
    print(f"'{<module_name>}' is installed.")
except ImportError:
    print(f"'{<module_name>}' is not installed.")
```

You can install a module in the command line using `sudo apt install python3-<module_name>` or `pip install <module_name>` (if cannot run the `pip` command you need to install `pip` first).

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk