# media_transfer
My camera Sony has files structure like this
```
G:.
+---PRIVATE
|   +---SONY
|   +---DATABASE
|   |       DATABASE.BIN
|   |
|   \---M4ROOT
|       |   MEDIAPRO.XML
|       |
|       +---CLIP
|       |       C0014M01.XML
|       |       C0014.MP4
|       |       C0015M01.XML
|       |       C0015.MP4
|       |       C0016M01.XML
|       |       C0016.MP4
|       |       C0017M01.XML
|       |       C0017.MP4
|       |
|       +---GENERAL
|       +---SUB
|       |       C0014S03.MP4
|       |       C0015S03.MP4
|       |
|       +---TAKE
|       \---THMBNL
|               C0014T01.JPG
|               C0015T01.JPG
|               C0016T01.JPG
|               C0017T01.JPG
|
\---DCIM
    +---10020804
    |       DSC03221.ARW
    |       DSC03222.ARW
    |       DSC03223.ARW
    |       DSC03224.ARW
    |       DSC03225.ARW
    |       DSC03226.ARW
    |
    \---10120807
            DSC03379.ARW
            DSC03380.ARW
            DSC03381.ARW
            DSC03382.ARW
            DSC03383.ARW
            DSC03384.ARW
            DSC03385.ARW
            DSC03386.ARW
```
It is difficult to endure and systematize in your library. I like to store everything in folders on shooting dates

```
require 'media_transfer'

PHOTOS_OUTPUT_FOLDER = File.join('d:', 'MEDIA', 'PHOTOS')
VIDEOS_OUTPUT_FOLDER = File.join('d:', 'MEDIA', 'VIDEOS')

MediaTransfer::Sony.(PHOTOS_OUTPUT_FOLDER, VIDEOS_OUTPUT_FOLDER)
```

The script will automatically find the desired USB disk and copy files
```
D:\MEDIA.
+---PHOTOS
|   \---2022.08.04 - 2022.08.07
|       +---2022.08.04
|       |       DSC03221.ARW
|       |       DSC03222.ARW
|       |       DSC03223.ARW
|       |       DSC03224.ARW
|       |       DSC03225.ARW
|       |       DSC03226.ARW
|       |
|       \---2022.08.07
|               DSC03379.ARW
|               DSC03380.ARW
|               DSC03381.ARW
|               DSC03382.ARW
|               DSC03383.ARW
|               DSC03384.ARW
|               DSC03385.ARW
|               DSC03386.ARW
|
\---VIDEOS
    \---2022.08.05 - 2022.08.07
        +---2022.08.05
        |   +---CLIP
        |   |       C0014.MP4
        |   |       C0014M01.XML
        |   |       C0015.MP4
        |   |       C0015M01.XML
        |   |
        |   \---SUB
        |           C0014S03.MP4
        |           C0015S03.MP4
        |
        \---2022.08.07
            |   MEDIAPRO.XML
            |
            \---CLIP
                    C0016.MP4
                    C0016M01.XML
                    C0017.MP4
                    C0017M01.XML
```
