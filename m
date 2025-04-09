Return-Path: <netdev+bounces-180843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912C0A82AD1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0827A1B63C46
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6320A265613;
	Wed,  9 Apr 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iIkiDsU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39962673A2
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213091; cv=none; b=INL8kp60u6AsfEnO4tmiYQ0eRzJxpPLZbd6T841U/NuBXORzhMABitwYFbc768ghc39jAxf5Fe+2p/9pWT7sbkpzjIxStxdTgD/siAKnreqTQy/naRrsBHemsqHiNHdxKhcivyuwd6EDdiDmGrxnILkdnrF3fZPhBJBa2UMCqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213091; c=relaxed/simple;
	bh=rlRYZ3jVnNeovIR6u+FaNTRqA/I63oeAYuPuabtCfcM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uUQAOzdH1ado0bgoczJzW53qjPoVrQd6m6kbUg+ow0nP/vqWLS4lE6qCxwJIh7YMjF9hBZdiCirD8nUB7Vq6TUVysboQx7hUh9mPxWy1l12jKXKXdd2rDLse4tFXguINVKbkJJWOEiY6lRidhRW3lvsZQNlJK0NOmfHPPnXxwiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iIkiDsU0; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744213073; x=1744472273;
	bh=IvillZ+6+eiS4eC+riFDz7oNN3jZBId4Y8u5CkxfPsM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=iIkiDsU0+W0fY3qjlY86hsssVwySVOCY9+mn4qG6CNOTIgNroR/ntPaD6rkcGKdy1
	 qRstHCb2KC4VDbLRmXXDbGHy0/7TxYATJYPWPB6whP1rJpg0RScKXUUsrkF0Y2+/PJ
	 fH5rLVntK4xQdhHtTfdonuyS5IsncQmmrL32U1iMA0zBxNTIZohCRzOxM5lF8dIl0Q
	 UPTFx+Bn9J+obeBFldUvgooSeMqSUDwodjvFLXCb7YNCXuzonEigklYMr7UqlmBa3+
	 FFWM9XGa5xzBuCk3Bbu6yUd/vaWn9j5//8VXnLYHlQV+vkfh2sF1DyaJCUL0R9n5oq
	 xnunCLdvnuFoA==
Date: Wed, 09 Apr 2025 15:37:46 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: [NOTES] Installing Check Point Firewall R80.10 in EVE-NG CE 6.2.0-4 (based on Ubuntu Server 22.04.4 LTS)
Message-ID: <vd1JNbzpv1bI-BVv7ZV3qCNH7CQ8AcKmMC1P4yGCJuu1AZIh9toXC0cJwhLHv9l1Anhrwm0RKgQdUrJ64uVStVyqdKlJktD6Lvpfc4QZ_8c=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 828af6fda3b072971f25989b8145cf84c5bc137c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: [NOTES] Installing Check Point Firewall R80.10 in EVE-NG CE 6.2.0-=
4 (based on Ubuntu Server 22.04.4 LTS)

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 9 Apr 2025 Wednesday

DETAILED INSTRUCTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

EVE-NG Community Edition 6.2.0-4 is based on Ubuntu Server 22.04.4 LTS.

EVE-NG stands for Emulated Virtual Environment - Next Generation.

Below is the YouTube video guide I am following.

Reference YouTube video: How to download Checkpoint Firewall for free and a=
dd in EVE-NG
Link: https://www.youtube.com/watch?v=3Ddxx6xgGcbNw

Download and install EVE-NG Community Edition 6.2.0-4, which is based on Ub=
untu Server 22.04.4 LTS, on a bare metal physical machine with at least 1 N=
IC.

Upload Check Point Firewall ISO filename Check_Point_R80.10_T479_Gaia.iso t=
o EVE-NG using WinSCP.

mkdir /opt/unetlab/addons/qemu/cpsg-R80-10

mv Check_Point_R80.10_T479_Gaia.iso /opt/unetlab/addons/qemu/cpsg-R80-10/cd=
rom.iso

