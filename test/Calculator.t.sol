// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {Test} from "forge-std/Test.sol";
import {Calculator} from "../src/Calculator.sol";

contract CalculatorTest is Test {
    Calculator calculator;
    uint256 firstResult = 0;

    function setUp() public {
        calculator = new Calculator(firstResult);
    }

    function testCheckFirstResult() public view {
        uint256 calculatorResult = calculator.result();
        assert(firstResult == calculatorResult);
    }

    function testAdd() public {
        uint256 numA = 5;
        uint256 numB = 5;
        uint256 addResult = calculator.add(numA, numB);

        assert(addResult == numA + numB);
    }

    function testSubstract() public {
        uint256 numA = 5;
        uint256 numB = 5;
        uint256 addResult = calculator.substract(numA, numB);

        assert(addResult == numA - numB);
    }

    function testMultiply() public {
        uint256 numA = 5;
        uint256 numB = 5;
        uint256 addResult = calculator.multiply(numA, numB);

        assert(addResult == numA * numB);
    }

    function testDivide() public {
        uint256 numA = 5;
        uint256 numB = 5;
        uint256 addResult = calculator.divide(numA, numB);

        assert(addResult == numA / numB);
    }

    function testCanNotMultiplyLargeNumbers() public {
        uint256 numA = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        uint256 numB = 2;

        vm.expectRevert();
        calculator.multiply(numA, numB);
    }

    function testDivideRandomNumbers(uint256 numA, uint256 numB) public {
        calculator.divide(numA, numB);
    }
}