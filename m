Return-Path: <netdev+bounces-304724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PrUsEqJhSWrc0wAAu9opvQ
	(envelope-from <netdev+bounces-304724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 145AB708464
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JOLhkBrt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304724-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304724-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C539300AC82
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8E2F693B;
	Sat,  4 Jul 2026 19:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C4433E93;
	Sat,  4 Jul 2026 19:39:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194001; cv=none; b=E7kxruOCGRZ0jt7dPZvPKRb7Lc10T7eCF0wvI+7YRz0iNv3xUUqz0umqJ3i/vZF8RDdS/O66J0QQOa485MoZNv0YZgYhGUlUFcpx2+OFZI0A8yTzAskVBu02o7c9qRwxS3jlcN2WRSTgPSpHJRvQDVtMyPoZtuJtIL077+I6ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194001; c=relaxed/simple;
	bh=/rQn7JesHbXH6m+65vTKbIW+3Crnb+Id2WSJHGN4GaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXVJI/oxlh/jyj5Lmr88W/kuC55o27goNFoNdT0G4ERRG2LQ67o6Aj9oLVbnFZiOytrVTTrf0O8FFXlaFmJCd6AMKZADxP91eEORwd5TW0DCutLxp+wjV1+PD0RweyYxo+S9yKMLVlA9odtm0zYtRo6BcklHK4RSOr8t9Sz7ioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOLhkBrt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1601F00A3A;
	Sat,  4 Jul 2026 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193999;
	bh=+eVbTcTTEAcqVJda9V7P4Hot538+iYiOeJ+11wuJhCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JOLhkBrtIlhETe/VqPGIaPxIjqhiVSkJUrK3gTW51GS8tf/EoINMEb2pjxIc5lgrq
	 zoMsmzoyd+ToPfw7y+wB+jZCVMdnEVeh75Hqm9eoo/iQXPDltiPwQqWdX0oqrYKwrf
	 UeR5BmlI+hxDps9Dem6hA6avA10IAYozmu2TnDErGtgqw+TQj8MfYaJ1da4EU/1UnD
	 oJ7CytUxlM+1b8hHwIyftZiNtCOqfbfoc7WDbVZQrngg9ls1UqmQXDTBImnVuz2bOu
	 HSh0zT7HHKqhzUVbL0qRmNtG1oCaeyEQKvKWftQqFj4wV5/bJ9RrXbQuneg2ApLHbD
	 J0XRulTnITOEw==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 04 Jul 2026 21:39:36 +0200
Subject: [PATCH net-next v7 4/5] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-ks8995-to-ksz8-v7-4-2af0eaa545a8@kernel.org>
References: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
In-Reply-To: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:linusw@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304724-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 145AB708464

This adds support for the Microchip KSZ8995XA also known as the
Micrel KS8995XA switch to the KSZ driver.

Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
different from the KSZ8995XA.

The helper macros are named ksz_is_ksz8995xa() to make it
possible to add E and MA support in the future.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/Kconfig           |   1 +
 drivers/net/dsa/microchip/ksz8.c            | 187 +++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8.h            |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h        |   7 ++
 drivers/net/dsa/microchip/ksz_common.c      |  54 ++++++--
 drivers/net/dsa/microchip/ksz_common.h      |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c         |  18 ++-
 include/linux/platform_data/microchip-ksz.h |   1 +
 8 files changed, 239 insertions(+), 42 deletions(-)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index c71d3fd5dfeb..75c9b2114afd 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -2,6 +2,7 @@
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	tristate "Microchip KSZ8XXX/KSZ9XXX/LAN937X series switch support"
 	depends on NET_DSA
+	select NET_DSA_TAG_KS8995
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 586916570a84..03a5981a6315 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3,6 +3,7 @@
  * Microchip KSZ8XXX series switch driver
  *
  * It supports the following switches:
+ * - KSZ8995XA (the oldest ancestor)
  * - KSZ8463
  * - KSZ8863, KSZ8873 aka KSZ88X3
  * - KSZ8895, KSZ8864 aka KSZ8895 family
@@ -137,7 +138,17 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
 
 static int ksz8_reset_switch(struct ksz_device *dev)
 {
-	if (ksz_is_ksz88x3(dev)) {
+	if (ksz_is_ksz8995xa(dev)) {
+		unsigned int port;
+
+		/* The KSZ8995XA switch itself cannot be reset by software, but
+		 * often boot loaders have fun with ports, so reset them. This
+		 * reset bit is self-clearing.
+		 */
+		for (port = 0; port < dev->info->port_cnt; port++)
+			ksz_port_cfg(dev, port, REG_PORT_STATUS_3,
+				     PORT_PHY_SOFT_RESET, true);
+	} else if (ksz_is_ksz88x3(dev)) {
 		/* reset switch */
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
@@ -161,8 +172,14 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 static int ksz8863_change_mtu(struct ksz_device *dev, int frame_size)
 {
 	u8 ctrl2 = 0;
+	unsigned int legalsz;
+
+	if (ksz_is_ksz8995xa(dev))
+		legalsz = KSZ8995XA_LEGAL_PACKET_SIZE;
+	else
+		legalsz = KSZ8_LEGAL_PACKET_SIZE;
 
-	if (frame_size <= KSZ8_LEGAL_PACKET_SIZE)
+	if (frame_size <= legalsz)
 		ctrl2 |= KSZ8863_LEGAL_PACKET_ENABLE;
 	else if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
 		ctrl2 |= KSZ8863_HUGE_PACKET_ENABLE;
@@ -207,6 +224,7 @@ static int ksz8_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
+	case KSZ8995XA_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
 	}
 
@@ -242,6 +260,10 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 		mask_2q = KSZ8873_PORT_2QUEUE_SPLIT_EN;
 		reg_4q = P1CR1;
 		reg_2q = P1CR1 + 1;
+	} else if (ksz_is_ksz8995xa(dev)) {
+		/* This switch has no 4way split support */
+		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
+		reg_2q = REG_PORT_CTRL_0;
 	} else {
 		mask_4q = KSZ8795_PORT_4QUEUE_SPLIT_EN;
 		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
@@ -860,6 +882,10 @@ static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
 	if (reg_val & PORT_MDIX_STATUS)
 		*val |= KSZ886X_CTRL_MDIX_STAT;
 
+	/* KSZ8995XA has no fancy features in register 0xA */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	ret = ksz_pread8(dev, port, REG_PORT_LINK_MD_CTRL, &reg_val);
 	if (ret < 0)
 		return ret;
@@ -958,8 +984,10 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
 	if (ctrl & PORT_FORCE_FULL_DUPLEX)
 		*val |= BMCR_FULLDPLX;
 
-	if (speed & PORT_HP_MDIX)
-		*val |= KSZ886X_BMCR_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		if (speed & PORT_HP_MDIX)
+			*val |= KSZ886X_BMCR_HP_MDIX;
+	}
 
 	if (restart & PORT_FORCE_MDIX)
 		*val |= KSZ886X_BMCR_FORCE_MDI;
@@ -1054,6 +1082,9 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 			data |= LPA_LPACK;
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz_pread8(dev, p, REG_PORT_LINK_MD_CTRL, &val1);
 		if (ret)
 			return ret;
@@ -1197,13 +1228,15 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 	if (val & BMCR_RESET)
 		return 0;
 
-	speed = 0;
-	if (val & KSZ886X_BMCR_HP_MDIX)
-		speed |= PORT_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		speed = 0;
+		if (val & KSZ886X_BMCR_HP_MDIX)
+			speed |= PORT_HP_MDIX;
 
-	ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
-	if (ret)
-		return ret;
+		ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
+		if (ret)
+			return ret;
+	}
 
 	ctrl = 0;
 	if (ksz_is_ksz88x3(dev)) {
@@ -1313,11 +1346,17 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		}
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		if (val & PHY_START_CABLE_DIAG)
 			ksz_port_cfg(dev, p, REG_PORT_LINK_MD_CTRL, PORT_START_CABLE_DIAG, true);
 		break;
 
 	case PHY_REG_PHY_CTRL:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz8_w_phy_ctrl(dev, p, val);
 		if (ret)
 			return ret;
@@ -1562,7 +1601,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8995xa(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1780,12 +1819,14 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
 
-	/* replace priority */
-	offset = P_802_1P_CTRL;
-	if (ksz_is_ksz8463(dev))
-		offset = P1CR2;
-	ksz_port_cfg(dev, port, offset,
-		     masks[PORT_802_1P_REMAPPING], false);
+	if (!ksz_is_ksz8995xa(dev)) {
+		/* replace priority */
+		offset = P_802_1P_CTRL;
+		if (ksz_is_ksz8463(dev))
+			offset = P1CR2;
+		ksz_port_cfg(dev, port, offset,
+			     masks[PORT_802_1P_REMAPPING], false);
+	}
 
 	if (cpu_port)
 		member = dsa_user_ports(ds);
@@ -1794,6 +1835,19 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_cfg_port_member(dev, port, member);
 
+	if (ksz_is_ksz8995xa(dev)) {
+		/*
+		 * The KSZ8995XA has a special tag format in the front of the frame
+		 * that need to be inserted by the CPU and then removed by each
+		 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
+		 * CPU port" it does not affect ingress packets.
+		 */
+		if (cpu_port)
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
+		else
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);
+	}
+
 	/* Disable all WoL options by default. Otherwise
 	 * ksz_switch_macaddr_get/put logic will not work properly.
 	 * CPU port 4 has no WoL functionality.
@@ -1810,7 +1864,12 @@ static int ksz8_dsa_port_setup(struct dsa_switch *ds, int port)
 		return 0;
 
 	ksz8_port_setup(dev, port, false);
-	return ksz_dcb_init_port(dev, port);
+
+	/* TODO: Revisit this and attempt to enable DCB on the KS8995XA. */
+	if (!ksz_is_ksz8995xa(dev))
+		return ksz_dcb_init_port(dev, port);
+
+	return 0;
 }
 
 static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
@@ -1841,7 +1900,9 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 	masks = dev->info->masks;
 	regs = dev->info->regs;
 
-	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+	/* KSZ8995XA uses a tag in the header instead of the tail */
+	if (!ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
 
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
@@ -2043,6 +2104,10 @@ static int ksz8_enable_stp_addr(struct ksz_device *dev)
 {
 	struct alu_struct alu;
 
+	/* KSZ8995XA lacks STP */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	/* Setup STP address for STP operation. */
 	memset(&alu, 0, sizeof(alu));
 	ether_addr_copy(alu.mac, eth_stp_addr);
@@ -2061,13 +2126,17 @@ static int ksz8_setup(struct dsa_switch *ds)
 	struct ksz_port *p;
 	const u16 *regs;
 	int i, ret;
+	u8 val;
 
 	regs = dev->info->regs;
 
-	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
-				       dev->info->num_vlans, GFP_KERNEL);
-	if (!dev->vlan_cache)
-		return -ENOMEM;
+	/* KSZ8995XA has no SW controlled VLAN handling */
+	if (!ksz_is_ksz8995xa(dev)) {
+		dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+					       dev->info->num_vlans, GFP_KERNEL);
+		if (!dev->vlan_cache)
+			return -ENOMEM;
+	}
 
 	ret = ksz8_reset_switch(dev);
 	if (ret) {
@@ -2126,9 +2195,10 @@ static int ksz8_setup(struct dsa_switch *ds)
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	val = NO_EXC_COLLISION_DROP;
+	if (!ksz_is_ksz8995xa(dev))
+		val |= UNICAST_VLAN_BOUNDARY;
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2, val, val);
 	if (ret)
 		return ret;
 
@@ -2136,11 +2206,15 @@ static int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
+	if (ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);
+	else if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
-	for (i = 0; i < (dev->info->num_vlans / 4); i++)
-		ksz8_r_vlan_entries(dev, i);
+	if (!ksz_is_ksz8995xa(dev)) {
+		for (i = 0; i < (dev->info->num_vlans / 4); i++)
+			ksz8_r_vlan_entries(dev, i);
+	}
 
 	/* Make sure PME (WoL) is not enabled. If requested, it will
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
@@ -2204,9 +2278,15 @@ static int ksz8_setup(struct dsa_switch *ds)
 		goto out_ptp_clock_unregister;
 	}
 
-	ret = ksz_dcb_init(dev);
-	if (ret)
-		goto out_ptp_clock_unregister;
+	/* TODO: the KSZ8995XA does have TOS priority control registers albeit
+	 * 7 instead of 15 and in a different location. Revisit this and attempt
+	 * to enable DCB on the KS8995XA.
+	 */
+	if (!ksz_is_ksz8995xa(dev)) {
+		ret = ksz_dcb_init(dev);
+		if (ret)
+			goto out_ptp_clock_unregister;
+	}
 
 	/* start switch */
 	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
@@ -2388,6 +2468,13 @@ static int ksz8_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
+static enum dsa_tag_protocol ksz8995xa_get_tag_protocol(struct dsa_switch *ds,
+							int port,
+							enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_KS8995;
+}
+
 static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -2484,6 +2571,16 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
+/*
+ * The KS(Z)8995XA has no indirect access, meaning no MIB counters,
+ * no FDB access, and no VLAN handling.
+ */
+const struct ksz_dev_ops ksz8995xa_dev_ops = {
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.init = ksz8_switch_init,
+};
+
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
@@ -2523,6 +2620,32 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
+/*
+ * Restricted operations for KSZ8995XA, so many things are not supported
+ * by this old switch that we need diet DSA operations.
+ */
+const struct dsa_switch_ops ksz8995xa_switch_ops = {
+	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
+	.setup			= ksz8_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz8_phy_read16,
+	.phy_write		= ksz8_phy_write16,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
+	.port_setup		= ksz8_dsa_port_setup,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
+	.port_change_mtu	= ksz8_change_mtu,
+	.port_max_mtu		= ksz_max_mtu,
+	/* TODO: add .port_get/set_apptrust() when we implement priority */
+};
+
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index bc371cc26c6f..9b37c56c9617 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -12,11 +12,13 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
+extern const struct ksz_dev_ops ksz8995xa_dev_ops;
 extern const struct ksz_dev_ops ksz8463_dev_ops;
 extern const struct ksz_dev_ops ksz87xx_dev_ops;
 extern const struct ksz_dev_ops ksz88xx_dev_ops;
 extern const struct phylink_mac_ops ksz88x3_phylink_mac_ops;
 extern const struct phylink_mac_ops ksz8_phylink_mac_ops;
+extern const struct dsa_switch_ops ksz8995xa_switch_ops;
 extern const struct dsa_switch_ops ksz8463_switch_ops;
 extern const struct dsa_switch_ops ksz87xx_switch_ops;
 extern const struct dsa_switch_ops ksz88xx_switch_ops;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 981ab441d9b7..c25897ccdc39 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -30,6 +30,11 @@
 #define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
 #define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
 
+#define REG_SW_ID_0			0x00
+#define REG_SW_ID_1			0x01
+
+#define SW_START_SWITCH			BIT(0)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
@@ -95,6 +100,8 @@
 #define SW_LED_LINK_ACT_DUPLEX		2
 #define SW_LED_LINK_DUPLEX		3
 
+#define SW_SPECIAL_TAG			BIT(0) /* KSZ8995XA only */
+
 #define REG_SW_CTRL_10			0x0C
 
 #define SW_PASS_PAUSE			BIT(0)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d1726778bb48..e9f85449517f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -553,6 +553,20 @@ static const u8 ksz8895_shifts[] = {
 	[DYNAMIC_MAC_SRC_PORT]		= 24,
 };
 
