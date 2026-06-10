Return-Path: <netdev+bounces-297816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iKioOSS+KWp1cgMAu9opvQ
	(envelope-from <netdev+bounces-297816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4168C66C8CB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=P9PIZVOY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8EE315AA02
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052837B400;
	Wed, 10 Jun 2026 19:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6E37B41F;
	Wed, 10 Jun 2026 19:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120540; cv=none; b=Q+hznw+dxLoSnCAfj65O2AjMU5sQ2nzJy35UMBff8GzhK0OYc+xC+rITUGMZYdpJh+s//Q3Df9Usy/Jka7sBLVk5p9HWQmXJXeX3fPLjq0khqsJjwqDwuZTAML7aMt3cM3s1niesx/mV/irl51norl6QQZlILyqHAU42NN+nCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120540; c=relaxed/simple;
	bh=qgTvZsQudVhiACT5mr/bDveB/SWOCbi3K6DL/Nfhqcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx00Sa1ihLIJ0GsWsyF93MCcjyMeAXm8C8GbmleLlUnLcVSKV3kWHHcsbYDY8sZA5Tlz3EOnWXHil1lRhChVnP9Q9AUNyunBuJGsUUEjv1d+G7WCd1+p8x9swUAkVTPg33iJcvbSf1+s4LUWFYKnxb+3vwpfUFMn0FbWP1T+v5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=P9PIZVOY; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781120524; x=1781725324;
	i=markus.stockhausen@gmx.de;
	bh=H06MNiUVKeD0XG85Cjvbg78n6e7kRCHAD8CBdf4Ub2A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P9PIZVOYgsT7UFGSHASjvshuTQDSIzzm9hIX/83BKjitANoLT1/w96iah/sYTYxN
	 NvuH5zYCaIb8WKZYisnznG7rtWf8L5Tj24wgw2RfuAsVV2esqVPvpKhhbYr+I8344
	 Eq79IkEY5LgcMlfTSL2WbeaTYi9jfcLDd/l23T10q4ieHyRi5FHHgw/FJ9VxqsL56
	 /V0BkzxyVVaAjcKJrOx45nompF57E4J2FiBMLBkWCZ9V+LA81wdiO7OKAQnmDWGeA
	 ZVvFdQkP7gEGxG6rwklYIL/wsLC9Iua29pKpmfMkNVYgCcRI60c/F7fo8A+E0E8VN
	 aLSt8AhCFuwpuDqQwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1wsKwh42Yu-00MFIR; Wed, 10
 Jun 2026 21:42:04 +0200
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
Subject: [PATCH net-next v3 2/5] net: mdio: realtek-rtl9300: Add prefix to register field defines
Date: Wed, 10 Jun 2026 21:41:42 +0200
Message-ID: <20260610194145.4153668-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:Uu8cKQrgxKztIOPCN9muuIEUcUfY9R3+bveaEQYIvStFbaJ8BXP
 vOvWGP5eR9qSSyyEusvIkG6JsvcVV1UYmUVI+ji7Z4yKHdUUOYeUCVeI+D3ZLuvpSwInduQ
 YdRlSdD3750+MRgUuQsE7kZ7NNT+75X5yuUVhdn5RiUSUz8BG60vYwDOMD66buZHSWnWhJd
 GSi29GA73WWB/bc05LW+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h7YFD2UpgCQ=;azovPPr2nds8EqNt6TKN/204SbN
 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
 oWYaBNV0sg3P7Ddauk=
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
	TAGGED_FROM(0.00)[bounces-297816-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4168C66C8CB

The current Realtek Otto MDIO driver has some define leftovers without
a SoC prefix. When adding new devices there will be an overlap for some
of them. Sort this out as follows:

- PHY_CTRL_CMD/PHY_CTRL_MMD_DEVAD/PHY_CTRL_MMD_REG are common for all
  series. Leave them as is but move them into a separate block.
- Add RTL9300 prefix to all other defines and adapt the callers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


