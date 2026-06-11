Return-Path: <netdev+bounces-298039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QvffApeDKmoergMAu9opvQ
	(envelope-from <netdev+bounces-298039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:44:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9950B670894
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=JNGjXdjn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298039-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC153067743
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196203C1405;
	Thu, 11 Jun 2026 09:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAF3BED69;
	Thu, 11 Jun 2026 09:44:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171072; cv=none; b=pvmmtI06653YTJdLYF2/GrmGT+2JVTwb12RAfv+Y0QsQs3LmSBJXj25jTU1Z8ej656bQFJiK8wjx0a69ZFgCogPgjzlJeXEZdN2Hp3k8hbQJGCoHwu7e7M2uBTkh3nuhQmmR5ivtD7Mjo3Jk3UxK3xJLbrlSFO1npHgM0MUNals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171072; c=relaxed/simple;
	bh=h06Ba6plWCFPwrl6DSt7syZ+dYYWeQDj8JDrAshIozE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFeGf2fwjHhxYyxKp5oRHIAO9KG1J9Z2yiMgoFrn6gVYTTuWkC0GAj60TUwT4wp8LByQQFH0I7mLBwTiuqFBd952eHVb06GpEK+sX7xeZef3wfNVVwC31FOwtCN1Nm0q4B0Um2CJVyqYg43jt9F7Ro47h8vP27NNtCuBbiM5MXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=JNGjXdjn; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B9hlUxB1836014, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781171028;
	bh=mMWmrt+ckDwotowLdxwv0gNUalSOq4DmXhfCT4FTUQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JNGjXdjnT1+CT20FsXlBCnDctoGiw9P4dsoOZtCCoI/ERQEI1bdijyiqH+6IZbuTD
	 s+TNvRrzkd+m7+q1J89j8TZ0NZpCV1Sno6MJVXRZA0q5PC09p6sFjLBy02XPDvQwEw
	 zVQNwo+IN80pSg6ClsrKfgIRxgwBDB9phnBBNssKytYYmdQxZvp2g48Aqwx556PB9T
	 otlU1doPHD06OpZ5sMVAoGwlQ8YsGV1cPmlcE+ucY/J/EUB5UUl++WJfO7BPHxp18S
	 h2pD2TRMTtaCOyY4hkNudo7B0pQWCOb3e/C72nmhr/rUBBC1nG1Lew/wyBRH2YrQGN
	 QIbuyLRFm5h6w==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B9hlUxB1836014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:43:48 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:43:47 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 17:43:47 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 4/6] r8169: add support for RTL8116af
Date: Thu, 11 Jun 2026 17:43:43 +0800
Message-ID: <20260611094345.880-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260611094345.880-1-javen_xu@realsil.com.cn>
References: <20260611094345.880-1-javen_xu@realsil.com.cn>
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
	TAGGED_FROM(0.00)[bounces-298039-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9950B670894

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is sfp mode. Phylink uses pcs to get the link status and speed
from its serdes reg, instead of standard phy reg. Also, RTL8116af doesn't
have internal phy, so we add some checks to ensure that tp->phydev is
not empty when we need it.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - replace some magic numbers with macro

---
 drivers/net/ethernet/realtek/r8169_main.c | 180 ++++++++++++++++++----
 1 file changed, 148 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 615bd4107359..a73c0215b240 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -99,6 +99,18 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
+#define OCP_SDS_ADDR_REG	0xEB10
+#define OCP_SDS_CMD_REG		0xEB0E
+#define OCP_SDS_DATA_REG	0xEB14
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
@@ -731,6 +743,12 @@ enum rtl_dash_type {
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
@@ -739,6 +757,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -766,7 +785,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -780,6 +798,7 @@ struct rtl8169_private {
 	u32 ocp_base;
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
+	struct phylink_pcs pcs;
 	struct irq_domain *phy_irq_domain;
 };
 
@@ -1136,7 +1155,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		return 0;
 
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1290,6 +1309,15 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
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
@@ -1585,6 +1613,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
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
@@ -2400,8 +2442,8 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int duplex = cmd->base.duplex;
 	int speed = cmd->base.speed;
 
-	if (!tp->sfp_mode)
-		return phy_ethtool_ksettings_set(phydev, cmd);
+	if (tp->sfp_mode != RTL_SFP_8127_ATF)
+		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
@@ -2512,9 +2554,10 @@ void r8169_apply_firmware(struct rtl8169_private *tp)
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
 
@@ -2551,6 +2594,8 @@ static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
 
 static void rtl8169_init_phy(struct rtl8169_private *tp)
 {
+	phy_init_hw(tp->phydev);
+	phy_resume(tp->phydev);
 	r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
 
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
@@ -2565,7 +2610,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_init(tp);
 
 	/* We may have called phy_speed_down before */
@@ -3703,12 +3748,14 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 
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
@@ -4998,7 +5045,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	phylink_stop(tp->phylink);
 
 	/* Reset SerDes PHY to bring down fiber link */
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_reset(tp);
 
 	rtl8169_update_counters(tp);
@@ -5020,9 +5067,9 @@ static void rtl8169_up(struct rtl8169_private *tp)
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
@@ -5100,9 +5147,11 @@ static int rtl_open(struct net_device *dev)
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
@@ -5647,6 +5696,10 @@ static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *ph
 static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
 					      phy_interface_t interface)
 {
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	if (interface == PHY_INTERFACE_MODE_1000BASEX || interface == PHY_INTERFACE_MODE_SGMII)
+		return &tp->pcs;
 	return NULL;
 }
 
@@ -5655,6 +5708,55 @@ static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
 {
 }
 
+static u16 rtl8169_sds_read(struct rtl8169_private *tp, u16 sds_reg)
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
+	bmsr = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_BMSR);
+	lpa = rtl8169_sds_read(tp, RTL_SDS_C22_BASE + MII_LPA);
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
 static void rtl_mac_disable_tx_lpi(struct phylink_config *config)
 {
 	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
@@ -5705,6 +5807,13 @@ static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
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
@@ -5716,10 +5825,19 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
 	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
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
 
@@ -5734,6 +5852,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 		else
 			if (tp->supports_gmii)
 				tp->phylink_config.mac_capabilities |= MAC_1000FD;
+		break;
 	}
 
 	__set_bit(phy_mode, tp->phylink_config.supported_interfaces);
@@ -5828,12 +5947,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -5941,10 +6055,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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


