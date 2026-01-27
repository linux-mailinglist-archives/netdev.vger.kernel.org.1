Return-Path: <netdev+bounces-253725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJXUL8dkeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:09:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CAE909CB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AE230125F5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E0329E50;
	Tue, 27 Jan 2026 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ok+ix2cE"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01643EBF05
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497669; cv=none; b=Jtjflvrq8/6vExXUKuO/fDWqfZrokg5YGKGfS85DyXDbnmPUoGJndjxeIa4L5cgmJsZY+iS5A3nbl+7gVQiIdPCX6fbIg3yS1+xL746VlcaXmSg1p8vv3eCAnQuhyiYz28HO3am+l1UWE5iSkrDShtHnoqGR0v1rpMOhtkLp+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497669; c=relaxed/simple;
	bh=3Gp5upKbyl1ZxF8EV5ygpI67gK0dUiMe4T03IdO59lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpKzO+fJMIw+uXRGlttS+a8odVP1xNZd1AcjuO7hDbMUXyVsLUd2mXXSJqYwe/O7aLtWArtrVmL/OIvr86Glhf0vG+PZGvG+Zk3RmUH1W/gG66YPfy55Csa9uY2vHr1mTPa8Hp34Sdh6eyK5VGcXO7oIgdOJ6cyJf2F0TiStfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ok+ix2cE; arc=none smtp.client-ip=66.163.184.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497666; bh=xIg2sFP67U7nlCmr6mMVughql4UTbfa691rNQ63zUeo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ok+ix2cEVc2Fx/vHo1K+fV+KHOszqLEbo/tW/88dzhqjBO0y9rksj9qbs5SaQiT/p3VngfMxeGeSZRdaCEEyJJsYkam6pJjxIMbqzvpbIq8OQGArwNkL6s7Q4YMd2PoUnP3r9Qc/64uHIRQ67TKRdEVgYL6VpGYzhotWHOnBGXWQHcWdmbyeApDRu56VN7u/uOFYijlWO0hFVafGAqVA1in01MRKPtpfXUFawW0ksSmDZ0cntYidb9U2iK71x+5vwHfhOFLA1923HJmWihopXqFXhE8vXTWwftzHso/twsNaU/YQ7zvWHhTZ4HLdXzl9dqJJIeLl6xt9Ag9lgQ7X+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497666; bh=Mvre0ZtIAI9UAwFe5SLXKVusmK4bbEFOVbDsixjf566=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pfqaggqvHLzugcLblvYTs+G/gPiBmIrcBcgyd4rA1v4FyMweZeJmOAvFRlIgXrgZvZdgXxb6fBVnOauFzonZV+JKc0Wlb9zqu6BJ93RlgnbNfiU4xoS7o6uNZaFkX5lHrcFoWR8GpMvG9uQSdJT8agyIprzMFIEAw58lM83nKdDCfODXwaXVT6I4SZKt0OYBnBmCnm5rl2wOL3EhdDEej/r5/Kq4gaucScDmiiKD2zDPLXcDZMxgAIR7BF3/MCsWX1bVDlaLJzKC/nqIjn4bDJc6RAtGj+M73ZQZSwec2kxhcOLRZTC2Z1Zem+6/XNAe08X0lca/nsGQEicBb0fagw==
