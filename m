Return-Path: <netdev+bounces-282706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3hyvBdUT82llxAEAu9opvQ
	(envelope-from <netdev+bounces-282706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F949F450
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A41DB300617F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE13EBF37;
	Thu, 30 Apr 2026 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="po1bUI5v"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAE3914F8;
	Thu, 30 Apr 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538001; cv=none; b=paf5Mkrex2IKAtOKxAho6BmK0lKSBx78QdpT7W3adb3/IQoQp2IBV1doQ13mWoRTNwR7WJvez7GBW5wW1w8IhEUclmjDk5gct3uEf6DMljEedHXOYtr7LMZADsT9t1psmqP9kUc6QfE6mAT4Zt2T4jx9lyERcTYBjI+hfwwPYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538001; c=relaxed/simple;
	bh=WGIEXmswSgYixQwf1gRnf+hhX1WEU1xy7AKxkmJGtc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/74Mk0lPy59murTzqG/0zHKpXvFXgz++5UZhxc1qPbaY7vSoX6mjj22keJd8OAhl+bYpLGxbNdtuG4I5jByb3HIgWKqzVmXBkm/b6sM3sUcvdoA4i0q5x+0QcKD0gHV/spPI2P5Ty9hSepM4/tuoVOs1sv5TJCCtTBPWu4zMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=po1bUI5v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63U8Wln161821569, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777537967;
	bh=DCtyK9HQFUSl2p7ntMFUFo5Wcsnmm/BhbsczxRyzdm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=po1bUI5v1QMMPl0tI7mKB2f8nBzO7WLs5p8YKVsPN1SoBarTA9Bikx987MlxbXzEV
	 ZE3On6botZJNcPwcndrbT80i1arNg2+4qZkVFmgBTzQr2CGTaKITySPRmzdFlCMqMh
	 SmlBfHuI6mCsKBGWU1wgphnmjvdOZB+cdVIFDbp6cHX8oBEosm0IErXX5sM1mEhT1W
	 W6sD/XlEH15h/fsUpPIKATLRwFvWdQYeor1GXKqeCdHoOTX4IpnImOaeu5vpkV+3sg
	 I7gzzfLvYyjoXqWw39W/a0omK5/+sPDKa8vsb8tu8Tk8HrH7BKiSlJsXEfaBU9NagH
	 J9VRpUYwBIXhw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63U8Wln161821569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Apr 2026 16:32:47 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Apr 2026 16:32:47 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 16:32:47 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next] r8169: add phylink support
Date: Thu, 30 Apr 2026 16:32:43 +0800
Message-ID: <20260430083244.703-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 606F949F450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282706-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds phylink support for r8169, and just for discussion.

Hi, all

I have refactored r8169 driver to integrate phylink based on
https://docs.kernel.org/networking/sfp-phylink.html, which seems to be
the official documentation. Now, RTL8116af can obtain bmsr and lpa value
through rtl8169_pcs_get_state.

rtl8116af_sds_read() shows how to access standard serdes reg, which is
the same as standard phy reg (map to standard Clause 22 PHY registers).
The access sequence is:
1. Write the SerDes register address to OCP_SDS_ADDR_REG.
2. Write SDS_CMD_READ to OCP_SDS_CMD_REG.
3. Read the data from OCP_SDS_DATA_REG.
I have tested this implementation on RTL8116af, as well as RTL8127a,
RTL8125b, and RTL8168h, it works well.

To save power, chip with fiber mode like RTL8127atf will no longer support
reading the link status directly from standard PHY register. So
migrating to phylink might be a crucial step to support future fiber
mode chips.

And one more question, when the driver initializes RTL8116af,
r8169_mdio_register() will still be called. So tp->phydev =
mdiobus_get_phy(new_bus, 0) will still be executed. This feels redundant
since we are now using phylink. However, if I bypass this assignment,
it breaks several existing functions which are strongly rely on
tp->phydev. Is it acceptable to keep this tp->phydev for now, or is
there a preferred way to handle this problem?

Any feedback would be greatly appreciated.

Thanks,

