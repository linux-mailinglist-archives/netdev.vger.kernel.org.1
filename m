Return-Path: <netdev+bounces-306804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nwb6E6sdUmqLMAMAu9opvQ
	(envelope-from <netdev+bounces-306804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C17413F8
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PtlkbAzA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306804-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306804-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A00053011048
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC013BB11D;
	Sat, 11 Jul 2026 10:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6023B992E
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766435; cv=none; b=neQkE/tBQxmeNu2lBwZOHqOJX31Alcm7PIdnlgwsyyc10O7+g2Wgyt6+jpuSXdZFu6MW/glMOg66T4AtZXTfSG+H4ZM4V1tkz3jzY7sWjespLOQapvmpq0zGfMNIfu63UQIj8WGo8cZX0rZ6XOLieWQvpJDF4Nhd05TU/qZn6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766435; c=relaxed/simple;
	bh=O9J/2l2LcB+jyMFa6SaQuqJkPyhfu3duBPFRLNJ2SpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbvxCSvXcIyht7FkMm+w326RTgmh1JSZbdVAaPGuRwwt7RKl1e1PWZ3Ukhq21Ms0mfn1A3dsjGi0AXN6szAu4x5/S+9xUhSZZjfkFnxxls9qdyajA9TD03PHqWu5xXDOoR8/pys52nX5nO5fvJyAwXyMvuC9FsqJqt4l1+54phw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtlkbAzA; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15b509c323so237625866b.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766431; x=1784371231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlpMAjb/Om74qf+FFxwyoZxa1Yqnmh7GeyI4L+jcCaY=;
        b=PtlkbAzAyAFtNdMm33NPgBxL53l3UdRDA9D/htJGaSTZCgi5S75v7OgtiZhzvqNCwB
         CkTcboiP1m9J/oZVlmHmS2fgHSSpljP4LGX1Rs6dKVhkD05rF//Qwcujhwv0TtWnEytF
         UMzm1OJ2u/OB0Ex7We3mLD3PGZQm7hYUJQTWVC7zv/apB2XJT36KwOCe68d8O+EwJ0Vw
         JkSCyQPoVouFZShf5Vj30bwD6x0W/hr692275R3mo54qu5G/4R4iw5CT+xdIaTmt1FXA
         /b3cOAEZuSV6LIIMrMRRL3Xw2ZZdnWrXD2xWj6ZeI5fEeJ7VLu79lD9qKa1Ao/oLYNI7
         6+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766431; x=1784371231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlpMAjb/Om74qf+FFxwyoZxa1Yqnmh7GeyI4L+jcCaY=;
        b=P8BlI02u0fQ6fONGXBvtnIUP+v8lYmNxQSsO0GVw03yiU+CNnZwqF5veaEs7uEgh/w
         8q9DCkbXtStqpAoG97xIWi0N52v+lxMfflHyo9gWmqpXyUMmJOYsu9B8YN9xDYX4fduU
         0enNljHlog5w07Us6On6niJcrCPRInE/pCDsRcQWmI6ctuqhPd4YmiS5HIENKzlKoXj5
         t6eD3ZavxG0TfA2tfNtpJ9BbADSURnSppvy8mGZHYlvIZ9SussOSSe+NgMWMzH7cTaWH
         Fk6is9pV0DNHR5lg/p6pI5mldT3INMRCwzhlGwqjnqkeFtxt7/p6NG+aqxGzzrnNzK5E
         dD7Q==
X-Forwarded-Encrypted: i=1; AFNElJ88ITu+BXeJf4e1ylX0NrGz51rAWD+YOmy8lqzurgkn7BQGFNRjK51flL6duv83aGe3mcCtjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywow/ESqIyjyI69b1rauW+8Ntx35Nh7ZXJb8sde30fFGX46NJAr
	+zgpYxJIGpk3665Ir35vyQXqh+aPqfOU9hQavcWaLghIEGz/ujSU6txc
X-Gm-Gg: AfdE7clTQZ5J/vzkbz9teXsYCkO6qVFWBYtcsfpazUY1NlRMnGuZho9EUSM9lrJG4Zq
	q1NNzQ/BNDpheWO2DOmlko1728qw1YJzj6mTl3bX3tRZfOS+s1XGtBnALUSkyI5N6ea2DJnea3R
	kp5HcuohLbEy2OoKLqxhIug3kknO8+HLg6egKDsXnm2C4igWL9d1XMhtUAgWhMj6l4XpU48TWnl
	wskVO5ZzErrOc8gLYcKZgte51ISlj2R1s6o8esSKrVr9xpBFJtUIFW0ysXQjDASymHfjmg/h9UN
	4qh8YpuRz/GTe+/XM7TFOiAIUjYmr099mQPGnbO6Cgk74Ntnv1Qfdk5iOL1qM9gON2DL06SDlLA
	xA8VK+uGuunkeQXIn4dRV+zbZwb10Eb/FPBkT7rpWcXgQHo/i3Fp0I4i/1VLATpThZg60ZwXmHf
	24cjGN2HYAWiPv5WyNDBqP1U2BoRuLrSoTvqxdDQbbxxMhtDyvv6MFcRYuHwmWquCQf2aFCkG6g
	fS2WnIZ2ktIbizgzluWqPJP/JyNZYFlBSQk+aRR8764JuTtlA==
X-Received: by 2002:a17:907:3d0d:b0:c12:b227:c0c8 with SMTP id a640c23a62f3a-c161f39350dmr80077666b.50.1783766431223;
        Sat, 11 Jul 2026 03:40:31 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:30 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 01/17] io_uring/zcrx: scale refilling with large pages
