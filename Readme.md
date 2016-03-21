# Robot Movement Simulator

A simple robot movement simulator that parses commands from a file and moves the
robot around a 5 x 5 board.

## Environment

Tested with ruby-2.3. It should however work on most versions of ruby.

## Installation

```bash
git clone https://github.com/bibstha/robot_movement
cd robot_movement
bundle install
```

Most of the tests are written on Minitest. They are found inside the `test`
folder. The rest of the code are inside `lib/robot_movement` folder.

## Usage

```bash
bin/robot_move /path/to/command_file
bin/robot_move test/examples/1.txt
bin/robot_move test/examples/2.txt
```

Two example command scripts have been included in the `test/examples` folder.

## Executing tests

```bash
rake test
```

It uses `Rake::TestTask` to execute the tests.

## Overview

The application takes in following commands: `PLACE`, `LEFT`, `RIGHT`, `MOVE`
and `REPORT`.

* `PLACE x,y,direction` - places the robot in the (x,y) coordinate facing one of
the directions: east, west, north and south. The board is of 5 x 5 size starting
at (0, 0) at the bottom left. North is facing the positive y axis.
* `LEFT` rotates the robot 90deg counter clock-wise direction.
* `RIGHT` rotates the robot 90deg clock-wise direction.
* `MOVE` moves the robot one coordinate to the direction it is facing.
* `REPORT` prints the current location of the robot on the board.

The conditions for moving the robots are as follows:

* The simulation begins with a valid `PLACE` command. Parameters x and y have to
be within `[0,4]` inclusive. Any commands before a valid `PLACE` command are
discarded.
* `MOVE` command only moves the robot if it does go beyond the borders of the
board.