BRs,
Javen

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 297 +++++++++++++++++-----
 2 files changed, 235 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 9b0f4f9631db..49ac72734225 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -88,6 +88,7 @@ config R8169
 	select CRC32
 	select PHYLIB
 	select REALTEK_PHY
+	select PHYLINK
 	help
 	  Say Y here if you have a Realtek Ethernet adapter belonging to
 	  the following families:
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..9710a4277db8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -32,6 +32,7 @@
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
 #include <net/phy/realtek_phy.h>
+#include <linux/phylink.h>
 
 #include "r8169.h"
 #include "r8169_firmware.h"
@@ -96,6 +97,12 @@
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
@@ -728,6 +735,12 @@ enum rtl_dash_type {
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
@@ -736,6 +749,7 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
+	enum rtl_sfp_mode sfp_mode;
 	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
@@ -762,7 +776,6 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
-	bool sfp_mode:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -774,6 +787,9 @@ struct rtl8169_private {
 	struct r8169_led_classdev *leds;
 
 	u32 ocp_base;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
+	struct phylink_pcs pcs;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -1129,7 +1145,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		return 0;
 
 	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+	if (tp->sfp_mode == RTL_SFP_8127_ATF && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
 		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
 
 	RTL_W32(tp, GPHY_OCP, reg << 15);
@@ -1283,6 +1299,13 @@ static void mac_mcu_write(struct rtl8169_private *tp, int reg, int value)
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
@@ -1578,6 +1601,20 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
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
@@ -1673,16 +1710,14 @@ static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
 	rtl_pci_commit(tp);
 }
 
-static void rtl_link_chg_patch(struct rtl8169_private *tp)
+static void rtl_link_chg_patch(struct rtl8169_private *tp, int speed)
 {
-	struct phy_device *phydev = tp->phydev;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_34 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_38) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
-		} else if (phydev->speed == SPEED_100) {
+		} else if (speed == SPEED_100) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1692,7 +1727,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 		rtl_reset_packet_filter(tp);
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_35 ||
 		   tp->mac_version == RTL_GIGA_MAC_VER_36) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1700,7 +1735,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f);
 		}
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_37) {
-		if (phydev->speed == SPEED_10) {
+		if (speed == SPEED_10) {
 			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x4d02);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_0011, 0x0060a);
 		} else {
@@ -2386,6 +2421,14 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
 		le32_to_cpu(tp->counters->rx_unknown_opcode);
 }
 
+static int rtl8169_get_link_ksettings(struct net_device *ndev,
+				      struct ethtool_link_ksettings *cmd)
+{
+	struct rtl8169_private *tp = netdev_priv(ndev);
+
+	return phylink_ethtool_ksettings_get(tp->phylink, cmd);
+}
+
 static int rtl8169_set_link_ksettings(struct net_device *ndev,
 				      const struct ethtool_link_ksettings *cmd)
 {
@@ -2394,8 +2437,8 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	int duplex = cmd->base.duplex;
 	int speed = cmd->base.speed;
 
-	if (!tp->sfp_mode)
-		return phy_ethtool_ksettings_set(phydev, cmd);
+	if (tp->sfp_mode != RTL_SFP_8127_ATF)
+		return phylink_ethtool_ksettings_set(tp->phylink, cmd);
 
 	if (cmd->base.autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
@@ -2434,7 +2477,7 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
@@ -2552,13 +2595,14 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
 	    tp->pci_dev->subsystem_device == 0xe000)
 		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
 
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_init(tp);
 
 	/* We may have called phy_speed_down before */
-	phy_speed_up(tp->phydev);
-
-	genphy_soft_reset(tp->phydev);
+	if (tp->sfp_mode != RTL_SFP_8168_AF) {
+		phy_speed_up(tp->phydev);
+		genphy_soft_reset(tp->phydev);
+	}
 }
 
 static void rtl_rar_set(struct rtl8169_private *tp, const u8 *addr)
