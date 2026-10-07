// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {Test} from "forge-std/Test.sol";
import {Calculator, DivisionByZero} from "../src/Calculator.sol";

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
        uint256 numA = 1;
        uint256 numB = 81;
        uint256 addResult = calculator.add(numA, numB);

        assertEq(addResult, 82);
        assertEq(calculator.result(), 82);
    }

    function testSubstract() public {
        uint256 numA = 21;
        uint256 numB = 4;
        uint256 substractResult = calculator.substract(numA, numB);

        assertEq(substractResult, 17);
        assertEq(calculator.result(), 17);
    }

    function testMultiply() public {
        uint256 numA = 51;
        uint256 numB = 6;
        uint256 multiplyResult = calculator.multiply(numA, numB);

        assertEq(multiplyResult, 306);
        assertEq(calculator.result(), 306);
    }

    function testDivide() public {
        uint256 numA = 20;
        uint256 numB = 4;
        uint256 divideResult = calculator.divide(numA, numB);

        assertEq(divideResult, 5);
        assertEq(calculator.result(), 5);
    }

    function testCanNotMultiplyLargeNumbers() public {
        uint256 numA = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        uint256 numB = 2;

        vm.expectRevert();
        calculator.multiply(numA, numB);
    }

    function testFuzzDivide(uint256 numA, uint256 numB) public {
        vm.assume(numB != 0);

        uint256 res = calculator.divide(numA, numB);

        assertEq(res, numA / numB);
        assertEq(calculator.result(), res);
    }
}