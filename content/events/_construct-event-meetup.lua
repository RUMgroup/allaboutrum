-- Construct a Meetup link for event detail pages and a boolean availability
-- flag for deterministic conditional rendering.

local function as_text(value)
  if value == nil then
    return ""
  end
  return pandoc.utils.stringify(value)
end

function Meta(meta)
  if not meta.event then
    return meta
  end

  -- Prefer registration_url; fall back to meetup_url for backwards compatibility.
  local registration_url = as_text(meta.event.registration_url)
  if registration_url == "" then
    registration_url = as_text(meta.event.meetup_url)
  end
  local has_meetup_link = registration_url ~= ""

  -- Prefer event_mode; fall back to legacy booleans for backwards compatibility.
  local event_mode = as_text(meta.event.event_mode)
  if event_mode == "" then
    if meta.event.online_only == true then
      event_mode = "online-only"
    elseif meta.event.hybrid == true then
      event_mode = "hybrid"
    else
      event_mode = "in-person"
    end
  end

  local meetup_label = "If you plan on attending in person, please"
  if event_mode == "online-only" then
    meetup_label = "If you plan on attending, please"
  end

  local meetup_link = pandoc.MetaInlines(pandoc.Str(""))
  if has_meetup_link then
    local meetup_txt = string.format("%s [register on Meetup](%s)", meetup_label, registration_url)
    meetup_link = pandoc.MetaInlines(pandoc.read(meetup_txt, "markdown").blocks[1].content)
  end

  meta.event["has-meetup-link"] = pandoc.MetaBool(has_meetup_link)
  meta.event["meetup-link"] = meetup_link

  return meta
end
