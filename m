Return-Path: <netdev+bounces-282629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKTILXrE8mkjuAEAu9opvQ
	(envelope-from <netdev+bounces-282629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:54:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82449C99B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 343AA301FF63
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41433F8B1;
	Thu, 30 Apr 2026 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+EibLJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920E331A66
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517359; cv=none; b=kzhHVP/foPOAxyak1goZsVrpnaOOjnUGVBlcy+3CWGFjzlGxvK+19k857aFvrmUAf6XSHLLBAnlXSrUGNlOB91YLy4ijdHHGz23OnSNnhu6SIUJ6Yafdq8FZ2P/MmsJIUyrq0miEh/fDykPva+0CrwDdbE7tCFlDFf1sy/zg+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517359; c=relaxed/simple;
	bh=Jzgtlfa0XPZihBMBAayfdTGA4qfZ/66+CFb4fTrbr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lQ0pdLOt47uIQOSM6Hu45zHoM6peyp9G0eGVFyMO7DSyReIK4tgNfII+V4N60aLZdn6uuFJSGAWzYXb6DjmOhnTLKJtp2/PhAiEjLWJ9szAREgInVwyHnxZmBiQaK9Wbu5lV7Cv9RvAF/PXgZAGjU+DOS82ClHRl5Jls6LrnC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+EibLJw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2d3a9e149so7106325ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777517357; x=1778122157; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFqSQggU6wMZ3sBcEBzUN/eFk5956xtC2nEBI87o+d8=;
        b=S+EibLJwmE2dTvXZvzrJ3NDUFadRQwEwaCedn0MlO+Ys8RRVCUcxZR36hRKdMZlpMa
         wC7aCZ4oxX6pRCC++ArI/QOL0Cb26QbpOTYkEMMiY3fnA445tshDvL7dHQX4BvXLo2+a
         HlyYILSEHmAIm8P8UgOaWsR75G5WYjwtr5axPWHJ0jIWQud0NLvEUJweTz8yX+LcCgnx
         3+2DInJICqYacGcADgxDUWmgnyaauXTVG2JXjI+9xvCXxqb7C7kdb1dEP8J+E+MS7XA3
         9+yUYEN/gGxlHy7M9ijCIKIdOG+rCOvOxTTNkW/oS84bHyRA/puTQwzlxNlJvDVUyOwL
         T3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777517357; x=1778122157;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFqSQggU6wMZ3sBcEBzUN/eFk5956xtC2nEBI87o+d8=;
        b=HrYwD70mHmQMu9fP1+KULHp4iwDUl/PaFMNzX28ttlCPBqThzv4T6zxVrukNBObSzw
         CJ6rrgLU32vXOygcA9v/1Edq7EiMV3XrbnG5Qtpt/vuruOdeRrPDA3eNaVCNw0zQyeSU
         2sxveUKWvZoo2ATjs0/GFOT/er7JxMbHFLZXE7WTX1SzMxWaYsxVZbg8FELTcpRL3voB
         5GYeZgFJAGFzBKwP6owRY5ZUDg+krw9/oZd9RkJJEGRL+Z3z+2dxAhya/p89CsAFeKAI
         +m2IdpHnB1Oflt+X8pVo7dgGFNE7kkMr9i05MXGo8H/zeLubFlLiO9r9ep36RqzMd3jG
         OilA==
X-Gm-Message-State: AOJu0YzlRygHGDV5MozSzbr3WNXxYJIjIP2YdCfddmnxLN0wy5c4i+iA
	vVOYIt3fLK+J/pheWQjOsJruL6vU9i+gGhAJNgqGkwFDuzl1kC2tQXiekWROau76
X-Gm-Gg: AeBDiesJ8b4ndwfI26LnTO/sm8JwJ32yJ5etei8fGe8RDVE144GBLcqrzcjFz3Zok9l
	pWsCDfsjQyA4rQioZVtR3X0yfUtcvtCMCCwrJKk7yCC7UEA/VAjLTGYcSqptkYfpnSDM3VgmwOW
	XoDXCq47LWFPisi7UAbNDafpUQG0G0eBf8AVKUGwJfVayT7hxhY3gG+877TwdqsF/1fusXyUo0M
	QnYnnHfcCHccbVrmok41PaMaJxGq52u5ZQowFEexnFRiBzMPGWLTYrSiS5rfek148VCgciyGaoJ
	Tg32ZNfcX51sud1zTDCgnNYTvfSgbiNNGnLYyl1REnM/habtdWbUK4z4qMXiAkln0eJfDsPhdQA
	HGgIU5F68SrkDj/awBwbiknUOLczfKMtdlmJ9nJuwd+iPkUMQIlMqcGam6wqtuIZshCbZye2xDP
	V6JfMp4iTHrJT8Y1aVritv1+nObNFxbT56tZMubKg34kdAJ8293/Fk3w==
X-Received: by 2002:a17:903:1a86:b0:2b2:eba4:2149 with SMTP id d9443c01a7336-2b9a47711b9mr5385535ad.30.1777517357156;
        Wed, 29 Apr 2026 19:49:17 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988989d67sm36559455ad.76.2026.04.29.19.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:49:16 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:49:13 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ilant@mellanox.com, sowmini.varadhan@oracle.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH ipsec] esp: Force skb_cow_data() on RX when the skb is
 non-linear
Message-ID: <afLDKSvAvMwGh7Fy@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: AC82449C99B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282629-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]

esp_input() and esp6_input() skip skb_cow_data() on uncloned skbs
through two arms: one for fully linear skbs (nfrags = 1) and one for
skbs carrying paged fragments without a frag_list, which sets
nfrags = skb_shinfo(skb)->nr_frags + 1.  In both arms the skb is mapped
into a scatterlist via skb_to_sgvec() and passed as both src and dst of
aead_request_set_crypt(), so the AEAD operates in place over the
existing frag pages.

Drop the paged-fragment arm so any non-linear inbound skb falls through
to skb_cow_data().  The fully linear fast path is unchanged and the
existing skb_cow_data() error handling that follows the gate is reused.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/esp4.c | 13 +++----------
 net/ipv6/esp6.c | 13 +++----------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcdef65..a6fbdec139dc 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -868,17 +868,10 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 		assoclen += seqhilen;
 	}
 
-	if (!skb_cloned(skb)) {
-		if (!skb_is_nonlinear(skb)) {
-			nfrags = 1;
-
-			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
-			nfrags = skb_shinfo(skb)->nr_frags;
-			nfrags++;
+	if (!skb_cloned(skb) && !skb_is_nonlinear(skb)) {
+		nfrags = 1;
 
-			goto skip_cow;
-		}
+		goto skip_cow;
 	}
 
 	err = skb_cow_data(skb, 0, &trailer);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f75313734f8..e5504cc0ecf9 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -910,17 +910,10 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 		assoclen += seqhilen;
 	}
 
-	if (!skb_cloned(skb)) {
-		if (!skb_is_nonlinear(skb)) {
-			nfrags = 1;
-
-			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
-			nfrags = skb_shinfo(skb)->nr_frags;
-			nfrags++;
+	if (!skb_cloned(skb) && !skb_is_nonlinear(skb)) {
+		nfrags = 1;
 
-			goto skip_cow;
-		}
+		goto skip_cow;
 	}
 
 	nfrags = skb_cow_data(skb, 0, &trailer);
-- 
2.43.0


