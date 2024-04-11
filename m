Return-Path: <netdev+bounces-87104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C28A1C55
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE81F28957
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9B16C86B;
	Thu, 11 Apr 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FQVrBt1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2B161311
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852299; cv=none; b=Q5BwgfYt5GsKWzefoQadZPXd2GIr45BXbl1NRwrwO4hYMMMnhc48hC0RcCg4XKKjP44CVRVftDSJ3TQOa9Mx3Ux6BPX2FN9vsm89KJQ3tVkQb6saYoruxOD8gq4DBIRnEoH6d+0ZO1Q9rswHM3EedBcMNOMbz+zjFdFm2Ps71PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852299; c=relaxed/simple;
	bh=tDxeBacMW2aRJEqgfDymIFF6NGEgSKfxUfLkNd0hwsU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I97kyz4YnV6M9ukVtRLxXhc3bQDOa83vPT7ziK75n2jzMImb0lkNqz+RqeoCEb85vZS0SPI7zo6NIpwQbcmmWjGh3eJdHhkQjEISBszyDEN0XoWu39NdKbES2o1FoGBDdfjbzmasK8PvABgYbfGtJw2SZulHaMF3O0J890ylaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FQVrBt1L; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712852289; x=1713111489;
	bh=LDwEE3J7o+FzBfaW4LNZVR58GR8itFvAZ5W3JW2Qlv4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FQVrBt1LLq9ab0gAv5hW8A+7k8URr3GQZVlaqM89nqQn+I11d9cVSWErKEbmpt9eF
	 Cb+VXWfQaPY0qcdQGN5oaxwsIUFK5WmBJCeyE5PYwcjbe2EFMqsKTstYTB5tew5bcr
	 kfY2vaDnytjtHE3TK+qdM9SqwD6h6XvbDLGjvw3/+qbuJG4wiTaKHlFmxb0kMLNamo
	 ZT6Q5bfnbUn6iPUuc/2k5W7sEc3XiKvkdQBSoGaPe1V6C1i5ywC5wxzYKuJyZ62jRu
	 U5QDUo2ZGJQMMXxVwTKLP2lHge60a74B0q/2TvJwH6o32E1SM/rv7yMiKEEqDC7rH4
	 G9QXvDvzGPyUQ==
Date: Thu, 11 Apr 2024 16:17:53 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Notes on Upgrading Firmware on HPE MSR954 Router and Enabling Web Interface - Version 1
Message-ID: <XmSiEMIKAgEaZGzNRPPPlW26owlkxz1y0tt15kV0BuhS6R6T9aCaIm15u18hFsK000GqKC7mR038HF1d7YzLhOvl2AM9u4AbozRo_ni623M=@protonmail.com>
Feedback-ID: 39510961:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Teo En Ming's Notes on Upgrading Firmware on HPE MSR954 Router and=
 Enabling Web Interface - Version 1

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date of Action: 11 Apr 2024 Thursday
Time: 8.30 PM to 11.00 PM

Step 1: Configuring IP address on router port GE1 to prepare for TFTP opera=
tion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Startup configuration file does not exist.
Performing automatic configuration... Press CTRL_D to break.

Automatic configuration attempt: 1.
Not ready for automatic configuration: no interface available.
Waiting for the next...

Automatic configuration attempt: 2.
Interface used: Vlan-interface1.
Enable DHCP client on Vlan-interface1.
Vlan-interface1 failed to obtain IP address.
Waiting for the next...
Automatic configuration is aborted.
Line con0 is available.


Press ENTER to get started.

<HPE>system-view

[HPE]interface Vlan-interface 1

[HPE-Vlan-interface1]ip address 192.168.1.1 255.255.255.0

[HPE-Vlan-interface1]end

<HPE>show ip int br
*down: administratively down
(s): spoofing  (l): loopback
Interface                Physical Protocol IP Address      Description
GE0/0                    down     down     --              --
GE0/5                    down     down     --              --
Vlan1                    up       up       192.168.1.1     --

Step 2: Download and install Open TFTP Server and Configure Management Work=
station
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Download Open TFTP Server from https://sourceforge.net/projects/tftp-server=
/

Install Open TFTP Server Installer.

Configure IP address of management workstation as 192.168.1.2/24

Copy LATEST firmware image file MSR954-CMW710-R6728P27.ipe to C:\OpenTFTPSe=
rver

Double click RunStandAloneMT.bat

Turn off GlassWire firewall.

Turn off Windows Defender firewall.

Step 3: TFTP Operation for the firmware
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<HPE>tftp 192.168.1.2 get MSR954-CMW710-R6728P27.ipe

The following attempt at installing the latest firmware failed because of i=
nsufficient space on the flash memory.

