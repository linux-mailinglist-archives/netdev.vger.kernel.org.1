Return-Path: <netdev+bounces-40168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B675A7C6071
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83511C2101C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25172D50B;
	Wed, 11 Oct 2023 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7qW2LY4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418E12E51
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:40:11 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236EC6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406402933edso4169415e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064007; x=1697668807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/nnP9l32LjqLFh8TKMytsH+qE574lmTYdTAz8rjZUM=;
        b=T7qW2LY4U2WTEjPSVYxF6/ysqTgfA10gxDo5h4JYBLCLlQs+Dk+9Eggkg7J61LyW62
         NMiPyaztOsOWCFHgIp9Lza6vwOvO+LJJ7aXcRxe95j68SOkKEGF5cjcvtwuCLCk9sa42
         iPkZ0SPyW/KR2LcaiP3NiwUBc24ijXmrZmegSvQqRPWxiqNgucqCBFsJAa0ikrWb6Aqc
         hBf4NWL7VfAB6VhJrMeAqi/y2V4DM1SVw/cSuHs4UY7lgqTN8l0jB1oAugAjZ+rM8+UK
         yoLemS8HwMxqERUAyom2+k/ZjHb+jBImBGUNbjsY2K44DXjRivjP7raiFdwwgS/Uy1Gs
         GRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064007; x=1697668807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/nnP9l32LjqLFh8TKMytsH+qE574lmTYdTAz8rjZUM=;
        b=LUpleVNcvRt6iIaSFJMFb825vnwoDbTahTugE9SiE95ZosDcPywPjl5OIhKwkBP5bX
         wnePY08b/bmM9tE3MMy4Ee016YhKTDdeu0gmGoGY1f4WG1TdqXiBpWRkhbVqJix7LGn9
         YucwAB3vVuUi0+xq8cdQFXyscT7QoWxYQ+kVm8cY10K4XyOHYfS9ySYewYShptxes8+p
         WIGkw8lhFW5nJtpYbyRFb8fBKX7i4EwbF3Ud3fJPX8hdB2/JdGbtahzEJwm4DehQ25KH
         iiFtRuazqZXAgb8DQzhBesGH6AX6jhs09Akd35m2OOzUBiOe1cX0w/ZVbH3PmUf4CFzo
         oOrQ==
X-Gm-Message-State: AOJu0YzrpscUaYtwOPw4c5eMiTeYNOzI6uAdb8q4yLYD46iY4bHEYzzg
	qoUFY5qAfXKoU+l5V/6Gy7ZD80disqcsXg==
X-Google-Smtp-Source: AGHT+IE/Bfh66Nc22V+WUKQ0ug1Y1AZ4W+Zpq4KNXB9qU7yL/swd/3ZSmw0TGUZq2cDTF6xSOsMyJg==
X-Received: by 2002:a1c:7414:0:b0:405:dbe2:df10 with SMTP id p20-20020a1c7414000000b00405dbe2df10mr20443485wmc.35.1697064006986;
        Wed, 11 Oct 2023 15:40:06 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b00405442edc69sm19964031wmr.14.2023.10.11.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:40:06 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	tglx@linutronix.de,
	jstultz@google.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	kuba@kernel.org
Subject: [PATCH net-next v6 2/6] ptp: Replace timestamp event queue with linked list
Date: Thu, 12 Oct 2023 00:39:54 +0200
Message-Id: <1b07be8f05b5d476602c4c77f1c27101fe055aed.1697062274.git.reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1697062274.git.reibax@gmail.com>
References: <cover.1697062274.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce linked lists to access the timestamp event queue.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v4: https://lore.kernel.org/netdev/a0aaf9c5347ea05deb8153511294676bc46f63d8.1696511486.git.reibax@gmail.com/
  - simpler queue clean procedure
  - fix/clean comment lines
v3: https://lore.kernel.org/netdev/20230928133544.3642650-2-reibax@gmail.com/
  - fix use of safe and non safe linked lists for loops
