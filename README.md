packer.exe validate --var-file=packer.auto.pkrvars.hcl packer.pkr.hcl

packer.exe inspect --var-file=packer.auto.pkrvars.hcl packer.pkr.hcl

packer.exe build --var-file=packer.auto.pkrvars.hcl packer.pkr.hcl

Steps Followed:
- Create lambda role
- Create lambda function and paste the code 
- create cloud trail rule
- create event bridge rule 
