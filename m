Return-Path: <netdev+bounces-46208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF77E26D5
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7871B281493
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973F1A715;
	Mon,  6 Nov 2023 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BCBqhwNH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815728DAA
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:31:39 +0000 (UTC)
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A5BD;
	Mon,  6 Nov 2023 06:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699281094; bh=yzxDq748KAPnudB/nqPp/8I4auKX8wfzYxRjAIXed9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCBqhwNH9EIBJzbgzLgFFjU3PpMMxjYojExc5l4ay0Z8VVISM7UQnJquo72D7oHvL
	 vMJbTAMwM5At7vvDwpYT5eABUKdKmuDK2ATJK5to3LGlicxbRwfKXXkCsFmlk7HmfP
	 LfmYLuhCfU3olpvkOAoM5YlaW7BFF51PPjUaobRU=
Received: from pek-lxu-l1.wrs.com ([2408:8409:2460:1c13:549b:dd5b:edb5:dcb3])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 7DB81248; Mon, 06 Nov 2023 22:31:27 +0800
X-QQ-mid: xmsmtpt1699281091tdsadapns
Message-ID: <tencent_1372C3B5244E7768777606C0F36563612905@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt9BxiBJRFQ/ns45YnFZYoXjlllQhBwQUNPAWFY/qdObadO7sW3d
	 uTxSQDKhr9JcFFXi/AV5uzT7OT/PuGOqgkV7C3424hNfYPwK7fmNDKBIMTkAt+Ld54d6THzele4g
	 I5spFu0xqo3MpJfHVxP6BfYWZoWjWjk4T5ljbQRhJlH/UGZxUk62viFLrYZMAlsF//DmpdvYsO19
	 baLf+3XeB94jBfF0tUVZTr3UVcqIurrrHJnGF8kzGFj34YdxsAr3RbuHtqFwqrizOzR4Ez7nhvO1
	 XMQDXLN4ces75AycCqbZwyU1YW4g8uwXIkx1fnbu1DLXBkAhnxS+tYHLDhtLGeojweXzHS9x15eu
	 5mJ2GpMGjO+dZRki+j8IE19EflPl6q8o6bVFtv5sDoSDEG43l5KhP8qY1gt+5tTnBt+2zVqaCo+H
	 RmPkX3tFeK6NRwx5/6sOqoDvxmfcU3Z3ISFA3M95eI9y/RzZQ//xvzWzhJxw3T6PwmYGAbtjESkU
	 wu1y/ZiQM3pMOsjRWOI9iMsuMpHbcAYLvLelLSIGxxNLVruwQ0Gr4gd/B8DS3u0+harwtCQgKRER
	 kWuGjGdjKWRhx+75eTk8wklI+SGP1bCXrcslWWRh5EZXKIY/FHDSAscnHt5RQngxMuOO2qp2bUsB
	 uDRu3dm7RaT2oxKms6mHNRzZ9szK1u/JgUglXp8mscehSLwxGVFABVcGZk0GXU8glzPVOCX5x43g
	 6U5BlomYjPvxsQBa6Gb33qwruI3Iya55sY+SI4E6ss9AeTfY5z+UQtjSRVTFzDPB2QKV2HE+NnCO
	 yUPEc6S2qWy5AlrwRwf+SLWiradqXtKaq13JnH0EZo872nKAe6CbcrBd+H/itNASlZDnC9ocglNz
	 EiPbplpHqF0QjRJbgHMl628ItaOTtTEfUK1Kl1j04anSeQiLEuk8nUAKnEIAGvTCG+jcYwEn4Jb+
	 mVFz7/9eYf48OdPWQsLBz3uyZx+NcFBPyKkWjZFPWqXnBofPoWBEn/sxdQdHOO/Wz6P48znGy8oc
	 XmLDVak+0Geyv4P+kP
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH net-next V8 2/2] ptp: fix corrupted list in ptp_open
Date: Mon,  6 Nov 2023 22:31:28 +0800
X-OQ-MSGID: <20231106143127.3936908-4-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106143127.3936908-3-eadavis@qq.com>
References: <20231106143127.3936908-3-eadavis@qq.com>
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


