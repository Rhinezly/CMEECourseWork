# My CMEE Coursework Repository

This repository is to submit the author's CMEE coursework. It contains the in-class practices and praticals from **The Multilingual Quantitative Biologist** online book https://themulquabio.github.io/TMQB/intro.html.

All codes in this project were written in and tested with bash terminal of Ubuntu 24.04.1 LTS, Python 3.12.3 and R 4.4.1.

## Usage

You can run most scripts directly with shell command. For shell script: `bash ScriptName.sh`; for python script: `python3 ScriptName.py`. Some may need (alternative or compulsory) user input, for example, `python3 ScriptName.py argv1 argv2 ...`.

### Project structure

The `code` directory includes all code and scripts. The `data` directory contains neccessary data to run the code. Results will automatically generate in the `results` directory when the assessment script runs.

### Dependencies

On Linux, you may install LaTex and R by running bash command: 
```bash
sudo apt install texlive-latex-extra
```
```bash
sudo apt install r-base
```
If you want to install Python modules by package manager `pip`, you can install `pip` with: 
```bash
sudo apt-get install python3-pip
```
Or you can install Python modules on local system: 
```bash
sudo apt install python3-<module_name>
```
For detailed installation instructions on different systems, see https://imperial-fons-computing.github.io/.

Other specific requirements are in each week's `README` file.

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk