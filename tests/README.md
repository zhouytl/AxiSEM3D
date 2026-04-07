# Integration Tests

CTest discovers integration cases from immediate subdirectories of `tests/`.

Each runnable case must contain:

- `input/`: the input directory passed to `axisem3d --input`
- `reference/`: expected outputs to compare against the generated `output/` tree
- `screen-output`: expected console output after normalization
- `config.txt`: contains test options (currently empty)

Note:
- Relative paths under `reference/` mirror the generated `output/` directory.