X-YMail-OSG: x_SSs9YVM1l8b.RWxm3c4..Ndmv_cLjc6uLRNjDYLY1CMHa8UBSvOD1NKh6lsDq
 dGKjKkoMqs5gXThOTcHeg9ktkf4jRNTHZOAqkvT80MyFi1mFtcf3WnRUNnz41x7FjiA_hMWQZhBD
 1.kE1RK8OXqfmh04YTVYeX7Pm89Toy3CbkuEUjmTINShEtrjR9GvVqY5GN73VNFwOXvRrFXLvFih
 htGsdS2zVNjJaOURI_8eCr1fye1lRVUeG0DjpGmU5Nv0Gc8KoP7jHMdZUoyjRhvkbIA4gcuz2.cj
 LYWsaqWQK5iif8_J_UFlORkPWA3Cct5CFCToH4dpvc0TnZpIBPLE9H5rcSzIgSSfRUy78cLQ62GB
 wkUw1RartVBaIC1Z3v3GydNRAvfik6qH8CeTB3FXMR2MP2_zL2EndVmrsWtGrwQ0lS6b1MgHZeYc
 BD6qqQHIKAtrVG0gwItMF_Cv7AZuP18qcvGcIEOBGwYmVpM8qOCAND4VXuKesVunskZyzPW5.jjT
 kazwVyq0LPZzFojPV5ogEm8m4mqNHiXJ1K670e.YBROj5oT.1ufyo.vdec7acff5NYxW3veJgkwu
 Yhs9VvzZ91eWRVH5k7gUeT9fD2M5m5_Okt2Gta9E8qs7eDXd1OR5huCcj.dA2WHkpCXmO1_Ry_TF
 130r5MEL1LZ1Nk.Eu.dg_T4RVVOF_53t3svE9VzHoRG7jIz7dRvMjMxxXUdFlHXBTNjWHDRefDC0
 34qvTYgofDivPKmhaSISqx2V9ieLa0kGgKOM0r7yGP16tFogXnBAHC_nGJApKb1IG_qFuDeARiSH
 s47QdDEzIl7Y1xhPqA7P3CVFtdnHE1Kibb3GXI6iwJPFkmhOcqtjKBBmL8O5MLSDFC5SvGIMKpAb
 om6WmMLSPbGaKJ1BF9zrTRJXE92QLX.efXTF06CYG1XgsRzGNzoYHnzeZP4X2iWM.6OCl3j9361d
 CrB_z4P4q6mo2M8GULj7ojoPrFqSKdEDGndAUXatlVrIuUfFaE7r_bzRvbNN4yGRVHWW5PUtPOHB
 8FYZ0YZsQn3Tod7CMvooAfUfRoww0ZLetkAbduNzmTMyaZoKrHAoY_xX6eSkDKgQlFxhphqepF0j
 5TmpZUXi67oHtEF8rkMAIPvk76uAosFXHICphnRHJ.SiCPuLXQPEE2vLpRyDtwpxZ1bn_C0wKERu
 ac6tl.NTSixC4Qgt7f.X8MTiYEk9FUijY6qEKqgDre0SdresD6iTCT86QxBb5L7VNQiQeaCAxcGT
 r1b8u.MTwuwhu1K7V460A_wIfKbLs48j5NA2msXV1Y_z5CSAUuYkrq7fK4oOeeleNbA_M8RMuAPx
 NVh4kW52skCh5zfAdPgZRCVLYkkEm4m_87EvNwepMexZfjXK0g6.FMBkynGyLNeMRkGPCyglnGKn
 tStK6Wnn8CKtnHdNbWbZTjn5J7r6VZYjfdyTEz8BUM3yRisHcZDpinYtv8BtXTN.LZj6ITnjBJZt
 An.4ox87534cupZZKN1dwv_7Ktnvk40ci.VtJ8rRvBASL0Ul80I2ICDtNlxi0Df0kZfFUjUPDvXj
 S1tzKaP3azqryJFRw5EoQZsp7dbuGaTpvybDfJKl9SL.qCDZoA_qNy8PolU2WJ5xqUvDrWXTbYUl
 Np2ptn30Zmy1tycbdjpleVgzqbxezBsHLo_FdV9d2EZ6r7A2YmU_vJvmxEWMT8pOYYj5wuR5.Aw3
 _8YMIdKcDX5Jkg4WmVgUx3zyPQCUa3Nh0CLgsvhMM6UcFN_8tV59mgDPT.OnzmzTShWSVEdfoe3q
 w6QVQzhF_pOYFGiKaFuaP2sIfh9hm8keLbVEaJOCdL2Kf0xGxgw4bQqGj8xsgJQM..QgOU7OqTvh
 vZBVCd_sHXKYg714rwWb0mjQuqqmOCoyjHBJ2CLhTszGIFriIJdAQ_zrAacRUBGaXaKoeSeQdNIt
 x8Lgb4KGSTWPUvk2BMBE8TeNwDftQwqf7aIZIFoomF2n6uCyd8KJpZTAZcNtfJbv4VAof3PHfP5L
 WXQNS8QKBdowM4QDQD.0WEoZ5haQwq3uRReEbwN0gnxOTYxxhXAxYkGxVEFd.GDqTYsNAb2.kb4w
 26CKn4BuCxBDncRpr4WipbInQKSvHr3gM1vChDtspUpjM1wPTjgw.bB9pwoEJmHgzvgVyr4Epi5H
 RWdvST8MvGbJa5FV6Ja2l1XI5Es3Y0FSj47mRhJSNQWI-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 95873767-b7ae-4b5f-b66a-cd3475f73380
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:07:46 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:07:31 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 04/11] net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
Date: Tue, 27 Jan 2026 08:04:45 +0100
Message-ID: <20260127070452.6581-5-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253725-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66CAE909CB
X-Rspamd-Action: no action

