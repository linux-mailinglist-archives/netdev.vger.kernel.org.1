Return-Path: <netdev+bounces-117589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8794E6E3
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47DE1F233F1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6311509BF;
	Mon, 12 Aug 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cKDMh6E3"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577714F9C9;
	Mon, 12 Aug 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444784; cv=none; b=h8DnOt8IKx86FPWNCZDgFAkM0XI9elRbjmT1cJth4sGbLOa+jhaoXptqhDurn5B2S1yDGrQ8F0org7g+79RriA+AzQJkPV+zH7rbgTiRrqRPsqeWv4LZU9vo4oj4xHSK68hZgm70fkwRYHMKZtecQmkyzvhItd+5NLSybkNOHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444784; c=relaxed/simple;
	bh=NJJ6EaTbXaBKYAhhu+0X+6iAshCtICJSVy+LFgHA2po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxBoMUJDkwisQYS4y0G4sJkJaXecc1Melw5D5wDAPlhE+9NoEAcJHNoHEkXDxA/GjWO+sugKujDKFN9GyEhnnBLpLpUFoDVYuCs0XdNxO+MvIDF/Dy5+XHnGoArudcTb1YTorFS6aVEgYhyPGCoFWLVC0glBPRcWXS1qckjIZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cKDMh6E3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47C6dIR913756663, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723444758; bh=NJJ6EaTbXaBKYAhhu+0X+6iAshCtICJSVy+LFgHA2po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cKDMh6E3lsvzIByRMHuCQwlLpqP0tRewRnaKVNp0FKF+vDOW+iPiHzE/sh8+zWrFd
	 +GQLg8AfnDYrJfXQaLI5ho6bwMIUmzcLAMCc+5u6pM3bx1L33MVgDw9vxqTnAd2i0D
	 /fBdyJo1hWvK4ANf/dMPEw5nETrjZQIP7IY2BqUY/FfrNg78geHcFOCAVowP8kP4Ei
	 r72EJvwnZfT4K98ZV1mCyh6xGC7sQhxrM1L/l5tCOozbZ7IuWQ+ljdMS8Oo/w5WeZW
	 wQXURSlFPkb8ureZof+RdjiUCB6X3EHcn6m3oWICdY5LCuL5Q+ueOUap8EFeOmd+bO
	 VkWAMtBmLSEqg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47C6dIR913756663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:39:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:39:19 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 12 Aug
 2024 14:39:18 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v27 07/13] rtase: Implement a function to receive packets
Date: Mon, 12 Aug 2024 14:35:33 +0800
Message-ID: <20240812063539.575865-8-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812063539.575865-1-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement rx_handler to read the information of the rx descriptor,
thereby checking the packet accordingly and storing the packet
in the socket buffer to complete the reception of the packet.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 70f52149c2ab..561fcaeb2b2b 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -435,6 +435,159 @@ static void rtase_rx_ring_clear(struct page_pool *page_pool,
 	}
 }
 
+static int rtase_fragmented_frame(u32 status)
+{
+	return (status & (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG)) !=
+	       (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG);
+}
+
+static void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff *skb,
+			  const union rtase_rx_desc *desc)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	/* rx csum offload */
+	if (((opts2 & RTASE_RX_V4F) && !(opts2 & RTASE_RX_IPF)) ||
+	    (opts2 & RTASE_RX_V6F)) {
+		if (((opts2 & RTASE_RX_TCPT) && !(opts2 & RTASE_RX_TCPF)) ||
+		    ((opts2 & RTASE_RX_UDPT) && !(opts2 & RTASE_RX_UDPF)))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+}
+
+static void rtase_rx_vlan_skb(union rtase_rx_desc *desc, struct sk_buff *skb)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	if (!(opts2 & RTASE_RX_VLAN_TAG))
+		return;
+
+	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+			       swab16(opts2 & RTASE_VLAN_TAG_MASK));
+}
+
+static void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *skb)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+
+	napi_gro_receive(&ivec->napi, skb);
+}
+
+static int rx_handler(struct rtase_ring *ring, int budget)
+{
+	union rtase_rx_desc *desc_base = ring->desc;
+	u32 pkt_size, cur_rx, delta, entry, status;
+	struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	union rtase_rx_desc *desc;
+	struct sk_buff *skb;
+	int workdone = 0;
+
+	cur_rx = ring->cur_idx;
+	entry = cur_rx % RTASE_NUM_DESC;
+	desc = &desc_base[entry];
+
+	do {
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & RTASE_DESC_OWN)
+			break;
+
+		/* This barrier is needed to keep us from reading
+		 * any other fields out of the rx descriptor until
+		 * we know the status of RTASE_DESC_OWN
+		 */
+		dma_rmb();
+
+		if (unlikely(status & RTASE_RX_RES)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Rx ERROR. status = %08x\n",
+					    status);
+
+			tp->stats.rx_errors++;
+
+			if (status & (RTASE_RX_RWT | RTASE_RX_RUNT))
+				tp->stats.rx_length_errors++;
+
+			if (status & RTASE_RX_CRC)
+				tp->stats.rx_crc_errors++;
+
+			if (dev->features & NETIF_F_RXALL)
+				goto process_pkt;
+
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+
+process_pkt:
+		pkt_size = status & RTASE_RX_PKT_SIZE_MASK;
+		if (likely(!(dev->features & NETIF_F_RXFCS)))
+			pkt_size -= ETH_FCS_LEN;
+
+		/* The driver does not support incoming fragmented frames.
+		 * They are seen as a symptom of over-mtu sized frames.
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			tp->stats.rx_dropped++;
+			tp->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+
+		dma_sync_single_for_cpu(&tp->pdev->dev,
+					ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		skb = build_skb(ring->data_buf[entry], PAGE_SIZE);
+		if (!skb) {
+			netdev_err(dev, "skb build failed\n");
+			tp->stats.rx_dropped++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+		ring->data_buf[entry] = NULL;
+
+		if (dev->features & NETIF_F_RXCSUM)
+			rtase_rx_csum(tp, skb, desc);
+
+		skb->dev = dev;
+		skb_put(skb, pkt_size);
+		skb_mark_for_recycle(skb);
+		skb->protocol = eth_type_trans(skb, dev);
+
+		if (skb->pkt_type == PACKET_MULTICAST)
+			tp->stats.multicast++;
+
+		rtase_rx_vlan_skb(desc, skb);
+		rtase_rx_skb(ring, skb);
+
+		dev_sw_netstats_rx_add(dev, pkt_size);
+
+skip_process_pkt:
+		workdone++;
+		cur_rx++;
+		entry = cur_rx % RTASE_NUM_DESC;
+		desc = ring->desc + sizeof(union rtase_rx_desc) * entry;
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx);
+
+	if (!delta && workdone)
+		netdev_info(dev, "no Rx buffer allocated\n");
+
+	ring->dirty_idx += delta;
+
+	if ((ring->dirty_idx + RTASE_NUM_DESC) == ring->cur_idx)
+		netdev_emerg(dev, "Rx buffers exhausted\n");
+
+	return workdone;
+}
+
 static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->rx_ring[idx];
-- 
2.34.1


