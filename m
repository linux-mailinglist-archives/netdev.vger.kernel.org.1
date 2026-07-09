Return-Path: <netdev+bounces-306163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0mygC5p2T2rLhAIAu9opvQ
	(envelope-from <netdev+bounces-306163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:23:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB472F8A3
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=vBYTtktZ;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306163-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306163-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 162FA309F410
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151340D580;
	Thu,  9 Jul 2026 10:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B97407575;
	Thu,  9 Jul 2026 10:09:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591746; cv=none; b=Z2eTOdEq9XnsGzK6wU8sFFowxFJMJ8vdZuIE7GFecWY3xMHmLLPtsUjuVa7bKT62oSEcMCyZ8S5hnhoUiuZ2Bz4gmgpqIKR8YulLpiSa7pCjt0xsn5uV2MOoYx57pZyXw/F7m+L6mzWE4xAY7dByTrBK9JBn5+MLn9G1xiQdUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591746; c=relaxed/simple;
	bh=1qOwJdfRJ67GqLNntrCz022QKbngoUGH3RT5KREa3kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1NQPZjvrMkQ+Zxov+B9RxpPpsBSzejMaH+gJkgOj2s2GGae8NUfZeu/9P9wMAhEBtTJX1FacjpLe7Voi5RcZs8F/Weehz9NQ3BBoi7WxgORFwa4154qzDD5wGEhgxOzFZETPyJ0eSY6wArIHTWJ73ypQ6BxAPyceD4dpZ0q1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vBYTtktZ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 669A2olyE2982781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783591370;
	bh=OGMN7UChNMQe9w9fnvPSdGambdE0J0Qc46HRuwGybsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vBYTtktZF7GXMNK4TcXmUQNWxZWkY+ZqdD4l4mNT6tiGH5UYvP0b0yS16kw5biUau
	 esW7zIbWNE9Q5ezW2aZRg3YQoQmp+OIRej4bmvje3zIMizYOmnYGUabyquA6nVEDs5
	 aKod5YgQn3vILnhfg2lloU4fZzl7KMAuvly9SwAPxpc6/BQTu7oTj+QmNRErkizdfO
	 OXfLDiDG2ri7uM4Bf6DGK5jXJnwDm0r4cp8uIOR7DceBN1NtZ1uKkq6A8cN1f3rrd9
	 1owstvnA3G5NWHBHHkn+MBv93R1Op8CaZ4deyuytJ8FOngQoIqf+3FHE/G5lfDWihj
	 5KzB/MghGbfag==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 669A2olyE2982781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 18:02:50 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 18:02:50 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Jul 2026 18:02:50 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v6 5/7] r8169: add support for RTL8127atf
Date: Thu, 9 Jul 2026 18:02:34 +0800
Message-ID: <20260709100237.541-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260709100237.541-1-javen_xu@realsil.com.cn>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306163-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp,realsil.com.cn];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25BB472F8A3

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8127atf is also a fiber mode card, but its sds reg base addr is
0x0080, which is different from RTL8116af. Add 10g and 1g support for
RTL8127atf in this patch.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v3:
 - No changes. New file.

Changes in v4:
 - remove DUMMY_PHY in driver/net/phy/realtek/realtek_main.c and related
   function

Changes in v5:
 - no changes, 1G support will be submitted by a following patch

Changes in v6:
 - no changes, merge patch 7/8 and 8/8 in v5
 - r8127_sds_read/write, return -ETIMEDOUT when time out
 - rtl8169_pcs_get_state set speed according to state->interface
 - register PHY_INTERFACE_MODE_10GBASER and PHY_INTERFACE_MODE_1000BASEX
   to supported_interfaces for RTL8127atf
---
 drivers/net/ethernet/realtek/r8169_main.c | 174 ++++++++++++++++------
 drivers/net/phy/realtek/realtek_main.c    |  54 -------
 include/net/phy/realtek_phy.h             |   7 -
 3 files changed, 127 insertions(+), 108 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 570801408f22..db2f3d9d6bf1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -32,7 +32,6 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
-#include <net/phy/realtek_phy.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -97,11 +96,18 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
+#define R8127_SDS_CMD		0x2348
+#define R8127_SDS_ADDR		0x234a
+#define R8127_SDS_DATA_IN	0x234c
+#define R8127_SDS_DATA_OUT	0x234e
+#define R8127_SDS_CMD_EXEC	BIT(0)
+#define R8127_SDS_CMD_WE	BIT(1)
 #define OCP_SDS_ADDR_REG	0xeb10
 #define OCP_SDS_CMD_REG		0xeb0e
 #define OCP_SDS_DATA_REG	0xeb14
 #define SDS_CMD_READ		0x0001
 #define RTL_SDS_C22_BASE	0x40
+#define RTL_SDS_C45_BASE	0x0080
 #define RTL_PKG_DETECT		0xdc00
 #define RTL_PKG_DETECT_MASK	0x0078
 #define RTL_PKG_DETECT_8116AF	0x0030
