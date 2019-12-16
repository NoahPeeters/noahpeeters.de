---
permalink: /tags/
excerpt: Content sorted by tags
title: Tags
search: false
---

{% include all-pages %}
{% include group-by-array collection=pages field="tags" %}

{% for tag in group_names %}
  {% unless tag == '' %}
  {% assign posts = group_items[forloop.index0] %}
  <h2 id="{{ tag | slugify }}" class="archive__subtitle">{{ tag }}</h2>
  {% for post in posts %}
    {% include archive-single.html %}
  {% endfor %}
  {% endunless %}
{% endfor %}
