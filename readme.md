This repository contains the scripts for our submission to track 4 of
iDASH 2019. See [our note](https://eprint.iacr.org/2019/1246) for
details.

### Building the docker container

Dockerfile expects MP-SPDZ in the `src` directory as well as
`replicated-ring-party.x` being compiled in said directory. You can
either clone MP-SPDZ into `src` or fetch the compiled version from
GitHub:

``` ./get-mp-spdz.sh ```

Then build the container using

``` docker build . ```

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

#### Docker setup

Run

```docker run -it -p <ssh port>:2222 <vm port>:<vm port> mp-idash```

on every host. This should ensure that all necessary ports are
forwarded correctly and that that the SSH server is started (via
`.bashrc`). Add `-d` to the options to run without active TTY (for
example via SSH). Note that <ssh port> and <vm port> have to the same
and available on all hosts.

#### Training

On <host0>, run

```./train-remote.sh <host0> <host1> <host2> <vm port> <ssh port> <negative> <positive>```

where `<negative>` and `<positive>` are text files containing the
data, either split by comma or by tab. Furthermore, both files are
expected to have a title row and column.

The script requires that all hosts run an SSH server on <ssh port> and
that <vm port> is open. If running with docker the ports have to the
same as above.

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

```./predict-remote.sh <host0> <host1> <host2> <vm port> <ssh port> <data>```

where `<data>` contains the input data in the same format as above.
This will only work after running the training with `train-remote.sh`,
and it also requires SSH and open ports as above.

This will run a secure computation as for training and output the result as

```predictions: <result>```

where `<result>` is a string of 0s and 1s.

### Computing the accuracy

We have used `regression.mpc` as provided with MP-SPDZ 0.1.2 for our
figures. You can compile it as follows in the root directory of
MP-SPDZ:

```./compile.py -DR 64 regression <n_epochs> <n_threads> [opts]```

where `<n_epochs>` stands of the number of epochs and `<n_threads>`
stands for the number of threads being used. Further options are:
- `bc` for the BC-TCGA dataset (default is GSE2034)
- `nearest` for nearest rounding (default is probabilistic truncation)
- `tol=<x>` to stop when the loss is below `x` (default is fixed
number of epochs)

`regression.mpc` processes inputs differently than the above
programs. It expects first the labels for all examples, then every
feature for all examples, all through player 0. In other words,
`Player-Data/Input-P0-0` should contain a whitespace-separated table
where first row is for labels and the further rows are the features.

Note that the program computes a non-standard aggreated accuracy
measure, but you can compute any accuracy measure using the two `a/b`
outputs on lines starting with `test_acc:` (negative first).
