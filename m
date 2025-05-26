Return-Path: <netdev+bounces-193384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0042AC3BB3
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49184189484F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC41E9B1A;
	Mon, 26 May 2025 08:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DF1E9B0B;
	Mon, 26 May 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248085; cv=none; b=qB5TbNyLdoLhQIcmAIP23UmqYFZXHsQBUdY00oJA9h6qAsPXOe5IGjKW38yAmd1ZGAyVeDa1xM04GQ0rMYE3haPo2LgJxvz+uw0CVPNYuMMdUCVA8PmvhsHi3y+wyCCaaxkmbah4OnIGSuD/7jk9caRg2e4oGg5O0YQnkunQ84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248085; c=relaxed/simple;
	bh=MLH7gSBcJPJZeIiOZ7z+35hYV1Sh5TAL4nPmBWlEf5I=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=nPsHemywv216apo0+XNf3CC/f7hTUgB5e0ZRy3XPJMXo5HPKKKXhbMEF+o6y25UGHjtlVWNm88Z1+9FLaHAqxq5DfvHRqCv/L2GQTVOQlFxCQ1yaNzmpUgW4AjGcNbC5jOtWN18TsG8c2pJpBcZBdbaWYAvMCUOWFkL9+T6e/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b5TRB5Hx7z8RTZN;
	Mon, 26 May 2025 16:27:50 +0800 (CST)
Received: from njy2app08.zte.com.cn ([10.40.13.206])
	by mse-fl2.zte.com.cn with SMTP id 54Q8RiBX001679;
	Mon, 26 May 2025 16:27:44 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 26 May 2025 16:27:46 +0800 (CST)
Date: Mon, 26 May 2025 16:27:46 +0800 (CST)
X-Zmail-TransId: 2af968342602255-1d940
X-Mailer: Zmail v1.0
Message-ID: <20250526162746319JPXpL0xRJ-n7onnZApOiV@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <davem@davemloft.net>, <kuba@kernel.org>
Cc: <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSBuZXQ6IGFycDogdXNlIGtmcmVlX3NrYl9yZWFzb24oKSBpbiBhcnBfcmN2KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 54Q8RiBX001679
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68342606.001/4b5TRB5Hx7z8RTZN

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() with kfree_skb_reason() in arp_rcv(). Following
new skb drop reasons are introduced for arp:

/* ARP header hardware address length mismatch */
SKB_DROP_REASON_ARP_HLEN_MISMATCH
/* ARP header protocol addresslength is invalid */
SKB_DROP_REASON_ARP_PLEN_INVALID

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 include/net/dropreason-core.h | 12 ++++++++++++
 net/ipv4/arp.c                | 15 ++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index bea77934a235..dc846b705c24 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -118,6 +118,8 @@
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
 	FN(ARP_PVLAN_DISABLE)		\
+	FN(ARP_HLEN_MISMATCH)		\
+	FN(ARP_PLEN_INVALID)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
 	FNe(MAX)
@@ -560,6 +562,16 @@ enum skb_drop_reason {
 	 * enabled.
 	 */
 	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
+	/**
+	 * @SKB_DROP_REASON_ARP_HLEN_MISMATCH: ARP header hardware address
+	 * length mismatch.
+	 */
+	SKB_DROP_REASON_ARP_HLEN_MISMATCH,
+	/**
+	 * @SKB_DROP_REASON_ARP_PLEN_INVALID: ARP header protocol address
+	 * length is invalid.
+	 */
+	SKB_DROP_REASON_ARP_PLEN_INVALID,
 	/**
 	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
 	 * is an IEEE MAC Control address.
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index a648fff71ea7..ca19f2645ccb 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -967,6 +967,7 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
 	const struct arphdr *arp;
+	enum skb_drop_reason drop_reason;

 	/* do not tweak dropwatch on an ARP we will ignore */
 	if (dev->flags & IFF_NOARP ||
@@ -979,12 +980,20 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto out_of_mem;

 	/* ARP header, plus 2 device addresses, plus 2 IP addresses.  */
-	if (!pskb_may_pull(skb, arp_hdr_len(dev)))
+	drop_reason = pskb_may_pull_reason(skb, arp_hdr_len(dev));
+	if (drop_reason != SKB_NOT_DROPPED_YET)
 		goto freeskb;

 	arp = arp_hdr(skb);
-	if (arp->ar_hln != dev->addr_len || arp->ar_pln != 4)
+	if (arp->ar_hln != dev->addr_len) {
+		drop_reason = SKB_DROP_REASON_ARP_HLEN_MISMATCH;
 		goto freeskb;
+	}
+
+	if (arp->ar_pln != 4) {
+		drop_reason = SKB_DROP_REASON_ARP_PLEN_INVALID;
+		goto freeskb;
+	}

 	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));

@@ -996,7 +1005,7 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 freeskb:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 out_of_mem:
 	return NET_RX_DROP;
 }
-- 
2.25.1

