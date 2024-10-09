// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {RemoveElementFromArray} from "../src/RemoveElementFromArray.sol";

contract RemoveElementFromArrayTest is Test {
    RemoveElementFromArray public removeElementFromArray;
    uint256 originalLength = 7;
    uint256[] incomingArray = new uint256[](originalLength);

    function setUp() public {
        removeElementFromArray = new RemoveElementFromArray();
        incomingArray[0] = 1;
        incomingArray[1] = 5;
        incomingArray[2] = 4;
        incomingArray[3] = 7;
        incomingArray[4] = 9;
        incomingArray[5] = 3;
        incomingArray[6] = 2;
        removeElementFromArray.setArray(incomingArray);
    }

    function test_remove_from_middle() public {
        uint256 positionToRemove = 2;

        // fire
        removeElementFromArray.remove(positionToRemove);

        // test expectations
        check_expectation_for_successful_removal(positionToRemove);
    }

    function test_remove_last_element() public {
        uint256 positionToRemove = 6;

        // fire
        removeElementFromArray.remove(positionToRemove);

        // test expectations

        check_expectation_for_successful_removal(positionToRemove);
    }

    function test_remove_first_element() public {
        uint256 positionToRemove = 0;

        // fire
        removeElementFromArray.remove(positionToRemove);

        // test expectations
        check_expectation_for_successful_removal(positionToRemove);
    }

    function test_remove_out_of_bounds_element() public {
        uint256 positionToRemove = 7;

        // fire
        vm.expectRevert(
            abi.encodeWithSelector(
                RemoveElementFromArray.PositionToRemoveOutOfBounds.selector,
                positionToRemove,
                incomingArray.length - 1
            )
        );

        removeElementFromArray.remove(positionToRemove);
    }

    // --------------------- INTERNALs ----------------------

    function check_expectation_for_successful_removal(
        uint256 positionToRemove
    ) internal view {
        uint256[] memory result = removeElementFromArray.getArray();

        for (uint256 i = 0; i < result.length; i++) {
            if (i == positionToRemove) {
                assertEq(result[i], incomingArray[incomingArray.length - 1]);
            } else {
                assertEq(result[i], incomingArray[i]);
            }
        }

        assertEq(result.length, originalLength - 1);
    }
}
