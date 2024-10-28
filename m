Return-Path: <netdev+bounces-139694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2769B3D73
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCCC1F21526
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848942003BC;
	Mon, 28 Oct 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="a6tv2lLi"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BD1F9ED6;
	Mon, 28 Oct 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152969; cv=none; b=eriFwuDtmoaoCulFFHKlPt+RIXrP07Tij+BvdKLzOq0ecd4/r+TGgas5rSdqWJ/DIHHLMQSkf4UFJpJ0aleAi1VLKHtR3rg2Ypcuu2McuuCAtJ5uZF9ca1rn8xZS7YjNsPHnvblqm8wMW3vdEyRVFAXOXI0awQ/XTs4NeimQkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152969; c=relaxed/simple;
	bh=n/APfUoHPDXAMzhjZMZiEDyF0sjfkmgoAdtmc3va7vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u05jHyO9qw+CKiqsxac0L7eT7uNi9/WxQDXRkH6CrnmMvMQ0tm0tUL0RKbVlo2ZlD0KubFpb0Nvz/MS50jMwCmUnr1ODtGznz3UQydSRmP9Qv04cAffEXMiGuA9ssOO4RXVFL+RJNe4IBDtJUcFFeMzxhHRxGYQGrFQXzAeoSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=a6tv2lLi; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (modemcable174.147-130-66.mc.videotron.ca [66.130.147.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8D67120167CD;
	Mon, 28 Oct 2024 23:02:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8D67120167CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1730152959;
	bh=Qj+fSJuAxw4qvKvFSjZXyAvFMm1rUrcK2jLeD/MTC0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6tv2lLifFJrewM7ojjmz8g0bK9DXNPXlrMi+VRQrvBco4/OrWqLbK132USpbHBrH
	 Iyo2u3s3+f/0AdryLAB8SlLEb73ZBD+yyphkV5JXBGKXQLHY5M4u/5+HVfq8V52jdx
	 DJwVYwIpU4pStJQCr0tolUG86OauivmZUdWPKPjPJ9RMOVT1r3DWSdpicCjdwspZMk
	 mRHQTcCLgbkFVD8toV6VGBgOwNcxAq7MybDYXv8wLlaJIjljDfGXt1tjNTDYRXJiXo
	 ejzL0YCzFzBNUX/5qp9SsWrUVqax0/klyaWQ/ZgjguGVX/vAXDjuYJHs7sFkuxlDZh
	 S97b1RjOAWkjQ==
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
	David Lebrun <dlebrun@google.com>
Subject: [PATCH net-next v2 2/3] net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
Date: Mon, 28 Oct 2024 23:02:11 +0100
Message-Id: <20241028220212.24132-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028220212.24132-1-justin.iurman@uliege.be>
References: <20241028220212.24132-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch mitigates the two-reallocations issue with seg6_iptunnel by
providing the dst_entry (in the cache) to the first call to
skb_cow_head(). As a result, the very first iteration would still
trigger two reallocations (i.e., empty cache), while next iterations
would only trigger a single reallocation.

Performance tests before/after applying this patch, which clearly shows
the improvement:
- before: https://ibb.co/3Cg4sNH
- after: https://ibb.co/8rQ350r

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: David Lebrun <dlebrun@google.com>
---
 net/ipv6/seg6_iptunnel.c | 108 +++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 098632adc9b5..a915b6c94c72 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -124,11 +124,25 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	return flowlabel;
 }
 
+static inline int dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 /* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
 int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 {
-	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	return __seg6_do_srh_encap(skb, osrh, proto, NULL);
+}
+EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
+
+static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+			       int proto, struct dst_entry *dst)
+{
+	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	struct ipv6_sr_hdr *isrh;
 	int hdrlen, tot_len, err;
@@ -137,7 +151,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dev_overhead(dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -181,7 +195,7 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, skb_dst(skb)->dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
@@ -197,15 +211,14 @@ int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
 
 /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
 static int seg6_do_srh_encap_red(struct sk_buff *skb,
-				 struct ipv6_sr_hdr *osrh, int proto)
+				 struct ipv6_sr_hdr *osrh, int proto,
+				 struct dst_entry *dst)
 {
 	__u8 first_seg = osrh->first_segment;
-	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	int hdrlen = ipv6_optlen(osrh);
 	int red_tlv_offset, tlv_offset;
@@ -230,7 +243,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
 
-	err = skb_cow_head(skb, tot_len + skb->mac_len);
+	err = skb_cow_head(skb, tot_len + dev_overhead(dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -263,7 +276,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	if (skip_srh) {
 		hdr->nexthdr = proto;
 
-		set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+		set_tun_src(net, skb_dst(skb)->dev, &hdr->daddr, &hdr->saddr);
 		goto out;
 	}
 
@@ -299,7 +312,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 srcaddr:
 	isrh->nexthdr = proto;
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, skb_dst(skb)->dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
@@ -319,6 +332,13 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 /* insert an SRH within an IPv6 packet, just after the IPv6 header */
 int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
+{
+	return __seg6_do_srh_inline(skb, osrh, NULL);
+}
+EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
+
+static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
+				struct dst_entry *dst)
 {
 	struct ipv6hdr *hdr, *oldhdr;
 	struct ipv6_sr_hdr *isrh;
@@ -326,7 +346,7 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + skb->mac_len);
+	err = skb_cow_head(skb, hdrlen + dev_overhead(dst, skb));
 	if (unlikely(err))
 		return err;
 
