Return-Path: <netdev+bounces-102088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85A90161B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF409B20DDE
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1035894;
	Sun,  9 Jun 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="I37Lfytf"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C621D69E
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717936827; cv=none; b=UooYzT2Qo5jBWJXwGu2WXz3MV0ADDhHA3QMIvTHCX81RbkrJFDwCw2aA3z01W7Ii46syuP4AS6354YWljY85oeNCrmemFSbk+29GZU0d27rc8ksG1MM3xjfRZRoDshPWlcCi1TKAXgkAxYOG3W8r/cmoQ3gCBcBwiV4a+WZVOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717936827; c=relaxed/simple;
	bh=tt3r7CEEOjxSx01964nW0EAQKLF5914Bo28XIMZwWGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1gbK8SUkHjZzowJLBkz5jpF+UtCDygSfMkPesjN31G/jCLwCN1OBPRAxcx6IX+W50NgSPrqISrpP0JQ6ENdgmOgPkjXmEVbIofaB9h3TrjX3RpT7fkmI9R3eyfmEE/eH2nYQACl8UEojZmxlL+iUp+oq4sD4/lkFU8YHhsZjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=I37Lfytf; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717936804; x=1718541604; i=hfdevel@gmx.net;
	bh=tt3r7CEEOjxSx01964nW0EAQKLF5914Bo28XIMZwWGA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I37LfytfnXUHb3GA86Pvc69O6EFyDdXUHvQpRudooQTTfZCMCHo7porjLgyb9aMb
	 diaVGuhg2UCD8hmZ4EgrN5Ayg8AoSH3k8JagNvdPBEgpHhva8OhHOej+ci17LeYaa
	 yU1AskR0wd/v8NGhWs+51bo3bLRaWhb9pNT22cVQb3jr266EB9elaO34MhACTADeX
	 0XUup3HYUBJVmnWVoOZ6Jt21TsCcPC50IUQ6Xp3yp2lN7qKdZJCpoFbfjAbFQicnj
	 Tk2yLxTW3A4NCQkPsLHItqspM344s1OjSHJ4NzKbCJ97MCFIMm+YzhP6zoa4g17Z2
	 1oPWNL07oQLhZYKUJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO2E-1sn8cG1hP6-00qLC9; Sun, 09
 Jun 2024 14:40:04 +0200
Message-ID: <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
Date: Sun, 9 Jun 2024 14:40:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
 <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sCcwGQc+8abDxwvdLPDYWXBZ5c0cyN0VPzXe6KjTSqS1MQKD8av
 z5bbyR7PwRlYOhbLtQEQ3RwAc31CXmq1avvjVNMHlCcC5S1/UmZGI1Yp1776NOuOsawtFBp
 XEsgFBA7DNES5ueS8Egx5ZBX2wF4oTYYtIxVyJw3E7hWF1YbI2vBjlgaTjX7FFb3yWZf35i
 4t9cr58EGw96xi+pJIptw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y42nHrpUswI=;OTdq4cwu9VVmY4jF2gFJUve3lDR
 BWGDDMOjYhQtAOOehqeKfg+cMr70spUmnYiG3BxCHX4Kd4MC+RNKoCbq78UFtwuXet5TLzXES
 IovjqilR+wWQ6OmtXBu7Dm1kzzs2wzmDvlv/NoXqqxDFnLGxDVtz7nWHFADgApRO8Yu0gnO/w
 J4xCtPeW7p2IL2WGslwmNEwJifhzERfonTpggAfRVgvgX9cyasn2/Q5LQ8vfUIkg1hGApAlG4
 oo04CIcUnl4BSWF6iOk6qgajEMHQA0VQXfdHo4GFyiBMmHbeDE/oJoduBIv1uL9wueTbEC/kn
 pGUFZJrQdq7zxAlCg9Ut1ep+xg1Q6cXUr0Yt3QCmarT2iKBS/DxIr0Te3nbvjEcTLN03lKfvq
 Plb98n+U1I5Qjb6vdEU7Nv8BvcW9Bytxqa3BwfhJAObE3qm3FW8JHtClPCzdyDCvxkAPnNutx
 imj0Gp7rWjnwEqsrYKFbQuKZD73fcGC4iScqJk/UtSSxC9yayX1l7f2Jt7onPcwRK45v1Sjdh
 yQ+QHccszc9KV4Zk7XmZmdLx2z97s52Hw30ENzuEh2c8qWHEzMEQK0Hg1/I6uW57tDBXRtftX
 E199MteHvOxkLhjUt8evsx2rhVbH7jSOFpJ5HnqXUU44ZprA9qYQnh0Iwb1cI2ULfP4BdrhAk
 8mws21ks0j21Af2+NlqqiDvKnW8FwW5IuBhbYKdpkPrHJU22wEK8QQ0npxJwlQADN6PPFc5fA
 2uO6iaGCkctTdJ6SUsfPhypHmUPB18v9gRoUSYfS1HspJ2e+5g5n4Z1x1XephOcNYIzBBaAXp
 FUxdyZ5ZIsifWM589hrM+9lZVgEvBOzY4zr2BPlRtRauY=

