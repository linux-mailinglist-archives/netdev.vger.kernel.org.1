Return-Path: <netdev+bounces-294870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NEgFH/BsIGoi3QAAu9opvQ
	(envelope-from <netdev+bounces-294870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:05:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E140E63A636
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=ZnCuyvBZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294870-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294870-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB50030E3E3C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762E379987;
	Wed,  3 Jun 2026 18:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB983803F2
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509636; cv=none; b=sRME6Ek6S35IkcOj02u3W6aKskb4XQ6QMxsZtv+fzJvveVr3lGrEVRdfNpoMGe6IZ5hXR0Q+kCdFeaT/CNhkVOcNRywl1DfBrNmoTLDgPd1vEhCVw0PkvOsF6V2jcdxZNOHRCXkGBLTz4/XZpAONzH74Vy9B6jG2fnkc0iXj+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509636; c=relaxed/simple;
	bh=gHQL/zoorqlbjAoFyVy4YAYeEe2+P32gMgr9BcI1eac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HY/gcRNsoIJd6r0wrfauvxwSDuyOE3zI7pbrvt467VelHwamNJacgyhHYsMuMbrlJwoK9Tme8/RBb6IMN2x/bce9DsP5UTgXmgtT+qQpSEImvbWXstcE3U9DshoejMLFzun02yZtW2ZZWl4qhIPwmHqjgSbVrRZsqz5cCR7qo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ZnCuyvBZ; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509608; x=1781114408;
	i=markus.stockhausen@gmx.de;
	bh=YkGy4a7mRSBBVV1Qx6rCN75EUWBaPGAkyCYJRUKq8m0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZnCuyvBZuCMTRsAZLXaS57l1scsp0IZBJ8QtQm1NX+od5z31Q4ziMcLppS+LcoKx
	 d/fJtiWbBaSw1v5u1qn9WzuVROsHINjNK0YOA6cED2TXZBNBJULpphwGW0o+K4G3c
	 Ehz/8bpERTiP8/7INHSF8JNGB9OeIHn7aqyoLbELm7OpMKDDHhYdTPWqvSWzgtv8G
	 Y/MAdoQCHfHXm7GlVohMO4sP2JkabC56IO4TbuhgSB/7Uopyo0+LkD8Hq60a7PpIR
	 KfihAm2b1ev3Yu+bLEkfRjxYN3LIg5QAXom4onQagLVRI4X5HzlmVVbFibAhuDfew
	 nWtww6P4y6cs9pt4rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1xNcvn2hD5-017VDZ; Wed, 03
 Jun 2026 20:00:08 +0200
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
Subject: [PATCH net-next v2 4/7] net: mdio: realtek-rtl9300: relocate topology setup
Date: Wed,  3 Jun 2026 19:59:21 +0200
Message-ID: <20260603175924.123019-5-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:Y/h6+MvgB1dWzrsQaOE4UVmn38iy+IetqR1yjcQpIx5NK9xBUHH
 QORAn9Y0DyqEVFTbNVuz5PxFXp15aX0rUStsBfovlh2eBDHI+i48yUMvzVwEUXCUezdfi2B
 PyfAUVi7jY8B0PUJYvS/GSzzQpMlN2jPHfsdciRap6jUUMNf9Q05mPJgnSxdm5Oq7pZ9bcj
 /W+PIbJAXDZsQ7kFKSwQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SYYLiC71dWA=;d3aUUORRyQ+vuVB2JMXjKWUgD6L
 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
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
	TAGGED_FROM(0.00)[bounces-294870-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E140E63A636

Until now the driver sets up the port to bus/address topology of the
controller after all buses are set up via otto_emdio_probe_one(). This
does not work for devices where U-Boot skips this setup. It is not
only needed for the hardware internal background PHY polling engine
but it is essential for access to the PHYs during probing.

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
- Due to the added prefixes, increase define indentation

Subtle change: The old coding used regmap_bulk_write and silently wrote
bus=3D0/address=3D0 to mapping registers for ports that are out of scope.
The new coding leaves those untouched.

[1] https://svanheule.net/realtek/longan/register/smi_port0_15_polling_sel
[2] https://svanheule.net/realtek/longan/register/smi_port0_5_addr_ctrl

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 127 ++++++++++++++----------
 1 file changed, 76 insertions(+), 51 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index aa45b0e92216..58854c54ad99 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -51,34 +51,38 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
-#define RTL9300_NUM_BUSES		4
-#define RTL9300_NUM_PAGES		4096
-#define RTL9300_NUM_PORTS		28
-#define SMI_GLB_CTRL			0xca00
-#define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
-#define SMI_PORT0_15_POLLING_SEL	0xca08
-#define RTL9300_SMI_ACCESS_PHY_CTRL_0	0xcb70
-#define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
-#define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
-#define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
-#define   PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
-#define   PHY_CTRL_WRITE		BIT(2)
-#define   PHY_CTRL_READ			0
-#define   PHY_CTRL_TYPE_C45		BIT(1)
-#define   PHY_CTRL_TYPE_C22		0
-#define   PHY_CTRL_CMD			BIT(0)
-#define   PHY_CTRL_FAIL			BIT(25)
-#define RTL9300_SMI_ACCESS_PHY_CTRL_2	0xcb78
-#define   PHY_CTRL_INDATA		GENMASK(31, 16)
-#define   PHY_CTRL_DATA			GENMASK(15, 0)
-#define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
-#define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
-#define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
-#define SMI_PORT0_5_ADDR_CTRL		0xcb80
-
-#define MAX_PORTS       28
-#define MAX_SMI_BUSSES  4
-#define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
+#define RTL9300_NUM_BUSES			4
+#define RTL9300_NUM_PAGES			4096
+#define RTL9300_NUM_PORTS			28
+#define SMI_GLB_CTRL				0xca00
+#define   GLB_CTRL_INTF_SEL(intf)		BIT(16 + (intf))
+#define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
+#define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
+#define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
+#define   PHY_CTRL_REG_ADDR			GENMASK(24, 20)
+#define   PHY_CTRL_PARK_PAGE			GENMASK(19, 15)
+#define   PHY_CTRL_MAIN_PAGE			GENMASK(14, 3)
+#define   PHY_CTRL_WRITE			BIT(2)
+#define   PHY_CTRL_READ				0
+#define   PHY_CTRL_TYPE_C45			BIT(1)
+#define   PHY_CTRL_TYPE_C22			0
+#define   PHY_CTRL_CMD				BIT(0)
+#define   PHY_CTRL_FAIL				BIT(25)
+#define RTL9300_SMI_ACCESS_PHY_CTRL_2		0xcb78
+#define   PHY_CTRL_INDATA			GENMASK(31, 16)
+#define   PHY_CTRL_DATA				GENMASK(15, 0)
+#define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define   PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
+#define   PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
+
+#define MAP_ADDRS_PER_REG			6
+#define MAP_BITS_PER_ADDR			5
+#define MAP_BITS_PER_BUS			2
+#define MAP_BUSES_PER_REG			16
+#define MAX_PORTS				28
+#define MAX_SMI_BUSSES				4
+#define RAW_PAGE(priv)				((priv)->info->num_pages - 1)
=20
=20
 struct otto_emdio_cmd_regs {
@@ -89,6 +93,8 @@ struct otto_emdio_cmd_regs {
 };
=20
 struct otto_emdio_info {
+	u32 addr_map_base;
+	u32 bus_map_base;
 	u32 cmd_fail;
 	u32 cmd_read;
 	u32 cmd_write;
@@ -327,41 +333,54 @@ static int otto_emdio_write_c45(struct mii_bus *bus,=
 int phy_id,
 	return ret;
 }
=20
-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+static int otto_emdio_write_mapping(struct otto_emdio_priv *priv, u32 bas=
e, u32 port,
+				    u32 vals_per_reg, u32 bits_per_val, u32 value)
 {
-	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
-	struct regmap *regmap =3D priv->regmap;
-	u32 port_addr[5] =3D { 0 };
-	u32 poll_sel[2] =3D { 0 };
-	int i, err;
+	u32 shift =3D (port % vals_per_reg) * bits_per_val;
+	u32 reg =3D base + (port / vals_per_reg) * 4;
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
+			ret =3D otto_emdio_write_mapping(priv, info->bus_map_base, port,
+						       MAP_BUSES_PER_REG, MAP_BITS_PER_BUS,
+						       priv->smi_bus[port]);
+			if (ret)
+				return ret;
+		}
+		if (info->addr_map_base) {
+			ret =3D otto_emdio_write_mapping(priv, info->addr_map_base, port,
+						       MAP_ADDRS_PER_REG, MAP_BITS_PER_ADDR,
+						       priv->smi_addr[port]);
+			if (ret)
+				return ret;
+		}
 	}
=20
+	return 0;
+}
+
+static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
+{
+	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
+	struct regmap *regmap =3D priv->regmap;
+	int i, err;
+
 	/* Put the interfaces into C45 mode if required */
 	glb_ctrl_mask =3D GENMASK(19, 16);
 	for (i =3D 0; i < priv->info->num_buses; i++)
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
@@ -528,6 +547,10 @@ static int otto_emdio_probe(struct platform_device *p=
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
@@ -542,6 +565,8 @@ static int otto_emdio_probe(struct platform_device *pd=
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


