# Client CLI Application

A command-line Ruby application that allows you to:

- Search for clients by partial name match
- Find clients with duplicate emails

---

## Setup

1. **Clone the repository** (if applicable):

   ```bash
   git clone git@github.com:esotericK18/client_directory.git
   cd client_directory
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Make the CLI executable**:

   ```bash
   chmod +x bin/client
   ```

4. **Ensure `clients.json` is present** in the root directory (or provide your own).

5. (optional) Add project bin/ to your PATH (temporary for session)

   ```bash
   export PATH="$PATH:/client_directory/bin"
   ```

---

## Usage

### Search for clients by name

```bash
./bin/client search John
```

or When you add bin to PATH

```bash
client search John
```

### Find duplicate emails

```bash
./bin/client duplicates
```

or When you add bin to PATH

```bash
client duplicates
```

---

## 🧪 Running Tests

```bash
rspec
```

---

## Assumptions & Design Decisions

- JSON is expected to be an array of objects with: `id`, `full_name`, and `email` same as the provided json file
- Initially create the core logic on single file then proceed to implementing repository pattern and adjust project structure for ease of script execution
- Logic is split into repository and services for modularity and testability

---

## Known Limitations

- Search limited to name field: Cannot search other fields like email or ID without code changes.
- No input validation: Assumes well-formed JSON input.
- All clients are loaded into memory

---

## Future Improvements and Know limitations

- Dynamic field search
- Full CRUD implementation
- Replace file-based storage with a database
- Convert to REST API using Rails
- Add validations and error messages for malformed data
