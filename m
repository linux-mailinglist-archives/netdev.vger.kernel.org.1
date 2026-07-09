Return-Path: <netdev+bounces-306162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qj04NLB1T2qhhAIAu9opvQ
	(envelope-from <netdev+bounces-306162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8C72F817
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=wLkXeKpa;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306162-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0E1830DDF1F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D940D582;
	Thu,  9 Jul 2026 10:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74809408023;
	Thu,  9 Jul 2026 10:09:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591746; cv=none; b=ubKe8MvbIQrRsCzbsWThLo8hhQvo7GTJB41bZgNOnZ1Zyhbt6ZULJ3P9cTgIaIFG91YoRgtiFxqKpQBHCUL61rSQFVuJ+Ud0m+Bh4EJVxOuSBNxPoDs1KQOq6KfRcbJAAK3IQ/LJlkMlfWcamUOH3JYtlGszraN0guuAiC9+wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591746; c=relaxed/simple;
	bh=JO0S+awVjynv7dUqD2PfUY4/T6UcX0ie7KUk1OxAL0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfyiwsjH2tcHCYJJKT/Fth2ftxwsVKzJ+kMO99qS+9KK6lj+fgAEVGjTsm9Soyhm+eDa4b9TghZVcz7OeD8CxMqjo0nBi3OB5hG+kFRze2N+yhsTHkSvfb01HJh11KfjIWh0FkQ3nMob7kdxHZyJXKr3TUcNQh8TbpbcxKNj0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=wLkXeKpa; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 669A2nm062982781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783591370;
	bh=6XoeFJb3EuTL+wY3BYg3ibuODK67aRQETPRWKuHpkkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wLkXeKpauPTonDYJ+ZsKqmEd1/BtDrOX5vj6GrnxbrD/7zT3HhuQYaxUCxbGDzW4D
	 he4eBwj0ts4hSJSvm+I3NVKomRc9BgFrb8jcieggzEqi4x9UrjunxoFAhQ1eoltPlq
	 qNTpVnbqujg8OWwi9X9o1jj7AefaAOr+hEx9PTNVRd4UPtGzG1VAuI7lXisfHySvmX
	 LMvxRmt79RNIey+jPhS5tMWUd7v/dsxL8lbh2JWTTTfivAHusqgspHQoNbMGKJgMT7
	 7ocEQfblC/XvWQ2nzvNnboppFHq1t6qltQj3PmTMpQXTwSwPaqzxieYyq34fQ1r6wo
	 KeJPEMYQCbUYg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 669A2nm062982781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 18:02:49 +0800
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
Subject: [PATCH net-next v6 4/7] r8169: add support for RTL8116af
Date: Thu, 9 Jul 2026 18:02:33 +0800
Message-ID: <20260709100237.541-5-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306162-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58A8C72F817

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is sfp mode. Phylink uses pcs to get the link status from its
serdes reg, instead of standard phy reg. Speed and duplex are hardcoded
to 1000Mbps Full-Duplex. Also, RTL8116af doesn't have internal phy, so
we add some checks to ensure that tp->phydev is not empty when we need it.
In rtl_hw_start_8117(), the MAC calibration for register 0xd412 relies
on reading the internal PHY register 0x0c42. Since RTL8116af does not
have an internal PHY, this calibration step is intentionally bypassed.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - replace some magic numbers with macro

Changes in v3:
 - change commit message
 - add lock when we do rtl8169_sds_read
 - use phylink_mii_c22_pcs_decode_state to get status
 - add phylink_mac_change for RTL8116af for it doesn't have phy

Changes in v4:
 - if tp->pcs.ops is not initial, just return NULL in rtl_mac_select_pcs

Changes in v5:
 - no changes

Changes in v6:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 187 ++++++++++++++++++----
 1 file changed, 153 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7a6c734df3d2..570801408f22 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -97,6 +97,18 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
+#define OCP_SDS_ADDR_REG	0xeb10
+#define OCP_SDS_CMD_REG		0xeb0e
+#define OCP_SDS_DATA_REG	0xeb14
+#define SDS_CMD_READ		0x0001
+#define RTL_SDS_C22_BASE	0x40
+#define RTL_PKG_DETECT		0xdc00
+#define RTL_PKG_DETECT_MASK	0x0078
+#define RTL_PKG_DETECT_8116AF	0x0030
+#define RTL_INT_HW_ID		0xd006
+#define RTL_INT_HW_ID_MASK	0x00ff
+#define RTL_INT_HW_ID_8116AF	0x0000
+
 static const struct rtl_chip_info {
 	u32 mask;
 	u32 val;
@@ -729,6 +741,12 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rtl_sfp_mode {
+	RTL_SFP_NONE,
+	RTL_SFP_8168_AF,
+	RTL_SFP_8127_ATF,
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -737,6 +755,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -764,7 +783,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -778,6 +796,7 @@ struct rtl8169_private {
 	u32 ocp_base;
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
+	struct phylink_pcs pcs;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -1133,7 +1152,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		return 0;
 
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1287,6 +1306,15 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
 	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
 }
 
+static bool rtl_is_8116af(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
+		(r8168_mac_ocp_read(tp, RTL_PKG_DETECT) & RTL_PKG_DETECT_MASK) ==
+		RTL_PKG_DETECT_8116AF &&
+		(r8168_mac_ocp_read(tp, RTL_INT_HW_ID) & RTL_INT_HW_ID_MASK) ==
+		RTL_INT_HW_ID_8116AF;
+}
+
 static int mac_mcu_read(struct rtl8169_private *tp, int reg)
 {
 	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
@@ -1582,6 +1610,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
+{
+	if (rtl_is_8125(tp)) {
+		u16 data = r8168_mac_ocp_read(tp, RTL_INT_HW_ID);
+
+		if ((data & 0xff) == 0x07)
+			return RTL_SFP_8127_ATF;
+	} else if (rtl_is_8116af(tp)) {
+		return RTL_SFP_8168_AF;
+	}
+
+	return RTL_SFP_NONE;
+}
+
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
@@ -2397,7 +2439,7 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int duplex = cmd->base.duplex;
 	int speed = cmd->base.speed;
 
-	if (!tp->sfp_mode)
+	if (tp->sfp_mode != RTL_SFP_8127_ATF)
 		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
@@ -2509,9 +2551,10 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
 		tp->ocp_base = OCP_STD_PHY_BASE;
 
 		/* PHY soft reset may still be in progress */
-		phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
-				      !(val & BMCR_RESET),
-				      50000, 600000, true);
+		if (tp->phydev)
+			phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
+					      !(val & BMCR_RESET),
+					      50000, 600000, true);
 	}
 }
 
