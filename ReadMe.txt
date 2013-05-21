Have attached my solution as a zip.

I took you at your word – and wrote in in the language I’m currently learning – Haskell. 

I’ve included compiled executables (one of the main programme, one of the test ) which I think are stand alone – so should be easy to run.

If I was doing this commercially for a client I’d change the input file parsing to have some error handling, and add more test cases. I needed to stop somewhere though!

Files included are :-
MarsMain.exe – the main executable – takes input from stdin – run as MarsMain  <  SampleInput.txt
TestRobots.exe – a simple set of unit tests – just uses the Haskell show for (ugly) output – not inputs / outputs or parameters – could be made much better – but at least there are some tests!
MarsMain.hs – the input/output/control module – always a bit ugly in Haskell
MarsRobot.hs – the main works and the most interesting code. Haskell can be a bit dense – happy to talk it through.
TestRobots.hs – some units tests – shows building test data structures in Haskell – and I think the language does this quite well. 
SampleInput.txt – the demo example data copied from the pdf

Let me know if you can read / run this OK.
