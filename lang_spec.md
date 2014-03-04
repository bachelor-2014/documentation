#Experiment Language Specification for Splotbot (DRAFT 1)
Firstly my intention with this "language" is to simply generate instructions at
runtime, it can be viewed as a basic scripting language. The language is based
around the concepts we have discussed up until this point. I will focus on two
core concepts that will be essential for this to work:

1. Calling component actions with parameters
2. Being able to handle component events

Other than that some useful features would be:

1. Integer calculations
2. Variables and reading parameters from users
3. Flow control structures

##Calling components
Calling of components is essential as it is the core functionality require to do
an experiment. The idea is that a "block" of component calls (possibly with
evaluations of calculations, control structures, variables etc.) will be translated into a list of
instructions that will be added to the instruction buffer. A core concept of an
action call is that it can NEVER return a value, the only way for splotbot to
"communicate" with the experiment script is via event handling.

###Syntax
The construct of calling a component could look something like the following:

```
componentName.action(arg1,arg2);
```

This would generally be translated at runtime to something along the lines of:

```
1 arg1 arg2
```

##Event Handling
An "event handler" is simply a block of code that should be executed open an
event happening in splotbot. At the time the event happens the event block is
translated into instructions and put on the stack (this includes evaluating
variables, calculations etc.). Data is fed into the event handler via a data
"object" from which each variable can be extracted (This could be improved, so
that multiple variables are used instead of a single binding object).

###Syntax
Here we can either use a special syntax like:

```
(eventName, data) -> {
    ...
}
```

Or something more traditional like higher order functions, where the event
function could simply be an function in the interpreter language:

```
event(eventName, function(data){
    ...
});
```

##Example
Combining the two constructs a simple program could look like:

```
xyaxes1.Move(20,30) 
syringe1.MoveDown()
syringe1.Get(5)
syring1.MoveUp()
xyaxes1.Move(-20,-30)
syringe1.MoveDown()
syringe1.Dispose(2)
syringe1.MoveUp()
dropTracker.start()

(DropStop, place) -> { //Event from droptracker component
       xyages1.Move(place.x, place.y) 
       syringe1.MoveDown()
       syringe1.Dispose(3)
}
```

#Implementation of Language in the Splotbot model
The basics of the language translates into a list of instructions and a map from
an event to a list of instructions (or untranslated code depending on
implementation of the compiler/interpreter). The language could be implemented
in two stages:

1. Implement the possibility to call component actions. Making it possible to
   repeat a simple experiment multiple times 
2. Implementing the event model. Making it possible to create experiments that
   react to feedback from the components.


I see two possibilities for implementing the language with our setup:

1. Running the language client side, this makes it possible to use the
   functionality of evaluating JavaScript in JavaScript (Can be easily implemented, especially
   for for first stage)
2. Implementing the language as a component in the C++ code, the code could then
   be sent from the client and executed on the server, (This makes it possible
   to terminate the client and to make it more real time)

##Implementation in JavaScript
In JavaScript it could be quite simple to execute code. Here we could simply
construct all components as JavaScript objects, where each method simply returns
its input with the function id prepended. Each component could then be added to
a global object, allowing us to parse a string of instructions into individual
JavaScript calls and prepend them with the global object such that:

> componentName.Action(arg1) ->  global.componentName.Action(arg1)

And then evaluate the statement and add the results to an instruction list that
can then be send to the client. Event handling becomes less trivial, and
requires us to keep the internals of an event as a complete string until
execution time, but events are already send to the client and could be bound to
socket.io handlers. If done right, calculations, control structures, variables
etc. could be readily available.

The biggest issue is the fact that it requires the client to be connected, the
connection to be stable and have a reasonable response time. This implementation
is also be somewhat of a hack.

##Implementation in Splotbot/C++
The implementation in C++ would require us to use an lexer + parser, hopefully
resulting in an abstract syntax that would be easier to work with in the long
run, it would also let the experiment run without a client connected and would
possibly have less latency on event handling. 

So the basic is to send the code from the client to splotbot, when the code hits
splotbot it will be send to the "Controller" which will get the code translated
into a syntax tree. The controller will then evaluate and translate any none
event code into instructions and put those on the instruction buffer. The
Controller will bind events to abstract syntax, when an event is called the
abstract syntax will be evaluated and translated into instructions that will
then be put onto the instruction buffer.
