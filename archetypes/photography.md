+++
title = "{{ replace .Name "-" " " | title }}"
date = {{ .Date }}
lastmod = {{ .Date }}
draft = true
type = "photography" # Explicitly sets the content type
album = ""           # e.g., "Street Photography", "Landscape", "Portraits"
location = ""        # e.g., "London, UK", "Dolomites, Italy"
camera = ""          # e.g., "Fujifilm X-T4", "Canon EOS 5D Mark IV"
lens = ""            # e.g., "Fujinon XF 35mm f/1.4", "Canon EF 70-200mm f/2.8L"
iso = 0              # e.g., 200, 400, 1600
shutter_speed = ""   # e.g., "1/250s", "30s"
aperture = ""        # e.g., "f/1.4", "f/8", "f/16"
focal_length = ""    # e.g., "35mm", "200mm"
tags = []            # e.g., ["black and white", "urban", "night sky"]
image = ""           # Path to the main image for this entry (e.g., "/images/my-photo-1.jpg")
# description = "A brief description of this photograph or gallery"
+++

Describe the photo or gallery here. You can include details about the subject, the moment it was captured, or the creative process.

You could embed the image directly using Markdown:
![{{ .Title }}]({{ .Params.image | default "/images/placeholder.jpg" }})

Or add more images if it's a gallery.
