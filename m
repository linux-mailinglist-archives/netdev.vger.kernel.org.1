Return-Path: <netdev+bounces-147972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0379DF9A0
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B189A280D3C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C51F8AC2;
	Mon,  2 Dec 2024 03:33:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCC28399
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.232.28.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110381; cv=none; b=jfwiNPrMWe+c13IluWyJM0IXQBnHyudzXAnHIWTh+fwqPVL3Tdh+hAHA65sGtxnaaS4aXQ+GxcuVTNQ94LQjSx+oljqmic5ve5/z2lhgEh0IlrhlhaoAa2lhO7WCdZaSj8ete/IqCX0jZHQBEKPTTc2eg0xF20T/PNcBq4L9BvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110381; c=relaxed/simple;
	bh=gFgwaufinNULPm9OAtH+5ih4lFacRD4Ah6y4yBq2HNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dt60gbo8t7H07xybo/bfdWO5Oe+uWSiiDerFTuTyjvSXtLN/gZaVtOQrr85uKklovbPvywdFq28nrJVaVmLWZVNYkiNQ6CYtpLnadTx1dzYWzInmz7ACUdTYf/z6ZbZq5saSURMltU43HLMyWb0x0SAZCJtRrCkNrWOOEUdEago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=20.232.28.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from localhost.localdomain (unknown [183.69.133.42])
	by mail (Coremail) with SMTP id AQAAfwDXVeDGKU1nDxNMAg--.46805S2;
	Mon, 02 Dec 2024 11:30:14 +0800 (CST)
From: tianyu2 <tianyu2@kernelsoft.com>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org
Subject: [PATCH] ipv4: remove useless arg
Date: Mon,  2 Dec 2024 11:32:30 +0800
Message-Id: <20241202033230.870313-1-tianyu2@kernelsoft.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXVeDGKU1nDxNMAg--.46805S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw43Xw1xZw48uF1xCw15Jwb_yoW8trWxpF
	W5Ka98ArWDWr48Wws2yFZrG34ayw1rWFyak3yrC343Kw1DKr4FgFWDtFWYyr15KrWxW3W2
	qFy29w45Gw1xAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUkfb1UUUUU
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


