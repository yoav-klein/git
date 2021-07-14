
<######################

    conflict.ps1

    Create a situation of a merge 
    conflict

########################>


function Init() {
    # Init sets up all the infrastructure and tries to `git merge`
    # which causes a conflict

    # init a git repo
    git init

    # ignore this script
    echo "conflict.ps1" | Out-File -Encoding ASCII .gitignore

    # create a first commit with a.txt, b.txt and c.txt
    new-item a.txt
    echo "a.txt first commit" > a.txt

    new-item b.txt
    echo "b.txt first commit" > b.txt

    new-item c.txt
    echo "c.txt first commit" > c.txt

    git add .
    git commit -m "First commit"

    # create feature branch, and change a.txt and b.txt
    git checkout -b feature

    echo "feature a.txt" > a.txt
    echo "feature b.txt" > b.txt

    git add .
    git commit -m "changing a.txt and b.txt in feature"

    # now changing a.txt in master
    git checkout master

    echo "master a.txt" > a.txt
    git add .
    git commit -m "changing a.txt in master"

    # now merge feature into master 
    #
    # Notice that when you 'git status'
    # you get b.txt in green (changed to be committed)
    # why?
    # that's because the index was updated to match the changes made in feature
    # (the working tree was also updated)
    # but wasn't yet committed because of the conflict.
    # and since b.txt was also changed in feature, it's different than 
    # what it is in the current head, i.e. master 
    #
    # a.txt is marked as red (Unmerged paths) 
    # solve the conflict and `git add` it
    #
    

    git merge feature
}

function Hard-Reset() {
    #
    # once we fell to a conflict resolution situation,
    # and we want to just abort the merge, we could of course just `git merge --abort`
    # 
    # we can also git `reset --hard` which is effectively the same thing
    # since when we hard-reset, we sync both the index AND working directory
    # to match the current head, so it basically just aborts the merge
    #

    git reset --hard
}

function Simple-Reset() {
    # look what happens when you simply `git reset`
    git reset

    # now, if you `git status`, you'll see b.txt marked red (Changes not staged for commit)
    # why?
    # that's beacuse when we merged, all the unconflicted files in the index 
    # and the working tree was updated with the changes made in the incoming branch (feature)
    # when we called `reset`, we synced the index with the current head (master), so now 
    # the contets of b.txt in the index match those in the master branch, but they're 
    # different from the contents in the working directory, hence it's marked as
    # changes to be commmitted
    

}

