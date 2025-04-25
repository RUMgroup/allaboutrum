function Meta(meta)
  if meta.event then
    local loc = pandoc.utils.stringify(meta.event.location or "")
    local is_hybrid = meta.event.hybrid and pandoc.utils.stringify(meta.event.hybrid) == "true"
    local loc_url = meta.event.location_url and pandoc.utils.stringify(meta.event.location_url) or nil

    -- If there's a URL, create a markdown link
    local link
    if loc_url then
      link = string.format("[%s](%s)", loc, loc_url)
    else
      link = loc
    end

    -- Compose label: plain location or "<location> • Online via Microsoft Teams"
    local label
    if is_hybrid then
      label = string.format("%s [&#8226;]{.sep} Online via Microsoft Teams", link)
    else
      label = link
    end

    meta.event_location = pandoc.MetaInlines(pandoc.read(label, "markdown").blocks[1].content)
  end

  return meta
end