@@ -2548,6 +2591,8 @@ static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
 
 static void rtl8169_init_phy(struct rtl8169_private *tp)
 {
+	phy_init_hw(tp->phydev);
+	phy_resume(tp->phydev);
 	r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
@@ -2562,7 +2607,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_init(tp);
 
 	/* We may have called phy_speed_down before */
@@ -3704,12 +3749,14 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 
 	rtl_pcie_state_l2l3_disable(tp);
 
-	rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
-	if (rg_saw_cnt > 0) {
-		u16 sw_cnt_1ms_ini;
+	if (tp->phydev) {
+		rg_saw_cnt = phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
+		if (rg_saw_cnt > 0) {
+			u16 sw_cnt_1ms_ini;
 
-		sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
-		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
+			sw_cnt_1ms_ini = (16000000 / rg_saw_cnt) & 0x0fff;
+			r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
+		}
 	}
 
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
@@ -4893,8 +4940,13 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		goto out;
 	}
 
-	if (status & LinkChg)
-		phy_mac_interrupt(tp->phydev);
+	if (status & LinkChg) {
+		if (tp->phydev)
+			phy_mac_interrupt(tp->phydev);
+		else if (tp->sfp_mode == RTL_SFP_8168_AF)
+			phylink_mac_change(tp->phylink,
+					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
+	}
 
 	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
@@ -5004,7 +5056,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
 	/* Reset SerDes PHY to bring down fiber link */
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_reset(tp);
 
 	rtl8169_update_counters(tp);
@@ -5026,9 +5078,9 @@ static void rtl8169_up(struct rtl8169_private *tp)
 		rtl8168_driver_start(tp);
 
 	pci_set_master(tp->pci_dev);
-	phy_init_hw(tp->phydev);
-	phy_resume(tp->phydev);
-	rtl8169_init_phy(tp);
+	if (tp->phydev)
+		rtl8169_init_phy(tp);
+
 	napi_enable(&tp->napi);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
@@ -5105,10 +5157,11 @@ static int rtl_open(struct net_device *dev)
 	if (retval < 0)
 		goto err_release_fw_2;
 
-	retval = r8169_phy_connect(tp);
-	if (retval)
-		goto err_free_irq;
-
+	if (tp->phydev) {
+		retval = r8169_phy_connect(tp);
+		if (retval)
+			goto err_free_irq;
+	}
 	rtl8169_up(tp);
 	phylink_start(tp->phylink);
 	rtl8169_init_counter_offsets(tp);
@@ -5609,6 +5662,14 @@ static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *ph
 static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 					      phy_interface_t interface)
 {
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	if (!tp->pcs.ops)
+		return NULL;
+
+	if (interface == PHY_INTERFACE_MODE_1000BASEX)
+		return &tp->pcs;
+
 	return NULL;
 }
 
@@ -5617,6 +5678,51 @@ static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
 {
 }
 
+static u16 rtl8169_sds_read(struct rtl8169_private *tp, u16 sds_reg)
+{
+	unsigned long flags;
+	u16 val = 0;
+
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write(tp, OCP_SDS_ADDR_REG, sds_reg);
+	__r8168_mac_ocp_write(tp, OCP_SDS_CMD_REG, SDS_CMD_READ);
+	val = __r8168_mac_ocp_read(tp, OCP_SDS_DATA_REG);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+
+	return val;
+}
+
+static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
+				  unsigned int neg_mode,
+				  struct phylink_link_state *state)
+{
+	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
+	u16 bmsr, lpa;
+
+	bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+	lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
+}
+
+static int rtl8169_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+			      phy_interface_t interface,
+			      const unsigned long *advertising,
+			      bool permit_pause_to_mac)
+{
+	return 0;
+}
+
+static int rtl8169_pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
+				const struct phylink_link_state *state)
+{
+	return 0;
+}
+
+static void rtl8169_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
 static void rtl_mac_disable_tx_lpi(struct phylink_config *config)
 {
 	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
@@ -5664,6 +5770,13 @@ static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
 	return caps;
 }
 