Update udp_tunnel{,6}_dst_lookup to return noref dsts when possible.
This is done using a new boolean which indicates whether the returned
dst is noref. When the returned dst is noref, the dst is only valid
inside the RCU read-side critical section in which it was queried.

Update all callers to properly use the new noref argument and convert
all tunnels that use udp_tunnel{,6}_dst_lookup to noref. This affects
bareudp, geneve and vxlan tunnels.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/bareudp.c          | 33 ++++++++++++------
 drivers/net/geneve.c           | 61 +++++++++++++++++++++++-----------
 drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++--------
 include/net/udp_tunnel.h       |  6 ++--
 net/ipv4/udp_tunnel_core.c     | 16 ++++++---
 net/ipv6/ip6_udp_tunnel.c      | 17 +++++++---
 6 files changed, 118 insertions(+), 56 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 92ee4a36f86f..5d2129c19c79 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -315,6 +315,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	int min_headroom;
 	__u8 tos, ttl;
 	__be32 saddr;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
@@ -329,7 +330,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
 				   sport, bareudp->port, key->tos,
 				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
+				   (struct dst_cache *)&info->dst_cache : NULL,
+				   &noref);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -364,11 +366,13 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return 0;
 
 free_dst:
-	dst_release(&rt->dst);
+	if (!noref)
+		dst_release(&rt->dst);
 	return err;
 }
 
@@ -386,6 +390,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	int min_headroom;
 	__u8 prio, ttl;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
@@ -400,7 +405,8 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
 				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
-				     (struct dst_cache *) &info->dst_cache : NULL);
+				     (struct dst_cache *)&info->dst_cache : NULL,
+				     &noref);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -434,11 +440,13 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return err;
 }
 
@@ -507,6 +515,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 	struct bareudp_dev *bareudp = netdev_priv(dev);
 	bool use_cache;
 	__be16 sport;
+	bool noref;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 	sport = udp_flow_src_port(bareudp->net, skb,
@@ -520,11 +529,13 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
 					   &info->key, sport, bareudp->port,
 					   info->key.tos,
-					   use_cache ? &info->dst_cache : NULL);
+					   use_cache ? &info->dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
@@ -534,11 +545,13 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
-					     use_cache ? &info->dst_cache : NULL);
+					     use_cache ? &info->dst_cache : NULL,
+					     &noref);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 	} else {
 		return -EINVAL;
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index cfc8e7b5f8f2..32ce2e197260 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1227,7 +1227,8 @@ static void geneve_put_gro_hint_opt(struct genevehdr *gnvh, int opt_size,
 	memcpy(gro_opt + 1, hint, sizeof(*hint));
 }
 
-static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
+static int geneve_build_skb(struct dst_entry *dst, bool noref,
+			    struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
 			    const struct geneve_dev *geneve, int ip_hdr_len)
 {
@@ -1268,7 +1269,8 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return 0;
 
 free_dst:
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return err;
 }
 
@@ -1300,6 +1302,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 df = 0;
 	__be32 saddr;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
@@ -1318,7 +1321,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				   &info->key,
 				   sport, geneve->cfg.info.key.tp_dst, tos,
 				   use_cache ?
-				   (struct dst_cache *)&info->dst_cache : NULL);
+				   (struct dst_cache *)&info->dst_cache : NULL,
+				   &noref);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 
@@ -1327,7 +1331,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(&rt->dst);
+		if (!noref)
+			dst_release(&rt->dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info;
@@ -1338,7 +1343,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(&rt->dst);
+				if (!noref)
+					dst_release(&rt->dst);
 				return -ENOMEM;
 			}
 
@@ -1347,13 +1353,15 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(&rt->dst);
+			if (!noref)
+				dst_release(&rt->dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(&rt->dst);
+		if (!noref)
+			dst_release(&rt->dst);
 		return -EMSGSIZE;
 	}
 
