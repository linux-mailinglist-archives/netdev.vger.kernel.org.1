Return-Path: <netdev+bounces-296907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mo8QJeakJ2pQ0AIAu9opvQ
	(envelope-from <netdev+bounces-296907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910465C6FC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:30:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=Fw6jZQIP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296907-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296907-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4038A3083563
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E553C2797;
	Tue,  9 Jun 2026 05:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF53C1F46;
	Tue,  9 Jun 2026 05:29:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982989; cv=none; b=Kmby/XIVbDHS2yoNAo/7MtMSKdZPfWrlpVjjofDTZY/gTqYabj523aHW/Y17dxELJ73n2DlyUzy0wqPwS/KBQzrLvn39wRgrMTGYGPleO7SkMV6nvGPIbGKChIxCSBLVKAlXaAnG9dq0UIaDFCioM9dRCd6AgURv0BjZO7vfR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982989; c=relaxed/simple;
	bh=RhDBzvyHz82j9X3ziIA88fE3XLN0u+I7Jl1tLCcj0Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io8sDDJyUC/lbRuSFrNX1u7cJu0j5wLnYuTBAQZhkBvHxuflulMDI6wlHSSmrQ7if7GsTt+1Zdk+sE4KgJHg9/HtOIR7iBGmA+l/vQhSP1aPBt5wlz4cxPbXhKKOZ331CZ01cCaG0ID+VDnKp7LXOnDPpWg8NGFRU4SxvZV+3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Fw6jZQIP; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982964; x=1781587764;
	i=markus.stockhausen@gmx.de;
	bh=+PkOc5Pejze22+u5CacnY5Y1s7SqFWRFGP22C00E8ig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fw6jZQIPPjvNoXI4ss8rus0C/BtCr6stUChPx0XQRCqYywmccs0714ZdukyOmGY8
	 TiP0YXxxY23vO6Lo7na+yzSh+1kgKt+3hB/q0Q/K39TTwSBSwEn2GjiPvug493bEn
	 oMh7A27G+VitLDyx3AOQlMD3yt2pM02o9PUJG3dx8ihG9OhylImkogo0HP4G3YaTn
	 ykORXoXipemzjSuB93oJpmKeKVXrtzdtXgl0X5FVMIt3wKKhq5KGJ9BmC31KUUXSm
	 AuORCzaCCSgybi87Qy5qZB0XecCJXgfVp1uTJ4IIndx+7OpojC85DbHzV4hAUr7cP
	 NVzujgXZodEDCUaqCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnpns-1x37pW00BG-00jG0e; Tue, 09
 Jun 2026 07:29:24 +0200
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
Subject: [PATCH net-next v2 5/5] net: mdio: realtek-rtl9300: Add support for RTL931x
Date: Tue,  9 Jun 2026 07:28:56 +0200
Message-ID: <20260609052856.3142922-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LapDXr+0tXWLqXICGsNs9veLkX4fyu8A4ZscG07Lrs8gz9nIoU0
 /c3vPaAgpB9kp7Je4DHQnXNM2BojKkrt9gTJWmvbkJipLzI12rcwOMrUeIMZvXzOzoKQaj7
 OKIMUl0m8xfsJcSqTm+r/00f3iPQ1b5NNLHne98xqqcegwRu9+MGjAV7bvmf0sn6H2RfT22
 j087g8cy1/FNj6vmBDdhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QzSxr4eny4E=;XdQvQxc7+8nmEWOSMoVLfDWB79y
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
	TAGGED_FROM(0.00)[bounces-296907-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0910465C6FC

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


