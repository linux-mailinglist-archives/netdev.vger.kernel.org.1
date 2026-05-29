Return-Path: <netdev+bounces-293061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAHICJdGWpevwgAu9opvQ
	(envelope-from <netdev+bounces-293061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D015FFFB2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C4D3115158
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE013BFAF0;
	Fri, 29 May 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kTmjeng7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5ED23AB88
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046822; cv=none; b=hmJCrSp1UBkWkLcq5ofPW75e+I+ldVtCqbFbonAW1PGkrQbf6awW9upsl4zes1+1VwwoMcvWAsuPUOhpHTZSGDl/D5tZsu/EqwbqKVVAiZsG09TNAA6cxtuow/Ib3nKMFud+TE1vZaW82GnemWJBZR41dLn1gpE4YztdAGRnPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046822; c=relaxed/simple;
	bh=OneWzUGXJOXSxx8cKD6+KvUYaua+86LFDnRZRkPYA3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfED730LMTD8CRGeK9at5WsDWix+RIPb1tW9sbs5QzLi7PbuJOGp/nP5hppjzPMz5QbWAOFfW6z6fQgyzPU7ubWI55anZjwARb7CUSBqOGVWBLwafFueAa4nZs7GdYvCfW9Hl+uR/5Yn70Xf44CKV6AOLBrNRCeF/08g4eYd3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kTmjeng7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C201B2019D;
	Fri, 29 May 2026 11:26:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihOz_DN-ZAGS; Fri, 29 May 2026 11:26:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1039E206E9;
	Fri, 29 May 2026 11:26:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1039E206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046819;
	bh=hUhBaH+Tkjie86cuxJ1Puw4FSYGFqVLzTaWYc1c3iU4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=kTmjeng7nVbYC7YCirEu6WdAq8bE45gut1MRm86BgfX5gqGTUf2OS9QoMQSeTYTrW
	 lJwl64yT+WcKjAATxmvx/9uALHVh3JNFEopHJsa8w3EZ4mcG/RLyB5O4p43lcGQSqO
	 9/mQs1rlctRF2vIeTQIIw2Rwf2dCVnQWIASAgs49wGU0ZKZ4HEC2nM/jjMTU3yqAFY
	 msAY9ChitdWkWMSPUZPzr/0IHyJR/LF48gAlsL+bkk9XVEWXAm7dMySwED/GOL3tTe
	 4PD61NvZnr3yX0m6R8Vbw4l8CZDQJovwxTzXxmr3KOyWyC3IOEEKJtd1YRdXuMqQmk
	 2RTP3bf5Frz0g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:26:58 +0200
Received: (nullmailer pid 3879717 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/10] Revert "esp: fix page frag reference leak on skb_to_sgvec failure"
Date: Fri, 29 May 2026 11:26:12 +0200
Message-ID: <20260529092648.3878973-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529092648.3878973-1-steffen.klassert@secunet.com>
References: <20260529092648.3878973-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3D015FFFB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 2982e599fff6faa21c8df147d96fc7af6c1a2f24.

The patch does not fully fix the issue and the Author does
not match the 'Signed-off-by:' tag, so revert it for now.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 12 +++++-------
 net/ipv6/esp6.c | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 5d3a8656687e..513c8215c947 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (already_unref || req->src != req->dst)
+	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
@@ -220,7 +220,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb, false);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
@@ -569,10 +569,8 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb, true);
+		if (unlikely(err < 0))
 			goto error_free;
-		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -604,7 +602,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb, false);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b963b8e72604..57481e423e59 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -113,7 +113,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
 			     __alignof__(struct scatterlist));
 }
 
-static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
+static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 {
 	struct crypto_aead *aead = x->data;
 	int extralen = 0;
@@ -130,7 +130,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	/* Unref skb_frag_pages in the src scatterlist if necessary.
 	 * Skip the first sg which comes from skb->data.
 	 */
-	if (already_unref || req->src != req->dst)
+	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
 			skb_page_unref(page_to_netmem(sg_page(sg)),
 				       skb->pp_recycle);
@@ -254,7 +254,7 @@ static void esp_output_done(void *data, int err)
 	}
 
 	tmp = ESP_SKB_CB(skb)->tmp;
-	esp_ssg_unref(x, tmp, skb, false);
+	esp_ssg_unref(x, tmp, skb);
 	kfree(tmp);
 
 	esp_output_encap_csum(skb);
@@ -600,10 +600,8 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		err = skb_to_sgvec(skb, dsg,
 			           (unsigned char *)esph - skb->data,
 			           assoclen + ivlen + esp->clen + alen);
-		if (unlikely(err < 0)) {
-			esp_ssg_unref(x, tmp, skb, true);
+		if (unlikely(err < 0))
 			goto error_free;
-		}
 	}
 
 	if ((x->props.flags & XFRM_STATE_ESN))
@@ -636,7 +634,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 	}
 
 	if (sg != dsg)
-		esp_ssg_unref(x, tmp, skb, false);
+		esp_ssg_unref(x, tmp, skb);
 
 	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 		err = esp_output_tail_tcp(x, skb);
-- 
2.43.0


