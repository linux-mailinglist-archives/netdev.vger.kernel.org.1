Return-Path: <netdev+bounces-295173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ar8aDkZUIWrODgEAu9opvQ
	(envelope-from <netdev+bounces-295173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789063F0EA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=JLzgZga7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295173-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A36303258F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019323A759C;
	Thu,  4 Jun 2026 10:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987723C343F;
	Thu,  4 Jun 2026 10:28:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568885; cv=none; b=ftd/hHJjQbVraaVpaU80y5fzXA9Q95MdYIP+X7sc9H3yb9lV2w+RKhfEtQHHfaIRFFZCjt+5ZLhWwMcSX7SQZ6r3qUUItZk+mP03iuPZkIhFC7c0w3sXm6+SPsczbyY3Ra18vZNyd+ZlCH3A7/q93lFEuR4N0BlPBCvdKcNKer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568885; c=relaxed/simple;
	bh=0scIp1g6jFaZ5acwxQ9HF90x7/u6sNALHQ1o2PoyU6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NerB1DRUsVNjVkBWszS5ksne5qMZbqbrvHRNAPc2D/Mu6Xipv2yhCUwggF+vzZLaWClWP5DQp8TwR+k9jv9g1rNvw39k4GGb4M3GPC8rebzceE4Aeo/7Hmqcw3hMOXEdT9FZyw3wk7oU5fVRBAlgGg8F450QA9sL8QAtmfWmd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=JLzgZga7; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654ARa652272242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780568857;
	bh=oufD+Qi8eVvo8qzHrks1StU5mOYjeV4zUSl0nl4KwG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JLzgZga7Wpv4PtLdnbLb6YfGzUIOv5B5JvRvMmT9rtuwSUnEztdWL8jnJsC2m+7oC
	 qAWILC0EiERFEP+aMVaKqQGGazdgIqNMIDpF/o3phFUYwk4F7wzbQ95h+EmBXtWWW3
	 s0Iw3BuE9JX1xT6iYNw/jXbiTZR2olQp+Z2lO+SDDIYW9IpQ5HV3wX/ze8DNW7EDn9
	 KehDhbwoZF4z1GAmKwz0O1vcETP81ACs8me59SEjSzAs6hjvZQyZVRqvbbf5xi/kC6
	 z2YILlahTD97IerYPt4rru8G8NQfzpVzjLj74hhIJPsCoESrN/MLDi5BWxc0jm+2zl
	 xh2UTyUq3dDQQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654ARa652272242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 18:27:36 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:27:36 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 18:27:36 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 7/7] r8169: support setting rx queue numbers via ethtool
Date: Thu, 4 Jun 2026 18:27:33 +0800
Message-ID: <20260604102733.1582-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260604102733.1582-1-javen_xu@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
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
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295173-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8789063F0EA

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

Changes in v7:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 125 ++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ceecf1a88739..1cd362b0afbe 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6225,6 +6225,129 @@ static void r8169_init_napi(struct rtl8169_private *tp)
 	}
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
@@ -6243,6 +6366,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
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


