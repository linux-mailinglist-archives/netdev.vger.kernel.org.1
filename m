Return-Path: <netdev+bounces-165306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5861A31874
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DC93A7D4F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9E268FF9;
	Tue, 11 Feb 2025 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Jhgcqe2c"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AE262D21
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312202; cv=none; b=SKGSKV2/tpw9Zhu5+xB5cFIAyF79IUsmxSTrOjWXXy25qePTiAaVl6kf2vWQhj5iHw2GvZgZErsJd/XLicXQyr0crPFM5GOywAHRkU2WpTkV5fE11vQBZN9h97qKERQaxyehEnrVQzBM6VYcH/WLt4qfGX1oJY91PqvkDsuOVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312202; c=relaxed/simple;
	bh=+fKzhba+jhKNMsksa4EvYGwM+FBK74D5or5T1KAF4hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpq24bZc5YeQYqQizSsrkj/kMJbcYPvpDnZCkWONZ7lMl0W5UL5Pqf5vw4II4mJVD6AirQS+LkEwKP6jjezzO2tkyTaOH0W1SlYhG6uiCpUBK9DXkuphQUeF8M4lSs5PX+86XJhzLHa3ua6seDodJtffjF8HFt/FGo/5mlsrASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Jhgcqe2c; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [10.29.255.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 98130200DB98;
	Tue, 11 Feb 2025 23:16:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 98130200DB98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1739312192;
	bh=EhvQZuj1jndiD6dVlTsKikQnLXdeZdL7Rl5pnp9H2f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jhgcqe2ccp+rKxAqpT3wyDqs17GRgJI2cRilY0Or0BrD7xD+SKIBwMHcm1t9RWiXn
	 DrlsvR9ndT1ME9c6ohGtm/6RL6qWIlQq8rCBjip7wfdm013890yVhbNXcfXzzzPoiD
	 g9KxTZB+o28yzu6dteSyiblYKj0TMGIhUtPGxRWv4n112u2IKLGTAr3g1H5/1ZqWO7
	 d6Pko6qLL1q5p68KYCSReAfrTNDT59qarUB1bYAE3OzaevaWns5bHVa09qslFklucT
	 vnMTMpPawu52R2J5HlhdW5K64ICRZlrZ/7lvb52okJWIdfHqJNaJvuYC/MQ15iVRhW
	 4oVw6j1uiRnSw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <alex.aring@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: [PATCH net v2 2/3] net: ipv6: fix lwtunnel loops in ioam6, rpl and seg6
Date: Tue, 11 Feb 2025 23:16:23 +0100
Message-Id: <20250211221624.18435-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211221624.18435-1-justin.iurman@uliege.be>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the destination is the same post-transformation, we enter a
lwtunnel loop. This is true for ioam6_iptunnel, rpl_iptunnel, and
seg6_iptunnel, in both input() and output() handlers respectively, where
either dst_input() or dst_output() is called at the end. It happens for
instance with the ioam6 inline mode, but can also happen for any of them
as long as the post-transformation destination still matches the fib
entry. Note that ioam6_iptunnel was already comparing the old and new
destination address to prevent the loop, but it is not enough (e.g.,
other addresses can still match the same subnet).

Here is an example for rpl_input():

dump_stack_lvl+0x60/0x80
rpl_input+0x9d/0x320
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
[...]
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
ip6_sublist_rcv_finish+0x85/0x90
ip6_sublist_rcv+0x236/0x2f0

... until rpl_do_srh() fails, which means skb_cow_head() failed.

This patch prevents that kind of loop by redirecting to the origin
input() or output() when the destination is the same
post-transformation.

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: David Lebrun <dlebrun@google.com>
---
 net/ipv6/ioam6_iptunnel.c |  6 ++----
 net/ipv6/rpl_iptunnel.c   | 10 ++++++++++
 net/ipv6/seg6_iptunnel.c  | 33 +++++++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 2c383c12a431..6c61b306f2e9 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -337,7 +337,6 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
-	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
 	u32 pkt_cnt;
@@ -352,8 +351,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (pkt_cnt % ilwt->freq.n >= ilwt->freq.k)
 		goto out;
 
-	orig_daddr = ipv6_hdr(skb)->daddr;
-
 	local_bh_disable();
 	cache_dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
@@ -422,7 +419,8 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
+	/* avoid a lwtunnel_input() loop when dst_entry is the same */
+	if (dst->lwtstate != cache_dst->lwtstate) {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index c26bf284459f..dc004e9aa649 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -247,6 +247,12 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
+	/* avoid a lwtunnel_output() loop when dst_entry is the same */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		return orig_dst->lwtstate->orig_output(net, sk, skb);
+	}
+
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
@@ -305,6 +311,10 @@ static int rpl_input(struct sk_buff *skb)
 		skb_dst_set(skb, dst);
 	}
 
+	/* avoid a lwtunnel_input() loop when dst_entry is the same */
+	if (lwtst == dst->lwtstate)
+		return dst->lwtstate->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 6045e850b4bf..5ce662d8f334 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -467,9 +467,16 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 	return dst_input(skb);
 }
 
+static int seg6_input_redirect_finish(struct net *net, struct sock *sk,
+				      struct sk_buff *skb)
+{
+	return skb_dst(skb)->lwtstate->orig_input(skb);
+}
+
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
+	int (*in_func)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct lwtunnel_state *lwtst;
@@ -515,12 +522,18 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		skb_dst_set(skb, dst);
 	}
 
+	/* avoid a lwtunnel_input() loop when dst_entry is the same */
+	if (lwtst == dst->lwtstate)
+		in_func = seg6_input_redirect_finish;
+	else
+		in_func = seg6_input_finish;
+
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, seg6_input_finish);
+			       skb_dst(skb)->dev, in_func);
 
-	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+	return in_func(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
 	return err;
@@ -554,6 +567,7 @@ static int seg6_input(struct sk_buff *skb)
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
+	int (*out_func)(struct net *net, struct sock *sk, struct sk_buff *skb);
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct seg6_lwt *slwt;
@@ -598,14 +612,21 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			goto drop;
 	}
 
-	skb_dst_drop(skb);
-	skb_dst_set(skb, dst);
+	/* avoid a lwtunnel_output() loop when dst_entry is the same */
+	if (orig_dst->lwtstate == dst->lwtstate) {
+		dst_release(dst);
+		out_func = orig_dst->lwtstate->orig_output;
+	} else {
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+		out_func = dst_output;
+	}
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
-			       NULL, skb_dst(skb)->dev, dst_output);
+			       NULL, skb_dst(skb)->dev, out_func);
 
-	return dst_output(net, sk, skb);
+	return out_func(net, sk, skb);
 drop:
 	dst_release(dst);
 	kfree_skb(skb);
-- 
2.34.1


