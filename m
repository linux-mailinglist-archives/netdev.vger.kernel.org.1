Return-Path: <netdev+bounces-304796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pq9XChiJSmrWEQEAu9opvQ
	(envelope-from <netdev+bounces-304796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A986270A965
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=fCF9Aoyc;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304796-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304796-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38CA303FDEC
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F32F9D85;
	Sun,  5 Jul 2026 16:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580B2F7F1E;
	Sun,  5 Jul 2026 16:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269376; cv=none; b=Eh9rEwTIr8WYC8HzNDJo8/jYbZbG0Pa9joKFDcRgjPeWU1N4YnEo/0j56dh7k9bPbyqwed5nHdk25jEHEbLHpfwHE3/3KXNF2PeLaEoL46mdZX7WjOClIiHzegdXbeHKU4VKo6KcRyewp8o9oLrIoes1U89NLEWfbY3IlvYrx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269376; c=relaxed/simple;
	bh=ghGDQAfX+v8Jj16bOX6ygC1dSxcwA9oKXa5ojeuZMGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFNHim94g6XHhEwq6veM3i6t7BcLc59ASP/BIhYAAb6Md07wkQHWh8Yi0BJH9DehzRUv3768DOxzaoYP/GKCLrXdQcO7Dkq1Jzfqk1OO4DJdtivzPQkaxteCRqcxXoVCJzYLXbC0yek3KwzVa/A1SxEnPW6NDQNerfrSsfMWwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=fCF9Aoyc; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269349; x=1783874149;
	i=markus.stockhausen@gmx.de;
	bh=ZDWF7vTErpgNLmkRQvostgvxUJRX8jG3FuQg+sKhZ+Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fCF9AoycqXrz+vwpImJ/Zi/qIKcd+eTlMKph+jPptThcHmu8Drgw/hpflkmQ/6JW
	 qTiHM7K4feIAQTctRj559Iujo/oJMx08VRYXvGsaHIOhMU5EI0MuGeQ47gNjU9cQC
	 +/Fy1ikKmCkrA4kY/cGTZssWZtOWN0z96HmBkj1v37TpSmWAwBm4miCOi9P6arH6P
	 iLhybuFw4xQAJh2MNntbg9ReEJn0lGzcjyvwEUl5QjND+/OORDXQ93zIWHUBtOuCb
	 cmW90OmUpdq88pgFi1+ctZ8gJd+cZwXzE+1YB61ErGtdxKawlMRczs8cB8VpkC5Se
	 Wl8TS0tGCv5nF/Sung==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1wg8ZS2zTP-001vVv; Sun, 05
 Jul 2026 18:35:49 +0200
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
Subject: [PATCH net-next v3 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Sun,  5 Jul 2026 18:35:31 +0200
Message-ID: <20260705163532.2853959-8-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:Gkr9mmtGiO7Lk7a6WVJurYMnGC28mqQ+VuFiiY99Pzcon5ohDJ9
 14ZfMyUR0/F3gMuw1iLrW2kNQ15Tkbxw6GKCGobLZ71MrgDhhB2e3mJ8rp4YTAMNSTsqQlg
 xwrYnbqn64Hxl9+rljV8u6n8iWSNipB3PMDMElYYslFEwYvqew4N4XFT5mvzAY7fNz3GZIl
 rSHuFEXWKy5eau7yB4X0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cWw8CWENYy0=;DRxzab9YuSVvJ31O4Bmt6ggu3bF
 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
 XVX94pQ0sza5PFhI99qnM0AmuBnqIvIPrlhtLdW
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-304796-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A986270A965

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
index c73e370d912a..e7c811614fd6 100644
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


