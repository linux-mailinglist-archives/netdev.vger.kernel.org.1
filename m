Return-Path: <netdev+bounces-88193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019728A63CA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FB61C2176F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A16BFC2;
	Tue, 16 Apr 2024 06:33:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA593D0AF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249182; cv=none; b=hX1cIaZc+kaZTsysSFFodspeEv+OIcynKC4UiiDj9FS9J2ZYrFwMlWhXsJFyq0Az+2K83N/iMbDS+eCxRBOmK7AsJTi7SLxLV92nzDzF9ybSAKNRQeZAl+qo6ZQXcZsvJvQgTVUiAWCqvswqwZclqE498dZmKhPECSsL67zUjNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249182; c=relaxed/simple;
	bh=cMtoJuC6mXMJ6I9XWtS+fLSnKo5EA6VwtZfnWXVhHVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LgPTpD3ttYZRF9onjH30nTHCUdmgfocORQMjMTihFkuMPPAd/kkMesy37z5lNrnmoTifJ0NtaV2jurZ5oAvxB2iPkU3TjMPJH55tr4zdmuOCiCa8MyF3lcTOs79KRSf1tmbf7lvZG4713T86fk0kgSYA6kXylteps9TxBqcz+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1713249020tcech5fe
X-QQ-Originating-IP: kDF1XfxnlAyc7CQjLZvD7ao+nLfimiy6et72c4tXpqY=
Received: from lap-jiawenwu.trustnetic.com ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 14:30:19 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: zA8e95lMvfBVGbMhaDo6YOp9xZoUCZNiD1mnA2PypbB2pCx9nKbkQ6v39dzFc
	Oo3IOL8U5Mdn4DrNG8gfrB38IgMQFZtfnR+nQH5ofHMrzIWMTgXfQ8cZkGHkG904PPdJAfx
	Vhjl55y44nXOSBVd+xrkm10nbuLHFFOUNa8cboMIIGixDSD7DBybhFYRa/RBWz/y9PKnTlN
	UrlhRNLTayH1y5HIAqxTgKUtLqNSYlA4HgdHCIlfWUD06T5hWT0nPFXxNvJaD10iT9hkwrb
	Dpn3cxS8hduC+7+o05wbP5ijjyiZigdqTR9OK2AzSO0f7ltcqOEpOHVDt+3SbrTlxduLece
	5rH2Qv0zv+fwKD3GE5meRPG/H7pZ8lXGet24WGafIfglnVP6sH558A9eh6OuENgJVeyKKUG
	kUD77qVmc4o=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2951019120719600918
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 4/5] net: wangxun: change NETIF_F_HW_VLAN_STAG_* to fixed features
Date: Tue, 16 Apr 2024 14:29:51 +0800
Message-Id: <20240416062952.14196-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240416062952.14196-1-jiawenwu@trustnetic.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Because the hardware doesn't support the configuration of VLAN STAG,
remove NETIF_F_HW_VLAN_STAG_* in netdev->features, and set their state
to be consistent with NETIF_F_HW_VLAN_CTAG_*.

Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 22 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  6 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  5 ++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 5c511feb97f2..40612cd29f1b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2701,6 +2701,28 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features)
+{
+	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		features |= NETIF_F_HW_VLAN_STAG_FILTER;
+	else
+		features &= ~NETIF_F_HW_VLAN_STAG_FILTER;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		features |= NETIF_F_HW_VLAN_STAG_RX;
+	else
+		features &= ~NETIF_F_HW_VLAN_STAG_RX;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_TX)
+		features |= NETIF_F_HW_VLAN_STAG_TX;
+	else
+		features &= ~NETIF_F_HW_VLAN_STAG_TX;
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
index fdd6b4f70b7a..12e47a1056d7 100644
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
@@ -584,7 +585,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 			   NETIF_F_RXHASH | NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_SCTP_CRC | NETIF_F_TSO_MANGLEID;
 	netdev->vlan_features |= netdev->features;
-	netdev->features |= NETIF_F_IPV6_CSUM | NETIF_F_VLAN_FEATURES;
+	netdev->features |= NETIF_F_IPV6_CSUM;
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
+			    NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_TX;
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features | NETIF_F_RXALL;
 	netdev->hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bd4624d14ca0..af0c548e52b0 100644
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
@@ -547,7 +548,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_SCTP_CRC;
 	netdev->vlan_features |= netdev->features | NETIF_F_TSO_MANGLEID;
 	netdev->hw_enc_features |= netdev->vlan_features;
-	netdev->features |= NETIF_F_VLAN_FEATURES;
+	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
+			    NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_TX;
 	/* copy netdev features into list of user selectable features */
 	netdev->hw_features |= netdev->features | NETIF_F_RXALL;
 	netdev->hw_features |= NETIF_F_NTUPLE | NETIF_F_HW_TC;
-- 
2.27.0