On 09.06.2024 12.42, Russell King (Oracle) wrote:
> On Sun, Jun 09, 2024 at 11:10:54AM +0200, Hans-Frieder Vogt wrote:
>> I have also tested your driver, however since I have 10GBASE-T cards
>> with x3310 and aqr105 phys I had to add a few lines (very few!) to make
>> them work. Therefore, formally I cannot claim to have tested exactly
>> your patches.
>> Once your driver is out, I will post patches for supporting the other p=
hys.
>> Thanks for taking the effort of mainlining this driver!
> Still, it would be useful to know what those changes were, even if they
> aren't formal patches.
>
> Thanks.
>
Sure. So, here, for info (and later addition to the driver), small
adjustments needed in the tn40 driver to support cards with Marvell
88X3310 and Aquantia/Marvell AQR105:

First the trivial change (I just also added also the e2010 phy, because
it seems to have a lot of commonality with the x3310, but I don't have a
card with this phy, so it is atm just speculation. Same applies to the
Promise card):

in tn40.c:

@@ -1752,6 +1754,10 @@ static const struct pci_device_id tn40_i
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0PCI_=
VENDOR_ID_ASUSTEK, 0x8709) },
 =C2=A0=C2=A0=C2=A0=C2=A0 { PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0PCI_=
VENDOR_ID_EDIMAX, 0x8103) },
+=C2=A0=C2=A0=C2=A0 { PCI_VDEVICE(TEHUTI, 0x4025), 0 }, /* AQR105 */
+=C2=A0=C2=A0=C2=A0 { PCI_VDEVICE(TEHUTI, 0x4027), 0 }, /* MV88X3310 */
+=C2=A0=C2=A0=C2=A0 { PCI_VDEVICE(TEHUTI, 0x4527), 0 }, /* MV88E2010 */
+=C2=A0=C2=A0=C2=A0 { PCI_VDEVICE(PROMISE, 0x7203), 0 }, /* AQR105 */
 =C2=A0=C2=A0=C2=A0=C2=A0 { }
 =C2=A0};

then the AQR105 seems to need the MDIO bus set at 1MHz to allow for
detection:

@@ -1681,6 +1681,8 @@ static int tn40_probe(struct pci_dev *pd
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto err_unset_drvdata;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

+=C2=A0=C2=A0=C2=A0 tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
+
 =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D tn40_mdiobus_init(priv);
 =C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "failed t=
o initialize mdio bus.\n");

This is not needed for the x3310 and may be related to, that the AQR105
is connected to phy address 1 on my card. Strange enough the
manufacturer's offline driver seems not to need this (but there the
sequence of initialization is also different, so it is likely due to
this reason).
Note: having set the speed to 1MHz here does NOT allow to skip the
similar call in tn40_priv_init, because BIT(3) seems to be lost on the
way, but is needed for the AQR phy to finish probing, but not for the
x3310 (don't really understand this).

On the other hand, the x3310 requires to add XAUI to host_interfaces.
Otherwise it will not switch to this interface on its own. So, adding
this to tn40_phy.c.

=2D-- a/drivers/net/ethernet/tehuti/tn40_phy.c=C2=A0=C2=A0=C2=A0 2024-06-0=
6
06:43:40.865474664 +0200
+++ b/drivers/net/ethernet/tehuti/tn40_phy.c=C2=A0=C2=A0=C2=A0 2024-06-06
18:57:01.978776712 +0200
@@ -54,6 +54,8 @@ int tn40_phy_register(struct tn40_priv *
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(PHY_INTERFACE_MODE_XAUI, p=
hydev->host_interfaces);
+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config =3D &priv->phylink_conf=
ig;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->dev =3D &priv->ndev->d=
ev;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->type =3D PHYLINK_NETDE=
V;

I have to mention, though, that the phy-drivers for x3310 and aqr105 are
not yet ready and will also need some changes related to the firmware
loading, because for most (all?) of the Tehuti-based cards the phy
firmware has to be uploaded via MDIO.

For AQR phys there is already support for firmware loading in the
driver. However, this is so far only working for systems using
device-tree. A few rather trivial changes (sorry, I know I should have
posted them already) will sort this. Further to this I have
"switched-on" some features coming from AQR107. I need to investigate
whether they are essential for operation.

For x3310 the patch provided by Tobias Waldekranz (or a similar patch
posted some year or two ago) will be needed for firmware-uploading.

I'll prepare a patch for the AQR105. Then we have at least one BASE-T
card fully supported.


