Return-Path: <netdev+bounces-80812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA04881264
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC89282440
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3140BEF;
	Wed, 20 Mar 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="c+X1+pvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44040BE5
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941739; cv=none; b=dhU9r6jDT4/eXoNUtiTIO17ulH8+1R10Sh0NTg20KFjUqtlIuecbjwWWfwYKijxp0SBoGO2I0YGgh9MtkHvIO2urydBDl+5ihdeXU+tzrLaD9lZZfdjd3qsA8PADBNaJd1rZ7tXlV+JDDpB27SJcaPPGLSYxS+KaWDtRZDQJvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941739; c=relaxed/simple;
	bh=BjzUslrnROEA43wk+xKuXcW4KjrKMSAMeWjGG6sehNY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IUIThFISgPrxE+wz1Z9zhtV/k6U+rxLYe6ZBuXLi/cOB8wyBd2b0lZFqjeRf8+9tpRw1+XEpriwjImxg4rU5AVY2e+2i8nLYkfxDYtXx1SbjyxZahD4mO3W3ubZb6u/cRNshb6q2abR5/z1nddPsh6VG1PgaVboAA3BdBjS8ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=c+X1+pvG; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1710941729; x=1711200929;
	bh=hvQyBWujL4qnrV3cQhSFq68V6MkuqPhAMHbTxKO1F6M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c+X1+pvGSiOBT3osQ4tagiYENXRNJKjVkVvr0reRW8LpyNaX8sOrNwFcILc7cFqr/
	 VrNW7q+tLbtduN1l/plsczXoojddgPmIq1v2qOX44qv0Mbht8g9JLtXjz5dFexH5mH
	 hSHJ57aFAGMXqLlSFXoBnDPsTl8zDJKg9sOjj1Dx+VMKRURN2vXYR10veDEkE0hQyP
	 lFZ8cFkvamYNL5D8GD4cwjuc8sm0p+P5xAYzLqoeo2lBAplsrGaVVcFyXHS0qkkXf/
	 gLstx8/OF1YMRdrSVHIfkD4uZjLFptpPG5Y5JsfBnHLzV4KftSc9Xg9XjL3LtZTS7e
	 rLrklyxfB7Zuw==
Date: Wed, 20 Mar 2024 13:35:09 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming's Notes on Basic Configuration of Cisco ASA 5516-X Firewall - Version 1
Message-ID: <iRfA7nfa9ZpTZB8Z8iPeDhGGXiQUjVjOX-rQieocKUfngjCr8ZJbFm9IXAkeuLTODSUWPM5h0bzBW-ljGK06hNf79fZwH0HUnmunAmd7440=@protonmail.com>
Feedback-ID: 39510961:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Teo En Ming's Notes on Basic Configuration of Cisco ASA 5516-X Fir=
ewall - Version 1

Good day from Singapore,

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date of Publication: 20 March 2024 Wednesday
Document Version: 1

I have bought this refurbished/second hand/used Cisco ASA 5516-X firewall w=
ith FirePOWER Services for SGD$100 at Bukit Panjang Ring Road on 17 Mar 202=
4 Sunday at about 8.30 PM Singapore Time.

On 19 March 2024 Tuesday, I have completed basic configuration of this fire=
wall.

Configuration Start: 19 March 2024 Tuesday, 9.22 PM

Configuration End: 19 March 2024 Tuesday, 11.33 PM

Below are my notes on configuring the Cisco ASA 5516-X firewall (basic).

Part 1: Factory reset the Cisco ASA 5516-X firewall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Reference guide: Clearing, resetting or erasing configuration on Cisco ASA
Link: https://www.linkedin.com/pulse/clearing-resetting-erasing-configurati=
on-cisco-asa-darko-raki%C4%87?utm_source=3Dshare&utm_medium=3Dmember_androi=
d&utm_campaign=3Dshare_via

cisco> en
Password: *****