Date: Sat, 11 Jul 2026 11:39:54 +0100
Message-ID: <dea84f254f89c7e799a24790f2ebc37a08b59720.1783616211.git.asml.silence@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-306804-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D27C17413F8

io_zcrx_ring_refill() caps the loop by mixing the max number of
allocated netmems and the number of available RQEs together, which
caps the number of entries to process the pp cache size. As a result,
when niovs are heavily fragmented, the refilling logic allocates only a
small number of niovs per call on average and sometimes even none.

Keep a separate counter for the number of processed RQ entries, which is
capped by a roughly calculated from the page size value to keep the
cache full. And separately break if it allocates enough niovs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 6bd71435e475..8348413d6d24 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -28,6 +28,13 @@
 #include "zcrx.h"
 #include "rsrc.h"
 
+#define ZCRX_MAX_FRAGS_PER_PAGE MAX(PAGE_SIZE / 1024, 1)
+/*
+ * We need a reasonable limit to be able to fill in 64 entries on average
+ * for 1500 byte MTU. Over-estimate it to keep it pow2.
+ */
+#define ZCRX_REFILL_CAP MIN(64 * ZCRX_MAX_FRAGS_PER_PAGE, 1024)
+
 #define IO_ZCRX_AREA_SUPPORTED_FLAGS	(IORING_ZCRX_AREA_DMABUF)
 
 #define IO_DMA_ATTR (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
@@ -1125,17 +1132,15 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 {
 	struct zcrx_rq *rq = &ifq->rq;
 	unsigned int mask = rq->nr_entries - 1;
-	unsigned int entries;
+	unsigned int rqes_left;
 	unsigned allocated = 0;
 
 	guard(spinlock_bh)(&rq->lock);
 
-	entries = zcrx_rq_entries(rq);
-	entries = min_t(unsigned, entries, to_alloc);
-	if (unlikely(!entries))
-		return 0;
+	rqes_left = zcrx_rq_entries(rq);
+	rqes_left = min_t(unsigned, rqes_left, ZCRX_REFILL_CAP);
 
-	do {
+	for (; rqes_left; rqes_left--) {
 		struct io_uring_zcrx_rqe *rqe = zcrx_next_rqe(rq, mask);
 		struct net_iov *niov;
 		netmem_ref netmem;
@@ -1156,7 +1161,9 @@ static unsigned io_zcrx_ring_refill(struct page_pool *pp,
 
 		netmems[allocated] = netmem;
 		allocated++;
-	} while (--entries);
+		if (allocated >= to_alloc)
+			break;
+	}
 
 	smp_store_release(&rq->ring->head, rq->cached_head);
 	return allocated;
-- 
2.54.0


