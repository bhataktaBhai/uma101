import re
import subprocess

def extract_theorems(file_contents):
    theorem_env = ['thm', 'axiom', 'defn', 'lem', 'cor', 'prop'] #, 'rem', 'example']
    theorem_regex = '(?:' + ')|(?:'.join(theorem_env) + ')'
    pattern = re.compile(f'((?:\\\\begin{{({theorem_regex})}}.*?\\\\end{{\\2}})|(?:\\\\(?:sub)*section{{.*?}}))', re.DOTALL)
    return (match[0] for match in re.findall(pattern, file_contents))

file_contents = ''
list_of_files = subprocess.check_output(['ls']).decode()
for i in range(1, 99):
    if f'lecture{i:02}.tex' in list_of_files:
        file_contents += subprocess.check_output(['cat', f'lecture{i:02}.tex']).decode()

print(r'''\documentclass[12pt]{article}
\input{preamble}

\title{UM101: Short Notes}
\author{Naman Mishra}

\begin{document}
\maketitle
''')

for theorem in extract_theorems(file_contents):
    print(theorem)
    print()

print(r'''\end{document}
''')

