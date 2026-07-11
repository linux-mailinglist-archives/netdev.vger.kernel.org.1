Return-Path: <netdev+bounces-306806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v+4MNbUdUmqNMAMAu9opvQ
	(envelope-from <netdev+bounces-306806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D57413FE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ghIg4nZR;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306806-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306806-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F37353016653
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5953AE18A;
	Sat, 11 Jul 2026 10:40:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80639989B
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766440; cv=none; b=rVuR3xP/VcrcQjUIuF9FKWl3xFCauQf0MCHtBzpPbuGGvfaqeBBfWFy6cXX2e+X7Nc9osLXnaqPbRTsjMKp7Ylt4YoaVU59DESv6CTIFm5RsVnnsM9s5gTfPNBipljA8MlcaRnbpNy3kzjl5Km0BCinrGuqtbghOZxI1o/j7gBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766440; c=relaxed/simple;
	bh=E6cOOOK8JRaX4aDVdN1M0+1MtzS0eNCG8VJsAdIuLwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8/OTKRnaXAsSHkSgdZkBZMSsDesQd3x9gliZ29dboL9X4JMqpYu6FTN0HqJAgAwaM7hDytKY/Aa5aXpjqSRe3LeltJ6Zr+LEN/cVSJpIeykX4WH0kK5bJaQgs0pdj/DirtasidBURZy55JQbVjM64j2aTyR/eQQZRiFLzrVRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghIg4nZR; arc=none smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15c257a488so249840166b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766437; x=1784371237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dvOpz0r7ZGyorI3Hc7NN1bB6/9+WhAP8KvikiSMDSlo=;
        b=ghIg4nZRSWfB3jpks7gT83/0l/RxVwSxmKgfxiCZYYLw46eGpI2jHcaU6vNj19s0Or
         mSjLfJMtFTYh1K45TajB0uwoY7KstWyZd8rtYapWiIdCPMTGUL8ptP24WCS4u/i6Lk7m
         +lso9rw7fUdp86lOudMl6hUeVAyqHur9NOWsGvjnVJxH2cnWNCstDcWEdJoBXtTIqCDp
         nDwS9KOJkJx+aQMlYRJ5Uu+nJprf0HVA8Dro0vR6a4frPsFJHjTr6K4vsCzaa9SJHOCN
         lbcg+eRZN40L4b19HYTPSfezILC3IsXn7uBT+ZfUZF3kGtSs+JvgqDA4HSsJxSlwG5LB
         kYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766437; x=1784371237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dvOpz0r7ZGyorI3Hc7NN1bB6/9+WhAP8KvikiSMDSlo=;
        b=SJyjRG3/p81TZn8xYVFtXFdQg5shgAQUEkYb2YsCkNAaTFTIFAbrUNUkj3QPBT5/kl
         8hD2tOU3lbsGAyz2PlEpO07NGn89DbnkD63aW4iDdu4OYR+GZanFHcx7u6zL0SGbMTMp
         hUGOmICyWxZiiaK2ORs0+XWwkzkPku9qdXNoIZuqQcsOS+oa+bJ7z6VODDxxGZgERgT/
         ALujia5qpcNPkyJkrWBaX8chIzBasjk4qv1j9fr3GBcaOzpi5jkyt6IU3jyiA731u+bH
         dmso3P0JzwJDQp7nFfJvbYuWUKzcSlaSIbN7mB+59S/14r0wPPdClFwcMvPBPvLVp2Ge
         zjRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoD9Moxg7B45Q85VQS3kixgTxeBLHdT7ORRJbuG7a4hKGskWu1HwAFBj2CnxqBTS/XehpeMOZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+mKZlnB22IRAzJlaLk7Q+K/ct1s0chG94fc5W7gukTI+6HjY
	Mtlk2LM4MeYdFvg+ungE29FggrIh3BeL60NwuRohPLOrb9GzjF1tJ8PaiLe+Sw==
X-Gm-Gg: AfdE7clRC5Ay1oFE4o1xux/nttLglHLg4EvlCPvpGwfhejuJQp8U5BJ93KDbDE6H3xd
	DzPfV+w33i+C9xQegFQoHfYAYA11Mc7QnyfMD1JxHmNii30q+QmlqRkKFLFVycBjm0T1p9+zH2y
	GIBXrOwfhGI7rDeS3nYe5Arf6zdUwbToAjH4plAiEjTQTFFVcdtGKCyhBzBlhikvSUezQnwmBYj
	sWK8AiHz7xFSVgFSgxozLcGtWzIiA3vslSPHHHqu4rX3VVow0ZjQJvpL4vOq0byinIo0VvLvrCn
	+yseJLuZBL717N710oXP7MFTM6sQ6KEWriUhlsM8h4wpBQTKnV+MMW9O+6bfFO2+JP+nXgV/Fdg
	Rqh4GIhMhWqRzMZMZhF8KRHmyUAQeAgweMNVUAtZRd0aLcoy/KcPBwfl3BhH+5d1u0H0k9n0WCO
	yW7yKVAVleYRRsZgwZ6tUbjsywCMxeO6W03lKL3FYyof31gjXqtYzn7Q94PO/yAhtyH9Ih+NAwQ
	940PnbvPFM3wxwjtRJYnOwuDXLrWGf85Ww1GgOeftTspAELoQ==
X-Received: by 2002:a17:907:9604:b0:c12:34ed:e108 with SMTP id a640c23a62f3a-c161f37e257mr76942666b.58.1783766437237;
        Sat, 11 Jul 2026 03:40:37 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:36 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 03/17] io_uring/zcrx: add RQ iterator
