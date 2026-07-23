# Turing Machine

A simple Turing machine simulator written in Haskell.

## Build
```
cabal build
```

## Run
To run a Turing machine, you need a file that describes the machine. See the `examples` directory for examples.
```
cabal run turingmachine -- <path-to-machine-file>
```

## Project Structure
```
.
├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── README.md
├── turingmachine.cabal
├── app
│   └── Main.hs
├── examples
│   ├── counter.tm
│   └── increment.tm
└── src
    └── Turing
        ├── Machine.hs
        ├── Parser.hs
        ├── Pretty.hs
        └── Types.hs
```