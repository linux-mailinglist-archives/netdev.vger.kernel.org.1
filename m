Return-Path: <netdev+bounces-111424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD7930E9A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9041F21194
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CFE1836D1;
	Mon, 15 Jul 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YrOJM6Vp"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784027457;
	Mon, 15 Jul 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721027938; cv=none; b=QBnOGLBVavWVaD6yhNNHEJr/i4MYJDacONMcpd21rj7jMuLBoprt07Blr3Ta6fve5qWS8ZzPA9/ScpdCtwargOGTYNpFGC2HHPQ8HLtdl1t+54CM2yQHHrQiIWVHWMFmozhVFdIQckiinzde/wTigy05dimqONZv/uqu7rVqyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721027938; c=relaxed/simple;
	bh=j2y4cHTRxoi5KN0sAMRPHwZpwlEWT9e6T5TRM4h0NxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYCLXQ05d2Ipf9UR+1qFeHBHeQhP0kKCsxmKic7jdXFzoc+MnHzn40DKTRm2fbSS34D1OptF2tf1H66vqitgqp5HxVehECN+KfupXB3vqLplryUbpju1K9PCSZCXWjkwbkjQD+1ctE1cO6hjPY5y7x18iJS0MSY/rJ/aZJ9UxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YrOJM6Vp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46F7IX6P03488609, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721027913; bh=j2y4cHTRxoi5KN0sAMRPHwZpwlEWT9e6T5TRM4h0NxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YrOJM6VpqebWwZqORlE1DTeEllESnbhcs4hy9G4aThsD5lYjTD7Je326kphvkCKIt
	 qwCmocmvvJ+x81nrU0rFs2XCu88rz1ko02+ARVJIPZJja5S2vY577H4/4Ax2CDDyd6
	 AypAR10t+1q30qZkd6aGOgV4NODljYwSKjIR/VqW4L1NBIPwY9CahW0WrtT8Wz7cY0
	 oG+fzWP8A/2Lxz0hUSUGvwZ5Xq4Wy/L4c82HIv7MXAmoNWqM6CA7Bl5uy7+5nCEDwJ
	 njOvLtX7ww35aejYgCuMaC+EE/sEmuL7IoPs2pqqJWAHmAE8lHGgyOke0zFW2CXxU+
	 85RdElpy59kug==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46F7IX6P03488609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:18:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 15:18:33 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jul
 2024 15:18:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v24 07/13] rtase: Implement a function to receive packets
Date: Mon, 15 Jul 2024 15:11:52 +0800
Message-ID: <20240715071158.110384-8-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715071158.110384-1-justinlai0215@realtek.com>
References: <20240715071158.110384-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement rx_handler to read the information of the rx descriptor,
thereby checking the packet accordingly and storing the packet
in the socket buffer to complete the reception of the packet.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 54bf683ae50e..8fd69d96219f 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -450,6 +450,151 @@ static void rtase_rx_ring_clear(struct rtase_ring *ring)
 	}
 }
 
+static int rtase_fragmented_frame(u32 status)
+{
+	return (status & (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG)) !=
+		(RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG);
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
+		/* make sure discriptor has been updated */
+		rmb();
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & RTASE_DESC_OWN)
+			break;
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
+		/* the driver does not support incoming fragmented
+		 * frames. they are seen as a symptom of over-mtu
+		 * sized frames
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			tp->stats.rx_dropped++;
+			tp->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			continue;
+		}
+
+		skb = ring->skbuff[entry];
+		dma_sync_single_for_cpu(&tp->pdev->dev,
+					ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		ring->skbuff[entry] = NULL;
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
+		prefetch(desc);
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx, 1);
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


