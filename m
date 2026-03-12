Return-Path: <netdev+bounces-267150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJr3CnnmsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF12755EF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C4B3040221
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88A3CCA09;
	Thu, 12 Mar 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jdetjNn7"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66025D53B
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331689; cv=none; b=W2CD0bK0JzwDFDae++5Ni7PJ4j7pnBcW2dYy9Wr735ZTc8EZxaw3DhpW5+YvfpaP+pEZxIWLkQCIXHWwwiw6N0tGLDjseh+ywPs/lhYDvqMN4eV2n6uDUUVXpMF5o6X8xqpGpti4crLLtustQXIEr91NbYzpP0xAb8ZAkLs/YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331689; c=relaxed/simple;
	bh=ooTemeN8Km809dxxZFtDPWsB0qUlqF/rSjvasDGmGC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3uB6s2Q2Wx1bubb82h5HXlPtidM07rwr8OZvCmYBxh8jIcjYsXDdmi0UHlFoz8RJtyA9h965PAYnrQW9zCJXcuPi37KcXv8jYLTBrD25h736Myt8tQ+AUeTIEuvH0XLkVmo7GMXr/fPufsPwQTCglU1kdya7n6V1Kh55qI1aR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jdetjNn7; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331682; bh=/Y3fJcrt6Ty3Q9MIem0sI8UsmHaupXURzcU/a8rL/B8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jdetjNn72N1mN1BxZ7X7t9xlWZ4bsRhc9jRsFEeQwIbnut0sjLz92Q7e+2bTG2QiWR4zcE/iySeU6CupKc+1mXVlxHtMF9yE5DNBzhpBnng8DAYvcstCpJyFguA0Z2Xp2ZmeHknx4joF7HF7R/7CiXKVgK89WpyHOpfcyrGdegBgOMnLhsPfJv00uusmz39uFlkC90QG2sYemb0L99mLDPz+asINllfJEgWtYWlMnifU+NwQbX6THrRWi9G9dLy2ccUJfeZjzVBPEXSIssufwhCEbB4BQ9NFnV50xd2xuGytRnSJwIyWODK4vRngJ5tOtmC3y9TiZ4C5WuPeHxyQqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331682; bh=TWs9Uzmutvor2To5XfRXU3lNv79gDt+2bgYL+cG74F/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=R7T1dwrW2m6ZSSYBcjYKGRT6H/gjiUOqtXdlvOqNeFKI0muRBWNzTeKnXDio9sVog+TnLStF6H0FsyfG7l4VmkWE/KupsPYeZLoRgWfNvAgyrb13444qw0DEo5BOb2v+SvidrjO9DgXmLZrQ/tnVxOGtNBgwggDtB40pwjWPy3+wJ1ryqgs8nKA5k23jAF6pk6Y46xnb5CcEt/s5FGuqAPmImYi11TsttXMPPJ9gSsZws/98IaLnwzbjVIOqK+UmaNk4UfpKkya6jsRu4gl6o+mUhI0dVkWNqmCC2NXECp7romuB4KB+7AEtqA2Ih6VN9vJ3TtrniiiD3QFv9uYXeg==