cisco# conf t
cisco(config)#

***************************** NOTICE *****************************

Help to improve the ASA platform by enabling anonymous reporting,
which allows Cisco to securely receive minimal error and health
information from the device. To learn more about this feature,
please visit: http://www.cisco.com/go/smartcall

Would you like to enable anonymous error reporting to help improve
the product? [Y]es, [N]o, [A]sk later: Y

Enabling anonymous reporting.
Adding "call-home reporting anonymous" to running configuration...
Creating trustpoint "_SmartCallHome_ServerCA" and installing certificate...

Trustpoint CA certificate accepted.

Please remember to save your configuration.

cisco(config)# configure factory-default
Based on the inside IP address and mask, the DHCP address
pool size is reduced to 250 from the platform limit 256

WARNING: The boot system configuration will be cleared.
The first image found in disk0:/ will be used to boot the
system on the next reload.
Verify there is a valid image on disk0:/ or the system will
not boot.

Begin to apply factory-default configuration:
Clear all configuration
Executing command: !
Executing command: interface Management1/1
Executing command:  management-only
Executing command:  no nameif
Executing command:  no security-level
Executing command:  no ip address
Executing command:  no shutdown
Executing command:  exit
Executing command: !
Executing command: interface GigabitEthernet1/1
Executing command:  nameif outside
INFO: Security level for "outside" set to 0 by default.
Executing command:  security-level 0
Executing command:  ip address dhcp setroute
Executing command:  no shutdown
Executing command:  exit
Executing command: !
Executing command: interface GigabitEthernet1/2
Executing command:  nameif inside
INFO: Security level for "inside" set to 100 by default.
Executing command:  security-level 100
Executing command: ip address 192.168.1.1 255.255.255.0
Executing command:  no shutdown
Executing command:  exit
Executing command: !
Executing command: object network obj_any
Executing command: subnet 0.0.0.0 0.0.0.0
Executing command: nat (any,outside) dynamic interface
Executing command: exit
Executing command: !
Executing command: http server enable
Executing command: http 192.168.1.0 255.255.255.0 inside
Executing command: !
Executing command: dhcpd auto_config outside
Executing command: dhcpd address 192.168.1.5-192.168.1.254 inside
Executing command: dhcpd enable inside
Executing command: !
Executing command: logging asdm informational
Executing command: !
Executing command: !
Executing command: !
Factory-default configuration is completed

ciscoasa(config)# reload
System config has been modified. Save? [Y]es/[N]o:  y
Cryptochecksum: 200435a9 cee9c848 4fb5e91d ac201631

3250 bytes copied in 0.150 secs
Proceed with reload? [confirm]
ciscoasa(config)#


***
*** --- START GRACEFUL SHUTDOWN ---
Shutting down isakmp
Shutting down webvpn
Shutting down sw-module
Shutting down License Controller
Shutting down File system



***
*** --- SHUTDOWN NOW ---
Process shutdown finished
Rebooting... (status 0x9)
..
INIT: Sending processes the TERM signal
Deconfiguring network interfaces... done.
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Deactivating swap...
Unmounting local filesystems...
Rebooting...


Part 2: Basic Configuration of Cisco ASA 5516-X Firewall
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Reference guide: Basic Cisco ASA 5506-x Configuration Example
Link: https://www.speaknetworks.com/basic-cisco-asa-5506-x-configuration-ex=
ample/

ciscoasa> en
Password:
ciscoasa#

ciscoasa# show bootvar

BOOT variable =3D
Current BOOT variable =3D
CONFIG_FILE variable =3D
Current CONFIG_FILE variable =3D

Step 1: Configure ASA interfaces and assign appropriate security levels
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ciscoasa# conf t

ciscoasa(config)# interface GigabitEthernet1/1
ciscoasa(config-if)# description to WAN
ciscoasa(config-if)# nameif outside
ciscoasa(config-if)# security-level 0
ciscoasa(config-if)# ip address dhcp setroute
ciscoasa(config-if)# exit

