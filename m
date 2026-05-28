Return-Path: <netdev+bounces-292746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPrIAwZgGGpEjggAu9opvQ
	(envelope-from <netdev+bounces-292746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5A5F4731
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327153031119
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E42609DC;
	Thu, 28 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfuDqkcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA40176238
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982092; cv=pass; b=NC6HdZv6KurVaL7SeRHSUj1JpG+rEKRKUmAJTs6I+Rd/U0kZA6KIYjzd8KbbO2NwD8/BBFU5im6sHUz8Zg7Y76BrPDDBHJNKywuZM+wVK5/aeve3EkpaLwjKV7GdC91oyxZ5e615LBpsE6ZVyHIYgoVe1bybYbJXMVsmGsGPcDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982092; c=relaxed/simple;
	bh=QQZRMUyG4rdg9VbIhpDJ4B7GggxoScpV42/zNaHlETA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JmH+UyKhDdF/llYdNX50rAJhMhlCho59nVF1U0RcDLBQ7IwzONqQXdlzs4rVoGaUjUz2IVSqETmxTp6RnkdA3eBnzKKF9UQcJytoO9wkNZAYtz1JxkKhMXwhk7ykoHjmaKoKm8NQ9p8wnEr1/rH2/n6bb3XHZ1vqS8dQ2zc3WXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfuDqkcx; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69b747a8984so3488313eaf.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779982091; cv=none;
        d=google.com; s=arc-20240605;
        b=jOsW0PL1Jy6obAW1NreOaK57g8nYAyxBecAjoCckd6vaYUPRUFk0KeBPua/Vo+M6uJ
         KS8h/tyYVGLYBDEcURNnHnyr6hhUlyUHbUBWuAdMNFOjxtdO8nvs7kvPb0TgW+oewB+c
         /mq6eff+CuH/KVqjLM4SHNBMWy8Ply1yWmfKF+uS4Tejb8t4B5GxSkM1wwAjJNQy7XtH
         4ZiRzm9Jkt3k2+OtrC4gURMPDDp8dgKyX5yK1RAELfDEjhRtgJOxDcfOgmzcrooQW1mm
         0vOTnLRFtF+mrws08Dj2Kpf8BfEHDsSjfgBbqcnSW/FAMURoMy4XLHVM6askvTAvnfeY
         IBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        fh=hdVJfXkVcsLS+IeldFmJ9Wc1m5bEgLS/fcLwErgOmJg=;
        b=j623NDNubcY60mHpCQfXkR1bW4QocM9WHjmEFFB8htJdQSU1gmLuJu50uLn5Il7fY2
         OMJ3OlrF+8wBjCIcvNoFjbiy1/EXbsFq/K+xk65G3DViIiP0J8fUniKtE96wMUhXCdx3
         CyDY5L+JRAlIFrOPAEn6Id+25wwJaq8yWV1+xKi9HO6PqtPayy7LyQMii1aBJzhLy+31
         5W1A5onc6i/E6H4rAl7l6nExf6zHHOKwHR5+GxI6XBCfQeBIks/ZMWJQRX8Vy/JaTw2Z
         kBvpAo/18EEH1pWs+0Qv6iqLVtoq4ApmRqK4O1n1i3oXd7rMlxmvFnkcvzDdML2I/6Xx
         c3cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982091; x=1780586891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=GfuDqkcxzhGtWCb6j9Jt2pXXoNhUxA+e5Bj90cyAGSaO5tTVYQCMR32CQMI2TAU4VQ
         0ktrTPAvf9T32ffX9N604td1xtaVktw1drvJ3ut2zvn8vNhRkUPYLpihkJfSQfD2jQdi
         kTvp6+5Y0LYdnAir/AvH5YZgWpzTCV8+FZT6IB8bgLbhBJS8X05RW/2hH25RLc6R9tSM
         BCA3S3XDnS5/TBZQVT5+P+6C8mzu7FAlbZtj/XRJ+oo+ciE1QxPHNf69/a12zlU4O5P4
         v4/1hJS/NVZBojFdQ2ysczS6WTCtIPC+XH2CzVazt5jn42iAxDqqNtDXdspsVwrje6Xa
         YrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982091; x=1780586891;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=LCQIrmPduuT8nKKgsNZ8bExb6UtOcLA2fIFM+5EeayK8L3fWw5pxnIz87XiKcFfIR/
         OG+qFbb+SCVEJOxbm/0EjEyYANe6k+/eCkMtwXbdLeJ9UOUIwtJ23lcOdRnGQ/VO/kss
         Zmk0dfc+64F0vq59gbPfSQcErHwb1cQpU2JqpDfSQMx7noKHgVKibwW/LFphlGOGDVfc
         uQ0wHvAhnUW5RCk8xN8sbBPFXDNjMOjuRLbpOxTrTfZ+josXRh99X1Vn1yZxVrQuoyhp
         aCQZTlw/z5GXYMMF7fMpFP476MPgaK+ulG2+tnL8tJO4RhQYFaokjWSP36fDSRzWrw9P
         8mCg==
X-Forwarded-Encrypted: i=1; AFNElJ9jp2010b8o/7OcU/Xon+StGrVo9UjLgUAZk4QKg+OeerApZnkXScmXok3FaT1gxMfVMfHMx5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWinTxQ2FDMXNM+yuezLoPkJpTAU/4trosjLgXNB5YTm4RFd6q
	LXxXm9i1u9mKadd07146GbIQl4sEgp42j1ymy8+bG5GEF2Jgvv3CdwqFP3jEzVZcIPd5H3KKrq4
	lC8mqQH7FknlbOgS8dOD+WwXAiosmgEg=
X-Gm-Gg: Acq92OF52Mz4LX4QrN1pTcjbvVtXzFf8L07o7zAJKOKgjZPnZzdtC/52RYcAFv2epbF
	a4muoZjaEBLmeGVefVQEpj+kpSaY8kh2lCw49O43pm6QTUjBysaDvKN8C9fKeqvapsm7FZGSVlv
	i9b9ZI779QKja595+/MKmFbyzI4cV2mUDx5codZGfZ+iEcxABHzgjqReiTPDr6Q8ezrWh303xSI
	kH6Peq4igK+/CWMs23rBuAe5Mi6umt+gjCAiz+qaR2zhEVclTlt6NEk33SD+ZkK9ptf57P63f6t
	llW3WUTIUizAE8wtgSQcjohUmA==
X-Received: by 2002:a05:6820:1995:b0:67b:bd89:90ed with SMTP id
 006d021491bc7-69d7eca473fmr15377134eaf.41.1779982091287; Thu, 28 May 2026
 08:28:11 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:10 -0700
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 08:28:10 -0700
X-Gm-Features: AVHnY4IdqTJ7zDmth5WMGZnzwixk6rFBEMqwDoQ3EpXt7LiTgL1t7notH1b99jM
Message-ID: <CAOYEF6nkrD4o_Kw_gxbv7Vefxpp=E6N4X_s-3KEcS1f3Hb1uAg@mail.gmail.com>
Subject: [PATCH v2 net] netfilter: nft_payload: validate offset for all
 csum_type paths
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292746-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 69B5A5F4731
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

