Return-Path: <netdev+bounces-291580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIJ+E9ZVFWqmUQcAu9opvQ
	(envelope-from <netdev+bounces-291580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:12:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0E5D241D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 567E53008D0B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9873CD8D7;
	Tue, 26 May 2026 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="QejnQFjH"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5D3B6BF1;
	Tue, 26 May 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783118; cv=none; b=ed5i64idq04Qi8rWjqCWClMkskPJrWvGhejtsrX6ow0KEH3V9J0vRuEa5Z8/xK2R7GCKbirPhfxCeA/urnw59YPBIfL0UAEUpMQdpH8boB64JlXgbgDCx6mvs/CaH+iSVB9fog54+WArCgILEwf+rzn2ZmIl/0ZzYrZOwkGkVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783118; c=relaxed/simple;
	bh=eqCqGJYrnj3iC652B2Z7LezNLPvZUE1KA8l9PK43+XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6kYEJ9GbsvkSoMXJENxdYsK8oCA1vUgCsik2cgZn9jAJi6vfzlz8ajgbKGyZmwmnYOtu6XRf0Az+AhZcuSoqrgfcf7lF/sfY1X6/FGQta/wkNv656jh6V9xu4BIji6rQtc4Iam9oYEMpi4Xn5jeysNw3ZAR8T5YlsJdPG10Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=QejnQFjH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64Q8BMl841615336, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779783082;
	bh=x7F67mPSSkLgJ0EQdQ6cxf1mBRFtH0btTcJ1DI/PsTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QejnQFjHhc5HgpwIarO56aEVLtV6OPjfIxuVW4/mMx2skVZEoyXT5/p3q9PQC/IvW
	 44ykswR3HgQKRUdFFpzb2L9ujFO58UsUvwCh8nCJmhNPqJpXavxu3fo525XJfSbXNx
	 UXNL3vbLidJC51ecruHS0wH+bfXi+BuiQrDdpiZT5zOMzqlFx676u+t3ZZuta7grnw
	 D56a8ObA9zZT8fInbal1eii9XgU8P+7T5sKglsN1i5mLafylmsoBLR8t2WPCF7fFGe
	 c8OeGlDn333hqpzHtJj/MklJGQoE69TyBB5SAl1T6BK9XSY22m1iwlDQeT1m5IobJK
	 qc1CGOe9gjUlA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64Q8BMl841615336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 May 2026 16:11:22 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 May 2026 16:11:21 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 26 May 2026 16:11:21 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v6 7/7] r8169: support setting rx queue numbers via ethtool
Date: Tue, 26 May 2026 16:11:17 +0800
Message-ID: <20260526081117.173-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260526081117.173-1-javen_xu@realsil.com.cn>
References: <20260526081117.173-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-291580-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 51C0E5D241D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch add support for changing rx queues by ethtool. We can set rx
1, 2, 4, 8 by ethtool -L eth1 rx num.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - remove rss_support and rss_enable
 - remove some zero-initialized
 - use kzalloc_objs instead of kcalloc

Changes in v5:
 - no changes

Changes in v6:
 - change subject of this patch
 - defer the assignment of tp->init_rx_desc_type until after
   rtl8169_down()
 - call netif_set_real_num_rx_queues() to synchronize the new rx queue
   number with networking core
---
 drivers/net/ethernet/realtek/r8169_main.c | 125 ++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index bf031f09437f..039465cd7ee1 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6253,6 +6253,129 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	devm_add_action_or_reset(&tp->pci_dev->dev, r8169_del_napi_action, tp);
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	ch->max_rx = tp->hw_supp_num_rx_queues;
+	ch->max_tx = 1;
+
+	ch->rx_count = tp->num_rx_rings;
+	ch->tx_count = 1;
+}
+
+static int rtl8169_realloc_rx(struct rtl8169_private *tp,
+			      struct rtl8169_rx_ring *new_rx,
+			      int new_count)
+{
+	int i, ret;
+
+	for (i = 0; i < new_count; i++) {
+		struct rtl8169_rx_ring *ring = &new_rx[i];
+
+		ring->rx_desc_array = dma_alloc_coherent(&tp->pci_dev->dev,
+							 R8169_RX_RING_BYTES,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+
+		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
+		ret = rtl8169_rx_fill(tp, ring);
+		if (ret) {
+			dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
+					  ring->rx_desc_array, ring->rx_phy_addr);
+			goto err_free;
+		}
+	}
+	return 0;
+
+err_free:
+	while (--i >= 0) {
+		rtl8169_rx_clear(tp, &new_rx[i]);
+		dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
+				  new_rx[i].rx_desc_array, new_rx[i].rx_phy_addr);
+	}
+	return ret;
+}
+
+static int rtl8169_set_channels(struct net_device *dev,
+				struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	bool if_running = netif_running(dev);
+	enum rx_desc_type old_rx_desc_type;
+	enum rx_desc_type new_desc_type;
+	struct rtl8169_rx_ring *new_rx;
+	int i, ret;
+
+	old_rx_desc_type = tp->init_rx_desc_type;
+
+	if (!rtl_hw_support_rss(tp)) {
+		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (ch->rx_count > R8169_MAX_RX_QUEUES)
+		return -EINVAL;
+
+	new_desc_type = ch->rx_count > 1 ? RX_DESC_TYPE_RSS : RX_DESC_TYPE_DEFAULT;
+
+	if (!if_running) {
+		tp->num_rx_rings = ch->rx_count;
+		tp->init_rx_desc_type = new_desc_type;
+		return 0;
+	}
+
+	netif_stop_queue(dev);
+	rtl8169_down(tp);
+
+	new_rx = kzalloc_objs(*new_rx, R8169_MAX_RX_QUEUES);
+	if (!new_rx)
+		return -ENOMEM;
+
+	tp->init_rx_desc_type = new_desc_type;
+	ret = rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
+	if (ret) {
+		tp->init_rx_desc_type = old_rx_desc_type;
+		kfree(new_rx);
+		return ret;
+	}
+
+	for (i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+	rtl8169_free_rx_desc(tp);
+
+	tp->num_rx_rings = ch->rx_count;
+
+	memset(tp->rx_ring, 0, sizeof(tp->rx_ring));
+	memcpy(tp->rx_ring, new_rx, sizeof(*new_rx) * ch->rx_count);
+
+	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++) {
+		if (ch->rx_count > 1)
+			tp->rss_data->rss_indir_tbl[i] =
+				ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+		else
+			tp->rss_data->rss_indir_tbl[i] = 0;
+	}
+
+	rtl_set_irq_mask(tp);
+
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+
+	ret = netif_set_real_num_rx_queues(dev, ch->rx_count);
+	if (ret)
+		netdev_warn(dev, "Failed to set real num rx queues\n");
+
+	kfree(new_rx);
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6271,6 +6394,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
+	.get_channels		= rtl8169_get_channels,
+	.set_channels		= rtl8169_set_channels,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= rtl8169_set_link_ksettings,
 	.get_ringparam		= rtl8169_get_ringparam,
-- 
2.43.0


