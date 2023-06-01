# Hill Cipher

## General Notes
 - Invented by Lester S. Hill in 1929
   - it was the first polygraphic cipher in which it was practical (though barely) to operate on more than three symbols at once
 - Hill Cipher follows a polygraphic substitution cipher, which means there is uniform substitution across multiple levels of blocks
 - More mathematical cipher compared to other ciphers: based on linear algebra, heavily relies on the sophisticated use of matrices
   - Mostly matrix multiplication and matrix inverses
 - Hill Cipher is a block cipher
   - encryption method that implements a deterministic algorithm with a symmetric key to encrypt a block of text
     - in this case, the deteriministic algorithm refers to the linear algebra the cipher utilizes
   - doesn’t need to encrypt one bit at a time like in stream ciphers
 - Hill Cipher is digraphic in nature
   - capable of expanding to multiply any size of letters to add more complexity and reliability for better use
 - Advantages: is immune to letter frequency analysis
 - Vulnerabilities: brute force attacks, known plaintext attackw
   - Brute force attacks can be countered by having a long key and large block sizes
   - Plaintext attacks will only work if attacker has access to both plaintext and ciphertext

## How it Works
 - Each letter is represented by a number modulo 26 (usually 0-25)
 ### Encrypting
 - To encrypt a message, each block of n letters is multiplied by an invertible n × n matrix, against modulus 26
   - For matrix multiplication, the number of columns in the first matrix must be equal to the number of rows in the second matrix
   - The matrix used for encryption is the cipher key, and it should be chosen randomly from the set of invertible n × n matrices (modulo 26)
   - The text being encrypted should be written as a vector (a matrix with one column and n rows)
 ### Decrypting
 - To decrypt the message, each block is multiplied by the inverse of the matrix used for encryption
   - The text being decrypted should be written as a vector (a matrix with one column and n rows)  
 - If the message is longer than n letters, break it up into matrices, each with n letters
   - Run the same encryption or decryption process on each new matrix, and then join the results together
   - Try to ensure that the message's length is a multiple of n, it'll make it easier

## Image Encryption/Decryption
 - Imagine each pixel of an image as a "message" of three length
 - This "message" isn't of letters, but rather of the RGB values of the pixel
 - This allows you to use a 3x3 matrix key to encode each individual pixel for a new, encoded image