@@ -1151,10 +1157,6 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
-	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
-		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
-
 	RTL_W32(tp, GPHY_OCP, reg << 15);
 
 	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
@@ -1222,6 +1224,73 @@ static void r8127_sfp_sds_phy_reset(struct rtl8169_private *tp)
 	usleep_range(10, 20);
 }
 
+DECLARE_RTL_COND(r8127_sds_cmd_cond)
+{
+	return RTL_R16(tp, R8127_SDS_CMD) & R8127_SDS_CMD_EXEC;
+}
+
+static int r8127_sds_read(struct rtl8169_private *tp, u16 index, u16 page, u16 reg)
+{
+	u16 addr = (index << 11) | (page << 5) | reg;
+
+	RTL_W16(tp, R8127_SDS_ADDR, addr);
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC);
+
+	if (rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100))
+		return RTL_R16(tp, R8127_SDS_DATA_OUT);
+
+	return -ETIMEDOUT;
+}
+
+static int r8127_sds_write(struct rtl8169_private *tp, u16 index, u16 page,
+			   u16 reg, u16 val)
+{
+	u16 addr = (index << 11) | (page << 5) | reg;
+
+	RTL_W16(tp, R8127_SDS_DATA_IN, val);
+	RTL_W16(tp, R8127_SDS_ADDR, addr);
+	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_EXEC | R8127_SDS_CMD_WE);
+
+	if (rtl_loop_wait_low(tp, &r8127_sds_cmd_cond, 10, 100))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static void r8127_sds_modify(struct rtl8169_private *tp, u16 index, u16 page,
+			     u16 reg, u16 clearmask, u16 setmask)
+{
+	int val = r8127_sds_read(tp, index, page, reg);
+
+	if (val < 0)
+		return;
+
+	val = (val & ~clearmask) | setmask;
+	r8127_sds_write(tp, index, page, reg, val);
+}
+
+static void r8127_sfp_init_1g(struct rtl8169_private *tp)
+{
+	int val;
+
+	r8127_sfp_sds_phy_reset(tp);
+
+	r8127_sds_modify(tp, 0, 1, 31, 0, BIT(3));
+	r8127_sds_modify(tp, 0, 2,  0, BIT(13) | BIT(12) | BIT(6), BIT(12) | BIT(6));
+	r8127_sds_modify(tp, 0, 0,  4, 0, BIT(2));
+
+	RTL_W16(tp, 0x233a, 0x8004);
+	RTL_W16(tp, 0x233e, (RTL_R16(tp, 0x233e) & ~0x3003) | 0x0002);
+
+	r8168_phy_ocp_write(tp, 0xc40a, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc466, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc808, 0x0000);
+	r8168_phy_ocp_write(tp, 0xc80a, 0x0000);
+
+	val = r8168_phy_ocp_read(tp, 0xc804);
+	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
+}
+
 static void r8127_sfp_init_10g(struct rtl8169_private *tp)
 {
 	int val;
@@ -1240,12 +1309,6 @@ static void r8127_sfp_init_10g(struct rtl8169_private *tp)
 	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
 }
 
-static void rtl_sfp_init(struct rtl8169_private *tp)
-{
-	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
-		r8127_sfp_init_10g(tp);
-}
-
 static void rtl_sfp_reset(struct rtl8169_private *tp)
 {
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
@@ -2435,30 +2498,8 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 				      const struct ethtool_link_ksettings *cmd)
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
-	struct phy_device *phydev = tp->phydev;
-	int duplex = cmd->base.duplex;
-	int speed = cmd->base.speed;
-
-	if (tp->sfp_mode != RTL_SFP_8127_ATF)
-		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
-
-	if (cmd->base.autoneg != AUTONEG_DISABLE)
-		return -EINVAL;
-
-	if (!phy_check_valid(speed, duplex, phydev->supported))
-		return -EINVAL;
 
-	mutex_lock(&phydev->lock);
-
-	phydev->autoneg = AUTONEG_DISABLE;
-	phydev->speed = speed;
-	phydev->duplex = duplex;
-
-	rtl_sfp_init(tp);
-
-	mutex_unlock(&phydev->lock);
-
-	return 0;
+	return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 }
 
 static int rtl8169_nway_reset(struct net_device *dev)
@@ -2607,9 +2648,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode == RTL_SFP_8127_ATF)
-		rtl_sfp_init(tp);
-
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -4943,7 +4981,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if (status & LinkChg) {
 		if (tp->phydev)
 			phy_mac_interrupt(tp->phydev);
-		else if (tp->sfp_mode == RTL_SFP_8168_AF)
+		else if (tp->sfp_mode)
 			phylink_mac_change(tp->phylink,
 					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
 	}
@@ -5667,7 +5705,8 @@ static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 	if (!tp->pcs.ops)
 		return NULL;
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX)
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_10GBASER)
 		return &tp->pcs;
 
 	return NULL;
