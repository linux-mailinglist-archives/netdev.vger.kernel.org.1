Return-Path: <netdev+bounces-253726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BW+I9hkeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4D909D2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981F1301224D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC4328626;
	Tue, 27 Jan 2026 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="um+5a7GY"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE221773D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497736; cv=none; b=cSZoBPXu6tyCUsphgc2JsrBlCk3SkNCdKo3+Oo//DmOAE34hMzkZvnMHFJ8gIo1K1O/P43QOtvs87wqXaW2ESWTuQk/TdoMZsXmXv8mvDncLD82bHZypYwtDAz7gx/Yha1Pa7a+J2MV6+Wz2tZakUeCVG9wOmzW6Bp2Olevif2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497736; c=relaxed/simple;
	bh=1xBhA+SemGM8RszsJYiIlVK7UG9WJx0fAh4TOWi6Fyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkzO0kSVXancY5l6YYzXZRBRUyQrajLftbd7dldGywQtWrXqAHOfgCM+ZTliD2g3PYz9iL/FnvvmK4mtbpgDo1l2qGtIEqigBCi6E5npFqNqlGySrWdhLqakOufisUwlcwrnGdoLqJ2urPk7u5kb+ZedqyM7u79tWcG1obzhQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=um+5a7GY; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497728; bh=I70KElqDUQJQTDcufEq+MIbNvz1K2tPqb5tYJuIF/Ds=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=um+5a7GYk65IF5qkPWbNFh7bHc03WnKpZ3mSK7KYxCitf2Uq1TW1y+B5+6LW2pTVX6MJCQedKmBVfjbkIDjZ4kUsGSTRLUBh0X5U4VDMcVscp5gQ4B3E684SSCtvtpDM5g4Tf9fkUu8SHhz8TsrhLWMOOHPEFWAoyyrFaPeCn13mM7r8KJp9qfjbclxso24A73+Zh0iZ+13TuCWmFEg072rEcnaYgggGHyzaKnURuMFkVNRIlfs09OajR688cZehxbU8c/k7aIwfik856Ynupo3LgmQ3/wFSQ6kHaT3RHh1RBQGsDFLF8eS9VkbP6AJIAqqDOUDS2TZ/Z+jwEbSC5w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497728; bh=sjwFhuBsdblD1yTKgsHI/6+r/vqr0qYThcs7CJ+R2FA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=E4DqnaQ5sILOEhoGV8+pECrLeatwnydP78jVk2QYmuWgNIBVCirtbT4+xQzYsYxURvB2Caw4ISFIG03FCNgrQQAFyQ/08a75gvf8TZYYXg/7NxQp6CE5TxYUoHL8LrlRmQM0dHPcg7iRXwAofuSex/IV71uV8thyp+E7+6o9Kdu5JzPfT6Tnb4iGqg9AxiX40znrZJlu4Ic+HsP5NSjVH3sI1uvdo2HFrMffFlVbxcoiwIUBe1TlHokZhgR7W917/T1khw1iJ2a1C/Cn5zkT1pjPDWS0LNWqGxb1x+myRNgI01l249MSUE6q4LlBoR1WbXqnUaBIbMJbgJgEV9S0iA==
