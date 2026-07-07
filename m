Return-Path: <netdev+bounces-305381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DybyNNHGTGpdpgEAu9opvQ
	(envelope-from <netdev+bounces-305381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:28:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60B719C54
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=u1XD5gRM;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305381-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305381-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B06EA30D366E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861CC3B71C9;
	Tue,  7 Jul 2026 09:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555F390601;
	Tue,  7 Jul 2026 09:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416166; cv=none; b=UcPth2ALBZ5AAoGmZFKJDGwkR5MstWlYKOhDhEvNcNggmYTSiA7kLOVyjdqVqrdidEeu3k41LbaXJ2WYl5VpY/LCJpTohuNemRS1G5SWhM6N/UL+cJmnVrjz0ierfDnQK4NGdYSjV1lXQelniJYDg2Vf3zYFPkWPhv71z89EG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416166; c=relaxed/simple;
	bh=aHpQRczmUVz3EKJ0AL7hnadsMTdp5f+XxFTzLR/cmUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4TMicqJV/RjGOe7AXL/xd1+BB/8kmZWqtoS0m4Fmo/sSpF9+l67EQ6zRG7BLSlpCeMz2lUkoGZqJGL+4EI7bR04ytXFKuHG8ulnWSXox8/CqEY1MzG8brWKTYTiE9fPff3n6T30KJU709S4WyTcujIw5+iEYWgyzro0gv5tb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=u1XD5gRM; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GfouE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415801;
	bh=c5vRF06W4wxJ5XvTd84wvrFXo+a4HY0VsqWo9vtluvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=u1XD5gRMdwkGJ6yVMfUq87rCuRNQI+D+/tWek6+ka6cR+wbyiYIEu5M5l5rY9HjOD
	 Z6DuFOSvLK0GDQlfDR2wxXMysbINI55Seu9KS5O0osjIYdHlsiIZKfTrc55Shs6Wnm
	 HaFFbDVdrlvhQVpXVpmo2s365vqtmLGU2ln2oNnDRRzn9PxvgxGpoESxKaeiH77Ud+
	 w3L556NLo33cgYiTpKvSa4d3UeBNpMOGmWOrdHrQLjqRuzCJCZdHSX15Yrthp3Y9G1
	 wEes6LWudYNncomHVhyZhUTPzTswCMaZJAOG/8BgIfXMB3rX9GFq8rc4eIiTIEwwbs
	 VvLE/0p2gMPAg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GfouE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:41 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:40 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:40 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 7/8] r8169: add phylink support for RTL8127atf
Date: Tue, 7 Jul 2026 17:16:35 +0800
Message-ID: <20260707091637.371-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260707091637.371-1-javen_xu@realsil.com.cn>
References: <20260707091637.371-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305381-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC60B719C54

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8127 ATF is a 10G SFP mode of RTL8127. Like RTL8116af, it has no
internal phy, so phylink uses a pcs to get the link status from the
serdes registers instead of standard phy registers.

The interface mode is PHY_INTERFACE_MODE_10GBASER. rtl_mac_select_pcs()
returns tp->pcs for it, and the serdes is configured for 10G in
pcs_config() via r8127_sfp_init_10g(). Speed and duplex are hardcoded
to 10Gbps Full-Duplex.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v3:
 - No changes. New file.

Changes in v4:
 - remove DUMMY_PHY in driver/net/phy/realtek/realtek_main.c and related
   function

Changes in v5:
 - no changes, 1G support will be submitted by a following patch
---
 drivers/net/ethernet/realtek/r8169_main.c | 81 ++++++++++-------------
 drivers/net/phy/realtek/realtek_main.c    | 54 ---------------
 include/net/phy/realtek_phy.h             |  7 --
 3 files changed, 35 insertions(+), 107 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e9b9246380e8..44dd1a5554ff 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -32,7 +32,6 @@
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
-#include <net/phy/realtek_phy.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -102,6 +101,7 @@
 #define OCP_SDS_DATA_REG		0xEB14
 #define SDS_CMD_READ			0x0001
 #define RTL_SDS_C22_BASE		0x40
+#define RTL_SDS_C45_BASE		0x0080
 #define RTL_PKG_DETECT			0xdc00
 #define RTL_PKG_DETECT_MASK		0x0078
 #define RTL_PKG_DETECT_8116AF		0x0030
@@ -1158,10 +1158,6 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
-	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
-		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
-
 	RTL_W32(tp, GPHY_OCP, reg << 15);
 
 	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
@@ -1247,12 +1243,6 @@ static void r8127_sfp_init_10g(struct rtl8169_private *tp)
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
@@ -2442,30 +2432,8 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
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
 
-	if (!phy_check_valid(speed, duplex, phydev->supported))
-		return -EINVAL;
-
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
@@ -2614,9 +2582,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode == RTL_SFP_8127_ATF)
-		rtl_sfp_init(tp);
-
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -4999,7 +4964,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if (status & LinkChg) {
 		if (tp->phydev)
 			phy_mac_interrupt(tp->phydev);
-		else if (tp->sfp_mode == RTL_SFP_8168_AF)
+		else if (tp->sfp_mode)
 			phylink_mac_change(tp->phylink,
 					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
 	}
@@ -5729,7 +5694,8 @@ static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 	if (!tp->pcs.ops)
 		return NULL;
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX)
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_10GBASER)
 		return &tp->pcs;
 
 	return NULL;
@@ -5759,12 +5725,28 @@ static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
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
+
+		state->link = !!(stat1 & MDIO_STAT1_LSTATUS);
+		if (!state->link)
+			return;
 
-	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+		state->duplex = DUPLEX_FULL;
+		state->speed = SPEED_10000;
+	} else {
+		u16 bmsr, lpa;
+
+		bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+		lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+	}
 }
 
 static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
@@ -5772,6 +5754,11 @@ static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
 			      const unsigned long *advertising,
 			      bool permit_pause_to_mac)
 {
+	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
+
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
+		r8127_sfp_init_10g(tp);
+
 	return 0;
 }
 
@@ -5814,7 +5801,7 @@ static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
 {
 	unsigned long caps = 0;
 
-	if (!rtl_supports_eee(tp))
+	if (!rtl_supports_eee(tp) || tp->sfp_mode == RTL_SFP_8127_ATF)
 		return 0;
 
 	caps |= MAC_100FD | MAC_1000FD;
@@ -5858,7 +5845,9 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 		tp->phylink_config.mac_capabilities |= MAC_1000FD;
 		break;
 	case RTL_SFP_8127_ATF:
-		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
+		tp->pcs.ops = &r8169_pcs_ops;
+		phy_mode = PHY_INTERFACE_MODE_10GBASER;
+		tp->phylink_config.default_an_inband = true;
 		tp->phylink_config.mac_capabilities |= MAC_10000FD;
 		break;
 	default:
@@ -6088,7 +6077,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


