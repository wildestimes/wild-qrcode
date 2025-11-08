# Spike: repo-interrogator

## Goal

To break down the "Very High" effort estimate for the `repo-interrogator` feature by investigating the core technologies and creating a more detailed implementation plan.

## Timebox

2 days

## Tasks

- [todo] **Research: Code Indexing Technologies**
    - Investigate options for generating vector embeddings for code (e.g., Sourcegraph's cody, local models).
    - Evaluate the effectiveness of traditional ctags for symbol-level lookups in modern codebases (e.g., Python, TypeScript).
    - Compare the pros and cons of a hybrid approach (embeddings + ctags).

- [todo] **Prototype: Simple Indexer**
    - Develop a proof-of-concept script that can traverse a local directory.
    - Implement either a basic ctags indexer or a simple vector embedding generator for a small sample of code.
    - Test the prototype with a simple query (e.g., "find function named 'calculateTotal'").

- [todo] **Analysis & Planning**
    - Based on the research and prototype, create a detailed task breakdown for the `repo-interrogator` feature.
    - Refine the user stories with more specific technical requirements.
    - Produce a revised effort estimate (e.g., from "Very High" to a more granular breakdown in story points or days).

## Success Criteria

- A detailed task list for the `repo-interrogator` is created and added to the feature document.
- A recommendation on the primary indexing technology (embeddings, ctags, or hybrid) is made.
- The effort estimate for the `repo-interrogator` is revised and broken down.
