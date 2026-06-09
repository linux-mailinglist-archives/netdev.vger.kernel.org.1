Return-Path: <netdev+bounces-296904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IRzGE7ukJ2pG0AIAu9opvQ
	(envelope-from <netdev+bounces-296904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF06365C6D8
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:29:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=HOfyPwJv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296904-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 339D5302C75D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FE3C1F40;
	Tue,  9 Jun 2026 05:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDD217723;
	Tue,  9 Jun 2026 05:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982966; cv=none; b=VJRd5GSQSdg8VSYA5I/Bv3BnHp6zAbrWXFAyo8I/fzpQdQdDViyfgW8XrNRSJiw61OhJclsIZtJfjH5B8MqlaUZTVOyNc2RYDAbzqgnlPgRdE7LaYwBRVpk1G0vz4z2MpTnORu/HLVCWgXOukMm4PyQgYnu2ergeUm2hZZJjf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982966; c=relaxed/simple;
	bh=Mus1mA4v+pL05M7ncHGUwwofOfa56V2tEZuuLJhcAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHMmuUBeE4p83do/IGq0nBILaQK2guOXoAlYyHkVTnaIQZI0BsWrutZUn1eJEBnQZjXQzvkXbczWVmYtleh1TNLOQwlH6StByNx2VBYb17tQxYTznaWqjuNtU5n3gFta67FWvRyJumosY6Z0zWkf7c/IPg3ywTiPQGSKMASWCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HOfyPwJv; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780982962; x=1781587762;
	i=markus.stockhausen@gmx.de;
	bh=zGF6LrsOk0URxZuzgolnWc9xJnfBwLBrrO2c8CnGOto=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HOfyPwJv9ihtRt5ZOi3/VUc3mc4NPKe3z/JgLD6L8gmtabAmifHlNQj1pH+bZcek
	 0ZjrT/2gPyfirzJZ8sovExQDTex0DQLeZ78Ogm43ea2+zFY9wghCfZSypE3TlkLl9
	 S02OaYrWrEYPWB4se8LINoG16vqxr/EBCVjbt0hHQ6ESnToa3MtkRVqC0ntQttYkj
	 AlerY4O4TFJv+x2Tswwb4REqSfMHwJPsrZUHOQR0ZFmv99/bagRcF2dpjfpm0w9Rq
	 /WIOE0+l2YrvcNVUIDwNu6o+XO5CMCYB7z/2uTbySlIPz3T+OK6Z5N/YOkRxs8zbf
	 jhGzv2B+icZGDMg9+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1xHCrt348F-012J01; Tue, 09
 Jun 2026 07:29:22 +0200
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
Subject: [PATCH net-next v2 2/5] net: mdio: realtek-rtl9300: Add prefix to register field defines
Date: Tue,  9 Jun 2026 07:28:53 +0200
Message-ID: <20260609052856.3142922-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:wLyJYxjTZK00nCNcGZX9Ha0+OYxgXEQIMqd0RQtHzj3nihA75sm
 3l8DxOAV3j2w+FWP65j011igzMhdquWv34eQjrzKhnZHlhSmXCaeMEFv0lWiaidjRw5WiXK
 MgKSzcQgS1axsSBZt0iROoKT6AJ4Qt3PAAhiyKJVuwmHTveIqbgXlklov0HIEYbxbSt6471
 YRgjD2Z6LvxTG+Fih2VEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ooVAXrQr9Z4=;OQIIeJWhANHuC6ebuKgjj4Pq8o7
 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
 JlOYA2mzOgaP8p9E6A=
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
	TAGGED_FROM(0.00)[bounces-296904-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF06365C6D8

The current Realtek Otto MDIO driver has some define leftovers without
a SoC prefix. When adding new devices there will be an overlap for some
of them. Sort this out as follows:

- PHY_CTRL_CMD/PHY_CTRL_MMD_DEVAD/PHY_CTRL_MMD_REG are common for all
  series. Leave them as is but move them into a separate block.
- Add RTL9300 prefix to all other defines and adapt the callers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 63 +++++++++++++------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 92c8f2512476..007a07136fa1 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -59,23 +59,24 @@
 #define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
-#define   PHY_CTRL_REG_ADDR			GENMASK(24, 20)
-#define   PHY_CTRL_PARK_PAGE			GENMASK(19, 15)
-#define   PHY_CTRL_MAIN_PAGE			GENMASK(14, 3)
-#define   PHY_CTRL_WRITE			BIT(2)
-#define   PHY_CTRL_READ				0
-#define   PHY_CTRL_TYPE_C45			BIT(1)
-#define   PHY_CTRL_TYPE_C22			0
-#define   PHY_CTRL_CMD				BIT(0)
-#define   PHY_CTRL_FAIL				BIT(25)
+#define   RTL9300_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL9300_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL9300_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL9300_PHY_CTRL_WRITE		BIT(2)
+#define   RTL9300_PHY_CTRL_READ			0
+#define   RTL9300_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL9300_PHY_CTRL_TYPE_C22		0
+#define   RTL9300_PHY_CTRL_FAIL			BIT(25)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_2		0xcb78
-#define   PHY_CTRL_INDATA			GENMASK(31, 16)
-#define   PHY_CTRL_DATA				GENMASK(15, 0)
+#define   RTL9300_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL9300_PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
-#define   PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
-#define   PHY_CTRL_MMD_REG			GENMASK(15, 0)
 #define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
+#define PHY_CTRL_CMD				BIT(0)
+#define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
+#define PHY_CTRL_MMD_REG			GENMASK(15, 0)
+
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
 #define MAP_BITS_PER_BUS			2
@@ -204,7 +205,7 @@ static int otto_emdio_read_cmd(struct mii_bus *bus, u3=
2 cmd,
 	if (ret)
 		return ret;
=20
-	*value =3D FIELD_GET(PHY_CTRL_DATA, *value);
+	*value =3D FIELD_GET(RTL9300_PHY_CTRL_DATA, *value);
=20
 	return 0;
 }
@@ -223,27 +224,27 @@ static int otto_emdio_9300_read_c22(struct mii_bus *=
bus, int port, int regnum, u
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
-		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
-		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
-	return otto_emdio_read_cmd(bus, PHY_CTRL_TYPE_C22, &cmd_data, value);
+	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C22, &cmd_data, va=
lue);
 }
=20
 static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
-		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
-		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
=20
-	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C22, &cmd_data);
+	return otto_emdio_write_cmd(bus, RTL9300_PHY_CTRL_TYPE_C22, &cmd_data);
 }
=20
 static int otto_emdio_9300_read_c45(struct mii_bus *bus, int port,
@@ -252,10 +253,10 @@ static int otto_emdio_9300_read_c45(struct mii_bus *=
bus, int port,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
-		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
-	return otto_emdio_read_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data, value);
+	return otto_emdio_read_cmd(bus, RTL9300_PHY_CTRL_TYPE_C45, &cmd_data, va=
lue);
 }
=20
 static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
@@ -264,11 +265,11 @@ static int otto_emdio_9300_write_c45(struct mii_bus =
*bus, int port,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
-		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
=20
-	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data);
+	return otto_emdio_write_cmd(bus, RTL9300_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
 static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnu=
m)
@@ -582,9 +583,9 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
-	.cmd_fail =3D PHY_CTRL_FAIL,
-	.cmd_read =3D PHY_CTRL_READ,
-	.cmd_write =3D PHY_CTRL_WRITE,
+	.cmd_fail =3D RTL9300_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL9300_PHY_CTRL_READ,
+	.cmd_write =3D RTL9300_PHY_CTRL_WRITE,
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
=2D-=20
2.54.0


