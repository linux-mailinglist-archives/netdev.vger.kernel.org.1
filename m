Return-Path: <netdev+bounces-298952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ya6qGE0/LWoaeQQAu9opvQ
	(envelope-from <netdev+bounces-298952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E417667E759
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=IWGifCrS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298952-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2905E3008251
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E332389115;
	Sat, 13 Jun 2026 11:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED48205E02;
	Sat, 13 Jun 2026 11:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350217; cv=none; b=aIxdMWuq8Sjitvue5iJIfiXyaQrZXOHXTDY0JlsLEYysKRQtzCwUnW1Ze3NIT8SI2lFC9YbEtAPlOlhjvjJMeUmpVJm4wzPdJySPbjM65nBbTSghkQsWKFQEb/CUQHENb7VmpUSeFKEpBSjIFtTdJGZ8xmaseOBjuEr5OHfCwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350217; c=relaxed/simple;
	bh=ifqQzXbrUGAy7YQe4f3nNaUj4GF8XEXVtdNfBEYnpx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNmbDrRPxrr8+5/f8XWTX5CJXMGcS1QqnnarCSFZywAOMtQTEIrvu1WYKJre15zvx6gv1WXP5AT/txTR7CwDpjlwJBra0SAMvivObgTvSpf2lPmLbC3bEXV6ij8O0wsUsxdi0lz7rvFhoxo+06b8Y8pqOKq2HkQy+9/xsyG/qCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=IWGifCrS; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350202; x=1781955002;
	i=markus.stockhausen@gmx.de;
	bh=Rb6656OG3jtqifHrxLtkMq8KBGw+/1UJdIwuQ7Lwwnc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IWGifCrSg/hIUJWYg87ou0z00K/GFWaLJNIY6/YqUUTzTCcDdQfZXbTy9uP+Wr5e
	 KF11TQsTP2tzKVCQz71ehC/9xC4q10/EdhehLzM0hN3pWykKCw44MDEMoiKTEbJ/a
	 HWYfdj58SlaChaw7k/UmqxeSk/U3zMmrQPhPSwJopyysWQwaRY8VyXlnxz4xVDZTi
	 jSbM1OJedXK7qF28if6nA9KMzoeNg0eiJi6B//wiIqCFvjZ2FRwKtZW2R87Y/8EJx
	 fLosnXrwx9IoE97/oC7HpefQX6JlDsQ0iQjMXBjtYgXX+D3Ml9GNo306MK/tCeTsw
	 rfe1cwytONlgL0Vrlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1wMlQy09vy-009VTH; Sat, 13
 Jun 2026 13:30:02 +0200
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
Subject: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Sat, 13 Jun 2026 13:29:41 +0200
Message-ID: <20260613112946.1071411-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v47zTxAv8TQDb6RPWex3H6rTfOvNWN1lvwjDXjeZZGjgCqj8PHY
 NUDldEkFd4sHsRd80dQUXYhenKJ5IUzy968MR/VUdpzvVaetIAXZcnAhMwX3fLKL7LQg3x+
 efSYrMyfE0aJUWC+al6jm0yQrQOo1gPEKL+O0c2OeOOPJAQ/bxpK9x3Fnauwi3KkOrccql4
 6vuOvv40mY0KpFqvVLprg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j9eAAgMIj5I=;EhdktoTLO+IsOA/No01IPRMPH1F
 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
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
	TAGGED_FROM(0.00)[bounces-298952-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E417667E759

The hardware polling unit of the Realtek switches has a very special
handling for PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

As of now all known existing hardware designs have Realtek based 1G PHYs.
Otherwise the polling engine and the MAC status update will not work at
all and the vendor SDK would fail totally.

This driver differentiates clearly between c22 and c45 buses. During
probing it enables only one of the protocols for a bus. So it is safe
to assume that any c22 access will only target a Realtek based 1G PHY.

Intercept access to register 31 and store the desired value for each port
in the driver. When issuing access to other registers add the saved page.
This given, the hardware will run two consecutive c22 commands that are
not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

Remark! To keep this simple, writes to register 31 are only accepted
if they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 32 +++++++++++++++++--------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index da2864c94d2c..c3a9eeca3154 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -193,6 +193,7 @@ struct otto_emdio_priv {
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -337,7 +338,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -351,7 +352,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -391,7 +392,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -403,7 +404,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -442,15 +443,19 @@ static int otto_emdio_9310_write_c45(struct mii_bus =
*bus, int port,
 static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnu=
m)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
-	int ret, port;
+	int port, ret =3D 0;
 	u32 value;
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31)
+			return priv->page[port];
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+	}
=20
 	return ret ? ret : value;
 }
@@ -458,16 +463,23 @@ static int otto_emdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
-	int ret, port;
+	int port;
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
-		ret =3D priv->info->write_c22(bus, port, regnum, value);
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31) {
+			if (value >=3D RAW_PAGE(priv))
+				return -EINVAL;
=20
-	return ret;
+			priv->page[port] =3D value;
+			return 0;
+		}
+
+		return priv->info->write_c22(bus, port, regnum, value);
+	}
 }
=20
 static int otto_emdio_read_c45(struct mii_bus *bus, int phy_id, int dev_a=
ddr, int regnum)
=2D-=20
2.54.0


