Return-Path: <netdev+bounces-304793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jxFCd6ISmrIEQEAu9opvQ
	(envelope-from <netdev+bounces-304793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB170A94E
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=HOurTTLV;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304793-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2ADE3037F44
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4E2E22B5;
	Sun,  5 Jul 2026 16:36:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD22F7F0A;
	Sun,  5 Jul 2026 16:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269372; cv=none; b=If7TJfwVHUlj5dT/tm6qzFfoQFX3yKp57hWH8kyrgF9FTRKLo8FMLV8Vhk9rh+suLW6fMVqlVA1ALvEn9vyxFrusM+qguir41yhN3vRARnfa7J62zrUktE509wnd3dguZ1/n5x0Oy0MaiKyiAYMyTi3o3qv5hFGjBskVQBIJgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269372; c=relaxed/simple;
	bh=5abXDP3yVP7yNDDa5VzyTqKqGcMcsuyq+tDfR118G24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN/zpifCkK4eb8Gp7xySWcroV1bg8hrtrVL3umwy3jLHjb1HRP0NJUGrXa6GhEo2Z9l0xu3Jmxi2do+Z5bzther25J2uGDadJ2E9et1jNYekWOiaUdwvNty+Yz6m9Fh18sIoI1KFqF9mQkBtqiHsYNehUjToNfXA5incSLLolTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HOurTTLV; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269350; x=1783874150;
	i=markus.stockhausen@gmx.de;
	bh=FFAVr/uv3Uw/X9S+nLlvusfkerBH+eJFXYfOfRQ3XR0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HOurTTLVYpQKn149Zw/k7xvZIIW9fOUL3VZIYXdFWfIE+cWz7uw1bRENXUVJvzDA
	 LH8C8gu2ymWt6Hn/v64flttgEm3sUrI/xNkiiOcWzsDAz1d3x8jwbXnl5gZWDURl0
	 ZffYuqyBlGp7nmNV1x2RR9ckmaxZQQaxrvKSzYhezxf98amD81Pdjt0i3K8sZrRpu
	 JQ2ghUW7yHB2rbddpwM8EDcXvkFxW0PRaDwZUuETEqucjBOFH1U7/wl2BqI8g1T45
	 jtBJHdqmS2GdrngcBAkfnszurbNmqYEn/vo2z9pUfVVDjR8bH08E3+Hni+sKA99Vq
	 4ZhoDI11ttYJgxscNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1wrkUB0aZl-00Gpkz; Sun, 05
 Jul 2026 18:35:50 +0200
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
Subject: [PATCH net-next v3 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Sun,  5 Jul 2026 18:35:32 +0200
Message-ID: <20260705163532.2853959-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:nlcs1PjTh52RIfOvFcYWNrFmK/AknA5mXl0GX504wLEhRILLJf+
 9t5thDMVLyUH2FuyNCge1wgzyouqf3UjSPxzJErq1B6URdUZOc7CKcSsb7+CDHP9GsYZHnz
 Pc6Jd45X1kI1ZdIiw5uOn5dqxXNd534EEaPTwY2c6cKca2K1onD3BBolchULntXqHPPw3wy
 3VqAuGkkD7leiifeB2riA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dUwbOtDfA6M=;NX3J+Z6xh8S2+vc9SlKgXS6KX9v
 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
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
	TAGGED_FROM(0.00)[bounces-304793-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 75EB170A94E

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. 8192 (Realtek)
  pages and 7 MMIO registers
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  registers exist.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.
- c22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index e7c811614fd6..d797d8f01c66 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -141,6 +141,28 @@
 #define RTL8380_SMI_POLL_CTRL			0xa17c
 #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
=20
+#define RTL8390_NUM_BUSES			2
+#define RTL8390_NUM_PAGES			8192
+#define RTL8390_NUM_PORTS			52
+#define RTL8390_BCAST_PHYID_CTRL		0x03ec
+#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
+#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
+#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
+#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
+#define   RTL8390_PHY_CTRL_READ			0
+#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
+#define   RTL8390_PHY_CTRL_TYPE_C22		0
+#define RTL8390_PHYREG_CTRL			0x03e0
+#define   RTL8390_PHY_CTRL_EXT_PAGE		GENMASK(8, 0)
+#define RTL8390_PHYREG_DATA_CTRL		0x03f0
+#define   RTL8390_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8390_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8390_PHYREG_MMD_CTRL			0x03f4
+#define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
+#define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
+#define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -423,6 +445,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8390_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -969,6 +1047,29 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.write_c45 =3D otto_emdio_8380_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_8390_info =3D {
+	.cmd_fail =3D RTL8390_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8390_PHY_CTRL_READ,
+	.cmd_write =3D RTL8390_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL8390_BCAST_PHYID_CTRL,
+		.c22_data =3D RTL8390_PHYREG_ACCESS_CTRL,
+		.c45_data =3D RTL8390_PHYREG_MMD_CTRL,
+		.ext_page =3D RTL8390_PHYREG_CTRL,
+		.io_data =3D RTL8390_PHYREG_DATA_CTRL,
+		.port_mask_low =3D RTL8390_PHYREG_PORT_CTRL_LOW,
+		.port_mask_high =3D RTL8390_PHYREG_PORT_CTRL_HIGH,
+	},
+	.num_buses =3D RTL8390_NUM_BUSES,
+	.num_pages =3D RTL8390_NUM_PAGES,
+	.num_ports =3D RTL8390_NUM_PORTS,
+	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.read_c22 =3D otto_emdio_8390_read_c22,
+	.read_c45 =3D otto_emdio_8390_read_c45,
+	.write_c22 =3D otto_emdio_8390_write_c22,
+	.write_c45 =3D otto_emdio_8390_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -1020,6 +1121,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
+	{ .compatible =3D "realtek,rtl8391-mdio", .data =3D &otto_emdio_8390_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.54.0


