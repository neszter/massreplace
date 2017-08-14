Instead of keeping to stupidly add (or remove) useless files like lalalalaa...etc.... let's do something meaningful and useful for you/myself to learn/use the power of github. 

Read carefully the following:

1) I can see my work branch (named mm_branch) in my github DESKTOP while you can't (this is normal because, from github DESKTOP point of view, branches are LOCAL workspace). HOWEVER...from yuor WEB central repository you can obviously see branches (from my workspace as well as yours) as soon as I publish my local branch.

2) I will be working on my mm_branch (when I'll have time) with massreplace.sh doing some modifications on my local PC. When I'll be sufficiently happy with my modifications I will commit and sync my local massreplace.sh to my branch stored in the central, web repository (so that you TOO can see my modifications) 

3) you could keep working (with your local PC) with massreplace.sh in your master branch. When you're sufficiently happy you can commit yuor changes and sync them with your master branch (this way I can see your changes)

4) point 2) and point 3) can be done for unlimited times (in case of complex projects of course)

5) once I'm definitely happy with my branch I can make a PULL request: this means that I ASK you to merge my suggested changes to your MASTER (official branch). 
You might:
a) accept and merge everything: then my massreplace.sh would REPLACE the massreplace.sh in the MASTER branch
b) refuse everything: then my merge request would simply be denied
c) accept something: then you can accept only some of the changes that I suggest
d) YOU CAN OBVIOUSLY do the following too: you can deny my pull request, copy some rows of my massreplace.sh and paste it in your local PC (bound to the master branch) and then commit the master branch

5) A small (although IMPORTANT!!!) remark to point 3) above. You too you SHOULD create your own work branch (let's name it en_branch) to do your modification to massreplace.sh INSTEAD OF doing such modifications directly to the Master branch!!! THIS IS A BEST PRACTICE because the master branch is the official version of something and shouldn't be continuously modified for development. So...you too you should do your work within en_branch and then ASK YOURSELF (through a PULL request which you see at the top right corner of your github DESKTOP) to merge your changes to master branch

6) ....and.....we always have the chance (in case we needed) to ROLLBACK any changes that we may have done :-)

7) OF COURSE we are "wasting" huge time to this only because we have been doing that "on a trining mode" ;-) ;-)



SO.....there are MANY, MANY, MANY possibilities and you keep having full control (now that we protected the MASTER branch)


As I wrote above...I'll (hopefully) do some work today with massreplace.sh ONLY if I have time.


