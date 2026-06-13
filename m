Return-Path: <netdev+bounces-298955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id va4iL3c/LWomeQQAu9opvQ
	(envelope-from <netdev+bounces-298955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5B67E780
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=M90PMTsZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298955-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298955-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B819304203C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1F3C2BBD;
	Sat, 13 Jun 2026 11:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAB3DE451;
	Sat, 13 Jun 2026 11:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350224; cv=none; b=dylUpsuMlf/erZUWuBgiHx/p08KcdXqhLL2t7P2Q1bG0V81EeCkVIBF4kLJkVPm0SgQRUa1xnjlx9TKNG6BSNeNEGFJ2pWE4eYIf6eaRTFqRm0PUmZ+l6G23q6E/J5OYO/xLIfjvOdFmk3604I1Phxf0/iWxO1macakzBq/3jzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350224; c=relaxed/simple;
	bh=DUhGYrUGhgYrmkaoY1S8pFkEBESDR0mxRAANMf72CVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKkKoA1FzWZbZv2kaa5z1GL8O+pLQtPjUjr6R2qOdp8YkSBW4afLJOIq+LaioZFnx6ozDaO5Nm9/2PMD83qFA6ZtecZX7lUG07QW3HalkBH3HhaB3F+BRx2mKYXap8LmUx7utIYN1dZVDvAL9xboiVIvDATqx0EJnBtfNAMbiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=M90PMTsZ; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350202; x=1781955002;
	i=markus.stockhausen@gmx.de;
	bh=IM2w+8AkH1yr6UQDJDxzPpmzY3MvbyrgagZFPBnQfws=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M90PMTsZSytFR3w5fSQFW1A1MHjG6B+S41LEtoKUGQ4t2DuFfOTSe7n+HLBXa000
	 vmDtnZ8Aegt5FXfTXxhTTUVrQ8VvGnziDEOz9gt4IjQDo2MYGaXWwNfUEIyfkxHAj
	 4VNNrUji1HSm7zIoXFh5hnlC63cayeQXG4rPzlMSYjB+g/+xkzEIcPlf518vTRPb8
	 hpWRrTwNyX96xrujpZOzOVjLh18/hJUpQBK1y1zlNarcsczPMjIrHtGA2LybGaCRG
	 fKVuAxX6eTwmwFAopEhlIaOPSShSRUlDS/OrpTGaLJ9O6l/ly+TgEOf9hhAiEnyPY
	 e/BJns36R3RPAd+yXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1x2gtI1bLK-00p9sp; Sat, 13
 Jun 2026 13:30:02 +0200
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
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Sat, 13 Jun 2026 13:29:42 +0200
Message-ID: <20260613112946.1071411-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WDdTYU6ZtZwGfDGKClAdp0K9vzv2q2lF0z8a8pph4u8JYfn+fzZ
 SILzVAIOMbscoqvozOFJUHovLLf0Vne4zqcHYBB/ZPHmEYuYG1O1r7ntSXcPnfifjz4eHOa
 nES+mFIMsM2pnt9FoqPrcQ/TE8qym1jHY326SOrWpbpHfVfhqeucH4w7aU4YJ1MDQYXMP92
 hbrDMp6HxivIv83yNyuVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3Kl+UGgfAEU=;OZPu0lcG2EpTIWw4Nf8YZZoWKv+
 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
 cvjDl5aTQjHHh7dpZg=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298955-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EC5B67E780

During bus probing the PHYs are initialized and firmware might be
loaded. This often requires complex access sequences where the switch
hardware polling might interfere badly.

The polling can be configured with one or two 32 bit mask registers.
Each bit enables (=3D1) or disables (=3D0) the polling of the correspondin=
g
port.

Provide a helper to enable/disable polling for a specific port. With
this disable hardware polling temporarily during bus probing and enable
it afterwards according to the device tree topology. Nice side effect:
This patch brings the hardware polling into a consistent state for
devices where U-Boot does not take care.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 26 ++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index c3a9eeca3154..a7fd075947b6 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -137,6 +137,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -162,6 +163,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -210,6 +212,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -245,6 +248,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
(struct mii_bus *bus)
 	return chan->priv;
 }
=20
+static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int =
port, bool active)
+{
+	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / =
32) * 4,
+				  BIT(port % 32), active);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -735,7 +744,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct otto_emdio_priv *priv;
-	int err;
+	int port, err;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -750,6 +759,13 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
=20
+	/* Avoid issues with complex firmware loads. */
+	for (port =3D 0; port < priv->info->num_ports; port++) {
+		err =3D otto_emdio_set_port_polling(priv, port, false);
+		if (err)
+			return err;
+	}
+
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
@@ -772,6 +788,12 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 			return err;
 	}
=20
+	for_each_set_bit(port, priv->valid_ports, priv->info->num_ports) {
+		err =3D otto_emdio_set_port_polling(priv, port, true);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
=20
@@ -790,6 +812,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -815,6 +838,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
fo =3D {
 	.num_buses =3D RTL9310_NUM_BUSES,
 	.num_pages =3D RTL9310_NUM_PAGES,
 	.num_ports =3D RTL9310_NUM_PORTS,
+	.poll_ctrl =3D RTL9310_SMI_PORT_POLLING_CTRL,
 	.setup_controller =3D otto_emdio_9310_setup_controller,
 	.read_c22 =3D otto_emdio_9310_read_c22,
 	.read_c45 =3D otto_emdio_9310_read_c45,
=2D-=20
2.54.0


