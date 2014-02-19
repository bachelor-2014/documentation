#Questions concerning Splotbot and its use
The following questions are an attempt to cover them knowledge we need in order
to work on Splotbot, improving it and providing functionality as according to
the needs of future users.

##Functional requirements
- Which experiments are to be performed (e.g. a usage scenario)?
- What is the number of different liquids being handled in a single experiment?
- With what precision must the liquids be handled (e.g. what is the minimum
  number of liquid being inserted into a petri-dish by the robot)?
- For how long must an experiment be able to run?
- Must the robot be able to run experiments without human intervention (after
  a human starting the experiment)?
- Must the robot be able to repeat the same experiment multiple times without
  the user intervening between the repetitions?

##Usability
- What are the qualifications of the users of the robot (e.g. one or more
  persona describing these)?
- Must the robot be intuitive enough to be usable without prior training of the
  users? If not, how much training is possible?
- Must the robot be controllable from the personal computers of the users or
  must it be controllable entirely as a standalone unit?
- Must the robot be controllable by more than a single person at the same time?
- Must the robot have different user interfaces for different kinds of users
  (e.g. a graphical and a programming user interface)?

##Reliability
- Must the robot be able to withstand use by various users, or will it be used by
  a few number of people who knows the robot well?
- How often will the robot be used (e.g. how often will an experiment be run)?
- How often is it allowed for the robot to have issues in operation such as
  (e.g. 1 time out of X experiments):
    - Minor issues (the issue is fixed by any user such as a petri-dish getting
      stuck)
    - Moderate issues (the issue is fixed by a superuser / a user knowing the
      robot well such as realignment of the carriage or camera)
    - Major issues (the issue must be fixed by someone capable of rebuilding
      parts of the robot if necessary such as parts of the construction
      breaking)

##Performance
In the following, the network connection needs to be taken into account when
doing estimates:

- What is the max allowed response time from a user interacts with the robot to
  the response of the robot (e.g. number of milliseconds)?
- What is the max allowed average response time?
- How constant must the response time be / what is the max allowed deviation of
  an actual response time from the average?
- How many video frames must the camera be able to process each second?

##Supportability / Maintainability
- Who must be able to repair the robot?
- To what extend must the robot be extendible with further functionality without
  requiring modifications of existing functionality?

##Documentation
- What kinds of training material must be available for users (e.g. user manual,
  training videos etc.)
- What kinds of documentation must be available for developer wishing to alter /
  extend the robot?
