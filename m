Return-Path: <netdev+bounces-46910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7037E70BE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE11C209E7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570D24A1A;
	Thu,  9 Nov 2023 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylJvIvjN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12430327
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:49:03 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938230FA
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:49:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dae71322ed4so1438463276.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699552141; x=1700156941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jM4jF9VNXW2lH4+D7qn2qjAfp3xCUH06MQnorNHS5G0=;
        b=ylJvIvjNn2BrkrZnQrRFzbTWQAumlLeRKZzC1iAa1lc1dnSawT9SaEiiX7xGYLKyz5
         nFVoR/Gw1GJikOE119qAmcnzjvy7iUSiUv6mgGngiORHFPw6IXsz7H5JpjJYBAJcS/GD
         AeA1Vt4Drgddm4mX5P8eAzIavBzMiQVpYVgnpphnI/THtZsXGKP/T6IZ8WS38mtOlY6f
         3WPJYLzIWtDtKUh7bqlhnuNPPo4fbOblwbHRs5BOEJl34jmujNtQhzRS+svlMKoAllba
         MdluitlMzvam+f+dx3Tn0EffL040tGbtpvG5efcNfpaZOwVhxCSlvBkOHpzI3V6jAPMC
         FzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552141; x=1700156941;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jM4jF9VNXW2lH4+D7qn2qjAfp3xCUH06MQnorNHS5G0=;
        b=rZviOZkaqBUFGkixFy+uGAWRsy7yHIZ7hpNxza3UiAKDeVcN785Mo+wi/9GTWBRH2m
         KeXZ9g3kGVwBVRJuZQdJWA3425B9KHUiJBAybHTRWQLmN49Ie1vZZQRNkT2kx7Zf+OKn
         pHbq229ERYZcxDYN1dE76wIe7CIsB3hgW90VfsiDhN0xCdUpWe2045ehlHMnHu+enmLb
         YSrPFUennf+u0zwbByyPqshPUDPiD4fWftLElI+DUksUGjpFvZLoIuVU+lpBE89+ssOd
         9TmapY+9Lr9Pw4tL+OwWz1Qyav0fjx9EA6znYFeUdc0RBcmEwYXe5TB6GNq/NvU4zK1F
         R9dw==
X-Gm-Message-State: AOJu0Yz326mBpIjzAL+PwOPDXjhIpk6sOkwZTQaJ8RFVWt4EzbPGoIl6
	t/GbOhHRLsD/z5tZeyPN8p8ah8IYnFlPyQ==
X-Google-Smtp-Source: AGHT+IFwydmi9D1hdnEiUChLGTXB5oi7LqccZAeAopykP4wEJLgkrczMdEmzoTyvGBYQlw8qdfjzdrBV0D1jSA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d52:0:b0:d9a:ec95:9687 with SMTP id
 79-20020a250d52000000b00d9aec959687mr140118ybn.11.1699552141611; Thu, 09 Nov
 2023 09:49:01 -0800 (PST)
Date: Thu,  9 Nov 2023 17:48:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109174859.3995880-1-edumazet@google.com>
Subject: [PATCH net] ptp: annotate data-race around q->head and q->tail
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"

As I was working on a syzbot report, I found that KCSAN would
probably complain that reading q->head or q->tail without
barriers could lead to invalid results.

Add corresponding READ_ONCE() and WRITE_ONCE() to avoid
load-store tearing.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Richard Cochran <richardcochran@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 3 ++-
 drivers/ptp/ptp_clock.c   | 5 +++--
 drivers/ptp/ptp_private.h | 8 ++++++--
 drivers/ptp/ptp_sysfs.c   | 3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 3f7a7478880240a2d256caf624b61dcc8e7054af..7513018c9f9ac72d5c1b0055b55ae9ff36e710b0 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -572,7 +572,8 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 
 	for (i = 0; i < cnt; i++) {
 		event[i] = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 
 	spin_unlock_irqrestore(&queue->lock, flags);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3134568af622d396f6ab15049cd1a3ace3243269..15b804ba48685ee11a34b88df1ae738a136d17a1 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -57,10 +57,11 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	dst->t.sec = seconds;
 	dst->t.nsec = remainder;
 
+	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 
-	queue->tail = (queue->tail + 1) % PTP_MAX_TIMESTAMPS;
+	WRITE_ONCE(queue->tail, (queue->tail + 1) % PTP_MAX_TIMESTAMPS);
 
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 35fde0a0574606a04d6bdf0ab42a204da5fa6532..45f9002a5dcaea2c588c001fa83317fc318500ee 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -85,9 +85,13 @@ struct ptp_vclock {
  * that a writer might concurrently increment the tail does not
  * matter, since the queue remains nonempty nonetheless.
  */
-static inline int queue_cnt(struct timestamp_event_queue *q)
+static inline int queue_cnt(const struct timestamp_event_queue *q)
 {
-	int cnt = q->tail - q->head;
+	/*
+	 * Paired with WRITE_ONCE() in enqueue_external_timestamp(),
+	 * ptp_read(), extts_fifo_show().
+	 */
+	int cnt = READ_ONCE(q->tail) - READ_ONCE(q->head);
 	return cnt < 0 ? PTP_MAX_TIMESTAMPS + cnt : cnt;
 }
 
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 7d023d9d0acbfb3d128be09578753588fa59e84d..f7a499a1bd39ec22edf6c77407a48736e137f277 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -94,7 +94,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
 		event = queue->buf[queue->head];
-		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+		/* Paired with READ_ONCE() in queue_cnt() */
+		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 	}
 	spin_unlock_irqrestore(&queue->lock, flags);
 
-- 
2.42.0.869.gea05f2083d-goog


