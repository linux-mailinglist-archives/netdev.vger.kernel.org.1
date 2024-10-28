Return-Path: <netdev+bounces-139701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CA9B3DE0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F8281E77
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3F200B80;
	Mon, 28 Oct 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="gG0RGd56"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EA18E05D;
	Mon, 28 Oct 2024 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154992; cv=none; b=DJe/mcAsYh0fkSRSNL//3IY4iLuSUABxZ7Q71jn2m/BaxjI8pQ02gIDsrGiTey1yiN040Iu95CDOj8FxkmkjarwBbg1Sv04KP33bKdRoBBnb3p1mDh/PbBbcyJYsEMWKGVP63JTkjNEMuTAPCV+/UgKNtSZetTkRXnkTH1kmMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154992; c=relaxed/simple;
	bh=fcb6/ZXqWJIFRDmjDhyI8ULDpI0uIWrmsfpnD3tx5PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtgSniMXUCmjZ9guIzr5S3j06ar7mP2CgsyXqboQfx5BtdJqcFda/IgD1gfS7cmjM+EtUZopmuJumKBKEWTnvAFZ6jsJhYkGyV1Gnx0umc3KIAvp0RA9AtyOH/k3VBPAdVqK13A/EpDLEXJX1mxOXeGLNf4N4TfzhARLjfNF/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=gG0RGd56; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [10.29.254.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8BB20200DF96;
	Mon, 28 Oct 2024 23:36:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8BB20200DF96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1730154988;
	bh=tYfpbkPNAjaZpZFMkRWmpEDluZdW9RukyEp0aeELqDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gG0RGd56fYB4i6Mr0y1PANR29LyYM4pZRZpo/J+glpj2805OJcCj3az+topCl5OZg
	 DKVUdI0Y3+MtB1/siLcaPSI0qAChSa0Tgn2vwGO5FDxTeUXUogVTXhy47IqtgPVAv6
	 isuf73tPvxsq2RRL4PmgAYZf1DSIdwbqzR+MdxEF/qhkemjaqlnr+h207oAUZieTQ2
	 Uoe34ZILjWuEOGWcozgX8IyJ95L8NJOgpP7bjouwJ/lR+5eUN8T+Noh9DWHKsGQRXH
	 b2pL8A5gi43UV7YB8MUyA8Q51r+RVNyA/Noth3S/hPaFPOtKFvspKfhN9+fUA3F0UB
	 +niZ4lEhokyGA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be,
	Alexander Aring <aahringo@redhat.com>
Subject: [PATCH net-next v3 3/3] net: ipv6: rpl_iptunnel: mitigate 2-realloc issue
Date: Mon, 28 Oct 2024 23:36:11 +0100
Message-Id: <20241028223611.26599-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028223611.26599-1-justin.iurman@uliege.be>
References: <20241028223611.26599-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch mitigates the two-reallocations issue with rpl_iptunnel by
providing the dst_entry (in the cache) to the first call to
skb_cow_head(). As a result, the very first iteration would still
trigger two reallocations (i.e., empty cache), while next iterations
would only trigger a single reallocation.

Performance tests before/after applying this patch, which clearly shows
there is no impact (it even shows improvement):
- before: https://ibb.co/nQJhqwc
- after: https://ibb.co/4ZvW6wV

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Aring <aahringo@redhat.com>
---
 net/ipv6/rpl_iptunnel.c | 67 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index db3c19a42e1c..c518728460a2 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -124,8 +124,17 @@ static void rpl_destroy_state(struct lwtunnel_state *lwt)
 	dst_cache_destroy(&rpl_lwt_lwtunnel(lwt)->cache);
 }
 
+static inline int dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
-			     const struct ipv6_rpl_sr_hdr *srh)
+			     const struct ipv6_rpl_sr_hdr *srh,
+			     struct dst_entry *dst)
 {
 	struct ipv6_rpl_sr_hdr *isrh, *csrh;
 	const struct ipv6hdr *oldhdr;
@@ -153,7 +162,7 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dev_overhead(dst, skb));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
@@ -186,36 +195,35 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 	return 0;
 }
 
-static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
+static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt,
+		      struct dst_entry *dst)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
 
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
-	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
+	tinfo = rpl_encap_lwtunnel(skb_dst(skb)->lwtstate);
 
-	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh, dst);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
-
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
+	rlwt = rpl_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
 	local_bh_enable();
 
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -237,15 +245,15 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	}
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
-
 	return dst_output(net, sk, skb);
 
 drop:
@@ -255,36 +263,37 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 static int rpl_input(struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct rpl_lwt *rlwt;
 	int err;
 
-	rlwt = rpl_lwt_lwtunnel(orig_dst->lwtstate);
-
-	err = rpl_do_srh(skb, rlwt);
-	if (unlikely(err))
-		goto drop;
+	rlwt = rpl_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
+	local_bh_enable();
+
+	err = rpl_do_srh(skb, rlwt, dst);
+	if (unlikely(err))
+		goto drop;
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
+			local_bh_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
+			local_bh_enable();
 		}
+
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		if (unlikely(err))
+			goto drop;
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
-	local_bh_enable();
-
-	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
-	if (unlikely(err))
-		goto drop;
 
 	return dst_input(skb);
 
-- 
2.34.1


