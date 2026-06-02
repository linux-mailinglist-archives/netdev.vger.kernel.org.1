Return-Path: <netdev+bounces-294023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KRkGNhpHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B529628898
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83F4F3019965
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A42245005;
	Tue,  2 Jun 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="iRJnQuUv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4F2AE7A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378030; cv=none; b=R15D2DD2unR9Lf+OLh/5S6Q5OYB1QT9NGxA1wU2dd1Zp76rmhYIMpL1X8hBgRUknxVTSIDKRWEkBQ06iLoqhjBHCpsT44diIRfpqnhkARHEy9tCMTiAvNYkS/Ymci9ldKOrJToBMLYUwdKHuOTdR/6zhj1ucEo4ApqKuxCybJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378030; c=relaxed/simple;
	bh=Kt8cDPiJKtD1dKqeT2N9vVMF7GUE/tRCGPcLCqobuJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/48eLRllUgf9Enpugtjsv42LXHStJ5dNGA0m5K3U/dZwhu+mR6A3K8mj11vTEnP8ANwVsmn8g9hMP5apRyi6Hmp0Gdet61YKJgPmrSCxJ3Lm5ZEk1OOJtwd40EVuoGKsWA6QV/mGA7UWTmTTWqE8u/9N/ClqQmuHfsurP0NqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=iRJnQuUv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378014; x=1780982814;
	i=markus.stockhausen@gmx.de;
	bh=Y8SerfR/XfCBJ+ktFwZyGfw/Ex3Gjy+NpWwlnhnocQw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iRJnQuUvsDJreMC01IDW9WXl+cJSkcgMERzz/P1hoSyz1guVBZjzrDelgiHGWts0
	 85OjzLVAw9jb6pTJSNlYApa5vUiUT+zVaIg/EXPpmbo6G60CCGIIJJ9WrZ2bOSzlU
	 dTc4f1cqH5dAj+EXfYLmoYJbaAd1SrclFr07GameorgKxtxU2S0ab/PpARLKqpY9L
	 HmAT4ny807H2niqEUHNxj+rw3A4tf2luGoYItCnRS1GmCl1fUMsnBbZxGHdjxscuf
	 gKDNKgcudhWb/xXeSs55jo6k90cAfT6AyAkUTBrvDKIpKqzIHMgFAu+2ybLC4XkNi
	 4tIn7EogalX1BeYytg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1we7xS0QnM-00JDcj; Tue, 02
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
Subject: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate topology setup
Date: Tue,  2 Jun 2026 07:26:38 +0200
Message-ID: <20260602052640.93083-7-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:ieXTac8HDzNGfBKlNzc4FVwivLqa9v5O713L0kB5GXavKdcSd9T
 vdR/7CsahKdnuV9ceWF7LdKlFsRNngkwMCSzU3E/KQ60rkEcP6yKRQK+VRvo9+2amegLhtS
 mthyRsGRxaY+TwTP+Rkq8noOJnxizV8R2tvjxJWTzTWbAd3yjaltmRL61wWDpWi/ZRq2w9g
 qu+idX6ilihY9CcUl8A3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uyalj6xOExQ=;04ldO+Cl7k4X70xBTYa+yvD4znT
 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
 rhaloK2p2OJXNnf3mJDoneXt23QYWzBPah6Ehnu
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294023-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 8B529628898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Until now the driver sets up the port to bus/address topology of the
controller after all buses are set up via otto_emdio_probe_one(). This
does not work for devices where U-Boot skips this setup. It is not
only needed for the hardware internal background PHY polling engine
but essential for access to the PHYs during probing.

Depending on the SoC type there exist two different register arrays

- Bus mapping registers (RTL930x, RTL931x) define to which bus the port
  is attached. E.g. [1]
- Address mapping registers (RTL838x, RTL930x, RTL931x) define to which
  address of the bus the port is attached. E.g. [2]

Relocate the topology setup and make it generic. For this

- Define device-specific bus_base/addr_base attributes that give the
  register base address where the mapping lives. In case one or both are
  not given the SoC does not support this specific type of mapping.
- Create a helper otto_emdio_setup_topology() that writes the detected
  topology to the registers.
- Call this helper prior to otto_emdio_probe_one().
- Remove unneeded code from otto_emdio_9300_mdiobus_init().

Subtle change: The old coding used regmap_bulk_write and silently wrote
bus=3D0/address=3D0 to mapping registers for ports that are out of scope.
The new coding leaves those untouched.

[1] https://svanheule.net/realtek/longan/register/smi_port0_15_polling_sel
[2] https://svanheule.net/realtek/longan/register/smi_port0_5_addr_ctrl

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 70 ++++++++++++++++---------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 74ea2550e652..9f67d8dd4185 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -56,7 +56,7 @@
 #define RTL9300_NUM_PORTS			28
 #define SMI_GLB_CTRL				0xca00
 #define   GLB_CTRL_INTF_SEL(intf)		BIT(16 + (intf))
