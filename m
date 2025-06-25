Return-Path: <netdev+bounces-201112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16667AE8217
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E61C200B1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36589265CB0;
	Wed, 25 Jun 2025 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kLsq2WEh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WAYsNwFB"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F1264634;
	Wed, 25 Jun 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852361; cv=none; b=iLz6jfm67QmM1Z5A2q0Ewvu//dynH8kpM7jhSEi5EwmCdyzTCP/mKG3Kn389U0g/xvqj7HWXkJ+upunQKwlGE45T6/TZ4Z2li0kDbbznf8pFUOe32PtnOuYXEJlsTH/XIdcMsK0b+QWnwfe9PDHIK/wFt1ma04DgoGKtCHo/T4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852361; c=relaxed/simple;
	bh=GJ9L8P5fX9+5aVNCWu/bHLaPykNnj/9VnbR+7NUm8pI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fJHuMr5uk1BXTzPp5ZQ8rZNArBwZdBSgX50wjS5DIJd/ITcC2nZuE2N6v8FgNZ49HJDnBOZqKJa99U9gORMa97wI8mCTifm1i7QuBI6XynCuldV4WOD/lmzyKN75sEVHmwcnnDyLIIHuWZADYVw9EPFsPLjqnzb606nQQr8yNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kLsq2WEh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WAYsNwFB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.425029269@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZrPTWm0oJsAfPaNIADSOD58SP7bLTlsVpT6I6K8U52E=;
	b=kLsq2WEhTaAa//1/rxb00CJg9f7pYyCnIKSerhbcyCIln9unw/NOzJZki243QTB1q0KsUE
	GjLOLPSBt7oUuZAs0QWKn9IC1s3ud+BwxwscZsxQevwNrI+3sYeAI3SUeoHnhpGSA1PeSQ
	1IDHv/i1YbNdicIErOlDw3TjDVuydg9vsu7LgR7S609XuA8tRLYKPJC1WxWOjOpk4wuL09
	kZtK9WK4JSkRwX8CMqb1KUZ2AOUp2j/ZpJLUXMSg1fP7EDEtjlQRL0nhHrFyQuMkR5W4mm
	3LeDh0SH471bmxU2bLHUHRXIX/1LP9vnIKGQGU7TtM7sG70J51GgYRuHgL23tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ZrPTWm0oJsAfPaNIADSOD58SP7bLTlsVpT6I6K8U52E=;
	b=WAYsNwFB/BUJFY0GGSict/QVOCXELMJDtHkkwZptZ+33a+VglkI0Y4ON2mq0er+pcsFLTM
	MNYmOafWiv1GK0CA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 12/13] ptp: Convert chardev code to lock guards
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:38 +0200 (CEST)

Convert the various spin_lock_irqsave() protected critical regions to
scoped guards. Use spinlock_irq instead of spinlock_irqsave as all the
functions are invoked in thread context with interrupts enabled.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/ptp/ptp_chardev.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -110,7 +110,6 @@ int ptp_open(struct posix_clock_context
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
-	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -122,9 +121,8 @@ int ptp_open(struct posix_clock_context
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
-	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
-	list_add_tail(&queue->qlist, &ptp->tsevqs);
-	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
+		list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
 
 	/* Debugfs contents */
@@ -143,15 +141,13 @@ int ptp_open(struct posix_clock_context
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
-	unsigned long flags;
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 
 	debugfs_remove(queue->debugfs_instance);
 	pccontext->private_clkdata = NULL;
-	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
-	list_del(&queue->qlist);
-	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
+		list_del(&queue->qlist);
 	bitmap_free(queue->mask);
 	kfree(queue);
 	return 0;
@@ -548,8 +544,6 @@ ssize_t ptp_read(struct posix_clock_cont
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
-	unsigned long flags;
-	size_t qcnt, i;
 	int result;
 
 	queue = pccontext->private_clkdata;
@@ -584,21 +578,19 @@ ssize_t ptp_read(struct posix_clock_cont
 		goto exit;
 	}
 
-	spin_lock_irqsave(&queue->lock, flags);
+	scoped_guard(spinlock_irq, &queue->lock) {
+		size_t qcnt = queue_cnt(queue);
 
-	qcnt = queue_cnt(queue);
+		if (cnt > qcnt)
+			cnt = qcnt;
 
-	if (cnt > qcnt)
-		cnt = qcnt;
-
-	for (i = 0; i < cnt; i++) {
-		event[i] = queue->buf[queue->head];
-		/* Paired with READ_ONCE() in queue_cnt() */
-		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
+		for (size_t i = 0; i < cnt; i++) {
+			event[i] = queue->buf[queue->head];
+			/* Paired with READ_ONCE() in queue_cnt() */
+			WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
+		}
 	}
 
-	spin_unlock_irqrestore(&queue->lock, flags);
-
 	cnt = cnt * sizeof(struct ptp_extts_event);
 
 	result = cnt;