@@ -369,22 +389,20 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
 
-static int seg6_do_srh(struct sk_buff *skb)
+static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *dst)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
 	int proto, err = 0;
 
-	tinfo = seg6_encap_lwtunnel(dst->lwtstate);
+	tinfo = seg6_encap_lwtunnel(skb_dst(skb)->lwtstate);
 
 	switch (tinfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
 		if (skb->protocol != htons(ETH_P_IPV6))
 			return -EINVAL;
 
-		err = seg6_do_srh_inline(skb, tinfo->srh);
+		err = __seg6_do_srh_inline(skb, tinfo->srh, dst);
 		if (err)
 			return err;
 		break;
@@ -402,9 +420,9 @@ static int seg6_do_srh(struct sk_buff *skb)
 			return -EINVAL;
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh, proto);
+			err = __seg6_do_srh_encap(skb, tinfo->srh, proto, dst);
 		else
-			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto);
+			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto, dst);
 
 		if (err)
 			return err;
@@ -425,11 +443,11 @@ static int seg6_do_srh(struct sk_buff *skb)
 		skb_push(skb, skb->mac_len);
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
-			err = seg6_do_srh_encap(skb, tinfo->srh,
-						IPPROTO_ETHERNET);
+			err = __seg6_do_srh_encap(skb, tinfo->srh,
+						  IPPROTO_ETHERNET, dst);
 		else
 			err = seg6_do_srh_encap_red(skb, tinfo->srh,
-						    IPPROTO_ETHERNET);
+						    IPPROTO_ETHERNET, dst);
 
 		if (err)
 			return err;
@@ -453,36 +471,37 @@ static int seg6_input_finish(struct net *net, struct sock *sk,
 static int seg6_input_core(struct net *net, struct sock *sk,
 			   struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
-
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
+	local_bh_enable();
+
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err))
+		goto drop;
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
+			local_bh_disable();
 			dst_cache_set_ip6(&slwt->cache, dst,
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
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -523,21 +542,20 @@ static int seg6_input(struct sk_buff *skb)
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
-	struct dst_entry *dst = NULL;
+	struct dst_entry *dst;
 	struct seg6_lwt *slwt;
 	int err;
 
-	err = seg6_do_srh(skb);
-	if (unlikely(err))
-		goto drop;
-
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_lwt_lwtunnel(skb_dst(skb)->lwtstate);
 
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
 	local_bh_enable();
 
+	err = seg6_do_srh(skb, dst);
+	if (unlikely(err))
+		goto drop;
+
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -559,15 +577,15 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		local_bh_disable();
 		dst_cache_set_ip6(&slwt->cache, dst, &fl6.saddr);
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
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
 			       NULL, skb_dst(skb)->dev, dst_output);
-- 
2.34.1


