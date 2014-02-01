# Choice of language

One major decision that should be made early in the project is the
choice of language to use for the end product. Since this will make
for a large portion of the project it is not an insignificant choice
to make. As such we have put a lot of thought into which
technology to bet on before finally ending up with C++. The
following describes the rationale behind this decision.

## Rationale

Two major factors weigh in on this choice, convenience and
capabilities. Capabilities is considered to be the slightly on the
more important end, but we will seek out convenience when it is within
reach. First of such opportunities shows itself when looking at what
our distribution of choice (Ängström) has to offer in precompiled
language support:

- Python 
- Perl 
- Mono 
- C 
- C++ 
- Bonescript (form of Javascript with lowlevel hooks on NodeJS)

Here an oppurtunity for convenience shows itself, as some of these
language have a reputation for being more concise and provide for more
rapid development with a smaller code base: Python, Perl, F# (on
mono), VB.net (on mono), Javascript (as Bonescript), but again it has
to be weighted against the languages that have a reputation of being
very capable and performant: C# (on mono), C, C++. 

Some of these languages are easily picked out of the race, Perl we
have zero experience in, and we have all had bad experiences with mono
on POSIX environments, so this should at least be ranked lower than
some of the other options. Although it sounds intriguing to run
javascript against low level devices none of us feel very fondly for
javascript as a language, and Bonescript seems like a rather new and
somewhat unproven technology. 

The coupe de grâce to these technologies comes courtesy of OpenCV,
which we know will be used extensively in this project. When looking
at the OpenCV documentation it is clear that C/C++ and python are best
represented in the online documentation for OpenCV, and having worked
with OpenCV in the past, we suspect we will consult the documentation
quite a lot. Speaking of past experience, we have all successfully
completed a course using python with opencv but in the process we
noted that C++ almost always had better documentation, even for the
simplest of operations. Snooping through the docs now also reveals
that for things like image stiching and machine learning, C++ is much
better represented. Coupling this with concerns of performance (image
stiching is not trivial computationally, and natively compiled always
beats a dynamic scripting language), convenience of type safety and
a (objectively) better support for object oriented programming the
choice naturally falls on C++.
