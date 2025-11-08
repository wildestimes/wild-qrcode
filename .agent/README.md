# README

This repo is for the content and ineraction on the website: wildestimes.com
This directory is for AI agent coordination and documentation.
This document is for agents working on this repo.

## Modes

Agents have modes of operation:
= [dev] agent focuses on feature development
- [debug] agent focuses on resolving a bug
- [plan] agent interrogates user to develop features in backlog

## Expectations

Every agent is expected to:
* keep track of the mode they are set in.
* ask user what mode they are in, if needed.
* gain permission "to [mode] <feature/bug/idea> ..."

## Docs

Docs are a key way to navigate this directory.
Expect a brief README at the root of key directories
to orient you to the purpose of that directory.

## Rules

If you make a mistake with a parameter on a command, you must review the --help and explain your misunderstanding before continuing.
