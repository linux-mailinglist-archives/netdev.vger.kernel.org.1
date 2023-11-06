Return-Path: <netdev+bounces-46205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E97E2600
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304CCB20DF3
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC09249FD;
	Mon,  6 Nov 2023 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nJ2F/Id7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A81200DA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 13:48:00 +0000 (UTC)
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6213D8;
	Mon,  6 Nov 2023 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699278476; bh=EJudLZETgEABMWZNAnUgwz6zsPd5cK0BfnFDCy8ZOBA=;
	h=From:To:Cc:Subject:Date;
	b=nJ2F/Id7FjKaVXsr9NuykgpHh2TgAkEt60OAv2q19MUKRsmwx9G+mq1RHjuxpRdLm
	 FR+g2OPZsC4Ur6w8pZZ0nKJJb3kpYYF2SuUYD47N3FPC6mwVU1SXSwcvxpGYKNe171
	 h4V1RPhN0Ptfh8gCuqPrLLnun7W9k8VzV3nUUufI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id A6233279; Mon, 06 Nov 2023 21:41:34 +0800
X-QQ-mid: xmsmtpt1699278094tcg2y2bpq
Message-ID: <tencent_2BEC6ECCDC7AB66DF02D496E4C9738EB960A@qq.com>
X-QQ-XMAILINFO: NkBK3x0tNc759LLae0hf8RvQgAoD+w5EXsEaQyodv1bzxabCSDNzSZxgmup67l
	 5sO4iVqgggyoQJlCQkPrXfXCUvW18GK4qH4RmWVKxE4AnHS59+nMs5TosgTqugIqWuqVkVT9LOOk
	 ESjFX55FLEnQB7b1PbfUgtAqczTPy5m1abO7WF2hyI9Psnj4ahUD+aSsEElTiFZDJ8Pqexg5D3rw
	 tgk87roZT0OBhQjchldYhx2o+iu5GezUDnD2V1/dor3cq2zv30jOqob5zTGAkNjb91iDMJa23gDf
	 xzhgzjTB/K9MhnMFIs8DEmYyFpdFg5iCFdlb6Hcc7Abu0ZzZBZlJLvHzw0Z88cV+ATJLn6ElTglC
	 VCu/QeWC9H89v0N7doTbfQlEHxC6PUmsbv9+twNEHvjpQhSQlFJ8vm5KMXllflCcfn5XBOJve2kw
	 CLJu0fiONl8FC9AeRCVdy9sHDY1dT6yH7O4go6TUwgbHQEGQy6JYATb0Zy/68bDofTA0Qr1Hj4D7
	 ShFa27ES6WdYyq6EP406W0z0HICDY00XH7yTm5ost4hDtIQ6tb/6R+P3N+ykqwR6Li/uU2U64kWa
	 SoCd3PalOJrmslAMNsaAmeDHNxD8xwBIMZaZpHICs2N+FFEUNxAorzfhj0fUALWxU4F+y3eSjCXF
	 my10yUrpije5qxHXLKXJ0Ys5/vWBimQVSgOUxrvt4WnTxmxNvJoGmA41vRh6CD0yAhL+UT2gwry7
	 HIarH3EqZD2oYDvu07CPQv/DQiQBmOJCEYLTrhMn8Ttc6VFZdjOxgSKv23mfdsS6HurhiomuUCr6
	 bCjznRGLfFD9Bks1royBY7NFTU/vOp9TrJhcSuZ9eqHT/cOHeDfXgpDazaPJ8PX/S0rOWkD+3sgC
	 veEmqE5MJ5dKkIp48vttcZ0hjiUdnS05pXPpjLMC4VUak5aQS84hgMQwu3ziW1bkLrX4oeXkzk4G
	 T9lCbgTcQsviUZLr/hhA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V7 1/2] ptp: fix corrupted list in ptp_open
Date: Mon,  6 Nov 2023 21:41:34 +0800
X-OQ-MSGID: <20231106134133.3882778-3-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no lock protection when writing ptp->tsevqs in ptp_open() and
ptp_release(), which can cause data corruption, use spin lock to avoid this
issue.

Moreover, ptp_release() should not be used to release the queue in ptp_read(),
and it should be deleted altogether.

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 21 ++++++++++++---------
 drivers/ptp/ptp_clock.c   |  8 ++++++--
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..473b6d992507 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -108,6 +108,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
+	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -119,7 +120,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 	pccontext->private_clkdata = queue;
 
 	/* Debugfs contents */
@@ -139,16 +142,16 @@ int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
 	unsigned long flags;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
-	if (queue) {
-		debugfs_remove(queue->debugfs_instance);
-		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
-		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
-		bitmap_free(queue->mask);
-		kfree(queue);
-	}
+	debugfs_remove(queue->debugfs_instance);
+	pccontext->private_clkdata = NULL;
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
+	list_del(&queue->qlist);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	bitmap_free(queue->mask);
+	kfree(queue);
 	return 0;
 }
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..b901f2910963 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -179,11 +179,11 @@ static void ptp_clock_release(struct device *dev)
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	/* Delete first entry */
+	spin_lock_irqsave(&tsevq->lock, flags);
 	tsevq = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
-	spin_lock_irqsave(&tsevq->lock, flags);
 	list_del(&tsevq->qlist);
-	spin_unlock_irqrestore(&tsevq->lock, flags);
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	debugfs_remove(ptp->debugfs_root);
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_lock_init(&ptp->tsevqs_lock);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
 	if (!queue->mask)
 		goto no_memory_bitmap;
@@ -407,6 +408,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 {
 	struct timestamp_event_queue *tsevq;
 	struct pps_event_time evt;
+	unsigned long flags;
 
 	switch (event->type) {
 
@@ -415,10 +417,12 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 
 	case PTP_CLOCK_EXTTS:
 		/* Enqueue timestamp on selected queues */
+		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
 			if (test_bit((unsigned int)event->index, tsevq->mask))
 				enqueue_external_timestamp(tsevq, event);
 		}
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..35fde0a05746 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	spinlock_t tsevqs_lock; /* protects tsevqs from concurrent access */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1


