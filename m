Return-Path: <netdev+bounces-96283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E28C4CFA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0D21F22600
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DAB3A29C;
	Tue, 14 May 2024 07:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA73A268
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671551; cv=none; b=hIbRJ85yJhSiesC7eXUfBHw2rgPty1vdTinn7aD7ZUH4y3yLEYynqZ0e3VRUrpBZ7y1R+Wo2sjmMXLzjbEZzu8SPvtz7Ea8seFJ+VaxZCSvbkzbJ0zLzpRS6EGM3Ei4/ogI2N05SwnM/cPYhcoUt932swS6KoMXtPmE4h3ywShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671551; c=relaxed/simple;
	bh=O3pq106+FRDHyt5ET9Oad08z+4FUubPVUqIp/BxLcb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDNhpCDo4EYDVOgkoPL4R0cGUKO7k+0PdMdK78B0By1oFJQuh0rAjJUXRrk1Y63urQXeGbpvHJoS/7oqa6B0H+/TZ+jonvKtCP1UjgWnvtx1F6u1WY9WLLd1grvJPapE0X/ybvgpfbiFp8YZ4iUncEiAVqqdr1EFDQNbcMJPteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1715671425t3d5px
X-QQ-Originating-IP: sa0OX1RUMgbkENcrrVlCkXbzvu3wFvXPakalYH7PqAE=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 May 2024 15:23:43 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: ExN6mnmVozCXbjx44Dwl9r1yEYhcCyfTs4A2Ufdl0W3IpvxXup0l9rl5hRFcE
	InPpiGRuTNEBz88UE4cidggJ5bqEWXgvv5nRJCyH7jEiWAYXR1HCBe90bR1n1cz3CI3gRYj
	Xp1DgG31I67ZvnAMSpeKhTiAJqzkvD5zutYDmer1SZ8npu5MaTAWz+i8kVihAG5K2BGX3a1
	7GfhMxBj7qCRnCTkO22HKHKZXaY4ZktWuQzD47a4wjPDOafu47i+PkA0aLprLUgj92tHXa2
	joeSmwAbH3/E4ikVpJg8Y/yJ5DDLtvmcfbT0DKJHBEO2dO+SkTYiU5hP+DwaQohfTEPMKOw
	aOkV4jvWwxcWlL6cvZ24kqbjQjx+bTPL8Xff6apD8oyJI+esWI6Qbkls2TEDMtAC8p5GnFv
	rRgBTmJ7rgM=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 806909722921880411
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 2/3] net: wangxun: match VLAN CTAG and STAG features
Date: Tue, 14 May 2024 15:23:29 +0800
Message-Id: <20240514072330.14340-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240514072330.14340-1-jiawenwu@trustnetic.com>
References: <20240514072330.14340-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hardware requires VLAN CTAG and STAG configuration always matches. And
whether VLAN CTAG or STAG changes, the configuration needs to be changed
as well.

Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 61 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 667a5675998c..28599e03cf4e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2701,6 +2701,67 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+#define NETIF_VLAN_STRIPPING_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
+					 NETIF_F_HW_VLAN_STAG_RX)
+
+#define NETIF_VLAN_INSERTION_FEATURES	(NETIF_F_HW_VLAN_CTAG_TX | \
+					 NETIF_F_HW_VLAN_STAG_TX)
+
+#define NETIF_VLAN_FILTERING_FEATURES	(NETIF_F_HW_VLAN_CTAG_FILTER | \
+					 NETIF_F_HW_VLAN_STAG_FILTER)
+
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features)
+{
+	netdev_features_t changed = netdev->features ^ features;
+	struct wx *wx = netdev_priv(netdev);
+
+	if (changed & NETIF_VLAN_STRIPPING_FEATURES) {
+		if (features & NETIF_F_HW_VLAN_CTAG_RX &&
+		    features & NETIF_F_HW_VLAN_STAG_RX) {
+			features |= NETIF_VLAN_STRIPPING_FEATURES;
+		} else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) &&
+			 !(features & NETIF_F_HW_VLAN_STAG_RX)) {
+			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
+		} else {
+			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_STRIPPING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN stripping must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_INSERTION_FEATURES) {
+		if (features & NETIF_F_HW_VLAN_CTAG_TX &&
+		    features & NETIF_F_HW_VLAN_STAG_TX) {
+			features |= NETIF_VLAN_INSERTION_FEATURES;
+		} else if (!(features & NETIF_F_HW_VLAN_CTAG_TX) &&
+			 !(features & NETIF_F_HW_VLAN_STAG_TX)) {
+			features &= ~NETIF_VLAN_INSERTION_FEATURES;
+		} else {
+			features &= ~NETIF_VLAN_INSERTION_FEATURES;
+			features |= netdev->features & NETIF_VLAN_INSERTION_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN insertion must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_FILTERING_FEATURES) {
+		if (features & NETIF_F_HW_VLAN_CTAG_FILTER &&
+		    features & NETIF_F_HW_VLAN_STAG_FILTER) {
+			features |= NETIF_VLAN_FILTERING_FEATURES;
+		} else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+			 !(features & NETIF_F_HW_VLAN_STAG_FILTER)) {
+			features &= ~NETIF_VLAN_FILTERING_FEATURES;
+		} else {
+			features &= ~NETIF_VLAN_FILTERING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_FILTERING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN filtering must be either both on or both off.");
+		}
+	}
+
+	return features;
+}
+EXPORT_SYMBOL(wx_fix_features);
+
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index ec909e876720..c41b29ea812f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -30,6 +30,8 @@ int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index fdd6b4f70b7a..e894e01d030d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -499,6 +499,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bd4624d14ca0..b3c0058b045d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -428,6 +428,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


