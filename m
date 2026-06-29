Return-Path: <netdev+bounces-302696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SjSbMTSQQmo+9wkAu9opvQ
	(envelope-from <netdev+bounces-302696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2736DCB9C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:33:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="Fl/DkOor";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302696-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 247AE308136A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25242EEA0;
	Mon, 29 Jun 2026 15:24:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC342EEAC;
	Mon, 29 Jun 2026 15:24:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746653; cv=none; b=cnrm9PbVbWHh5o+lKGywa2VWX99cI5cof6ZeHEOu8OnZ7l0sVwvw8Bl1igv/RD3YEgrxuubv5iCCfLYt5ThS3i2GLXF4u/AmqqH/YE/43eSi0A7B8M5lW7uAYUtIrG1UHCVeCXTqyBQMQzrPy0QDjMteoUpd03sTT4JH4LcrYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746653; c=relaxed/simple;
	bh=9STEfGg6sVe7FdMBOxNeIKw1Ih/BBALyIigY3tgAMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXVp2Q7xXT2buSSdeSgqgmdadeeB1890e7zR0kUu1Ssa5+D5FtTpOXV8s/9IC8vYkYqU8JsjigBB0RkyGc2LZSfuVpIL4ap+9IVxUlwP7fko8EVrI49b7uqwnMe6LzGLMwW0Nl+3sMrnTLAZMm2MZWBVBHN0FSdhHoGRIoISLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Fl/DkOor; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746633; x=1783351433;
	i=markus.stockhausen@gmx.de;
	bh=xai9ImsH/6fN/arw1+Gr6bn9RgZLYN1bViQS9Q9egQk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fl/DkOorYHB50VIF02qYURSIAdGIEX45aeF/KAzQu50IktBf1k902YOeq9cZGAyY
	 Szt835fjVW8oSZ1bfLbyiaTmZE2RoYS6HLKJ41xnZblqkieD8uFViGwJImXh0+JPs
	 PJUXy3ao+YqO2ZhW3Zhyg4p6DpBKk5UbpdvsgbcxpIhXYbz4AuFiOblHyp99Kpqxx
	 btkwAJAopAj8VvSYz55tXutpmIVHvb/gXZvpTyzBVfeBIqfpuLz+Ojv9HH54uRapz
	 U6wGHK7RCrwobdB+0Z6Zx0xiW0vw4DdGdAH9pXaTViR47A9cv+hZxGDROh9AVol//
	 EZk2Q6GsB01TN3zJzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1wMPs22dNb-00UeUz; Mon, 29
 Jun 2026 17:23:53 +0200
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
Subject: [PATCH net-next v2 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Mon, 29 Jun 2026 17:23:36 +0200
Message-ID: <20260629152336.2239826-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:MJIXO/cf7vxjjwgSLnBDl//Z1AQ7zSqU1GbufpX9FpaB33b2okx
 U5pitWueWBFgYdsTxYLUjD1UJPpBkoVWZwTwBJ4umzngxbIYoHhF/6kIElE5aJJa3Lm60mr
 qTzx29FcHtE7Mhci2rtAf8md2zPOQy4T8dzBxGRYncgURKMOLzIfTiZtTOPrgmjb5sw4DrX
 zjNRXC0moQGvUvoRPbTTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PKRZXI3P5UI=;Hy4P+G7+bgzYb0fD0dh4SeVnDE7
 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
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
	TAGGED_FROM(0.00)[bounces-302696-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A2736DCB9C

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. 8192 (Realtek)
  pages and 7 MMIO registers
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  registers exist.
- The MAC layer shows link flapping when temporarily deactivating the
  hardware polling for one port. Mark this in the info structure.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.
- c22 read/write functions must be called with PARK_PAGE =3D 0. Keep code
  clean and avoid setting it to zero, matching the behavior of the RTL9310
  logic.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 103 ++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 24a281b46526..6a65a6b0f122 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -139,6 +139,28 @@
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
@@ -465,6 +487,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
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
@@ -1023,6 +1101,30 @@ static const struct otto_emdio_info otto_emdio_8380=
_info =3D {
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
+	.link_flap =3D true,
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
@@ -1074,6 +1176,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
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


