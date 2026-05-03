Return-Path: <netdev+bounces-283669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJwtCQuo92k/kQIAu9opvQ
	(envelope-from <netdev+bounces-283669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F64B731E
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A2CB3007A73
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206D3AD51F;
	Sun,  3 May 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="oZnijoFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77F3A75A4
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838040; cv=none; b=LtOHLkgHYh6gZqjjsUDlgirAuRN8My+RAHmVVJxOR3WS4ow6T+hA5JoJQr1QHjEXmDZeMPajSqQ85Ww7QgM3HujOIgCH00GmaPLriK3kF+wLlsWY71Tacu8Pvo8l8D2p9kBRzzzRz/YPrJ1Fj4gj7pFRNjfw+H7dqDV31iy/LLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838040; c=relaxed/simple;
	bh=jkGP3JJZc5F4eiLYfVZfH8J+7FsZwTHa0M+JIaj9Iig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilYv+UIV8RJKrNa/GxU6Q8Cu/34jr4TvvKT3UsAC2kaSvnnWcznlfJ21ZeofWO1kWHen5qxrLOefCy8vo2/OI5tHqm+GajWUNvsqP/AzmNzEH0HIatKROJ12730UcmxKROtTHul7RW+Q926YTOWyTu4HLsiX9206rfCS43tNmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=oZnijoFO; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso3129057eec.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838038; x=1778442838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2KVk/NfLkWCP3uxifGrRMEbzUM1e8rpejscYMGtaqE=;
        b=oZnijoFOao4h4lzgQH8Q/FSEyJrkasOyqOs5Hh+pQdWHMheeh6qReEGuXoxy4a5WjC
         vxiNxZ9aZ3xY6agrZuxIrA0yPacrLvoA76nM2KeWxXed4q/DWPMXm27rhksjk6PpocYd
         TIzA6yNJzszj2CyhJJ5z3fPQQKfyUohcxDuBvpdZVTEcSQ21GdB4GShfDLuRHTD2VwKa
         8Jlv9l2byPlYYWIbC3KY6nU0h+dddLO8+mP2K7Sf2M/PAmBfwcopj5oEe4XYzzGdVXun
         QlpVIyWswGPzK3ZUFESmvD9wQfVckPPoVGajMMuVcGmdGuL+n9GwfAwx958qJ68TNYiZ
         ojgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838038; x=1778442838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2KVk/NfLkWCP3uxifGrRMEbzUM1e8rpejscYMGtaqE=;
        b=hFbBerOYmn8rPrdBQoBwP6s0eiXfvVXKXeEF15sgvLaWfL8rUfaQaBvtnlIXig1yT2
         ptMlTLdfsURLjAS4uBpbgqwjiS06rx5ea0vE8f9jLKVpvFgn8DEb04PUQfhYuvngKeO6
         x+6Ee5lQI+AsefSv8D4gmafSLst0Umqd8q8L6EbOchqlB4PBVzl2+Cwauie9gAkvK7ki
         L3pIH3YJonYUUlFP+7KkYoG3yK62wOBYRxlOmxXV01zPtp1MxKumEYdKfSesxULKNUF+
         9ubnXYExGT7Dupq43nqPcmmOvt1k2Ni15Ky8Zytm3i2E/Tr2c13RJrgvNPwxkfjqHlmu
         UsoA==
X-Gm-Message-State: AOJu0YzcF3KjnflJWpwIEqXUkySR8wLSICyxUKQ4w+DunZIlrrBRPa0p
	TGnykGKlEh0CnvPMNdxhUqdWEKIcW0iCX4RTVdWJXNUWSiwg8QMt53iTj8D6nX9Sk26s7e1ekkg
	JM6yT
X-Gm-Gg: AeBDietyZM/egorBgfusloGA22RcwruLVqVuUS9CXqnNRKy1xFj7R5NTL0Qdjr6nTef
	Rdd7ZUpFkNe6CKKJx9ynOjiApa470D1w05d+LRs+ZaksGX8mqT1lQWHA1gLZG++uAJcpskQ7yN0
	Z9V8sIcf80iW65+hlezqkLDKPuYNtr7rOTxEYcFeNYxEBxTWGKoPdR6HOzx5fb/n/D9B2PGntxN
	NQvPlfIWtofxIL3iA6Wq2tXaNQILKk+7qD6KPVCjyXMeQmXyCsW+N+dmWa0CwH9NHFsLukH2uAd
	rEXH3nrhHYBS7UUmxNZEtqsX9lqKXb45Q3a8aOLpaRHyolEnKxo6zOGt+IF4QQEMZ1ceWu65sak
	xDLKnugJn1kJfSQCtMfkLF5UAB9jT7rIun7nnTAD7AKZAPEYp68k52QmWF35QoYOfiC10pfraUU
	nWYYWnKybogxJpOctm+9OfJWPYoPBeabVBjjbsIzvfnHw=
X-Received: by 2002:a05:7300:5792:b0:2da:933b:f51f with SMTP id 5a478bee46e88-2efb84b00cbmr3967139eec.11.1777838038215;
        Sun, 03 May 2026 12:53:58 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 5/5] net/sched: netem: handle multi-segment skb in corruption
Date: Sun,  3 May 2026 12:52:03 -0700
Message-ID: <20260503195348.521225-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503195348.521225-1-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 108F64B731E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283669-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The packet corruption code only flipped bits in the linear
header portion of the skb, skipping corruption when
skb_headlen() was zero.

Use skb_header_pointer() and skb_store_bits() to access the
full packet data, allowing any bit in the packet to be
corrupted regardless of how the skb is laid out.

Replaces d64cb81dcbd5 ("net/sched: sch_netem: fix out-of-bounds access
in packet corruption") with a more general solution.

Only count the number of packets that were actually corrupted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index e710898ce96e..5cbd1a0dbfda 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -509,7 +509,6 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * do it now in software before we mangle it.
 	 */
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
-		WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -532,9 +531,18 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			goto finish_segs;
 		}
 
-		if (skb_headlen(skb))
-			skb->data[get_random_u32_below(skb_headlen(skb))] ^=
-				1 << get_random_u32_below(8);
+		if (skb->len > 0) {
+			unsigned int offset = get_random_u32_below(skb->len);
+			u8 *ptr, val;
+
+			/* handle multi-segment skb's */
+			ptr = skb_header_pointer(skb, offset, 1, &val);
+			if (ptr) {
+				val = *ptr ^ (1 << get_random_u32_below(8));
+				skb_store_bits(skb, offset, &val, 1);
+				WRITE_ONCE(q->corrupted, q->corrupted + 1);
+			}
+		}
 	}
 
 	if (unlikely(sch->q.qlen >= sch->limit)) {
-- 
2.53.0


