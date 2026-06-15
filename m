Return-Path: <netdev+bounces-299296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGs0KRpuL2pJAQUAu9opvQ
	(envelope-from <netdev+bounces-299296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:14:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB1682FBE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:14:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=PfUZcr3N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299296-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28C573001381
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33296276038;
	Mon, 15 Jun 2026 03:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551726738B;
	Mon, 15 Jun 2026 03:14:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493269; cv=none; b=VsHl7Q/UdBtsN7Bb8D6ZDmvxL+JTTvjJPqTmFJ2M8Fq4O7bTzZR6D8X7zh1BG1FhdIipMDl5cR9QnhxEyHNomIyl8GMLIdk2pdvLL/n8ap3VQZohDy/80w8H1Y5biJVf7kQVG7tME/rZ3aK99JjJXF33mgryRIy9jZ/vXda6vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493269; c=relaxed/simple;
	bh=SDW+1aca+i8yDrqxFwq2oaZia/1LeDbXSozLBKAhGDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbfD1Rfpi6Wfln+WCfqIaoNdshw7GXdlb6GI/59/fjA1UyxUzOQkoFYvyElm5wMni3zSGLF7NNz9z0J/QjtsdlWgE/Vr3C3Jn/qf/kuurYZnggzKLOc22/0CZDPyGc+JSBan6z/5r/hoGuDPgZBv9cBOPMr5rvF+dFIVwgSWRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=PfUZcr3N; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F3DpQxA457249, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781493231;
	bh=wrj5UsQq6LyDhfuIzqwXJb1M1z4Wiycs5p67n8lSfcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PfUZcr3NPnGItFP4JvdP8N43Y+qaPMLx1yGIwsCkLWEbab7Qb+A1wDuu72LPL03C7
	 FIkK8JP1QDhh7ecphmn25vM8PZizECgpA/wOoJCnBdAGeMGvGF/P3yNUYnFSIl7yc5
	 ocpOJNcBjKNep8QEmlkPSkDERYy7A17jRYgWvYkMgka7Zi0+QIHfJsYWyZIoj+gfju
	 m7uSuy0POPYAfqycL9OAWe6u0IYnbxK097rFli/yOeO0QUXLy/GRUyTU3c5+wecQF5
	 vxbuJr5m6RT4CZcXuCzk81ZYCXKQ+q9RI+wpnOGz/+mzMpdb7it3YdBJpQJ52uZVd4
	 sNVfpBYloO8NQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F3DpQxA457249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 11:13:51 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 11:13:49 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 11:13:49 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 7/7] r8169: support setting rx queue numbers via ethtool
Date: Mon, 15 Jun 2026 11:13:45 +0800
Message-ID: <20260615031345.548-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260615031345.548-1-javen_xu@realsil.com.cn>
References: <20260615031345.548-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299296-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14BB1682FBE

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
 
Changes in v8:
 - if dev is not running, updating tp->rss_data->rss_indir_tbl and
   calling netif_set_real_num_rx_queue when change rx queue number
 - if system does not provide enough irq_nvecs, return -EINVAL
 - malloc new_rx before device down
---
 drivers/net/ethernet/realtek/r8169_main.c | 146 +++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e43366468101..c893f0e3ecff 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2790,11 +2790,16 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
-static void rtl8169_init_rss(struct rtl8169_private *tp)
+static void rtl8169_set_rss_indir_tbl(struct rtl8169_private *tp,
+				      unsigned int num_rx_rings)
 {
 	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
-		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
+}
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
 	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
 }
 
@@ -6228,6 +6233,141 @@ static void r8169_init_napi(struct rtl8169_private *tp)
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
+	if (ch->rx_count > R8169_MAX_RX_QUEUES || !is_power_of_2(ch->rx_count) ||
+	    tp->irq_nvecs < get_min_irq_nvecs(tp))
+		return -EINVAL;
+
+	if (ch->rx_count == tp->num_rx_rings)
+		return 0;
+
+	new_desc_type = ch->rx_count > 1 ? RX_DESC_TYPE_RSS : RX_DESC_TYPE_DEFAULT;
+
+	if (!if_running) {
+		ret = netif_set_real_num_rx_queues(dev, ch->rx_count);
+		if (ret)
+			return ret;
+
+		tp->num_rx_rings = ch->rx_count;
+		tp->init_rx_desc_type = new_desc_type;
+
+		rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
+		rtl_set_irq_mask(tp);
+		return 0;
+	}
+
+	new_rx = kzalloc_objs(*new_rx, R8169_MAX_RX_QUEUES);
+	if (!new_rx)
+		return -ENOMEM;
+
+	netif_stop_queue(dev);
+	rtl8169_down(tp);
+
+	ret = netif_set_real_num_rx_queues(dev, ch->rx_count);
+	if (ret)
+		goto err_up;
+
+	tp->init_rx_desc_type = new_desc_type;
+
+	ret = rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
+	if (ret)
+		goto err_reset;
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
+	rtl8169_set_rss_indir_tbl(tp, tp->num_rx_rings);
+	rtl_set_irq_mask(tp);
+
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+
+	kfree(new_rx);
+
+	return 0;
+
+err_reset:
+	netif_set_real_num_rx_queues(dev, tp->num_rx_rings);
+	tp->init_rx_desc_type = old_rx_desc_type;
+err_up:
+	rtl8169_up(tp);
+	netif_start_queue(dev);
+	kfree(new_rx);
+
+	return ret;
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6246,6 +6386,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
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


