# CMEE Week1 Coursework

This directory contains the in-class practices and practicals for biological computating bootcamp week1. The content covers Unix/Linux, Shell scripting, and Scienific documents with LaTeX. All teaching materials and practical questions are on https://themulquabio.github.io/TMQB/intro.html.

All code was written and tested in the bash terminal on Ubuntu 24.04.1 LTS.

## Usage

---

### Running the scripts

- **Bash commands:**
Five UNIX shell commands are stored in `UnixPrac1.txt`. You need to copy each command and paste it onto the terminal to run it.

- **Shell scripts:**
You can run all shell scripts(*.sh) directly from the bash terminal:

```bash
bash ScriptName.sh
```

- **LaTex:**
To generate a PDF output from the LaTex file(`FirstExample.tex`), run the following in a terminal:

```bash
 pdflatex FirstExample.tex
 bibtex FirstExample
 pdflatex FirstExample.tex
 pdflatex FirstExample.tex
 ```

 This should produce a file `FirstExample.pdf` in the `code` directory.

---

### Project structure

- `code/`: Contains command lines for Unix practical 1 (`Unixprac1.txt`), shell scripts practices (*.sh) and LaTex example (`FirstExample.tex` and `Firstbiblio.bib`). 

- `data/`: Contains a text file for testing `grep` command and FASTA data for running commands from `Unixprac1.txt`.

---

### Dependencies

Ensure LaTex and ImageMagick are installed on your device. To install them from bash, use the following command:

- **LaTex:**
```bash
sudo apt install texlive-latex-extra
```

- **ImageMagick:**
```bash
sudo apt install imagemagick
```

---

## Author
Laiyin Zhou
l.zhou24@imperial.ac.uk
