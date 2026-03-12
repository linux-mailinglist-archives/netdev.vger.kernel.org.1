Return-Path: <netdev+bounces-267141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APyrG6/lsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:11:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5E27546A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDCE33008CA4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B23F54A0;
	Thu, 12 Mar 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="L3ZuJkub"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9733F2105
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331117; cv=none; b=PH4u9gsY5j0H6738YqpA8Mn2+J4CvFDKW3xXZkwHpUJps36RgLAI/q1rME2M7Vg5aSaxp1YCKoagb15Uez9IlkL8AoOSCpEky6MrGqIEpLPcW+6xbyHJQdLcKX9al12TYDqF5GxpUwCb6LRz5pR8TXDvrP1QC19SI+cTNI+LBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331117; c=relaxed/simple;
	bh=CteEjqLkTGq0qRLrIq5NizVGhUKfiW5vkmPUCqAbq7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovzIcJV0OKoWbWWMCqSO3yN27uki+xmQJDqpkGFUE8azQ8ySAzsbjjAGd2eKvt1tDLFl1I4vdmxxoEvnYTG/WJTwN5cqmlbdcDxEpMIaOJWilCRYL9yzRf4esdu5X+6MSpbWAoJcSWaufcnUH11XtugnfWdKcx86A5AAg9r2d9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=L3ZuJkub; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331115; bh=e5q/bwQ71s5I/BF7m1b8GBX1wDtekJQoCTxwQui3LM8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=L3ZuJkubGr0yLFB0lThnGD+xacSWBEjQegHvzW/Ibg4nu6BN+xpT6L+0P1CweGRxdD8VWPxF1tmoHrZIuOi7fd721zzBaMTnH02kDJpO8EV9lC64ST7kspx6y/aluiXG6y8zWYjeRXnCR1SX+e57i29lo/K7fC9wVDktdfm1LHnEq0vu1v7+Gj76feCZY/QRe0Ft1UfEQd5ERIIAuPVywZ+TZ8x4aG+Si6/nfnWk6a/hw7540JNZXEP162Z3p0mDemziyP1dtc61zlyyQc7oe2bwNWvU19Xo0rbaoC7Lb5PMHlQVJMJN1cuRwkLTSiUdZC0EypT3dg2XQPUBmTr3nA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331115; bh=WcaIaLdOkDNK+63F8VfH/4J0O3bvdVE+vdK4b/H9RZ7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s1xnwolqN5R5fafDLnEJMfuVIpO/X7IY7EfyC4rww12AzqgbHJga1lNf0i2Ni4IALY/ZpoEqJQY29HdyQIgYvLo4IXH4U1sxLD5iE6wXOS4CltgHW0GoWS+PlOcUGifacAHp5Wb3prbRmiv5BlP1dYOPuT8QrXG2WZ1/lqLBr5MvfAlDIubnLBXo01MZO+t5pn2zI/lTZdquI6Z/0SJTZX2oLelcf4XuAK/b0bEH9mM4PEPMtiOT4/DJKdJMhn2GPa8M71aV53bUm7HTTKdXHj08pDltGWydGRta3DUTc5scl8ZhBeMSCxU5VRAg5u67RXfjI+wh4yhD/CXqgAArpQ==
