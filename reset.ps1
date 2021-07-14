
<##############################
        reset.ps1

    This script is aimed to practice git reset
###########################>

function Init() {
    # init a git repository with 3 commits
    git init

    # create 3 commits
    echo "first version of a.txt" | Out-File -Encoding ASCII a.txt
    echo "first version of b.txt" | Out-File -Encoding ASCII b.txt
    
    git add .
    git commit -m "first commit"

    echo "second version of a.txt" | Out-File -Encoding ASCII a.txt
    echo "second version of b.txt" | Out-File -Encoding ASCII b.txt

    git add .
    git commit -m "second commit"

    echo "third version of a.txt" | Out-File -Encoding ASCII a.txt
    echo "third version of b.txt" | Out-File -Encoding ASCII b.txt
    
    git add .
    git commit -m "third commit"

}

function Restart() {
    if($(Get-Location).ToString() -match "reset$") {
        rm -Recurse -Force *
    }
    else {
        echo "You're not in reset directory"
    }
}

function Soft-Reset() {
    # init the repo
    Init

    # soft reset only moves the head
    git reset --soft HEAD^

    Write-Output "Notice that git log will show you you're on Second commit"
    Write-Output "---------------------------------------------"
    git log

    Write-Output "Git status will tell you you have chagnes ready for commit"
    Write-Output "---------------------------------------------"
    git status

    Write-Output "The files remain unchanged"
    Write-Output "---------------------------------------------"
    Get-Content a.txt
    Get-Content b.txt
    
    # git status will tell you
}

function Mixed-Reset() {
    # init the repo
    Init
    # mixed reset  moves the head
    git reset --mixed HEAD^

    Write-Output "Notice that git log will show you you're on Second commit"
    Write-Output "---------------------------------------------"
    git log

    Write-Output "Git status will tell you you have unstaged changes"
    Write-Output "---------------------------------------------"
    git status

    Write-Output "The files remain unchanged"
    Write-Output "---------------------------------------------"
    Get-Content a.txt
    Get-Content b.txt
    
    # git status will tell you
}

function Hard-Reset() {
    # init the repo
    Init
    # hard reset moves the head
    git reset --hard HEAD^

    Write-Output "Notice that git log will show you you're on Second commit"
    Write-Output "---------------------------------------------"
    git log

    Write-Output "Git status will tell you that everything is clean"
    Write-Output "---------------------------------------------"
    git status

    Write-Output "The files are reset to the second version"
    Write-Output "---------------------------------------------"
    Get-Content a.txt
    Get-Content b.txt
    
    # git status will tell you
}

function Merge-Reset() {
    # init the repo
    Init
    
    # create a commit with change only to a.txt
    echo "fourth version" | Out-File -Encoding ASCII a.txt
    git add .
    git commit -m "fourth commit"

    # change b.txt in working directory
    echo "Some change to b.txt, to see merge reset in action" | Out-File -Encoding ASCII b.txt

    # merge reset
    git reset --merge HEAD^
     
    Write-Output "Git log will show you you're on Third commit"
    Write-Output "---------------------------------------------"
    git log

    Write-Output "Git status will tell you that b.txt has unstaged changes"
    Write-Output "----------------------------------------------------------"
    git status

    Write-Output "b.txt still contains the change"
    Write-Output "--------------------------------"
    cat b.txt 

}


function Stage-Change() {
    # change the files and stage them

    echo "staging a.txt" > a.txt
    echo "staging b.txt" > b.txt

    git add .
 }