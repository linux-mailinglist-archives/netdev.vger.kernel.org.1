Return-Path: <netdev+bounces-296234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lgDwAzFqJWoIIAIAu9opvQ
	(envelope-from <netdev+bounces-296234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B465093F
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 14:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=ht0K+C3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42BA2302615B
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373D3A7D6F;
	Sun,  7 Jun 2026 12:54:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A123A4F23;
	Sun,  7 Jun 2026 12:54:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836874; cv=none; b=Udlm1PHIoOWSrNarKaxvhgsYGrTMCzcpEPoxdHd5f3x667zZWaih44fc7XF4ojbfb3ZI1XK6xZGmo13wtHUwRDoEBC82n1KOuasMxY+TQkds8Q9+q9IQp4doFL+L3KtGhDTSFExtiZsM5JUJT/baHXrKDxUay5tea33cs3OAWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836874; c=relaxed/simple;
	bh=Mus1mA4v+pL05M7ncHGUwwofOfa56V2tEZuuLJhcAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qioa8C4xBrhLIKKOnCPoc7H3lp1phgDv112i0iJqCDeDXfHsSo2Xo/s9a3EhMn0QxwR4U3ywJRyuMAMNwRNG04g+tJk25UIncFg1jKAkfPu6CfKCicrqLRxJmzteYuw/sVEZ0xUlj1OHXUnQjAU3OzGG3CsYsrRYByW0gDjtLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ht0K+C3t; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836865; x=1781441665;
	i=markus.stockhausen@gmx.de;
	bh=zGF6LrsOk0URxZuzgolnWc9xJnfBwLBrrO2c8CnGOto=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ht0K+C3t4nbB+QZyiLAWnRrlhReDzyuJ8JIksIC8BPERlNJbRsgti/j7If9m4wau
	 wTuKMJtj1Aeb9RyWEHsvagNQ0y/fToERe+Gk75ub8StNUtf6s6olwnAMD09P6Lqf0
	 /5McbJvc3nEnB5dToo7H+2EK1jYyWEMAy/bOQUByRnDHCY3FePblwLg4uNSoHUkZM
	 TUG4MD8WUFuCJPLlcCPyFccALb1lrI5yGGWKMstCSJ282n7NZQnFjV0MR/NrZi6eZ
	 qQWdzokvwBWH1nzoWLntzJ7sBgZl1u+ew7IKFRy6q5TlA1/CFNk7noTzlzgtWChou
	 z+MA0bLtepqbEALAOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1wN6Lg0IaX-005Cib; Sun, 07
 Jun 2026 14:54:25 +0200
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
Subject: [PATCH net-next 2/5] net: mdio: realtek-rtl9300: Add prefix to register field defines
Date: Sun,  7 Jun 2026 14:54:03 +0200
Message-ID: <20260607125406.2853607-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:ilQO9yDFZFYr3pz3yPZzUkxPjQbH/BdPQSXor41orju1brt4Cyx
 3sQkd0seWsz9eoriLBZqIRLTn54aYeaBUkJLR5H+Ikz963m8dDbky3ywB0E2F9PpcxlYZlp
 tU9MSHNwRtBx5Q4uMVoT890SGdjzeF5kqgG3Ak2dSA/lysQkof/USgrkh0W/KtFfGil1zqe
 V/WVfwQ/qppSE8IdoPn/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VTMNH9kox3w=;slBPs0kZX5iMQBKCiAk2iGHr81L
 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
 fCDDbjpd0uXSbV8fpFRMLvmAIs4xh0n8qX1+/HF
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
	TAGGED_FROM(0.00)[bounces-296234-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F5B465093F

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


