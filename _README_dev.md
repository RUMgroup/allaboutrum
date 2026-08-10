# Developer README

## Event content metadata

Past events currently support two metadata styles:

- Legacy pages (2023-04-27 to 2025-02-27) use `title` and `subtitle` display
  strings with a more free-format content body. These are pages that existed
  prior to migrating the site to Quarto and adding more structured
  metadata.
- Newer pages (2025-05-22 onward) use nested `event`, `talk`, `bio`, and
  `content` metadata. These are pages that were created after migrating the site
  to Quarto and adding more structured metadata.

Both styles are intentionally supported for backward compatibility.

## Creating a new event page

To create a new event page in `content/events/upcoming/`, use the following template:

```yaml
---
title: "Your Event Title"
date: "YYYY-MM-DD"

event:
  date: "Day-name Day Month, Year"
  time: "12:00 pm - 1:00 pm GMT"   # insert correct time as appropriate
  summary: "Short event summary"
  location: "Room name"   # or leave empty as appropriate
  venue_url: "https://..."   # or leave empty as appropriate
  event_mode: "hybrid" | "online-only" | "in-person"
  join_url: "https://teams.microsoft.com/..."   # or leave empty as appropriate
  registration_url: "https://www.meetup.com/..."

# chair:

talk:
  speaker_1: "Speaker Name"
  topic_1: "Talk title"

bio:
  speaker_1: |
    Speaker bio

content:
  speaker_1: |
    Talk abstract
---

{{< include ../_event-detail-component.qmd >}}
```

The `_event-detail-component.qmd` component renders event metadata, i.e. the
talk title, summary, date, venue, URLs, abstract, speaker bio etc.

***Tip:*** \
You could use one of the newer (non-legacy) event pages as an example. These are
listings created from 2025-05-22 onwards.

Note that when there are no upcoming events to list, the
`content/events/upcoming/` directory would be empty and the rendered site will
display a message as configured in the metadata variable
`'listing.template-params.empty-message'` (e.g. "We don't currently have any
scheduled events ... please check back.")

In this case, on running `quarto render` you will get a warning:

```text
WARN: The listing in 'content/events/index.qmd' using the following contents:
- upcoming/*.qmd
doesn't match any files or folders.
```

This is expected when there are no upcoming events to list. The warning has
intentionally not been suppressed as it is truthful and could be helpful in the
case of a genuine developer error. If there genuinely are no upcoming events,
it can be ignored.

### Filename and date formats

Name the file `YYYY-MM-DD_short-description.qmd`, e.g.
`2026-09-24_intro-to-tidymodels.qmd`. The date in the filename should match
the `date` field in the YAML front matter, whilst the `event.date` field is
formatted in a more human-friendly way as "Day-name Day Month, Year".

### Moving an event to past

When an event has taken place, simply move its `.qmd` file from
`content/events/upcoming/` to `content/events/past/`. No other changes are
needed; the listing pages pick up events by directory.

## Managing team members

### Adding a current team member

Create a `.qmd` file in `content/team/current/` named after the person (e.g.
`name.qmd`). Use the following template:

```yaml
---
title: "Full Name"   # controls sort order
format: html
description: "Role and optional affiliation"
date: "YYYY-MM-DD"   # date joined (or date entry first included)
image: ../../../assets/img/team/filename.jpg
about:
  template: trestles
  image: ../../../assets/img/team/filename.jpg
  image-width: 12em
  image-shape: round
  image-alt: "Full Name"
  image-title: "Full Name"
---

<!-- Current team member -->

Bio text here.
```

Place the photo at `assets/img/team/filename.jpg`. If no photo is available,
use `../../../assets/img/team/profile.jpg` for both `image` fields.

### Moving a team member to past

Move their `.qmd` file from `content/team/current/` to `content/team/past/`.
No other changes are required as the listing pages pick up team members by
directory.

## Deployment

The site is rendered and deployed automatically via GitHub Actions on push to
the `main` branch. The rendered site is published to the `gh-pages` branch.

To test changes locally before committing, run `quarto render` in the
repository root.