Date: Sat, 11 Jul 2026 11:39:56 +0100
Message-ID: <ee60806a753b75c2cbc6edaf8d0cb468e7b9d0cf.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 979D57413FE

Add a iterator structure and helper functions for the refill queue
processing to avoid polluting io_zcrx_ring_refill() with extra state
and logic once it's extended in following patches.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c4a9a663eba4..45b178afbbc3 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1088,6 +1088,10 @@ void io_unregister_zcrx(struct io_ring_ctx *ctx)
 	xa_destroy(&ctx->zcrx_ctxs);
 }
 
+struct zcrx_rq_iter {
+	int rqes_left;
+};
+
 static inline u32 zcrx_rq_entries(struct zcrx_rq *rq)
 {
 	u32 entries;
@@ -1103,6 +1107,24 @@ static struct io_uring_zcrx_rqe *zcrx_next_rqe(struct zcrx_rq *rq, unsigned mask
 	return &rq->rqes[idx];
 }
 
+static inline void zcrx_rq_iter_init(struct zcrx_rq_iter *it,
+				     struct zcrx_rq *rq)
+{
+	it->rqes_left = min_t(unsigned, zcrx_rq_entries(rq), ZCRX_REFILL_CAP);
+}
+
+static inline bool zcrx_rq_iter_next(struct zcrx_rq_iter *it,
+				     struct zcrx_rq *rq,
+				     struct io_uring_zcrx_rqe **rqe)
+{
+	it->rqes_left--;
+	if (unlikely(it->rqes_left < 0))
+		return false;
+
+	*rqe = zcrx_next_rqe(rq, rq->nr_entries - 1);
+	return true;
+}
+
 static inline bool io_parse_rqe(struct io_uring_zcrx_rqe *rqe,
 				struct io_zcrx_ifq *ifq,
 				struct net_iov **ret_niov)
@@ -1131,17 +1153,15 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 				    netmem_ref *netmems, unsigned to_alloc)
 {
 	struct zcrx_rq *rq = &ifq->rq;
-	unsigned int mask = rq->nr_entries - 1;
-	unsigned int rqes_left;
+	struct io_uring_zcrx_rqe *rqe;
+	struct zcrx_rq_iter it;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
-	rqes_left = zcrx_rq_entries(rq);
-	rqes_left = min_t(unsigned, rqes_left, ZCRX_REFILL_CAP);
+	zcrx_rq_iter_init(&it, rq);
 
-	for (; rqes_left; rqes_left--) {
-		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
+	while (zcrx_rq_iter_next(&it, rq, &rqe)) {
 		struct net_iov *niov;
 		netmem_ref netmem;
 
-- 
2.54.0


