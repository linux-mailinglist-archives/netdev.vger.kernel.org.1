Return-Path: <netdev+bounces-128444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4689798A5
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFD7282DD3
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EF1CB319;
	Sun, 15 Sep 2024 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="LdIQMgjv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C691CA697
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430919; cv=none; b=JPcQhW9A2wzuM+N0eeeW0kcBD9GsXlkzhN3zyD1ldDnYxwoJWmieFZ9NwiKHTMRxhUj1KXNO5t0dpcwhExUY35/es1xD755Kg7NESWfHL8bXKfV35kovVDcsd5iJTxKZdDihMzNTVwKinR6AVRynDzq0mT0iSOug+hcUkeTgNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430919; c=relaxed/simple;
	bh=mpW/6tMDmZpnWnf50q8A2HwvDh1aqlU5Fcovbs/vPUo=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=Qilz6M2DIHA5ftZOcv+W4+tLYDyS6p/Q+veFRPjsutvKy7lGuzl4ROQvW2aG018Q8yeVsZMoZhZVHnIl++aMByQ5kvR4phttYx9bBteQG4uE07OhEqx1wrPQ22VzXWF6UDSdnTtG/7i6VBRfr7CAjeaMNzN0NbMze8GlEdi3V90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=LdIQMgjv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726430902; x=1727035702; i=hfdevel@gmx.net;
	bh=orv1bF9UPAiJnriKS0oEUP4jaz511AJ6Ahe52qmNWec=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LdIQMgjv4N6OmZz8jiZxdKS7QD7SQjNsZs9/l8TbyNkGfDbnojW+G/RCBwuhpTew
	 ggFMLnpvzi0RRHwfkkRNwVgtQMN7l8RfgjKUoY8WXmOpXgeL+5FwjrWgfJeHJ4RAV
	 P/Q67x2u0wHpkrdoa8DpTchwGTT996Q7LIQOI7tcZ5sWuPPuCTd8HdOPAs3/TUyXF
	 s2V6fQtXCsH9/TeDGNoMVgd+y8Y13kb+G3Oi7VKY2t7fjl/WtdQrckwTeYBxafSa+
	 sZ8nc9+MX5YrQh8LgRCTCCo8CYyCPTqhRYc7PHKH/eq2CQ6r/xjVZy4GhBsL10mYq
	 CjVLqEALyo5fBfScXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 22:08:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-f28f6938-afbc-4059-a149-d220fa8dc6f9-1726430902358@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 6/7] net: tn40xx: optimize mdio speed settings
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 22:08:22 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:JaK3B2tQhrsC4vAS3gzzLidboRt4EJ4JoMjQo+toDB1blfXj0whzSBeRigFZDzrdIB63P
 HAjbHhlqfAWGuoBFuJRzx+2v9oJI/5xv7nYnf4iCNQSdmIHuPZA3Vg1Q26mpZY1Bd4fy+jHxhHKJ
 RAqRREWPdCOUoNMJ7ejQOc7aPMUjaEc6bGnrsDMomv3FQFNTJOIHHljpuypZ45jZrkq6L77O4lpE
 fcD7bmfcn8wWvCe3w93bNZXJMoX2cM3C1q3MPVyvShy7+e4Wa+OcSjJKsFwCY0udxnnC7Qbo10BQ
 t0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HwKrpz2aOt4=;Gcvs60UVUKNXSFUcKn0tFE8eOpT
 PdfFbuuyGDbuw9FYvl3kHK/Y1JLgzjq5QMebuxV84mRUDaIt25Vg8VtVb55ULyKhKYbAxup0z
 o/dsRuBvfj0Y1VluNDVMcuqya8aQ/+Kgihy/ZN4pANAnaBq40maKt/brQNULC3vkXO97lEaRJ
 ypTXzk5KHs+cVxtT8z8PG/bLm+BU805hnXgjfO/3rer4iCcjvwSqwYGCrOcZa4wubSBBbCcjt
 V6AGP6PctBzbyDBuQunmIhqp6c0iwMV729KAdb2/o0RCFqd3uksa8/AxmX0MO5O8bCoUBIfIi
 lEH7q6KE5wOvgrGw0lkPeoCsGYL5jOgL2mKF1TxwJdZun5GqIOaPXoRBfX1Li9nntk1ILwffs
 6+fq1DX5TVLKsOztzPILy03hIliQ5kerD+5WO1V1OYYwoswEgDcARdJ8rwBn9s6OZpwQuTEws
 1w6f/1hf7exdZbsZjo2e9EbbGdBjSSX+0JgXQ58KgnYdJR63TxxgDnw89JHs3sox/MZOEogNr
 AxN9G0UxktgHkUKc/FOakzHpWQRusW6ybCHstlPNy9iF02mKgtRAJSGZ/VvU3YG0pXby+XupK
 i36FF1QJiWljxOJ6luIdNzfyuvPWiTiXZPnE5sVwzdE30L76SUrdy636MxSIAhPKZAIcFePvZ
 cVJ608sID1F58+zo2m4I8xhEDGAyicS9eydg4k4rww==
Content-Transfer-Encoding: quoted-printable

Optimize MDIO speed settings. The PHYs of all currently supported TN4010
cards support 6 MHz operation. Therefore select 6 MHz already before
devm_mdiobus_register, which also saves another call to
tn40_mdio_set_speed afterwards. As a nice side effect, the loading of the
firmware for the AQR105 PHY is then reduced from 30 s to 5 s.

Remove the write to TN40_REG_MDIO_CMD_STAT in tn40_priv_init, which is
equivalent to tn40_mdio_set_speed to 1 Mhz and therefore would revert the
6 MHz speedup of the MDIO communication.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40.c      | 1 -
 drivers/net/ethernet/tehuti/tn40_mdio.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/teh=
uti/tn40.c
index 5f73eb1f7d9f..9ccf5cd89663 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1642,7 +1642,6 @@ static int tn40_priv_init(struct tn40_priv *priv)
 	/* Set GPIO[9:0] to output 0 */
 	tn40_write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
 	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
-	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);

 	/* we use tx descriptors to load a firmware. */
 	ret =3D tn40_create_tx_ring(priv);
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/etherne=
t/tehuti/tn40_mdio.c
index 80eb68384389..993458cc4932 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -185,14 +185,13 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 			ret);
 	}

-	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	ret =3D devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
 		goto err_swnodes_unregister;
 	}
-	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	priv->mdio =3D bus;
 	return 0;

=2D-
2.45.2


