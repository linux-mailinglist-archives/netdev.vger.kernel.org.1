Return-Path: <netdev+bounces-149392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D39E562B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6855A282E97
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA704207DE4;
	Thu,  5 Dec 2024 13:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567311C3318
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403894; cv=none; b=PGTtttgcln2+nNWEhAVk/G3jCBX8KEiCI7QcCsYqUpS4K65PL4AiV/syYluf7jME1THnn4K2gjLPfuKCkzZ+nnI7TDHw4S6IrHyQEhoXePqbYeKVDNNjPvBHcYNToW3n/HsP/sO7qlZ9a6j+azf/+aVXo8CVj838ZYolZxsOdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403894; c=relaxed/simple;
	bh=gFgwaufinNULPm9OAtH+5ih4lFacRD4Ah6y4yBq2HNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MCGrmvyj11Fv7O16p8Vs1Su2NMNOOYTvUNAn0LlnTBa9RcF1b8ZpMHhMkXE4i1kOiuvtG6tbBE98lfspozVJnKJbc8tCucf8f81BxhFEV7gFZquz6A90KwyztTjDsimK6pWOAsBXlfmSXsomoz+JI1S4x5iml08AmZSkvq5Renc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from localhost.localdomain (unknown [183.69.133.42])
	by mail (Coremail) with SMTP id AQAAfwA3tuBKpFFnaTJaAg--.7861S2;
	Thu, 05 Dec 2024 21:02:03 +0800 (CST)
From: tianyu2 <tianyu2@kernelsoft.com>
To: pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH v2 net-next] ipv4: remove useless arg
Date: Thu,  5 Dec 2024 21:04:54 +0800
Message-Id: <20241205130454.3226-1-tianyu2@kernelsoft.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3tuBKpFFnaTJaAg--.7861S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw43Xw1xZw48uF1xCw15Jwb_yoW8trWxpF
	W5Ka98ArWDWr48Wws2yFZrG34ayw1rWFyak3yrC343Kw1DKr4FgFWDtFWYyr15KrWxW3W2
	qFy29w45Gw1xAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr
	0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Xr4l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyhihUUUUU
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/

The "struct sock *sk" parameter in ip_rcv_finish_core is unused, which
leads the compiler to optimize it out. As a result, the
"struct sk_buff *skb" parameter is passed using x1. And this make kprobe
hard to use.

Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
---
 net/ipv4/ip_input.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index f0a4dda246ab..30a5e9460d00 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -314,7 +314,7 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_early_demux(struct sk_buff *skb);
 int udp_v4_early_demux(struct sk_buff *skb);
-static int ip_rcv_finish_core(struct net *net, struct sock *sk,
+static int ip_rcv_finish_core(struct net *net,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
 {
@@ -442,7 +442,7 @@ static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return NET_RX_SUCCESS;
 
-	ret = ip_rcv_finish_core(net, sk, skb, dev, NULL);
+	ret = ip_rcv_finish_core(net, skb, dev, NULL);
 	if (ret != NET_RX_DROP)
 		ret = dst_input(skb);
 	return ret;
@@ -589,8 +589,7 @@ static struct sk_buff *ip_extract_route_hint(const struct net *net,
 	return skb;
 }
 
-static void ip_list_rcv_finish(struct net *net, struct sock *sk,
-			       struct list_head *head)
+static void ip_list_rcv_finish(struct net *net, struct list_head *head)
 {
 	struct sk_buff *skb, *next, *hint = NULL;
 	struct dst_entry *curr_dst = NULL;
@@ -607,7 +606,7 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb, dev, hint) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, skb, dev, hint) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);
@@ -633,7 +632,7 @@ static void ip_sublist_rcv(struct list_head *head, struct net_device *dev,
 {
 	NF_HOOK_LIST(NFPROTO_IPV4, NF_INET_PRE_ROUTING, net, NULL,
 		     head, dev, NULL, ip_rcv_finish);
-	ip_list_rcv_finish(net, NULL, head);
+	ip_list_rcv_finish(net, head);
 }
 
 /* Receive a list of IP packets */
-- 
2.27.0