@@ -1386,7 +1394,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	err = geneve_build_skb(&rt->dst, skb, info, geneve,
+	err = geneve_build_skb(&rt->dst, noref, skb, info, geneve,
 			       sizeof(struct iphdr));
 	if (unlikely(err))
 		return err;
@@ -1396,7 +1404,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return 0;
 }
 
@@ -1412,6 +1421,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	bool use_cache;
 	__u8 prio, ttl;
 	__be16 sport;
+	bool noref;
 	int err;
 
 	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
@@ -1430,7 +1440,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, key, sport,
 				     geneve->cfg.info.key.tp_dst, prio,
 				     use_cache ?
-				     (struct dst_cache *)&info->dst_cache : NULL);
+				     (struct dst_cache *)&info->dst_cache : NULL,
+				     &noref);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
@@ -1439,7 +1450,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		return err;
 	} else if (err) {
 		struct ip_tunnel_info *info = skb_tunnel_info(skb);
@@ -1449,7 +1461,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 			unclone = skb_tunnel_info_unclone(skb);
 			if (unlikely(!unclone)) {
-				dst_release(dst);
+				if (!noref)
+					dst_release(dst);
 				return -ENOMEM;
 			}
 
@@ -1458,13 +1471,15 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!pskb_may_pull(skb, ETH_HLEN)) {
-			dst_release(dst);
+			if (!noref)
+				dst_release(dst);
 			return -EINVAL;
 		}
 
 		skb->protocol = eth_type_trans(skb, geneve->dev);
 		__netif_rx(skb);
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		return -EMSGSIZE;
 	}
 
@@ -1478,7 +1493,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			ttl = key->ttl;
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
-	err = geneve_build_skb(dst, skb, info, geneve, sizeof(struct ipv6hdr));
+	err = geneve_build_skb(dst, noref, skb, info, geneve, sizeof(struct ipv6hdr));
 	if (unlikely(err))
 		return err;
 
@@ -1488,7 +1503,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
-	dst_release(dst);
+	if (!noref)
+		dst_release(dst);
 	return 0;
 }
 #endif
@@ -1551,6 +1567,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	struct geneve_dev *geneve = netdev_priv(dev);
 	__be16 sport;
+	bool noref;
 
 	if (ip_tunnel_info_af(info) == AF_INET) {
 		struct rtable *rt;
@@ -1572,11 +1589,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					   &info->key,
 					   sport, geneve->cfg.info.key.tp_dst,
 					   tos,
-					   use_cache ? &info->dst_cache : NULL);
+					   use_cache ? &info->dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		info->key.u.ipv4.src = saddr;
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
@@ -1598,11 +1617,13 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 					     &saddr, &info->key, sport,
 					     geneve->cfg.info.key.tp_dst, prio,
-					     use_cache ? &info->dst_cache : NULL);
+					     use_cache ? &info->dst_cache : NULL,
+					     &noref);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		info->key.u.ipv6.src = saddr;
 #endif
 	} else {
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index aacef14cd300..491253467e59 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2300,6 +2300,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
 				 struct dst_entry *dst,
+				 bool noref,
 				 u32 rt_flags)
 {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2315,7 +2316,8 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
-		dst_release(dst);
+		if (!noref)
+			dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
@@ -2348,6 +2350,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	unsigned int pkt_len = skb->len;
 	__be16 src_port = 0, dst_port;
 	struct dst_entry *ndst = NULL;
+	bool noref = false;
 	int addr_family;
 	__u8 tos, ttl;
 	int ifindex;
@@ -2473,7 +2476,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
 					   &saddr, pkey, src_port, dst_port,
-					   tos, use_cache ? dst_cache : NULL);
+					   tos, use_cache ? dst_cache : NULL,
+					   &noref);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
 			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
@@ -2487,7 +2491,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			/* Bypass encapsulation if the destination is local */
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
 						    dst_port, ifindex, vni,
-						    &rt->dst, rt->rt_flags);
+						    &rt->dst, noref, rt->rt_flags);
 			if (err)
 				goto out_unlock;
 
@@ -2523,7 +2527,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.dst = saddr;
 			}
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			if (!noref)
+				dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2540,7 +2545,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2559,7 +2565,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
 					      ifindex, &saddr, pkey,
 					      src_port, dst_port, tos,
-					      use_cache ? dst_cache : NULL);
+					      use_cache ? dst_cache : NULL,
+					      &noref);
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
@@ -2575,7 +2582,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
-						    ndst, rt6i_flags);
+						    ndst, noref, rt6i_flags);
 			if (err)
 				goto out_unlock;
 		}
