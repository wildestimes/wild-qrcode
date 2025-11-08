# Development Workflow

This document outlines the development workflow, 
which is divided into phases: `Plan`, `Dev`, `Debug`, and `Release`.

## Plan Phase

The `plan` phase focuses on deconstructing input, refining existing features, and creating new feature documents.

**Steps:**
1.  **Deconstruct Input:** Analyze new requests, bug reports, or enhancement ideas.
2.  **Revise/Create Features:**
    *   For existing features, update their documentation in `docs/dev/backlog/`.
    *   For new features, create a new Markdown file in `docs/dev/backlog/` named after the feature (e.g., `feature-name.md`).
    *   Each feature document should include:
        *   Title
        *   Description
        *   Tasks (with title and status: `[todo, in-progress, pending approval, done]`)
        *   User Stories (if necessary)
3.  **Update dev/status**
    *   Add an update of the features added/discussed.

## Dev Phase

The `dev` phase involves actively working on the features outlined in the backlog.

**Steps:**
1.  **Move to Current:** Select features from `docs/dev/backlog/` to work on during the current sprint. Move their respective Markdown files to `docs/dev/current/`.
2.  **Implement Work:** Address the tasks outlined in the feature document. Update task statuses as work progresses.
3.  **Commit Changes:** Once a task or feature is complete, commit the changes to version control.
4.  **Create Pull Request:** Push the changes to a feature branch and create a Pull Request (PR). Ensure all tests and pipelines are passing.
5.  **Move to Release:**: Select the related feature and assess if it is ready to release.  Move the feature accordingly.
5.  **Update dev/status**
    *   Add an update of the features moved to release.


## Debug Phase

TODO: Define

## Release Phase

The `release` phase handles the finalization and reporting of completed features.

TODO: define the release phase.