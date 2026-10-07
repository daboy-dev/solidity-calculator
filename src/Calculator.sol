// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

error DivisionByZero(uint256 numA, uint256 numB);

contract Calculator {
    uint256 public result;

    event Addition(uint256 numA, uint256 numB, uint256 result_);
    event Subtraction(uint256 numA, uint256 numB, uint256 result_);
    event Multiplication(uint256 numA, uint256 numB, uint256 result_);
    event Division(uint256 numA, uint256 numB, uint256 result_);

    constructor(uint256 firstResult_) {
        result = firstResult_;
    }

    function add(uint256 numA, uint256 numB) external returns (uint256 result_) {
        result_ = numA + numB;
        result = result_;

        emit Addition(numA, numB, result_);
    }

    function subtract(uint256 numA, uint256 numB) external returns (uint256 result_) {
        result_ = numA - numB;
        result = result_;

        emit Subtraction(numA, numB, result_);
    }

    function multiply(uint256 numA, uint256 numB) external returns (uint256 result_) {
        result_ = numA * numB;
        result = result_;

        emit Multiplication(numA, numB, result_);
    }

    function divide(uint256 numA, uint256 numB) external returns (uint256 result_) {
        if (numB == 0) {
            revert DivisionByZero(numA, numB);
        }

        result_ = numA / numB;
        result = result_;

        emit Division(numA, numB, result_);
    }
}
