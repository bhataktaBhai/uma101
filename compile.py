import subprocess

args = [f'lecture{i:02}.tex' for i in range(1, 99) if f'lecture{i:02}.tex' in subprocess.check_output(['ls']).decode()]
print(args)

print(r'''\documentclass[12pt]{article}
\input{preamble}

\title{UM101: Analysis \& Linear Algebra}
\author{Naman Mishra}
\date{Fall 2022}

\begin{document}
\maketitle
\tableofcontents
''')

print(subprocess.check_output(['cat'] + args).decode())

print(r'\end{document}')

