Return-Path: <netdev+bounces-282256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UByCKqyu8WmwjgEAu9opvQ
	(envelope-from <netdev+bounces-282256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15B4903D3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35DE3035A81
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF633A3E85;
	Wed, 29 Apr 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="nI/QwWKl"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CE3A256F;
	Wed, 29 Apr 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446505; cv=none; b=E5xgUPuJjXLYp5SZcdhbQQzf6trpShsjssG5s4tm9Ktj3rIGeIqXuQOhWb2HJiK9C1fe/VxqhiRLrlWz4OAcbLEiaDdoFBuM3nFlwbPx5RpiSJlPw9qZhlVYAbhCntOtrftOrAWe8C++5TfP2j8VUrASXh35Q0YiMwSNiCcbNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446505; c=relaxed/simple;
	bh=xguju6C70W7JLmPatum2r9gfengM/ij4LU+KO3Es6og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+LPX2nQc05shW3STgJ3ZrFuz8fITtPZpIsKrRmzotWWHXtFZJ9CHJ3Qvc+JqLpe4npv81Yk5+df7Yzp6u1mOt2MmqulNszCYF8eQr6xzmdoYASzUuz1dGuCsaQvHFDJGwa2vLPrD5h640jNkcYAPK43UgfRPS5zKt6PH0fKbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=nI/QwWKl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77svdE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446475;
	bh=LULWFLg0qvfDrJJsgAe+NiyiSqd1QUHQ59/p0QCGKG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nI/QwWKlgvAxhCoKpL1tbUSWH0QZtkBvl+wD79z06cxjgw6Pk6SwDErDrAd9ej+2n
	 bAAuKAQiLIOnsyLfOoAdlkcJ3oqESCIJA/vLcHgy8NBTepPbqn3IHBgu17QZi80vY3
	 GoG3IUSuLZ1/8rgpROclMmTp1GwHnO3K94+/qg6JSvRSLbPjx3InGSmUPxTwm02Wf1
	 8mdBtsUnB7bzcgoqMkbUlyJPBQlzmIWTeqSiytIaeC2epsNc0KKSq3HkCjlTHi8asR
	 +igmPi1fR6L/HGpQMHQZRa0p/r+j+jjYWwQzbcNy3WBCTSkk4dZGh5hChYtM8zHF0E
	 TP0aF1W4+SRCA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77svdE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:55 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:54 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:54 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2] r8169: add support for ethtool
Date: Wed, 29 Apr 2026 15:07:50 +0800
Message-ID: <20260429070750.1477-9-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260429070750.1477-1-javen_xu@realsil.com.cn>
References: <20260429070750.1477-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 0C15B4903D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282256-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Javen Xu <javen_xu@realsil.com.cn>

This patch add support for changing rx queues by ethtool. We can set rx
1, 2, 4, 8 by ethtool -L eth1 rx num.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
changes in v2:
 - try to alloc memory for rx ring first. If failed, just roll back.
   Remove rtl_open and rtl8169_close. 
---
 drivers/net/ethernet/realtek/r8169_main.c | 133 ++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ea91cedc3100..7375d9e2e476 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6375,6 +6375,137 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_get_channels(struct net_device *dev,
+				 struct ethtool_channels *ch)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	ch->max_rx = tp->hw_supp_num_rx_queues;
+	ch->max_tx = 1;
+	ch->max_other = 0;
+	ch->max_combined = 0;
+
+	ch->rx_count = tp->num_rx_rings;
+	ch->tx_count = 1;
+	ch->other_count = 0;
+	ch->combined_count = 0;
+}
+
+static int rtl8169_realloc_rx(struct rtl8169_private *tp,
+			      struct rtl8169_rx_ring *new_rx,
+			      int new_count)
+{
+	int i, ret;
+
+	new_rx[0].rdsar_reg = RxDescAddrLow;
+	for (i = 1; i < new_count; i++)
+		new_rx[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
+
+	for (i = 0; i < new_count; i++)
+		new_rx[i].num_rx_desc = NUM_RX_DESC;
+
+	for (i = 0; i < new_count; i++) {
+		struct rtl8169_rx_ring *ring = &new_rx[i];
+
+		ring->rx_desc_alloc_size = (NUM_RX_DESC + 1) * sizeof(struct RxDesc);
+		ring->rx_desc_array = dma_alloc_coherent(&tp->pci_dev->dev,
+							 ring->rx_desc_alloc_size,
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
+			dma_free_coherent(&tp->pci_dev->dev, ring->rx_desc_alloc_size,
+					  ring->rx_desc_array, ring->rx_phy_addr);
+			goto err_free;
+		}
+	}
+	return 0;
+
+err_free:
+	while (--i >= 0) {
+		rtl8169_rx_clear(tp, &new_rx[i]);
+		dma_free_coherent(&tp->pci_dev->dev, new_rx[i].rx_desc_alloc_size,
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
+	struct rtl8169_rx_ring *new_rx;
+	u8 old_tx_desc_type = tp->init_rx_desc_type;
+	u8 new_desc_type;
+	bool new_rss_enable;
+	int i, ret;
+
+	if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
+		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!(tp->features & RTL_VEC_MAP_ENABLE))
+		return -EINVAL;
+
+	new_rss_enable = (ch->rx_count > 1 && tp->rss_support);
+	new_desc_type = new_rss_enable ? RX_DESC_RING_TYPE_RSS : RX_DESC_RING_TYPE_DEFAULT;
+	tp->init_rx_desc_type = new_desc_type;
+
+	if (!if_running) {
+		tp->num_rx_rings = ch->rx_count;
+		tp->rss_enable = new_rss_enable;
+		return 0;
+	}
+
+	new_rx = kcalloc(R8169_MAX_RX_QUEUES, sizeof(*new_rx), GFP_KERNEL);
+	if (!new_rx)
+		return -ENOMEM;
+
+	ret = rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
+	if (ret) {
+		kfree(new_rx);
+		tp->init_rx_desc_type = old_tx_desc_type;
+		return ret;
+	}
+
+	netif_stop_queue(dev);
+	rtl8169_down(tp);
+
+	for (i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+	rtl8169_free_rx_desc(tp);
+
+	tp->num_rx_rings = ch->rx_count;
+	tp->rss_enable = new_rss_enable;
+
+	memset(tp->rx_ring, 0, sizeof(tp->rx_ring));
+	memcpy(tp->rx_ring, new_rx, sizeof(*new_rx) * ch->rx_count);
+
+	for (i = 0; i < tp->hw_supp_indir_tbl_entries; i++) {
+		if (tp->rss_enable)
+			tp->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+		else
+			tp->rss_indir_tbl[i] = 0;
+	}
+
+	rtl_set_irq_mask(tp);
+
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+
+	kfree(new_rx);
+
+	return 0;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6393,6 +6524,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
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


