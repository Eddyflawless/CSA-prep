## Commands
-   aws ssm get-parameters --names /my-app/dev/db-url /my-app/dev/db-password  > output.txt
-   aws ssm get-parameters --names /my-app/dev/db-url /my-app/dev/db-password  --with-decryption >  output.txt

## Get all parameters by path
-   aws ssm get-parameters-by-path --path /my-app/dev/
-   aws ssm get-parameters-by-path --path /my-app/ --recursive --with-decryption > output.txt