+static const u16 ksz8995xa_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
+	[P_FORCE_CTRL]			= 0x0C,
+	[P_LINK_STATUS]			= 0x0E,
+	[P_LOCAL_CTRL]			= 0x0C,
+	[P_NEG_RESTART_CTRL]		= 0x0D,
+	[P_REMOTE_STATUS]		= 0x0E,
+	[P_SPEED_STATUS]		= 0x09,
+	[P_STP_CTRL]			= 0x02,
+	[S_START_CTRL]			= 0x01,
+	[S_BROADCAST_CTRL]		= 0x06,
+	[S_MULTICAST_CTRL]		= 0x04,
+};
+
 static const u16 ksz9477_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x0302,
 	[P_STP_CTRL]			= 0x0B04,
@@ -1484,6 +1498,21 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 	},
 
+	[KSZ8995XA] = {
+		.chip_id = KSZ8995XA_CHIP_ID, /* Also known as KS8995XA */
+		.dev_name = "KSZ8995XA",
+		.cpu_ports = 0x10,	/* can be configured as cpu port */
+		.port_cnt = 5,		/* total cpu and user ports */
+		.num_tx_queues = 2,	/* low/hi priority queues, no more */
+		.num_ipms = 4,
+		.ops = &ksz8995xa_dev_ops,
+		.switch_ops = &ksz8995xa_switch_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
+		.regs = ksz8995xa_regs,
+		.supports_mii = {true, true, true, true, true},
+		.internal_phy = {true, true, true, true, false},
+	},
+
 	[KSZ9477] = {
 		.chip_id = KSZ9477_CHIP_ID,
 		.dev_name = "KSZ9477",
@@ -2811,6 +2840,10 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 {
 	int i;
 
+	/* KSZ8995XA lacks MiB features */
+	if (ksz_is_ksz8995xa(dev))
+		return;
+
 	INIT_DELAYED_WORK(&dev->mib_read, ksz_mib_read_work);
 
 	for (i = 0; i < dev->info->port_cnt; i++) {
@@ -2997,6 +3030,7 @@ int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
+	case KSZ8995XA_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
 	case KSZ8567_CHIP_ID:
@@ -3213,11 +3247,15 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			return -ENODEV;
 		break;
 	case KSZ8895_FAMILY_ID:
-		if (id2 == KSZ8895_CHIP_ID_95 ||
-		    id2 == KSZ8895_CHIP_ID_95R)
+		if (id2 == KSZ8895_CHIP_ID_95XA) {
+			dev->chip_id = KSZ8995XA_CHIP_ID;
+			break;
+		} else if (id2 == KSZ8895_CHIP_ID_95 ||
+			   id2 == KSZ8895_CHIP_ID_95R) {
 			dev->chip_id = KSZ8895_CHIP_ID;
-		else
+		} else {
 			return -ENODEV;
+		}
 		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
 		if (ret)
 			return ret;
@@ -4530,11 +4568,13 @@ int ksz_switch_register(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
-	/* Read MIB counters every 30 seconds to avoid overflow. */
-	dev->mib_read_interval = msecs_to_jiffies(5000);
+	if (!ksz_is_ksz8995xa(dev)) {
+		/* Read MIB counters every 30 seconds to avoid overflow. */
+		dev->mib_read_interval = msecs_to_jiffies(5000);
 
-	/* Start the MIB timer. */
-	schedule_delayed_work(&dev->mib_read, 0);
+		/* Start the MIB timer. */
+		schedule_delayed_work(&dev->mib_read, 0);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index b4a5673ba365..61fd5d059026 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -239,6 +239,7 @@ enum ksz_model {
 	KSZ88X3,
 	KSZ8864,
 	KSZ8895,
+	KSZ8995XA,
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
@@ -714,7 +715,13 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 static inline bool ksz_is_8895_family(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8895_CHIP_ID ||
-	       dev->chip_id == KSZ8864_CHIP_ID;
+	       dev->chip_id == KSZ8864_CHIP_ID ||
+	       dev->chip_id == KSZ8995XA_CHIP_ID;
+}
+
+static inline bool ksz_is_ksz8995xa(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8995XA_CHIP_ID;
 }
 
 static inline bool is_ksz8(struct ksz_device *dev)
@@ -785,6 +792,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87_CHIP_ID_94		0x6
 #define KSZ87_CHIP_ID_95		0x9
 #define KSZ88_CHIP_ID_63		0x3
+#define KSZ8895_CHIP_ID_95XA		0x0
 #define KSZ8895_CHIP_ID_95		0x4
 #define KSZ8895_CHIP_ID_95R		0x6
 
@@ -848,6 +856,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ8863_HUGE_PACKET_SIZE	1916
 #define KSZ8863_NORMAL_PACKET_SIZE	1536
 #define KSZ8_LEGAL_PACKET_SIZE		1518
+#define KSZ8995XA_LEGAL_PACKET_SIZE	1522
 #define KSZ9477_MAX_FRAME_SIZE		9000
 
 #define KSZ8873_REG_GLOBAL_CTRL_12	0x0e
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 77aecac32466..2c55014246e5 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -161,7 +161,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
 		regmap_config = ksz8795_regmap_config;
-	else if (chip->chip_id == KSZ8895_CHIP_ID ||
+	else if (chip->chip_id == KSZ8995XA_CHIP_ID ||
+		 chip->chip_id == KSZ8895_CHIP_ID ||
 		 chip->chip_id == KSZ8864_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else
@@ -185,7 +186,10 @@ static int ksz_spi_probe(struct spi_device *spi)
 		dev->pdata = spi->dev.platform_data;
 
 	/* setup spi */
-	spi->mode = SPI_MODE_3;
+	if (chip->chip_id == KSZ8995XA_CHIP_ID)
+		spi->mode = SPI_MODE_0;
+	else
+		spi->mode = SPI_MODE_3;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;
@@ -239,6 +243,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "micrel,ksz8795",
 		.data = &ksz_switch_chips[KSZ8795]
 	},
+	{
+		.compatible = "micrel,ks8995",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz8463",
 		.data = &ksz_switch_chips[KSZ8463]
@@ -271,6 +279,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,ksz8895",
 		.data = &ksz_switch_chips[KSZ8895]
 	},
+	{
+		.compatible = "microchip,ksz8995xa",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz9477",
 		.data = &ksz_switch_chips[KSZ9477]
@@ -332,6 +344,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);
 
 static const struct spi_device_id ksz_spi_ids[] = {
+	{ "ks8995" },
 	{ "ksz8463" },
 	{ "ksz8765" },
 	{ "ksz8794" },
@@ -340,6 +353,7 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "ksz8864" },
 	{ "ksz8873" },
 	{ "ksz8895" },
+	{ "ksz8995" },
 	{ "ksz9477" },
 	{ "ksz9896" },
 	{ "ksz9897" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 028781ad4059..d8eddd21c3c7 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -31,6 +31,7 @@ enum ksz_chip_id {
 	KSZ88X3_CHIP_ID = 0x8830,
 	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8895_CHIP_ID = 0x8895,
+	KSZ8995XA_CHIP_ID = 0x8995,
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
 	KSZ9897_CHIP_ID = 0x00989700,

-- 
2.54.0


