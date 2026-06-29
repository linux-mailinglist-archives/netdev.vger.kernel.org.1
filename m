Return-Path: <netdev+bounces-302463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pKohMIUMQmrNzQkAu9opvQ
	(envelope-from <netdev+bounces-302463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E676D6315
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:11:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b="T8/8RakM";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302463-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB90A302A508
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A81395273;
	Mon, 29 Jun 2026 06:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945C3890EA;
	Mon, 29 Jun 2026 06:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713433; cv=none; b=R4V9E1e6ol37v948EOVc/WoMTwKGrjWDN8aH/J6BHsN/EWGYQ9ym6aMJ6NQH2/rpth1j1PVhb5tJVmzni1WN4vU3eUwTFB2/idPsuNNx68LZN9bUPaXYPJNeyfWMrsctLQJrJjeCm5T01nLCtgC5QZg82Wnili4xAbqtzZilToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713433; c=relaxed/simple;
	bh=HYgyUyh9dn6VmW6t+6WuVe5PmsZkWdqTo64LMn9PNSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLwW0lC+JgyT0bAhvVupJ3Z2sOcnVr/a5icBdYKsXawWPaR0KcUUquhqlkltICQgyvWZ9FYYbcUez7fb9pkgwvDn0x4tDAmkvOlqX1WpGBmAfB5TD+Gs7lOuRENtrvnoXW6QugUQlgp+yudX4bo09+y9+EmkSBT0UMMnP3d5V38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=T8/8RakM; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T69Z2N03467453, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782713375;
	bh=xJNJu6swPAaJmbqhCwaV7ITFmbAZnmAT63Z4gz6Ezg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=T8/8RakM6plhZPR3lXiCK3h2XE8VK+jGMdD/mek9oQxct8IzTlmtMgymxiFVAzf4S
	 bnIxfxRmFf3xSTCg8aPSJxIGk604hZ+cBqZWXKLykePNm2VTo+xczHRi/YizYNPFby
	 8G8aMU/izV/OlhOw14OFxteCDU94XT2EGk5rTLHDrYUb8YsfR2qhVvqSOR6sLdIx7K
	 7wjX/Ynoz2ZWljPZfMtayRH2uFL5ISc+DfajKihogfWLnrcoAA52pXz4kET3G8H1Qg
	 TaMNgALeKTXBQXFdhKUGdBwXTHsG8e6ktPXRYdcmQ01CurHjRXaWQr5Hw/PvLK1uWN
	 o6V49PnbPKddA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T69Z2N03467453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:09:35 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:09:34 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:09:34 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 7/7] r8169: add phylink support for RTL8127atf
Date: Mon, 29 Jun 2026 14:09:31 +0800
Message-ID: <20260629060931.1006-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260629060931.1006-1-javen_xu@realsil.com.cn>
References: <20260629060931.1006-1-javen_xu@realsil.com.cn>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302463-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3E676D6315

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8127 ATF is a 10G SFP mode of RTL8127. Like RTL8116af, it has no
internal phy, so phylink uses a pcs to get the link status from the
serdes registers instead of standard phy registers.

The interface mode is PHY_INTERFACE_MODE_10GBASER. rtl_mac_select_pcs()
returns tp->pcs for it, and the serdes is configured for 10G in
pcs_config() via r8127_sfp_init_10g(). Speed and duplex are hardcoded
to 10Gbps Full-Duplex.

Per the datasheet, the 10G fiber does not support EEE/EEEP, RTD3, MAC
speed down, GPHY speed up, UPS or PFM mode, so EEE and runtime D3 are
disabled for RTL8127 ATF. UPS and PFM are already left disabled for this
chip, and the phy speed up/down paths are not reached because there is no
phydev.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v3:
 - No changes. New file.
---
 drivers/net/ethernet/realtek/r8169_main.c | 84 ++++++++++-------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 223501479d20..6f4221079e8f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -104,6 +104,7 @@
 #define OCP_SDS_DATA_REG	0xEB14
 #define SDS_CMD_READ		0x0001
 #define RTL_SDS_C22_BASE	0x40
+#define RTL_SDS_C45_BASE	0x0080
 #define RTL_PKG_DETECT		0xdc00
 #define RTL_PKG_DETECT_MASK	0x0078
 #define RTL_PKG_DETECT_8116AF	0x0030
@@ -1161,10 +1162,6 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
 
-	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
-		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
-
 	RTL_W32(tp, GPHY_OCP, reg << 15);
 
 	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
@@ -1250,12 +1247,6 @@ static void r8127_sfp_init_10g(struct rtl8169_private *tp)
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
@@ -2445,31 +2436,8 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
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
-	tp->speed = speed;
-
-	rtl_sfp_init(tp);
-
-	mutex_unlock(&phydev->lock);
-
-	return 0;
+	return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 }
 
 static int rtl8169_nway_reset(struct net_device *dev)
@@ -2618,9 +2586,6 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode == RTL_SFP_8127_ATF)
-		rtl_sfp_init(tp);
-
 	/* We may have called phy_speed_down before */
 	phy_speed_up(tp->phydev);
 
@@ -5039,7 +5004,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if (status & LinkChg) {
 		if (tp->phy_irq_domain)
 			generic_handle_domain_irq(tp->phy_irq_domain, 0);
-		else if (tp->sfp_mode == RTL_SFP_8168_AF)
+		else if (tp->sfp_mode)
 			phylink_mac_change(tp->phylink,
 					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
 	}
@@ -5809,7 +5774,9 @@ static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 {
 	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX || interface == PHY_INTERFACE_MODE_SGMII)
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_10GBASER)
 		return &tp->pcs;
 	return NULL;
 }
@@ -5838,12 +5805,28 @@ static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -5851,6 +5834,11 @@ static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
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
 
@@ -5896,7 +5884,7 @@ static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
 {
 	unsigned long caps = 0;
 
-	if (!rtl_supports_eee(tp))
+	if (!rtl_supports_eee(tp) || tp->sfp_mode == RTL_SFP_8127_ATF)
 		return 0;
 
 	caps |= MAC_100FD | MAC_1000FD;
@@ -5940,7 +5928,9 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
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
@@ -6167,7 +6157,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	if (tp->sfp_mode != RTL_SFP_8168_AF) {
+	if (tp->sfp_mode == RTL_SFP_NONE) {
 		rc = r8169_mdio_register(tp);
 		if (rc) {
 			phylink_destroy(tp->phylink);
@@ -6202,7 +6192,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl8168_driver_start(tp);
 	}
 
-	if (pci_dev_run_wake(pdev))
+	if (pci_dev_run_wake(pdev) && tp->sfp_mode != RTL_SFP_8127_ATF)
 		pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
-- 
2.43.0


