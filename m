Return-Path: <netdev+bounces-46366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864137E362A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E62280F52
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82CD301;
	Tue,  7 Nov 2023 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CdGTlmK4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BDD2F6
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:00:50 +0000 (UTC)
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4A114;
	Tue,  7 Nov 2023 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699344044; bh=/3hYxG4N3WJw8nBKqrjTVQUWUiQVmDcgYis0QEzy/6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdGTlmK4VnFzXa0sitWFEt7Nvjmpm8NEA3Wc5ufYvHj0fJhS54nl6HQt8jcjJ2EEX
	 mDZClP0qs8x1rJi2M9kFD/1EgyvtQEicoQ8XeYD6C4g4wz4+30xyz2K8esNC9obfMt
	 IPcafEqd/0RdacsjQWHJ+KMdovx4WBgXQ24oo+Fc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 278C277; Tue, 07 Nov 2023 16:00:39 +0800
X-QQ-mid: xmsmtpt1699344042t3zlf7rlw
Message-ID: <tencent_CD19564FFE8DA8A5918DFE92325D92DD8107@qq.com>
X-QQ-XMAILINFO: NDThGJ6G3IIARYpJUjkKX0n0/eFol7V1uSZbsttNLyb9F/jJnznpXGClj0A6SD
	 Eq1yVfIhAG69EZ0t/YA8KdwgytGv+nDPcHqtvg2qfeii5KUy8mDzb/AHoPZBqQ+3uK+nAGO5InMQ
	 46Bc9JxTUo6pfGrc11tMxU2UgrKl1JNCgott2uhIv1ELBSw0knOsNERRmKoG0eiHifnrzFTPBZc2
	 EPyvP4Cwy2ygbvDEnPyXMW1MLiGV5rItY2fBTj1R2og0RogUZaLykwThrZ1rxtqNvFnHfsry2gkw
	 ZpQQ1e3O1C/lgZO2RKT+VWJ1iZ8J7TZa0lZgBbh/pwaWKa2k/ZkCHCMhQlCArnsrGgv8YT4uJWs6
	 CtMj191fMSRI73EwMCaYiXnm/UzSvbCbSz/+q7HUvJlft6ZdaP0JFBfFRgoEqUN3q1ZxPpwyZ/LX
	 dSPI+fXTGycwdfKL7Ad6lVAP/uAb3qfQ1iWZc0GLp+nb+Gm0WSaZKaHjewfd49d10ZWJsqQlmeEI
	 AY/UR3GDInYpOOyN7BTRetBcCB7GX27nfDml/NVs9ymvoMW5RPwG/PEec8yxRoCnk1wbJjMHsUsJ
	 zpv2sPHp0VQ+J66ajd6hUp47NxGxOjJmV6YJeEU8IGyOLtSHt28OVWVNNttIwouuNVMIoA2ch94A
	 Yd1gxc1Uczr1ZZlbddAVE+dzYPLdCJPKEvuzm6WELPZtXWVYBW/BAhg3hCPwdKQLw1QnbM8x3iaS
	 NjQx4XdWxIfuMKiS6TP+TW+XtmsHjul0BVFfPUsffGEHg4Lq8QZJxiYz+qhlIaV1jorehK4TmRWA
	 8ShUXXx6Mla29N81UwzkAzMmmVHcJB/0MUBL/vr0heH2lp9NI+4yG+rtHZDB0Zna/cbNXgyV4D0Z
	 KR4DGuHhv6G/FS+VkNX0WRASstuNLNCfA5LhOVhgyEG/zbcypSjTnhSbCPC+UpIGqC3u8r4O086t
	 ty1PrcWItUktrlVXmP4JupE/wBWxa1M049R7zuy7s=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
Subject: [PATCH net V9 2/2] ptp: fix corrupted list in ptp_open
Date: Tue,  7 Nov 2023 16:00:41 +0800
X-OQ-MSGID: <20231107080039.436253-4-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107080039.436253-3-eadavis@qq.com>
References: <20231107080039.436253-3-eadavis@qq.com>
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

Acked-by: Richard Cochran <richardcochran@gmail.com>
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
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
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


