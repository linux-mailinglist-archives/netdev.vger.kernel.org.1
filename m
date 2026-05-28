Return-Path: <netdev+bounces-292747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MVfAjJgGGpajggAu9opvQ
	(envelope-from <netdev+bounces-292747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579425F4758
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DA13078357
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF69026A08F;
	Thu, 28 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzOoUkg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C022D7A1
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982109; cv=pass; b=VLpOQ6hLBwDhonSt/C9aLTZ8JNhP91HYvw7y6nuoOgkaMeQ3U1xsYyIKWHX+0gsVjd/42R0Rl0A8XPp3Rny+ZRMUHbUtxn3Wdo/DOIkuMBMSuLk1UnIoqf3fYrPfrQCHMGKO9zwVCn5u1lxXBaaMu4koo2XtE+dDqmZjotAs6HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982109; c=relaxed/simple;
	bh=QQZRMUyG4rdg9VbIhpDJ4B7GggxoScpV42/zNaHlETA=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6XBJys27QITSLYX2l9O78yagbFACr0FCYQQZRBD8JSUc0aOrlvgVmkeNYq2K8M3zPFiV+FoKoBdqPCRS6B2oWoLWx8IfRaQDhzHF+3DTaiNFcCG4+kBkMtBVZazNQlmGsT0GJz2wAv60p/dbicvw76HJJ9bo3emcx5r7aXq7vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzOoUkg1; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43bf6230cffso2462549fac.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779982108; cv=none;
        d=google.com; s=arc-20240605;
        b=YLquIoVqIEwSVohumgxgelHvHd7HAeCrTSXA00nlIZ10bZubty8s9DNmRYXIzXsHA4
         aqRIKx0mIuLXT2UOGi3kHOkay6NmYd0n9jQIrtWf+Zq5Uds8cOrMUIZ2nquQNk/TlXsz
         7xCUIi0s3VWzdcDMLsDlZq5/HFYNIZ8DzS8A9DnSQtxi0B2TKrGBwr79ca3nOUmfzBQ/
         BstTZFiS/9JjY7ov8Wvs48b0JGcLdFMQL2isDUU5Op0eVpqmmni+iKDyhNMSQId74MJF
         TeAmScDVLKMBoSmShoJ6zTm10yhteylsQq4f7FjevkQDjSKi4/mLsfkS2CyOAuCwgNkD
         pFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        fh=jFByzBpdSJXSDuOf7Doe+Jy3qoaV8Fm6P9i7wGoZww4=;
        b=H0LIfXB7pplyopqBPR5nUxCcTe30Uxadbfdv9cfJnukCD5l/Fqs/PWgWghWWExNRJK
         nhu0JpxCM5YaSFYwsCt7hpclL19RTVJUaVfZrkPsGoQQg/xLvvKgGzI+QJajH6Ny7n9J
         +l/IL97fScX1yBxBdqJzIAue4//JmBccpLt15C9plZdkKaD9c9UlHXLHQ3E3XQrYkfpc
         N7KpZRXRpq9sU8w0QfBVh9WRliVUj3VGagRp52FMAETvpEO6Ot6yClpR7hgrWcWYi3q8
         J66QT5AANZsSUGcxiCOSJgF8x7OIXLjqC8WojjleUxqkyB2xO2Y77bU8kBzY/GueHZwl
         OX/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982108; x=1780586908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=VzOoUkg1ZnTWLmw5dWRm1Jk2re+9L1EkyBrTXhujJ8rLD6Hqdiljyplc0oD+BdEzkv
         bKutHvPStxai+OPb7JNj7p4HFxhOOeqRVJggLYpkyFfn/FryzsfSroleu9E0xl/DIEe7
         ZwyrNaGGgeJz0tIAyHY/srpCyV/EGPEiowWZbAfpBxr6Dxh3/p1i26c/GGFd2hpMBmR8
         CrHfki0XfzHqTWPT3z3Iz+Q6x2cEDwpLwrwgXhhTmXIW3JdUrH6XmsAL3Bjc3M+W2otr
         VYU0THM8UostJZvx0NlQHMh4kVBhiGjvyq1O3DGAq64peggqV9us/ZEq+IhwVsvGrRUl
         RYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982108; x=1780586908;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=UgDiAdR+OZ+UWjjGam+niRBvC8bpfF/sQMgGG/dC2UqpxINIEay2bbhD7u6VTXR6J+
         5CKb/9ppLF4CSopdS5LmGZ+IaXnACEQDrhiuuCNYQnraQo19ne3/21NvgSNOAsvOLKWB
         aalgF47e0lYuIBoErc20YAz1HnGR+UBjYvb1aNCXYJJWNy39IZDp3M12afZMZEbWhEiG
         xw2+QS1iuqpdFDE4FLOJtjdHDa6F1GxNOaWBRdfr35T+Gt06+K5Mp6DgRy+ShzBR2U15
         9QTJFjc4I3eCspcdma/++FPB4Tbe66w/CZjS/tUtntL904sL0+LL+hBsACfdICAj/YhX
         DSwg==
X-Forwarded-Encrypted: i=1; AFNElJ+2uIjMTPrpa/k1T8RoFAXMcDNwhGPMv7mt/QQnddKpGg4I32rAfDf8sjTFXLeSYB+D0IOGGoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XyRJW7/2UvxU3T50+CEpczKb2MfYsjwzODh2fWbbL8w5NchU
	R7VyjqAbX3pel+YH5kJnU5U4bhewbFm6FIQATubJ8de1oEv32/RS6ofUW37DNRgfxct5mg9n2V7
	ebd60LvsvRDoFP1BWepRLfwINrCfJzXwR6+HJqy0=
X-Gm-Gg: Acq92OEqqI9snLyvryFCZZeCtOPMBV8ZhKsjKESPMJOCvGQr9s2I+ueJ+TXI1mu1vqV
	fW4hNuJ7oopWj1qeI2TtmfozGt9ZxOkK52KTZGsYlzQzmJXd1Aqp5lM1mVQlfXCMHbp5E+7DiCQ
	H4rQGigy+SzuS0j1myjhi/V786QbwozZS2wpeA85jbcmpiMtqBw2oPwk1IjXQDvNyBJ4EwmZywY
	PE8MnhwfHgv9jWvNGiHpwFyH1/HwH6eoLxUzcT85oOQi1l1bkEvdfhBb9kC/xz56gdYmEmJTl5c
	TWrb3l6yae0l7R4Zkh/OjHSDDg==
X-Received: by 2002:a05:6820:2188:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69dfa8cc60bmr776345eaf.33.1779982108478; Thu, 28 May 2026
 08:28:28 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:27 -0700
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
In-Reply-To: <ahhNSscKHjx7bebv@strlen.de>
References: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
 <ahhNSscKHjx7bebv@strlen.de>
Date: Thu, 28 May 2026 08:28:27 -0700
X-Gm-Features: AVHnY4L8t6Egmo5coWR6ByJIrK5IZmT-3tpDxVljiqUtl1hxBn6WdKFJ5bAIdmA
Message-ID: <CAOYEF6mb3K6=-+h-ayyVrSmXbxLVNXYgj23g4j4tJEaxvz5u8w@mail.gmail.com>
Subject: [PATCH v2 net] netfilter: nft_payload: validate offset for all
 csum_type paths
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 579425F4758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From e11e35dfd10960ea8ca4258dfa6ed7aeb207179f Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Fri, 29 May 2026 00:23:35 +0900
Subject: [PATCH v2] netfilter: nft_payload: validate offset for all csum_type
 paths

When csum_type is NFT_PAYLOAD_CSUM_NONE and csum_flags is 0, the
bounds check inside the csum condition block is skipped entirely.

For NFT_PAYLOAD_LL_HEADER, offset is computed as:
    offset = skb_mac_header(skb) - skb->data - vlan_hlen
which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
pulls the Ethernet header. This is a valid negative offset that
refers to the Ethernet header area (used by bridge/vlan rules).

However, without any bounds check in the csum=NONE path:
- skb_ensure_writable(skb, max(offset + priv->len, 0)):
  max() converts negative values to 0, making it a no-op.
- skb_store_bits(skb, offset, src, priv->len):
  A negative offset that exceeds skb headroom writes out of bounds.

Add proper validation after the csum condition block:
- Negative offsets: ensure they fall within skb_headroom(skb)
  (bridge/vlan rules legitimately access the Ethernet header)
- Positive offsets: ensure offset + len does not exceed skb->len

Also remove the max() wrapper from skb_ensure_writable() since
the new validation guarantees the offset is within range.

Fixes: d5953d680f7e ("netfilter: nft_payload: sanitize offset and
length before calling skb_checksum()")
Cc: stable@vger.kernel.org
Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 net/netfilter/nft_payload.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 01e13e5255a9..2c891c13bbf5 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -892,7 +892,17 @@ static void nft_payload_set_eval(const struct
nft_expr *expr,
 			goto err;
 	}

-	if (skb_ensure_writable(skb, max(offset + priv->len, 0)) ||
+	/* Negative offset (LL_HEADER with bridge/vlan) must be within headroom.
+	 * Positive offset must be within skb length.
+	 */
+	if (offset < 0) {
+		if (-offset > (int)skb_headroom(skb))
+			goto err;
+	} else if (offset + priv->len > skb->len) {
+		goto err;
+	}
+
+	if (skb_ensure_writable(skb, offset + priv->len) ||
 	    skb_store_bits(skb, offset, src, priv->len) < 0)
 		goto err;

-- 
2.43.0