X-YMail-OSG: rNeFoDIVM1mVV1B.3BY11qSqRDGamvm7JPhLq_UORm22laiRoeeuDmSLzRfJBSi
 wh0sQC8HTMfkswpP8DynHHq0gsQyc7iswWIqB17mv4NEEHLFmEo7WtEKOq5Rfm0O48Fp8JRzU7a.
 fwTmfv7OhZDbLGHhWJ1EX3atAZ0wP7pNsg2UvwNP7aDvTge7APvwzjDK3KAkz_qICKmXiDgA2xAV
 SqyNuwYRaPfUjfFRxamnO0CxdAAEBExigbDft5IpZi1vx5.zKCVVZs7Z7FR2SDvoCUOMUicFbC7Y
 65xiSSeqpPav71kQ0RZ6EdQHDYYQrbc3maGq7FdZqKyLeNN1q2aeqm7g2AYk8FeI8We2U.XvvBQW
 iSfvGCtjUji5.zAYFiFN7fqNk1Lm4oJwaWyHdBZ7foQbDuGNdKSHydGJDLQ_dI36WmYVlx8DPeoP
 .ApyVUOPMgZTYyZUQ7nf0FoHoi8f3NQ2pIIZldg1EUa9QK4jkYX7zv2LL4q12o6kkUaekCNIbtRL
 GHRKXC57t5_WDXhbIfyEj9.iiKpGOIDqWMhaK0CRSTLhxI4PwN8_DBMYKBGGitxc4xM5kUWlGsHf
 EjW.ImtWg0QEuwty5b.Mnzz6qanUeiaroIqY8VFKLG2g9dzGzFSyKYHrw9B9iROkVVvQfh8Rz2mj
 RBt.v3YMV9lLjJC5pVEwBP0YTL8ca2wKWNBfAr6ONRfvH.x4s5npZ2JM806FWj14h97w.xcuX02a
 Xl5JEID1.w8MwN_XhMyj6htwY_NNiE4aGHEhktBBmh44U.PQVgGFrmOukVyqT_hPoLYgIltUBT39
 9zc4YI8odKwesN8cNhJG4bQEUro.p8zLb8qW2U29JyOcOvbjv67YLKONDhzo3ArAIi0BpCJFe8_6
 1QYX070joJVb3Hk0Woqf38dO7ryMB.vjiPJdSCttfMS4C0e4fIBS5ki..9IGCeDEBB3KX1WJl0kk
 dIx3ahX7li8eZDha1LrlsDUD.jcSOfcCOuaSFens92UuRyVGiKB.YbW7jDYiFcrbC5wTPxXimo9U
 kTcY0dIqiZsfwOlMr.CBqubh1UZ0w.Rt3mu9dB46qgKiuhQ8t_Ibwp6bqCQh.K4ilpSQ7jJUlmBo
 pk90p_RQMgsdNaQrKrSxDV4D7Lq_ctTFMf8KOfodDoVKDVYlYf.kpnLToGtqUh524LHX3GRHVzBp
 9ZANM5ADg7MY2WDJRn1wYR8KGQjl8BJfw_tUmRq0SfgH4YfugGFActcfkFOLsii5ON3Jt5A.0e3h
 nAeX.u3PrlSQ7n6IvYdTFvxPld7v1UTzpHmzPRVaqhE9NZZUF_ec7tZAIeImF3UMQRPHbXbINNkK
 0yh33h4_nnlZZ0vFWImDnZLOasZXKYXp9nsfdk2SeiZRI6GZn1QhIwGyDoDJAs6Lp4DbeL52IAvb
 Zca2a9o5gncn1MUeNtGBstcB6MVEguuVgZPYtgZMTFTKE6pGfyA00ZWbct7B4YDU4RAimhSvJKlt
 Tm9Tk8oSrajwjZnuZJ.neb8LjUDfVIJQT6L9A.9OvBFiZiH86RGXQoVN7p_s_VP96vNktjkj19Qt
 YF3dubLL9AIdVNmsVJ2K4r0KkV8r1iszeaCTB1pPZagvKw0qZbZAh2k2RlNsBElMCOv72DrOuc96
 8bzFaCxLfsKmytS_Yz394LKqa4nGEE.YbAtqRrJmua_wGDinZyKtyrpGfq4Odpmopgkmvogun_PM
 PFemKYofEHJOyV02SDFuPkj3t7v4xCyJUHo0oI57XNmWASIs48Lhr1y3FrwdezIiUvE7ky4uwqsT
 hnIZ28qxh8E2VyfKIXhclrgJ_Iskv7QB446UqKXJzB66.a04Ke7GcUR260YOo71rp4criK7plT1E
 gR1XvaCMiUw9CQUUHXpHHpDI_9rGhxrdacVRmxybLnHnGWuf.6eriAwq8l5FRKRTP1KFZQ4RDDxy
 d6bUg96On5hf7cQPQd_iQxjs.4Do_M9dmYFXWdO9O.YPkgsRxAlOuE_vtsf6m9nhLx9LpHFm1Iud
 7bEN6enO1LQd.B4eZVxc8t_EyE.qxGGUnl_nTPOfNvGg1a5Rljyy4yXkzprdX8zAiTnDYQIeEp.a
 ZJbpurfDS6kbUw6iTOcKX1ODVZrdy7TSiG4JgMndr_.8Y0MAQ9o.XqjX79N1WEazLvMz5ZsSKhbp
 ZuGnrAo7HwtdJw2ugHYTQHuYhIKltAvq8G1FT4CktVAs.Bmm0.KjPFldf4Lo-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 48020779-2d5d-468c-9660-b694ff0c7a40
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 15:58:35 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:58:27 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 04/11] net: tunnel: return noref dsts in udp_tunnel{,6}_dst_lookup
Date: Thu, 12 Mar 2026 16:56:50 +0100
Message-ID: <20260312155657.25676-5-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
References: <20260312155657.25676-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6DD5E27546A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update udp_tunnel{,6}_dst_lookup to always return noref dsts. The dst
is only valid inside the RCU read-side critical section in which it was
queried.

