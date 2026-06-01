Return-Path: <netdev+bounces-293877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ+rOorLHWrHeQkAu9opvQ
	(envelope-from <netdev+bounces-293877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:12:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76D623CC2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B9793042C4B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4BA3E5577;
	Mon,  1 Jun 2026 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h59ozYOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669F3E3C7A
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337267; cv=none; b=msNk2YapTjCwJ1x9IKyDUdOUaHvo24QfCXvoGrOTlSx5B8pmZ2O8ZMv8XXtX6XtHGlLg905PmNgfU+XiuxXkODTFhka4Zg35fBf/jqi8zbWmIGMgedJPU8h82IEeopHOVZ6R1wtT+5dF27+N8JMcm3Jhk+OOXR2tayfUjKl/Z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337267; c=relaxed/simple;
	bh=VOiBXoBQlSg//vVKEz2y7OxY1/2p9gdtUZWvw/YqZPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kyvh5LALL927lBa5Tf9zRByUQprqHlyQeTiGRNdh8cWAhf9/LbG0rfVYfk0IuBzkcqhOZgbogDdQzzzq829Wu3aP0LCjj/3Zy4uXU0U8CUFFPTgFpsW7VSnwGY56cqYB5eM0KUlzrRp8oa4qciglMJSl8cmmS2bWuz3d/VhdCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h59ozYOb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f869421so1136045b3a.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337265; x=1780942065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6ImwceoKhc+jAOboR4IDZozN81GRjqesHGaUtrdZGI=;
        b=h59ozYObRoBy1PbUCSJg4RtI5W1efa4NDpDuts4ihvyNzrdSul3kfRlltHNdWm44aq
         kP28DqRymhIMGmWev1nY+po6o19ZvMjZ5Jb1Ictp8VK0nKtC+j+5jhcQSvLDPjMEKcjq
         nZwl6QQ+NvvWr+POmKyu6n+XX0norKSCNMGXB5nSJM5myYBJKG35lJj+qCqGyAUvv8Tv
         bsBdVr5P7wv+sElRM4T9prha9zMW//IE1IUV8P9CTCYIKPGxKfBN7eLWfvfKoNWM6hJk
         MqzIQ51gugHReGoDKMTmcGgT41Wugeh/6YE7YFfODKPzjwxJL+SO/0LW+1CNXPVozv1X
         EbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337265; x=1780942065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6ImwceoKhc+jAOboR4IDZozN81GRjqesHGaUtrdZGI=;
        b=qAizy+mJNkcN9tfl/X05pvceGoKiDqGDUu5sQfFpYDFj/cX3/fBcA2RH4HgK4hyehC
         LZ64uHSsYXl3evnKK4d2lQtCBakwhlZUU5elodJ/CCt6KLbwwshG05Xeq7r5n0tdALXp
         MXO/AyB5zI6jOHGzmQpiugDGA3EIPZySlKQOGhAj9KW0bmk9tdVFAlU/12ova7miTlfy
         dJKqX5gGK2AvNJoraEYgLggysKEMLHpjQnvGdoOLHEJOYBMWC8nJ70XIfohDfCCGq4tx
         /SO4QOyoT9dY8hP/uIm2Oo0Jwywlv1jlP/LMhMVbcguSgwltyscVXpX8AxqcKBscnrc5
         6rnQ==
X-Gm-Message-State: AOJu0YwU/r/WTX1LdrfunXiI9G838xR0cJ++RAIV1xkeowpB3T6wb+VE
	uk2q6Ja4LNau1njAgDgCCKetj6dW7+QoULk8Z/z64EocNnRCqexdR/Ek
X-Gm-Gg: Acq92OHmwlIyJpJMdM2izpB/MwXxrVsf74HooPrexT0hKzE2hYFyk/Cys5JNveohBYC
	ZF/QbmS9ExcDvtWfbrOy0HeMxmpPJhkWxfs0eu5wlDCBvSEOtSQ4OUXWhRC0Smzq8nCXWDw/tga
	mxWe5hsnniLaWM0tAnukZWHio8NzRnixOLsLHpsKilq8NQ8Lap8HUKiEvhV/m+AsAQewUxloDzI
	k2+hI6weoQDyN4NdXR68tTSmyTqsSGbsPA6v+HnCY5utBFxFrrgZ0nJVMipW38r3Ohaiv2UuorO
	M6scXVfwt1/imVj6BsfvxyXZS3w1ooonNfdbezl1IP8Z5GtHkE18bvgoK9o11e8a0uldrh/qHVr
	eFSmQs0BNi4Ij/7ogzu+nUFskg+kIJVMBwCLJb5kShcmYkQFiVMaS/+jRRICb17U0OeX7FLtJA1
	i1JaHkgQBLLUrPECRgOBgqmEdAjtw1Nv/wqxUw0a8Uu1Y=
X-Received: by 2002:a05:6a00:21d2:b0:842:5a8d:303a with SMTP id d2e1a72fcca58-8425a8d41a0mr3825753b3a.37.1780337265000;
        Mon, 01 Jun 2026 11:07:45 -0700 (PDT)
Received: from localhost.localdomain ([212.107.31.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84237a41a3esm7389702b3a.22.2026.06.01.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:07:43 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	tamird@kernel.org
Subject: [RFC PATCH 6.1.y 1/2] bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
Date: Tue,  2 Jun 2026 02:03:59 +0800
Message-ID: <20260601180400.1381736-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601180400.1381736-1-jt26wzz@gmail.com>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293877-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A76D623CC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 9e314f5d8682e1fe6ac214fb34580a238b6fd3c4 ]

When performing 32-bit conditional operation operating on lower 32 bits
of a full 64-bit register, register full value isn't changed. We just
potentially gain new knowledge about that register's lower 32 bits.

Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
reg_set_min_max() performs as a last step, can lose information in some
cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
That's bad and completely unnecessary. Especially __reg_assign_32_into_64()
looks completely out of place here, because we are not performing
zero-extending subregister assignment during conditional jump.

So this patch replaced __reg_combine_* with just a normal
reg_bounds_sync() which will do a proper job of deriving u64/s64 bounds
from u32/s32, and vice versa (among all other combinations).

__reg_combine_64_into_32() is also used in one more place,
coerce_reg_to_size(), while handling 1- and 2-byte register loads.
Looking into this, it seems like besides marking subregister as
unbounded before performing reg_bounds_sync(), we were also performing
deduction of smin32/smax32 and umin32/umax32 bounds from respective
smin/smax and umin/umax bounds. It's now redundant as reg_bounds_sync()
performs all the same logic more generically (e.g., without unnecessary
assumption that upper 32 bits of full register should be zero).

Long story short, we remove __reg_combine_64_into_32() completely, and
coerce_reg_to_size() now only does resetting subreg to unbounded and then
performing reg_bounds_sync() to recover as much information as possible
from 64-bit umin/umax and smin/smax bounds, set explicitly in
coerce_reg_to_size() earlier.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20231102033759.2541186-10-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ zhenzhong: adapt to 6.1.y verifier.c layout ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c | 60 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8d3616..5e029d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1577,51 +1577,6 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 	}
 }
 