ciscoasa(config)# interface GigabitEthernet1/2
ciscoasa(config-if)# description to LAN
ciscoasa(config-if)# nameif inside
ciscoasa(config-if)# security-level 100
ciscoasa(config-if)# ip address 192.168.1.1 255.255.255.0
ciscoasa(config-if)# exit

ciscoasa(config)# interface GigabitEthernet1/3
ciscoasa(config-if)# description to DMZ1
ciscoasa(config-if)# nameif dmz1
ciscoasa(config-if)# security-level 50
ciscoasa(config-if)# ip address 192.168.2.1 255.255.255.0
ciscoasa(config-if)# exit

Step 2: Configure ASA as an Internet gateway, enable Internet access
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure NAT rules.

ciscoasa(config)# nat (inside,outside) after-auto source dynamic any interf=
ace
ciscoasa(config)# nat (dmz1,outside) after-auto source dynamic any interfac=
e

Allow ping requests to go out.

ciscoasa(config)# policy-map global_policy
ciscoasa(config-pmap)# class inspection_default
ciscoasa(config-pmap-c)# inspect icmp
ciscoasa(config-pmap-c)# exit
ciscoasa(config-pmap)# exit

Step 3: Configure static NAT to web servers, grant Internet inbound access =
to web servers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I will skip this step because I am not planning to have any public facing w=
eb servers at home at the moment.

Step 4: Configure DHCP service on the ASA
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure DHCP server for LAN network.

ciscoasa(config)# dhcpd address 192.168.1.2-192.168.1.254 inside
ciscoasa(config)# dhcpd dns 8.8.8.8 8.8.4.4
ciscoasa(config)# dhcpd lease 3600
ciscoasa(config)# dhcpd ping_timeout 50
ciscoasa(config)# dhcpd enable inside
ciscoasa(config)# dhcprelay timeout 60

Configure DHCP Server for DMZ network.

ciscoasa(config)# dhcpd address 192.168.2.2-192.168.2.254 dmz1
ciscoasa(config)# dhcpd enable dmz1

ciscoasa(config)# exit

(Optional) Step 5: Redirect traffic to the FirePOWER module for deeper leve=
l inspection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I don't think I have any FirePOWER feature license, so I will skip this ste=
p for the moment.

Step 6: Hardening the device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Shutdown unused interfaces.

ciscoasa(config)# interface GigabitEthernet1/4
ciscoasa(config-if)# shutdown
ciscoasa(config-if)# interface GigabitEthernet1/5
ciscoasa(config-if)# shutdown
ciscoasa(config-if)# interface GigabitEthernet1/6
ciscoasa(config-if)# shutdown
ciscoasa(config-if)# interface GigabitEthernet1/7
ciscoasa(config-if)# shutdown
ciscoasa(config-if)# interface GigabitEthernet1/8
ciscoasa(config-if)# shutdown
ciscoasa(config-if)# exit

Enable SSH access for admin.

ciscoasa(config)# hostname ASA5516X
ASA5516X(config)# crypto key generate rsa modulus 1024 (change to 4096 in f=
uture)
WARNING: You have a RSA keypair already defined named <Default-RSA-Key>.

Do you really want to replace them? [yes/no]: yes
Keypair generation process begin. Please wait...



Hosts from the internet are not allowed to ssh into the firewall.

LAN users are allowed to ssh into the firewall.
ASA5516X(config)# ssh 192.168.1.0 255.255.255.0 inside

DMZ users are not allowed to ssh into the firewall.

ASA5516X(config)# ssh timeout 30
ASA5516X(config)# ssh version 2
ASA5516X(config)# aaa authentication ssh console LOCAL
WARNING: local database is empty! Use 'username' command to define local us=
ers.

Step 7: Configure time and enable logging
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I didn't set the time or timezone correctly. Will fix it in the future.