<HPE>boot-loader file flash:/MSR954-CMW710-R6728P27.ipe main
Verifying the file flash:/MSR954-CMW710-R6728P27.ipe on the device.......Do=
ne.
HPE MSR954 images in IPE:
  msr954-cmw710-boot-r6728p27.bin
  msr954-cmw710-system-r6728p27.bin
  msr954-cmw710-wifidog-r6728p27.bin
  msr954-cmw710-wwd-r6728p27.bin
  msr954-cmw710-security-r6728p27.bin
  msr954-cmw710-voice-r6728p27.bin
  msr954-cmw710-data-r6728p27.bin
This command will set the main startup software images. Continue? [Y/N]:y
Add images to the device.
No sufficient storage space on the device.

Step 4: Delete unnecessary files on the flash memory to free up space=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<HPE>delete flash:/msr954*.bin
Delete flash:/msr954-cmw710-boot-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-boot-r0306p30.bin... Done.
Delete flash:/msr954-cmw710-data-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-data-r0306p30.bin... Done.
Delete flash:/msr954-cmw710-security-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-security-r0306p30.bin... Done.
Delete flash:/msr954-cmw710-system-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-system-r0306p30.bin... Done.
Delete flash:/msr954-cmw710-voice-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-voice-r0306p30.bin... Done.
Delete flash:/msr954-cmw710-wifidog-r0306p30.bin? [Y/N]:y
Deleting file flash:/msr954-cmw710-wifidog-r0306p30.bin... Done.


