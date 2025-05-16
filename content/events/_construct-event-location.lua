-- Construct a location label, possibly with a link to a meeting location, as
-- well as a link to a Teams meeeting (if the URLs are provided in the metadata)
-- and add it to the event metadata
function Meta(meta)
  if meta.event then
    local loc_link_txt = pandoc.utils.stringify(meta.event.location or "")
    local is_hybrid = meta.event.hybrid and pandoc.utils.stringify(meta.event.hybrid) == "true"
    local loc_url = meta.event.location_url and pandoc.utils.stringify(meta.event.location_url) or nil
    local hybrid_url = meta.event.hybrid_url and pandoc.utils.stringify(meta.event.hybrid_url) or nil

    -- If there's a URL, create a markdown link
    if loc_url then
      loc_link_txt = string.format("[%s](%s)", loc_link_txt, loc_url)
    end

    -- Compose label:
    --   plain "<location>" or "<location> • Online via Microsoft Teams"
    -- The location could be a link to a meeting location, and the online link
    -- could be a link to a Teams meeting (if the URLs are provided in the
    -- metadata)

    local online_link = "Online via Microsoft Teams"

    local loc_link
    if is_hybrid then
      -- If there's a URL, create a markdown link
      if hybrid_url then
        online_link = string.format("[%s](%s)", online_link, hybrid_url)
      end
      loc_link = string.format("%s [&#8226;]{.sep} %s", loc_link_txt, online_link)
    else
      loc_link = loc_link_txt
    end

    -- Add the location link to the event metadata
    -- Note that it may not be an actual link (if no url is provided in the
    -- metadata)
    meta.event["location-link"] = pandoc.MetaInlines(pandoc.read(loc_link, "markdown").blocks[1].content)
  end

  return meta
end
