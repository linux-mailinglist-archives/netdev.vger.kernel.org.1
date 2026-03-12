Return-Path: <netdev+bounces-267147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNywBlTksmnyQgAAu9opvQ
	(envelope-from <netdev+bounces-267147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:05:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B138F2752C2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E599307C637
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4F3F661D;
	Thu, 12 Mar 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hQDyLP0/"
X-Original-To: netdev@vger.kernel.org
Received: from sonic310-24.consmr.mail.ne1.yahoo.com (sonic310-24.consmr.mail.ne1.yahoo.com [66.163.186.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176673F6600
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331234; cv=none; b=qdpXJuS3t84MYGwFAj5i1TcY1DSiMkJ5XkW+52ozQtE/n2dcvCV/TXrTSzyl5djFkDU2ncjEvWt6RIq+ovmFFeJZ7DrDN3S3LaaCfgyOKc0HbqVZruR5e6RHq2CPKRU6CYEwr9aL6Fqiw6BvzhD5lQZsD7bkPRP7uaLDLkGdTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331234; c=relaxed/simple;
	bh=CA7+VdT9Elfg3hUijDYBxF96lERvLYBcqxlJ8ud7b1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVGnS2CMjrFunH1P5/UtOvBGiEJWxJg+aFTI/3yZB1De7gVMANlde93flKbCtZH4f666uSn3ZpfANHxtJYr1Cho4aZyHuydDDXTzX3aHciUMWtY4SLfH+5UXREsfNziqeqsEFQ3DPaDVJAzV7h8EUqxd7zkFWUb5hKAwDgbbSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hQDyLP0/; arc=none smtp.client-ip=66.163.186.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331232; bh=EsCvYfAS5E/uumGXxgps4bKtVkCTU6uVnfZLPWKTixQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hQDyLP0/7FYz4PSUAeQtwQsQznWoYaGpOXXtPuKa+U1YauATbbPBpMjRcQ9tyDthqxLoSyuyqdcijyylM62cSHb96/psxamYWumgam+wmjYJrI8rsC1LvkYVpWIjKKTKM47sVbXrYqd56y5KWdqie0JiiI57iLQ3q2KCKpifRRLKmUmR+ej06Y1wjVJTiq4sVurF34kodk4ZIk1/fGcSFCWQ0JR7M1R3PqXCpaW/h5pOzO28OOWAjm2NX9Ou3QCOQLvw6+XjzYNNpbFRJhF0g89WS3vHmZBG7h0Mtyey47TyZ9EBezfLy1tCZT3LD2w9JulF7nR882q0/XDTxzFtTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331232; bh=TFIET5d2isMuUd7cUs+Ep6HJt74dH3un9DUrmfCBf4F=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q00nZTW5ay0pBI2/B8TdEiKtp/bZ7tL1p86v21m2/EkFoAY1TmrwwJWtGpYYbMMm/rnsnI1lgACta148ReG4Qg6Dn69eh74i7UowLC5+YBsCwf22iPoM8eb5UPY45TmBVe2IsTkmPxYRDrNONYBL5VysZq4JnjrNXAXS1rD+Rqsfk+RIvSYC3JeKzxPJM+fU2KKT0Gyr+NmmtLVslmd5sa2LbJjLeShFGiPZv0ycEm9p9+6tm9x8/K5Xi7nO9P/taY30OBs92VWoLoxolUgU9PuQkOPN2oSKR0RhkjhzU0CvGl8jDsqQYElyPnqOk/Ea1QPZ3z6CCilX635Qnfh4Lg==
X-YMail-OSG: Ur7WoCkVM1ljtb6s.u8tK9YIXnX9t4THgqKYIeBA72uEUXHnwx7mkcIFu3KQQzg
 DnvwDbVs_rLnSXoM9M6LOVWlJN0yEg1jF_U43slEF2WtnkZV1GNVT67HHi6jgrnLlEKz6WlF1I35
 ML5FYgYxXkCsa2BX9Fc_r66Uy_Ds735OYznLiJ6nLj1dyNJrxmIci2KM4K615kzHjK8yCHt.MTup
 Bym.OoXcT1l40Kt4h_Wtjd4cePe.pcgxf6rLUPD_P9tBzjriTuQIhK8XXukwp9MKEfjiuKE6IJcv
 geUKz3Gw33CUr.._TtVzBp2tS0vHyvymO6RVLnDoFLpYWxLuZTTbzapICMHd4jonDR.coFw7qtYE
 0VUc413ivtL7THJNVsjHKwA6hHQmL1Oz3A1mlfBib00RY6iYTz_m89QDEik3fND6NqZ3X0jU5vkc
 JZ_5aR9RSV5UzuXPP8D5B6laKMooosNRIhbXwxqRfNhnrWeB67ovh5qQymtY6splJ7L59Gh9ICXt
 ajXNNYpSDUHaBh6B.Lae8rhpSe8Gsm0s1siQgFvBg_EH14msjovQK39eUlqxwIalP4sHXYsU7uYm
 wHbBZjis_pCnZWgCcaPydlEv7IA9y68xUAVjL5KCx3BLLbpkKZihTg.t5jC7FABNyPJoofbLV.Ty
 OJib4KgOzRA.rbwODLJAgp6QgP_O28nnvJ6bchvC9mEmwCpTNlqA8W6ap94tz0CKAGmmqftCl8lI
 7OXqZ.ZENNfIC0c8NUk6QWoPAGQxlgJNSP5acqUuznqTJ9xVHKbCwDMl2nO84CuZdb_zF75c5rHm
 3QTowrLLZ.syNfKg3QaYx9DUz9Br8CnnjjBsGGJ2QynEJqaGmKYMiiXXOG3bbe_o10yo0yU5HxWY
 R4OvA.mpEc8EdyVXDXidFoJq48sj4574hl9KtPIX8QIPptCegqX0s3uDGP8c1hpVhddAqPcApxzL
 9HBI6mpkpwOXcBCqlGwhz8KhS2FyGZsXS1Ut8mzk0Gg0Lsd.s8.FxyMpYtxHiYe39tLnx2_Nlc0C
 s75C81PenZwRIxUoU5OUuBrYsv1OdsguPI_W5or42L.S8PrryV4qQatlS_xaYffgx3smYllA6o5q
 SvMjYxxWT.P.nm07wXDcZsCoZ7zC4bDYsKKU9Z3z_kWLdU5y6rQSWAzpOiFbLq7_YKi_hDPVz8r8
 lX.qF4QYh4qcWiNA41X2KWVVGCxEQaMkpYiRu_tjIHSGDj8DtIU4398H8EbS_DCn9i1VxPsdZP_v
 PswUSn0k_n2uNpIH74okKAXaKyndgRg4DdmOVsBdBuahZv1CTfPi08EVqM8GN_s0CMR2PJZdnU1s
 iV5FcpX5YfsRsw8DaZv4h2t7jfthPq64lz.F0HQF0lTZh._LMz29mhhqCbN7uhW7PteVtQrHoduy
 4hphx830mvAb0HFteab0biYeEZUcu8kyG2C2TlerJcmr..xchCjxKeAHi.qcP1vjqpbVVJLsALFR
 QeyX_EV2Mryiez2Hkda0uUDO4956IP_vCalNslGldaLjd.MCEd4T9VGCPtm4SEEycA2DPK3KqSFN
 8KMfozahzTzGOz.AZ5VFfvXapcYWs4yeicjyywbdjGz64NERcplO0lO9ZS.LKEusqUmfiynGIBfo
 NBSkGae9QmbxKv9Y02YcmiaahXAeM2yKbOC_MrfilvGeXU09pfNscXZvUWOUYjy9vlR2ewCLrMDz
 UcX1kF.iEdoPK1lusXkaSQt6_TlG_SWJn8JMO82GHebB4yRzXFCY.z7TRI7_GyMNNperUyzV1gqB
 PVv_LM5DxB.hQRq5HWo21PwPJ1SIaNZhFjVKGOJztVv8xcBRhT5p4xlhPI25j_CKfVx3EwRyDlMr
 K.XcfBe22yngNGOtbMVNo_KIQRlzl0Mx346oulYNkiJqk17QfG1ULJ6mPcqFeDtNvI3AoFypndiU
 P9UFcDEfdSnflBV2sPjxi.fHd3idKYvaFUEp6CoAWzzgEN0CuGBbV9yiqSibuv8lIxMEFrCem9Ld
 CDR20YrmwVqG.lthokpH9hFQeHfq93gm0XCP.vmC8uUUbwHcJ.S_yuO2d9QqnKRvlyn6v4rnUcmX
 9.fJhXCdJFbE6hZ9Ec.uBFQ9w3LI4ABCgVd.Q0LvYFjO4c2WWS1gueqb4W0t8ZluUSLhYbsatDET
 FrsnfkbzKQRkiac4F6gQOJxHnB7NhGUBbUz30rO_KLH0nZTjTnNhrKqcnY74-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: ea8d1056-dba8-4e8c-9e2c-dd76c3423d2d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:00:32 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 16:00:25 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 11/11] net: tipc: convert tipc_udp_xmit to use a noref dst
Date: Thu, 12 Mar 2026 16:56:57 +0100
Message-ID: <20260312155657.25676-12-mmietus97@yahoo.com>
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
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-267147-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B138F2752C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tipc_udp_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for tipc_udp_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/tipc/udp_media.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index df0d82fed02e..4e1db2915437 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -175,7 +175,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	int ttl, err;
 
 	local_bh_disable();
-	ndst = dst_cache_get(cache);
+	ndst = dst_cache_get_rcu(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
 		struct rtable *rt = dst_rtable(ndst);
 
@@ -191,14 +191,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(rt);
 				goto tx_error;
 			}
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
-		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -215,13 +214,12 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(ndst);
 				goto tx_error;
 			}
-			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
+			dst_cache_steal_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
-		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