@@ -2780,7 +2824,8 @@ static void rtl_prepare_power_down(struct rtl8169_private *tp)
 		rtl_ephy_write(tp, 0x19, 0xff64);
 
 	if (device_may_wakeup(tp_to_dev(tp))) {
-		phy_speed_down(tp->phydev, false);
+		if (tp->sfp_mode != RTL_SFP_8168_AF)
+			phy_speed_down(tp->phydev, false);
 		rtl_wol_enable_rx(tp);
 	}
 }
@@ -4963,40 +5008,15 @@ static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
 	}
 }
 
-static void r8169_phylink_handler(struct net_device *ndev)
-{
-	struct rtl8169_private *tp = netdev_priv(ndev);
-	struct device *d = tp_to_dev(tp);
-
-	if (netif_carrier_ok(ndev)) {
-		rtl_link_chg_patch(tp);
-		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
-		pm_request_resume(d);
-	} else {
-		pm_runtime_idle(d);
-	}
-
-	phy_print_status(tp->phydev);
-}
-
 static int r8169_phy_connect(struct rtl8169_private *tp)
 {
-	struct phy_device *phydev = tp->phydev;
-	phy_interface_t phy_mode;
 	int ret;
 
-	phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
-		   PHY_INTERFACE_MODE_MII;
-
-	ret = phy_connect_direct(tp->dev, phydev, r8169_phylink_handler,
-				 phy_mode);
-	if (ret)
+	ret = phylink_connect_phy(tp->phylink, tp->phydev);
+	if (ret) {
+		netdev_err(tp->dev, "failed to connect phy\n");
 		return ret;
-
-	if (!tp->supports_gmii)
-		phy_set_max_speed(phydev, SPEED_100);
-
-	phy_attached_info(phydev);
+	}
 
 	return 0;
 }
@@ -5007,10 +5027,10 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	/* Clear all task flags */
 	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
-	phy_stop(tp->phydev);
+	phylink_stop(tp->phylink);
 
 	/* Reset SerDes PHY to bring down fiber link */
-	if (tp->sfp_mode)
+	if (tp->sfp_mode == RTL_SFP_8127_ATF)
 		rtl_sfp_reset(tp);
 
 	rtl8169_update_counters(tp);
@@ -5039,7 +5059,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
-	phy_start(tp->phydev);
+	phylink_start(tp->phylink);
 }
 
 static int rtl8169_close(struct net_device *dev)
@@ -5055,7 +5075,7 @@ static int rtl8169_close(struct net_device *dev)
 
 	free_irq(tp->irq, tp);
 
-	phy_disconnect(tp->phydev);
+	phylink_disconnect_phy(tp->phylink);
 
 	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
 			  tp->RxPhyAddr);
@@ -5112,9 +5132,11 @@ static int rtl_open(struct net_device *dev)
 	if (retval < 0)
 		goto err_release_fw_2;
 
-	retval = r8169_phy_connect(tp);
-	if (retval)
-		goto err_free_irq;
+	if (tp->sfp_mode == RTL_SFP_NONE || tp->sfp_mode == RTL_SFP_8127_ATF) {
+		retval = r8169_phy_connect(tp);
+		if (retval)
+			goto err_free_irq;
+	}
 
 	rtl8169_up(tp);
 	rtl8169_init_counter_offsets(tp);
@@ -5288,6 +5310,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 		r8169_remove_leds(tp->leds);
 
 	unregister_netdev(tp->dev);
+	if (tp->phylink)
+		phylink_destroy(tp->phylink);
 
 	if (tp->dash_type != RTL_DASH_NONE)
 		rtl8168_driver_stop(tp);
@@ -5474,10 +5498,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		return -EUNATCH;
 	}
 
-	tp->phydev->mac_managed_pm = true;
 	if (rtl_supports_eee(tp))
 		phy_support_eee(tp->phydev);
-	phy_support_asym_pause(tp->phydev);
 
 	/* mimic behavior of r8125/r8126 vendor drivers */
 	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
