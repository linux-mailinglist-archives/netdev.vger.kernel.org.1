Return-Path: <netdev+bounces-64518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619E8358A2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 00:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009AA1F21761
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554038DFB;
	Sun, 21 Jan 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XElU9le+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B606381A5
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705878349; cv=none; b=Pm7CN5ZDmC2/Z6y3irug1HDtuTkPdt+0jAC6OmNRDyoXrRye10NGqLztLRvl9lx5rmhj9KmIOXRhRURw2Z7kpjx2yBc3M3PkjrEcwN7+e/QaH16HXl72M8BGgnG3mrmefQbMzTZh7NHXra9j+DD1jvALEC6xIb7vD7t2jjkjJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705878349; c=relaxed/simple;
	bh=hg8xdlM6GT7xYSb8QZAYhMncXhXG3PcTugEvMAS6v5I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=c1Wro5xs245nSCp3tAgUajcWCd/W/4wGik/9Ib4IoXpnl11GuFTNKmZAXXJUxfxxtQAVjfrhIdjAuEHwWrM2VuGHIcvS+BOT7ANndK0a4h3g7WkCFkF9saCRXdyxePBak41OR1IVpmp7cmtoU10Kaw65N2Mk46iTA6fcSDh4HQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XElU9le+; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1705878338; x=1706137538;
	bh=HkSqFMQNqMy74YTczzcS1IKaiyrpvHplXbx/lPfG2sE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XElU9le+BzDrtz2TiaPO/bZTPubQGnhOYb+c/7JPd2sDwd2VtaKhGUyN/WlYpSWKp
	 Zr4rlLrCY7DA3igoKhaOXasmgvGCvD2y1QLxB6Rv8XPtPgYDq0DvoYdjPb6MkWJbkk
	 CsFc85Sari84Pk13FBz7McELjhQhmzj8r86la551XHWquezFrjz+cy7Pe5banH3pcf
	 14sZrMSPCYhrpBkQF2pNXh5KFXE+dlgar+Uo/pB7xt+ZEEPTugvzr6RqqF5vOyxP9u
	 FMiTY41yxCEWtAOYGM2JtvRjx197fnh/masn/2FniqdR0Ii5yxvUcFVblPtzX2errH
	 niwhsMs8nT8/g==
Date: Sun, 21 Jan 2024 23:05:19 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Accidentally set Password Recovery Functionality to Disabled for Cisco ASA 5506-X Firewall After Following Guide with Conflicting Instructions
Message-ID: <JOhkKNLAc4s78ndVx8fG5cjGyh-Gc3XA4csUXYJuv4wk56cuZcff2t2gbtvAtkujWkL3nTOKdBirMvSIyc0OZWFKW2zZwWogvHI0kusQ5C4=@protonmail.com>
Feedback-ID: 39510961:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Accidentally set Password Recovery Functionality to Disabled for C=
isco ASA 5506-X Firewall After Following Guide with Conflicting Instruction=
s

Good day from Singapore,

On 12 Jan 2024 Friday, my colleague Danial Robinson asked me to go to our c=
ustomer office at Paya Lebar Square, Singapore to reset the password for Ci=
sco ASA 5506-X firewall.

When I putty into the console of Cisco ASA 5506-X firewall, I knew I was ab=
le to reset the password.

But alas! I had followed a guide with conflicting instructions.

The following is the guide with conflicting instructions.

Reference Guide: Password Recovery for the Cisco ASA 5500 Firewall (5505,55=
10,5520 etc)

Link: https://www.networkstraining.com/password-recovery-for-the-cisco-asa-=
5500-firewall/

When I came to Step 7 in the guide, it gave conflicting instructions.

Step 7 says: "Accept the default values for all settings (at the prompt ent=
er Y)", which is apparently contradictory.

Step 7 asks you to accept the default values for all settings and yet it co=
ntradicts itself by asking you to enter Y at the prompt.

Due to my carelessness and lack of careful thought, I had accidentally ente=
red Y when I was asked about setting password recovery to disabled. I had n=
ever thought my action would be permanent and irreversible.=20

This was a complete disaster. After the reboot, I could no longer reset the=
 password for Cisco ASA 5506-X firewall. The change was permanent and irrev=
ersible.

Every time I try to break into ROMMON mode, I was asked to permanently eras=
e disk0, which is the flash.

<CODE>

Rom image verified correctly


Cisco Systems ROMMON, Version 1.1.14, RELEASE SOFTWARE
Copyright (c) 1994-2018  by Cisco Systems, Inc.
Compiled Tue 06/05/2018 22:45:19.61 by builder


