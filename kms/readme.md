
## Encryption
aws kms encrypt --key-id alias/tutorial --plaintext fileb://ExampleSecretFile.txt \
--output text --query CiphertextBlob --region eu-west-2 > ExampleSecretFileEncrypted.base64

## base64 decode for Linux or Mac OS
cat ExampleSecretFileEncrypted.base64 | base64 --decode > ExampleSecretFileEncrypted

## decryption
aws kms decrypt --ciphertext-blob fileb://ExampleSecretFileEncrypted --output text --query Plaintext > \
ExampleSecretFileEncrypted.base64 --region eu-west-2

## base64 decode for Linux or Mac OS
cat ExampleSecretFileEncrypted.base64 | base64 --decode > ExampleFileDecrypted.txt