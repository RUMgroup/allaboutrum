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

  local meetup_url = as_text(meta.event.meetup_url)
  local has_meetup_link = meetup_url ~= ""

  local meetup_label = "If you plan on attending in person, please"
  if meta.event.online_only == true then
    meetup_label = "If you plan on attending, please"
  end

  local meetup_link = pandoc.MetaInlines(pandoc.Str(""))
  if has_meetup_link then
    local meetup_txt = string.format("%s [register on Meetup](%s)", meetup_label, meetup_url)
    meetup_link = pandoc.MetaInlines(pandoc.read(meetup_txt, "markdown").blocks[1].content)
  end

  meta.event["has-meetup-link"] = pandoc.MetaBool(has_meetup_link)
  meta.event["meetup-link"] = meetup_link

  return meta
end
