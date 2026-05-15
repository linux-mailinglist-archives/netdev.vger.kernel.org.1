Return-Path: <netdev+bounces-288475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMB0HmyeB2oD+wIAu9opvQ
	(envelope-from <netdev+bounces-288475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70A558DDB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36DDA3007510
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B763F44FC;
	Fri, 15 May 2026 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BolM1PKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401037BE8E
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884141; cv=none; b=dQ47kmSgE5BA8JVx45Ev9z1e3YHfJVYxsT5nZTKd6ngNA57VrOdtdw1MpsKUqHdXz5pSfTeRMs3vjE0qTVJCI4f+V0RB2MqHKmpp+OXK+bPProaN8n6wpq+MOjQ8oDTQyPDzP90Zd4yE6WK9GukvMh6MP5FCCQRsaHGVbD8DsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884141; c=relaxed/simple;
	bh=aGmAtHHcir/8kQqVKi/Xn+nLoHQb9rYIl7b8rLXZWwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2UFfL8tOVe1E7lh9uoJ9Vt7bkAsptCAfw/KBaVOJ8a37M2M3Vrm36RyYaZdbeCtudVghsnkKVrzKZXQ5lRavnThntaoHW41d7f9LT19gRyk5FIDyz7cg+3Zb94aPgxCCYumzcQ/OYvciug8W75NMM1k0Yx4NdXatiqKNDll2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BolM1PKg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c80167f5716so123449a12.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778884139; x=1779488939; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mUBdLpThxzKu9Liq0g3UUpqLlKdRPYUPjPABtznf7g=;
        b=BolM1PKgVJU+RW050qCJgbmlgm3bSQFYA1tgMl54vowdr30PjJPQJEURqDlaRdOuL5
         EWxRRJtJjsbyCjTdsp9CQ+Ea8IwgQ3hGvhdf+0sBaeb2IHDircsQsyBBUuZXLmKxfPOk
         TFvwvEGhhnKajCencjdzxxMyEJwBMiJmy4/JR0t57cYMVoozzh0d5IYlAjxopyMn9AQQ
         cwBypBrIlhtVwIx5NunCiQ8lpCmhnXjLuVyEMMupa8cTbYVRYqAQnd1yxB8BX0aMpWqJ
         SdJZeb9Rbr5fy2SIwmneODjxSRHGUr5jszOAh4xp6T2sdn23o9idRAm5WTJpAdDTaYBO
         MpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884139; x=1779488939;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mUBdLpThxzKu9Liq0g3UUpqLlKdRPYUPjPABtznf7g=;
        b=tP6h2xd8yyOMtUNfusG4h1rUka9uIXhlZdsPbnR/UCqGMlA7Y1yDR6yYgqx4UTGQzL
         ePaDm6MelNVEqC2x8gxgyEeIvo1mAjudvbfmZjkG8PRPP4mIH/nZUUHkSIz5ZNui7dvZ
         o7Ikc7zTKVDEa1A0am3V4jBxtsw6aaW+NT6hfFxgMSgH4bv63wVp3VLGiy4AQTRs9sAp
         8fdSDECuYV0G4uQsF5rMktjjNXI9A7kazGT2Me2fWA9M03P3FqyypyfkfMlPFS9W4MXI
         vSFQQ/Jrww3NGzvxk5zhbVmShKDqO8xkM2GIRRvmjfWqdDZAPv3z1WZB99AAbKnWEMvY
         oT5A==
X-Gm-Message-State: AOJu0YyCuxcLROteCCrE83uqf49zAjjjjtshLiskSiN+2QtBv9D8/Vy9
	9gm5khmb7QYpjsFvO4WMaJvWQQxGMPUOAo3kcY8O+96VYZr9/7hy3x5w
X-Gm-Gg: Acq92OHFOfuR07TX9KEaqoJNPAmBJIslnJ068jyxa7m3aGeND56VdwNby1GG13MmicR
	be549qN8j2PqD/VDdPUDrUFigwliMFEsE8W+ZFEI1eHA9x0ux0quvsmVQCD/dNmUubqYb/VwSfA
	zbp3oQk1rFQdEKtP33Hdqgf4BThjQBfgXfPi8luqAd2Jn4Pd9HPMvmiqCUyyesHvPWlVCAGz6Lw
	iSaExU3ZfofLlS50aNwvNTymxygLLNntzZ9UogGu+JmA5KWuU0kv0P9W+xNaIIE6GeYO+uoiFg2
	+nyqUkB1b7uAmeFP4AOY5apkRKXHsO7bIlikO9JljGBOFTZRmDCb8vGsGNW6QQlHFMNmD3BrGJj
	h0Y98Jro+493JsYVJRCY37YWYWe563aOIZD2BwaXSNjgo+eHwFfwg3Uzy/F3YbpGMA6/AmQtvHy
	SYJkooJ7Ucq372I9BATSroYJJ4b2K5Ii7lxkQhSiJMm5o=
X-Received: by 2002:a17:90b:38cf:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-369519c6bcfmr5722103a91.5.1778884138863;
        Fri, 15 May 2026 15:28:58 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c26355csm67761435ad.35.2026.05.15.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:28:58 -0700 (PDT)
Date: Sat, 16 May 2026 07:28:53 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, sd@queasysnail.net, malin89@huawei.com,
	tanjingguo@huawei.com, aaron1esau@gmail.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v5] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ageeJfJHwgzmKXbh@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 1F70A558DDB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288475-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net,huawei.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,decadent.org.uk:email,kerneltoast.com:email]
