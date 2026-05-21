Return-Path: <netdev+bounces-290587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOQYMWZKD2qRIwYAu9opvQ
	(envelope-from <netdev+bounces-290587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8A5AAD2B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BB8304BBFE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B413FE660;
	Thu, 21 May 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="VACFzAR0"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54573FCB22
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386404; cv=none; b=lMkC6z0UtovbosI93aRcmAbcocci/jEqhnnCHS6sG5jeu0gnjn/doPm15PsTpO/9MzaEDdOE7aOylrIs9abPD4XXt28z5B+Ba5ymzvnvKOIu6f16HfZ2MXQR9v8GX01ezXWWbDWuAU5OoiXK4HKC/Upidr8c5HEwG16bLNH45b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386404; c=relaxed/simple;
	bh=VM/Fiha1YdTeBf1ZMA12zKYR7GbSdgzBlnLDavZdErU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dhy/MyvlOg+vgE3OgmG7pbeBK7jxG+zbEkQV1pQmeTwBBy/vgD4xN8JrvhNkJpUjljHUxmq1FuQHafqzoFGNJt0MU0D4LGO7dLboEUQYcg4ctEVn3A+HulNDECFgynu63YNwTcCxE2X0odafuukwBfVON3fBCESNeykRf67pdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=VACFzAR0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386377; x=1779991177;
	i=markus.stockhausen@gmx.de;
	bh=9DOhlgyaRxt2MtDOrucoC2yrBtfaPAF1Hd7XNz5tFGc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VACFzAR0gpfAZ7b8TDYAJsQKCgM1RvTkz5IwBggF8SYMDXePx0pFJAmP0mhKVeHX
	 YJzgz8xoxUDO9zVMx+1fkST3PEhVi7LZbBwRqQJlRw8oDlL66xSlLZNE1r6LbaOC5
	 FPp9NK90UaC1ZfJ0Nc0Tj5gt8rmdyFs26VU9HvAcRraLTs8VqQJQXfzhLBhJ1hYkH
	 zXNvxQ2GZh2R65k6pYjHtSM2I/3pmuNIVudstK22ty+ps0GHTbdeLP7XtomEsfcYN
	 b6Kgili08VOGL/jFI8MpiMJlfB8UkD+OaZYoSDmXED0sCKswfiW+vXwPFeiTabZu8
	 j44NmVHzpLN1SJbiAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1wzkYA1sBb-00iBxF; Thu, 21
 May 2026 19:59:37 +0200
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
Subject: [PATCH net-next v2 7/9] net: mdio: realtek-rtl9300: Add I/O register
Date: Thu, 21 May 2026 19:59:16 +0200
Message-ID: <20260521175918.1494797-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZzU6rqX3yz0IdZXNuNjYFn5E1KwNajeF/U2LEXj3tznabs/Ir7
 p2FOLDKjgyuRHJg3WWoZXquG16mchKypUx0kXt6wHyMUnAAPU2k19NaMuD4vEBr9W6zo5wQ
 WiiKHW9SJv8nUs7O1dh3G5NoWDQ+2UyDCpX1JTGJRodoo+iAlxW+TaqenCzELX7jY7Z8AbI
 OROt51MT6esLvaJFB5XAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yh+8QLefKIQ=;ECyphEkoZoW3hDMH7dN4Wcr1Z4l
 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
 AtXHtRjyQorP46koh0=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290587-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 67D8A5AAD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MDIO data that needs to be written or read to registers of the
controller is handled by an I/O register. Add that to the register
structure and make use of it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 28 +++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index d294bfaed887..d379b6171e30 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -68,7 +68,7 @@
 #define   PHY_CTRL_TYPE_C22		0
 #define   PHY_CTRL_CMD			BIT(0)
 #define   PHY_CTRL_FAIL			BIT(25)
-#define SMI_ACCESS_PHY_CTRL_2		0xcb78
+#define RTL9300_SMI_ACCESS_PHY_CTRL_2	0xcb78
 #define   PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
@@ -85,6 +85,7 @@
 struct otto_emdio_cmd_regs {
 	u32 c22_data;
 	u32 c45_data;
+	u32 io_data;
 };
=20
 struct otto_emdio_info {
@@ -141,13 +142,14 @@ static int otto_emdio_9300_read_c22(struct mii_bus *=
bus, int phy_id, int regnum)
 {
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
+	u32 io_reg, cmd_reg, val;
 	struct regmap *regmap;
-	u32 cmd_reg, val;
 	int port;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	io_reg =3D priv->info->cmd_regs.io_data;
 	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
@@ -159,7 +161,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, FIELD_PREP(PHY_CTRL_=
INDATA, port));
+	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, port));
 	if (err)
 		goto out_err;
=20
@@ -175,7 +177,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read(regmap, SMI_ACCESS_PHY_CTRL_2, &val);
+	err =3D regmap_read(regmap, io_reg, &val);
 	if (err)
 		goto out_err;
=20
@@ -191,13 +193,14 @@ static int otto_emdio_9300_write_c22(struct mii_bus =
*bus, int phy_id, int regnum
 {
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
+	u32 io_reg, cmd_reg, val;
 	struct regmap *regmap;
-	u32 cmd_reg, val;
 	int port;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	io_reg =3D priv->info->cmd_regs.io_data;
 	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
@@ -213,7 +216,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int phy_id, int regnum
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, FIELD_PREP(PHY_CTRL_=
INDATA, value));
+	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, value))=
;
 	if (err)
 		goto out_err;
=20
@@ -246,13 +249,14 @@ static int otto_emdio_9300_read_c45(struct mii_bus *=
bus, int phy_id, int dev_add
 {
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
+	u32 io_reg, cmd_reg, val;
 	struct regmap *regmap;
-	u32 cmd_reg, val;
 	int port;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	io_reg =3D priv->info->cmd_regs.io_data;
 	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
@@ -265,7 +269,7 @@ static int otto_emdio_9300_read_c45(struct mii_bus *bu=
s, int phy_id, int dev_add
 		goto out_err;
=20
 	val =3D FIELD_PREP(PHY_CTRL_INDATA, port);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, val);
+	err =3D regmap_write(regmap, io_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -283,7 +287,7 @@ static int otto_emdio_9300_read_c45(struct mii_bus *bu=
s, int phy_id, int dev_add
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read(regmap, SMI_ACCESS_PHY_CTRL_2, &val);
+	err =3D regmap_read(regmap, io_reg, &val);
 	if (err)
 		goto out_err;
=20
@@ -300,13 +304,14 @@ static int otto_emdio_9300_write_c45(struct mii_bus =
*bus, int phy_id, int dev_ad
 {
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
+	u32 io_reg, cmd_reg, val;
 	struct regmap *regmap;
-	u32 cmd_reg, val;
 	int port;
 	int err;
=20
 	priv =3D chan->priv;
 	regmap =3D priv->regmap;
+	io_reg =3D priv->info->cmd_regs.io_data;
 	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
@@ -323,7 +328,7 @@ static int otto_emdio_9300_write_c45(struct mii_bus *b=
us, int phy_id, int dev_ad
 		goto out_err;
=20
 	val =3D FIELD_PREP(PHY_CTRL_INDATA, value);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, val);
+	err =3D regmap_write(regmap, io_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -551,6 +556,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_2,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
=2D-=20
2.54.0


