## What's this

A bash script to delete remote branches. Only for use with git.

**************
  Assumption
**************
Your remote is aliased as 'origin'.

**************
  How to use
**************

1. Think of a list of branches that you know will never be deleted and then put their names in a formatted string. Example: if the branches that should never be deleted are 'master', 'staging' and 'release', make a string like this 'master|staging|release'.

2. Make sure your repo is currently on a main development branch for the whole team, such as 'master' or 'develop', which is usually the branch the team pushes to most frequently.

3. In your repo, run 'git branch -r --no-merged | egrep "origin/(master|staging|release)$" -v'. Of course, you need to replace the 'master|staging|release' part with the string you came up in step 1.

4. The result from step 2 is a list of unmerged remote branches against your main dev branch. Locate those you want to keep and then remove their names from the list. Now save the list in a plain text file.

5. Run the script on your machine, like this: 
	```
	./git_remote_branches_removal.sh <path/to/your/repo> <path/to/file/from/step/4> '<string_you_came_up_in_step_1>'
	```

	Example: ./git_remote_branches_removal.sh /Users/me/Code/MyRepo my_blacklist_file_created_in_step_4 'release|master|staging'

*****************
  Runing result
*****************

Except for the branches you came up in step 1 AND all the unmerged branches (against your team main development branch) not in the file from step 4, all the other remote branches will be deleted. 