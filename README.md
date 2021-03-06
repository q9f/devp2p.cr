# devp2p.cr

[![Build Status](https://img.shields.io/github/workflow/status/q9f/devp2p.cr/Nightly)](https://github.com/q9f/devp2p.cr/actions)
[![Language](https://img.shields.io/github/languages/top/q9f/devp2p.cr?color=black)](https://github.com/q9f/devp2p.cr/search?l=crystal)
[![License](https://img.shields.io/github/license/q9f/devp2p.cr.svg?color=black)](LICENSE)

a native library implementing `devp2p` purely for the crystal language. `devp2p` is the underlying networking protocol built for and used by ethereum.

track initial library release progress: [#1](https://github.com/q9f/devp2p.cr/issues/1)

# installation

add the `devp2p` library to your `shard.yml`

```yaml
dependencies:
  secp256k1:
    github: q9f/devp2p.cr
    version: "~> 0.1"
```

# testing

the library is entirely specified through tests in `./spec`; run:

```bash
crystal spec --verbose
```

# contribute

create a pull request, and make sure tests and linter passes.

license: apache license v2.0

contributors: [**@q9f**](https://github.com/q9f/)