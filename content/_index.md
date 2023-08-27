---
date: "2022-10-24"
sections:
- block: about.biography
  content:
    title: About
    username: admin
  id: about
- block: collection
  content:
    filters:
      folders:
      - event
    title: Recent & Upcoming Talks
  design:
    columns: "2"
    view: compact
  id: events
- block: portfolio
  content:
    buttons:
    - name: Current
      tag: current_team_member
    - name: Past
      tag: past_team_member
    default_button_index: 0
    filters:
      folders:
      - team
    title: Organising Team
  design:
    columns: "1"
    flip_alt_rows: false
    view: showcase
  id: team
- block: contact
  content:
    autolink: false
    email: r-user-group@manchester.ac.uk
    title: Contact
  design:
    columns: "2"
  id: contact
title: null
type: landing
---
