# This script checks for the presence of iso2mesh backend executables in the system PATH.
import shutil
import sys

print("Python:", sys.version)
print()

tools = [
    "tetgen",
    "meshfix",
    "cork",
    "cgalmesh"
]

print("Checking iso2mesh backend executables:\n")

for tool in tools:
    path = shutil.which(tool)

    if path:
        print(f"[OK] {tool} found at:")
        print(f"     {path}\n")
    else:
        print(f"[MISSING] {tool} not found in PATH\n")

print("Done.")