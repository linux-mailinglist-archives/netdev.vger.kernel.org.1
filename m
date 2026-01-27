Return-Path: <netdev+bounces-253736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEM1BjNpeGkopwEAu9opvQ
	(envelope-from <netdev+bounces-253736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:28:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B064490BBE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18E7B3005A81
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3432AAAD;
	Tue, 27 Jan 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o2Yvn73H"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F08219A8D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498929; cv=none; b=aR/2Dcn0KcAc6emJtnuv/pXuvGO3jDygDFj1LYRrTpuqNiF0jfr29ICmrb5yejrzOVpu3vLLctJaro1e4FuiaYtbrd9n8Ong9iRwCBvZihvVlkilzVXtthWaaWBb1TSyvIcnxWlfu0mBox+fobNUziLtsmRmBe9IJjYcCFXmY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498929; c=relaxed/simple;
	bh=vG898GjSLPB8Nkp+1+cRvIhbyQWjrmnHnKNrZG7p0hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USc/RFOq4CD+Rkm4EYURIh3HGxReU8R+St24/A4btiEKRR+ujyISx28vkkTHNmlgI6K4Unxijhfb8zkcDElrlKm43PvhaaLHIHpc9ih/Iio+bxCdpAXa5tzDGwfRwDg2MMFE2TPCLV7rKXXNkV7oAIqfKFBDnWmEX9Lrsg9OekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o2Yvn73H; arc=none smtp.client-ip=66.163.184.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498926; bh=4tdAyeqBQoe3LBdckitw8sweWpmC06d1RGCNpADCggI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=o2Yvn73HJKvbgOpoO93l+E8o7F3wc17rS2KIMDXf3zj7JXNK9kpTtYrDAc2yR/YAt6vxSQ7Yx3H9FEH5b4/lMiUcrNtsGrScAe6XtmHF8xgx4lInwlzALaUaFCNONP70s4CkjKKF032GpRLwnPau3WmZMNwSqNgQC4kJdVtjJQbn7K9O0Xr5dpUe28X3KUURfJXnGRJNKjBtWA5FXRigvIHabIZGFlTdpGtX/pL2zR86Mq/jSfm+35XQ/pJPJsIiBdIyQ2cD/Y6tjXcPGJJ95dTDS1Z0ZoTkgcWkfxfIkB2Zcv9SNW5vr53odUgMYa8eiUbXzGN3A5uUmY2nSugD1Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498926; bh=xQChHKSt2J98rIxNTIcWev/Y9L8td1X4X/YdvmV4MMP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Y7i3/puN243g/Rj6Bu181C8vBJoeQdsxKMio8WH30f1HKjcYC2D4w9ThEKuBY+SluSAvR7LFPTEJixPT76GVDeSjP0w2NtgrSGKla1CjD70J+riP4sf5fRxArdAuDjgZeDQblW+E6ISPFdVQrKitoa05Uw+G/GSKgs7aRnV3EkYwDDbFBzZQJc+DK9ybHztdliqXcHL7+KSviefTuIwjU09ZbDKzesCk6KLJC6OW89KZN/3EP12xK+xTThwLCyReSJhtAbUcCdubRuIFffJVDOv4U/rV+SCbQUHbLanfHDL9cVkdQ9GGf1DILoVEJdV5eZd+KmKipPZ5lq17nAmBSQ==
X-YMail-OSG: WrFsEycVM1nB997CH5ZoAlkEL3KVX2qyZjbqvGPcBEHszJcI.xt.Ce1z8Jep6R5
 u3ZuQrYdnBwH5WXtgcn6OYBCVmVq70BjaSFeBiiNcbxjTyVXeuAW4wtkjEHGEtF1Dc6aMclwHrmK
 ZtnUl4eo0HxlcJFOxtw2mMoVUz9wyp4WoqN6M2dyytFNrdE02Ys6HgC4OBix3jDOR1mTadFG5hkD
 Nye39xkOfIFMd3PLX7OCiJk15xJtcdYEdxqbK0SpO_kPGjmWlK4FhA_soxJpOKGA.pEh3gMTeGAn
 yICSeOhrxI9YD0yYAxdsCr6b.srMQ92aYhaYqbyUR4U1ZJc7y_IyIwVfj__8EM6rDzxua_4aVbT0
 Y64s5nV5XFX.oXUZ4FMZBiXzokrodufcsp0Xu_Cunq6C4B64okslxrPT76WcjyDLrXK7.TNk1YBh
 iYrDKPQSlIAkqHfWHvqYnkRktlTMVfPh7iFkGNytOWfb1t3PAMjqs5cW5KOA2uQWI1y_wRDvHuyn
 Jq9UtiT.qC8FdNNS7Fev574QCTdysAVO7cJ0BI7_3I8pQqNdvcTlfuprx4w8lAtRDaxgilgsA1gE
 cJeWBm7baQ4Qw6NGxks6u.TTXSLAhGkKXiApMtmNa4BLXWq8A2lPUB_ZhAjs79yVzID9GdMBI9yW
 M6e9Y.ahP6mI8nfyKtQe62nu16QTZT1O.APz6Xjc6mzgAPYD7qDhgyHnfmqwCs0RMAEVMgwn0su3
 HRKiQX1.UjYnjLLECXh5mkD71mAZUXOU2lY4sRc7raxdE0T3tpA8LDDAvwvo9D3DbUlXga9fBF5X
 hsQjYny3Bj_dwU2FhAASTuS2recFB6gI6BzU7soIeOIoX_teXCxzVTBUKL58MkXVN1wWNW5wbX3_
 V13LX1n3WPFYGgxI5Ywy.BsuRNqWqY9v3shXifQUDK1oP.sY.ivsAA_R26koDuKQ2cYoWOZv3HLl
 K_NGbWIjJXadFjdlgIu8oTeT6o3qR3TK1WJ8QwRtPT99p8CCzbgrVPwcYpzZawcQ7t8G3QNm_jYH
 jIMdD86rMXUbjnKiX6xcDA9bUt5EJT5AVgXjdQaXeVyz2lFnjJpqJLyIuvm2jehoLjFVdf.fuzz2
 .s38HikJuBrmK0G41NlWQyfk.0vhM3JD9NeAjXvG7LjXHzEk56Cl9eGNsHubqxlWliLvLd0goWD9
 LLzQtfeC9M2gHLZN_UbXH6EuhtGLazedPIYnbXJNl_1BkH2wafAEl7adKOL2y7F5uoOHUxrAi6XZ
 fPbXoKsLJCxH24MnmuTKk_QicLnp8fCREztlHlQL5.WHOgnTDNu1.B80Rn6uylsDszw4nPfjIOoz
 2gVQNuLup067lHFevs5omkl9fIdaID9czQ2SirKms4RpMWVIVstrVwj1s0J06yOhDN_3tHv6BpJM
 Yzh0lKEQy5gH6cxfShJIEw8R_0ftfll3DFfPVKXXVse46W99kcsYe67r4jMqAElWaUNLqfILd1fe
 Vo2d7VhPThBWxqshPV6INtiXh0RHM1Hzg_CHXyrYTD9wLp_hHwBootWUyfa6dKmGMLclakNbK3WD
 uz.YwexMavCICFGXAT2mjn.NGbW_PbOE472_5osPVJrQnAxZGaKq8xVmQ3_5Q7t9zFBRaxSiVu8q
 UzIpm_mIkwYj1c6v.xVCv2FtRyFuyAaXbvMIMe9iGdl.A9lGxeFiiQ2AgE2o3xtzSJCY2_3mbAZX
 1c74M.VUp48J9aNqJg.Ii7mdl8ZsFLPi46UiuUT57cJDf1yoetSNbqZrcIkUVAACaj8hjUrpjp1r
 MY.jkiFZbe6Mr7HZ0g3G7ObQA0QXI7nWfEBCTWsb5o909Lp.hjoH9rS9jBoXEIFnvdZ5GJpJATeD
 Z3n19andax5.xa5YnN7TysTGgmxTVySIlsK1B60W30VTBiLXe1HRLQLKJxXO72jNXgUVxd0GWR5a
 UIiB0Mtr09lm3qb1tKvSMF84BCC75JCuaAScxAVkl2RBBMJgKtBDj1nWLxuuE61734dXh0RQ1bZm
 DYxs0DyaC7sCbrV9SgwQOnTTkdJ3on4wOLHRhoFAuSr35MpBAL1ExC6Evipm7fmTbmv0fbhEQde2
 hymqLBCpftZVXht3dmFrOlACBUAqMwYA751JzgKn8m3ryNhe1dF1wl3er3SD5AHQDiGQ7ermMlN2
 k2Nr1dO4RjH8nX6f_1Wb2mdMvWMp5.YQqeO7cY0zfbA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 52db836c-2fdc-4702-8d28-fa20f201c463
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:28:46 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:08:25 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 07/11] net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when possible
Date: Tue, 27 Jan 2026 08:04:48 +0100
Message-ID: <20260127070452.6581-8-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B064490BBE
X-Rspamd-Action: no action

ip_md_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_md_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2136a46bcdc5..40ff6ad9b9b9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -609,7 +609,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
-		rt = dst_cache_get_ip4(&tun_info->dst_cache, &fl4.saddr);
+		rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache, &fl4.saddr);
 	if (!rt) {
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
@@ -617,11 +617,12 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
 	}
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -630,7 +631,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -647,7 +649,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
-		ip_rt_put(rt);
+		if (!use_cache)
+			ip_rt_put(rt);
 		goto tx_dropped;
 	}
 
@@ -655,7 +658,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
+	if (!use_cache)
+		ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-- 
2.51.0