ASA5516X(config)# clock set 22:37:00 Mar 19 2024
ASA5516X(config)# clock timezone GMT +8
ASA5516X(config)# logging enable
ASA5516X(config)# logging timestamp
ASA5516X(config)# logging buffer-size 512000
ASA5516X(config)# logging buffered debugging

Part 3: Create LOCAL users for SSH
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reference guide: Cisco ASA Firewall Management Interface Configuration (wit=
h Example)
Link: https://www.networkstraining.com/using-the-management-interface-of-th=
e-cisco-asa-firewall/

ASA5516X(config)# username cisco password cisco privilege 15

Part 4: Enable ASA Web Interface
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Reference guide: How do I perform a basic setup of Cisco ASA 5516-X firewal=
l?
Link: https://community.cisco.com/t5/network-security/how-do-i-perform-a-ba=
sic-setup-of-cisco-asa-5516-x-firewall/m-p/5041698#M1109965

ASA5516X(config)# http server enable
ASA5516X(config)# http 192.168.1.0 255.255.255.0 inside
ASA5516X(config)# enable password cisco level 15

Hosts from the internet are not allowed to access the ASA web interface.
Hosts from the DMZ are not allowed to access the ASA web interface.

Part 5: Saving the Firewall Configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ASA5516X(config)# write mem
Building configuration...
Cryptochecksum: 5857f4ec 34234f34 4cec64f6 f85d7cd4

7180 bytes copied in 0.150 secs
[OK]


ASA5516X(config)# write mem
Building configuration...
Cryptochecksum: 5857f4ec 34234f34 4cec64f6 f85d7cd4

7180 bytes copied in 0.150 secs
[OK]


Part 6: show run output
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ASA5516X# show run
: Saved

:
: Serial Number: JAD****00ZZ
: Hardware:   ASA5516, 8192 MB RAM, CPU Atom C2000 series 2416 MHz, 1 CPU (=
8 cores)
:
ASA Version 9.7(1)4
!
hostname ASA5516X
enable password $sha512$5000$LuFgFhttGYuAEdvYbB7Y9g=3D=3D$M2/7xYvePzQsOAQNr=
QsxTg=3D=3D pbkdf2
names

!
interface GigabitEthernet1/1
 description to WAN
 nameif outside
 security-level 0
 ip address dhcp setroute
!
interface GigabitEthernet1/2
 description to LAN
 nameif inside
 security-level 100
 ip address 192.168.1.1 255.255.255.0
!
interface GigabitEthernet1/3
 description to DMZ1
 nameif dmz1
 security-level 50
 ip address 192.168.2.1 255.255.255.0
!
interface GigabitEthernet1/4
 shutdown
 no nameif
 no security-level
 no ip address
!
interface GigabitEthernet1/5
 shutdown
 no nameif
 no security-level
 no ip address
!
interface GigabitEthernet1/6
 shutdown
 no nameif
 no security-level
 no ip address
!
interface GigabitEthernet1/7
 shutdown
 no nameif
 no security-level
 no ip address
!
interface GigabitEthernet1/8
 shutdown
 no nameif
 no security-level
 no ip address
!
interface Management1/1
 management-only
 no nameif
 no security-level
 no ip address
!
ftp mode passive
clock timezone GMT 8
object network obj_any
 subnet 0.0.0.0 0.0.0.0
pager lines 24
logging enable
logging timestamp
logging buffer-size 512000
logging buffered debugging
logging asdm informational
mtu outside 1500
mtu inside 1500
mtu dmz1 1500
no failover
no monitor-interface service-module
icmp unreachable rate-limit 1 burst-size 1
no asdm history enable
arp timeout 14400
no arp permit-nonconnected
arp rate-limit 16384
!
object network obj_any
 nat (any,outside) dynamic interface