@@ -2598,7 +2605,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			}
 
 			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
-			dst_release(ndst);
+			if (!noref)
+				dst_release(ndst);
 			goto out_unlock;
 		}
 
@@ -2616,7 +2624,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
-		dst_release(ndst);
+		if (!noref)
+			dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -2636,7 +2645,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
 		DEV_STATS_INC(dev, tx_carrier_errors);
-	dst_release(ndst);
+	if (!noref)
+		dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
@@ -3224,6 +3234,7 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct ip_tunnel_info *info = skb_tunnel_info(skb);
 	__be16 sport, dport;
+	bool noref;
 
 	sport = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
 				  vxlan->cfg.port_max, true);
@@ -3240,10 +3251,11 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					   &info->key.u.ipv4.src,
 					   &info->key,
 					   sport, dport, info->key.tos,
-					   &info->dst_cache);
+					   &info->dst_cache, &noref);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 	} else {
 #if IS_ENABLED(CONFIG_IPV6)
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
@@ -3256,10 +3268,11 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					      0, &info->key.u.ipv6.src,
 					      &info->key,
 					      sport, dport, info->key.tos,
-					      &info->dst_cache);
+					      &info->dst_cache, &noref);
 		if (IS_ERR(ndst))
 			return PTR_ERR(ndst);
-		dst_release(ndst);
+		if (!noref)
+			dst_release(ndst);
 #else /* !CONFIG_IPV6 */
 		return -EPFNOSUPPORT;
 #endif
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d9c6d04bb3b5..5ccfed54c546 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -185,7 +185,8 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     __be32 *saddr,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache);
+				     struct dst_cache *dst_cache,
+				     bool *noref);
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
@@ -193,7 +194,8 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache);
+					 struct dst_cache *dst_cache,
+					 bool *noref);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    const unsigned long *flags,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..978cd59281f6 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -233,16 +233,19 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     __be32 *saddr,
 				     const struct ip_tunnel_key *key,
 				     __be16 sport, __be16 dport, u8 tos,
-				     struct dst_cache *dst_cache)
+				     struct dst_cache *dst_cache,
+				     bool *noref)
 {
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		rt = dst_cache_get_ip4(dst_cache, saddr);
-		if (rt)
+		rt = dst_cache_get_ip4_rcu(dst_cache, saddr);
+		if (rt) {
+			*noref = true;
 			return rt;
+		}
 	}
 #endif
 
@@ -267,9 +270,12 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		ip_rt_put(rt);
 		return ERR_PTR(-ELOOP);
 	}
+	*noref = false;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip4(dst_cache, &rt->dst, fl4.saddr);
+		*noref = true;
+	}
 #endif
 	*saddr = fl4.saddr;
 	return rt;
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index d58815db8182..b166ba225551 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -126,6 +126,7 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @dport: UDP destination port
  *      @dsfield: The traffic class field
  *      @dst_cache: The dst cache to use for lookup
+ *      @noref: Is the returned dst noref?
  *      This function performs a route lookup on a UDP tunnel
  *
  *      It returns a valid dst pointer and stores src address to be used in
@@ -140,16 +141,19 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
-					 struct dst_cache *dst_cache)
+					 struct dst_cache *dst_cache,
+					 bool *noref)
 {
 	struct dst_entry *dst = NULL;
 	struct flowi6 fl6;
 
 #ifdef CONFIG_DST_CACHE
 	if (dst_cache) {
-		dst = dst_cache_get_ip6(dst_cache, saddr);
-		if (dst)
+		dst = dst_cache_get_ip6_rcu(dst_cache, saddr);
+		if (dst) {
+			*noref = true;
 			return dst;
+		}
 	}
 #endif
 	memset(&fl6, 0, sizeof(fl6));
@@ -173,9 +177,12 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
 	}
+	*noref = false;
 #ifdef CONFIG_DST_CACHE
-	if (dst_cache)
-		dst_cache_set_ip6(dst_cache, dst, &fl6.saddr);
+	if (dst_cache) {
+		dst_cache_steal_ip6(dst_cache, dst, &fl6.saddr);
+		*noref = true;
+	}
 #endif
 	*saddr = fl6.saddr;
 	return dst;
-- 
2.51.0


