Return-Path: <netdev+bounces-267154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM6LCC/osmljQwAAu9opvQ
	(envelope-from <netdev+bounces-267154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:22:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9ED275808
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B053030DE2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A83B9D9A;
	Thu, 12 Mar 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="isTx52n0"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D13B3BF8
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331805; cv=none; b=b886z6TtLtl+g2/Ph7ukxBwS2I99T4RLnVkNmfMwHBzmuQ7NUflOVLhFmiry3SgSPdLXXD2ZcL4o7MUWj0kxz+PolxG3m6un1zdC8kl6SAuMWu5Hs8UPumjPe71HxS9pGuZ05lat4QENgpUR4YIB2D7R1JWPIBReqNqx7vpDzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331805; c=relaxed/simple;
	bh=ad/iBqtHSQHkeV4UjvjIIpL3dhrnFREGCgHKbQ4umd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3snxbiwVCFu+FCSVWHJnDkkKbc9lS+mIMbWZtybeMEtacn2ymZ5oO1JQRrWVtLFqu6stFtiCwzkE6IOkX0Szhiq8Isj+XxEq7DKRdl/lPGmLXkILExExZ6zqwwR3OblVyO/5rHOlfnIIH/bnH/TpvVmCAvDOI2/LHR/ud4P7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=isTx52n0; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331803; bh=AfGQecfGjJ1guY/UCaXifJu5T8vnIY7c1Z2gwo2ffmI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=isTx52n0bsuK1fN5SlrLPXgWRJTpr7EDeo6407hh6A/PNzBAnB0vJic2GTz2P9cTHYl+z7XhjWgux0R0KZ3339CAo51wKm8d+HCYkiE4oUK4h5btP2GrGYYed3bPnOKAVpvAqhOC5vBPx+mw/QkzN4+zzVpgH1KKBWk5sNlz7XIY1jB0lVOAwKrcIRrX2jEw/bHADG4PUV0I9fshCryRGCGRJAv9ZYGSBq5BShVhZHt+XC0MEs5APUSNg3Yx59StUWm+X0kqcU9C3KDz37pFhAusC+qib1689yxVzSl4ZkTAhIFi6dLo+n5ub/NaZPzsQDVVvxMTREV4eNXgNZxNsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331803; bh=FKPqJrdrtolCskY32+jk2IPHyZaXtvlhn5sydV5/Bid=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W/5VYA4oHt3wGQGlIXxfhOQwHCT9hDmEJg7iVqdCMMtJWypioEU/zdJ53A29xuuu2jP/9rhc0Th+vE1yJ3GeLpSqQKKRpTqDJWokwFMJm0QYOlczwsidBGk7c2UP+L7f2Ck0k8ucnkuyrnvHWHzLEn4WkdGXAUxHUn2xhy9uZjsuJ9PCV6siuQr5Ld2YBGCIBRRGdGaLYMPyKO1cjuZ5dD2f3nsscgg6h+3MXSApYIjznGbUsQ6froQzOjxD2TT/TlBnsP+Y7rK8LiWHZTEvctPNjRBH9GS0LIAMC/LbuS2E2AQ70E9w2TZaFGe/Bo4XxfYgO9vokp9qB3aSviRTTQ==
X-YMail-OSG: MYj3wuIVM1mE7LYdkYvksPoo_oq_KCMDIe5Xnc7sLUKJNxJ6.gyJjMzWogvFoiW
 E00St1ew82pPsoPFUPS3JFyfDabsJTJdEhqlnNRdU94Y7o1wTNk9dUYx1vHRHUKx1IcTJg246PcJ
 sVc5fTJd6tykdcdVexkMt7jwULgBohWBZEQMwMbT8AeHGGeHsdYJ0N6Sld0gzpAdMnGqLMVyxVVO
 JwiTZVhzo3cQ4WmVQ9e.C1ryuVv6w2rzPx_djL4WXmtqFZ0pZ299sy9YSMvldAvjD5IUrUbr9nLe
 af66gb6eF.HRa0ydX1abickxAWpbwHiYl7WLaMxEZUVLhhcR3bi6NFaIlYnxiFlrz0hFYJJNl_Dk
 YpjDsgM8h99oxHRpfKrD.DDGcivvLYSIfQNQ91KKFcC_bUmnTid5EuPYDZvqRceREsH3EAbQxQOB
 5oU7NuEYXfrCAS_JyeG33ZkOzrKEEoI_rvKTJ.NLOxvQ4s1cH5hmuUWzi0WuBTxPaTgCpVlmU5X2
 r5EgQPFYrdQ_uPp484h8hgsI1Puvaq_SxI8yD8bHjO0dozV7cU.wcIOzStDic7sqYHEf02oh6be_
 lNHCHeDVUzQibmR4G6TGmO8VrdWFMth7m.65XnKzVJAfZjgB_J9f.z2OLwgZgTdCmD.0ajXqFEDJ
 ktRPbAxg8MjcJqLo9PzpNBQ3Hwf22ZbVMnkYjjf46XLg41QwQUTaG.uA4dYn8_K65x284dZcnOwd
 fZsJK3JleNrTyqUTiRrnI1aKrkBXHI2dUc2vxwCnZmBm5qHrA14jHGSYllR7R04D3Etdl7P0X2IF
 rJdJ4yCzivy.N7U6NKy9vu3wNiR.cD5a7Ft9JdAp5n_hF4bNR7U5vVmfmAGRPLE6RbQGYlem6VHb
 hTEk5dzifjNZwFTo9swBkq5AMjcEP6rvcj4u8TYPAgxd16SzlFkjVAfz3E4fkd.TOst3_D1mbGhB
 oJFSP7w3ff8GS6ubB32yj7O.6NWbFmE3ZSDSLZX96y3t0RTjnpnTBpV5yIf3.vBWRlWNVJ4SXs51
 DWXezyuaYnt9G6e.vOOMjsL9vl2Zjac.E5nbHv297nZkWZ_Q49elO80TorHMuqDMkrodRyA8Dfjq
 571Ekavoywiqh3LMa9Dudk_wGJwCCsHhrEblrvOvGi48R9e0Zv1c1kI65TYjy1EpaJodybhKEsae
 zogSgHGOVVwrQQ_V.uzwQN8fGHjODYGQQdgKWketB4BjhgfduL3M0.0KV.UZ4TqMvN1VULp_Kex5
 w9p4iPbwnLI7FTm1aoAwMUD7YdSpuT5AE2uyQOAYN41FygR0bxzHyaki625Mf.j.ED7DaeLV8M31
 HH7QnZ_ytraCz9qALPWD6JvkJNPiXCaBLWHGNgkiWD9pWzOeiKA.4i.meYFsrMRU0RFKVY_wwDoe
 UBRQ.aEMU83Ab7zocQnBr.gDnRB11DzZMtITDnLzNg5NMkcGMm2VkxmoM5MPU.xqtZtWFYkqxBYH
 PlnQafLYuglZLDY1jcMh_WozdXurgW6LW_HzL7rVgWUB9MUCBy9vFq0SGU3aA5OXwNeSeqvflSsd
 qBOW4sYJsu9Et1aL44i8oWs0KPrQmS0pZkq0YnCk0XOOvctGgDEGzr3lLbU7KPSJ_dctjUIEWWeR
 bqshScAbSrqhuT6RiI.qbjHU_D1MuhLlTFHPy6i0nAOXrirSy5_AetTHqXaSgx.Cg2ceEkBrO0_y
 NFre0PCp4qtMakIDy2Ko5eBeruPDLrw1pHHWHoPLcVFhJcgqNuV.Lby6UaAiilwkuh6m2eBFYekf
 1j3VyXroroD0bVyXnHzLtr0NuiJaBVnpQTxeQ3QGtAE3_M_aa_U6fHaU1128tgMBDW6UG0UMvXi7
 p9U4AvMA66rxxqXAgps97FhNlGWZsw3B7t0rObkfFxldnpapL3yZE5IHprIM5rRn5QF_JYGF014.
 gkrR2J_3yEdgmwIujetTaPGUaEp9lx_YRkN1Saz53DhNK9mKUJ.VgptZa2by2_xh_q5Nca2AqwfE
 typezbUKlEpJ1LcXEom5SJqyVaIKtrPcg6WfqRyBFsSwYC05N1ZrTn67miiluPAcdmC1YmeHlKmY
 .ahJeXDmSx3CuZv.EsAbYqrTRqUyFqrnroyKvMvL6.TtIY_lG4IwnsFWzi6oUuigcJWuyNPibwal
 Ys2x312lxu49KUUCsAdJUpf7lRgqgUeHwnJx49Uwga6zvLeixtCftAM9W3Lo-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c79af9a0-18db-412f-b840-961e9fcdc3b3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:10:03 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:59:53 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 09/11] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Thu, 12 Mar 2026 16:56:55 +0100
