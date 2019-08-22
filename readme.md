#### Training

Run

```./train.sh <negative> <positive>```

where `<negative>` and `<positive>` are text files containing the
data, either split by comma or by tab. Furthermore, both files are
expected to have a title row and column.

The script will prepare an optimized program for the virtual machines
depending on the size of the data if such a program isn't present
yet. Then it runs three virtual machines (`replicated-ring-party.x`)
that execute the actual computation between them.

For simplicity, the data is all input via the first party (through
`src/Player-Data/Input-P0-0`).

#### Prediction

Run

```./train.sh <data>```

where `<data>` contains the input data in the same format as above.

This will also run a secure computation and output the result as

```prediction: <result>```

where `<result>` is a string of 0s and 1s.