-#define SMI_PORT0_15_POLLING_SEL		0xca08
+#define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
 #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
 #define   PHY_CTRL_REG_ADDR			GENMASK(24, 20)
@@ -74,7 +74,7 @@
 #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
 #define   PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define   PHY_CTRL_MMD_REG			GENMASK(15, 0)
-#define SMI_PORT0_5_ADDR_CTRL			0xcb80
+#define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
=20
 #define MAX_PORTS				28
 #define MAX_SMI_BUSSES				4
@@ -89,6 +89,8 @@ struct otto_emdio_cmd_regs {
 };
=20
 struct otto_emdio_info {
+	u32 addr_map_base;
+	u32 bus_map_base;
 	u32 cmd_fail;
 	u32 cmd_read;
 	u32 cmd_write;
@@ -327,24 +329,46 @@ static int otto_emdio_write_c45(struct mii_bus *bus,=
 int phy_id,
 	return ret;
 }
=20
-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+static int otto_emdio_write_mapping(struct otto_emdio_priv *priv, u32 bas=
e, u32 port,
+				    u32 ports_per_reg, u32 bits_per_val, u32 value)
 {
-	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
-	struct regmap *regmap =3D priv->regmap;
-	u32 port_addr[5] =3D { 0 };
-	u32 poll_sel[2] =3D { 0 };
-	int i, err;
+	u32 shift =3D (port % ports_per_reg) * bits_per_val;
+	u32 reg =3D base + (port / ports_per_reg) * 4;
+	u32 mask =3D GENMASK(bits_per_val - 1, 0);
=20
-	/* Associate the port with the SMI interface and PHY */
-	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports) {
-		int pos;
+	return regmap_update_bits(priv->regmap, reg, mask << shift, value << shi=
ft);
+}
=20
-		pos =3D (i % 6) * 5;
-		port_addr[i / 6] |=3D (priv->smi_addr[i] & 0x1f) << pos;
+static int otto_emdio_setup_topology(struct otto_emdio_priv *priv)
+{
+	const struct otto_emdio_info *info =3D priv->info;
+	u32 port;
+	int ret;
=20
-		pos =3D (i % 16) * 2;
-		poll_sel[i / 16] |=3D (priv->smi_bus[i] & 0x3) << pos;
+	for_each_set_bit(port, priv->valid_ports, info->num_ports) {
+		if (info->bus_map_base) {
+			/* 16 ports per register, 2 bits per port (bus index 0-3) */
+			ret =3D otto_emdio_write_mapping(priv, info->bus_map_base, port,
+						       16, 2, priv->smi_bus[port]);
+			if (ret)
+				return ret;
+		}
+		if (info->addr_map_base) {
+			/* 6 ports per register, 5 bits per port (PHY address 0-31) */
+			ret =3D otto_emdio_write_mapping(priv, info->addr_map_base, port,
+						       6, 5, priv->smi_addr[port]);
+			if (ret)
+				return ret;
+		}
 	}
+	return 0;
+}
+
+static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+{
+	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
+	struct regmap *regmap =3D priv->regmap;
+	int i, err;
=20
 	/* Put the interfaces into C45 mode if required */
 	glb_ctrl_mask =3D GENMASK(19, 16);
@@ -352,16 +376,6 @@ static int otto_emdio_9300_mdiobus_init(struct otto_e=
mdio_priv *priv)
 		if (priv->smi_bus_is_c45[i])
 			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
=20
-	err =3D regmap_bulk_write(regmap, SMI_PORT0_5_ADDR_CTRL,
-				port_addr, 5);
-	if (err)
-		return err;
-
-	err =3D regmap_bulk_write(regmap, SMI_PORT0_15_POLLING_SEL,
-				poll_sel, 2);
-	if (err)
-		return err;
-
 	err =3D regmap_update_bits(regmap, SMI_GLB_CTRL,
 				 glb_ctrl_mask, glb_ctrl_val);
 	if (err)
@@ -534,6 +548,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
 	if (err)
 		return err;
=20
+	err =3D otto_emdio_setup_topology(priv);
+	if (err)
+		return err;
+
 	device_for_each_child_node_scoped(dev, child) {
 		err =3D otto_emdio_probe_one(dev, priv, child);
 		if (err)
@@ -548,6 +566,8 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 }
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
+	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
+	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
 	.cmd_fail =3D PHY_CTRL_FAIL,
 	.cmd_read =3D PHY_CTRL_READ,
 	.cmd_write =3D PHY_CTRL_WRITE,
=2D-=20
2.54.0