Current image running: Boot ROM0
Last reset cause: PowerOn
DIMM Slot 0 : Present

Platform ASA5506 with 4096 Mbytes of main memory
MAC Address: 74:88:bb:c8:72:bf


INFO: PASSWORD RECOVERY functionality is disabled.
WARNING: Password recovery and ROMMON command line access has been
disabled by your security policy. Answering YES below will cause ALL
configurations, passwords, images in 'disk0:' to be erased.
ROMMON command line access will be re-enabled, and a new image must be
downloaded via ROMMON.

Permanently erase 'disk0:'? no

</CODE>

Dear Cisco TAC support,

Is there any way to recover the startup-config without forcing me to perman=
ently erase the flash? Which will erase everything?

The following console output shows that I could not enter ROMMON mode at al=
l, after accidentally setting password recovery to disabled.

<CODE>

securevpn> reload
           ^
ERROR: % Invalid input detected at '^' marker.
securevpn>
Rom image verified correctly


Cisco Systems ROMMON, Version 1.1.14, RELEASE SOFTWARE
Copyright (c) 1994-2018  by Cisco Systems, Inc.
Compiled Tue 06/05/2018 22:45:19.61 by builder


Current image running: Boot ROM0
Last reset cause: PowerOn
DIMM Slot 0 : Present

Platform ASA5506 with 4096 Mbytes of main memory
MAC Address: 74:88:bb:c8:72:bf


INFO: PASSWORD RECOVERY functionality is disabled.
WARNING: Password recovery and ROMMON command line access has been
disabled by your security policy. Answering YES below will cause ALL
configurations, passwords, images in 'disk0:' to be erased.
ROMMON command line access will be re-enabled, and a new image must be
downloaded via ROMMON.

Permanently erase 'disk0:'? no
Located '.boot_string' @ cluster 997554.

#
Attempt autoboot: "boot disk0:/asa984-22-lfbff-k8.SPA"
Located 'asa984-22-lfbff-k8.SPA' @ cluster 969854.

