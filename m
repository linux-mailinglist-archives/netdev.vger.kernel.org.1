Return-Path: <netdev+bounces-32223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BAC793A4D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA5928143F
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8230566D;
	Wed,  6 Sep 2023 10:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE487E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:48:14 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C426910F9
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:48:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b5516104so34424025e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997280; x=1694602080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJUmuSIwPiuMBs8OmdGVOt9Y6L2l5R1BUyhmQJoQeNU=;
        b=K0XWrDmbqQ3JQMPrgIfkOOHYP8EkL7at6gnJaamrhPt+Akl2lxmznm/mfwYv4XFfWj
         Nf7Mt3DczZczE+fIOmZ2eH6RF+IZUGOm7QJKa2UxCgk0mX0tSqGiuY/NwJRP2+MxUjl2
         B780Rxs0zIWyiPIRAtpBKgI6owangkkxdzv8AcAnsdGZwgw3IhRTlV2oSSstSMMGxzF5
         eDFQlU/ryH+PUM9rl7FJsPGRY5BJdqhNvB5M6CXFIk89LyJp3TAjHWn8NXqd8jQJYmNz
         WUmbIRRNP/lujoGCaJHyySrivOGb540JURFQnYGWVu/CYvON714cKmTaCzrhNZ99gZRF
         0NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997280; x=1694602080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJUmuSIwPiuMBs8OmdGVOt9Y6L2l5R1BUyhmQJoQeNU=;
        b=C3zSb79MJsV08/SZtpWA3rFznZnA/0v+qTgeZoNWwOlMMIvmT32BwtemrqTkfYB00/
         K3aL5N+kXtFA2moGi/yEDFACBdYWU+/q/4abuJM+IYSjlwULw46/1CI1JrshACpqfion
         J9F9Kci2FVKm3VszpbVlzHszoRZPUbgbsU2yOxfmlPOcZZWD7+5RFz4Yev9Eix3jWtsk
         a5F8cpPui0JiYc2IVFu2cwXPYoyqXnRa5zI5InHw7WOy8c9QPRdwkviEEiiu+jCP765S
         px6eFfpCjawvYrfquNPWfGY36Oka5eUHW6yQpl7JhEanz3Gu0opih1sPDoO0lF0QiteD
         Nh8Q==
X-Gm-Message-State: AOJu0Yx1XXEVp0jb6DffKPDulh7Kav3xyj24hDGQphjyz8NFtk8i7Tc0
	fixB2qQGj34nxnpG80HbeKs=
X-Google-Smtp-Source: AGHT+IEzI+0C1LWBQvmFf0PkNmMwx7koI3/2ibrOfqmURV502fawq1KVv2dtJYhi3ynJn6vq2yAOIg==
X-Received: by 2002:a7b:cb96:0:b0:3fe:d6bf:f314 with SMTP id m22-20020a7bcb96000000b003fed6bff314mr1879161wmi.39.1693997280048;
        Wed, 06 Sep 2023 03:48:00 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm19508728wmi.33.2023.09.06.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:47:59 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [PATCH 1/3] ptp: Replace timestamp event queue with linked list
Date: Wed,  6 Sep 2023 12:47:52 +0200
Message-Id: <20230906104754.1324412-2-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906104754.1324412-1-reibax@gmail.com>
References: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
 <20230906104754.1324412-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the first of a set of patches to introduce linked lists to the
timestamp event queue. The final goal is to be able to have multiple
readers for the timestamp queue.

On this one we maintain the original feature set, and we just introduce
the linked lists to the data structure.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 18 ++++++++++++++++--
 drivers/ptp/ptp_clock.c   | 30 ++++++++++++++++++++++++++++--
 drivers/ptp/ptp_private.h |  4 +++-
 drivers/ptp/ptp_sysfs.c   |  6 +++++-
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..1ea11f864abb 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -435,10 +435,17 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue;
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
-	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
+	/*
+	 * Extract only the first element in the queue list
+	 * TODO: Identify the relevant queue
+	 */
+	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+
+	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
@@ -447,12 +454,19 @@ ssize_t ptp_read(struct posix_clock *pc,
 		 uint rdflags, char __user *buf, size_t cnt)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue = &ptp->tsevq;
+	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
 
+	/*
+	 * Extract only the first element in the queue list
+	 * TODO: Identify the relevant queue
+	 */
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
 	if (cnt % sizeof(struct ptp_extts_event) != 0)
 		return -EINVAL;
 
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da..dd48b9f41535 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -166,6 +166,18 @@ static struct posix_clock_operations ptp_clock_ops = {
 	.read		= ptp_read,
 };
 
+static void ptp_clean_queue_list(struct ptp_clock *ptp)
+{
+	struct list_head *pos;
+	struct timestamp_event_queue *element;
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
+	queue = kzalloc(sizeof(struct timestamp_event_queue), GFP_KERNEL);
+	if (queue == NULL)
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
@@ -376,6 +398,7 @@ EXPORT_SYMBOL(ptp_clock_unregister);
 void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 {
 	struct pps_event_time evt;
+	struct timestamp_event_queue *tsevq, *tsevq_alt;
 
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
index 75f58fc468a7..014293255677 100644
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
+	struct list_head qlist; /* Link to other queues */
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


