Return-Path: <netdev+bounces-174853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFDA61089
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D833B0427
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7642E1FECC0;
	Fri, 14 Mar 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="LzRI1v0q"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5311FECB1
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953671; cv=none; b=ME/i36rSkCD7Dv5qKUiDzdtjsye426cNBjCQdN8EINPl4S9JwfOhqGbc1SqMFIwl+IXj9k/z7Z6HJGtrVxPJqIYYy3pEm/2e3IL0db8ppzgVYKf47yVzDP54ngDFJymTYUv+QE4Vi35YM6laba9s3mUwAsVNt/+cx3Jx7H/MW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953671; c=relaxed/simple;
	bh=Zb5AFMbY8r6HXREN8+whWqjDvw9ccRPgOWuK0KOvwWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=im+nfUzGjPZSEElRUpn1rkRLASNaGa18K2VPBtY9wZu3UOnvwRYPg188evZSVaNh4SWVEnYuj4imqWtMTiKo3+2W9jVVkCTfc2n85uUILy35hd22DwE4yZvDrKvX9auJX7/UY4KHiU6yEi3CfFXF/blbf1TO/C5zIWWfgI7W6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=LzRI1v0q; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (rtr-guestwired.meeting.ietf.org [31.133.144.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 78DD9200DB93;
	Fri, 14 Mar 2025 13:01:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 78DD9200DB93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741953667;
	bh=9vBlWDe5O63orQAJG0bjrL9w+dmBhwLhb3omuftsdsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzRI1v0qxOQjDwFVzX8kQezJP7ljzscL6ILVZLpAWM9byi4DASFgD0TDrJvo3D3KS
	 kfFvgM60NK6zP0GqIjgitO7lIpqh0Uz34SCk03WKN2mks0+0Y7Z4kt24kkjd6DBFf7
	 FKMu7dNO8JkAg2ImQFs83JeKbWb24mYHgilr/I1O7WKrzMsfNl0sXCI4WNsY55CMCL
	 hJFB0mq+PG5UG6nOPG7KlG9f5qAS8PTrHkzFrF8eFPk9n5Gk5MRhswymyfFqUO99vR
	 TZLMHrOgwBMts6AVKkTwquRj/d694wwT13OayqU6qMOAPMfP7/tFxyq/G9Rrs+ImUG
	 Qf1l9Fgv8CDyA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2 2/3] net: ipv6: ioam6: fix lwtunnel_output() loop
Date: Fri, 14 Mar 2025 13:00:47 +0100
Message-Id: <20250314120048.12569-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314120048.12569-1-justin.iurman@uliege.be>
References: <20250314120048.12569-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_output() reentry loop in ioam6_iptunnel when the
destination is the same after transformation. Note that a check on the
destination address was already performed, but it was not enough. This
is the example of a lwtunnel user taking care of loops without relying
only on the last resort detection offered by lwtunnel.

Fixes: 8cb3bf8bff3c ("ipv6: ioam: Add support for the ip6ip6 encapsulation")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ioam6_iptunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 2c383c12a431..09065187378e 100644
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
@@ -422,7 +419,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation (e.g., with the inline mode)
+	 */
+	if (dst->lwtstate != cache_dst->lwtstate) {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
-- 
2.34.1


