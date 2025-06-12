Return-Path: <netdev+bounces-196793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB6AD65E6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F3C17D55C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166F1A9B52;
	Thu, 12 Jun 2025 03:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938C18D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749697422; cv=none; b=dHcssLzypAyBVuRKfTbXNLtayBZHy1MRj2b4jdWZOojuqW1KqbD0QSFpNUnEKnriHZSrdNchwgRapD1lvGXLCQpYO6FXjKUgUa38AteULs6EJLYe3w/Ed1iFtX7DtgZHgurXCTSrXLBMtwtkoL4I4iTfrMtUgG6wHSGuuGIl6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749697422; c=relaxed/simple;
	bh=K4fU+l8YiSjZQ95BL0rGgOPIdgyWM64dcgAYQthf3Vg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=VkV/4LteO6swGCNPFzttrK0xnkiSqyqkibs9iaftkxLhvdw3QoXPSw8M2RgM8tjplwm4nppwJuA+UFk79OIk1r7c+0dBCfwQEIIHYe2ear6IjCU4lswIb81qu3JR7+eSFsAm/IDozPInbR+Y08/qmn0n1bVx0lodrrkzUHtDMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bHnR63Gyjz5DXTW;
	Thu, 12 Jun 2025 11:03:30 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 55C3236B099616;
	Thu, 12 Jun 2025 11:02:58 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 12 Jun 2025 11:02:59 +0800 (CST)
Date: Thu, 12 Jun 2025 11:02:59 +0800 (CST)
X-Zmail-TransId: 2afd684a4363331-cfcc1
X-Mailer: Zmail v1.0
Message-ID: <20250612110259698Q2KNNOPQhnIApRskKN3Hi@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <davem@davemloft.net>, <kuba@kernel.org>, <dsahern@kernel.org>,
        <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <netdev@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYzXSBuZXQ6IGFycDogdXNlIGtmcmVlX3NrYl9yZWFzb24oKSBpbiBhcnBfcmN2KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55C3236B099616
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 684A4382.000/4bHnR63Gyjz5DXTW

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() with kfree_skb_reason() in arp_rcv().

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
v2->v3
https://lore.kernel.org/all/20250610164445403aNkwCjYV-MAINIWe0T9JJ@zte.com.cn/
1. Move drop_reason declaration before arp

 net/ipv4/arp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index a648fff71ea7..c0440d61cf2f 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -966,6 +966,7 @@ static int arp_is_multicast(const void *pkey)
 static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
+	enum skb_drop_reason drop_reason;
 	const struct arphdr *arp;

 	/* do not tweak dropwatch on an ARP we will ignore */
@@ -979,12 +980,15 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto out_of_mem;

 	/* ARP header, plus 2 device addresses, plus 2 IP addresses.  */
-	if (!pskb_may_pull(skb, arp_hdr_len(dev)))
+	drop_reason = pskb_may_pull_reason(skb, arp_hdr_len(dev));
+	if (drop_reason != SKB_NOT_DROPPED_YET)
 		goto freeskb;

 	arp = arp_hdr(skb);
-	if (arp->ar_hln != dev->addr_len || arp->ar_pln != 4)
+	if (arp->ar_hln != dev->addr_len || arp->ar_pln != 4) {
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		goto freeskb;
+	}

 	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));

@@ -996,7 +1000,7 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 freeskb:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 out_of_mem:
 	return NET_RX_DROP;
 }
-- 
2.27.0

