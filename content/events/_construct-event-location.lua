-- Construct event location metadata for both listing cards and event detail
-- pages. For listing cards we provide plain text; for detail pages we provide
-- a markdown link variant.

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

  local location_txt = as_text(meta.event.location)
  local location_url = as_text(meta.event.location_url)
  local is_hybrid = meta.event.hybrid == true
  local hybrid_url = as_text(meta.event.hybrid_url)
  local online_txt = "Online via Microsoft Teams"

  local location_display = location_txt
  if is_hybrid then
    if location_txt ~= "" then
      location_display = string.format("%s • %s", location_txt, online_txt)
    else
      location_display = online_txt
    end
  end

  local location_link_txt = location_txt
  if location_url ~= "" and location_txt ~= "" then
    location_link_txt = string.format("[%s](%s)", location_txt, location_url)
  end

  local online_link_txt = online_txt
  if hybrid_url ~= "" then
    online_link_txt = string.format("[%s](%s)", online_txt, hybrid_url)
  end

  local location_link = location_link_txt
  if is_hybrid then
    if location_link_txt ~= "" then
      location_link = string.format("%s [&#8226;]{.sep} %s", location_link_txt, online_link_txt)
    else
      location_link = online_link_txt
    end
  end

  meta.event["location_display"] = pandoc.MetaString(location_display)
  meta.event["location-display"] = pandoc.MetaString(location_display)
  meta.event["location-link"] = pandoc.MetaInlines(
    pandoc.read(location_link, "markdown").blocks[1].content
  )

  return meta
end
