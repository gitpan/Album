package Album::Tutorial;

( $VERSION ) = '$Revision: 1.4 $ ' =~ /\$Revision:\s+([^\s]+)/;

# NOTE: This is a documentation-only module.

use strict;

=pod

=head1 NAME

Album::Tutorial - How to use the Album program

=head1 SYNOPSIS

This tutorial describes the basic use of the Album program to create
and maintain HTML based photo albums.

=head1 DESCRIPTION

=head2 Getting started

To get started, create a new directory and cd to it. Create a
subdirectory 'large' and put some pictures there. If you have
installed the 'album' tool in your execution path, you can now execute
it as follows:

  $ album -v
  No info.dat, adding images from large
  info.dat: Cannot update (does not exist)
  Number of entries = 7 (7 added)
  mkdir thumbnails
  mkdir icons
  Creating icons first-gr.png first.png ... sound.png movie.jpg done
  im023.jpg: thumbnail OK
  im024.jpg: thumbnail OK
  im025.jpg: thumbnail OK
  im026.jpg: thumbnail OK
  im027.jpg: thumbnail OK
  im028.jpg: thumbnail OK
  im029.jpg: thumbnail OK
  Creating pages for 7 images
  (Needed to write 7 image pages)
  Creating pages for 1 index
  (Needed to write 1 index page)

Your results will vary, but be similar to this example run. What you
can see is that 'album' found 7 images in the 'large' directory,
created thumbnails and icons directories, created thumbnails by
resizing the images, and finally created the HTML pages. You can
inspect your first photo album by opening file 'index.html' with your
favorite browser. You can click on any image to see the larger
version. Navigation buttons are provided to the left of the image.

It is interesting to run 'album' again:

  $ album -v
  No info.dat, adding images from large
  info.dat: Cannot update (does not exist)
  Number of entries = 7 (7 added)
  .......[7]
  Creating pages for 7 images
  (No image pages needed updating)
  Creating pages for 1 index
  (No index pages needed updating)

'album' tries to avoid doing unnecessary work as much as possible. In
this case, all thumbnails and image and index pages are up to date.
The line of periods shows progress, one period for each image
processed.

=head2 Adding medium sized images

The purpose of medium sized images is easy browsing by having a
consistent and convenient size. The default size shows normal 4:3
images completely on an 1024x768 screen in the browser's full screen
mode. 

To add medium sized images (and also specify an album title):

  $ album -v --medium --title "My First Album"
  No info.dat, adding images from large
  info.dat: Cannot update (does not exist)
  Number of entries = 7 (7 added)
  mkdir medium
  im023.jpg: medium OK
  im024.jpg: medium OK
  im025.jpg: medium OK
  im026.jpg: medium OK
  im027.jpg: medium OK
  im028.jpg: medium OK
  im029.jpg: medium OK
  Creating pages for 7 images
  (Needed to write 14 image pages)
  Creating pages for 1 index
  (Needed to write 1 index page)

Again, 'album' only does the work needed, re-using the work already
done.

=head2 Adding image descriptions

As can be seen from the example runs, 'album' looks for a file
'info.dat'. This file can be used to:

=over 4

=item *

control what images must be shown

=item *

the order in which they must be shown

=item *

whether rotation is necessary

=item *

set tag and description information

=item *

control other settings

=back

The format of 'info.dat' is simple. Empty lines and lines starting with
a '#' are ignored. Data lines contain the name of an image file,
followed by its description. Control lines start with an '!' mark.

'album' can fill 'info.dat' for you. To obtain this, create an empty
'info.dat' file, and run 'album':

  $ touch info.dat
  $ album -v --medium --title "My First Album"
  No info.dat, adding images from large
  Updating info.dat
  Number of entries = 7 (7 added)
  .......[7]
  Creating pages for 7 images
  (No image pages needed updating)
  Creating pages for 1 index
  (No index pages needed updating)

Upon completion, 'info.dat' will look similar to:

  # album control file generated by album 1.19, Tue Jun  1 22:39:41 2004
  !title My First Album
  !medium
  # New entries added by album 1.19, Tue Jun  1 22:39:41 2004
  !tag 
  im023.jpg  
  im024.jpg  
  im025.jpg  
  im026.jpg  
  im027.jpg  
  im028.jpg  
  im029.jpg  

You can now add a description for each image following the file name,
for example:

  !tag 2004/06/01
  im023.jpg  Sunrise
  im024.jpg  Overview
  im025.jpg  Across the lake
  im026.jpg  Catch of the day
  im027.jpg  Fishermen
  im028.jpg  Swimming cows
  im029.jpg  Moon over Clew Bay

Re-run the program (no need for B<--medium> and B<--title> anymore):

  $ album -v
  Number of entries = 7
  .......[7]
  Creating pages for 7 images
  (Needed to write 14 image pages)
  Creating pages for 1 index
  (Needed to write 1 index page)