!
nat (inside,outside) after-auto source dynamic any interface
nat (dmz1,outside) after-auto source dynamic any interface
timeout xlate 3:00:00
timeout pat-xlate 0:00:30
timeout conn 1:00:00 half-closed 0:10:00 udp 0:02:00 sctp 0:02:00 icmp 0:00=
:02
timeout sunrpc 0:10:00 h323 0:05:00 h225 1:00:00 mgcp 0:05:00 mgcp-pat 0:05=
:00
timeout sip 0:30:00 sip_media 0:02:00 sip-invite 0:03:00 sip-disconnect 0:0=
2:00
timeout sip-provisional-media 0:02:00 uauth 0:05:00 absolute
timeout tcp-proxy-reassembly 0:01:00
timeout floating-conn 0:00:00
timeout conn-holddown 0:00:15
timeout igp stale-route 0:01:10
user-identity default-domain LOCAL
aaa authentication ssh console LOCAL
http server enable
http 192.168.1.0 255.255.255.0 inside
no snmp-server location
no snmp-server contact
service sw-reset-button
crypto ipsec security-association pmtu-aging infinite
crypto ca trustpoint _SmartCallHome_ServerCA
 no validation-usage
 crl configure
crypto ca trustpool policy
crypto ca certificate chain _SmartCallHome_ServerCA
 certificate ca 18dad19e267de8bb4a2158cdcc6b3b4a
    308204d3 308203bb a0030201 02021018 dad19e26 7de8bb4a 2158cdcc 6b3b4a30
    0d06092a 864886f7 0d010105 05003081 ca310b30 09060355 04061302 55533117
    30150603 55040a13 0e566572 69536967 6e2c2049 6e632e31 1f301d06 0355040b
    13165665 72695369 676e2054 72757374 204e6574 776f726b 313a3038 06035504
    0b133128 63292032 30303620 56657269 5369676e 2c20496e 632e202d 20466f72
    20617574 686f7269 7a656420 75736520 6f6e6c79 31453043 06035504 03133c56
    65726953 69676e20 436c6173 73203320 5075626c 69632050 72696d61 72792043
    65727469 66696361 74696f6e 20417574 686f7269 7479202d 20473530 1e170d30
    36313130 38303030 3030305a 170d3336 30373136 32333539 35395a30 81ca310b
    30090603 55040613 02555331 17301506 0355040a 130e5665 72695369 676e2c20
    496e632e 311f301d 06035504 0b131656 65726953 69676e20 54727573 74204e65
    74776f72 6b313a30 38060355 040b1331 28632920 32303036 20566572 69536967
    6e2c2049 6e632e20 2d20466f 72206175 74686f72 697a6564 20757365 206f6e6c
    79314530 43060355 0403133c 56657269 5369676e 20436c61 73732033 20507562
    6c696320 5072696d 61727920 43657274 69666963 6174696f 6e204175 74686f72
    69747920 2d204735 30820122 300d0609 2a864886 f70d0101 01050003 82010f00
    3082010a 02820101 00af2408 08297a35 9e600caa e74b3b4e dc7cbc3c 451cbb2b
    e0fe2902 f95708a3 64851527 f5f1adc8 31895d22 e82aaaa6 42b38ff8 b955b7b1
    b74bb3fe 8f7e0757 ecef43db 66621561 cf600da4 d8def8e0 c362083d 5413eb49
    ca595485 26e52b8f 1b9febf5 a191c233 49d84363 6a524bd2 8fe87051 4dd18969
    7bc770f6 b3dc1274 db7b5d4b 56d396bf 1577a1b0 f4a225f2 af1c9267 18e5f406
    04ef90b9 e400e4dd 3ab519ff 02baf43c eee08beb 378becf4 d7acf2f6 f03dafdd
    75913319 1d1c40cb 74241921 93d914fe ac2a52c7 8fd50449 e48d6347 883c6983
    cbfe47bd 2b7e4fc5 95ae0e9d d4d143c0 6773e314 087ee53f 9f73b833 0acf5d3f
    3487968a ee53e825 15020301 0001a381 b23081af 300f0603 551d1301 01ff0405
    30030101 ff300e06 03551d0f 0101ff04 04030201 06306d06 082b0601 05050701
    0c046130 5fa15da0 5b305930 57305516 09696d61 67652f67 69663021 301f3007
    06052b0e 03021a04 148fe5d3 1a86ac8d 8e6bc3cf 806ad448 182c7b19 2e302516
    23687474 703a2f2f 6c6f676f 2e766572 69736967 6e2e636f 6d2f7673 6c6f676f
    2e676966 301d0603 551d0e04 1604147f d365a7c2 ddecbbf0 3009f343 39fa02af
    33313330 0d06092a 864886f7 0d010105 05000382 01010093 244a305f 62cfd81a
    982f3dea dc992dbd 77f6a579 2238ecc4 a7a07812 ad620e45 7064c5e7 97662d98
    097e5faf d6cc2865 f201aa08 1a47def9 f97c925a 0869200d d93e6d6e 3c0d6ed8
    e6069140 18b9f8c1 eddfdb41 aae09620 c9cd6415 3881c994 eea28429 0b136f8e
    db0cdd25 02dba48b 1944d241 7a05694a 584f60ca 7e826a0b 02aa2517 39b5db7f
    e784652a 958abd86 de5e8116 832d10cc defda882 2a6d281f 0d0bc4e5 e71a2619
    e1f4116f 10b595fc e7420532 dbce9d51 5e28b69e 85d35bef a57d4540 728eb70e
    6b0e06fb 33354871 b89d278b c4655f0d 86769c44 7af6955c f65d3208 33a454b6
    183f685c f2424a85 3854835f d1e82cf2 ac11d6a8 ed636a
  quit
