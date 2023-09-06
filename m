Return-Path: <netdev+bounces-32224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD0793A4E
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F01C20AD9
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6BD17E4;
	Wed,  6 Sep 2023 10:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B17E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:48:19 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C80199F
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:48:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40078c4855fso34392645e9.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997282; x=1694602082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65gwA4q5n+YpII0wBkIL+YWS0or2Y/v+uHr6EorpFpE=;
        b=pLRFTfCAxACbJQ2A4xjLjA2aLIn+tck+Auti70cGQzoo0SFD1e2OmHPULGOPxsmyL4
         FImBYWzKMogeVkvNsqyjSdV1OMyulR4rPhfynBgMvtY/kn6/azvbYKgH4qR/C/AVpxgx
         ixIbze9nnBGod1kkFbicbwkDb8i844kt7c68BZPyEAPMd/bMq+rTGSj/2b1yYe84wW8q
         wMwb1aJ7zdKLIjTKk+ppPMIDxx55+Iv7Za44bL8bRv9ewj/ZxSGuNRkSljm3eEctOWXa
         0g4igekdjHTPkjjAioC+G2t82YqjWPy/N5CkXj7nh3P4N48e9MuPaoh2u8iY3tURs/7v
         +gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997282; x=1694602082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65gwA4q5n+YpII0wBkIL+YWS0or2Y/v+uHr6EorpFpE=;
        b=KbcsHmpIao2+/nHfjCtA9QEOLwavP1MMWF/CpWN66FAC8ANB6u8Sl10b90FMNHcx87
         ycrn8MutyVj87EJVEYg7uf9dtYoqquj9/VBtawH0NY7ytMUlsBmH2dihMMgCaPPw0rlY
         vq5Wj/0bEy9sn/0Dg1U9OCFMXV6J7W5Gr1di/aG3NV/aPmlm4H3PhG0tAFKBO398ZKXa
         gLVkUKxzdsz1WuA4DcZk37N/SlZMLqHQK+GbuJ3yzj3L/SaIouZfdL/kGmbFZxqZ71MY
         uynYWOJuJmCgGcC2cb28YgIB2/VDUd7ftNoGiO5Ah1YnJqJDPQlUCm+fb4ItYY7gFK/H
         dykg==
X-Gm-Message-State: AOJu0YwWUJMejmHFn40LezzCjvR5ptX1YPvWnLwXrUEnNod2ejN8JQY3
	VO99yucON+RzeoUJ0+1nt40=
X-Google-Smtp-Source: AGHT+IGMhbEVU+oaksMiBWnBkokfA4jafJIjVvSpdlpBOuhYaujIBO+IRyqMnl3GVdY/AL7AwFS2hg==
X-Received: by 2002:a05:600c:b88:b0:402:e68f:888a with SMTP id fl8-20020a05600c0b8800b00402e68f888amr619304wmb.3.1693997282238;
        Wed, 06 Sep 2023 03:48:02 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm19508728wmi.33.2023.09.06.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:48:02 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [PATCH 2/3] ptp: support multiple timestamp event readers
Date: Wed,  6 Sep 2023 12:47:53 +0200
Message-Id: <20230906104754.1324412-3-reibax@gmail.com>
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

Use linked lists to create one event queue per open file. This enables
simultaneous readers for timestamp event queues.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 95 ++++++++++++++++++++++++++++++---------
 drivers/ptp/ptp_clock.c   |  6 +--
 drivers/ptp/ptp_private.h |  4 +-
 drivers/ptp/ptp_sysfs.c   |  4 --
 4 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 1ea11f864abb..c65dc6fefaa6 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -103,9 +103,39 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 
 int ptp_open(struct posix_clock *pc, fmode_t fmode)
 {
+	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue;
+
+	queue = kzalloc(sizeof(struct timestamp_event_queue), GFP_KERNEL);
+	if (queue == NULL)
+		return -EINVAL;
+	queue->reader_pid = task_pid_nr(current);
+	list_add_tail(&queue->qlist, &ptp->tsevqs);
+
 	return 0;
 }
 
+int ptp_release(struct posix_clock *pc)
+{
+	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct list_head *pos, *n;
+	struct timestamp_event_queue *element;
+	int found = -1;
+	pid_t reader_pid = task_pid_nr(current);
+
+	list_for_each_safe(pos, n, &ptp->tsevqs) {
+		element = list_entry(pos, struct timestamp_event_queue, qlist);
+		if (element->reader_pid == reader_pid) {
+			list_del(pos);
+			kfree(element);
+			found = 0;
+			return found;
+		}
+	}
+
+	return found;
+}
+
 long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
@@ -436,14 +466,25 @@ __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
+	struct list_head *pos, *n;
+	bool found = false;
+	pid_t reader_pid = task_pid_nr(current);
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
 	/*
-	 * Extract only the first element in the queue list
-	 * TODO: Identify the relevant queue
+	 * Extract only the desired element in the queue list
 	 */