+static const struct phylink_pcs_ops r8169_pcs_ops = {
+	.pcs_validate = rtl8169_pcs_validate,
+	.pcs_get_state = rtl8169_pcs_get_state,
+	.pcs_config = rtl8169_pcs_config,
+	.pcs_an_restart = rtl8169_pcs_an_restart,
+};
+
 static int rtl_init_phylink(struct rtl8169_private *tp)
 {
 	struct phylink *pl;
@@ -5675,10 +5788,18 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
 	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
-	if (tp->sfp_mode) {
+	switch (tp->sfp_mode) {
+	case RTL_SFP_8168_AF:
+		tp->pcs.ops = &r8169_pcs_ops;
+		tp->phylink_config.default_an_inband = true;
+		phy_mode = PHY_INTERFACE_MODE_1000BASEX;
+		tp->phylink_config.mac_capabilities |= MAC_1000FD;
+		break;
+	case RTL_SFP_8127_ATF:
 		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
 		tp->phylink_config.mac_capabilities |= MAC_10000FD;
-	} else {
+		break;
+	default:
 		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
 
 		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
@@ -5698,6 +5819,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 				   PHY_INTERFACE_MODE_MII;
 		else
 			phy_mode = PHY_INTERFACE_MODE_INTERNAL;
+		break;
 	}
 
 	__set_bit(phy_mode, tp->phylink_config.supported_interfaces);
@@ -5795,12 +5917,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	tp->aspm_manageable = !rc;
 
-	if (rtl_is_8125(tp)) {
-		u16 data = r8168_mac_ocp_read(tp, 0xd006);
-
-		if ((data & 0xff) == 0x07)
-			tp->sfp_mode = true;
-	}
+	tp->sfp_mode = rtl_get_sfp_mode(tp);
 
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
@@ -5908,10 +6025,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = r8169_mdio_register(tp);
-	if (rc) {
-		phylink_destroy(tp->phylink);
-		return rc;
+	if (tp->sfp_mode != RTL_SFP_8168_AF) {
+		rc = r8169_mdio_register(tp);
+		if (rc) {
+			phylink_destroy(tp->phylink);
+			return rc;
+		}
 	}
 
 	rc = register_netdev(dev);
-- 
2.43.0


