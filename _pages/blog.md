---
permalink: /blog/
excerpt: My blog
title: Blog posts
layout: collection
entries_layout: grid
collection: posts

---

In this blog, I might irregularly post stuff.
{: .notice--info}

<!-- {% capture written_year %}'None'{% endcapture %}
{% for post in site.posts %}
  {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
  {% if year != written_year %}
    {% include archive-subtitle.html subtitle=year %}
    {% capture written_year %}{{ year }}{% endcapture %}
  {% endif %}
  {% include archive-single.html %}
{% endfor %} -->
