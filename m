Return-Path: <netdev+bounces-302699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BTfOCE2PQmoE9wkAu9opvQ
	(envelope-from <netdev+bounces-302699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F06DCACA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="iJ4/X7VN";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302699-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 274CC30356A4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B043636F;
	Mon, 29 Jun 2026 15:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E732426688;
	Mon, 29 Jun 2026 15:24:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746662; cv=none; b=JnJbqPbcjin9KCtqcRumLXIsmH7q49F1atD2OEGibhYSEazeeP9yO9pWFkJyGNCYwXIMvdcZSZwCZYky2AEAMIV8UIFE6yWzQP71jGWE+1Ih/Z6NXxHCNjl6WOvro2FC9bZ1AhT7Nh1jTHNL42SxCFMU7mYPIaNAOVY7NNF4vGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746662; c=relaxed/simple;
	bh=voPk4zpSAzoT39oDJQ1BjF1tDiGiThxmJo5MtV2gpYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmrWzs/P+AiU6qii5cXzmJ5RMvANELEU62udxOOvK3nnmeMCREJaUVz2j3UhPt8w4TzjIOmm1qrChN8rTo3Vzslt6ZiusvFB/asfM9VeXK5S/F2ao3ldZMjX0ivlRb9tqS3VsbcPNnM5qwgpWrnqmYaEbzCQVZg4+1Ju2dEx0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iJ4/X7VN; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746632; x=1783351432;
	i=markus.stockhausen@gmx.de;
	bh=9sOWL7PanijgBFcDu/odbdmEMTk4FGudK+2DpNStyk4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJ4/X7VNDDh1wsQ4kuocnSdtmBl+d7cjRCE1oKkl3zkcRkHxcty8qvlObAMMYWgu
	 iN8IHnmjToiDaYJDnlKsgiTcZ9BJL88VpYRyfjKUzDVFY1txDARAmsJbrB9dlfvsj
	 Uto75K23GE55B33SuxJHyxFyAKmIvffS+2x3l8ebo1GhgnFwoa+O3+6i5rV7tdWP3
	 iia8hjiNj3UrAAzKKvrTWaAc8sxxTPASoPAn2kHk6N4/MBHlZpZOYw2TAmq4sMtUi
	 JdzqD2kxWKQyIBvSFVMr2ljs94PXX5XyWbiZqaQF7zyRat0Fhoa78wPRgOymbrAwv
	 ulKMZY9ZD45WbVnglA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1wjBOA1ywY-00FznA; Mon, 29
 Jun 2026 17:23:52 +0200
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
Subject: [PATCH net-next v2 4/8] net: mdio: realtek-rtl9300: Configure hardware polling during probing
Date: Mon, 29 Jun 2026 17:23:32 +0200
Message-ID: <20260629152336.2239826-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iTazXeuWgI2OMTaEs4Su38X9Z3KPHlveRu35kHZZzKWxobF9JmF
 KUQslzV1qE1+u5sZYh0nz+XMw16RV2BNeZBYLf7+lf/V3CeqkmYOW2BYBXyBCF4WC0YIS0o
 WcNA2IcKfi9NK0dy/++uK1RUGHgodb6Ba8OckISV4pztCw9Aot55pf3hOsR3w0EAE7Z5s78
 8srbl4xTuNmsSz3rJi2zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V0re4JOFlY8=;sQjJXRlD80mAhQGAJ1P6Xa7RRXu
 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
 kI/Cdb/J/ErKhWmtrQHif
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-302699-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 064F06DCACA

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

The different devices will need an individual polling setup. For
this provide two callbacks that will be used later for coding
similar to [1] or [2].

- init_polling(): After polling has been disabled during probing.
- tune_polling(): Before polling gets reactivated for one PHY.

This synchronizes the kernel and hardware polling to some extent.
It gracefully handles deferred probing of PHYs in case the driver
is loaded asynchronously during boot. Additionally it brings the
hardware polling into a consistent operation mode for devices
where U-Boot does not take care.

[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/file=
s-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e=
8.1769053496.git.daniel@makrotopia.org/

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 87 +++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 616edcde15d9..a8e9a497a0dc 100644
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
@@ -192,6 +194,7 @@ struct otto_emdio_priv {
 	const struct otto_emdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
+	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
@@ -210,6 +213,9 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	u32 poll_ctrl;
+	int (*init_polling)(int port);
+	int (*tune_polling)(struct phy_device *phydev);
 	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
@@ -245,6 +251,14 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv=
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
@@ -588,6 +602,49 @@ static int otto_emdio_9310_setup_controller(struct ot=
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
+		if (priv->info->tune_polling) {
+			ret =3D priv->info->tune_polling(phydev);
+			if (ret)
+				return ret;
+		}
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
+
+	if (port < 0)
+		return;
+
+	scoped_guard(mutex, &priv->lock) {
+		__clear_bit(port, priv->phy_poll);
+		if (otto_emdio_set_port_polling(priv, port, false))
+			dev_err(bus->parent, "failed to disable polling for port %d\n", port);
+	}
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -617,6 +674,9 @@ static int otto_emdio_probe_one(struct device *dev, st=
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
@@ -733,6 +793,27 @@ static int otto_emdio_map_ports(struct device *dev)
 	return err;
 }
=20
+static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
+{
+	int err;
+
+	scoped_guard(mutex, &priv->lock) {
+		for (int port =3D 0; port < priv->info->num_ports; port++) {
+			err =3D otto_emdio_set_port_polling(priv, port, false);
+			if (err)
+				return err;
+
+			if (priv->info->init_polling) {
+				err =3D priv->info->init_polling(port);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -752,6 +833,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -792,6 +877,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.poll_ctrl =3D RTL9300_SMI_POLL_CTRL,
 	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
@@ -817,6 +903,7 @@ static const struct otto_emdio_info otto_emdio_9310_in=
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


