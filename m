Return-Path: <netdev+bounces-128443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBE9798A3
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCCE1F213E7
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629121C6F55;
	Sun, 15 Sep 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="AkIP5LeV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C05347C7
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430740; cv=none; b=sLic/SgpF+N26A8iQGlyUgMzVIyo5RghhSeIlmHb537iEN+sCsM7D8lPtGpVKd9/ndMYQdjHZnkCUN9AgPX9gpppaJHXWkaFNKn56Clhfh1m9pNq6IfBgXuIDkODjUd16VKFzEsC9Say5ZkiQvdyKSHeEutf5eqVKKR+C95zIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430740; c=relaxed/simple;
	bh=jXX+XZpoNwxKHXXJlbzM62Y2l9JlMOnBIojpZVujsDo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=aSPtHmvbIdGgzFE0L6/vE5agX+GRgQTNRQlv9JISH3dVMh+pRT+6GYM2xvMqsGyKKTcRc/vRcARTEnG4FghLeiYWRPs+83vG80BXLYBaEZ/peRLAPSqyNaJNXRoi60el1/oCy4jTEPv6TOuguFkHpZxixF2BHrEN5G50LHfQfw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=AkIP5LeV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726430721; x=1727035521; i=hfdevel@gmx.net;
	bh=8PPR96DY0hmhT6IUYLXS+Vf7OqMmSwn7ycZ+YNB8FE4=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AkIP5LeV4Q+sC4evFK1GpkNsBX85pzTrcFYIomVEcndCt2LXgviAY4LcbmPTCrIf
	 IMUjIANXi2ikWYQBAeDC8hfhIi8lkj3YQiZxHmZhNXKKRUjSMAcdgpxzEkccQgohX
	 QEtxc9kWMqG/U81/i2Op3rx5Yq0IUnCXyQStmFY38xskQ/Uab2SWLt3MIpBIbMWkQ
	 ON+0/fqYD+slLuOh3cESW3Byl33bPFxUyPGE6LAEIpGvltNJPqu6dO4T63w2xO4Jz
	 v+sbQzKgdOgG2YymuS3uCUjhgXJXEG0TEVbno+jleClvgxQqiXzHW4/Z3A0LM+15v
	 nqkAHGPrsohwia1p3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 22:05:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-a908f45c-9600-475b-a182-f34055ffd4a6-1726430720847@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 5/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 22:05:20 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:lX32I0/rUPHpsOBqx2YViX+AXNO8rvDe2WEqsQqPGH9uJ9hpnB/N27Y3vxVpvz7MHv7oV
 dTa6TJVbPwon8+EsB/GEbIyoRiIS11y5X819A6dmeEQJpxeDyJyzFab/ShHIvNrtbHGRkGyD1KSb
 DMDG8FUkNYsgskdaT3rKlNyMBauoLb/FEmf6YuHRi8g6moLsBfab73F95TLY2KVzGyYMxwHTPE5X
 Xvh319CpLdpZnTWVxLpckKdFyWZYjWEFnlFb8c1CkTGDWQNkoZb3CguTiFuf2ViOUWgUbw9inhuE
 zU=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2c9Grf27+Rw=;UyGxUNPeTP4RiH4SqZ3z7K4tBY9
 iCW6vGB8VUk3qc/OaA0x/tVQDgXMU5RbnWU7gz9evT8fyrL+qlgd+WH8iSaBv5twSuLOUWjpO
 WabmyOoH5imKsRAtFfCVmerGjRFlGOljdkhqPocEcGgm6MD6MzLL9001EQhCJxujgV0GaQjmC
 fpA1AxRI0MgTO4PD0Pbb6uK9nhPPQ8PvtFETmczBLkMIEjyrRtWlHDjKwarAi7IhPFwvYqY6V
 L7XwovIFX9MH2HB7kwQx2rFukOAsDhU/Lx/I/lLO6Qkfo/XqKzJbQ4LE7hfQxDjwMH/tcSp3U
 +7XyNfRXS6jkAVkHAATrq4BR9JVBHIzmhVTm6X1LkljVr3htVt4xKG0V3uQkFE9XcwOABKtYc
 mxN30KPCqQRRYqJJwHPLo3lOzSQiqATw8wb36sgOWaPxpde8+Hb6cDxCVr3Z2l4hrX5bILfHc
 uH4kMztUULAoBmdaNTSrxc1WqDCLriS1teAGtsSUbVeiVmoc7CAhirqtQmm48Osh6LdsdBeYZ
 W1PDpedK8jwIya0XA9S0BXUX0NzmuQFaBDqgdahIDX+gq/FuaDTesc+wh9v/5BaNpaZ+YDkYT
 TBVG1ZW872i7yIgwfuOEw6eszPawfrWXhEw4OVUDfjOaSS4sZ1TEOjfsunUnhZ4xqvwW4eNJo
 CUNhc95DUSgBdfV7K8GYVDKBa8O7SsfTWWG9Ihk3tA==
Content-Transfer-Encoding: quoted-printable

Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set.
The function of bit 3 is unclear, but may have something to do with the
length of the preamble in the MDIO communication. If bit 3 is not set, the
PHY will not be found when performing a scan for PHYs. Use the available
tn40_mdio_set_speed funtion which includes setting bit 3.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40_mdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/etherne=
t/tehuti/tn40_mdio.c
index b8ee553f60d1..80eb68384389 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -185,6 +185,7 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 			ret);
 	}

+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
 	ret =3D devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
=2D-
2.45.2