telnet timeout 5
ssh stricthostkeycheck
ssh 192.168.1.0 255.255.255.0 inside
ssh timeout 30
ssh version 2
ssh key-exchange group dh-group1-sha1
console timeout 0
dhcpd dns 8.8.8.8 8.8.4.4
dhcpd auto_config outside
!
dhcpd address 192.168.1.2-192.168.1.254 inside
dhcpd enable inside
!
dhcpd address 192.168.2.2-192.168.2.254 dmz1
dhcpd enable dmz1
!
dhcprelay timeout 60
threat-detection basic-threat
threat-detection statistics access-list
no threat-detection statistics tcp-intercept
dynamic-access-policy-record DfltAccessPolicy
username cisco password $sha512$5000$G5B9+ZfYxXVvcUPZ67ndpg=3D=3D$SzTisL+Gx=
QG2Nr/K7hh9gA=3D=3D pbkdf2 privilege 15
!
class-map inspection_default
 match default-inspection-traffic
!
!
policy-map type inspect dns preset_dns_map
 parameters
  message-length maximum client auto
  message-length maximum 512
  no tcp-inspection
policy-map global_policy
 class inspection_default
  inspect dns preset_dns_map
  inspect ftp
  inspect h323 h225
  inspect h323 ras
  inspect rsh
  inspect rtsp
  inspect esmtp
  inspect sqlnet
  inspect skinny
  inspect sunrpc
  inspect xdmcp
  inspect sip
  inspect netbios
  inspect tftp
  inspect ip-options
  inspect icmp
!
service-policy global_policy global
prompt hostname context
call-home reporting anonymous
Cryptochecksum:2cf585656729bff783f7247b760f1d15
: end


Part 7: Corrective Steps for DMZ network
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ASA5516X(config)# interface GigabitEthernet1/3
ASA5516X(config-if)# no shut
ASA5516X(config-if)# exit
ASA5516X(config)# write mem
Building configuration...
Cryptochecksum: 2cf58565 6729bff7 83f7247b 760f1d15

7170 bytes copied in 0.150 secs
[OK]

That's all.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com









