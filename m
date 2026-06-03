Return-Path: <netdev+bounces-294865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4YmJDZsIGrp3AAAu9opvQ
	(envelope-from <netdev+bounces-294865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290063A5C2
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=mzwvSPZt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294865-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEF530435B5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0245A37F75D;
	Wed,  3 Jun 2026 18:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF237F8DB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509612; cv=none; b=m+82Res9rkVMgEm0rSg263GVS+wkpqcB39mwN3tN7GusHH2fhLTKlpWcn3o5UvRMc4douQOjzgmCx/EDpWRPZBxGFp4ifKTkURQqih3z5xViAPAm+JK32GHw0gHT6pB65ID2qf9YuBqIWGEJlJ+hZ1DkBqA6lT1Xg0gUQTJwhjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509612; c=relaxed/simple;
	bh=7iWd96veQR3BzNK9nKYvncFdTQhDIUYyPVpEVY6Z6Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GteP/ELD04/IFEscc3A/IAj3TURVijqVdHjWPuP59iYhl/4qk1t9ZJdojpiQ9B+ks6eV672WCr6K4GFgM+TNVTHmCiGCfTtwKMyY3f6tMXUmZYodWSkohW107maIBc7/fBNodF1N2Lc35ZVi1zm62DTT+TpV/mLiJYEpLRaDUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mzwvSPZt; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509609; x=1781114409;
	i=markus.stockhausen@gmx.de;
	bh=CllolFvOMaUy+lzWy6bM+zfHP0IVy/E+g2bAIxNQyyI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mzwvSPZtpx1JlMVecmBoVfmxvlmX3Ir3Eh2ChUXy2qCB+SwZaUzK6jlYT+j9qHww
	 NMzWmruJWX8nAYOk7IG9qkK6nozudUO5kKCTMOafKq30hh5R4hY1EvB7lsGdy+tfP
	 fzSv+zC3UBVfQC/WGaLVvgP+SMOeNDr8tqSROZBdFim/PfNahfhHr3f9V7QV0daIb
	 8dWM9N532L72FckAUcxRV1k0ms+HXOgnt6ZZP3IUoqwip/Djot5my0bvJqXCPDGoD
	 I/VIDa3XE9Of6LDhSdPUM8NZv8JvEKrTk79NBnTIJymhrKSBginz19L2Kimxb45Rs
	 7iWXPiluH//sxGiYTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1xPGp21WcX-015raZ; Wed, 03
 Jun 2026 20:00:09 +0200
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
Subject: [PATCH net-next v2 6/7] net: mdio: realtek-rtl9300: reorder controller setup
Date: Wed,  3 Jun 2026 19:59:23 +0200
Message-ID: <20260603175924.123019-7-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603175924.123019-1-markus.stockhausen@gmx.de>
References: <20260603175924.123019-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4aDQTyHDcn851cAwOVx93CyAbxAsnweG5XuZBQCxKLT/WDyRFvX
 hFDl4yUVFSatXrEC60P/8TTAFTORDIiqyvl1wmidfV13GPYT0FjBnBiLlRZkyHkY445fGDg
 XSHgGnkmU/20OD0/dAd3BlqRVMFb/WYduV1ZXBxjEGnaPzvYHhKVhwz5MG1Vf42SSB5qS3Z
 tlV5FQEw34FShE23f3NvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SB2IkNuOC4w=;uT3M2icBPPIsNDCb7j/5XJXar+w
 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
 QStaULtjsv7pG2+/+QrBeDQVS0eY3pF2g1Ui3Hi
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,m:markus.stockhausen@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294865-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2290063A5C2

After the former refactoring the existing otto_emdio_9300_mdiobus_init()
contains only the c22/c45 bus mode setup. Like the topology setup this
must run before bus registration. Otherwise the bus does not "speak" the
right protocol for PHY setup.

This setup is device-specific and other SoCs will need to set up other
register bits in the controller in the future. Therefore

- Relocate c22/c45 device tree readout to the very beginning of the probin=
g
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
index e626dd7fb4b8..bd361aa19739 100644
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
@@ -92,6 +92,17 @@ struct otto_emdio_cmd_regs {
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
@@ -102,23 +113,13 @@ struct otto_emdio_info {
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
@@ -369,7 +370,7 @@ static int otto_emdio_setup_topology(struct otto_emdio=
_priv *priv)
 	return 0;
 }
=20
-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
 	struct regmap *regmap =3D priv->regmap;
@@ -379,9 +380,9 @@ static int otto_emdio_9300_mdiobus_init(struct otto_em=
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
@@ -548,16 +549,18 @@ static int otto_emdio_probe(struct platform_device *=
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
@@ -576,6 +579,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
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


