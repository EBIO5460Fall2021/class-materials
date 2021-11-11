# Git collaboration and teamwork

Using Git and GitHub is transformative for collaborating on a coding project.



### Basic workflow

I will incorporate my feedback on your code into your repository. You'll need at least to collaborate with me through GitHub to get feedback on the code in your project. If you're working with other people on a project, here's the simplest and most common workflow:



#### Getting changes from GitHub

* First commit any changes to your local repository (you don't necessarily need to commit your local changes but it can be the approach that involves the least hassle).
* Then `git pull`. This will fetch the version of your repository from GitHub and attempt to merge any differences in it with your local repository.
* This may reveal some differences that can be considered *conflicts* between the version on GitHub and your local version. Review the "Conflicts" tutorial at Software Carpentry (below) to see how to resolve these differences.



#### Pushing changes to GitHub

If someone else is contributing to your project's code on GitHub, when you try to push you may find that it isn't possible because the other person has updated the version of the repository on GitHub. Before you can push, you have to update your local version to take these updates into account. You need to do what is described above first in "Getting changes from GitHub", then you'll be able to push.



### Tutorials at Software Carpentry

https://swcarpentry.github.io/git-novice/

* Conflicts

You might also find the following tutorials useful for background and more complicated details (but not necessary for now since the essential steps are described in "Basic workflow" above).

* Remotes in GitHub
* Collaborating



### Summary of Git commands:

`git remote -v` List your Git project's remotes. Your remote will be on GitHub.\
`git fetch` Fetch work from the remote (GitHub) into the local copy.\
`git merge origin/main` Merge origin/main into your local branch (after first fetching it).\
`git pull` Combine `fetch` and `merge` above into one command.



### Try with GitHub

Try resolving a conflict with a test remote repo on GitHub (in your personal GitHub account, not in the class Organization area).

For example, practice resolving a conflict on local (your computer) and remote (GitHub) branches. First set up a conflict:

  * initiate a repo on GitHub with a `README.md` file
  * clone the repo to your computer and make some changes to `README.md` without pushing
  * use the web interface of GitHub to change `README.md` directly on the website or to create a new file, or upload a file through the GitHub website interface

Now changes have been made to the repo in two places (origin/main, which is on GitHub, and main, which is on your computer) and if you try to push from your computer, it will fail. You'll need to pull first and reconcile merge conflicts.



## Further reading

[Pro Git Chapter 5 Distributed Git](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows) is really good for the concepts and various ways to collaborate. You will probably most often use the "centralized workflow" to collaborate on projects.

Relevant topics at "Happy Git with R" are:

* [Dealing with push rejection](https://happygitwithr.com/push-rejected.html)
* [Pull, but you have local work](https://happygitwithr.com/pull-tricky.html)

