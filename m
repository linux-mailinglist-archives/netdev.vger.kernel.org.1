Return-Path: <netdev+bounces-292192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEdNKWuFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:43:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728F5E142A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99763048DC4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3523E023D;
	Wed, 27 May 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="l5+jZpsf"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED13E00B7
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871336; cv=none; b=BqiMHuN9PoAm2/RWV8Q7DCsMlFix6ZdTzGWR7E/LOx3IWqINHKXRhp+z76WLPeM6SBDgWqj9OK3G7NDJ9Pr4ewtfgaUOCAxHVwOIUtCXpqsaVxLCHwhrLVwtxP9jIZMthjA5fXfMiswv/V1ppb3EpmFl35GtrFV584gsUaK4puI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871336; c=relaxed/simple;
	bh=atUm+c4I6aAEocJw0cXWl300NCwCOgvD2VRHRYZZ/7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwSmxbP72t/rv2YczTLpfQo7ZIY75WqXcglZ1lzQ9XXXk69GqRJbhBPSBP22vkOeD5Ch48XHwotSgApHSdKyJ/fVkzXvIh2G6M4pTY9JjESQ8tCa7s+BhnoQKmTWlRlRsr/aNZSLyaLLXdSLQ9qE0rzVy54AIAwLfDjvDYO6c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=l5+jZpsf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 62E5920728;
	Wed, 27 May 2026 10:42:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9gYAaFwN25k; Wed, 27 May 2026 10:42:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A68F22069C;
	Wed, 27 May 2026 10:42:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A68F22069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779871326;
	bh=yipK8FjG1wkn1bbO2gdJqD+Jj/yXwFwkD1A61xzlaZI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=l5+jZpsfCMthsZ5vRBz2lNGS4lZcS9iAasOL69/a2VZLSg0KLSsVBvkia6cZlTMKA
	 2BpYjg5Anl+l0A4RoJpSDBKTYtNT0RgOAq+aQDdzZHhudCFeyQdiCUF6NQkTiy/YfE
	 b0RuMdDOW12JWBWyWREl1W69ihwhniuqq1JaWHWsdtWtfdPgFaoPYqLqqJrfAfzo14
	 jk8KemBrDRnGz8jkr0s48kyOkt0VXsQxEE9ZJThmBXm/8wpHfIfnzr8Z2WlruKx9tj
	 mT05qhLhR9RytcleYZK2scfY3NVLoFTeqvZ2kc1oa4qR1e3tj3GBjG1Ktetg1wyckx
	 6C8xeWClgn5Ow==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 10:42:06 +0200
Received: (nullmailer pid 3493994 invoked by uid 1000);
	Wed, 27 May 2026 08:42:01 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 3/9] xfrm: Check for underflow in xfrm_state_mtu
Date: Wed, 27 May 2026 10:41:21 +0200
Message-ID: <20260527084148.3489759-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527084148.3489759-1-steffen.klassert@secunet.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
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
	TAGGED_FROM(0.00)[bounces-292192-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email,secunet.com:mid,secunet.com:dkim,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2728F5E142A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Ahern <dahern@nvidia.com>

Leo Lin reported OOB write issue in esp component:

  xfrm_state_mtu() returns u32 but performs its arithmetic in unsigned
  modulo-2^32 space using an attacker-influenced "header_len + authsize +
  net_adj" subtracted from a small "mtu" argument. A nobody user can
  install an IPv4 ESP tunnel SA with a large authentication key
  (XFRMA_ALG_AUTH_TRUNC, e.g. hmac(sha512), 64-byte key, 64-byte trunc),
  configure a small interface MTU (68 bytes), and set XFRMA_TFCPAD to a
  large value. When a single UDP datagram is then sent through the
  tunnel, xfrm_state_mtu() underflows to a near-2^32 value, and
  esp_output() consumes it as a signed int via:

        padto      = min(x->tfcpad, xfrm_state_mtu(x, mtu_cached))
        esp.tfclen = padto - skb->len   (assigned to int)

  esp.tfclen ends up negative (e.g. -207). It is sign-extended to size_t
  when passed to memset() inside esp_output_fill_trailer(), producing a
  ~16 EB write of zeroes at skb_tail_pointer(skb). KASAN logs it as
  "Write of size 18446744073709551537 at addr ffff888...".

Check for underflow and return 1. This causes the sendmsg attempt to
fail with ENETUNREACH.

Fixes: c5c252389374 ("[XFRM]: Optimize MTU calculation")
Reported-by: Leo Lin <leo@depthfirst.com>
Assisted-by: Codex:26.506.31004
Signed-off-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 395d82411a87..589c3b6e4679 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3114,10 +3114,14 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	const struct xfrm_type *type = READ_ONCE(x->type);
 	struct crypto_aead *aead;
 	u32 blksize, net_adj = 0;
+	u32 overhead, payload_mtu;
 
 	if (x->km.state != XFRM_STATE_VALID ||
-	    !type || type->proto != IPPROTO_ESP)
+	    !type || type->proto != IPPROTO_ESP) {
+		if (mtu <= x->props.header_len)
+			return 1;
 		return mtu - x->props.header_len;
+	}
 
 	aead = x->data;
 	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
@@ -3140,8 +3144,17 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 		break;
 	}
 
-	return ((mtu - x->props.header_len - crypto_aead_authsize(aead) -
-		 net_adj) & ~(blksize - 1)) + net_adj - 2;
+	overhead = x->props.header_len + crypto_aead_authsize(aead) + net_adj;
+	if (mtu <= overhead)
+		return 1;
+
+	payload_mtu = mtu - overhead;
+	payload_mtu &= ~(blksize - 1);
+	if (payload_mtu <= 2)
+		return 1;
+
+	return payload_mtu + net_adj - 2;
+
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-- 
2.43.0


