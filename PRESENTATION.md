# This document is required.

Initial Plan
 - start off with brief introduction regarding history of Hill Cipher (when it was invented)
 - describe what it is and mention the vulnerabilities
 - demonstrate the math
 - show an example with the code (image encryption)

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
 - Vulnerabilities: brute force attacks, known plaintext attackw
   - Brute force attacks can be countered by having a long key and large block sizes
   - Plaintext attacks will only work if attacker has access to both plaintext and ciphertext
