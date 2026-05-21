Return-Path: <netdev+bounces-290582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFtNOd5JD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C55AAC65
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9432E302E793
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBAD3EAC82;
	Thu, 21 May 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="R9Nh78R6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420CC3FB7FC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386398; cv=none; b=P8RJCzUIqNb5LhafPyy1HM7rjU5yFyF8eAJ/DVe8zzM7v0yVr3f9nZh+YvaN2ETdk6CVXJbPxii7PvX5d676XnMnys6kKj8R22BYEvRdEaklD54ajfiZiIrQpWz0CEWtzAjKyK2WdfrIHiIs/8dOMDuf8A7RqRrwis3lOvASuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386398; c=relaxed/simple;
	bh=pA9A6JBQTWasJTfbIvqldnJd/5QiBS7LDPTg/frEia8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwA8x7HcumC1PFrhxygNBQUIFRskkzxLsR6g+Prg+wHDj39BgjZS+diNFfeFWrotq/+F/m1Kjq1fZ0Z1Zixi8ehZIxqgd95ZVsmbAF8woU1Wctrqe9lH/OvnUyq7n5Gt8LnlIIWqNZkTl5ff+4eD+hOf+4jMPkUdsMF5E1T7w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=R9Nh78R6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386377; x=1779991177;
	i=markus.stockhausen@gmx.de;
	bh=SY53dMSWYrmyjocfJD2xbcxRXcBvb923BAzXC4ST10g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R9Nh78R6Amv+GvEqPOjfKCTm3NEh+m187jr+hg2aOGzU/fIGQbpmfJLgpCn1Vafd
	 nOQl19ULTrUUIRf5AZpGvh3Vpl/y4NZNXxVGiY5t0eW+87zaH7BFsfMyUgR7iakZO
	 B4S/JJhP3iLcHeHvJcU2TFTkahUdslSsZXfltmb/QuI/F0EkroD9vY5Yfv9OLXm0C
	 l3PtZv9K0WvqVuJm6AH5AaTOh+IRA7hiTDAJ4lMub7j/hm6tvbN6iaRYBEFs5j3ok
	 Tr+IRnBx98ryNcVv8sDAZF3hLjHPDMsAidgkWrJbbM3fOjkS90bZwY7/G+Mp90+6k
	 pXDlmRvOdk6cfQH3OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1xQw5N0kY8-00rqju; Thu, 21
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
Subject: [PATCH net-next v2 6/9] net: mdio: realtek-rtl9300: Add command/C22 register
Date: Thu, 21 May 2026 19:59:15 +0200
Message-ID: <20260521175918.1494797-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:+WLYtsxarh/7hHsf45hKNwili8oxw5tyf5aMkMGrEL3AlQPlqtx
 0QvRwY3rAbQ5WDtPhBtk90UpgD1gEndKymT9LaLIa9gshQq7d2AzwuB1U25TRoPF6FaGcrt
 JNnU47VBH0RebOuFkBJUy45clafHivLqoCVDB9w85YAJHLnGUlJ0tSWqBAqpph7lsFdHZvZ
 8gd6ulVppBHdJSClHJ5pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2GFHcRBG6K8=;Jz9SRAow34Rc70YKJcMTp4Gavcn
 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
 iR636MaxG4GWQNcfp/UZ8oavHhxQEFvifDSmcFX
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
	TAGGED_FROM(0.00)[bounces-290582-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: EA9C55AAC65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Command issuing/status bits and C22 data share the same register. In the
future the number of places where this register is used will be:

- One generic command helper/runner for all devices that will access the
  command bits of the register
- 8 device specific C22 read/write functions that will access the C22
  data fields.

Thus name the register c22_data to align with the existing c45_data
register. This way all device specific helpers will have a common
view on the to-be-fed data. Add the register to the existing structure
and make use of it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 38 +++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index c992f09835f9..d294bfaed887 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -58,7 +58,7 @@
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
 #define SMI_ACCESS_PHY_CTRL_0		0xcb70
-#define SMI_ACCESS_PHY_CTRL_1		0xcb74
+#define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
 #define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
 #define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
 #define   PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
@@ -83,6 +83,7 @@
=20
=20
 struct otto_emdio_cmd_regs {
+	u32 c22_data;
 	u32 c45_data;
 };
=20
@@ -128,12 +129,12 @@ static int otto_emdio_phy_to_port(struct mii_bus *bu=
s, int phy_id)
 static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
-	u32 val;
+	u32 cmd_reg, val;
=20
 	lockdep_assert_held(&priv->lock);
+	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
=20
-	return regmap_read_poll_timeout(regmap, SMI_ACCESS_PHY_CTRL_1,
-					val, !(val & PHY_CTRL_CMD), 10, 1000);
+	return regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_C=
MD), 10, 1000);
 }
=20
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int phy_id, int =
regnum)
@@ -141,12 +142,13 @@ static int otto_emdio_9300_read_c22(struct mii_bus *=
bus, int phy_id, int regnum)
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
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
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -165,7 +167,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int phy_id, int regnum)
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
 	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
 	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
+	err =3D regmap_write(regmap, cmd_reg, val);
 	if (err)
 		goto out_err;
=20
@@ -190,12 +192,13 @@ static int otto_emdio_9300_write_c22(struct mii_bus =
*bus, int phy_id, int regnum
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
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
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -218,12 +221,11 @@ static int otto_emdio_9300_write_c22(struct mii_bus =
*bus, int phy_id, int regnum
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
 	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
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
@@ -245,12 +247,13 @@ static int otto_emdio_9300_read_c45(struct mii_bus *=
bus, int phy_id, int dev_add
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
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
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -272,8 +275,7 @@ static int otto_emdio_9300_read_c45(struct mii_bus *bu=
s, int phy_id, int dev_add
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
@@ -299,12 +301,13 @@ static int otto_emdio_9300_write_c45(struct mii_bus =
*bus, int phy_id, int dev_ad
 	struct otto_emdio_chan *chan =3D bus->priv;
 	struct otto_emdio_priv *priv;
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
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -330,13 +333,11 @@ static int otto_emdio_9300_write_c45(struct mii_bus =
*bus, int phy_id, int dev_ad
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
@@ -548,6 +549,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.cmd_regs =3D {
+		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
=2D-=20
2.54.0


