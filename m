Return-Path: <netdev+bounces-304789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L+XjDPuHSmqgEQEAu9opvQ
	(envelope-from <netdev+bounces-304789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242770A912
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:36:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=LkOab5eo;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304789-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304789-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47C7300A38D
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428E2DF152;
	Sun,  5 Jul 2026 16:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A22DAFB0;
	Sun,  5 Jul 2026 16:35:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269352; cv=none; b=OgiQXwPKs5mDq/6w04OzATAkCvX8mFOUdcE0lrt7f+nqqTWGAom462sy1kioQDRkdNaN47m304vf9HHf5NDl66aoONO4Q3V1AXujAYRPJ5A69WZ6PdCHIMFnBXtXlD2F4PEvhTbqnVvRhAS13nvoY35tLaf97ywGh8i1kGrdMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269352; c=relaxed/simple;
	bh=LGD7byL73kHV3ge5LWR2vDHNuj0QT5XpcmHXrVKIFCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSI+CHpoMVjJWy9K2tOILQwrPTuGXzAGHMBcSnVNd0hQUQNGc5ZPxVMS01qU/QK/lRNwDpFUO1jKG/JzLevGhqB8QCS22NVNOV74ORQ/7jZx1jOy3bRE863oZqTSKqa5WPVs5EbLTeTDWvTBD8BLl+rhFmkfv4+9dDbbGtcDKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LkOab5eo; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269348; x=1783874148;
	i=markus.stockhausen@gmx.de;
	bh=P9dloCFe9Ybn0q7JfV/WhY++BIuuh6GOj3OMLlSSWok=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LkOab5eoRaFeEhZTHZia6vEkM3YS2xw6A8SNKZMorWNjwXTt+qTwkC4lv1/Ta39J
	 AGCY37lu17hri6WUjQCXWwm41EOS9fPaqSDObMsnj3CJbcQHwMaB+MYQ2GDFz7N2c
	 aVWg1xoN/qDaDz9VqnaAYUTZGhFIenDLUPxqzRrb5HXWSuB58yibcZ3+vxP+n0qvK
	 7ZrqUI+nA4vxXWgcKGNXqYYYyJe26Nmy8WJhbeIyIqlqW/h18TT8LpCnJzVKuVHK8
	 irI/HQxDNWlMpkPX57fW2i3o9FcH36ywK1IDgyo/XMg2ayIT46x1vwhoBMKI8Te1I
	 LtByzeyPML/sG3tzOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1xSApa1XsY-00oEpa; Sun, 05
 Jul 2026 18:35:48 +0200
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
Subject: [PATCH net-next v3 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Sun,  5 Jul 2026 18:35:28 +0200
Message-ID: <20260705163532.2853959-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bzTI9DtwbYtanjI+NSD7sZS2STcrHsn7RgT1ilR67bT4Pfg04ep
 Od3zSfeePKf0WMQ9+0yWGYH3DNpxxyAp3kSaS8EFwgYfBSgc8c5nvcOvT6ps8FAHuSNaWMY
 ET2F1bS3LI2p7nenCt8oeuYHhsGdErpxy9rZAiB4gK6SD8ZSXx2PJvWSI9N1b/sRe1ELHLl
 iGzFb9xr9gMNfdDFEWovQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vhPTfbOEQMw=;Y8lhS3Nb5b7YaRvwUPRO4rq5wsl
 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
 07OtpfZhksLYxIINM0DVsUHbArlrGp
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304789-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8242770A912

During PHY probing and configuration complex configuration sequences
might be issued and firmware might be loaded. Hardware polling can
interfere badly with that. E.g. a hardware polling MMD c45 over c22
request might break an ongoing firmware loading sequence.

To avoid such issues the polling of the Realtek Otto switches can be
(de)activated with one or two 32 bit mask registers. Each bit enables
(=3D1) or disables (=3D0) the polling of the corresponding port. Make use
of this as follows:

- Disable polling for all ports when the MDIO driver starts.
- Reenable polling just after the PHY has been attached.
- Disable polling just before the PHY is being detached.

This synchronizes the kernel and hardware polling to some extent. It
gracefully handles deferred probing of PHYs in case the driver is
loaded asynchronously during boot. Additionally it brings the hardware
polling into a consistent operation mode for devices where U-Boot does
not take care.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e=
8.1769053496.git.daniel@makrotopia.org/

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 562f9c7f2895..c36244cd9a66 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -139,6 +139,7 @@
 #define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_POLL_CTRL			0xca90
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define RTL9310_NUM_BUSES			4
@@ -164,6 +165,7 @@
 #define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
 #define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
 #define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_CTRL		0x0ccc
 #define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
=20
 #define PHY_CTRL_CMD				BIT(0)
@@ -194,6 +196,7 @@ struct otto_emdio_priv {
 	const struct otto_emdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
+	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
@@ -211,6 +214,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -246,6 +250,14 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
(struct mii_bus *bus)
 	return chan->priv;
 }
=20
+static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int =
port, bool active)
+{
+	lockdep_assert_held(&priv->lock);
+
+	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / =
32) * 4,
+				  BIT(port % 32), active);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -576,6 +588,47 @@ static int otto_emdio_9310_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
+	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	int ret;
+
+	if (port < 0)
+		return port;
+
+	if (test_bit(port, priv->phy_poll))
+		return 0;
+
+	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_set_port_polling(priv, port, true);
+		if (!ret)
+			__set_bit(port, priv->phy_poll);
+	}
+
+	return ret;
+}
+
+static void otto_emdio_notify_phy_detach(struct phy_device *phydev)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
+	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct mii_bus *bus =3D phydev->mdio.bus;
+	int ret;
+
+	if (port < 0)
+		return;
+
+	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_set_port_polling(priv, port, false);
+		if (!ret)
+			__clear_bit(port, priv->phy_poll);
+	}
+=09
+	if (ret)
+		dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -605,6 +658,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
+	bus->notify_phy_attach =3D otto_emdio_notify_phy_attach;
+	bus->notify_phy_detach =3D otto_emdio_notify_phy_detach;
+
 	chan =3D bus->priv;
 	chan->mdio_bus =3D mdio_bus;
 	chan->priv =3D priv;
@@ -721,6 +777,21 @@ static int otto_emdio_map_ports(struct device *dev)
 	return err;
 }
=20
+static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
+{
+	int err;
+
+	for (int port =3D 0; port < priv->info->num_ports; port++) {
+		scoped_guard(mutex, &priv->lock) {
+			err =3D otto_emdio_set_port_polling(priv, port, false);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -740,6 +811,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
=20
+	err =3D otto_emdio_init_polling(priv);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, priv);
=20
 	err =3D otto_emdio_map_ports(dev);
@@ -780,6 +855,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -805,6 +881,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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


