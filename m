Return-Path: <netdev+bounces-296237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KsZ8HitqJWoHIAIAu9opvQ
	(envelope-from <netdev+bounces-296237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE254650939
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:55:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=pK+t4Dxl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296237-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8826A3010492
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5B3A7F7E;
	Sun,  7 Jun 2026 12:54:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420428CF4A;
	Sun,  7 Jun 2026 12:54:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836891; cv=none; b=R2vKF9TNOwrCEMjnWK/PFcqK/tzZAauyn5yMsucMh9+HotNP7u14UW6HfofE/h3iPex+q2cn03LzY+tLijgQq5EKNKAPKgVe2W00KqhEOtmSS8zuROqpTlzPp2fsWWYcj6H0IeXxa8JoF42vCcVLZQVlR0D8d1hOosqe4cyH1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836891; c=relaxed/simple;
	bh=RhDBzvyHz82j9X3ziIA88fE3XLN0u+I7Jl1tLCcj0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q800XyJzuR30G8sN35JhotRnJ/c7nFdBS1VopG9LO8IJC3ffOkhKH8U53s7CYXrVKqHXh/Q00p/So08x9HbxhXyedWX2WLvcsWJTHoB/Qx5+8lizBF3jFawaAtXkEODHjoVsSOe55Yypnsj2r+cOIr5iRrdBGB+svovtJF+woXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=pK+t4Dxl; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836868; x=1781441668;
	i=markus.stockhausen@gmx.de;
	bh=+PkOc5Pejze22+u5CacnY5Y1s7SqFWRFGP22C00E8ig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pK+t4DxlQXzH1BzY658YTCjbXy4pccG+m6/sKGmhvipzqcytw815sn4IcHFuQLrM
	 FAiGWK6ieTy5Wm6nPusWo6S0xdlPgo+uHyUH3yeyVtANpdtJj4abmTVkWz5zt0rD+
	 rcQVEsHtA4pJ4uGjfIQ19Kuyaqwo9Z0L0eRLhvjJXeGMa+i4dGnCrbkrloGPT8MH8
	 aVmlOM9fHbGgEBAXwUxdfYdx7oAVHHUtvpGurAp1b5kveV/73/CGdJCob5q1K/T5I
	 m5LIb3UX+S9Kn8upssvHWOF8598fihggQLdTE4Fe27EcIRpPGaabfP4nDI4BdqFJw
	 BpwVNZrF+t7F7oVKBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1xMnju2V5V-014YiL; Sun, 07
 Jun 2026 14:54:28 +0200
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
Subject: [PATCH net-next 5/5] net: mdio: realtek-rtl9300: Add support for RTL931x
Date: Sun,  7 Jun 2026 14:54:06 +0200
Message-ID: <20260607125406.2853607-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
References: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ir/N4gM8FV5exH1xZ/xOrfr/n9V2W7LyhaX+2ObQd/OcJ8AQZhW
 RYCFGJv1wochv2qiKp4RMF8xSGpxbyvkFewhoLsj3zJ1aSBuqB7o7Kzu/wbmToKnIVO9nwr
 NY0F1mbispb9czaExzNer7hsjTJziAB7H5Nytb+91oPnPDMUb6Nwl5wEPYvhJDO23aD5Ijj
 AESMyGBPpvXUkLGknNIlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rANkKQ/nDtY=;kELeoA13lc04OSA/flCBMIbURTb
 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
 uJqSeg85WQ1abSxrG7chMZPQMKM=
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
	TAGGED_FROM(0.00)[bounces-296237-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE254650939

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

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 123 +++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 33c00b6ba8f8..dbd52f921909 100644
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