X-YMail-OSG: WQIksA4VM1lGbtlDARMM.r3TFl6CcsREtqM8YEB4VI5GRZGEq6HIa7VtixraIKj
 cPO5JNRSvf.EOaMckT24.tieo8GOBNirOPNegix_i3JgGpQNKHsp4zYSV3894XeScGwFnToKAI5z
 vl_1q5CRqYRLQPf_UaTfFGEHtkBPa50pHW5817YFH7u1iG4Bdt1MHfRLLADFotoq4kAyoJx1pgwX
 0ORwbuZUmVOfiZmEkjYJ6SA5BVpbatj_ThXBBKMtm8IGvbmEh2WTW42HAUYNIGA1aWsrMxisTiB2
 g5ilHEMs130kSUEzxW97z39qzcbbbecrL9gLC5UZpkFuVPWIwXZWY894Lki5gjYfwXqCxPwDIvyB
 k087FUZq4xjBfmbIP0e34Gik3QjCx6giuc6WztNZfsgUChvLiaVXh2dv6ssjyzXlP_hlclO8Gv5g
 _A8zh56W2UamxLDc1t6VkmHztif7rwShwmFLmFDU9LMLrlgpXPXv4lIVYlawmkU1CbRVAo1MPdrh
 xWYXCxQRD8yWX.P2F0xE3tR6F_9RQHoCRWVdw9yvDFfUquO6KpZ_FuBDbdoxDhWhqp1rkUUP1qOZ
 TDWLyhVMFPr7ODbOV3M4aYL3aYUfrDBy1I39db9GAOXzq23PLdg6CqGrkEuVLLEIwmXdZqRPNff2
 e33p5r__a2HlodsJwkgJz66eHRUBGq.VYkJMV46OZNpqPy.uB.2poqlGy.4rX63ROmc1RwwpVF4A
 OeRdalWvN9VFU5ttjARf06BwP7yDWub92rQXlVBlHo7uWCdKYtPQwazGnCsFO_LgxXjwx0GLdjcx
 4L0EmHiVH_FS4b9KToKCUc4FEFvdk_bqB85ZxlSDP9WsDYSeyUr4WEI9IEP_V_ee6H7tHedm_1rb
 VRtxR.ygFvCyTjCZ90Q6Kv_OoXM1kwuUGUpgk_pwrrv0Lwfk5WE3bhOcwk7CKWw2skluL4_vIo5s
 D0NF1sG.kovSVJEEDKp7zbmHf4MrQkLg13sAyMKluMT47Qslutw_kqCkjTnCXJoN_AnrCSuyZIs8
 FXqJfFmqUdxcWob3GzyQDljuDfL.42atKoYvzIej.Df1luwMSFpFmi0qSddrQ_rGNAK6bCoTknlH
 q3GJdF_Q_FC.jPkvyRZrQhXekOu0LLESMxxc72PqpJ5g3dunJrd1TJZSRBqswFQs.9aeV0lHylwr
 SbUJ_WanB1jWRBlSaeq3t1jifXBVfPD4kUzcmou4HSoRGwSzu6w9cGCbA7tzaenSRlFkjhHYRQ2Y
 z6teTGbes0Mx84JdAaDlDi9zffm7PwrGWjfmYUfJ7Hxd8QIk1ipZx7W9zfgvfPPxftD2rmsk6xGu
 Z0Ff7jTY8StMG0tguyCkRlZcqroIdLy6MpZnk2.1nwmDJotlyrBq2n96.aRl_iMm_E7P9E49VV2o
 H_X.3NryQgQsQ47l1TQLYW8Y6.cHimUKmRvX3ydISjnbhGEqf5jV44Nwb13_rx4WbjSkXyGqUiSG
 hO2KuudycDVEKFQyN7brf9peG4f79hpjCnvcjDnvRPmte2VHltdKReegm9LbgpWfPcZ5a3VA7u9I
 1pqnA0Dr1W9w2YmvrCVW0XQ03P5pG25xs_Py.fN.Q8xY9uFpI37Mnv6a_26HGxjnY40MPsMUJmX7
 T9.KzISJSirLqZ7qIsTlulQQBv34GLaIe_UyVzHFDc3vj2OhMFXyhBeHcnRXsVXwic2XGdOFJEiz
 pXR94lwpqNQEBxyJydO.yprN0xJ2B6AsWSMITTxK2oE4RRKnvgWlvfTAGe7GLRTQ0fGWVylCt24M
 HHpKGC3wj3OhVVyK5i7R7DI4I__owEJn3YDk2Xt_3KK7PwiPaMMU_QniSwVSr3h3Ga1QTdFnraZB
 QdiGc_GFTrIYJYog.5.Z7l0OFofVJtoq1YHZpYA0KZ.0uk43iv770pHGFolHCekfHu6iP_Vumu8V
 Modv8OOKzvfEUa2wNpdbKG9ablcsjQNsrChNK6y.52Cz5UUkB1uku9X1T4TPovKjCpQNf8AIMUS6
 UguxW28GEHORZxZ9BlXAVPA7ku8W_pb3bjCxaSb_BYgku5IEHFatxg4hwvX3V_bmmL8gtwFUV0QI
 HdFEFrKlYD4UO_jUfGnOwV1RxLvVMri3YEjX30OBTr4NPA71f2c6VeGdTYaPEwLG3SH8aX2CSj6t
 J0Wadhrh5QHELIBkwbY8D1tYVE_OqAo1TMS_UmZRN
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0e3a247a-6f5c-4b91-a2d7-2ec760ee506a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:08:48 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:08:41 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 08/11] net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
Date: Tue, 27 Jan 2026 08:04:49 +0100
Message-ID: <20260127070452.6581-9-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-253726-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E8D4D909D2
X-Rspamd-Action: no action

ip_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 40ff6ad9b9b9..146e354810d2 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -681,6 +681,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	struct rtable *rt = NULL;		/* Route to the other host */
 	__be16 payload_protocol;
 	bool use_cache = false;
+	bool noref = true;
 	struct flowi4 fl4;
 	bool md = false;
 	bool connected;
@@ -775,11 +776,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 		if (use_cache)
-			rt = dst_cache_get_ip4(&tun_info->dst_cache,
-					       &fl4.saddr);
+			rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache,
+						   &fl4.saddr);
 	} else {
-		rt = connected ? dst_cache_get_ip4(&tunnel->dst_cache,
-						&fl4.saddr) : NULL;
+		rt = connected ? dst_cache_get_ip4_rcu(&tunnel->dst_cache,
+						       &fl4.saddr) : NULL;
 	}
 
 	if (!rt) {
@@ -790,15 +791,18 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
 		else if (!md && connected)
-			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst,
+					    fl4.saddr);
+		else
+			noref = false;
 	}
 
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -808,7 +812,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -839,7 +844,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
 
 	if (skb_cow_head(skb, max_headroom)) {
-		ip_rt_put(rt);
+		if (!noref)
+			ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
@@ -849,7 +855,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
+	if (!noref)
+		ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.51.0


