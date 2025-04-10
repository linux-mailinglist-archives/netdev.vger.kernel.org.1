Return-Path: <netdev+bounces-181326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2520A8477E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601EE188DC10
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495C1DF261;
	Thu, 10 Apr 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DBjYbPdM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E3E1DD0F2
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298066; cv=none; b=qbA+9OBJxwEw5eurpxxHWdQqbbdZjxfAUnIGAVDQG2zljlg7/pHHwkzubDPsy4kSOPaMSlSZOG9BDgCuxjDVUKafmpTHbf06AvSnNO4NcbFO3DaDNuhauR6kq2yIqjkFDT8cY1qNBIId8sx6229OH+8XUSF4nOhs92y8BwU1AjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298066; c=relaxed/simple;
	bh=lGgCnN3Zt0Qp+tpWJDXPf/jIcmRwDrO/bXmqGzT727c=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=j0gAVb3XpOjRZ1qCq0bwzTixVir96Muz6q4zdcdawUGHKPqTNf5cqCKtTL1C4Y/FjOT6MrC3JxaeTc3b+ZOhCY+XrAd2mBpXTXH42/xo21ZqeDMdbpqG/RM4VvprAmg4uClURZ6GPF7jdCEnLPUieKt1GixUFJwd85zNDD86EjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DBjYbPdM; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744298061; x=1744557261;
	bh=YnzVDTmjUaWXYp5MDPZ9PzE3FMlYw37wFYX/xFv4Z+c=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=DBjYbPdM3VGlDykJotTBQqoSvTLKUs6vBY8tyE9Q5cEA/0mn03Uwb02ffx/pUgN/l
	 lsT9gB5WYFQE32n6sgUYAWfwsOl0MJv79DJ+ZAl0JKlrIcpuhd3f0kljRqeX5COJly
	 AJ4uCZDHEe0/9aWEZ/ReoalqNyzcNesl41Hr6Ugv4JapjoxAxKo0nmwRLEEDaB2vp9
	 lJ3sJNh+o96yV1qPlIFfCKmVhEfYP1mGQfh2jlSh2S1NLq1mn7qeM73QitFx+PvY8j
	 kkiviPBMF/xbSYiLAvKEKYmJUIIf/Ilck1H9vrGOddPiHLLAJsWbPciX89aWVt320F
	 rXhKUA6sPfhXg==
Date: Thu, 10 Apr 2025 15:14:16 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Check Point Firewall R80.10 First Time Configuration Wizard
Message-ID: <KusHN5THMnBCdyFZzg4ZV82WBdOXkifENjjlK-j6qpTe73M6Laj8KMzDV2kmfzln4hsm8E1NCbqUtD4xTlTsUdbeenXL5Xx_csxvDCJePkU=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: 138b8bde6b113fd142ef73ab97447d53f8da9026
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Check Point Firewall R80.10 First Time Configuration Wizard

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 10 Apr 2025 Thursday

DETAILED INSTRUCTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Welcome to the Check Point First Time Configuration Wizard

Click Next

Deployment Options
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Click Continue with R80.10 configuration

Click Next

Management Connection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Interface: eth0
Configure IPv4: Manually
IPv4 address: 192.168.1.99
Subnet mask: 255.255.255.0
Default Gateway: 192.168.1.1

Configure IPv6: Off

Click Next

Internet Connection
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Configure the interface to connect to the Internet (optional)

Interface: eth1

Configure IPv4: Off

Configure IPv6: Off

Click Next

Device Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Host Name: checkpoint
Domain Name: teo-en-ming-corp.com
Primary DNS Server: 8.8.8.8
Secondary DNS Server: 8.8.4.4
Tertiary DNS Server: Leave blank

Uncheck Use a Proxy server

Click Next

Date and Time Settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Click Use Network Time Protocol (NTP):

Primary NTP server: 0.sg.pool.ntp.org

Secondary NTP server: 1.sg.pool.ntp.org

Time Zone: Singapore, Asia (GMT +8:00)

Click Next

Installation Type
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Click Security Gateway and/or Security Management

Click Next

Products
=3D=3D=3D=3D=3D=3D=3D=3D

Click Security Gateway

Click Security Management

Click Automatically download Blade Contracts and other important data (high=
ly recommended)

Click Next

Security Management Administrator
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Click Use Gaia administrator: admin

Click Next

Security Management GUI Clients
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

GUI clients can log into the Security Management from:

Click Any IP Address

Click Next

First Time Configuration Wizard Summary
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Your device will be configured with the following products:

Security Gateway

Security Management: Primary Security Management

Click Improve product experience by sending data to Check Point

Click Finish

This will start the configuration process. Are you sure you want to continu=
e?

Click Yes

Finishing the Firewall Configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After configuration completes, the firewall will reboot automatically.

Login from the CLI and shut down the firewall gracefully.

checkpoint> halt
CLINFR0519  Configuration lock present. Can not execute this command. To ac=
quire the lock use the command 'lock database override'.
checkpoint> lock database override
checkpoint> halt
Are you sure you want to halt?(Y/N)[N]
y

checkpoint>
Broadcast message from admin (Thu Apr 10 16:20:42 2025):

The system is going down for system halt NOW!

root@eve-ng:/opt/unetlab/addons/qemu/cpsg-R80-10# du -h hda.qcow2
7.5G    hda.qcow2

root@eve-ng:/opt/unetlab/addons/qemu/cpsg-R80-10# du hda.qcow2
7779208 hda.qcow2

root@eve-ng:/opt/unetlab/addons/qemu/cpsg-R80-10# sha1sum hda.qcow2
afd915e0624d8a6f983cc4138c99b714d04daafa  hda.qcow2

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Singapore
10 Apr 2025 Thursday 11.13 PM