v2: https://lore.kernel.org/netdev/20230912220217.2008895-1-reibax@gmail.com/
  - Style changes to comform to checkpatch strict suggestions
v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/
---
 drivers/ptp/ptp_chardev.c | 12 ++++++++++--
 drivers/ptp/ptp_clock.c   | 26 ++++++++++++++++++++++++--
 drivers/ptp/ptp_private.h |  4 +++-
 drivers/ptp/ptp_sysfs.c   |  6 +++++-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 0ba3e7064df2..aa1990d2ab46 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -439,10 +439,14 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue;
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
-	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
+	/* Extract only the first element in the queue list */
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+
+	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
@@ -452,12 +456,16 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue = &ptp->tsevq;
+	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
 
+	/* Extract only the first element in the queue list */
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
 	if (cnt % sizeof(struct ptp_extts_event) != 0)
 		return -EINVAL;
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da..157ef25bc1b1 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -169,12 +169,21 @@ static struct posix_clock_operations ptp_clock_ops = {
 static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
+	struct timestamp_event_queue *tsevq;
+	unsigned long flags;
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	/* Delete first entry */
+	tsevq = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+	spin_lock_irqsave(&tsevq->lock, flags);
+	list_del(&tsevq->qlist);
+	spin_unlock_irqrestore(&tsevq->lock, flags);
+	kfree(tsevq);
 	ida_free(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
@@ -206,6 +215,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 				     struct device *parent)
 {
 	struct ptp_clock *ptp;
+	struct timestamp_event_queue *queue = NULL;
 	int err = 0, index, major = MAJOR(ptp_devt);
 	size_t size;
 
@@ -228,7 +238,12 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->info = info;
 	ptp->devid = MKDEV(major, index);
 	ptp->index = index;
-	spin_lock_init(&ptp->tsevq.lock);
+	INIT_LIST_HEAD(&ptp->tsevqs);
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		goto no_memory_queue;
+	spin_lock_init(&queue->lock);
+	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	mutex_init(&ptp->tsevq_mux);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
@@ -333,6 +348,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	list_del(&queue->qlist);
+	kfree(queue);
+no_memory_queue:
 	ida_free(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
@@ -375,6 +393,7 @@ EXPORT_SYMBOL(ptp_clock_unregister);
 
 void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 {
+	struct timestamp_event_queue *tsevq;
 	struct pps_event_time evt;
 
 	switch (event->type) {
@@ -383,7 +402,10 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
-		enqueue_external_timestamp(&ptp->tsevq, event);
+		/* Enqueue timestamp on all queues */
+		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
+			enqueue_external_timestamp(tsevq, event);
+		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index a3110c85f694..cc8186a92eec 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -15,6 +15,7 @@
 #include <linux/ptp_clock.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/time.h>
+#include <linux/list.h>
 
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
@@ -25,6 +26,7 @@ struct timestamp_event_queue {
 	int head;
 	int tail;
 	spinlock_t lock;
+	struct list_head qlist;
 };
 
 struct ptp_clock {
@@ -35,7 +37,7 @@ struct ptp_clock {
 	int index; /* index into clocks.map */
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
-	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+	struct list_head tsevqs; /* timestamp fifo list */
 	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6e4d5456a885..2675f383cd0a 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -75,12 +75,16 @@ static ssize_t extts_fifo_show(struct device *dev,
 			       struct device_attribute *attr, char *page)
 {
 	struct ptp_clock *ptp = dev_get_drvdata(dev);
-	struct timestamp_event_queue *queue = &ptp->tsevq;
+	struct timestamp_event_queue *queue;
 	struct ptp_extts_event event;
 	unsigned long flags;
 	size_t qcnt;
 	int cnt = 0;
 
+	/* The sysfs fifo will always draw from the fist queue */
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
 	memset(&event, 0, sizeof(event));
 
 	if (mutex_lock_interruptible(&ptp->tsevq_mux))
-- 
2.30.2


