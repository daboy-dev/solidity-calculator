# Solidity Calculator

[![CI](https://github.com/daboy-dev/solidity-calculator/actions/workflows/test.yml/badge.svg)](https://github.com/daboy-dev/solidity-calculator/actions/workflows/test.yml)

A simple on-chain calculator written in Solidity and tested with [Foundry](https://book.getfoundry.sh/). It is a learning project focused on writing clean contracts and a solid test suite, rather than on complex logic.

## Overview

`Calculator` stores the result of the last operation and exposes four functions that operate on `uint256` values:

| Function                    | Description                | Reverts when                       |
| --------------------------- | -------------------------- | ---------------------------------- |
| `add(numA, numB)`           | Returns `numA + numB`      | The result overflows               |
| `subtract(numA, numB)`      | Returns `numA - numB`      | `numB > numA` (underflow)          |
| `multiply(numA, numB)`      | Returns `numA * numB`      | The result overflows               |
| `divide(numA, numB)`        | Returns `numA / numB`      | `numB == 0` (`DivisionByZero`)     |

Every operation:

- Updates the public `result` variable.
- Emits an event (`Addition`, `Subtraction`, `Multiplication` or `Division`) with both operands and the result.

Notes:

- Division is integer division, so the result is rounded down (`7 / 2 == 3`).

## Tests

The suite in [`test/Calculator.t.sol`](test/Calculator.t.sol) covers:

- The initial result set by the constructor.
- The return value and the updated `result` for each operation.
- Event emission for each operation, using `vm.expectEmit`.
- Reverts on overflow (`add`, `multiply`), underflow (`subtract`) and division by zero.
- Fuzz tests for `divide`, for both valid inputs and a zero divisor.

Line, statement, branch and function coverage is 100%.

## Getting started

Requirements: [Foundry](https://book.getfoundry.sh/getting-started/installation).

```shell
git clone --recurse-submodules https://github.com/daboy-dev/solidity-calculator.git
cd solidity-calculator
```

If you already cloned the repository without submodules, run `git submodule update --init --recursive`.

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Coverage

```shell
forge coverage
```

### Format

```shell
forge fmt
```

## Continuous integration

GitHub Actions runs `forge fmt --check`, `forge build` and `forge test` on every push and pull request.

## License

MIT
