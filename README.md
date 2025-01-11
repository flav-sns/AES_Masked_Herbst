# AES Protection Against Side-Channel Attacks

This repository contains an implementation of AES (Advanced Encryption Standard) with protection mechanisms against side-channel attacks such as Template Attacks, Correlation Power Analysis (CPA), and Differential Power Analysis (DPA). The implemented masking technique is based on Herbst's masking scheme, offering enhanced security against these types of attacks.

## Features

- **AES Implementation**: Includes both standard AES and a masked version of AES.
- **Masking for Protection**: Uses Herbst's masking method to prevent side-channel attacks.
- **Random Mask Generation**:
  - **Robust Mode**: Uses OpenSSL's cryptographically secure random number generator.
  - **Lightweight Mode**: Uses standard C library's `rand()` function.

## Prerequisites

Ensure that the following are installed on your system:

- GCC (GNU Compiler Collection)
- OpenSSL library for robust random generation

## How to Use

./run.sh
