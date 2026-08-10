# Developer README

## Event content pre- and post-migration to Quarto

Past events currently support two metadata styles:

- Legacy pages (2023-04-27 to 2025-02-27) use `title` and `subtitle` display
  strings.
- Structured pages (2025-05-22 onward) use nested `event`, `talk`, `bio`, and
  `content` metadata.

Both styles are intentionally supported for backward compatibility.

## Creating a new event page

To create a new page in `content/events/upcoming/`, use the following template:

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
summary/date/location, conditional Meetup text, talk title, abstract and speaker
bio.