-	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+	list_for_each_safe(pos, n, &ptp->tsevqs) {
+		queue = list_entry(pos, struct timestamp_event_queue, qlist);
+		if (queue->reader_pid == reader_pid) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
 
 	return queue_cnt(queue) ? EPOLLIN : 0;
 }
@@ -459,40 +500,50 @@ ssize_t ptp_read(struct posix_clock *pc,
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
+	struct list_head *pos, *n;
+	bool found = false;
+	pid_t reader_pid = task_pid_nr(current);
 
 	/*
-	 * Extract only the first element in the queue list
-	 * TODO: Identify the relevant queue
+	 * Extract only the desired element in the queue list
 	 */
-	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
-				 qlist);
+	list_for_each_safe(pos, n, &ptp->tsevqs) {
+		queue = list_entry(pos, struct timestamp_event_queue, qlist);
+		if (queue->reader_pid == reader_pid) {
+			found = true;
+			break;
+		}
+	}
 
-	if (cnt % sizeof(struct ptp_extts_event) != 0)
-		return -EINVAL;
+	if (!found) {
+		result = -EINVAL;
+		goto exit;
+	}
+
+	if (cnt % sizeof(struct ptp_extts_event) != 0) {
+		result = -EINVAL;
+		goto exit;
+	}
 
 	if (cnt > EXTTS_BUFSIZE)
 		cnt = EXTTS_BUFSIZE;
 
 	cnt = cnt / sizeof(struct ptp_extts_event);
 
-	if (mutex_lock_interruptible(&ptp->tsevq_mux))
-		return -ERESTARTSYS;
-
 	if (wait_event_interruptible(ptp->tsev_wq,
 				     ptp->defunct || queue_cnt(queue))) {
-		mutex_unlock(&ptp->tsevq_mux);
 		return -ERESTARTSYS;
 	}
 
 	if (ptp->defunct) {
-		mutex_unlock(&ptp->tsevq_mux);
-		return -ENODEV;
+		result = -ENODEV;
+		goto exit;
 	}
 
 	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
 	if (!event) {
-		mutex_unlock(&ptp->tsevq_mux);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto exit;
 	}
 
 	spin_lock_irqsave(&queue->lock, flags);
@@ -511,12 +562,16 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	cnt = cnt * sizeof(struct ptp_extts_event);
 
-	mutex_unlock(&ptp->tsevq_mux);
-
 	result = cnt;
-	if (copy_to_user(buf, event, cnt))
+	if (copy_to_user(buf, event, cnt)) {
 		result = -EFAULT;
+		goto free_event;
+	}
 
+free_event:
 	kfree(event);
+exit:
+	if (result < 0)
+		ptp_release(pc);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index dd48b9f41535..dc2f045cacbd 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -162,6 +162,7 @@ static struct posix_clock_operations ptp_clock_ops = {
 	.clock_settime	= ptp_clock_settime,
 	.ioctl		= ptp_ioctl,
 	.open		= ptp_open,
+	.release	= ptp_release,
 	.poll		= ptp_poll,
 	.read		= ptp_read,
 };
@@ -184,7 +185,6 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	ptp_clean_queue_list(ptp);
@@ -246,10 +246,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	queue = kzalloc(sizeof(struct timestamp_event_queue), GFP_KERNEL);
 	if (queue == NULL)
 		goto no_memory_queue;
+	queue->reader_pid = 0;
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
-	/* TODO - Transform or delete this mutex */
-	mutex_init(&ptp->tsevq_mux);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
@@ -350,7 +349,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	ptp_clean_queue_list(ptp);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 014293255677..56b0c9df188d 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -27,6 +27,7 @@ struct timestamp_event_queue {
 	int tail;
 	spinlock_t lock;
 	struct list_head qlist; /* Link to other queues */
+	pid_t reader_pid;
 };
 
 struct ptp_clock {
@@ -38,7 +39,6 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
-	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
@@ -124,6 +124,8 @@ long ptp_ioctl(struct posix_clock *pc,
 
 int ptp_open(struct posix_clock *pc, fmode_t fmode);
 
+int ptp_release(struct posix_clock *pc);
+
 ssize_t ptp_read(struct posix_clock *pc,
 		 uint flags, char __user *buf, size_t cnt);
 
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 2675f383cd0a..512b0164ef18 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -87,9 +87,6 @@ static ssize_t extts_fifo_show(struct device *dev,
 
 	memset(&event, 0, sizeof(event));
 
-	if (mutex_lock_interruptible(&ptp->tsevq_mux))
-		return -ERESTARTSYS;
-
 	spin_lock_irqsave(&queue->lock, flags);
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
@@ -104,7 +101,6 @@ static ssize_t extts_fifo_show(struct device *dev,
 	cnt = snprintf(page, PAGE_SIZE, "%u %lld %u\n",
 		       event.index, event.t.sec, event.t.nsec);
 out:
-	mutex_unlock(&ptp->tsevq_mux);
 	return cnt;
 }
 static DEVICE_ATTR(fifo, 0444, extts_fifo_show, NULL);
-- 
2.34.1


