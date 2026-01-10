**Windows Comands Used are:**

packer.exe validate --var-file packer-vars.json packer.json


packer.exe inspect --var-file packer-vars.json packer.json


packer.exe build --var-file packer-vars.json packer.json

Command to Debug packer build:

PACKER_LOG=1 packer build -var-file=packer-vars.json packer.json