Message-ID: <20260312155657.25676-10-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267154-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4B9ED275808
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_v{4,6}_xmit unnecessarily clone the dst from the transport when
sending an encapsulated skb.

Reduce this overhead by avoiding the refcount increment introduced by
cloning the dst.

Since t->dst is already assumed to be valid throughout both functions,
it's safe to use the dst without incrementing the refcount.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/sctp/ipv6.c     | 5 ++---
 net/sctp/protocol.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 43340eac8ec5..5c8f72cfb7de 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -219,7 +219,7 @@ int sctp_udp_v6_err(struct sock *sk, struct sk_buff *skb)
 
 static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi6 *fl6 = &t->fl.u.ip6;
 	struct sock *sk = skb->sk;
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -243,7 +243,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
 		int res;
 
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		rcu_read_lock();
 		res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
 			       rcu_dereference(np->opt),
@@ -266,7 +266,6 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	rcu_read_unlock();
-	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 815279410bf9..00e6b607ebd5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1038,7 +1038,7 @@ static int sctp_inet_supported_addrs(const struct sctp_sock *opt,
 /* Wrapper routine that calls the ip transmit routine. */
 static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1056,7 +1056,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	SCTP_INC_STATS(sock_net(sk), SCTP_MIB_OUTSCTPPACKS);
 
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		return __ip_queue_xmit(sk, skb, &t->fl, dscp);
 	}
 
@@ -1077,7 +1077,6 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
 	rcu_read_unlock();
-	dst_release(dst);
 	return 0;
 }
 
-- 
2.51.0