-static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
-{
-	/* special case when 64-bit register has upper 32-bit register
-	 * zeroed. Typically happens after zext or <<32, >>32 sequence
-	 * allowing us to use 32-bit bounds directly,
-	 */
-	if (tnum_equals_const(tnum_clear_subreg(reg->var_off), 0)) {
-		__reg_assign_32_into_64(reg);
-	} else {
-		/* Otherwise the best we can do is push lower 32bit known and
-		 * unknown bits into register (var_off set from jmp logic)
-		 * then learn as much as possible from the 64-bit tnum
-		 * known and unknown bits. The previous smin/smax bounds are
-		 * invalid here because of jmp32 compare so mark them unknown
-		 * so they do not impact tnum bounds calculation.
-		 */
-		__mark_reg64_unbounded(reg);
-	}
-	reg_bounds_sync(reg);
-}
-
-static bool __reg64_bound_s32(s64 a)
-{
-	return a >= S32_MIN && a <= S32_MAX;
-}
-
-static bool __reg64_bound_u32(u64 a)
-{
-	return a >= U32_MIN && a <= U32_MAX;
-}
-
-static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
-{
-	__mark_reg32_unbounded(reg);
-	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
-		reg->s32_min_value = (s32)reg->smin_value;
-		reg->s32_max_value = (s32)reg->smax_value;
-	}
-	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
-		reg->u32_min_value = (u32)reg->umin_value;
-		reg->u32_max_value = (u32)reg->umax_value;
-	}
-	reg_bounds_sync(reg);
-}
-
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg)
@@ -4660,9 +4615,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size >= 4)
-		return;
-	__reg_combine_64_into_32(reg);
+	if (size < 4) {
+		__mark_reg32_unbounded(reg);
+		reg_bounds_sync(reg);
+	}
 }
 
 static bool bpf_map_is_rdonly(const struct bpf_map *map)
@@ -10114,13 +10070,13 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 					     tnum_subreg(false_32off));
 		true_reg->var_off = tnum_or(tnum_clear_subreg(true_64off),
 					    tnum_subreg(true_32off));
-		__reg_combine_32_into_64(false_reg);
-		__reg_combine_32_into_64(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	} else {
 		false_reg->var_off = false_64off;
 		true_reg->var_off = true_64off;
-		__reg_combine_64_into_32(false_reg);
-		__reg_combine_64_into_32(true_reg);
+		reg_bounds_sync(false_reg);
+		reg_bounds_sync(true_reg);
 	}
 }
 
-- 
2.43.0