@@ -5599,6 +5621,152 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static void rtl_mac_link_down(struct phylink_config *config, unsigned int mode,
+			      phy_interface_t interface)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	pm_runtime_idle(tp_to_dev(tp));
+}
+
+static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
+			    unsigned int mode, phy_interface_t interface,
+			    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	struct device *d = tp_to_dev(tp);
+
+	rtl_link_chg_patch(tp, speed);
+
+	if (phydev)
+		rtl_enable_tx_lpi(tp, phydev->enable_tx_lpi);
+
+	pm_request_resume(d);
+}
+
+static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t interface)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	if (interface == PHY_INTERFACE_MODE_1000BASEX || interface == PHY_INTERFACE_MODE_SGMII)
+		return &tp->pcs;
+	return NULL;
+}
+
+static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
+			   const struct phylink_link_state *state)
+{
+}
+
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
+	if (bmsr == 0xffff || lpa == 0xffff) {
+		state->link = false;
+		return;
+	}
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
+static const struct phylink_mac_ops rtl_phylink_mac_ops = {
+	.mac_select_pcs = rtl_mac_select_pcs,
+	.mac_config = rtl_mac_config,
+	.mac_link_down  = rtl_mac_link_down,
+	.mac_link_up    = rtl_mac_link_up,
+};
+
+static const struct phylink_pcs_ops r8169_pcs_ops = {
+	.pcs_validate = rtl8169_pcs_validate,
+	.pcs_get_state = rtl8169_pcs_get_state,
+	.pcs_config = rtl8169_pcs_config,
+	.pcs_an_restart = rtl8169_pcs_an_restart,
+};
+
+static int rtl_init_phylink(struct rtl8169_private *tp)
+{
+	struct phylink *pl;
+	phy_interface_t phy_mode;
+
+	tp->phylink_config.dev = &tp->dev->dev;
+	tp->phylink_config.type = PHYLINK_NETDEV;
+	tp->phylink_config.mac_managed_pm = true;
+
+	tp->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+
+	switch (tp->sfp_mode) {
+	case RTL_SFP_8168_AF:
+		tp->pcs.ops = &r8169_pcs_ops;
+		tp->pcs.poll = true;
+		tp->phylink_config.default_an_inband = true;
+		phy_mode = PHY_INTERFACE_MODE_1000BASEX;
+		tp->phylink_config.mac_capabilities |= MAC_1000FD;
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX, tp->phylink_config.supported_interfaces);
+		break;
+	case RTL_SFP_8127_ATF:
+		phy_mode = PHY_INTERFACE_MODE_10GBASER;
+		tp->phylink_config.mac_capabilities |= MAC_10000FD;
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, tp->phylink_config.supported_interfaces);
+		break;
+	default:
+		phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII : PHY_INTERFACE_MODE_MII;
+		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
+		__set_bit(PHY_INTERFACE_MODE_MII, tp->phylink_config.supported_interfaces);
+		if (tp->supports_gmii) {
+			__set_bit(PHY_INTERFACE_MODE_GMII, tp->phylink_config.supported_interfaces);
+			tp->phylink_config.mac_capabilities |= MAC_1000FD;
+		}
+		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+			tp->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD | MAC_10000FD;
+		if (tp->mac_version == RTL_GIGA_MAC_VER_70)
+			tp->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD;
+		if (tp->mac_version >= RTL_GIGA_MAC_VER_61)
+			tp->phylink_config.mac_capabilities |= MAC_2500FD;
+	}
+
+	pl = phylink_create(&tp->phylink_config, tp_to_dev(tp)->fwnode,
+			    phy_mode, &rtl_phylink_mac_ops);
+	if (IS_ERR(pl))
+		return PTR_ERR(pl);
+
+	tp->phylink = pl;
+
+	return 0;
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct rtl_chip_info *chip;
@@ -5679,12 +5847,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -5788,13 +5951,21 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, tp);
 
-	rc = r8169_mdio_register(tp);
+	rc = rtl_init_phylink(tp);
 	if (rc)
 		return rc;
 
+	rc = r8169_mdio_register(tp);
+	if (rc) {
+		phylink_destroy(tp->phylink);
+		return rc;
+	}
+
 	rc = register_netdev(dev);
-	if (rc)
+	if (rc) {
+		phylink_destroy(tp->phylink);
 		return rc;
+	}
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
 		if (rtl_is_8125(tp))
-- 
2.43.0


