Return-Path: <netdev+bounces-297817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0qBNDTu+KWqAcgMAu9opvQ
	(envelope-from <netdev+bounces-297817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761D66C8E2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=LO0PTyHU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297817-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8E28304C05E
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184B3793BF;
	Wed, 10 Jun 2026 19:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466B145355;
	Wed, 10 Jun 2026 19:42:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120545; cv=none; b=K0eWjnq8sFebPLm6F/n4uBN+SpCOrC8LGqp3s2LZudaurLghAI5AJRVvRNWX0sFPtYtxssBvXVkz6/Eh3EMsnZYxU+P3X4yWfFYzfd9y20nBw1BDdVyUhIw8K2U6ifGxS3dPcixXze96+TQSHfW5Yg5hX847t65k+r5VS6u/EX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120545; c=relaxed/simple;
	bh=AGpkop/q6ykPJYgQxXxrCmzksLizorNg1PFhcR17Fv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QECIR0jc8oO16e9nOYYpcOfSRzmcL1uqlEhJv6IdGlX91zyNBhgIZEH+4SuV6L/hfWhSq7YfHobytrpE0rHIkdf/SR5638LyCbVggaiz/0+RCxN3mzBscSa5XlrBYdyNRQJmQJucigYDTE8ocoHcz4n58CatpnGGGltwRL9H/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LO0PTyHU; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120525; x=1781725325;
	i=markus.stockhausen@gmx.de;
	bh=6XNUQsEXyWheisBL3Qmj9zl0jSlfI2OKzXTzsN2d9EA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LO0PTyHUKHYcu18aPl9QSdzsPV68jVmSuQXjqEwAxGmIVkUynVl+osRR9fSFNucj
	 Y8W1ojf25UbcHlVaQQTne6wVWeNNGrQ4NXVNBaHhbCZFLPg3GkiYtCEDn+Ubt73Nk
	 0eHDs1dzf+Rk+mGJ+z/Sg4/dpK0cfx4/LyukczbwdqP0ppz8Cphp0aaIrTJC9n0mL
	 3clhGBhCvODvfDmMvjof3bb6DGLmNx2sl0d0ihLUxTKJjJMEPvlhe/J8dcWmSG/E/
	 BxIEMIfmoer3/5FwncxAuALgiX2XJ2Cz4ZBl8jSNAr9+dVuaMSgJSjtmyD5ksnUOU
	 QmUL2tex1k9CFjsYdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1wuXs115YC-00OSDr; Wed, 10
 Jun 2026 21:42:05 +0200
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
Subject: [PATCH net-next v3 5/5] net: mdio: realtek-rtl9300: Add support for RTL931x
Date: Wed, 10 Jun 2026 21:41:45 +0200
Message-ID: <20260610194145.4153668-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
References: <20260610194145.4153668-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tJ9UwvCf84/5W2RkCxBLdkPJ2tdH92GlGx9i2TMOyEQhFPFVtNg
 ap86zyMr4FHrXeqWct4GovmXvoaLXHtLqiMJZJoa4mrSkJJem0QP2aoB3J2CMX1V4CK79Jl
 3md7Q5c8ZjrBRDNQOicF6aDoUwbVQPKNiwInQ+IcqTBoxJftuW4usbAYQ9hfLY0mmeae+fq
 PTwUKQ3Yg7CwDHoEbUzxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R+DlgJPcifU=;znttS/evZCAeOmbmVEUvKEWw0jk
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-297817-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9761D66C8E2

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL931x (aka mango) series. This is straightforward
but some things are worth to be mentioned.

- In contrast to RTL930x the I/O register has the input/output fields
  swapped. Upper 16 bits are for read/outputs, and the lower 16 bits
  are for write/inputs.
- The supported "pages" are 8192 and thus the raw page is 8191
- The devices support up to 56 ports. Thus the MAX_PORTS definition
  is increased by this commit.
- There are multiple global SMI controller registers with a different
  layout from RTL930x devices. Therefore a separate setup_controller()
  callback is added.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 123 +++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1cdf2049cfa5..892ed3780a65 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -73,6 +73,31 @@
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
+#define RTL9310_NUM_BUSES			4
+#define RTL9310_NUM_PAGES			8192
+#define RTL9310_NUM_PORTS			56
+#define RTL9310_SMI_GLB_CTRL1			0x0cbc
+#define   RTL9310_SMI_GLB_FMT_SEL_C45(intf)	BIT((intf) * 2 + 1)
+#define RTL9310_SMI_INDRT_ACCESS_CTRL_0		0x0c00
+#define   RTL9310_PHY_CTRL_REG_ADDR		GENMASK(10, 6)
+#define   RTL9310_PHY_CTRL_MAIN_PAGE		GENMASK(23, 11)
+#define   RTL9310_PHY_CTRL_READ			0
+#define   RTL9310_PHY_CTRL_WRITE		BIT(4)
+#define   RTL9310_PHY_CTRL_TYPE_C45		BIT(3)
+#define   RTL9310_PHY_CTRL_TYPE_C22		0
+#define   RTL9310_PHY_CTRL_FAIL			BIT(1)
+#define RTL9310_SMI_INDRT_ACCESS_BC_PHYID_CTRL	0x0c14
+#define   RTL9310_BC_PORT_ID			GENMASK(10, 5)
+#define RTL9310_SMI_INDRT_ACCESS_CTRL_1		0x0c04
+#define RTL9310_SMI_INDRT_ACCESS_CTRL_2_LOW	0x0c08
+#define RTL9310_SMI_INDRT_ACCESS_CTRL_2_HIGH	0x0c0c
+#define RTL9310_SMI_INDRT_ACCESS_CTRL_3		0x0c10 /* I/O fields flipped */
+#define   RTL9310_PHY_CTRL_DATA			GENMASK(31, 16)
+#define   RTL9310_PHY_CTRL_INDATA		GENMASK(15, 0)
+#define RTL9310_SMI_INDRT_ACCESS_MMD_CTRL	0x0c18
+#define RTL9310_SMI_PORT_ADDR_CTRL		0x0c74
+#define RTL9310_SMI_PORT_POLLING_SEL		0x0c9c
+
 #define PHY_CTRL_CMD				BIT(0)
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
@@ -81,7 +106,7 @@
 #define MAP_BITS_PER_ADDR			5
 #define MAP_BITS_PER_BUS			2
 #define MAP_BUSES_PER_REG			16
-#define MAX_PORTS				28
+#define MAX_PORTS				56
 #define MAX_SMI_BUSSES				4
 #define RAW_PAGE(priv)				((priv)->info->num_pages - 1)
=20
@@ -294,6 +319,60 @@ static int otto_emdio_9300_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL9300_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_9310_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
+		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL9310_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_9310_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_9310_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL9310_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_9310_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL9310_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnu=
m)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -413,6 +492,22 @@ static int otto_emdio_9300_setup_controller(struct ot=
to_emdio_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
+{
+	int i, err;
+
+	/* Put the interfaces into C45 mode if required */
+	for (i =3D 0; i < priv->info->num_buses; i++) {
+		err =3D regmap_assign_bits(priv->regmap, RTL9310_SMI_GLB_CTRL1,
+					 RTL9310_SMI_GLB_FMT_SEL_C45(i),
+					 priv->smi_bus_is_c45[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_pri=
v *priv,
 				 struct fwnode_handle *node)
 {
@@ -624,8 +719,34 @@ static const struct otto_emdio_info otto_emdio_9300_i=
nfo =3D {
 	.write_c45 =3D otto_emdio_9300_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_9310_info =3D {
+	.addr_map_base =3D RTL9310_SMI_PORT_ADDR_CTRL,
+	.bus_map_base =3D RTL9310_SMI_PORT_POLLING_SEL,
+	.cmd_fail =3D RTL9310_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL9310_PHY_CTRL_READ,
+	.cmd_write =3D RTL9310_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL9310_SMI_INDRT_ACCESS_BC_PHYID_CTRL,
+		.c22_data =3D RTL9310_SMI_INDRT_ACCESS_CTRL_0,
+		.c45_data =3D RTL9310_SMI_INDRT_ACCESS_MMD_CTRL,
+		.ext_page =3D RTL9310_SMI_INDRT_ACCESS_CTRL_1,
+		.io_data =3D RTL9310_SMI_INDRT_ACCESS_CTRL_3,
+		.port_mask_low =3D RTL9310_SMI_INDRT_ACCESS_CTRL_2_LOW,
+		.port_mask_high =3D RTL9310_SMI_INDRT_ACCESS_CTRL_2_HIGH,
+	},
+	.num_buses =3D RTL9310_NUM_BUSES,
+	.num_pages =3D RTL9310_NUM_PAGES,
+	.num_ports =3D RTL9310_NUM_PORTS,
+	.setup_controller =3D otto_emdio_9310_setup_controller,
+	.read_c22 =3D otto_emdio_9310_read_c22,
+	.read_c45 =3D otto_emdio_9310_read_c45,
+	.write_c22 =3D otto_emdio_9310_write_c22,
+	.write_c45 =3D otto_emdio_9310_write_c45,
+};
+
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
+	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
 };
 MODULE_DEVICE_TABLE(of, otto_emdio_ids);
=2D-=20
2.54.0


