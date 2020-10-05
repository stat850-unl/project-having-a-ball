Stat 850 Project Description
================
Stack Jayden, Grantham Michael

## Instructions

Each member of your team should modify this document in some way and
push their modifications to the repository in a separate commit. This
will ensure that you have set your repository up in a way that ensures
all group members are working with the same repository.

Note that you must compile your readme (this document) for it to
properly display as part of your github repository.

Once you have received feedback on your project proposal (via Canvas)
you may alter this README so that it describes your final project
instead of the project proposal.

## Data Set

<https://developer.sportradar.com/docs/read/baseball/MLB_v7_with_Statcast#play-by-play>

## Potential Topics to Explore Using the Data Set

The ultimate idea is to continue the development of a new baseball
statistic called the level of contact (LoC). While there is a statistic
out there called hard hit percentage, this new statistic is different in
the fact that it divides the strike zone into nine different zones.
While the hitter may be hitting .350 in a specific area, it is sometimes
hard as a pitcher in baseball to gauge just how well that player is
hitting in that specific spot. The level of contact is measured on a
0-10 scale on balls put in play. The current rubric states for example
that a strikeout is a 0 LoC. A homerun is a 10 LoC. A hard hit ground
ball could be a 5 level of contact.

We will be exploring a rewrite of the rubric based on trajectory and
exit velocity.The ultimate goal would be to make the LoC a traceable
statistic through an algorithm instead of a subjective score. Other
factors that could affect the LoC is count, pitch type, pitcher type,
and others. All can be tested using proc glimmix to find if there is a
significant effect from said variable.

## Group Members

Jayden Stack and Michael Grantham
