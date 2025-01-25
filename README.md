# Installation

Install the latest  [SWI-Prolog](http://www.swi-prolog.org) _development
version_.

# Running Web Prolog

```bash
git clone https://github.com/tranlynhathao/prolog_test_web.git
cd prolog_test_web
swipl run.pl
```

# Steps for the Server to Use the `passwd` File

#### **Create the `passwd` File**

   The `passwd` file should contain entries in the following format:

   ```
   username:hashed_password
   ```

- `username` is the name of the user (e.g., `admin`).
- `hashed_password` is the password hashed using a secure hash function, typically MD5 or SHA-256.

   Example:

   ```
   admin:$1$randomsalt$abcdef1234567890abcdef1234567890
   ```

   You can use tools like `openssl` to generate hashed passwords:

   ```bash
   openssl passwd -apr1
   ```

   Enter the desired password, and it will generate a hash.

#### How to Update

- Use `htpasswd` (if available):

  ```bash
  htpasswd -c passwd admin
  ```

  The above command will create a new `passwd` file with the username `admin` and prompt you to enter a password.

- If `htpasswd` is not available, you can manually hash the password. For example, to create a hash for the password `1234`:

  ```prolog
  ?- use_module(library(crypto)).
  ?- crypto_password_hash('1234', Hash), writeln(Hash).
  ```

  Then add it to the `passwd` file:

  ```
  admin:$pbkdf2-sha256$... (the generated hash)
  ```

#### Verification

- Ensure the `passwd` file is in the correct location (e.g., the same directory as `server.pl` or provide the absolute path).

# Check List

- [ ] Prepare documentation for Prolog logic
- [ ] Add pages to the website
- [ ] Adjust the navbar for the documentation
