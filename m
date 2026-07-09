Return-Path: <netdev+bounces-306061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9shUHwlDT2pWdAIAu9opvQ
	(envelope-from <netdev+bounces-306061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:43:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766472D49C
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=Q99NOed7;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306061-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306061-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69BD300C330
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA863DB97A;
	Thu,  9 Jul 2026 06:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55E3806CD;
	Thu,  9 Jul 2026 06:42:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579363; cv=none; b=AAZl3JUPG92i3tA6XsjxI02X+SVfE0jjlQvjQdGZJRjKc1HlIJmNH/1M57zW/kOHyPh7vFkpSWUoEFLzTIvHk26nNR+vbUXbSHYMyBOXxecS6tQFj+u//amUP6/qIo5ONLqcKF3Q+lBxinlo4RYEicjahzS25KWWOPw+oaR2ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579363; c=relaxed/simple;
	bh=wgbsGvPRPOJ9dLAOsJ3L+RcWcP2GY5mgS2gUGf2sxPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBhuXpuMsiAWvQEzcN2844g6S1AIB/0RPoshHsBY7UaZIcsqT1KgX5S1Dl5qjmkNH+m4936qj9Ul0Nq7BLwddHjzvKSHajEESsAhCqAtSC2f+6h5K1JKs79mmIO23/UnCarjlkdw7ztvrGB9508RqgzfjOvudWO51/NG/UYmQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Q99NOed7; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579334; x=1784184134;
	i=markus.stockhausen@gmx.de;
	bh=sHfZ6dyLNDVhisDp4XUwisHkDmbpHnDE6bLdXrOI+GM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q99NOed7etC2W426/MxGy0jIATVXdckxeJRwUTqaSuukCgteR0WyLhjmhWEQjrID
	 f1eIjvDWksojFMQZmWek02Fg5wGm9QkScs+EoqcxwVU/xkN4nbdt8WwkPlwPNIuIi
	 lI9LJyA4osWSt/DC1SAhR/cwYf44qp4/8d3WmeukRBAFURrL4O794OeqGQY2elyef
	 7ioWfQAaVh9qUCzrb6kwXlaRCtEV+rzOkv//7q4dhS2uWykGehZg72L7Oa5E4OkXA
	 JPcaUje9AEztsr3hM2M+VxZEPHzSHz0IL7MTmfRsAU3CgAXO4jc5yzgGn/qcgjRaE
	 +j1SC1Cm6fIcpNWnBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1xJou33mrO-00a1cW; Thu, 09
 Jul 2026 08:42:13 +0200
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
Subject: [PATCH net-next v4 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Thu,  9 Jul 2026 08:41:53 +0200
Message-ID: <20260709064157.2865063-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtJ1v06mafLWV0B4XRSgrHpZaC08L/0i9iunnxhwNbcWuaJK2jB
 eLTcSaMHz+ydnh0I+NVxVqACkQHswCInrlma0QemBA1Y0+9b4YmUP/M9b0Cn9X2Rh4xS1NC
 y2Gkfec5/mUG2Rhp/zQLBLZoYSI6TO4myXR1I3W7vT9ZuPB/zHLroBp8Cyyzh4m0wxPQ9SR
 1tZ6ZPEd7CZqRB8LATpQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iRE/XPWTe/E=;TmXz4w3FGi2snrPt/i22z0MIV76
 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
 =
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-306061-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1766472D49C

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
index 562f9c7f2895..7096fb46b915 100644
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
+	scoped_guard(mutex, &priv->lock) {
+		if (test_bit(port, priv->phy_poll))
+			return 0;
+
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
+
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