X-Rspamd-Action: no action

Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
moving frags from source to destination.  __pskb_copy_fclone() defers
the rest of the shinfo metadata to skb_copy_header() after copying
frag descriptors, but that helper only carries over gso_{size,segs,
type} and never touches skb_shinfo()->flags; skb_shift() moves frag
descriptors directly and leaves flags untouched.  As a result, the
destination skb keeps a reference to the same externally-owned or
page-cache-backed pages while reporting skb_has_shared_frag() as
false.

The mismatch is harmful in any in-place writer that uses
skb_has_shared_frag() to decide whether shared pages must be detoured
through skb_cow_data().  ESP input is one such writer (esp4.c,
esp6.c), and a single nft 'dup to <local>' rule -- or any other
nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
skb in esp_input() with the marker stripped, letting an unprivileged
user write into the page cache of a root-owned read-only file via
authencesn-ESN stray writes.

Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
were actually moved from the source.  skb_copy() and skb_copy_expand()
share skb_copy_header() too but linearize all paged data into freshly
allocated head storage and emerge with nr_frags == 0, so
skb_has_shared_frag() returns false on its own; they need no change.

The same omission exists in skb_gro_receive() and skb_gro_receive_list().
The former moves the incoming skb's frag descriptors into the
accumulator's last sub-skb via two paths (a direct frag-move loop and
the head_frag + memcpy path); the latter chains the incoming skb whole
onto p's frag_list.  Downstream skb_segment() reads only
skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
shinfo as the nskb -- both p and lp must carry the marker.

The same omission also exists in tcp_clone_payload(), which builds an
MTU probe skb by moving frag descriptors from skbs on sk_write_queue
into a freshly allocated nskb.  The helper falls into the same family
and warrants the same fix for consistency; no TCP TX-side in-place
writer is currently known to reach a user page through this gap, but
a future consumer depending on the marker would regress silently.

The same omission exists in skb_segment(): the per-iteration flag
merge takes only head_skb's flag, and the inner switch that rebinds
frag_skb to list_skb on head_skb-frags exhaustion does not fold the
new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
so segments drawing frags from frag_list members carry the marker.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Suggested-by: Lin Ma <malin89@huawei.com>
Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
Suggested-by: Aaron Esau <aaron1esau@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v5:
- Propagate SHARED_FRAG in skb_segment()
- v4: https://lore.kernel.org/all/aga1VyHpHaUhnGZa@v4bel/

Changes in v4:
- Include the tcp_clone_payload() propagation suggested by Sabrina
- Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
- v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/

Changes in v3:
- Include the skb_gro_receive() audit patch suggested by Sultan
- v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/

Changes in v2:
- Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
- v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
---
 net/core/gro.c        | 4 ++++
 net/core/skbuff.c     | 9 ++++++++-
 net/ipv4/tcp_output.c | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..9f8960789b2c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -213,10 +213,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	p->data_len += len;
 	p->truesize += delta_truesize;
 	p->len += len;
+	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	if (lp != p) {
 		lp->data_len += len;
 		lp->truesize += delta_truesize;
 		lp->len += len;
+		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow = 1;
 	return 0;
@@ -244,6 +246,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
+	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow = 1;
 
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c4e8d331d6d..44ac121cfccb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
 
@@ -4959,7 +4962,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4976,6 +4980,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
+
+				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f7..6e4bb411dc04 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 			todo = min_t(int, skb_frag_size(fragfrom),
 				     probe_size - len);
 			len += todo;
+			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 			if (lastfrag &&
 			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
 			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
-- 
2.43.0


