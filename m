Return-Path: <netdev+bounces-295778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OvsGBDmqImojbwEAu9opvQ
	(envelope-from <netdev+bounces-295778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:51:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC4F64785D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:51:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=n3dLtDWO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295778-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295778-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E455231380E2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C374BC021;
	Fri,  5 Jun 2026 10:39:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F64183CD;
	Fri,  5 Jun 2026 10:39:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655973; cv=none; b=QiDRvTSUz0OjjQIUzgJZ7Xl5GPZDPtnOm+Dqrup6s1OyHadEN7etdz3uWYA4yeslwjJckNEetPJi6ri71TnMd/TwqB0leWUa+LDdf8NgX0VuyqmdZh1AMo4ODv2HEbcbu2e0R462nHe77gerEqjUq+vdqqSupe7TizF2oQHK3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655973; c=relaxed/simple;
	bh=iQDlx8qk+GrmzeDno8vms/raPqirWtUebz7COV5np/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3fDv/HiTfjJVUPArT6SieR9wqLaOEUkkGg8LeiuN9JjvBZgv0mNTmrThe6Iax3whjlXisCUPEuVtt3EXZH7rvvvK+SJQsCnRGo4X1hufuEjHyswPmi7z6NARAbkVwexrmSZdwpS5KEQ0stCeWg4PTgiOP4PLxv47F1QtHt3ezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=n3dLtDWO; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 655Ad9eE51324199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780655949;
	bh=mr1pr3pqc6eochxrQvqy5tqM+O7oqq1KWz7fbRYMC2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n3dLtDWO5GeDYwb7EWv7g69Ab84Mu4VBRCiWvcksEnXhrkapZ9FmoM9rcKvNKhgn0
	 XYYnXBOs27xSp2JeQ8p5gkoYa9qDrXy4BBliHin2M+yZK7o7vUSTgsj+Zz9G4gQPvz
	 ayWnYr2h75oelKz+55TNvAyzVTWW+uDdPjY4evmzjx5c3kaezok4IUyUwCEvIe1PzO
	 Q+84uyXYQlXxP8sdfVWvgSZAcZt0zz4LkLUxyxUPEnE591h0rhad0/42oGMVJlPVlC
	 O7wqxuIvrXtOrG9YcTAMYhhOlU5fR+hcOp2jq+Ru+J/fPqYmEf7e8GBFvrjnZjgAid
	 LYVaN+vjmrI/Q==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 655Ad9eE51324199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 18:39:09 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 18:39:09 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 18:39:09 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Date: Fri, 5 Jun 2026 18:39:03 +0800
Message-ID: <20260605103906.1445-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260605103906.1445-1-javen_xu@realsil.com.cn>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295778-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DC4F64785D

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is sfp mode. Phylink uses pcs to get the link status and speed
from its serdes reg, instead of standard phy reg. Also, RTL8116af doesn't
have internal phy, so we add some checks to ensure that tp->phydev is
not empty when we need it.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 172 ++++++++++++++++++----
 1 file changed, 140 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c46117e3a643..7b79305635fc 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -97,6 +97,12 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
+#define OCP_SDS_ADDR_REG	0xEB10
+#define OCP_SDS_CMD_REG		0xEB0E
+#define OCP_SDS_DATA_REG	0xEB14
+#define SDS_CMD_READ		0x0001
+#define RTL_SDS_C22_BASE	0x40
+
 static const struct rtl_chip_info {
 	u32 mask;
 	u32 val;
@@ -729,6 +735,12 @@ enum rtl_dash_type {
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
@@ -737,6 +749,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -764,7 +777,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -778,6 +790,7 @@ struct rtl8169_private {
 	u32 ocp_base;
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
+	struct phylink_pcs pcs;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -1133,7 +1146,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		return 0;
 
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1287,6 +1300,13 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
 	r8168_mac_ocp_write(tp, tp->ocp_base + reg, value);
 }
 
+static bool rtl_is_8116af(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_52 &&
+		(r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) == 0x0030 &&
+		(r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) == 0x0000;
+}
+
 static int mac_mcu_read(struct rtl8169_private *tp, int reg)
 {
 	return r8168_mac_ocp_read(tp, tp->ocp_base + reg);
@@ -1582,6 +1602,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static enum rtl_sfp_mode rtl_get_sfp_mode(struct rtl8169_private *tp)
+{
+	if (rtl_is_8125(tp)) {
+		u16 data = r8168_mac_ocp_read(tp, 0xd006);
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
@@ -2397,7 +2431,7 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int duplex = cmd->base.duplex;
 	int speed = cmd->base.speed;
 
-	if (!tp->sfp_mode)
+	if (tp->sfp_mode != RTL_SFP_8127_ATF)
 		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
@@ -2509,9 +2543,10 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
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
 
@@ -2562,7 +2597,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_init(tp);
 
 	genphy_soft_reset(tp->phydev);
@@ -3697,12 +3732,14 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 
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
@@ -4879,7 +4916,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		goto out;
 	}
 
-	if (status & LinkChg)
+	if (status & LinkChg && tp->phydev)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
@@ -4995,7 +5032,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	phylink_stop(tp->phylink);
 
 	/* Reset SerDes PHY to bring down fiber link */
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_reset(tp);
 
 	rtl8169_update_counters(tp);
@@ -5017,9 +5054,11 @@ static void rtl8169_up(struct rtl8169_private *tp)
 		rtl8168_driver_start(tp);
 
 	pci_set_master(tp->pci_dev);
-	phy_init_hw(tp->phydev);
-	phy_resume(tp->phydev);
-	rtl8169_init_phy(tp);
+	if (tp->phydev) {
+		phy_init_hw(tp->phydev);
+		phy_resume(tp->phydev);
+		rtl8169_init_phy(tp);
+	}
 
 	/* We may have called phy_speed_down before */
 	phylink_speed_up(tp->phylink);
@@ -5100,9 +5139,11 @@ static int rtl_open(struct net_device *dev)
 	if (retval < 0)
 		goto err_release_fw_2;
 
-	retval = r8169_phy_connect(tp);
-	if (retval)
-		goto err_free_irq;
+	if (tp->phydev) {
+		retval = r8169_phy_connect(tp);
+		if (retval)
+			goto err_free_irq;
+	}
 
 	rtl8169_up(tp);
 	rtl8169_init_counter_offsets(tp);
@@ -5616,6 +5657,10 @@ static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *ph
 static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 					      phy_interface_t interface)
 {
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	if (interface == PHY_INTERFACE_MODE_1000BASEX || interface == PHY_INTERFACE_MODE_SGMII)
+		return &tp->pcs;
 	return NULL;
 }
 
@@ -5624,6 +5669,55 @@ static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
 {
 }
 
+static u16 rtl8116af_sds_read(struct rtl8169_private *tp, u16 sds_reg)
+{
+	r8168_mac_ocp_write(tp, OCP_SDS_ADDR_REG, sds_reg);
+	r8168_mac_ocp_write(tp, OCP_SDS_CMD_REG, SDS_CMD_READ);
+	return r8168_mac_ocp_read(tp, OCP_SDS_DATA_REG);
+}
+
+static void rtl8169_pcs_get_state(struct phylink_pcs *pcs,
+				  unsigned int neg_mode,
+				  struct phylink_link_state *state)
+{
+	struct rtl8169_private *tp = container_of(pcs, struct rtl8169_private, pcs);
+	u16 bmsr, lpa;
+
+	bmsr = rtl8116af_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+	lpa = rtl8116af_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
+
+	state->link = !!(bmsr & BMSR_LSTATUS);
+	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
+	if (state->link) {
+		state->speed = SPEED_1000;
+		state->duplex = DUPLEX_FULL;
+	} else {
+		state->speed = SPEED_UNKNOWN;
+		state->duplex = DUPLEX_UNKNOWN;
+	}
+
+	if (lpa & LPA_1000XPAUSE)
+		state->pause |= MLO_PAUSE_RX | MLO_PAUSE_TX;
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
 static const struct phylink_mac_ops rtl_phylink_mac_ops = {
 	.mac_select_pcs = rtl_mac_select_pcs,
 	.mac_config = rtl_mac_config,
@@ -5631,6 +5725,13 @@ static const struct phylink_mac_ops rtl_phylink_mac_ops = {
 	.mac_link_up    = rtl_mac_link_up,
 };
 
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
@@ -5642,10 +5743,19 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 
 	tp->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
-	if (tp->sfp_mode) {
+	switch (tp->sfp_mode) {
+	case RTL_SFP_8168_AF:
+		tp->pcs.ops = &r8169_pcs_ops;
+		tp->pcs.poll = true;
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
 		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
 
@@ -5660,6 +5770,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 		else
 			if (tp->supports_gmii)
 				tp->phylink_config.mac_capabilities |= MAC_1000FD;
+		break;
 	}
 
 	__set_bit(phy_mode, tp->phylink_config.supported_interfaces);
@@ -5754,12 +5865,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -5867,10 +5973,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