cd /opt/unetlab/addons/qemu/cpsg-R80-10

/opt/qemu/bin/qemu-img create -f qcow2 hda.qcow2 20G

Login to EVE-NG Web-UI.

Create new lab add your newly created Checkpoint image, connect it to Cloud=
0 network.

Click on Add new lab.

Name: Checkpoint

Version: 1

Click Save.

unl_wrapper -a fixpermissions

Right click, select Node.

Select CheckPoint Security Gateway VE.

Console: choose vnc

Click Save.

Right click on Check Point Firewall (CP) icon and click Start.

Double click on the Check Point Firewall icon and click Open ultravnc_wrapp=
er.bat

You will see "Welcome to Check Point Gaia R80.10"

Click Install Gaia on this system

Do you wish to proceed with the installation? Click OK

Keyboard Selection: US

Click OK

Partitions Configuration: Click OK

Enter your password and confirm it.

Click OK

Choose eth0 for the Management Port.

Click OK.

Management Interface (eth0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

IP address: 192.168.1.99
Netmask: 255.255.255.0
Default gateway: 192.168.1.1

Click OK

Confirmation: Click OK

Installation complete: Click Reboot

After rebooting, try to login at the Check Point Firewall console.

Login was successful.

Right click the Check Point Firewall icon and click Stop.

Right click the Check Point Firewall icon and click Edit.

Change the CPU from 4 to 2.

RAM (MB): 6144

Ethernets: 4

QEMU Version: 2.4.0

QEMU Arch: x86_64

QEMU Nic: tpl(e1000)

Console: telnet

Click Save.

Right click and select Network.

Type: Management(Cloud0)

Click Save.

Drag a connection from the Net icon to the CP icon.

Right click the Check Point Firewall icon and click Start.

Double click the Check Point Firewall icon and click Open SSH, Telnet and R=
login client.

Access the Check Point Firewall web UI at https://192.168.1.99/ using your =
favorite web browser.

Enter your username and password and click LOGIN.

Run the "top" Linux command.

The qemu-system-x86 process frequently consumes 200% to 300% of CPU usage o=
n Ubuntu Server 22.04.4 LTS.=20
As a result, the Ubuntu Server is frequently unresponsive and extremely slo=
w.=20
How do I solve this problem?

The Check Point First Time Configuration Wizard takes FOREVER to load.

I have decided that I will not go through the Check Point First Time Config=
uration Wizard.

Right click the Check Point Firewall icon and click Stop.

cd /opt/unetlab/tmp/0/

Click on the Lab details on the left hand side menu.

Copy the UUID.

cd deba7f1a-1699-401c-9cf8-74ef69e34d8e

Right click on the Check Point Firewall icon. You will see 1.

cd 1

Commit the QCOW2 image.

/opt/qemu/bin/qemu-img commit hda.qcow2
Image committed.

cd /opt/unetlab/addons/qemu/cpsg-R80-10/

root@eve-ng:/opt/unetlab/addons/qemu/cpsg-R80-10# du -h hda.qcow2
6.1G    hda.qcow2

root@eve-ng:/opt/unetlab/addons/qemu/cpsg-R80-10# du hda.qcow2
6304264 hda.qcow2

Additional learning resources
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

[1] How to Add Check Point Firewall Images to EVE-NG
Link: https://networkhunt.com/how-to-add-check-point-firewall-images-to-eve=
-ng/

[2] How to add Checkpoint R81 Image in Eve-ng
Link: https://www.youtube.com/watch?v=3DKTRD67xGixQ

[3] How to create Check Point images=20
Link: https://www.eve-ng.net/index.php/documentation/howtos/howto-add-check=
point/

Next / Upcoming project: I will be installing Check Point Firewall QCOW2 im=
age in Ubuntu Linux KVM host in the next few weeks.=20
Today's work is just a preparation and to lay the ground work for my next p=
roject.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
9 Apr 2025 Wednesday 11.30 PM