<HPE>delete flash:/logfile/*
Delete flash:/logfile/logfile1.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile1.log.gz... Done.
Delete flash:/logfile/logfile10.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile10.log.gz... Done.
Delete flash:/logfile/logfile2.log? [Y/N]:y
Deleting file flash:/logfile/logfile2.log... Done.
Delete flash:/logfile/logfile2.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile2.log.gz... Done.
Delete flash:/logfile/logfile3.log? [Y/N]:y
Deleting file flash:/logfile/logfile3.log... Done.
Delete flash:/logfile/logfile4.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile4.log.gz... Done.
Delete flash:/logfile/logfile5.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile5.log.gz... Done.
Delete flash:/logfile/logfile6.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile6.log.gz... Done.
Delete flash:/logfile/logfile7.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile7.log.gz... Done.
Delete flash:/logfile/logfile8.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile8.log.gz... Done.
Delete flash:/logfile/logfile9.log.gz? [Y/N]:y
Deleting file flash:/logfile/logfile9.log.gz... Done.

<HPE>dir flash:/
Directory of flash:
   0 -rw-    93636608 Jan 01 2011 00:29:51   MSR954-CMW710-R6728P27.ipe
   1 drw-           - Jan 01 2011 00:00:10   diagfile
   2 -rw-         735 Jan 01 2011 00:07:25   hostkey
   3 -rw-         228 Jan 01 2011 00:12:54   ifindex.dat
   4 drw-           - Jan 01 2011 00:00:10   license
   5 drw-           - Jan 01 2011 00:36:14   logfile
   6 drw-           - Jan 01 2011 00:00:10   seclog
   7 -rw-         591 Jan 01 2011 00:07:25   serverkey
   8 -rw-        5735 Jan 01 2011 00:12:55   startup.cfg
   9 -rw-       61417 Jan 01 2011 00:12:55   startup.mdb

251904 KB total (86996 KB free)

<HPE>delete flash:/startup.mdb
Delete flash:/startup.mdb? [Y/N]:y
Deleting file flash:/startup.mdb... Done.


<HPE>dir /all
Directory of flash:
   0 -rw-    93636608 Jan 01 2011 00:29:51   MSR954-CMW710-R6728P27.ipe
   1 drw-           - Jan 01 2011 00:00:10   diagfile
   2 -rw-         735 Jan 01 2011 00:07:25   hostkey
   3 -rw-         228 Jan 01 2011 00:12:54   ifindex.dat
   4 drw-           - Jan 01 2011 00:00:10   license
   5 drw-           - Jan 01 2011 00:36:14   logfile
   6 drw-           - Jan 01 2011 00:00:10   seclog
   7 -rw-         591 Jan 01 2011 00:07:25   serverkey
   8 -rw-        5735 Jan 01 2011 00:12:55   startup.cfg
   9 drwh           - Jan 01 2011 00:45:44   .trash


<HPE>rmdir flash:/.trash
Remove directory flash:/.trash and the files in the recycle-bin under this =
directory will be deleted permanently. Continue? [Y/N]:y
Failed to remove the directory because it is not empty.

<HPE>dir flash:/.trash/
Directory of flash:/.trash
   0 -rw-      362875 Jun 24 2011 11:12:32   logfile1.log.gz_0001
   1 -rw-      307359 Jan 07 2011 13:01:22   logfile10.log.gz_0001
   2 -rw-      332922 Jan 07 2011 11:11:52   logfile2.log.gz_0001
   3 -rw-     3633086 Jan 07 2011 20:06:45   logfile2.log_0001
   4 -rw-     5216633 Jul 19 2011 10:45:11   logfile3.log_0001
   5 -rw-      370150 Jul 02 2011 19:51:51   logfile4.log.gz_0001
   6 -rw-      356413 Jun 27 2011 21:30:47   logfile5.log.gz_0001
   7 -rw-      355667 Jul 05 2011 10:05:21   logfile6.log.gz_0001
   8 -rw-      363096 Jul 11 2011 10:40:24   logfile7.log.gz_0001
   9 -rw-      371726 Jul 17 2011 06:21:00   logfile8.log.gz_0001
  10 -rw-      354088 Jul 08 2011 19:24:06   logfile9.log.gz_0001
  11 -rw-     6972416 Jan 01 2013 00:00:00   msr954-cmw710-boot-r0306p30.bi=
n_0001
  12 -rw-     2955264 Jan 01 2013 00:00:00   msr954-cmw710-data-r0306p30.bi=
n_0001
  13 -rw-      387072 Jan 01 2013 00:00:00   msr954-cmw710-security-r0306p3=
0.bin_0001
  14 -rw-    51291136 Jan 01 2013 00:00:00   msr954-cmw710-system-r0306p30.=
bin_0001
  15 -rw-       12288 Jan 01 2013 00:00:00   msr954-cmw710-voice-r0306p30.b=
in_0001
  16 -rw-      116736 Jan 01 2013 00:00:00   msr954-cmw710-wifidog-r0306p30=
.bin_0001
  17 -rw-       61417 Jan 01 2011 00:12:55   startup.mdb_0001

251904 KB total (86996 KB free)

<HPE>delete flash:/.trash/msr954-cmw710-boot-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-boot-r0306p=
30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-boot-r0306p30.bin_0001... Done.

<HPE>delete flash:/.trash/msr954-cmw710-data-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-data-r0306p=
30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-data-r0306p30.bin_0001... Done.

<HPE>delete flash:/.trash/msr954-cmw710-security-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-security-r0=
306p30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-security-r0306p30.bin_0001... Don=
e.

<HPE>delete flash:/.trash/msr954-cmw710-system-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-system-r030=
6p30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-system-r0306p30.bin_0001... Done.

<HPE>delete flash:/.trash/msr954-cmw710-voice-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-voice-r0306=
p30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-voice-r0306p30.bin_0001... Done.

<HPE>delete flash:/.trash/msr954-cmw710-wifidog-r0306p30.bin_0001
The file cannot be restored. Delete flash:/.trash/msr954-cmw710-wifidog-r03=
06p30.bin_0001? [Y/N]:y
Deleting the file permanently will take a long time. Please wait...
Deleting file flash:/.trash/msr954-cmw710-wifidog-r0306p30.bin_0001... Done=
.


<HPE>dir flash:/.trash/
Directory of flash:/.trash
   0 -rw-      362875 Jun 24 2011 11:12:32   logfile1.log.gz_0001
   1 -rw-      307359 Jan 07 2011 13:01:22   logfile10.log.gz_0001
   2 -rw-      332922 Jan 07 2011 11:11:52   logfile2.log.gz_0001
   3 -rw-     3633086 Jan 07 2011 20:06:45   logfile2.log_0001
   4 -rw-     5216633 Jul 19 2011 10:45:11   logfile3.log_0001
   5 -rw-      370150 Jul 02 2011 19:51:51   logfile4.log.gz_0001
   6 -rw-      356413 Jun 27 2011 21:30:47   logfile5.log.gz_0001
   7 -rw-      355667 Jul 05 2011 10:05:21   logfile6.log.gz_0001
   8 -rw-      363096 Jul 11 2011 10:40:24   logfile7.log.gz_0001
   9 -rw-      371726 Jul 17 2011 06:21:00   logfile8.log.gz_0001
  10 -rw-      354088 Jul 08 2011 19:24:06   logfile9.log.gz_0001
  11 -rw-       61417 Jan 01 2011 00:12:55   startup.mdb_0001

251904 KB total (147428 KB free)

Step 5: Installing the LATEST firmware on the HPE MSR954 router
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

<HPE>boot-loader file flash:/MSR954-CMW710-R6728P27.ipe main
Verifying the file flash:/MSR954-CMW710-R6728P27.ipe on the device.......Do=
ne.
HPE MSR954 images in IPE:
  msr954-cmw710-boot-r6728p27.bin
  msr954-cmw710-system-r6728p27.bin
  msr954-cmw710-wifidog-r6728p27.bin
  msr954-cmw710-wwd-r6728p27.bin
  msr954-cmw710-security-r6728p27.bin
  msr954-cmw710-voice-r6728p27.bin
  msr954-cmw710-data-r6728p27.bin
This command will set the main startup software images. Continue? [Y/N]:y
Add images to the device.
Decompressing file msr954-cmw710-wwd-r6728p27.bin to flash:/msr954-cmw710-w=
wd-r6728p27.bin...Done.
Decompressing file msr954-cmw710-wifidog-r6728p27.bin to flash:/msr954-cmw7=
10-wifidog-r6728p27.bin...Done.
Decompressing file msr954-cmw710-data-r6728p27.bin to flash:/msr954-cmw710-=
data-r6728p27.bin...Done.
Decompressing file msr954-cmw710-voice-r6728p27.bin to flash:/msr954-cmw710=
-voice-r6728p27.bin...Done.
Decompressing file msr954-cmw710-security-r6728p27.bin to flash:/msr954-cmw=
710-security-r6728p27.bin...Done.
Decompressing file msr954-cmw710-system-r6728p27.bin to flash:/msr954-cmw71=
0-system-r6728p27.bin........................................Done.
Decompressing file msr954-cmw710-boot-r6728p27.bin to flash:/msr954-cmw710-=
boot-r6728p27.bin.....Done.
The images that have passed all examinations will be used as the main start=
up software images at the next reboot on the device.

Verifying that the latest firmware has been installed.

<HPE>display boot-loader
Software images on the device:
Current software images:
  flash:/msr954-cmw710-boot-r0306p30.bin
  flash:/msr954-cmw710-system-r0306p30.bin
  flash:/msr954-cmw710-wifidog-r0306p30.bin
  flash:/msr954-cmw710-security-r0306p30.bin
  flash:/msr954-cmw710-voice-r0306p30.bin
  flash:/msr954-cmw710-data-r0306p30.bin
Main startup software images:
  flash:/msr954-cmw710-boot-r6728p27.bin
  flash:/msr954-cmw710-system-r6728p27.bin
  flash:/msr954-cmw710-wifidog-r6728p27.bin
  flash:/msr954-cmw710-wwd-r6728p27.bin
  flash:/msr954-cmw710-security-r6728p27.bin
  flash:/msr954-cmw710-voice-r6728p27.bin
  flash:/msr954-cmw710-data-r6728p27.bin
Backup startup software images:
  None

Rebooting the HPE MSR954 router.

<HPE>reboot
Start to check configuration with next startup configuration file, please w=
ait.........DONE!
Current configuration may be lost after the reboot, save current configurat=
ion? [Y/N]:n
This command will reboot the device. Continue? [Y/N]:y
Now rebooting, please wait...
%Jan  1 01:00:07:296 2011 HPE DEV/5/SYSTEM_REBOOT: System is rebooting now.

Step 6: Enabling Web Interface on the HPE MSR954 Router
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Startup configuration file doesn't exist or is invalid.
Performing automatic configuration... Press CTRL_C or CTRL_D to break.

Automatic configuration attempt: 1.
Not ready for automatic configuration: no interface available.
Waiting for the next...

Automatic configuration attempt: 2.
Interface used: Vlan-interface1.
Enable DHCP client on Vlan-interface1.
Vlan-interface1 failed to obtain IP address.
Waiting for the next...
Automatic configuration is aborted.



<HPE>system-view
[HPE]interface Vlan-interface 1
[HPE-Vlan-interface1]ip address 192.168.1.1 255.255.255.0

[HPE]ip https enable

You can now browse the web interface using https://192.168.1.1/

Google Chrome doesn't display the web interface properly. You need to use M=
icrosoft Edge.

But I don't know the default username and password, need to check it out la=
ter.

Step 7: Remember to save the router configuration before shutting down
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[HPE]save
The current configuration will be written to the device. Are you sure? [Y/N=
]:y
Please input the file name(*.cfg)[flash:/startup.cfg]
(To leave the existing filename unchanged, press the enter key):
flash:/startup.cfg exists, overwrite? [Y/N]:y
Validating file. Please wait...
Configuration is saved to device successfully.

Reference Guides
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[1] 07-Software upgrade configuration

Link: https://www.h3c.com/en/d_201905/1178175_294551_0.htm

[2] Router HPE MSR954 Web interface

Link: https://community.hpe.com/t5/comware-based/router-hpe-msr954-web-inte=
rface/td-p/6940091

[3] dir

Link: https://techhub.hpe.com/eginfolib/networking/docs/switches/5700/5998-=
5600r_fund_cr/content/447037782.htm




Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems






