Return-Path: <netdev+bounces-302462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6OC/EWEOQmo8zgkAu9opvQ
	(envelope-from <netdev+bounces-302462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:19:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C5E6D646C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 08:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=WXYd+5SQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302462-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302462-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B608930102C0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 06:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5C39449C;
	Mon, 29 Jun 2026 06:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959638945D;
	Mon, 29 Jun 2026 06:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713432; cv=none; b=sb0D3MxSVgue2GMsQIo7zgfx4dpWeZAe8VGH7M3A/wRBc8gEJv/wUZyEFAAFu6npMjG1TpX74LVnsilC6aXPvbPsLcvGK0CIEWyADZUL1Bc3m4gESBvAzCPysYn/TYQbGW/xWNcnOUxMu1bAVDrxR0dO42AlfXQap0Nn8O6Lcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713432; c=relaxed/simple;
	bh=U9Uv7PJklips6wxMSwRI8yiHU+WuTV8fZuk7ECsIgAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQyl7bASBLDJtI87a0qxzhGGOWoaqUTtU3ZaLXndQ6tAq2Qw0HEccJZuDRoZIR18AgUeMg7RrrDrNyI+rTZDoljBz0ITS1MXC8aKxFj3YiSJJL9ukEwMMGJfwqDHWn2xKsicD8axOMj5sawCSrMNOeDAf5VvCb62JRjPVz2cDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WXYd+5SQ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T69Y1a83467455, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782713374;
	bh=gH5NH5/WSqDOzZKdu6EER+MDUtnXqhYFR3XXhYlybtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WXYd+5SQDtgzXoZEfUVshxlCpsCpIrmtSUtmV6+yFS/wMFJRoJ1rQItll4Nm7GN3f
	 k0Jbu3b937pgWwXv+93bPQTODnXpIqyd8hYat5BA3f9BuvOdtp8ySraQ0m+xk3DjbU
	 ngLUlJvmUk+T+kMTJvErvt5HDHz2HczJfa2L0fOh46obehSJnpZST5nQhczl0nISri
	 eVGfhLiYpEPkp0mDTI/KH8TJaTwRCQkuyzX0YF+dqeIXmRP8kQ674r8wRPYeyfwN+S
	 dx936b5Kn+M5x4qWgrp3t0oUEy8XSpDAySvtb+DmPa26x0j7ks7gx5r/fjWW2dm1up
	 34pRDpnQ61Dtg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T69Y1a83467455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:09:34 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:09:33 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:09:33 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 3/7] r8169: add support for phylink
Date: Mon, 29 Jun 2026 14:09:27 +0800
Message-ID: <20260629060931.1006-4-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302462-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48C5E6D646C

From: Javen Xu <javen_xu@realsil.com.cn>

Transfer old framework to phylink. Phylink can support fiber mode card
which can not get link status or link speed from standard phy registers.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - merge patch v1 3/6 and v1 4/6.
 - add helper rtl_mac_enable_tx_lpi(), rtl_mac_disable_tx_lpi()
   and rtl8169_get_lpi_caps()

Changes in v3:
 - use phylink_ethtool_set_pauseparam to set pause status when change
   mtu
 - replace phy_do_ioctl_running with rtl8169_ioctl
 - recover phy_mode according to tp->supports_gmii for 1G nics
---
 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 310 +++++++++++++++++-----
 2 files changed, 241 insertions(+), 70 deletions(-)

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
index ee33f01af6df..1d4a136519ab 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -28,6 +28,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
+#include <linux/phylink.h>
 #include <linux/prefetch.h>
 #include <linux/ipv6.h>
 #include <linux/unaligned.h>
@@ -777,7 +778,11 @@ struct rtl8169_private {
 	struct r8169_led_classdev *leds;
 
 	u32 ocp_base;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 	struct irq_domain *phy_irq_domain;
+	struct ethtool_pauseparam saved_pause;
+	bool jumbo_pause_saved;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -2256,7 +2261,7 @@ static int rtl8169_get_eee(struct net_device *dev, struct ethtool_keee *data)
 	if (!rtl_supports_eee(tp))
 		return -EOPNOTSUPP;
 
-	ret = phy_ethtool_get_eee(tp->phydev, data);
+	ret = phylink_ethtool_get_eee(tp->phylink, data);
 	if (ret)
 		return ret;
 
@@ -2272,7 +2277,7 @@ static int rtl8169_set_eee(struct net_device *dev, struct ethtool_keee *data)
 	if (!rtl_supports_eee(tp))
 		return -EOPNOTSUPP;
 
-	return phy_ethtool_set_eee(tp->phydev, data);
+	return phylink_ethtool_set_eee(tp->phylink, data);
 }
 
 static void rtl8169_get_ringparam(struct net_device *dev,
@@ -2303,13 +2308,8 @@ static void rtl8169_get_pauseparam(struct net_device *dev,
 				   struct ethtool_pauseparam *data)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
-	bool tx_pause, rx_pause;
 
-	phy_get_pause(tp->phydev, &tx_pause, &rx_pause);
-
-	data->autoneg = tp->phydev->autoneg;
-	data->tx_pause = tx_pause ? 1 : 0;
-	data->rx_pause = rx_pause ? 1 : 0;
+	phylink_ethtool_get_pauseparam(tp->phylink, data);
 }
 
 static int rtl8169_set_pauseparam(struct net_device *dev,
@@ -2320,9 +2320,7 @@ static int rtl8169_set_pauseparam(struct net_device *dev,
 	if (dev->mtu > ETH_DATA_LEN)
 		return -EOPNOTSUPP;
 
-	phy_set_asym_pause(tp->phydev, data->rx_pause, data->tx_pause);
-
-	return 0;
+	return phylink_ethtool_set_pauseparam(tp->phylink, data);
 }
 
 static void rtl8169_get_eth_mac_stats(struct net_device *dev,
@@ -2388,6 +2386,14 @@ static void rtl8169_get_eth_ctrl_stats(struct net_device *dev,
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
@@ -2419,6 +2425,13 @@ static int rtl8169_set_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+static int rtl8169_nway_reset(struct net_device *dev)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	return phylink_ethtool_nway_reset(tp->phylink);
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -2434,10 +2447,10 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_sset_count		= rtl8169_get_sset_count,
 	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
 	.get_ts_info		= ethtool_op_get_ts_info,
-	.nway_reset		= phy_ethtool_nway_reset,
+	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= rtl8169_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
 	.get_pause_stats	= rtl8169_get_pause_stats,
@@ -2630,6 +2643,7 @@ static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 static void rtl_jumbo_config(struct rtl8169_private *tp)
 {
 	bool jumbo = tp->dev->mtu > ETH_DATA_LEN;
+	struct ethtool_pauseparam pause;
 	int readrq = 4096;
 
 	if (jumbo && tp->mac_version >= RTL_GIGA_MAC_VER_17 &&
@@ -2661,13 +2675,48 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
 	if (pci_is_pcie(tp->pci_dev) && tp->supports_gmii)
 		pcie_set_readrq(tp->pci_dev, readrq);
 
-	/* Chip doesn't support pause in jumbo mode */
 	if (jumbo) {
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-				   tp->phydev->advertising);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				   tp->phydev->advertising);
-		phy_start_aneg(tp->phydev);
+		if (!tp->jumbo_pause_saved) {
+			struct ethtool_link_ksettings cmd;
+			bool adv_pause, adv_asym;
+
+			phylink_ethtool_get_pauseparam(tp->phylink, &tp->saved_pause);
+
+			if (tp->saved_pause.autoneg) {
+				phylink_ethtool_ksettings_get(tp->phylink, &cmd);
+				adv_pause = ethtool_link_ksettings_test_link_mode(&cmd,
+										  advertising,
+										  Pause);
+				adv_asym  = ethtool_link_ksettings_test_link_mode(&cmd,
+										  advertising,
+										  Asym_Pause);
+
+				if (adv_pause && !adv_asym) {
+					tp->saved_pause.rx_pause = 1;
+					tp->saved_pause.tx_pause = 1;
+				} else if (adv_pause && adv_asym) {
+					tp->saved_pause.rx_pause = 1;
+					tp->saved_pause.tx_pause = 0;
+				} else if (!adv_pause && adv_asym) {
+					tp->saved_pause.rx_pause = 0;
+					tp->saved_pause.tx_pause = 1;
+				} else {
+					tp->saved_pause.rx_pause = 0;
+					tp->saved_pause.tx_pause = 0;
+				}
+			}
+
+			tp->jumbo_pause_saved = true;
+		}
+
+		pause.autoneg = tp->saved_pause.autoneg;
+		pause.rx_pause = 0;
+		pause.tx_pause = 0;
+
+		phylink_ethtool_set_pauseparam(tp->phylink, &pause);
+	} else if (tp->jumbo_pause_saved) {
+		phylink_ethtool_set_pauseparam(tp->phylink, &tp->saved_pause);
+		tp->jumbo_pause_saved = false;
 	}
 }
 
@@ -2783,7 +2832,7 @@ static void rtl_prepare_power_down(struct rtl8169_private *tp)
 		rtl_ephy_write(tp, 0x19, 0xff64);
 
 	if (device_may_wakeup(tp_to_dev(tp))) {
-		phy_speed_down(tp->phydev, false);
+		phylink_speed_down(tp->phylink, false);
 		rtl_wol_enable_rx(tp);
 	}
 }
@@ -2835,6 +2884,16 @@ static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
 	RTL_W32(tp, 0x7c, val);
 }
 
+static int rtl8169_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -ENODEV;
+
+	return phylink_mii_ioctl(tp->phylink, ifr, cmd);
+}
+
 static void rtl_set_rx_mode(struct net_device *dev)
 {
 	u32 rx_mode = AcceptBroadcast | AcceptMyPhys | AcceptMulticast;
@@ -4143,11 +4202,17 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
+	if (netif_running(dev))
+		phylink_stop(tp->phylink);
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 	netdev_update_features(dev);
 	rtl_jumbo_config(tp);
 	rtl_set_eee_txidle_timer(tp);
 
+	if (netif_running(dev))
+		phylink_start(tp->phylink);
+
 	return 0;
 }
 
@@ -4933,9 +4998,6 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
 {
-	if (!rtl_supports_eee(tp))
-		return;
-
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_52:
 		/* Adjust EEE LED frequency */
@@ -4966,41 +5028,15 @@ static void rtl_enable_tx_lpi(struct rtl8169_private *tp, bool enable)
 	}
 }
 
-static void r8169_phylink_handler(struct net_device *ndev)
-{
-	struct rtl8169_private *tp = netdev_priv(ndev);
-	struct device *d = tp_to_dev(tp);
-
-	tp->speed = tp->phydev->speed;
-	if (netif_carrier_ok(ndev)) {
-		rtl_link_chg_patch(tp, tp->speed);
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
@@ -5011,7 +5047,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	/* Clear all task flags */
 	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
-	phy_stop(tp->phydev);
+	phylink_stop(tp->phylink);
 
 	/* Reset SerDes PHY to bring down fiber link */
 	if (tp->sfp_mode)
@@ -5043,7 +5079,7 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
-	phy_start(tp->phydev);
+	phylink_start(tp->phylink);
 }
 
 static int rtl8169_close(struct net_device *dev)
@@ -5059,7 +5095,7 @@ static int rtl8169_close(struct net_device *dev)
 
 	free_irq(tp->irq, tp);
 
-	phy_disconnect(tp->phydev);
+	phylink_disconnect_phy(tp->phylink);
 
 	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
 			  tp->RxPhyAddr);
@@ -5194,8 +5230,11 @@ static int rtl8169_runtime_resume(struct device *dev)
 	rtl_rar_set(tp, tp->dev->dev_addr);
 	__rtl8169_set_wol(tp, tp->saved_wolopts);
 
-	if (tp->TxDescArray)
+	if (tp->TxDescArray) {
+		rtnl_lock();
 		rtl8169_up(tp);
+		rtnl_unlock();
+	}
 
 	netif_device_attach(tp->dev);
 
@@ -5292,6 +5331,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 		r8169_remove_leds(tp->leds);
 
 	unregister_netdev(tp->dev);
+	if (tp->phylink)
+		phylink_destroy(tp->phylink);
 
 	if (tp->dash_type != RTL_DASH_NONE)
 		rtl8168_driver_stop(tp);
@@ -5314,7 +5355,7 @@ static const struct net_device_ops rtl_netdev_ops = {
 	.ndo_fix_features	= rtl8169_fix_features,
 	.ndo_set_features	= rtl8169_set_features,
 	.ndo_set_mac_address	= rtl_set_mac_address,
-	.ndo_eth_ioctl		= phy_do_ioctl_running,
+	.ndo_eth_ioctl		= rtl8169_ioctl,
 	.ndo_set_rx_mode	= rtl_set_rx_mode,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= rtl8169_netpoll,
@@ -5520,16 +5561,6 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 		return -EUNATCH;
 	}
 
-	tp->phydev->mac_managed_pm = true;
-	if (rtl_supports_eee(tp))
-		phy_support_eee(tp->phydev);
-	phy_support_asym_pause(tp->phydev);
-
-	/* mimic behavior of r8125/r8126 vendor drivers */
-	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
-		phy_disable_eee_mode(tp->phydev,
-				     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
-
 	/* PHY will be woken up in rtl_open() */
 	phy_suspend(tp->phydev);
 
@@ -5645,6 +5676,137 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static void rtl_mac_link_down(struct phylink_config *config, unsigned int mode,
+			      phy_interface_t interface)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	tp->speed = SPEED_UNKNOWN;
+	pm_runtime_idle(tp_to_dev(tp));
+}
+
+static void rtl_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
+			    unsigned int mode, phy_interface_t interface,
+			    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+	struct device *d = tp_to_dev(tp);
+
+	tp->speed = speed;
+	rtl_link_chg_patch(tp, speed);
+
+	pm_request_resume(d);
+}
+
+static struct phylink_pcs *rtl_mac_select_pcs(struct phylink_config *config,
+					      phy_interface_t interface)
+{
+	return NULL;
+}
+
+static void rtl_mac_config(struct phylink_config *config, unsigned int mode,
+			   const struct phylink_link_state *state)
+{
+}
+
+static void rtl_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	rtl_enable_tx_lpi(tp, false);
+}
+
+static int rtl_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
+{
+	struct rtl8169_private *tp = container_of(config, struct rtl8169_private, phylink_config);
+
+	if (!rtl_supports_eee(tp))
+		return -EOPNOTSUPP;
+
+	rtl_enable_tx_lpi(tp, true);
+
+	return 0;
+}
+
+static const struct phylink_mac_ops rtl_phylink_mac_ops = {
+	.mac_select_pcs = rtl_mac_select_pcs,
+	.mac_config = rtl_mac_config,
+	.mac_link_down  = rtl_mac_link_down,
+	.mac_link_up    = rtl_mac_link_up,
+	.mac_disable_tx_lpi = rtl_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = rtl_mac_enable_tx_lpi,
+};
+
+static unsigned long rtl8169_get_lpi_caps(struct rtl8169_private *tp)
+{
+	unsigned long caps = 0;
+
+	if (!rtl_supports_eee(tp))
+		return 0;
+
+	caps |= MAC_100FD | MAC_1000FD;
+
+	/* mimic behavior of r8125/r8126 vendor drivers
+	 * RTL_GIGA_MAC_VER_61 doesn't support 2.5G eee
+	 */
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_63)
+		caps |= MAC_2500FD;
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_70)
+		caps |= MAC_5000FD;
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		caps |= MAC_10000FD;
+
+	return caps;
+}
+
+static int rtl_init_phylink(struct rtl8169_private *tp)
+{
+	struct phylink *pl;
+	phy_interface_t phy_mode;
+
+	tp->phylink_config.dev = &tp->dev->dev;
+	tp->phylink_config.type = PHYLINK_NETDEV;
+	tp->phylink_config.mac_managed_pm = true;
+	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
+	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+
+	if (tp->sfp_mode) {
+		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
+		tp->phylink_config.mac_capabilities |= MAC_10000FD;
+	} else {
+		phy_mode = PHY_INTERFACE_MODE_INTERNAL;
+		tp->phylink_config.mac_capabilities |= MAC_10 | MAC_100;
+
+		if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+			tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_2500FD |
+							       MAC_5000FD | MAC_10000FD;
+		else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
+			tp->phylink_config.mac_capabilities |= MAC_1000FD |
+							       MAC_2500FD | MAC_5000FD;
+		else if (tp->mac_version >= RTL_GIGA_MAC_VER_61)
+			tp->phylink_config.mac_capabilities |= MAC_1000FD | MAC_2500FD;
+		else
+			if (tp->supports_gmii)
+				tp->phylink_config.mac_capabilities |= MAC_1000FD;
+
+		if (tp->mac_version < RTL_GIGA_MAC_VER_61)
+			phy_mode = tp->supports_gmii ? PHY_INTERFACE_MODE_GMII :
+				   PHY_INTERFACE_MODE_MII;
+		else
+			phy_mode = PHY_INTERFACE_MODE_INTERNAL;
+	}
+
+	__set_bit(phy_mode, tp->phylink_config.supported_interfaces);
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
@@ -5835,13 +5997,21 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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