X-YMail-OSG: 2wSe.VUVM1lugG0l0u4Uwh3OvZullX.o_sGQZFNsMuuIQPCUCfbYVW1LnWxslVC
 7XdrI6PbXN7dQ94PVnRyWfcKegIRVaW.LooPvsmE8vSooBz5ACVHRYP_88aeJ.0t4OeZchtOOPLd
 ayzrRFpy6zi3M0o0xxsThTDj32QgOnmwhpheLvuqoR00dorar6yvTi2UqIms4M9W2Xi3agzlNOdx
 _vQjutCsJLRcDJnvFWBYVMUKim.Rbp08wruC2BjVvW.3xbeTj76dQCNoP_HQqj5Ge_AdtnJ1NMo_
 UQMwhyCvEA5q9wYbrHoDhc72n9RP.pqDeIrSLE89thzPZzshaH2uz8NU6LNm4dPMoQpQYA6S8gE9
 A_8tADxZy57jmxhkiCgrMPC6AiR_S6uMcnYHhu7QbhH27f88aMsqYmcgWIGYC0UbL3gseHxXEvt0
 lgDXeeGLDHMwnZ4JJeK0uEivg4Ix7ukMDkWl709tnc9YPAdLG6p.WPRM6pFG.0sZvaDQSaMETUeV
 2EcF7ctfvFS2eiUAfhVMQmLHvRoHYpZADGbWO9AGZkXF.qMU6_YXnaf7DOfYECCbxvBJNh6koTU7
 6UoJu6YifUfAhfnuMjX7IgoWzpPTj9iNmbHfR.0FqmaVgzjaMFjgd31Rqfqfx4qHohKywPQGMjxI
 DbELBg4eKE5XSmjuwjnXoIjUpDLN60BSFnJ6dXOzVPcxXamfNdLeHcBj1vgVeKp5zAWL1OqZiuJ4
 52G5tBCJ8Bo2yUCCVRd6zDfXCIIn8a0.AsQovalcZXoMNpGh2Gh_e_F7VkpImCUSC3TS8FWSRUMJ
 mu0ROyX9dDGM504lOVfHJfnb24s33yUxdmcijj2FSXRSSAoiX776TtXZi9mx.MlnUeITTBDfPg5P
 gPIwAoCqQfg3CHgszbl0EbuDq7YAwSJTuarMNuIpoEJQO4XC.38KS6W9MinZsafVrL0waNpFrFQ_
 M2NJqI331q2a3OIgdz1KnaV1FWfZfHS.fs3W0qyjmlCQ6OWiupkhdy24LZZSz.5cAQYDQZ1oGX5X
 PA8sQWppDkyUQElzWpEL3_SPZ5ek5w_eIWFJx2lIEyU2oHW.vPZcx9Ful0rDtWtsD23qCiZQwIO5
 mSm81l426gQrQLJqvbJh2ZMoA7aFL8LBO0BM.grQGYOc5PXCJmdhHin7azkxyAYyz7TNhSwMW9E_
 Tr3tCtClVOqcOsS2c3xiw7eOuJZdibC3ggoc6yQtHehlvgwfZMK4xbDYltEswnjgAFjfKQDxV9jA
 WG3nVlwk2Xm.75lf5geWvLDMSd8.rtwRCC3bbmuZQjsTZ6okrNGUCV4S9ZTfF5wnemEuaDhop5fY
 .jsCeG7yK.IA1vJWgl5GHD9IhGjLuFaXorOEVMU0BmgKfVo10WqUuNPQN4I55vTW116EeQc2_S6P
 8Qv3By5t9wXCgvcl8BnjqH9saOQHKOFqIfcr1AJVhldAuiUdr8Rjku5Q6Qc8X8tQZEmw5OHlwJUu
 68wFg3i4Wgg8hS2.i63TToGKdroJd7OAOoAoEtn27bLIP5ybnLe5GTBJ.n6zi5ynwHkMJ8169PPF
 K8gcTKb0g1tI1d.f.XeU.vHVzQbuTrguaHkBQOR7pb8jK3IZg8yZ1VebnopyITr97rXouWt7MyAC
 FE64jTLwcuYpz01l_lOLS_Pl6DKT13RTTxarDAtoLQNzu28ifSGoN3pRK6NjwcAA5BT.jhrzV9uE
 qrGo9kUwZmvxvj5aZPq_yuETXg1bLI.TBIkjvS9.tZypRlke8P1yWJBvdbTzikBIgD1zAHSuB_wl
 RV3sRRuPcQIfF37TQnbTSwAkVmmN4aNVSSs6jJdktpZFLV9TWj2DhOBWPdwDuFYjF65Qv_BfrMfq
 r1xJz3tam3GuyqJnegy7IUug0qhFlWmiDgTswpppplg9tDuTVsNS1bEKf8JE1uYmc2vVtJAkQMGO
 iRDLSSCbZcIEqzQgwp.jqVjASJgVfMGbym1UleysGs8RS02.JMN1tnYeBJWmjyM.xgH9HNfYZ0Fk
 rsSiVfu9XgLVBwJF7mF_mYnXRXeDGBHHHNtYVx0GLQltYOKrj5YXkDxCsKxKfG1oNUuWjSL7wZRW
 50HtKQtEBTW0CljVQFipxjWCleHUetcqWOvNtUi4TmtIitigHvwKY90qqTHUOuqPYIVI1YMCQPr0
 KJFMxh1QDcfP27J6eBUvT29yTBF.la67amehbpH6hHjXMtSgDiUq14zXtt3M-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: da4a4fc3-d7fb-4583-8b9f-838cff9fbce0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:08:02 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:57:51 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 02/11] net: tunnel: convert iptunnel_xmit to noref
Date: Thu, 12 Mar 2026 16:56:48 +0100
Message-ID: <20260312155657.25676-3-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267150-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B5FF12755EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptunnel_xmit assumes that a reference was taken on the dst passed to it,
and uses that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert iptunnel_xmit to be noref and drop the requirement that a ref be
taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c       | 2 ++
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/ipv4/udp_tunnel_core.c | 3 +++
 net/ipv6/sit.c             | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..2136a46bcdc5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -655,6 +655,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
@@ -844,6 +845,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..70f0f123b0ba 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -61,7 +61,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
+	skb_dst_set_noref(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..8a91f36cc052 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -190,8 +190,11 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
+	rcu_read_lock();
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
+	rcu_read_unlock();
+	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index ef2e5111fb3a..34d4d72dc58a 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1029,6 +1029,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


