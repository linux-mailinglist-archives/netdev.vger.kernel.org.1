Return-Path: <netdev+bounces-193608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D0AC4C84
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BD3A3E97
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02724DD17;
	Tue, 27 May 2025 10:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3003C30;
	Tue, 27 May 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343471; cv=none; b=aUON1yXzUlfefhdJJeGlLMEVb9n3T3YtPwSAyRABQ/E4JVQrPDSDilvhtNLOj/tv/y1ju81f7NOJCi1X084TkSdk+qSyjvJ7nnMIofAyZltlDpPIZysr7fWMSw6oztf2l2l5LQlXw37mu9+ZPQ9l24i8WbNqObgHILmXYQl8vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343471; c=relaxed/simple;
	bh=kn/nRRLMtAjxo7kfizv0Ybk8CZ92Ovm7QgzR/FkyBVw=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=RbiVD5CLXGEUKImv05KA+gRAf6iTdwNwPf80PznBMI5R3dC5FoD+UPQq+xCZY3zaZb2ycQ/7cQeeEqIzKpA9ke2sjx1BlWIoycrQAVYOJpu50piw5ay+URZfI8HM42iULN6exEinjlIWhHWBUhJja7MB5zzWkExvJOvi13w02iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4b68jc5V7Xz8R043;
	Tue, 27 May 2025 18:57:40 +0800 (CST)
Received: from njb2app07.zte.com.cn ([10.55.22.95])
	by mse-fl1.zte.com.cn with SMTP id 54RAvW65014815;
	Tue, 27 May 2025 18:57:32 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app04[null])
	by mapi (Zmail) with MAPI id mid204;
	Tue, 27 May 2025 18:57:36 +0800 (CST)
Date: Tue, 27 May 2025 18:57:36 +0800 (CST)
X-Zmail-TransId: 2afc68359aa0ffffffffc7e-feb8f
X-Mailer: Zmail v1.0
Message-ID: <20250527185736038u-6EtRPVin2ftxbrp-C4w@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <edumazet@google.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <dsahern@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYyXSBuZXQ6IGFycDogdXNlIGtmcmVlX3NrYl9yZWFzb24oKSBpbiBhcnBfcmN2KCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 54RAvW65014815
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68359AA4.002/4b68jc5V7Xz8R043

From: Qiu Yutan <qiu.yutan@zte.com.cn>

Replace kfree_skb() with kfree_skb_reason() in arp_rcv().

Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
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

