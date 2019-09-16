The model is a linear regression, that is, a dense layer followed by
sigmoid.

### Local executution

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
`src/Player-Data/Input-P0-0`), after which all computation is entirely
secret.

#### Prediction

Run

```./predict.sh <data>```

where `<data>` contains the input data in the same format as above.
This will only work after running the training as above.

This will also run a secure computation and output the result as

```predictions: <result>```

where `<result>` is a string of 0s and 1s.

### Remote executution

#### Training

Run

```./train-remote.sh <host0> <host1> <host2> <negative> <positive>```

where `<negative>` and `<positive>` are text files containing the
data, either split by comma or by tab. Furthermore, both files are
expected to have a title row and column.

The script requires that all hosts run an SSH server and that the
ports 5000-5003 are open.

The script will prepare an optimized program for the virtual machines
depending on the size of the data if such a program isn't present
yet. This optimized program is distributed by rsync together with the
SSL certificates. Then it runs three virtual machines
(`replicated-ring-party.x`) that execute the actual computation
between them.

For simplicity, the data is all input via the first party (through
`src/Player-Data/Input-P0-0`), after which all computation is entirely
secret.

#### Prediction

Run

```./predict-remote.sh <host0> <host1> <host2> <data>```

where `<data>` contains the input data in the same format as above.
This will only work after running the training with `train-remote.sh`,
and it also requires SSH and open ports as above.

This will run a secure computation as for training and output the result as

```predictions: <result>```

where `<result>` is a string of 0s and 1s.
