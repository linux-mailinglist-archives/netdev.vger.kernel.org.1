Return-Path: <netdev+bounces-33390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC779DB89
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1741281CB7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47560BA29;
	Tue, 12 Sep 2023 22:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B134A92D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:02:29 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1E10D9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:02:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-403012f276dso40188355e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694556146; x=1695160946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1zXodHUWWoiS3DLQ0Igs7xvxAHmTbQxFZwMtP1FTBU=;
        b=QBQCe5P2kDyTfSGlrMfoEN6DLc0WAqaOjzzutXNBJkn7jplHI9yOO4wtLpx4Y45Do2
         /ngA36KokALiCDlNBI86zDkqPbu5yPtuIgd5r2YmUsVOoWY8LqnLK9kdwCOBSOYkzYPv
         2sJEFSEyl9GUW2uuWay9QJR/HypH2GHkJxj+hhWC9ta+5LgOuHm2I0ExxWOjsNOWGT6A
         vzc6KLq5hqsfjR5VbMQ1Jej4EHsFLo8tTZz4tfwhsboknvodAmSQ/07/735FPREJSJDc
         5QRdnoL5BkRK9GjFxMTjcjx4Ud+aHHA1e31sY6hwkPbq2P8Xp2SVKU7k2+C/UHRgIQff
         be6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556146; x=1695160946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1zXodHUWWoiS3DLQ0Igs7xvxAHmTbQxFZwMtP1FTBU=;
        b=k3QKzK42V44Cta64nR25TEzDo6KnDuzmKWti/kn3KPzEvp6+f4p0XqEC7OELYHWy3G
         +dAKvUXRB1ey8RtE3JWRNJzkJ77O4u6P73vT1UB6GfMOZBDjRv09xd1eHyCK2zomzVut
         B+vQ7alp+8vx45t4V+f1OE4MjZNLgK2BYkgP6ibQjgZMgJ5HEuthSIRLBvIa/X5wBesH
         p+foXZXKgSblQNe1wM4V1wT4sxKooahJ8mOYLo/wItnUpm1njPtQNKO2f/Z9Dntp4tEa
         +ge/LrKMRMaORpsenFY2Vzi0L3dnw7F/GkaJxFxfv5Ye7FaIYNRtNuZWve6IMlLjYpnZ
         WXRg==
X-Gm-Message-State: AOJu0Yzv58fYgqIDPisoCa3sDy86Tkp202X4PbYFm9CyT57wW/iG1fcF
	hUN9HxzFQznv/jyQOjWbvks+OZdxfSSJ8Q==
X-Google-Smtp-Source: AGHT+IFU7w/n9NI6qorb7JT1l79urAzjW+2sriQpNPvL6lTJ0ZTsFOTGXNzh8YsDrGvlaFRGyqQkIg==
X-Received: by 2002:a05:600c:24d:b0:3fe:795:712a with SMTP id 13-20020a05600c024d00b003fe0795712amr498555wmj.27.1694556146169;
        Tue, 12 Sep 2023 15:02:26 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id a3-20020adfeec3000000b003196e992567sm13799082wrp.115.2023.09.12.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:02:25 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	shuah@kernel.org,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	alex.maftei@amd.com
Subject: [PATCH net-next v2 1/3] ptp: Replace timestamp event queue with linked list
Date: Wed, 13 Sep 2023 00:02:15 +0200
Message-Id: <20230912220217.2008895-1-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first of a set of patches to introduce linked lists to the
timestamp event queue. The final goal is to be able to have multiple
readers for the timestamp queue.

On this one we maintain the original feature set, and we just introduce
the linked lists to the data structure.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v2:
  - Style changes to comform to checkpatch strict suggestions
v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/

 drivers/ptp/ptp_chardev.c | 16 ++++++++++++++--
 drivers/ptp/ptp_clock.c   | 30 ++++++++++++++++++++++++++++--
 drivers/ptp/ptp_private.h |  4 +++-
 drivers/ptp/ptp_sysfs.c   |  6 +++++-
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..197edf1179f1 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -435,10 +435,16 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue;
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
-	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
+	/* Extract only the first element in the queue list
+	 * TODO: Identify the relevant queue
+	 */
+	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+
+	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
@@ -447,12 +453,18 @@ ssize_t ptp_read(struct posix_clock *pc,
 		 uint rdflags, char __user *buf, size_t cnt)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue = &ptp->tsevq;
+	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
 
+	/* Extract only the first element in the queue list
+	 * TODO: Identify the relevant queue
+	 */
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
 	if (cnt % sizeof(struct ptp_extts_event) != 0)
 		return -EINVAL;
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da..7ac04a282ec5 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -166,6 +166,18 @@ static struct posix_clock_operations ptp_clock_ops = {
 	.read		= ptp_read,
 };
 
+static void ptp_clean_queue_list(struct ptp_clock *ptp)
+{
+	struct timestamp_event_queue *element;
+	struct list_head *pos;
+
+	list_for_each(pos, &ptp->tsevqs) {
+		element = list_entry(pos, struct timestamp_event_queue, qlist);
+		list_del(pos);
+		kfree(element);
+	}
+}
+
 static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
@@ -175,6 +187,7 @@ static void ptp_clock_release(struct device *dev)
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	ptp_clean_queue_list(ptp);
 	ida_free(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
@@ -206,6 +219,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 				     struct device *parent)
 {
 	struct ptp_clock *ptp;
+	struct timestamp_event_queue *queue = NULL;
 	int err = 0, index, major = MAJOR(ptp_devt);
 	size_t size;
 
@@ -228,7 +242,13 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
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
+	/* TODO - Transform or delete this mutex */
 	mutex_init(&ptp->tsevq_mux);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
@@ -333,6 +353,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	ptp_clean_queue_list(ptp);
+no_memory_queue:
 	ida_free(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
@@ -375,6 +397,7 @@ EXPORT_SYMBOL(ptp_clock_unregister);
 
 void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 {
+	struct timestamp_event_queue *tsevq, *tsevq_alt;
 	struct pps_event_time evt;
 
 	switch (event->type) {
@@ -383,7 +406,10 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
-		enqueue_external_timestamp(&ptp->tsevq, event);
+		/* Enqueue timestamp on all other queues */
+		list_for_each_entry_safe(tsevq, tsevq_alt, &ptp->tsevqs, qlist) {
+			enqueue_external_timestamp(tsevq, event);
+		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 75f58fc468a7..314c21c39f6a 100644
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
2.34.1


