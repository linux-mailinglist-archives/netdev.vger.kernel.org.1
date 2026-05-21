Return-Path: <netdev+bounces-290584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eElwCkpID2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A8E5AAB63
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0328300AB3D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05483F54DD;
	Thu, 21 May 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="KtFqOnmr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEB3FBB4E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386399; cv=none; b=WcynJksoEEatuvdCCNgeQ75z7wNPRIje31AZIKSoGVYKVOmXh6YH76/lJCuqrkelkZRYP2T64TiOug1KLhrLNDnNMbEsR0JQA3OoyivL0vVdSVqb8e22fSpU0aXpKrSQgjXj46SuNn8PLFoggJHxftO8ZikyU7y2aT1D5T6mo6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386399; c=relaxed/simple;
	bh=XvduXfobZe4udM4pvqPWiCVRMS+eQbICLEC3eXuZQdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQJEd7NRnlzRkKFwPYIpDiQ3UeHqNJIFeU3WNsFamgHzrCA9Ua02wcyAzsHOmUXEZqRVH3anCsQijdRA8nSUbL7TrbMnzm+cS6EawVZGD2xxJ2dB2xqZY2NXuAfqrvoQ9iGo/zkptMoTD1ldLKfJ60K9A00Y9+TOUENPhfZqh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KtFqOnmr; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386376; x=1779991176;
	i=markus.stockhausen@gmx.de;
	bh=y1FcSMG6VDuMTA6mCrtlH8PoX08C7rbt2rAPTXWeYVE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KtFqOnmrJBD4JHUhqYeAxXThaOT5892FkqS4NxCHo44Br44Ppy9T1aY6xUEW8Ua+
	 rGzJqJkIov+Txj+Vl5DK2hpzOcXDVHFAuKO6JZ9pQst97oQHuw0GVL+cmd9gpvRXx
	 04ejdJArM8haeOeae7hUZKcgQ/cOt+CpvmrxXQsC8dnSwq1MioWqjEU+LsjbizlCQ
	 TRm38sS1Y2/bvlpDG7oShcIL5GUlQ5huDKiFn9mJxlaJ9nLPTlGf4ocUh+5pOszmc
	 7f81yCYTXhkdtHSCYV6ccK25x8b2gkBKfqzp4CSjxCWN7UoHPpjcfCufWtDfg0or6
	 d3MixriiFeQ0fB0ESw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1x0qTj0fKV-00jHsn; Thu, 21
 May 2026 19:59:36 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 2/9] net: mdio: realtek-rtl9300: Add device specific info structure
Date: Thu, 21 May 2026 19:59:11 +0200
Message-ID: <20260521175918.1494797-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:16N7lg5fL8D3hbybAX1tl4rAOBy2TOnrvh5kZ2A4aKRrBmoh8RX
 vJXz1F2pOpkdTpNGNqjnoa0YgmWudFjJ/MYckfvSDJPI1HxZx10gs/jYp37ufAigyXs3m31
 R8Yu33b7YNEaKb/MuXAoZc067EFxjN1QEFntZNKVH5PSS58w+7aogj5WRLZf3SNL/yilQq3
 JA59XfscONR4UV93yr/fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qsuh46cs8Xk=;fg+cW3qs/DAjYaa8OLw054P2Db3
 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
 FkDFh8J0E=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290584-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: C3A8E5AAB63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Device properties of the RTL930x SOCs are hardcoded into the MDIO driver.
This must be relaxed to support additional devices like the RTL838x or
RTL839x. These do not have 4 SMI buses but 1 or 2 instead.

To support multiple devices establish an info structure that contains
individual variations of each series. As a first use case add the number
of buses into this structure and use it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 98484c689126..931c6684b2f3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -51,6 +51,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL9300_NUM_BUSES		4
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
@@ -77,7 +78,12 @@
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
=20
+struct otto_emdio_info {
+	u8 num_buses;
+};
+
 struct otto_emdio_priv {
+	const struct otto_emdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
@@ -357,7 +363,7 @@ static int otto_emdio_9300_mdiobus_init(struct otto_em=
dio_priv *priv)
=20
 	/* Put the interfaces into C45 mode if required */
 	glb_ctrl_mask =3D GENMASK(19, 16);
-	for (i =3D 0; i < MAX_SMI_BUSSES; i++)
+	for (i =3D 0; i < priv->info->num_buses; i++)
 		if (priv->smi_bus_is_c45[i])
 			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
=20
@@ -476,7 +482,7 @@ static int otto_emdio_map_ports(struct device *dev)
 		if (err)
 			return err;
=20
-		if (bus >=3D MAX_SMI_BUSSES)
+		if (bus >=3D priv->info->num_buses)
 			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus)=
;
=20
 		err =3D of_property_read_u32(phy_dn, "reg", &addr);
@@ -505,6 +511,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 	if (err)
 		return err;
=20
+	priv->info =3D device_get_match_data(dev);
 	priv->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -528,8 +535,12 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_9300_info =3D {
+	.num_buses =3D RTL9300_NUM_BUSES,
+};
+
 static const struct of_device_id otto_emdio_ids[] =3D {
-	{ .compatible =3D "realtek,rtl9301-mdio" },
+	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{}
 };
 MODULE_DEVICE_TABLE(of, otto_emdio_ids);
=2D-=20
2.54.0


