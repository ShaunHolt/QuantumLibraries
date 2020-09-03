// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Arrays {

    /// # Summary
    /// Combines Mapped and Fold into a single function
    ///
    /// # Description
    /// This function iterates the `folder` function through the array, starting from
    /// an initial state `state` and returns all intermediate values, not including
    /// the inital state.
    ///
    /// # Type Parameters
    /// ## 'State
    /// The type of states the `folder` function operates on, i.e., accepts as its first
    /// argument and returns.
    /// ## 'T
    /// The type of `array` elements.
    ///
    /// # Input
    /// ## folder
    /// A function to be folded over the array
    ///
    /// ## state
    /// The initial state of the folder
    ///
    /// ## array
    /// An array of values to be folded over
    ///
    /// # Output
    /// All intermediate states, including the final state, but not the initial state.
    /// The length of the output array is of the same length as `array`.
    ///
    /// # Remark
    /// This function generalizes `Fold` since
    /// `Tail(CumulativeFolded(folder, state, array)) == Fold(folder, state, array)`.
    ///
    /// # Example
    /// ```Q#
    /// // same as sums = [1, 3, 6, 10, 15]
    /// let sums = CumulativeFolded(PlusI, 0, SequenceI(1, 5));
    /// ```
    function CumulativeFolded<'State, 'T>(folder : (('State, 'T) -> 'State), state : 'State, array : 'T[]) : 'State[] {
        mutable current = state;
        mutable result = new 'State[Length(array)];

        for ((i, elem) in Enumerated(array)) {
            set current = folder(current, elem);
            set result w/= i <- current;
        }

        return result;
    }
}
