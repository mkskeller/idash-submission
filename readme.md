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
