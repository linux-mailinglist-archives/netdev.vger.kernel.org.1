Return-Path: <netdev+bounces-121659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3595DF33
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA4E2826C3
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FD41C65;
	Sat, 24 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="uEll73jb"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3315D1
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520818; cv=none; b=aOCPErTQizFsxyePUney/7tYkZCHe60j6hbrXmcfFnJBHy01a87dPqWxvqCLr8XZS9i8aZJM8f6KkkVjgWULyGZQo4Rgl1mRv5snyCraWoG/Av58cRoHxp3v6YMnZ8oNkl7No3XkMgvKd2pV40Jut0Api2WO+H+OwudBsthklfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520818; c=relaxed/simple;
	bh=c5zVhsXkbhy3Og2SGHowcQstLOQWHRbw8MH2D5smdXY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=baWNC9lOz2kK8X5cIL0ia/FFJ139WdTW58ggiGQUWhOt1XofP+nmaFqAFU3pZSlrwqw3gBzn5q2Af9sWpdcGyjx3bmCSBxCkG5tzIQqnRvt+9jkJviIwss4zppJcFasKtBGWus5n+s3Rn3SRaodrv9+OW2XL4yFGujH1bBmyF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=uEll73jb; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724520810; x=1725125610; i=hfdevel@gmx.net;
	bh=c5zVhsXkbhy3Og2SGHowcQstLOQWHRbw8MH2D5smdXY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uEll73jbvpIzENplAnKBPMa/fWOXyVC4Q/RzzlerV+0+G7oDOM5vNe9DaX+eXcYY
	 +LovfM/o9pZoeO2pU/9Bhd45XV+HwqZGzE67UYsshK9A5beTSND2Np8Ndyz14FLjY
	 q/BT/eFzuIdxXyUn4ZcT6rwf9i9h5f64u/VJvLrrfCP1o1eCX0r166VWnm/Khr4EE
	 U1p2AkDvseUc0qgLZfygMXzI9BgyJNe8s+VMHUAnx5rQuR3rsEdRaqW6kybd2TqXp
	 R2c1n64WbMQcbs3gnd9oDAST6vkbbBFGms+Xivd6lrJSVKlbNKEvJE/fEbbOEZDBI
	 YaGolrmknl3W1a5+zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1suIZL1PK9-00AQ79; Sat, 24
 Aug 2024 19:33:30 +0200
Message-ID: <c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.net>
Date: Sat, 24 Aug 2024 19:33:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
From: Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH net-next 0/2] net: phy: aquantia: enable firmware loading for
 aqr105 on PCIe cards
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yj9/P03bEoIRzmIdQ8RxwZ0JMyYH9c704j7Qsr5AGlM9nUB02Ne
 17eOD9fYdkp3ok+WfPxSVoawiHZqihy0v6hJk/BQqIcPOO+9sfvM2U6gqWkqHDeK6pTFbYk
 c5hYVjQFRSov8uUmEOKaseTStXneQqaKOD9F0UeEjmaTetUecgDJdfd5IVN63Un7iPWkUpv
 D0ORHokAPutVxD+2Xaz9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o+Fso0chxmM=;rPrqsd7JboH3X8bcsEGbsOizUv1
 a897k5EjXp7Y3olESQ5qB222eAqcBpugavUHlskGSOAJNe3CJXByQUvyMG0wsvE+/wd9L5651
 IDNZVR9LFu11x9Xaw9dSBveQdpSW1kRofScW7SyzP95Jzk/hqRIhAhov6uBMATa0lpVB6mlyq
 sX9ybyM28MQfBiccQp+4T2rsc6UyrV5rSJL3r0kP1eDZ5w9HWKBZS0+lih/OTsFgUgK8KXQY6
 dSgmxJj88H7uEoqX+3b1IcS1H4+OzR6F3yhVcHL5/3AdfXdzcrx0/V2HdxB7kEMJ7Vc/veUuH
 bkcOydni6b9mXNTj/255sX1FlbopZmBJFOvAMqAFypzoXUKxhskLDsX2JJaQE04tvt9l7hJt8
 bPT8032A698983MDSsPvU7vHR+kZaeyXmhZMv1RxfVz199UNc92oEZCFSvdbGLy+IzwdZgvWR
 d805tB0lbYJKT3tCc0Dl+XjGuLrGzS7FYJD2IvXoscXc7t8SCWdNhuhij5WOMFb/gKToUFbym
 7cd6CLtTy7hGv5TVrNuVx5DKIwM3B3kc6G0pmXwqcpKE/pf8TCNvi0cYngKq0PFH3jHr/YciC
 hnvCaRBBoAYf0iCsT4OpA8VRaFN2ZY2ZyTbss5lEYmvSehX0TOQK5qY7LdEeoXIgeG+ngviMp
 bNEsJyOfEPnK0t1b63jneyN6+rgh416tfbWPnfwcYC6zRkKr9RVuliNeFCSyISFk9EtlrELl1
 XdJ6iSZwo0kHPgjeBKxneKjpBet7/5vZ0sYez+9yQ2NeFswrsWh+STxllTnzKn36qddoh9bYN
 h2mEh/HSvEEvBCayZoq6B2OA==

This patch series adds support for firmware loading from the filesystem fo=
r
Aquantia PHYs in a non-device-tree environment and activates firmware
loading
for the AQR105 PHY.

Firmware loading for the Aquantia PHYs cannot use a static file name,
because
the firmware differs depending on the MAC it is connected to.
Therefore, the firmware name is created using the PHY and MAC (rather: MDI=
O)
names at runtime.

Activating firmware loading on the AQR105 is achieved by using the probe
function which is already used for the AQR107 and later PHY families.

The patch was tested on a Tehuti TN9510 card, with the improved
aqr_wait_reset_complete handling suggested by Vladimir Oltean
(discussion of patch by
Bartosz Golaszewski)
https://lore.kernel.org/netdev/20240806112747.soclko5vex2f2c64@skbuf/
(without these changes, the driver would timeout in
aqr_wait_reset_complete and
would return an error instead of loading firmware)

Hans-Frieder Vogt (2):
 =C2=A0=C2=A0 net: phy: aquantia: create firmware name for aqr PHYs at run=
time
 =C2=A0=C2=A0 net: phy: aquantia: add firmware loading for aqr105

 =C2=A0drivers/net/phy/aquantia/aquantia_firmware.c | 78 +++++++++++++++++=
+++
 =C2=A0drivers/net/phy/aquantia/aquantia_main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
 =C2=A02 file changed, 79 insertions(+)


