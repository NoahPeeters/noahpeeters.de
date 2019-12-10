---
layout: null
---

{% assign docs = site.pages | where_exp:'doc','doc.search != false' | where_exp:'doc','doc.title != null' %}

{%- for c in site.collections -%}
  {%- assign filtered_docs = c.docs | where_exp:'doc','doc.search != false' -%}
  {%- assign docs = docs | concat: filtered_docs -%}
{%- endfor -%}

var store = [
    {%- for doc in docs -%}
      {%- if doc.header.teaser -%}
        {%- capture teaser -%}{{ doc.header.teaser }}{%- endcapture -%}
      {%- else -%}
        {%- assign teaser = site.teaser -%}
      {%- endif -%}
      {%- capture doc_text -%}
        {%- if site.search_full_content == true -%}
          {{ doc.content | newline_to_br |
            replace:"<br />", " " |
            replace:"</p>", " " |
            replace:"</h1>", " " |
            replace:"</h2>", " " |
            replace:"</h3>", " " |
            replace:"</h4>", " " |
            replace:"</h5>", " " |
            replace:"</h6>", " "|
            split:"{"|first|
            strip_html | strip_newlines | strip }}
        {%- else -%}
          {{ doc.content | newline_to_br |
            replace:"<br />", " " |
            replace:"</p>", " " |
            replace:"</h1>", " " |
            replace:"</h2>", " " |
            replace:"</h3>", " " |
            replace:"</h4>", " " |
            replace:"</h5>", " " |
            replace:"</h6>", " "|
            split:"{"|first|
            strip_html | strip_newlines | strip | truncatewords: 50 }}
        {%- endif -%}
      {%- endcapture -%}

      {% assign truncated_doc_text = doc_text | truncatewords: 20 %}

      {
        "title": {{ doc.title | jsonify }},
        "excerpt": {{ doc.excerpt | default: truncated_doc_text | jsonify }},
        "fulltext": {{ doc_text | jsonify }},
        "categories": {{ doc.categories | jsonify }},
        "tags": {{ doc.tags | jsonify }},
        "url": {{ doc.url | absolute_url | jsonify }},
        "teaser":
          {%- if teaser contains "://" -%}
            {{ teaser | jsonify }}
          {%- else -%}
            {{ teaser | absolute_url | jsonify }}
          {%- endif -%}
      },
    {%- endfor -%}]
