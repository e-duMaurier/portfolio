+++
title = "The Planet's Prestige"
date = "2024-11-10T22:06:33Z"
draft = false
categories = ["cybersecurity", "write-up"]
featuredImage = "/images/cybersec.jpeg"
tags = ["labs", "btlo" ]
keywords = ["cybersecurity", "labs", "btlo", "write-up"]
author = "{{ .Site.Params.Author }}"
+++

This is my write-up for 'The Planet's Prestige'. This is a CTF-Like challenge, that is now 'Retired', on the [Blue Team Labs Online](https://blueteamlabs.online/home) cybersecurity practice and challenge platform.

When challenges are retired, this means that leaderboard points are not awarded, but then write-ups for the challenge are permitted to be made public.  
I have only recently received a certification for cybersecurity, and I am using this platform as part of my learning experience to complete challenges and tasks. This is in an effort to better prepare me as I start to look into progressing in to the field of cybersecurity for a career.

ℹ️ While any URLs, email addressed, domains, and IP addresses may not be actual references, just in case that any of these do point to anything that can be directly linked to, I have 'defanged' any references.  
All references will have the square brackets '[]' placed around any periods '.' or at '@' symbols.

## Scenario:

CoCanDa, a planet known as 'The Heaven of the Universe' has been having a bad year. A series of riots have taken place across the planet due to the frequent abduction of citizens, known as CoCanDians, by a mysterious force. CoCanDa’s Planetary President arranged a war-room with the best brains and military leaders to work on a solution. After the meeting concluded the President was informed his daughter had disappeared. CoCanDa agents spread across multiple planets were working day and night to locate her. Two days later and there’s no update on the situation, no demand for ransom, not even a single clue regarding the whereabouts of the missing people. On the third day a CoCanDa representative, an Army Major on Earth, received an email.

## Process of Investigation:

****Extracting the File:****  
The zip file contained only one file, an email file 'A Hope to CoCanDa.eml', and I opened this in a text editor, so that I could get a full view of all the data.  
  
****Finding the Email Service Domain:****  
I first searched the text representation of the email for the word 'Received' so that I could quickly scan the document for any reference to the originating domain.  
I find the line 'Received: from localhost (emkei[.]cz. [93[.]99[.]104[.]210])' which indicated the email service used was emkei[.]cz

![](https://blog.techwhiskers.com/content/images/2024/11/00_domain.cleaned.png)

****The Reply-To Email Address:****  
Searching through the document for 'Reply-To' pointed me to the email address egeja3921[@]pashter[.]com

![](https://blog.techwhiskers.com/content/images/2024/11/01_reply_to.cleaned.png)

****Email Attachments:****  
Opening the email in a mail application, I could now see the message content in the email.

> Hi TheMajorOnEarth,  
> The abducted CoCanDians are with me including the President’s daughter. Dont worry. They are safe in a secret location.  
> Send me 1 Billion CoCanDs🤑 in cash💸 with a spaceship🚀 and my autonomous bots will safely bring back your citizens.  
> I heard that CoCanDians have the best brains in the Universe. Solve the puzzle I sent as an attachment for the next steps.  
> I’m approximately 12.8 light minutes away from the sun and my advice for the puzzle is  
> “Don't Trust Your Eyes”  
> Lol😂

There was also an attachment on the email, a document named as 'PuzzleToCoCanDa.pdf', which I then downloaded to my investigation folder.  
  
****Extracting the Attachment:****  
Checking the downloaded file from the email with the `file` command, the PDF file is actually a zip file, that has been renamed.

```bash
file PuzzleToCoCanDa.pdf
```

![](https://blog.techwhiskers.com/content/images/2024/11/04_not_pdf.cleaned.png)

I renamed the PDF document to a zip file, then extracted the contents. This contained 3 new files, named 'DaughtersCrown', 'GoodJobMajor' and 'Money.xlsx'.  
Using `file filename` again to check each file, 'DaughtersCrown' returns as a JPEG image, 'GoodJobMajor' is a PDF document, and 'Money.xlsx' shows it's a Microsoft Excel 2007+ document.  
  
****Finding the Author:****  
With the files extracted from the attachment, I then ran each file with the exif tool, and 'GoodJobMajor' shows that the PDF has the author metadata still attached, showing the author as 'Pestero Negeja'

![](https://blog.techwhiskers.com/content/images/2024/11/05_author.cleaned.png)

****Discovering the Location:****  
I wanted to find whatever information I could from 'Money.xlsx' without opening it directly, so I extracted the file to another directory. Within this directory, inside the 'xl' directory, after opening 'sharedStrings.xml' in a text editor, there is an entry that appears to be base64 encoded text.

![](https://blog.techwhiskers.com/content/images/2024/11/06_base64.cleaned.png)

Using CyberChef, I decoded this string to its plaintext value - 'The Martian Colony, Beside Interplanetary Spaceport.'

![](https://blog.techwhiskers.com/content/images/2024/11/07_location.cleaned.png)

****Bot Domain:****  
Based on the domain in the reply-to email address, I believed this would also be the likely domain of the C&C to control the bots, and would be hosted at pashter[.]com

# Challenge Questions and Answers:

1. What is the email service used by the malicious actor? emkei[.]cz
2. What is the Reply-To email address? egeja3921[@]pashter[.]com
3. What is the filetype of the received attachment which helped to continue the investigation? .zip
4. What is the name of the malicious actor? Pestero Negeja
5. What is the location of the attacker in this Universe? The Martian Colony, Beside Interplanetary Spaceport
6. What could be the probable C&C domain to control the attacker’s autonomous bots? pashter[.]com

# References:

- [CyberChef](https://gchq.github.io/CyberChef/)
- [Blue Team Labs Online](https://blueteamlabs.online/)