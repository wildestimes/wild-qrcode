# Feature: diff-synthesizer (PR/Diff Analysis Service)

## Description

An extension that takes a git diff or a pull request URL as input and provides a strategic summary of the changes.

## Tasks

- [done] Implement an extension to accept git diffs from stdin.
- [done] Implement functionality to fetch PR details from a given URL.
- [done] Use an LLM to summarize the architectural implications of a change.
- [done] Check for potential anti-patterns or missing error handling in the diff.

## User Stories

- As a senior engineer, I want to get a high-level summary of a pull request before diving into a line-by-line review so that I can focus on the strategic impact of the changes.
- As a developer, I want to pipe my local git diff to the tool to get a quick check for common issues before I commit my code.