###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
###########################################################################=
#####################################
LFBFF signature verified.
INIT: version 2.88 booting
Starting udev
Configuring network interfaces... done.
Populating dev cache
^[^[^[^[^[^[dosfsck 2.11, 12 Mar 2005, FAT32, LFN
There are differences between boot sector and its backup.
Differences: (offset:original/backup)
  65:01/00
  Not automatically fixing this.
Starting check/repair pass.
Starting verification pass.
/dev/sdb1: 138 files, 947320/1919830 clusters
dosfsck(/dev/sdb1) returned 0
Mounting /dev/sdb1
IO Memory Nodes: 1
IO Memory Per Node: 387973120 bytes

Global Reserve Memory Per Node: 314572800 bytes Nodes=3D1

LCMB: got 387973120 bytes on numa-id=3D0, phys=3D0x38800000, virt=3D0x2aaaa=
ae00000
LCMB: HEAP-CACHE POOL got 312475648 bytes on numa-id=3D0, virt=3D0x2aaac200=
0000
LCMB: HEAP-CACHE POOL got 2097152 bytes on numa-id=3D0, virt=3D0x2aaad4a000=
00
Processor memory:   1638667399
M_MMAP_THRESHOLD 65536, M_MMAP_MAX 25004
M_MMAP_THRESHOLD 65536, M_MMAP_MAX 25004
POST started...
POST finished, result is 0 (hint: 1 means it failed)

Compiled on Fri 29-May-20 00:37 PDT by builders

Total NICs found: 14
i354 rev03 Gigabit Ethernet @ irq255 dev 20 index 08 MAC: 7488.bbc8.72bf
ivshmem rev03 Backplane Data Interface     @ index 09 MAC: 0000.0001.0002
en_vtun rev00 Backplane Control Interface  @ index 10 MAC: 0000.0001.0001
en_vtun rev00 Backplane Int-Mgmt Interface     @ index 11 MAC: 0000.0001.00=
03
en_vtun rev00 Backplane Ext-Mgmt Interface     @ index 12 MAC: 0000.0000.00=
00
en_vtun rev00 Backplane Tap Interface     @ index 13 MAC: 0000.0100.0001
WARNING: Attribute already exists in the dictionary.
WARNING: Attribute already exists in the dictionary.
Verify the activation-key, it might take a while...
Running Permanent Activation Key:=20

Licensed features for this platform:
Maximum Physical Interfaces       : Unlimited      perpetual
Maximum VLANs                     : 5              perpetual
Inside Hosts                      : Unlimited      perpetual
Failover                          : Disabled       perpetual
Encryption-DES                    : Enabled        perpetual
Encryption-3DES-AES               : Enabled        perpetual
Carrier                           : Disabled       perpetual
AnyConnect Premium Peers          : 2              perpetual
AnyConnect Essentials             : Disabled       perpetual
Other VPN Peers                   : 10             perpetual
Total VPN Peers                   : 12             perpetual
AnyConnect for Mobile             : Disabled       perpetual
AnyConnect for Cisco VPN Phone    : Disabled       perpetual
Advanced Endpoint Assessment      : Disabled       perpetual
Shared License                    : Disabled       perpetual
Total TLS Proxy Sessions          : 2              perpetual
Botnet Traffic Filter             : Disabled       perpetual
Cluster                           : Disabled       perpetual

This platform has a Base license.

^[^[Encryption hardware device : Cisco ASA Crypto on-board accelerator (rev=
ision 0x1)

Cisco Adaptive Security Appliance Software Version 9.8(4)22

  ****************************** Warning *******************************
  This product contains cryptographic features and is
  subject to United States and local country laws
  governing, import, export, transfer, and use.
  Delivery of Cisco cryptographic products does not
  imply third-party authority to import, export,
  distribute, or use encryption. Importers, exporters,
  distributors and users are responsible for compliance
  with U.S. and local country laws. By using this
  product you agree to comply with applicable laws and
  regulations. If you are unable to comply with U.S.
  and local laws, return the enclosed items immediately.

  A summary of U.S. laws governing Cisco cryptographic
  products may be found at:
  http://www.cisco.com/wwl/export/crypto/tool/stqrg.html

  If you require further assistance please contact us by
  sending email to export@cisco.com.
  ******************************* Warning *******************************
Cisco Adaptive Security Appliance Software, version 9.8
Copyright (c) 1996-2019 by Cisco Systems, Inc.
For licenses and notices for open source software used in this product, ple=
ase visit
http://www.cisco.com/go/asa-opensource

                Restricted Rights Legend
Use, duplication, or disclosure by the Government is
subject to restrictions as set forth in subparagraph
(c) of the Commercial Computer Software - Restricted
Rights clause at FAR sec. 52.227-19 and subparagraph
(c) (1) (ii) of the Rights in Technical Data and Computer
Software clause at DFARS sec. 252.227-7013.

                Cisco Systems, Inc.
                170 West Tasman Drive
                San Jose, California 95134-1706

Reading from flash...
!!!!!...........
Cryptochecksum (unchanged): a44c49c9 4217b655 7de33b81 70c47440

INFO: Power-On Self-Test in process.
.......................................................................
INFO: Power-On Self-Test complete.

INFO: Starting HW-DRBG health test...
INFO: HW-DRBG health test passed.

INFO: Starting SW-DRBG health test...
INFO: SW-DRBG health test passed.
User enable_1 logged in to securevpn
Logins over the last 1 days: 1.
Failed logins since the last login: 0.
Type help or '?' for a list of available commands.
securevpn>

</CODE>

The following is the "show version" console output.

<CODE>

securevpn> show version

Cisco Adaptive Security Appliance Software Version 9.8(4)22
Firepower Extensible Operating System Version 2.2(2.124)
Device Manager Version 7.8(2)151

Compiled on Fri 29-May-20 00:37 PDT by builders
System image file is "disk0:/asa984-22-lfbff-k8.SPA"
Config file at boot was "startup-config"

securevpn up 126 days 8 hours

Hardware:   ASA5506, 4096 MB RAM, CPU Atom C2000 series 1250 MHz, 1 CPU (4 =
cores)
Internal ATA Compact Flash, 8000MB
BIOS Flash M25P64 @ 0xfed01000, 16384KB

Encryption hardware device : Cisco ASA Crypto on-board accelerator (revisio=
n 0x1)
                             Number of accelerators: 1

 1: Ext: GigabitEthernet1/1  : address is 7488.bbc8.72c0, irq 255
 2: Ext: GigabitEthernet1/2  : address is 7488.bbc8.72c1, irq 255
 3: Ext: GigabitEthernet1/3  : address is 7488.bbc8.72c2, irq 255
 4: Ext: GigabitEthernet1/4  : address is 7488.bbc8.72c3, irq 255
 5: Ext: GigabitEthernet1/5  : address is 7488.bbc8.72c4, irq 255
 6: Ext: GigabitEthernet1/6  : address is 7488.bbc8.72c5, irq 255
 7: Ext: GigabitEthernet1/7  : address is 7488.bbc8.72c6, irq 255
 8: Ext: GigabitEthernet1/8  : address is 7488.bbc8.72c7, irq 255
 9: Int: Internal-Data1/1    : address is 7488.bbc8.72bf, irq 255
10: Int: Internal-Data1/2    : address is 0000.0001.0002, irq 0
11: Int: Internal-Control1/1 : address is 0000.0001.0001, irq 0
12: Int: Internal-Data1/3    : address is 0000.0001.0003, irq 0
13: Ext: Management1/1       : address is 7488.bbc8.72bf, irq 0
14: Int: Internal-Data1/4    : address is 0000.0100.0001, irq 0

Licensed features for this platform:
Maximum Physical Interfaces       : Unlimited      perpetual
Maximum VLANs                     : 5              perpetual
Inside Hosts                      : Unlimited      perpetual
Failover                          : Disabled       perpetual
Encryption-DES                    : Enabled        perpetual
Encryption-3DES-AES               : Enabled        perpetual
Carrier                           : Disabled       perpetual
AnyConnect Premium Peers          : 2              perpetual
AnyConnect Essentials             : Disabled       perpetual
Other VPN Peers                   : 10             perpetual
Total VPN Peers                   : 12             perpetual
AnyConnect for Mobile             : Disabled       perpetual
AnyConnect for Cisco VPN Phone    : Disabled       perpetual
Advanced Endpoint Assessment      : Disabled       perpetual
Shared License                    : Disabled       perpetual
Total TLS Proxy Sessions          : 2              perpetual
Botnet Traffic Filter             : Disabled       perpetual
Cluster                           : Disabled       perpetual

This platform has a Base license.

Serial Number:=20
Running Permanent Activation Key:=20
Configuration register is 0x1
Image type                : Release
Key Version               : A
Configuration has not been modified since last system restart.

</CODE>

*************************************************************
Technical specifications of Cisco ASA 5506-X firewall
*************************************************************

Processor: CPU Atom C2000 series 1250 MHz, 1 CPU (4 cores)
Memory: 4 GB RAM
Storage: 8 GB Internal ATA Compact Flash

*************************************************************

The following is the "show flash" console output.

<CODE>

securevpn> show flash
--#--  --length--  -----date/time------  path
  122  108563072   Jan 25 2019 22:53:16  asa982-lfbff-k8.SPA
  123  26970456    Jan 25 2019 22:53:46  asdm-782.bin
  124  93          Jun 17 2020 18:50:42  .boot_string
   11  4096        Jan 25 2019 22:56:56  log
  144  1375        Mar 09 2020 12:54:10  log/asa-appagent.log
   19  4096        Jan 25 2019 22:57:48  crypto_archive
   20  4096        Jan 25 2019 22:57:50  coredumpinfo
   21  59          Jan 25 2019 22:57:50  coredumpinfo/coredump.cfg
  125  26916144    Mar 09 2020 16:39:48  asdm-781-150.bin
  126  28672       Jan 01 1980 08:00:00  FSCK0000.REC
  127  45961535    Mar 05 2020 20:34:28  anyconnect-win-4.7.01076-webdeploy=
-k9.pkg
  128  53129667    Mar 05 2020 20:34:48  anyconnect-macos-4.7.01076-webdepl=
oy-k9.pkg
  129  12511       Mar 05 2020 23:07:36  oldconfig_2020Mar05_1451.cfg
  130  34033084    Mar 05 2020 23:09:02  asdm-7131.bin
  131  111281312   Mar 05 2020 23:29:58  asa984-8-lfbff-k8.SPA
  132  12851       Mar 05 2020 23:30:06  oldconfig_2020Mar05_1513.cfg
  133  26975568    Mar 05 2020 23:35:10  asdm-782-151_2.bin
  134  111290512   Jun 17 2020 14:46:10  asa984-10-lfbff-k8.SPA
  135  23506       Jun 17 2020 14:46:22  oldconfig_2020Jun17_0631.cfg
  136  23509       Jun 17 2020 15:07:42  backup_170620.cfg
  137  111383904   Jun 17 2020 18:25:30  asa984-22-lfbff-k8.SPA
  138  23674       Jun 17 2020 18:25:38  oldconfig_2020Jun17_1010.cfg
  139  4096        Jan 01 1980 08:00:00  FSCK0001.REC

7863623680 bytes total (3983400960 bytes free)

</CODE>

Looks like Cisco ASA 5506-X firewall operating system is also based on Linu=
x and open source software.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.






