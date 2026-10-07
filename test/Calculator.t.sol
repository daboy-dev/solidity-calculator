// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {Test} from "forge-std/Test.sol";
import {Calculator, DivisionByZero} from "../src/Calculator.sol";

contract CalculatorTest is Test {
    Calculator calculator;
    uint256 firstResult = 17;

    function setUp() public {
        calculator = new Calculator(firstResult);
    }

    function testCheckFirstResult() public view {
        uint256 calculatorResult = calculator.result();
        assertEq(firstResult, calculatorResult);
    }

    function testAdd() public {
        uint256 numA = 1;
        uint256 numB = 81;
        uint256 addResult = calculator.add(numA, numB);

        assertEq(addResult, 82);
        assertEq(calculator.result(), 82);
    }

    function testSubtract() public {
        uint256 numA = 21;
        uint256 numB = 4;
        uint256 subtractResult = calculator.subtract(numA, numB);

        assertEq(subtractResult, 17);
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

    function testFuzzDivide(uint256 numA, uint256 numB) public {
        vm.assume(numB != 0);

        uint256 divideResult = calculator.divide(numA, numB);

        assertEq(divideResult, numA / numB);
        assertEq(calculator.result(), divideResult);
    }

    function testFuzzDivideByZeroReverts(uint256 numA) public {
        vm.expectRevert(abi.encodeWithSelector(DivisionByZero.selector, numA, 0));
        calculator.divide(numA, 0);
    }

    function testAddOverflowReverts() public {
        vm.expectRevert();
        calculator.add(type(uint256).max, 5);
    }

    function testSubtractUnderflowReverts() public {
        vm.expectRevert();
        calculator.subtract(1, 2);
    }

    function testMultiplyOverflowReverts() public {
        vm.expectRevert();
        calculator.multiply(type(uint256).max, 2);
    }

    event Addition(uint256 numA, uint256 numB, uint256 result_);

    function testAddEmitsEvents() public {
        vm.expectEmit(false, false, false, true);

        emit Addition(7, 3, 10);
        calculator.add(7, 3);
    }

    event Subtraction(uint256 numA, uint256 numB, uint256 result_);

    function testSubtractEmitsEvents() public {
        vm.expectEmit(false, false, false, true);

        emit Subtraction(25, 5, 20);
        calculator.subtract(25, 5);
    }

    event Multiplication(uint256 numA, uint256 numB, uint256 result_);

    function testMultiplyEmitsEvents() public {
        vm.expectEmit(false, false, false, true);

        emit Multiplication(5, 2, 10);
        calculator.multiply(5, 2);
    }

    event Division(uint256 numA, uint256 numB, uint256 result_);

    function testDivideEmitsEvents() public {
        vm.expectEmit(false, false, false, true);

        emit Division(35, 5, 7);
        calculator.divide(35, 5);
    }
}