There are no complaints anymore about a missing 'info.dat', but
there's also no message 'adding images from ./large'. In other words,
the only images shown are the ones named in the control file. New
images added to the 'large' directory will be ignored. We'll see later
what to do about that.

=head2 Summary of 'info.dat' control commands

Most settings can also obtained with command line options, as shown.

=over

=item B<!title> I<XXX>

Sets the title to I<XXX>, override with B<--title>.

=item B<!page> I<N>B<x>I<M>

Sets the layout to I<N> rows (B<--rows>) and I<M> columns (B<--columns>).

=item B<!thumbsize> NNN

Specifies the desired width for thumbnail images (B<--thumbsize>).

=item B<!medium>

Includes medium sized images (B<--medium>)

=item B<!mediumsize> I<NNN>

Specifies the desired width for medium sized images (B<--mediumsize>)

=item B<!tag> I<XXX>

Sets the tag line for all subsequent images. Cancel with and empty
B<!tag> command.

=item B<!caption>

Sets the caption code for index pages (B<--caption>). It must be a
sequence of B<f> (file name), B<s> (size, WxH), B<c> (caption), B<t>
(tag line). If no B<!caption> has been used, the default value is
B<fct>.

=back

=head2 Importing new images

An important feature of 'album' is importing new images from an
external source. For example, you can import new images from a CD-ROM,
or from a digital camera.

Assuming you mounted a CD-ROM with new images, execute 'album' as
follows:

  $ album -v --import /mnt/cdrom --update
  Updating info.dat
  Number of entries = 9 (2 added)
  .......[7]
  im030.jpg: copy medium thumbnail OK
  im031.jpg: copy medium thumbnail OK
  Creating pages for 9 images
  (Needed to write 18 image pages)
  Creating pages for 1 index
  (Needed to write 1 index page)

Two new images were found on the CD-ROM, copied to the 'large'
directory, and processed as usual. 'info.dat' has been updated with
the new entries. Note that images found on the CD-ROM that already
exist in 'large' (i.e., have the same name) are skipped.

=head2 Using EXIF information

When importing images from a digital camera, 'album' can use the EXIF
information that is present in these files:

=over 4

=item *

it will use the time stamp rename it to YYYYMMDDhhmmssSSSS (where SSSS
is a sequence number);

=item *

it will set the modification time of the file to the time stamp;

=item *

while copying the image, it will be rotated if necessary,
according to the 'orientation' property in the EXIF information.

=back

To enable EXIF processing, add the B<--exif> command line option, or
specify the import directory with B<--dcim> instead of B<--import>:

  $ ls -l /mnt/camera/dcim/101msdcf
  -rwxr-xr-x 1 jv jv 2347808 Jun 25 12:08 /mnt/camera/dcim/101msdcf/dsc00052.jpg
  -rwxr-xr-x 1 jv jv 1327475 Jun 25 12:05 /mnt/camera/dcim/101msdcf/dsc00053.jpg
  $ album -v --dcim /mnt/camera/dcim/101msdcf --update
  Updating info.dat
  Number of entries = 11 (2 added)
  .........[ 9]
  200405171843310052.jpg: link medium thumbnail OK
  200405171845030053.jpg: copy rotate medium thumbnail OK
  Creating pages for 11 images
  (Needed to write 22 image pages)
  Creating pages for 1 index
  (Needed to write 1 index page)

The file 'dsc00052.jpg' has now been imported as
'200405171843310052.jpg'. 'album' tries to link to the image, if that
is not possible, the image will be coped. File 'dsc00053.jpg' must be
rotated, so it will always be a copy.

If you hover the mouse over the file name in the index page, or over
the title on the image pages, a pop-up will show a selection of
information from the EXIF data.

=head2 Additional notes

The B<--clobber> command line option will force regeneration of all
medium and thumbnail images, and HTML pages. It will not force
re-import of the 'large' images. To completely rebuild everything
save info.dat, remove all the files in the album directory (including
.cache), restore info.dat and re-run the 'album' program.

The digital camera import is designed for cameras that adhere to the
ISO DCF standard. Handling of MPG movies and voice images is probably
specific for my Sony DSC-V1.

When importing images from different camera's, there's an extremely
small chance that the EXIF information would lead to identical file
names. This can only happen if the pictures were taken at the exact
same time (according to the camera's notion of time!), and have the
same internal sequence number.

=head1 AUTHOR AND CREDITS

Johan Vromans (jvromans@squirrel.nl) wrote this module.

=head1 COPYRIGHT AND DISCLAIMER

This program is Copyright 2004 by Squirrel Consultancy. All
rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of either: a) the GNU General Public License as
published by the Free Software Foundation; either version 1, or (at
your option) any later version, or b) the "Artistic License" which
comes with Perl.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See either the
GNU General Public License or the Artistic License for more details.

=cut

1;

# $Id: Tutorial.pm,v 1.4 2004/08/08 10:38:31 jv Exp $
