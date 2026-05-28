Return-Path: <netdev+bounces-292695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEajNuFFGGr5iAgAu9opvQ
	(envelope-from <netdev+bounces-292695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A95F2E18
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6311F3017E8F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9903F6C4A;
	Thu, 28 May 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH4d2LxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623613F39CC
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975585; cv=pass; b=PAqF5XcVj/PM92KLgMEj4stRS3pWw28rG2dY1fa2kvoWxzzcYKDZB/D34bOfGtOrC9ur6KL5QhTfMSIMiy1ZEKMzWhEplvlsKbmHTyFoqu4eyAUFPQmC1huPUVrC/vMFm3FBHSzUSrfgzpm0kVdeZuZo7cQXJHPNgsFr2mTvZ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975585; c=relaxed/simple;
	bh=yw019RHIYxycqtwq64UtUDUJDQ24/M2csMV8DlAPgw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XHkOIKY7wbzANOHxePxg/etbigvBHyz4zzpuXLUZQ8vbLrSQufSFF99IsoKEoga2F5NQoiVVGzqgfoDe7oRrz1x1iShSTbacpNYmVDk55ZNk9ml55cbNcdd8kWG8APCtewY2cA1kKuFteeH5SAOlk0BKfFx2kQxCjA503MziS88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH4d2LxL; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bf94534a1so1699550fac.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975582; cv=none;
        d=google.com; s=arc-20240605;
        b=Oi6rYQRxxdz3m+qSjEbPilXro2N1ywvOc5lMv1+gkv0JnYMkF6RCWLv9QxwVK2OVv9
         6wZHYyQwzKq7yEs9AHOULb0p1wV2quMnvYTvh7cUHfywi7h1n2B3HqVAaA7lXXfvp65x
         tkzepif1s+yz7smUpwSYz8ZbmU0zfvq87A2r4L12ka+kvyFzYhRorGjFZANcz3W3Y6kA
         vdL4DkDQ9/a/cku5MfEl/ig8mhOu6QrxKfVimm3A+O0FXKlvx4MSomRlrAvJWTBV3XiI
         iOwqK92pYlbQqgKeKhE+oLwGfGxU30cM92AXML8Az6/z5ExqMtmpuAWKFsqlOGzXQRF7
         3b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        fh=0jRz+FMK7gBliPzdg9b0FmkgUKY71pCeOt8RD+1bJ/I=;
        b=HP660mGk1wK2olMONWG05kL6sgJltkNyUZAVh5dBtNk6rN/LTd9L3l5BKpeHm6f4kM
         ya7mLV/xa1VYOt0Ss/TEgQlPc33F0uiUJbZhEffPdcnhvSpSnf/T4x/mXCGuLfboXZ20
         vIVcyDNopb+EEiZjtJ0Ou208Mve6bBCh3MZtk99q1TikiCcAKZ3Sg+BDyMMg3k+V6lfT
         sc5EISIdY6/xogQrwcuW+bW2xyyAChaGPezT86bp7Fc2jsPdwAr9t2eAtQc8AieDerhp
         a/RrKj6ZI1GN3XcURCWP6wM7gB6rUs8NR+Rgoi98Hx1znseMP6zR5NgA716lNjqSKH6o
         /xRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975582; x=1780580382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        b=lH4d2LxLZepwO3Kezjd4XHcM5OYtiIVmZzGzAYcJLS/mEngBValeUxxK3RV0AHkjCL
         /K4I/+9N58xw966QiVMiztab/P6EdXYcdHlS7bgC9Q/XgPKEHbVzCCla6yPV0e6lr448
         820x3Ndwhotnz7ooe/YsjqVy++2Sq6RQ9zPIfW90OcFT9MNgG42XJ6TOfkz3MhZYzzO6
         H0dMV+wNrIiL4I2iLamLAJ7u46zWj/6BwqTyZUN8ZMayHEg0BBgXZIAGDVCoElj5A1EV
         ah5596D6oLY370pX364y2rLNqNtQ//OIJlRER1ot9l0Is+5RlJiupjpCr+rRLdEXc4Un
         cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975582; x=1780580382;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        b=e/FkAAGrNpCkb+/nyzSboKB3aNqT+BoHbGK5Rv3FTXNwfi2KpdQEY7Uo0qRICxZd7O
         mTx3TN/tGMD2yiZgQn0lghoL2jEl1riNpO6eDovvPVQT4wTBhlSl2TQiyzTt0S32+e6c
         GPYWWlT9Ybcn/e5GH3v3wB9ij8kXztfrRwFknX1R2fv63i6+R6XmEZ4H1GnVPymCnTpj
         uOgCs2GpEL3dblVJBUoi/T8eLLKHMbxH1d1rA8Gzf0arYDjhdbYPf1XITmLFOTkS9qzp
         skatHyAHJLWevYuQIA3nOYO0I32w8Sg7eGTojfm/dOPzSsKcjP35RYspJyB0xSEHLZ4E
         6jFA==
X-Forwarded-Encrypted: i=1; AFNElJ9hzRJ2v1Q9LSIrhoE0NIlB9AZABK/3K2Obbfho6rlsZuVMl/cThR96xQtdxtXNstv1w555Mq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhBzYKRRgqLteGnXNqTqfMgOeGFu3P1vnp5L8DNtdH22x5Cyg
	3QEiSySd51AidAenbeoxHDN3o3MzZcD2lIsS7BAhRUs1XfWQKdOyY0KoGPoPLvey9aDglR7vQha
	mQUr7RMj9m9H04p2HDVGnos57eyX2xVI=
X-Gm-Gg: Acq92OEKKW4QBejWSAtdY/NZOYa90+NXoxrr7WjiyWHL69xi13QXSEjt7kQUTlCwvT2
	TtOZFdRgVaKdAbnlXXPbn91+SLBN8OsFn6CoYDKHxZIHRugQtn9AU6WTTWPq2r7KesAj+U/xYbU
	f3CAfXiFiYO8UXC9u3KhKye0xSqrNnD9G2Ogeid/rBH8T1YrIX9y6NE849O+CZHoX5Zi3CwOC09
	SgXIDZlvD8EU1W3Lzxi6wjgpJE2g+A/KQaLVJ8uduZbWtNgLnBrQ+dDjQeCcv0YigArW2KKBJBY
	W9uLamxBQpH4LzUv5Btyhk2Tqw==
X-Received: by 2002:a05:6820:c203:b0:696:6585:a51 with SMTP id
 006d021491bc7-69d7eb66ac7mr12034312eaf.13.1779975582247; Thu, 28 May 2026
 06:39:42 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:39:41 -0500
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:39:41 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 08:39:41 -0500
X-Gm-Features: AVHnY4IjQLe8D3fhmXisoI-4JSwxgrf6oHHC3rTfzHf8ykBiOBRC4gfpxJ5yCMs
Message-ID: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
Subject: [PATCH net] netfilter: nft_payload: move offset bounds check outside
 csum condition
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC2A95F2E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 574604a1b4a98ee130d7f727ad3c8a7df3f3b6f1 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 22:39:03 +0900
Subject: [PATCH v1] netfilter: nft_payload: move offset bounds check outside
 csum condition

The bounds check for offset + priv->len was placed inside the csum
condition block. When csum_type is NFT_PAYLOAD_CSUM_NONE and
csum_flags is 0, the entire block including the bounds check is
skipped.

For NFT_PAYLOAD_LL_HEADER, offset is computed as:
    offset = skb_mac_header(skb) - skb->data - vlan_hlen
which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
pulls the Ethernet header.

Without the bounds check, a negative offset reaches:
    skb_ensure_writable(skb, max(offset + priv->len, 0))
    skb_store_bits(skb, offset, src, priv->len)

max(-14 + 4, 0) == 0 makes skb_ensure_writable a no-op, and
skb_store_bits(skb, -14, ...) writes to skb headroom (OOB write).

The signed-unsigned comparison in the bounds check correctly catches
negative offsets: (unsigned int)(-10) is a large positive value that
exceeds any valid skb->len.

Move the bounds check outside the csum condition so it applies
regardless of csum_type/csum_flags.

Fixes: d5953d680f7e ("netfilter: nft_payload: sanitize offset and
length before calling skb_checksum()")
Cc: stable@vger.kernel.org
Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 net/netfilter/nft_payload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 01e13e5255a9..62661e4eeb13 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -873,13 +873,13 @@ static void nft_payload_set_eval(const struct
nft_expr *expr,
 	csum_offset = offset + priv->csum_offset;
 	offset += priv->offset;

+	if (offset + priv->len > skb->len)
+		goto err;
+
 	if ((priv->csum_type == NFT_PAYLOAD_CSUM_INET || priv->csum_flags) &&
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
-		if (offset + priv->len > skb->len)
-			goto err;
-
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);

-- 
2.43.0