@@ -5697,12 +5736,32 @@ static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
 				  struct phylink_link_state *state)
 {
 	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
-	u16 bmsr, lpa;
 
-	bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
-	lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
+	if (tp->sfp_mode == RTL_SFP_8127_ATF) {
+		u16 stat1;
+
+		stat1 = rtl8169_sds_read(tp, RTL_SDS_C45_BASE + MDIO_STAT1);
+
+		if (!(stat1 & MDIO_STAT1_LSTATUS))
+			stat1 = rtl8169_sds_read(tp, RTL_SDS_C45_BASE + MDIO_STAT1);
 
-	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+		state->link = !!(stat1 & MDIO_STAT1_LSTATUS);
+		if (!state->link)
+			return;
+
+		if (state->interface == PHY_INTERFACE_MODE_1000BASEX)
+			state->speed = SPEED_1000;
+		else
+			state->speed = SPEED_10000;
+
+		state->duplex = DUPLEX_FULL;
+	} else {
+		u16 bmsr, lpa;
+
+		bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+		lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+	}
 }
 
 static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
@@ -5710,6 +5769,23 @@ static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
 			      const unsigned long *advertising,
 			      bool permit_pause_to_mac)
 {
+	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
+
+	if (tp->sfp_mode == RTL_SFP_8127_ATF) {
+		switch (interface) {
+		case PHY_INTERFACE_MODE_10GBASER:
+			r8127_sfp_init_10g(tp);
+			break;
+		case PHY_INTERFACE_MODE_1000BASEX:
+			r8127_sfp_init_1g(tp);
+			break;
+		default:
+			netdev_err(tp->dev, "Unsupported SFP interface mode: %s\n",
+				   phy_modes(interface));
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
@@ -5752,7 +5828,7 @@ static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
 {
 	unsigned long caps = 0;
 
-	if (!rtl_supports_eee(tp))
+	if (!rtl_supports_eee(tp) || tp->sfp_mode == RTL_SFP_8127_ATF)
 		return 0;
 
 	caps |= MAC_100FD | MAC_1000FD;
@@ -5796,8 +5872,12 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 		tp->phylink_config.mac_capabilities |= MAC_1000FD;
 		break;
 	case RTL_SFP_8127_ATF:
-		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
-		tp->phylink_config.mac_capabilities |= MAC_10000FD;
+		tp->pcs.ops = &r8169_pcs_ops;
+		phy_mode = PHY_INTERFACE_MODE_10GBASER;
+		tp->phylink_config.default_an_inband = true;
+		tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_10000FD;
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, tp->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX, tp->phylink_config.supported_interfaces);
 		break;
 	default:
 		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
@@ -6025,7 +6105,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (tp->sfp_mode != RTL_SFP_8168_AF) {
+	if (tp->sfp_mode == RTL_SFP_NONE) {
 		rc = r8169_mdio_register(tp);
 		if (rc) {
 			phylink_destroy(tp->phylink);
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index b65d0f5fa1a0..4721ba071cbb 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/string_choices.h>
-#include <net/phy/realtek_phy.h>
 
 #include "../phylib.h"
 #include "realtek.h"
@@ -2646,45 +2645,6 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int rtlgen_sfp_get_features(struct phy_device *phydev)
-{
-	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			 phydev->supported);
-
-	/* set default mode */
-	phydev->speed = SPEED_10000;
-	phydev->duplex = DUPLEX_FULL;
-
-	phydev->port = PORT_FIBRE;
-
-	return 0;
-}
-
-static int rtlgen_sfp_read_status(struct phy_device *phydev)
-{
-	int val, err;
-
-	err = genphy_update_link(phydev);
-	if (err)
-		return err;
-
-	if (!phydev->link)
-		return 0;
-
-	val = phy_read(phydev, RTL_PHYSR);
-	if (val < 0)
-		return val;
-
-	rtlgen_decode_physr(phydev, val);
-
-	return 0;
-}
-
-static int rtlgen_sfp_config_aneg(struct phy_device *phydev)
-{
-	return 0;
-}
-
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -2934,20 +2894,6 @@ static struct phy_driver realtek_drvs[] = {
 		.write_page	= rtl821x_write_page,
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
-	}, {
-		PHY_ID_MATCH_EXACT(PHY_ID_RTL_DUMMY_SFP),
-		.name		= "Realtek SFP PHY Mode",
-		.flags		= PHY_IS_INTERNAL,
-		.probe		= rtl822x_probe,
-		.get_features	= rtlgen_sfp_get_features,
-		.config_aneg	= rtlgen_sfp_config_aneg,
-		.read_status	= rtlgen_sfp_read_status,
-		.suspend	= genphy_suspend,
-		.resume		= rtlgen_resume,
-		.read_page	= rtl821x_read_page,
-		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001ccad0),
 		.name		= "RTL8224 2.5Gbps PHY",
diff --git a/include/net/phy/realtek_phy.h b/include/net/phy/realtek_phy.h
deleted file mode 100644
index d683bc1b0659..000000000000
--- a/include/net/phy/realtek_phy.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _REALTEK_PHY_H
-#define _REALTEK_PHY_H
-
-#define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
-
-#endif /* _REALTEK_PHY_H */
-- 
2.43.0


