Return-Path: <netdev+bounces-289538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMwoHeWWDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDED582C0E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66CD73059E41
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC23264D8;
	Tue, 19 May 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="hgoKsZ5H"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AE409116
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209919; cv=none; b=hAndWmE4lxDtqeIoGe5DrRaI4vIf19Nky/wh32iq9i4cDQun0FUtlq2WitrYwQCfh1Gej+3Bv0IGcgCrxjGqXZBqFo1NED8Jca6Amz1HQIUapKW20prxrDzywDFvl+dvnH/0aR3sOQ1JpuIRsM4Bo4i3NzNDPvatVqsNCtJdVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209919; c=relaxed/simple;
	bh=R8wsIqmLD/ls6Ts82vD/gZLpcqisZLaXEYWRKpu2nzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgOonjuCTUxXnZrqb0qkp5pZkczpgq72qZHTdvI9fScT/Ovm0S0S6y6p9nkf525Ygw5ZlKvzWvPCCZDXsoCocuvr1raHSyFD0zXL7FHK/h3Dj/AneeFlFyBSGdTotXLKf41imuEgImUt4NjTiWMLgPqMfCCncDKCQanjgbDPr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=hgoKsZ5H; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209890; x=1779814690;
	i=markus.stockhausen@gmx.de;
	bh=7/hUmjpCCTKj9ptRKGc6Q+zx8pP0SgtPanDfyIZyCec=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hgoKsZ5H+Rhy0SKnixVBscGvaOERJ+R+88xx4Hj3VfLjdI2nMWbbB17LWqyHnqr/
	 FA+VC2KNh6ijLTxh1ekJyiNDMSRSMxFmeJeKhqFGmSBpqVvCa3oD2/jNId5A7eNZq
	 jbFp7C7wKZH6YlD+/HeoqXd+Pv+qMezJLtsMXosh1t9sai4vrHhEZJiE73DpZGQ7d
	 DNl3IHpFsiYRgLSR9sgP70QS6ZQPiyK+tB13/ZaiPYnUdWmcTy50qQom8yw8CU0Nj
	 bQFdv4b8kVF17T7sUSXu6xOx59g3asLu80Mlst28QZaIg9nNhXQCH3E+JM7/lTAp4
	 Kh8NNh1q1KU2mtbOsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MirjS-1x1ijO1Z8W-00ZMwx; Tue, 19
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
Subject: [PATCH 7/9] net: mdio: realtek-rtl9300: Add I/O register
Date: Tue, 19 May 2026 18:57:45 +0200
Message-ID: <20260519165747.1288903-8-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:ihm55pHFkAufyPa42a811GgM+OyQVM//lgNWoMckk06c/6Pg7Sk
 AlfzKS8u52SEDkKIehqYdx5xgPNVQ6PN3z0eKn7y2uUyFEyN9HbspJiu0Ao0QKzLODkpPbN
 dCyeIcQrmkKvhjLUF5m3JA2ymCxHaMureAJHntjXgAcTgJuIEqGfgce631+gc7tKEGy2hDX
 FFv7GawHg1eMVE/KmESyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MVLrgegjA9k=;09I7ykjJBxSJ3PrUmhjgC7KYEC8
 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
 i8zvJyxU4wftfSYUG2wPN6pt4NRajCDF32Xw=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289538-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1BDED582C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MDIO data that needs to be written or read is handled by an I/O
register. Add that to the register structure and make use of it where
needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 28 +++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 855c7935617f..be6a0cfe4bb8 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -36,7 +36,7 @@
 #define   PHY_CTRL_TYPE_C22		0
 #define   PHY_CTRL_CMD			BIT(0)
 #define   PHY_CTRL_FAIL			BIT(25)
-#define SMI_ACCESS_PHY_CTRL_2		0xcb78
+#define RTL9300_SMI_ACCESS_PHY_CTRL_2	0xcb78
 #define   PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   PHY_CTRL_DATA			GENMASK(15, 0)
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
@@ -56,6 +56,7 @@
 struct rtl_mdio_cmd_regs {
 	u32 c22_data;
 	u32 c45_data;
+	u32 io_data;
 };
=20
 struct rtl_mdio_info {
@@ -112,13 +113,14 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus=
, int phy_id, int regnum)
 {
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
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
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
@@ -130,7 +132,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, FIELD_PREP(PHY_CTRL_=
INDATA, port));
+	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, port));
 	if (err)
 		goto out_err;
=20
@@ -146,7 +148,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read(regmap, SMI_ACCESS_PHY_CTRL_2, &val);
+	err =3D regmap_read(regmap, io_reg, &val);
 	if (err)
 		goto out_err;
=20
@@ -162,13 +164,14 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bu=
s, int phy_id, int regnum, u
 {
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
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
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
@@ -184,7 +187,7 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bus,=
 int phy_id, int regnum, u
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
@@ -217,13 +220,14 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus=
, int phy_id, int dev_addr,
 {
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
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
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
@@ -236,7 +240,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 		goto out_err;
=20
 	val =3D FIELD_PREP(PHY_CTRL_INDATA, port);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, val);
+	err =3D regmap_write(regmap, io_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -254,7 +258,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_read(regmap, SMI_ACCESS_PHY_CTRL_2, &val);
+	err =3D regmap_read(regmap, io_reg, &val);
 	if (err)
 		goto out_err;
=20
@@ -271,13 +275,14 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bu=
s, int phy_id, int dev_addr,
 {
 	struct rtl_mdio_chan *chan =3D bus->priv;
 	struct rtl_mdio_priv *priv;
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
 	port =3D rtl_mdio_phy_to_port(bus, phy_id);
@@ -294,7 +299,7 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bus,=
 int phy_id, int dev_addr,
 		goto out_err;
=20
 	val =3D FIELD_PREP(PHY_CTRL_INDATA, value);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, val);
+	err =3D regmap_write(regmap, io_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -522,6 +527,7 @@ static const struct rtl_mdio_info rtl9300_mdio_info =
=3D {
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_2,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
=2D-=20
2.54.0


