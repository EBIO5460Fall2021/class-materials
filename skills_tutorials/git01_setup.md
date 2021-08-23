# Setting up a Git-RStudio-GitHub workflow
Here we focus on getting set up with a workflow that has three components:
1. Git
2. Rstudio
3. GitHub

We will address rationale and usage later.\
Prerequisite: RStudio installed and up to date.

## Register a GitHub account
https://github.com/ \
Use your colorado.edu email.\
Email me your GitHub username so I can add you to the class's GitHub organization.

## Install Git
There are lots of options for Git [clients](https://en.wikipedia.org/wiki/Client_(computing)) (including GitHub desktop) but the official Git version is recommended:\
https://git-scm.com. \
Go to downloads and choose your operating system. This official version installs both a CLI ([command line interface](https://en.wikipedia.org/wiki/Command-line_interface)) and a GUI ([graphical user interface](https://en.wikipedia.org/wiki/Graphical_user_interface)).

On this website there is also a section for third-party GUI clients. You can ignore this section but feel to try some out.

**Windows**\
When installing, there will be a bunch of questions. For most, the defaults are good. These two are important:
1) Choose default editor: I suggest [nano](https://www.nano-editor.org/), or [notepad++](https://notepad-plus-plus.org/).
2) Adjust your path environment if necessary: choose "Git from the command line and also from 3rd-party software (this is the default choice)". This is important to allow Rstudio to find Git. Depending on your Windows version and installation this may or may not work with RStudio automatically. If not, in RStudio -> Tools -> Global Options -> Git/SVN -> enter the path to git.exe (and restart Rstudio).

**Mac**\
If asked, install Xcode command line developer tools also.

**Linux**\
Instructions for different distributions here:
https://git-scm.com/download/linux.

## Set up Git
Open a [CLI shell](https://en.wikipedia.org/wiki/Shell_(computing)). A shell can be opened through R studio > Tools > Shell.\
Otherwise, you can do this:\
**Windows:** start the "Git bash" program/app (which you installed above)\
**Mac:** start the terminal app.\
**Linux:** fire up a terminal.

Set up Git with your name and email. These will label your commits to document who made changes - important when you are collaborating.
```bash
git config --global user.name "Your_full_name"
git config --global user.email "your.email@address"
git config --global --list
```
The email address should be the same one you used to register on GitHub. That's all you should need to set up. For more options, see
https://swcarpentry.github.io/git-novice/02-setup.

## Set up a test Git repository (or two)

First test that everything works. Do this directly from your personal GitHub account (i.e. not from the class organization at this stage), setting up public repos each time. Follow the directions in [Happy Git with R Chapter 9](http://happygitwithr.com/push-pull-github.html). Don't worry about understanding what is going on too much at this stage. Just follow the directions and type carefully (or copy and paste). Go all the way to the end, including deleting the test repo. BEWARE: a few details have changed:

* In section 9.3 it says "you will be challenged for your GitHub username and password". GitHub has recently changed it's authentication process and traditional passwords are no longer used for this step, as explained [here](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/about-authentication-to-github#authenticating-with-the-command-line). Instead of entering a traditional password you must now enter your "personal access token" (PAT). Here's what you need to do:
  * Follow the directions [here](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) for setting up a personal access token:
    * Where it asks to "Give your token a descriptive name", you could call it "Git repo interface"
    * Where it asks for an expiration, choose indefinitely or the largest possibility
    * Where it asks for scope, select "repo"
  * Now you can enter your PAT when asked for a password at the command line.
* In section 9.5, if you find your cached credentials don't "just work" I suggest setting up cached credentials for HTTPS access because it is simpler than SSH keys. But you can certainly set up SSH keys if you prefer.

Now we're going to do that all again but this time with RStudio. Follow the directions in [Happy Git with R Chapter 12](http://happygitwithr.com/rstudio-git-github.html). Finish by cleaning up as directed.

If you run into trouble with any of this, there are lots of resources at Happy Git with R, especially [Chapter 14](http://happygitwithr.com/troubleshooting.html).
