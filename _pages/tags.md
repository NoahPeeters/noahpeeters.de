---
permalink: /tags/
excerpt: Content sorted by tags
title: Tags
---

{% assign pages = site.posts %}
{% assign pages = pages | concat: site.teaching %}
{% assign pages = pages | concat: site.publications %}
{% assign pages = pages | concat: site.portfolio %}
{% assign pages = pages | concat: site.news %}

{% include group-by-array collection=pages field="tags" %}

{% for tag in group_names %}
  {% assign posts = group_items[forloop.index0] %}
  <h2 id="{{ tag | slugify }}" class="archive__subtitle">{{ tag }}</h2>
  {% for post in posts %}
    {% include archive-single.html %}
  {% endfor %}
{% endfor %}