The dst is fetched from the dst cache (as noref) or returned by a routing
lookup operation, in which case its refcount is either stolen into the
cache, or decremented shortly before returning (in case the cache can't
be used). This is safe, since this code runs in an RCU read-side critical
section, and the dst only lingers until the end of said section.

Update all callers to use the new convention (of no longer calling
dst_release, since all dsts are now noref). This affects the bareudp,
geneve and vxlan tunnels.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/bareudp.c          |  6 ------
 drivers/net/geneve.c           | 13 -------------
 drivers/net/vxlan/vxlan_core.c |  8 --------
 net/ipv4/udp_tunnel_core.c     |  6 ++++--
 net/ipv6/ip6_udp_tunnel.c      |  8 ++++++--
 5 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 92ee4a36f86f..456bc17c352d 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -364,11 +364,9 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
 	return 0;
 
 free_dst:
-	dst_release(&rt->dst);
 	return err;
 }
 
@@ -434,11 +432,9 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
 	return 0;
 
 free_dst:
-	dst_release(dst);
 	return err;
 }
 
@@ -524,7 +520,6 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
@@ -538,7 +533,6 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 	} else {
 		return -EINVAL;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 4216a8ffd591..8a918bd009dc 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1268,7 +1268,6 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return 0;
 
 free_dst:
-	dst_release(dst);
 	return err;
 }
 
@@ -1327,7 +1326,6 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(&rt->dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info;
@@ -1338,7 +1336,6 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(&rt->dst);
 				return -ENOMEM;
 			}
 
@@ -1347,13 +1344,11 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(&rt->dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(&rt->dst);
 		return -EMSGSIZE;
 	}
 
@@ -1396,7 +1391,6 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1439,7 +1433,6 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info = skb_tunnel_info(skb);
@@ -1449,7 +1442,6 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(dst);
 				return -ENOMEM;
 			}
 
@@ -1458,13 +1450,11 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(dst);
 		return -EMSGSIZE;
 	}
 
@@ -1488,7 +1478,6 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
 	return 0;
 }
 #endif
@@ -1576,7 +1565,6 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
@@ -1602,7 +1590,6 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 #endif
 	} else {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 4482a47dbe15..39fb2e6df6c4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2320,7 +2320,6 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
-		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
@@ -2528,7 +2527,6 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.dst = saddr;
 			}
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2545,7 +2543,6 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
-		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2603,7 +2600,6 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			}
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2621,7 +2617,6 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
-		dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -2641,7 +2636,6 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
 		DEV_STATS_INC(dev, tx_carrier_errors);
-	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
@@ -3248,7 +3242,6 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					   &info->dst_cache);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
-		ip_rt_put(rt);
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
@@ -3264,7 +3257,6 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					      &info->dst_cache);
 		if (IS_ERR(ndst))
 			return PTR_ERR(ndst);
-		dst_release(ndst);
 #else /* !CONFIG_IPV6 */
 		return -EPFNOSUPPORT;
 #endif
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..c9c3fe8f0158 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -240,7 +240,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
+		rt = dst_cache_get_ip4_rcu(dst_cache, saddr);
 		if (rt)
 			return rt;
 	}
@@ -269,8 +269,10 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	}
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+		dst_cache_steal_ip4(dst_cache, &rt->dst, fl4.saddr);
+	else
 #endif
+		ip_rt_put(rt);
 	*saddr = fl4.saddr;
 	return rt;
 }
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index d58815db8182..94901935c9e9 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -130,6 +130,8 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *
  *      It returns a valid dst pointer and stores src address to be used in
  *      tunnel in param saddr on success, else a pointer encoded error code.
+ *      The returned dst pointer is noref and must only be used in the RCU
+ *      read-side critical section in which it was queried.
  */
 
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
@@ -147,7 +149,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		dst = dst_cache_get_ip6(dst_cache, saddr);
+		dst = dst_cache_get_ip6_rcu(dst_cache, saddr);
 		if (dst)
 			return dst;
 	}
@@ -175,8 +177,10 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	}
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
+		dst_cache_steal_ip6(dst_cache, dst, &fl6.saddr);
+	else
 #endif
+		dst_release(dst);
 	*saddr = fl6.saddr;
 	return dst;
 }
-- 
2.51.0


