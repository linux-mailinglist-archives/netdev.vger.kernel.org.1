Return-Path: <netdev+bounces-251555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM0NLKG5b2kOMQAAu9opvQ
	(envelope-from <netdev+bounces-251555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:21:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5048769
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 252197EBD3D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA1441041;
	Tue, 20 Jan 2026 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D9d/mPlA"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6580441030
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927061; cv=none; b=iGdGRjp3+YCSIc6vTxudABq/MweVKdkCP8o/qqmXGzGl6Gp0wLBidKkNIFUwFFQdbWZeu1dj2/zWv0pp2511su4GDmU5ZSqxwZTWEnNJWX+75JbNbNdyhsLo2rjQ/MroFOOmt/uTvn+/ISz6o32nwlFq3I0Z/2VSfYENY+N/t8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927061; c=relaxed/simple;
	bh=vG898GjSLPB8Nkp+1+cRvIhbyQWjrmnHnKNrZG7p0hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDiO3y62TAc8D2klvIPF51UGCrH3Gi8JbJMpRt1hD/gIQAhhFki07eFJ/gqnV8ZGcl0n6f8rfq7cJDX7LyhCV/AR2DV0himmuA8Wu/pvGT9EuLpi5YTo2ASjvaIFSKJRRvhXWrbVL74R8GR2C5S0nUmp9EI7zuyD7Hb+H5yrRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D9d/mPlA; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927058; bh=4tdAyeqBQoe3LBdckitw8sweWpmC06d1RGCNpADCggI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=D9d/mPlAjnsefzwqT1SuMvI5bjqNeDpPDCZZ+V82jzO2cWLfB1561AMaOL06tKNI9HgcKXLj/Mu+epiTByg/lKqZFoDH9lpua3cAwRKJwci3Omd9/wZeeOfTDZ+flXQxDXFkdsRWVo+9ad6giQ0vMH7vjC7x9d12XV+1MhVjGiSGZH8CFOl8L6ncXzdlq6gwx/51ck5T452iHSYFuACydevcPjeka/RNZkLvb+hCTieOm+RybeaP3oa6MgpHfhtnVZ/UcNXmch2FajZYwfG6ymjQqB2+ZC5oRCdlG3LIAYnBn8iLMygc12N7fTf8+zdPCfU0EAJthEtytfyMcG4oCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927058; bh=j6ZicL5doxOX9vLW9scWAFgvd3C1C9eoNBGJlTSlP3B=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ajd9vl4NYCvQhqEti/Vj3MKVGb0g1cEiXZlOU48wLHHkdJAm67npBlyD6CH7G5aUo59UzkAfy0wJMCxm38Crk+oN1lIxkWQ2wMMjuhDC/5Uv+YNlZdFHUXzr2e2qJJUayikbR6sCcCT++Fdz+zsQ8/32dLIDHU2PGQ/FCZVi3cKGlct1OgcOATTMNoxoC/bd8udy5cyUk15qd9qZhSBLq+NHQTOyxdbyfh6nI3Ex5lXGXUIrdfOGORZVGP/2cAw/emX3osgG8FQkhcrQFs20BgSh/yokAYkOEeHiwBp23FxWXs0Ukt9afUSsPYMj2mUrafadfH5sGHvZS7niYh2lVA==
X-YMail-OSG: j5zGJJAVM1nRfJhu52fvlcqgL_b_rwrxVGzYm1qWtZge1quXZlRWwtM49oGAgJT
 EF_b867hu05IcwknYDzDpxwQ4hrOQ.1_t62X.4t3VVOYCRqtL_8YTEha8UVCq6FHwgSzBT5a2UAd
 I0PSVPFyZMQaXX4hxu01FgKJXwuNVcZUVR4sreyjJtN1jLTU2tjMoSr.x6dUhmMzT85pOTK3ollJ
 kN23NQ.5toS8HhnCtghM9L_D9HxIBi0R8zxVBHNW1qbSG8V6Bmf9nG_G0euvhQauzK7rM.wTIzPN
 qc9IZqtvobB1GReDV.cShy0Qxe1XjCPz3R_EO.bWDINg5iZv.Ap6Mct2_HLRPvjoTUczjGoiL2zl
 B.SzedfSfSsT.FcWLTJmyRWNKz7bOUkDgxS2CsINkcl5cqSTxTLF0eNjw.8foK84qHUq8Mf44Lgk
 qQfkCgeWxWplkeTwVkyqdPwsWiAHChhVA0S9nz0V7pgm9O3tfF0sqxpu._Qu.v1gvGcsHTyRuZs0
 Ptv8VKa699MWh.dkN7FrL6foczhUUyxuSu_Gak017kJmg97.K9wU4kOVSZxLex6oqrJennH3PPPK
 fDIX1YQnCzs72vcYvBtwQFJJz8QiEgv1tySRcZoETy919OiTe4DZB9FdtZu0sFzNIZAiyMslV3Fn
 s18W25OJ0UdkBuCMfGBaDEHQjb2TeHy1EN.Qp6.yzWMo0rRFXVmxTHQ79znbNk28JvHhce2UhpyH
 H7NE1r_SquvjBzb_2frc.EBZmQa69483fr5vP0kBOay9o6QiU_eL_1gDOjzPxz9__PJMXAiula.A
 0Me9wJgjSMPvr7tHwk.qwz.lEbtd6WNHXVUwkygwv_Kf8nuzTar0RCzvBqBUmMy53eV.nKJSoOSU
 bv5eXPY5diZ47Gu5N2fG_PIessRTwqRok3o2vCEz86rjQvUUcdgJzClYQo6YXze0mXidqd_deTez
 N2QhpHAxkOsdlm5avtcElate7YjDIjOpD83uXrEW5dU2VG_ypsVwaG_tT3UhA_bxlMaTEyh1bCTz
 5.qL8R_AszW3Glp86dpHTKP9p2oYV42IzUjD8AanhzM7zwGVfZ76T9PUyyZV8g3x01Ts6QxMpnMC
 u_A4_ngcrgRPJ9kOq.RylClznVn6JkGN5.kKUyJYLkkKIsdwAq_mpHJrBFWnPWFRzjufQwEWmqnS
 ERV1ypfAufAHZ8h7WflfXMNJIYioTHA0MCo2Rmtv2_5vSxmaqC6yQag2JC9lW3ck71Xh7kMkn0Nr
 pqW4FUvskxWYuH7BQ6WTsJuid591witIuSLLeQP4g_cTzEnvpweGtgammmSD.yq67rHKrL21RjlQ
 qqn1RvDwyRwKEfViwzvhwux3KwUDIEafA9iFYfUIaC_KNFbZDxC9.b5OlR0wTvUkq9Tn3790li8B
 6_mw7hjjgbQRndZqZ_9bHtZhSXoih7RFrtzVmxXtq9x5iFIHdMyMSZxOvhg5BT5HVbkLa_AHuhKt
 flZa0Ca59TUZ7EbOfd3sB26jxycrNW2DG8uvykNj4KrwpUHPhICptPXvKzzrHEagmcrLP5GNI_uL
 tvMV7EDNa4RbbiUy0JSxlcKunZ433fac2KWOuGDs0oyx9EunMg8EHvdeVp0TVp04xHKTHDBnxxdE
 6x.Q2JSXX8sWFTYqX6oVNC502bcT2rd9zcyMs7trn9.fl99auHO_kGhYtAgxnt.7RcXBTeEAUdE_
 6HS_8H18ySDx4rA2_oAw3ejQevcMdph49otSCystsqE09Jn6NYq8h2uk12NbvCnZk0U9FFqvP_eB
 _0b6I0TFcAKIdaIaGKJv2S5kgEcTecYcr0R0hz9B.5DVEWXwDRIeAJGwo9R0_903yant2OVNFInx
 qK3wZ53gRuXsnFN0ivPXVxG8VqePhKaRYg4N5rFf3q_RhPJjshd1iiUxO0lndTNi.HF_9tuXjK4w
 rWBgHzRjBxso1BtQxuwMG5.Kir6TnYFZ77N5IzdrOtd8gbz8qcvd3Ieu8Alh6eBeeo6MmqewaVF6
 Rw.QgXOfdTXI6Z7nbiad00WT3.ezh2GGXdf_acqoqAep7BoknKkArGCGGEbFOF64EEzU5QM8DHZL
 9Dur4eH5haOlwPRfbCo0NA22Nn4RnnnDGopw.u3AY3VX7jkI3fs8DaKIvFZ9y88VlOzU7q9Pc8H9
 Rs0dfa9_SyZR52MJ_7lS2rhxN_6qR0ckV72OSkG.LY6Huwg--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: a6b7912e-c6b1-42de-8a06-a3f8d2ad7963
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:37:38 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:27:26 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 07/11] net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when possible
Date: Tue, 20 Jan 2026 17:24:47 +0100
Message-ID: <20260120162451.23512-8-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251555-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 59E5048769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


