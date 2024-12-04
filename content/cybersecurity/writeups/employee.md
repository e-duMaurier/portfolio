+++
date = '2024-12-03T23:42:02Z'
draft = true
title = 'Employee'
+++

# Employee of the Year

This is my write-up for the retired [Blue Team Labs Online](https://blueteamlabs.online/ "Blue Team Labs Online") challenge '[Employee of the Year](https://blueteamlabs.online/home/challenge/employee-of-the-year-df16bc36f3 "Employee of the Year")'.

## Scenario
On a Friday evening when you were in a mood to celebrate your weekend, your team was alerted with a new RCE vulnerability actively being exploited in the wild. You have been tasked with analysing and researching the sample to collect information for the weekend team.

## Process of Investigation:
This challenge took some additional work before I could start work on the investigation. After downloading and extracting the contents of the challenge zip file, there was just one file, 'recoverfiles.dd'.
A .dd file is a copy of a partition, or disk image, and it is possible to retrieve data from this image file without the need to mount it in the operating system.  
  
Using `strings recoverfiles.dd` I could see some information from the disk image.  
While a lot of the data is unreadable, due to the file being a binary file, there was some readable text, some filenames, and folders.

[image to be inserted here]

Some of this data can be extracted with `scalpel`, but first the configuration file would need to be edited, so that the `scalpel` application can recover .gif image types, by removing the hash '#' comment indicators.

```
sudo nano /etc/scalpel/scalpel.conf
```

After saving the changes to the configuration file, I created a directory to hold the recovered data, within my investigation directory, then ran `scalpel` against the disk image file.

```
mkdir recovery
scalpel -o recovery recoverfiles.dd
```

A directory containing the recovered files, and an audit text file, were created in the selected directory.  
In the `gif-1-0` directory that was created, I saw a single .gif file.  
The file did not load all the frames when opening up in an image viewer, but there was a frame containing the text “GoodJobDefender”.

[image to be inserted here]

There wasn't much more I could get from using scalpel, unless I knew the extensions of the files that I wanted to retrieve.  
There was another tool that could be of use here, though. `Photorec` can help recover lost files from disk drives.  
  
I created a directory to store the recovery files, then I ran `photorec` against the 'recoverfiles.dd' file.

```
mkdir rec
sudo photorec recoverfiles.dd
```

`Photorec` presents several menu options at each step through the process:

1. Selecting the media source
2. Selecting disk or partition
3. The filesystem type
4. To analyse all space or free space
5. Destination directory to recover the files to

I know had several files recovered to look through.

```
-rw-r--r-- 1 root root  93K Nov 14 22:44 f0008848.gif
-rw-r--r-- 1 root root  13K Nov 14 22:44 f0009040.pdf
-rw-r--r-- 1 root root 6.1K Feb 12  2021 f0009072.docx
-rw-r--r-- 1 root root 732K Nov 14 22:44 f0016384.mp4
-rw-r--r-- 1 root root  17K Nov 14 22:44 f0017848.png
-rw-r--r-- 1 root root 3.2K Nov 14 22:45 report.xml
```

I started with the other image file that had been recovered, 'f0017848.png'. This image just contained the text “FLAG1:WELOVEBTLO”. I checked the metadata with `exiftool` of both of these files, and no additional information was recovered.

[image to be inserted here]

The metadata for the .docx file also didn't provide any helpful data. Running the file against `oleid` I saw that the file wasn't encrypted, contained no VBA or XLM macro’s or any external relationships. I still didn't want to open the file directly, though.

[image to be inserted here]

Listing the contents of the file with `unzip` from the terminal shows there is data to be extracted, now to get to that data using:

```
unzip f0009072.docx
```

With that, the files were extracted. The file I was interested in was 'document.xml' as this would be the likely location for any text in the document to be stored.

[image to be inserted here]

There was not much in the XML file, but there was text, which appeared to be base64 encoded.

[image to be inserted here]

The text was base64 encoded, and after putting it through CyberChef, I got the plaintext result- ”FLAG2:ASOLIDDEFENDER”.

[image to be inserted here]

I didn't find any further information from the DOCX file, so now I moved on to the PDF document.  
  
I started with passing the file through `exiftool`, and the document author metadata is displayed as “FLAG3%3A%40BLU3T3AM%240LDI3R”.

[image to be inserted here]

This text would need to be cleaned up first, so I put the text in to the [URL-formatted strings decoder](https://it-tools.tech/url-encoder "URL-formatted strings decoder") from IT-Tools, and got the cleaned text “FLAG3:@BLU3T3AM$0LDI3R”.  
  
Finding the filesystem of the disk image took some work. I didn't see anything definitive for the filesystem when using `photorec`, and trying with `fdisk`, `blkid`, and `kpartx`, didn't provide the information either.  
However, after some web searching, I found an article on [askubuntu.com](https://askubuntu.com/questions/1279716/how-to-open-dd-file-to-analyze-it "askubuntu.com") that indicated using `cfdisk` could be the answer, and it was the answer, displaying `ext4` as the filesystem after running:

```
cfdisk recoverfiles.dd
```

[image to be inserted here]

Finally, as I had done with all the other files, I started with 'f0016384.mp4' by running `exiftool` against it.  
  
To find the original filename of the recovered mp4 file, I went back to my first step of this process, when getting some initial data from the image file. The strings gave me several filenames, and the number of files and the extensions of these files, matched the number of files, and extensions recovered.  
Looking at this, I could see that the mp4 file in the original results was named 'SBTCertifications.mp4'.

[image to be inserted here]

# Challenge Questions and Answers:

1. **What is the text written on the recovered gif image?**
    - **Answer:** GoodJobDefender
2. **Submit Flag1:**
    - **Answer:** FLAG1:WELOVEBTLO
3. **Submit Flag2:**
    - **Answer:** FLAG2:ASOLIDDEFENDER
4. **Submit Flag3:**
    - **Answer:** FLAG3:@BLU3T3AM$0LDI3R
5. **What is the filesystem of the provided disk image?**
    - **Answer:** ext4
6. **What is the original filename of the recovered mp4 file?**
    - **Answer:** SBTCertifications.mp4

# Links:

- [https://blueteamlabs.online/home/challenge/employee-of-the-year-df16bc36f3](https://blueteamlabs.online/home/challenge/employee-of-the-year-df16bc36f3)
- [https://manpages.ubuntu.com/manpages/xenial/man8/kpartx.8.html](https://manpages.ubuntu.com/manpages/xenial/man8/kpartx.8.html)
- [https://gchq.github.io/CyberChef](https://gchq.github.io/CyberChef/)
- [https://it-tools.tech/](https://it-tools.tech/)
- [https://askubuntu.com/questions/1279716/how-to-open-dd-file-to-analyze-it](https://askubuntu.com/questions/1279716/how-to-open-dd-file-to-analyze-it)
