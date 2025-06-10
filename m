Return-Path: <netdev+bounces-196002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C8DAD30C3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518F516CCA1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB0280A35;
	Tue, 10 Jun 2025 08:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01728033E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545107; cv=none; b=R9VIsZx3T4HdjfwhBriHuDaJGSJwTKI9O8Az4sgRvIwfqHb8dWzC9MwJc3BM/M7spf+8JQo0mtydwCze+oNRjj44YiebLcsXeSuT4u/VreSMtrzVJ/EyGLVtCWwpe55bYFbzCzqT1xp6WgV1J8axz0TUcXllmiPzvv9DVDzQ1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545107; c=relaxed/simple;
	bh=nJkV/vx6mRicN9KHEk9hiDwqG/V+pZQaH4miB3dQ5PM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=SbdFyOFdhrncLYlIdY/XGnsnhbZFCHppIMhHPejqh9u5AzNvgIcoPjxxmny/dyRUdeNSL7bGK/p+LVyVzPWRKQQWWbJPuPIeCzCXjwwQ9eDwwnZLlzQncQ11jeKo8HQVOMiWaBlvo1xY8ViLP/psg/RojzMLGL5c3uM9fzXLZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bGj5w4jPfz8RVFW;
	Tue, 10 Jun 2025 16:44:52 +0800 (CST)
Received: from njb2app07.zte.com.cn ([10.55.22.95])
	by mse-fl1.zte.com.cn with SMTP id 55A8igNw032653;
	Tue, 10 Jun 2025 16:44:42 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app03[null])
	by mapi (Zmail) with MAPI id mid204;
	Tue, 10 Jun 2025 16:44:45 +0800 (CST)
Date: Tue, 10 Jun 2025 16:44:45 +0800 (CST)
X-Zmail-TransId: 2afb6847f07dfffffffff7f-9e437
X-Mailer: Zmail v1.0
Message-ID: <20250610164445403aNkwCjYV-MAINIWe0T9JJ@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYyXSBuZXQ6IGFycDogdXNlIGtmcmVlX3NrYl9yZWFzb24oKSBpbiBhcnBfcmN2KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 55A8igNw032653
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6847F084.000/4bGj5w4jPfz8RVFW

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() with kfree_skb_reason() in arp_rcv().

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
v1->v2
https://lore.kernel.org/all/20250526162746319JPXpL0xRJ-n7onnZApOiV@zte.com.cn/
1. Remove new skb drop reasons

 net/ipv4/arp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index a648fff71ea7..5b4dac7bbde4 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -967,6 +967,7 @@ static int arp_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
 	const struct arphdr *arp;
+	enum skb_drop_reason drop_reason;

 	/* do not tweak dropwatch on an ARP we will ignore */
 	if (dev->flags & IFF_NOARP ||
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
2.25.1

