Return-Path: <netdev+bounces-306062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u92+Ec5DT2qWdAIAu9opvQ
	(envelope-from <netdev+bounces-306062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:46:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64272D531
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:46:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=dLxUqboN;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306062-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16592306F638
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91523DC850;
	Thu,  9 Jul 2026 06:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2416C3DB316;
	Thu,  9 Jul 2026 06:42:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579363; cv=none; b=tUDLWqoqILAjpnVOVvevTlzOVTz0AQJyNCnJG7N1htFJyljYE5JG31yXSD0t2OsNrMwqHObcvt3jrn04sZXL2Pr6VFc1EOEyYWb0muc4VyRcGAvywVBdmVl1uWKNKzasUeiP5MhbuZlb/1k/DZPbPqhoA7ocoKVV802TX6Bu9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579363; c=relaxed/simple;
	bh=b2fIzrpV91OZuBZOTh3socWUCqiku+BOU02NGLS2fTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwBKjjYYLe2h2ZC45x6y/H1mZwx4FQGjEcAuWKOH18+GCutw1NzXTqYO/nIA1dXIQAN/8tlGhFxNftrklo74qm5QYuZNZJF9WCRD+LwFGKMa4XbGfV3TsHIr+m4fPik3WjAB9S5TLrscsRyOCKbVMHuaclT3AK8uiGHted98SbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=dLxUqboN; arc=none smtp.client-ip=212.227.17.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579335; x=1784184135;
	i=markus.stockhausen@gmx.de;
	bh=pUSN7sE5oCeU8d00HqwCi5zFbWnpjlNjZlwPUk4m33w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dLxUqboNDpeH3OaZqHAaSlIl5rJZGaeXYNp7M3+0MZ4MdLbgKzYVc8UmlrHgGG4h
	 s6dYgbBnUxcx7D/tLM8wdXRi6VxCdDJn1Z+VolHDXCv0EJIFrDYlTnbaU99JzP0yd
	 TTl1vz55bAZoZbtIw32uu92ENcF4+ydBfEYSqBXsk9Q5yxLOuheWf/sGGe2B/Dyin
	 d5D/mNIiAKyjyLohyBrfICBHnWeoW2h/HRsi+LPis6WcQ1J9uCjpgiQ+uf7ZAEUEh
	 7pRSIP1xwXWAaHdJY8fKhdSMs0Pz28BqZBoAFIJgyRNcIWFYijvHT8F3ihhJ/LzCZ
	 GYs8+AN91hw+mW65Bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1wehOG0etP-008Q21; Thu, 09
 Jul 2026 08:42:15 +0200
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
Subject: [PATCH net-next v4 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Thu,  9 Jul 2026 08:41:56 +0200
Message-ID: <20260709064157.2865063-8-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:rzfbk+t2jh2gkPoYypkh4bp07wlQe7smEcpsrUpk1truWLZHdms
 3DqZXRT8lvQuz2pn33TATJWSVraYVfXc2kcvg1wgfR0DP3QeNYqGtjuymKH1LlHExzEdul6
 PSA8QG9atZipIZYCNW6fWK7daoEtWM1lAPMKtMO8SCmnaIsXYyOhKCUHrRIrkoM7jnf+GRM
 PUVgNoNFPm3p0afgjE3mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YG9RaCT00Ik=;jbs04Oz0Vg5nI2Y/4SXZvqSLA48
 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
 lwXrzm13s2q5HOzdM3xiKmeZK/go+GIPzjjA8/q
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
	TAGGED_FROM(0.00)[bounces-306062-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC64272D531

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. 28 ports, 4096
  (Realtek) pages, 4 MMIO registers
- The MDIO engine has no fail bit. Thus the mask is set to zero
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no c45 setup but must activate
  the PHY access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 97fb151d8b36..a6dfd8d26722 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -119,6 +119,28 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL8380_NUM_BUSES			1
+#define RTL8380_NUM_PAGES			4096
+#define RTL8380_NUM_PORTS			28
+#define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
+#define   RTL8380_PHY_CTRL_READ			0
+#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL8380_PHY_CTRL_TYPE_C22		0
+#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
+#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTL8380_SMI_POLL_CTRL			0xa17c
+#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -347,6 +369,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
+static int otto_emdio_8380_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8380_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -567,6 +643,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
+{
+	/*
+	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY =
access, including
+	 * patching and must be set before the PHYs are probed.
+	 */
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -862,6 +947,28 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_8380_info =3D {
+	.addr_map_base =3D RTL8380_SMI_PORT0_5_ADDR_CTRL,
+	.cmd_fail =3D RTL8380_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8380_PHY_CTRL_READ,
+	.cmd_write =3D RTL8380_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.c22_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_1,
+		.c45_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL8380_SMI_ACCESS_PHY_CTRL_0,
+	},
+	.num_buses =3D RTL8380_NUM_BUSES,
+	.num_pages =3D RTL8380_NUM_PAGES,
+	.num_ports =3D RTL8380_NUM_PORTS,
+	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.setup_controller =3D otto_emdio_8380_setup_controller,
+	.read_c22 =3D otto_emdio_8380_read_c22,
+	.read_c45 =3D otto_emdio_8380_read_c45,
+	.write_c22 =3D otto_emdio_8380_write_c22,
+	.write_c45 =3D otto_emdio_8380_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -912,6 +1019,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
nfo =3D {
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.54.0


