# Git: used branch models / workflows

## Preface


**from where should a branch be created?**
Most git users are only concerned with the question of which branch they should create the branch for a new feature from and merge it back in via a pull request.
The answer is usually like this:

- for an new feature: `develop` (or - **and only then** - if there is no develop, `main`)
- merge back into that branch where you branched from

The details become exciting when it comes to hotfixes (= bug fixes in several versions) and the release process.


General rules for products - regardless of the chosen workflow:

- the main - branch is protected
- each delivered version must be provided with a unique version
- merge requires a pull request with reviewer and passed review
- no change without JIRA story
  - the key of the story SHOULD precede each commit
  - the branch name MUST be identifiable with the story
- if the target branch has changed, rather rebase than merging
- be careful when rewriting the story for a remote branch (e.g. rebase): Make sure you are the only one affected by the changes
- Squashing commits only if you have done a lot of local "work in progress" commits

# Git flow (preferred)

The standard git workflow.

The daily work takes place at an dedicated feature branch, witch must be forked from develop and must be merged via pull-request back to develop.

```mermaid
gitGraph
	commit tag: "v1.2.2"
	branch develop order: 3
    commit
    branch feature/proj1-234 order:4
    checkout feature/proj1-234
    commit
    commit
    checkout develop
    merge feature/proj1-234
    commit
    branch feature/proj1-235 order:5
    checkout feature/proj1-235
    commit
    commit
    checkout develop
    merge feature/proj1-235
    branch release/1.2.3
    commit
    commit
    checkout main
    merge release/1.2.3 tag: "v1.2.3"
	commit
```

The following Branches may exist in our git-workflow:

- `feature/*` - Branch = Branch, where the implementation actually happens
- `develop` - Branch = finished changes for the next release
- `release/*` - Branch, where release-preparation will take place (finish release documentation etc.)
- `main` - Branch = productive-like code



**Release - hints:**

1. creating the release branch from `main` and them merge `develop` into the release branch ensures, that problems occur at the beginning of the release phase and not at the end when the merge into the main takes place
2. don’t forget to bump the version number when creating an release/support/hotfix - branch



```mermaid
gitGraph
	commit tag: "v1.2.2" id: " "
	branch develop order: 3
    commit id: "is v1.2.3"
    commit id: "add some features"
    checkout develop
    checkout main
    branch release/1.2.3
    checkout release/1.2.3
    merge develop
	commit id: "create rc" type: REVERSE tag: "v1.2.3-RC.1"
	checkout develop

    checkout main
    merge release/1.2.3 tag: "v1.2.3"
	checkout release/1.2.3
	commit id: "set v1.2.4" type: HIGHLIGHT
	checkout develop
	merge release/1.2.3
  ```

 

## legacy products

Our legacy products must also support multiple, previous released versions. Thus, there are some additional branches:

- `support/<version>` = the main branch for an older supported version
- `hotfix/*` = branch for a hotfix, which must be rolled out over various versions
- `release/*` = branch for prepare a planned release

```mermaid
gitGraph
	commit tag: "v1.2.3" id: " "
    branch develop
    commit id: "is v2.0.0"
    commit id: "    "
    branch release/2.0.0 order: 1

    checkout release/2.0.0
	commit id: "create rc" type: REVERSE tag: "v2.0.0-RC.1"
    checkout develop
	

    checkout main
    branch support/1.2 order: 2
    commit id: "  "

    checkout main
    merge release/2.0.0 tag: "v2.0.0"
	
    checkout release/2.0.0
    commit id: "set v2.1.0" type: HIGHLIGHT

    checkout develop
    merge release/2.0.0


    checkout main
    branch release/2.0.1 order: 2
    commit id: "set v2.0.1" type: HIGHLIGHT
    
    checkout support/1.2
    branch hotfix/issue order: 3
    commit id: "set v1.2.4" type: HIGHLIGHT
    commit id: "fixing issue"

    checkout support/1.2
    merge hotfix/issue tag: "v1.2.4"

    checkout release/2.0.1
    cherry-pick id: "fixing issue"
    checkout main
    merge release/2.0.1 tag: "v2.0.1"

    checkout release/2.0.1
    commit id: "set v2.1.1" type: HIGHLIGHT

    checkout develop
    merge release/2.0.1
```

# Other workflows

## GitHub flow

[GitHub flow - GitHub Docs](https://docs.github.com/en/get-started/quickstart/github-flow)

The GitHub Flow is a lightweight workflow. It was created by [GitHub in 2011](http://scottchacon.com/2011/08/31/github-flow.html) and respects the following 6 principles:

1. Anything in the `main` branch is deployable
2. To work on something new, create a branch off from`main` and given a descriptively name(ie: `new-oauth2-scopes`)
3. Commit to that branch locally and regularly push your work to the same named branch on the server
4. When you need feedback or help, or you think the branch is ready for merging, open a [pull request](http://help.github.com/send-pull-requests/)
5. After someone else has reviewed and signed off on the feature, you can merge it into `main`
6. Once it is merged and pushed to `main`, you can and *should* deploy immediately


```mermaid
gitGraph
	commit tag: "v1.2.2"
    branch proj1-235
    commit
    commit
    checkout main
    merge proj1-235 tag: "v1.2.3"
	commit
  ```

➕ It is ideal when it needs to maintain single version in production
➖ It isn’t recommended when multiple versions in production are needed
➖ Are not adequate when it needs the release plans

 
## One flow

One flow is something in between GitHub and Git flow

In short, it is GitFlow without develop


```mermaid
gitGraph
	commit tag: "v1.2.2"
	branch feature/proj1-234 order:4
    checkout feature/proj1-234
    commit
    commit
    checkout main
    merge feature/proj1-234
    commit
    branch feature/proj1-235 order:5
    checkout feature/proj1-235
    commit
    commit
    checkout main
    merge feature/proj1-235
    commit
    branch release/1.2.3
    commit
    commit
    checkout main
    merge release/1.2.3 tag: "v1.2.3"
	commit
  ```
[OneFlow – a Git branching model and workflow | End of Line Blog](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow)

 

## Trunk-Based “flow” (should not be used productive)

> A source-control branching model, where developers collaborate on code in a single branch called ‘trunk’, resist any pressure to create other long-lived development branches by employing documented techniques. 
> They therefore avoid merge hell, do not break the build, and live happily ever after



```mermaid
gitGraph
    commit
    branch release/1.2.2
    commit
	commit tag: "v1.2.2" type: HIGHLIGHT
    checkout main
	branch feature/proj1-234 order:4
    commit
    checkout feature/proj1-234
    commit
    commit
    checkout main
    merge feature/proj1-234
    commit
    branch feature/proj1-235 order:5
    checkout feature/proj1-235
    commit
    commit
    checkout main
    merge feature/proj1-235
    commit
    branch release/1.2.3
    commit
    commit tag: "v1.2.3" type: HIGHLIGHT
    checkout main
```

[Introduction (trunkbaseddevelopment.com)](https://trunkbaseddevelopment.com/)



## No-branch “flow” (must not used productive)

```mermaid
gitGraph
    commit
    commit
    commit
    commit
    commit
    commit
    commit
    commit
    commit
    commit
```

 
Links:

- [War of the Git Flows - DEV Community](https://dev.to/scottshipp/war-of-the-git-flows-3ec2)
- [Gitgraph (Git) Diagram 🔥 (mermaid-js.github.io)](https://mermaid-js.github.io/mermaid/#/gitgraph)
