# Robot Movement Simulator

A simple robot movement simulator that parses commands from a file and moves the
robot around a 5 x 5 board.

## Environment

Tested with ruby-2.3. It should however work on most ruby versions

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

* `PLACE x,y,direction` - places the robot in the `(x,y)` coordinate facing one of
the directions: east, west, north or south. The board is of 5 x 5 size starting
at (0, 0) at the bottom left. North is facing the positive y axis.
* `LEFT` rotates the robot 90 deg counter clock-wise direction.
* `RIGHT` rotates the robot 90 deg clock-wise direction.
* `MOVE` moves the robot one coordinate to the direction it is facing.
* `REPORT` prints the current location of the robot on the board.

The conditions for moving the robots are as follows:

* The simulation begins with a valid `PLACE` command. Parameters x and y have to
be within `[0,4]` inclusive. Any commands before a valid `PLACE` command are
ignored.
* `MOVE` command only moves the robot if it does go beyond the borders of the
board.

Here is an example of a valid command file.

```
PLACE 1,0,NORTH
MOVE
MOVE
RIGHT
MOVE
REPORT
```

Saving it to `/tmp/robo_commands.txt` and executing `bin/robo_move
/tmp/robo_commands.txt` will result in following output.


```
2,2,EAST
```

### Explanation

The robots moved through the following states.

```
1,0 -> start
1,1 -> moved north
1,2 -> moved north
1,2 -> turn east
2,2 -> move east

The final state: 2,2,EAST
```

## Design

1 `app/robo_move -> lib/robo_movement/cli.rb`

This is the entry point to the application. `robo_move` is an executable that
loads and calls the cli file.

The `cli.rb` file is the main controller of the application. It does the
following:

1. Create an empty game state.
2. Parse each line of the file and convert it to a `Command` object.
3. Execute all `Command`s against the `state`. The `state` gets changed
according to the commands.

2 `lib/robo_movement/game_state.rb`

This file is responsible only for storing the coordinates x, y, direction and
  is_active values. It performs no validation.

3 `lib/robo_movement/*_command.rb`

Each of the five commands are represented by their individual classes:
  `PlaceCommand`, `LeftCommand`, `RightCommand`, `MoveCommand` and
  `ReportCommand`.

The Command files are the boundary classes for the application. They

1. Take and store the input
2. Validate input
3. Execute their core logic and modify the state according to the given state.

4 `lib/robo_movement/command_factory`

Implements the `FactoryPattern`. It

1. Takes a line of string as command
2. Identifies the appropriate `Command class`
3. Instantiates the class and passes the arguments
4. Returns the object

## Thought process

In the application, I want it to behave like a `state machine`. The current
state of the game is saved in `GameState`. It contains no logic what so ever.

All logic of the rules of the game are encapsulated inside the commands. This is
where validation and state changes occur.

All `commands` could have a common Ancestor (Inheritence). However, all the
commands follow the pattern: their constructor arguments are in line with their
real arguments as string. They all have a `run` method that takes a `state` and
operates on the state.

To add new command, one needs to simply add it the `lib/robot_movement` folder
and will be loaded by the `CommandFactory`.

## License

All code is distributed under the MIT License.

## About Bibek Shrestha

[Bibek Shrestha](http://www.bibekshrestha.com) is a Nepal born, Austria based 
Software Engineer who loves to program in Ruby. He is always interested in
creative projects. When he is not programming, you can find him hiking and
running in the Austrian mountains.

Looking for a Ruby Programmer? Contact [bibekshrestha@gmail.com](bibekshrestha@gmail.com)
