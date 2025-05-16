-- Construct a link to a Meetup event, if the URL is provided in the metadata
-- (or a blank string), and add it to the event metadata
function Meta(meta)
  if meta.event then
    local meetup_url = meta.event.meetup_url and pandoc.utils.stringify(meta.event.meetup_url) or nil

    local meetup_label = "If you plan on attending in person, please"
    local meetup_link_txt = "register on Meetup"

    local meetup_link
    if meetup_url then
      meetup_link = string.format("%s [%s](%s)", meetup_label, meetup_link_txt, meetup_url)
      meetup_link = pandoc.MetaInlines(pandoc.read(meetup_link, "markdown").blocks[1].content)
    else
      meetup_link = pandoc.MetaInlines(pandoc.Str(""))
    end

    -- Add the meetup link if there is on (or a blank string) to the event
    -- metadata
    meta.event["meetup-link"] = meetup_link
  end

  return meta
end
