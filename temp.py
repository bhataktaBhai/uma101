import subprocess
import re

ls_output = subprocess.check_output(["ls"]).decode()
for i in range(1, 2):
    file_name = f"lecture{i:02}.tex"
    file = open(file_name, "w")
    file_contents = subprocess.check_output(["cat", file_name])
    if file_name in ls_output and f"% {file_name}" not in file_contents.decode():
        cmd = f"""sed -i '' '1i\\
                % {file_name}' {file_name}"""
        subprocess.call(cmd, universal_newlines=True, shell=True)

        #print(subprocess.run(["sed", "-i", "''", "'1i\\\n% " + file_name + "'", file_name]).check_returncode())

        # subprocess.run(["echo", "%", file_name], stdout=file)
        # subprocess.run(["echo"], stdout=file)
        # subprocess.run(["echo", file_contents], stdout=file)

