Return-Path: <netdev+bounces-294025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ+oGOxpHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:28:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E06288AE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82F36301D13F
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4D24BBEB;
	Tue,  2 Jun 2026 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="NfgStmbp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D72F8EB7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378033; cv=none; b=FfJKKcjaxxlApNo9+VhF5DPYhcE6XfOMN7Fijw+nzimawbK2wVWPdiDT4H0I5YdzPFD45QeEVCapz7dN3zLrPXWdfTZYY98fpr7ltrb6YbD2XhJJfHn10ttgP1gnRWg5VCPn0AoNOkqp7d6QwBzpeEelyTI1Gm1ry2yABjEG+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378033; c=relaxed/simple;
	bh=aOLr2LC5ihDJ/0G2ZxE5bemQNFA2SVhFGJkVE+QHqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZzc7y5QPckiNU39m5cMhwgSteFQrYZFu9zcSmGi8Lq5Og76uACTiUNrgm74EB5OzLtx9cT9MuwrrchsmJGI7xF0M155hPATxwjoXh6vsPUr3Ht2vIAfVT6D5+zd5ZsNu7c3oYIz6lJFHanBKA2Uhk4mjK1Q6H7UnN9ERB0FP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=NfgStmbp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378014; x=1780982814;
	i=markus.stockhausen@gmx.de;
	bh=1w4nbZscYZzyIXYM4DLmAvdEHfpTQHxnuDheKjfhZNk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NfgStmbpia+lV6yghGRpOd1enhO5sg+xZlaKt4Xq70DjFnio6qsKxY/M0KTIKOf3
	 COyMgKawVG9NNb7ZAXi0HnT0Qs/rdSq+fVBdugD0CpK33nu1UwEwSmfxYknUqm/By
	 vDKzok0ZRbGI8t32fnLb/xaVWFBJ3c+Acrp9YWKX9Iy2z/uQtrKq/0LFWrlrwuy5u
	 1y/kLUX7JKNKAXPegIE8Q3j9YAKWm+E+TWc22TznAnXuHiRQ6JmXaUT/59M+WLy9s
	 WtO3HmyYGEHoqsWTXgrXW0NaVLrfe/ZiftHXibfaEKKU681sVxG/3yxrtdMpKv1U+
	 zqQNC8vri65H9DDUEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1x94zK2Wwm-00nnBd; Tue, 02
 Jun 2026 07:26:54 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 7/8] net: mdio: realtek-rtl9300: reorder controller setup
Date: Tue,  2 Jun 2026 07:26:39 +0200
Message-ID: <20260602052640.93083-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wb+zW6KdP9CwbhUc0qOxOwrA7BzGDfElRbNH6457LRGkFOHK0Ku
 PUb0s5+WCSpzn54HSr4c8t1XSiWRdV6fvbm+xP2gtGvmDy8ELWcAbDdQLNwB/7L/TNt2agg
 s5KKOCdzH1yCmLdaxtZbCUux95mImrZevfDVOObGHgv33Pm474UW2eE4NxEJQgd8enSt6qY
 Xc8Pc+USicr3G+50Ix9sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tGoC4XyeuXk=;pbBKuuN1g5JUtfjO3a/JeRQSPix
 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
 Q1lj3eFWvgUgEjnJZuS9hBzNnFMYB/twkZ/LHlz
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294025-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 694E06288AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After the former refactoring the existing otto_emdio_9300_mdiobus_init()
contains only the c22/c45 bus mode setup. Like the topology setup this
must run before bus registration. Otherwise the bus does not "speak" the
right protocol for PHY setup.

This setup is device-specific and other SoCs will need to set up other
register bits in the controller in the future. Therefore

- Add a new device-specific setup_controller() into the info structure.
- Relocate otto_emdio_priv to satisfy the new info structure dependency.
- Rename otto_emdio_9300_mdiobus_init accordingly and add it to the
  RTL9300 info structure. At the same time, adapt register naming
  for the function to make it clear that it only applies to this SoC.
- Call setup_controller() prior to bus registration.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 44 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 9f67d8dd4185..50fc8582571d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -54,8 +54,8 @@
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
-#define SMI_GLB_CTRL				0xca00
-#define   GLB_CTRL_INTF_SEL(intf)		BIT(16 + (intf))
+#define RTL9300_SMI_GLB_CTRL			0xca00
+#define   RTL9300_GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
@@ -88,6 +88,17 @@ struct otto_emdio_cmd_regs {
 	u32 port_mask_low;
 };
=20
+struct otto_emdio_priv {
+	const struct otto_emdio_info *info;
+	struct regmap *regmap;
+	struct mutex lock; /* protect HW access */
+	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u8 smi_bus[MAX_PORTS];
+	u8 smi_addr[MAX_PORTS];
+	bool smi_bus_is_c45[MAX_SMI_BUSSES];
+	struct mii_bus *bus[MAX_SMI_BUSSES];
+};
+
 struct otto_emdio_info {
 	u32 addr_map_base;
 	u32 bus_map_base;
@@ -98,23 +109,13 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	int (*setup_controller)(struct otto_emdio_priv *priv);
 	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
 	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
=20
-struct otto_emdio_priv {
-	const struct otto_emdio_info *info;
-	struct regmap *regmap;
-	struct mutex lock; /* protect HW access */
-	DECLARE_BITMAP(valid_ports, MAX_PORTS);
-	u8 smi_bus[MAX_PORTS];
-	u8 smi_addr[MAX_PORTS];
-	bool smi_bus_is_c45[MAX_SMI_BUSSES];
-	struct mii_bus *bus[MAX_SMI_BUSSES];
-};
-
 struct otto_emdio_chan {
 	struct otto_emdio_priv *priv;
 	u8 mdio_bus;
@@ -364,7 +365,7 @@ static int otto_emdio_setup_topology(struct otto_emdio=
_priv *priv)
 	return 0;
 }
=20
-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
 	struct regmap *regmap =3D priv->regmap;
@@ -374,9 +375,9 @@ static int otto_emdio_9300_mdiobus_init(struct otto_em=
dio_priv *priv)
 	glb_ctrl_mask =3D GENMASK(19, 16);
 	for (i =3D 0; i < priv->info->num_buses; i++)
 		if (priv->smi_bus_is_c45[i])
-			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
+			glb_ctrl_val |=3D RTL9300_GLB_CTRL_INTF_SEL(i);
=20
-	err =3D regmap_update_bits(regmap, SMI_GLB_CTRL,
+	err =3D regmap_update_bits(regmap, RTL9300_SMI_GLB_CTRL,
 				 glb_ctrl_mask, glb_ctrl_val);
 	if (err)
 		return err;
@@ -552,16 +553,18 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 	if (err)
 		return err;
=20
+	if (priv->info->setup_controller) {
+		err =3D priv->info->setup_controller(priv);
+		if (err)
+			return dev_err_probe(dev, err, "failed to setup MDIO bus controller\n"=
);
+	}
+
 	device_for_each_child_node_scoped(dev, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
 			return err;
 	}
=20
-	err =3D otto_emdio_9300_mdiobus_init(priv);
-	if (err)
-		return dev_err_probe(dev, err, "failed to initialise MDIO bus controlle=
r\n");
-
 	return 0;
 }
=20
@@ -580,6 +583,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.setup_controller =3D otto_emdio_9300_setup_controller,
 	.read_c22 =3D otto_emdio_9300_read_c22,
 	.read_c45 =3D otto_emdio_9300_read_c45,
 	.write_c22 =3D otto_emdio_9300_write_c22,
=2D-=20
2.54.0


