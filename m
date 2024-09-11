Return-Path: <netdev+bounces-127526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45189975ABA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38BA1F23F23
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAEF7E583;
	Wed, 11 Sep 2024 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Ipcxx3G+"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A92224CC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082126; cv=none; b=bJ1f1DI4as/GefS8/NFXIpGSlwxZWOwTxuS4We3WX8ETfIqEMcoLLJXJoTZnHqeSxj24xt5pLnhRGCCrVe+t+lNQXe0ZkRtwpFEEVvnt9uwhWD3GNLGGCgOdyF1h7qllSNvLhLP7mxu0rKEIBwKRoqUpgpt6oagZ7JahqT5eTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082126; c=relaxed/simple;
	bh=Ocg14CoWyDKExQ6dU2mEkXQYi0ajENPGwMEmpx8a2wU=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=cPj6GOi0iMlNnOZquraD/iD9Y5Qsr/VHIg75yygeYqnlGrR2gCe2qM8ydE4AAhQLyibQrSighqI+vULsS2qappW2I0Pvy2oauqgw6YTMut7sHiwcys321Kn1Brd4fenE/BW4lpfAP6qw0cDAMhsmYfxB9W0z2k/hof27rppnnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Ipcxx3G+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726082106; x=1726686906; i=hfdevel@gmx.net;
	bh=MToyL+/Utn4Wvb/jqOOyn41Hu0yeeOyZp/x5AztWWpE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ipcxx3G+nbKNna2nFKvTYLEama2OdDMdtp8wyVejIcExUGpFTCRMofGp68Q4WNlz
	 JDzzlIqIGmq9PyJSVM6Pcx/yRXqWr17Mj8VEdvVdAIL/JcH9dLPhar+j8HS2gXCLD
	 NrOzG//Ui3NBBCf0D7WFr3UC5xxaKLsygtW45qHaimu29yuBVDbjShb2gnmNGWfwd
	 F88XWbpaPuWXh8iAbC3YXQQp7zNDIpDKDMhQLMH390MiV4wiQybdIx+gAeh56c2aW
	 JS/QXkn1VZdbJVsH0h5UoPZAYWWJSYZE/LWDrNeeCfhUL9+TkiWogBup06Whxu90M
	 HY65FykDew1AhMg2xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:15:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-33332a4a-1c44-46b7-8526-b53b1a94ffc2-1726082106356@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/5] net: tn40xx: add support for AQR105 based
 cards (was: net: phy: aquantia: emable firmware loading for aqr105)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:15:06 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:tCMLMX3NQvicjBwgtnRJoBqQQCN5gQ5BRmHS5bR/ekht5UyhW9MQx7xOXLDyzI/jvSQ0A
 ialGdpLyC9Rt6qcbTGhrgY/KtiGa18PT8xvJc5rsu2yiNcp/tLsZmWO6wU9ptLmFIH0hsehD6W0Q
 IFovZHvPesYyFWi0LKEOlpCO+2JrkgC2GKLvbq79rLKrsfXBP7mRw1JpR8lzGNnaDMN+JczVAC34
 B6nVsJr69stlYD8LnW9UZg/5S+qm4k/kVVuBlJy77Pdc9k7+xpwfZ51OsTPEKwfm2YsQJnDpXXd4
 J0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/goVdxtqv20=;n60qSL+RkMcUtVO9eerC29T5UHO
 ce95sEQwUjgTFds52nResYEAO+70d6rmm9Y6Lq/BxqbiTdPA63wD0cfW0pR7QX9zdyR9Qanh8
 dyPc65k5orbDwNW3zQXQZ65FBafgSicvO4I9rKIUMen1D+jKynOFeJO7K4+Ae3lJqlgo1JwBp
 6wQn/hTIfdAymrFmv5wV5J1WgFu6+u1Jo72qOPuX6Sxg+GQlT+pRaHUmpJzxwyVqzDIf68im+
 VQI+aQu7AJ6aTned9aT9jjT2wuUT8WM/GfmstonIULyBCNAsLsyUhu+Q2TK7H9X4lVfDDrjQm
 ZfYxlpYIGmFmY1XIuhXon1AfSi6WsCawwPoxrdXnw3T+lHzuGV9bOXH9u9/K4dwxS051xB2lE
 HpJKMdQROziSaeR4+IJw1XBWSyOCcSj0o03M0dskK0XDrLR2TEaXxu5o+j6IGEs2iWssh4AWv
 B4KGBy/85NEUKNbAurwAizDspz5qkrWPhaaC6qTHM4d8BsraTLQqMBmlYgwKDiOuFTXEEcVy0
 kbreaRPo5LV/MpOenr/ItYqvUUMGhCzggwNk8++lvFJ0u0nSZ2F66mDtLjpMAYT23Sue4bIPF
 4ZzZaSZqYbg6w79oYVOi6uiRPxKFjdnVqW9g/hnD4fzjC+uKUqzPaqo1RzJEZcAYDHZI95/ZS
 /zjG+7n1oP2yIXpQHNIv1jm4jGEFL3CQW6ntNEnfQQ==
Content-Transfer-Encoding: quoted-printable

This patch series adds support to the Tehuti tn40xx driver for TN9510 card=
s
which combine a TN4010 MAC with an Aquantia AQR105.
It is a replacement for the proposed patch series "net: phy: aquantia: ena=
ble
firmware loading for aqr105 on PCIe cards" for firmware loading to Aquanti=
a PHYs
from the filesystem, see
https://lore.kernel.org/netdev/c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.ne=
t/

As suggested by Andrew Lunn, I have replaced the potentially unreliable
firmware-name composition deriving a name from MDIO and phy names with a
more robust method, where the MAC provides a file name via software nodes.

Therefore, this is now a combined patch series adding functionality to the
aquantia PHY driver to read a file name from swnode and to the tn40xx MAC =
driver
to create the swnode.
Additionally, a few small changes are added to allow firmware loading from=
 the
filesystem for the Aquantia AQR105 phy and loading of the tn40xx driver fo=
r the
TN9510 card (TN4010 MAC + AQR105 PHY).

The patch was tested on a Tehuti TN9510 card (1fc9:4025).

Hans-Frieder Vogt (5):
   net: phy: aquantia: add probe function to aqr105 for firmware loading
   net: phy: aquantia: allow firmware loading after aqr_wait_reset_complet=
e
   net: phy: aquantia: search for firmware-name in fwnode
   net: tn40xx: enable driver to support TN4010 cards with AQR105 PHY
   net: tn40xx: register swnode and connect it to the mdiobus

 drivers/net/ethernet/tehuti/tn40.c             |    4 +
 drivers/net/ethernet/tehuti/tn40.c             |   10 +++
 drivers/net/ethernet/tehuti/tn40.h             |   25 +++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c        |   63 +++++++++++++++++++=
+++++-
 drivers/net/phy/aquantia/aquantia_firmware.c   |    2
 drivers/net/phy/aquantia/aquantia_firmware.c   |   25 +++++++++
 drivers/net/phy/aquantia/aquantia_main.c       |    1
 7 files changed, 126 insertions(+), 4 deletions(-)


