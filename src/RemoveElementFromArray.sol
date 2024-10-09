// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

contract RemoveElementFromArray {
    uint256[] _array;

    error PositionToRemoveOutOfBounds(uint256 position, uint256 maxAllowed);

    function setArray(uint256[] calldata _incomingArray) external {
        _array = _incomingArray;
    }

    function remove(uint256 _positionToRemove) external {
        if (_positionToRemove >= _array.length) {
            revert PositionToRemoveOutOfBounds(
                _positionToRemove,
                _array.length - 1
            );
        }

        _array[_positionToRemove] = _array[_array.length - 1];
        _array.pop();
    }

    function getArray() external view returns (uint256[] memory) {
        return _array;
    }
}
