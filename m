Return-Path: <netdev+bounces-289537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCRlEOOWDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2266D582BFF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD5B73058D4C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4155E2E9ED6;
	Tue, 19 May 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NmsPYOPA"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197440912D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209919; cv=none; b=IeLyHMQdv74g4RW8s6NtRY58Y8CURzOKrPRPAx0oT5yr3kmVcJ2BykNEotpMIvvDy3bz5ChEwRwKfB4CuBCWDwQ/ceY2T6qnoA6Gx9DXRnv6NHbc+cJhW2HL5Vohmn9bI+8dLaSRLwIqA8wqaBTlgZ4l9cGJMA0kqZH0wl6cpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209919; c=relaxed/simple;
	bh=3JBuPhFeygkd4h4ZZMpvO2crlqHYXC0slNDYumzLrpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxdVALsuqLuMKvem3q6Q8QmQWKvhhKf9hyK+LpFWLLUC9y6lk3FmVjOS+I042tJlWS2THr/hRvFPxrQabmU6wXgRpDYYpaJB+IHQKjLaaS7JaTYNOtDTd1vnvq4+k/X2g3QtWnPxKcTFFWDChBr0YuidkuPxeqTFifiaU4bBdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NmsPYOPA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209890; x=1779814690;
	i=markus.stockhausen@gmx.de;
	bh=IdZRsiXqJOqsTaOGHJuDa3TyszTXuO7prIrYjACsVXs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NmsPYOPAoZ5Jpas7HlPE0ib9mllP7RXYCMLiEJ8OkkQ3yDHtFGEUr2ychDasgDhb
	 4l3EQ1fei9u3/qGLV0rjSQQHa2FQ02LdZnbqYYhqP3SsRWIyNHHAnI/7JXic0rgoy
	 3Mbdu0OMm8xT3uopnoIFyDSRnqY9+gGCx1U7kEejA1fyWjQVRH9JOxr9ZQMRK06C4
	 CB+Ozh+EqHLB6O0TlS8LY9oyRty3FSX1QZ+iehwCKqx41pf5hyO7Xi9tZ1L4q7B+n
	 9YHnrpkj/lyZbawhtTUwfccjHmRRt2v9zCxSsJNJWZDH7sfk+Hd96J4evsK93Ifvh
	 X5o/lnOnNlvXKBtXAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1wp3WJ0Zr3-00V9x0; Tue, 19
 May 2026 18:58:10 +0200
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
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 6/9] net: mdio: realtek-rtl9300: Add command/C22 register
Date: Tue, 19 May 2026 18:57:44 +0200
Message-ID: <20260519165747.1288903-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZLjVqS11U2ZSpuDGy5KSuSoajxoPUIOpczZA8qS0eJIY3RY1wqa
 OCveazZTag5GHxQJ8o97tCS62TkdUw6cNFuSwMS5j1sFG5ggZJOTBtgELrsRqVE0AYsUA3V
 ObWRrdGjQcK38aMsygn/430un+Zy/dgQCZiWRK2YevsbzDB4lTb/ghbgDcGN9XRsQ71ztBu
 zZdgQcAmaXsZdw2iP7xiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nMDWAsTRAqo=;MZ2msWTTdRTUfzlNa6pF37qUw3u
 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
 p0WcUw==
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289537-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 2266D582BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Command issuing/status bits and C22 data share the same register. In the
future the number of places where this register is used will be:

- 1 command runner
- 16 individual read/write/read_c45/read_c45 functions

So name the register c22_data to align with the existing c45_data
register and add it to the register structure. Make use of it
where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 38 +++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index e382f57b7738..855c7935617f 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -26,7 +26,7 @@
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
 #define SMI_ACCESS_PHY_CTRL_0		0xcb70
-#define SMI_ACCESS_PHY_CTRL_1		0xcb74
+#define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
 #define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
 #define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
 #define   PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
@@ -54,6 +54,7 @@
 #define RTL9300_NUM_PORTS		28
=20
 struct rtl_mdio_cmd_regs {
+	u32 c22_data;
 	u32 c45_data;
 };
=20
@@ -99,12 +100,12 @@ static int rtl_mdio_phy_to_port(struct mii_bus *bus, =
int phy_id)
 static int rtl_mdio_wait_ready(struct rtl_mdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
-	u32 val;
+	u32 cmd_reg, val;
=20
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
 	lockdep_assert_held(&priv->lock);
=20
-	return regmap_read_poll_timeout(regmap, SMI_ACCESS_PHY_CTRL_1,
-					val, !(val & PHY_CTRL_CMD), 10, 1000);
+	return regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_C=
MD), 10, 1000);
 }
=20
 static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int reg=
num)
@@ -112,12 +113,13 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus=
, int phy_id, int regnum)
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
+	u32 cmd_reg, val;
 	int port;
-	u32 val;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -136,7 +138,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
 	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
 	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
+	err =3D regmap_write(regmap, cmd_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -161,12 +163,13 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
+	u32 cmd_reg, val;
 	int port;
-	u32 val;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -189,12 +192,11 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
 	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
 	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
+	err =3D regmap_write(regmap, cmd_reg, val);
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read_poll_timeout(regmap, SMI_ACCESS_PHY_CTRL_1,
-				       val, !(val & PHY_CTRL_CMD), 10, 100);
+	err =3D regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_=
CMD), 10, 100);
 	if (err)
 		goto out_err;
=20
@@ -216,12 +218,13 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus=
, int phy_id, int dev_addr,
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
+	u32 cmd_reg, val;
 	int port;
-	u32 val;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -243,8 +246,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1,
-			   PHY_CTRL_READ | PHY_CTRL_TYPE_C45 | PHY_CTRL_CMD);
+	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_READ | PHY_CTRL_TYPE_C45 =
| PHY_CTRL_CMD);
 	if (err)
 		goto out_err;
=20
@@ -270,12 +272,13 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bu=
s, int phy_id, int dev_addr,
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
 	struct regmap *regmap;
+	u32 cmd_reg, val;
 	int port;
-	u32 val;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -301,13 +304,11 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bu=
s, int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1,
-			   PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE | PHY_CTRL_CMD);
+	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE=
 | PHY_CTRL_CMD);
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read_poll_timeout(regmap, SMI_ACCESS_PHY_CTRL_1,
-				       val, !(val & PHY_CTRL_CMD), 10, 100);
+	err =3D regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_=
CMD), 10, 100);
 	if (err)
 		goto out_err;
=20
@@ -519,6 +520,7 @@ static int rtl_mdiobus_probe(struct platform_device *p=
dev)
=20
 static const struct rtl_mdio_info rtl9300_mdio_info =3D {
 	.cmd_regs =3D {
+		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
=2D-=20
2.54.0


