Return-Path: <netdev+bounces-36823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603277B1E91
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 036351C20AE4
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714853B78A;
	Thu, 28 Sep 2023 13:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369C3B7A1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:35:56 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60592
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405417465aaso122180215e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695908152; x=1696512952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewEk1KTBBRvNKIcI3ntHRyVMGoa2Cc8R/XOZX8EHbYY=;
        b=Kh32fpx8QY+G/LRIJv6nfdv4uqNnHFyhgwsemYumg9Poy21A2al2vx4bvoqJDEjz2U
         IuKmYrcElyC42EvwDaPaU9qak0yMf2kQcuVswYnK5IrRfsmdlyUDUlNBoh0/B5UsJWS9
         4OtvRXOmNBWIPoYqK98IW56WHURdMXquFEEQp037yFVFwgv2Eoqbxe0ycCX62076PNvR
         QdSxqHI9ND05l8Oj2VQzmWbf/PC5R5Otu1F671MTpHbIhYiXo/vHztACC6F3AdcA5VJJ
         dHy5ezL5Jamn6Dpkbc63P9JT+B3rDqwjiOApk5GNM4JaXAAB4dng0iuEV4hU+TsmwPtl
         vMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908152; x=1696512952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewEk1KTBBRvNKIcI3ntHRyVMGoa2Cc8R/XOZX8EHbYY=;
        b=PUVgqoU5StfTi3q3OOLVW2vCACn3L38SBDI5DJFfbciPyHNAmByuBM3rgWaCsub+32
         mzirDmJFbQphfv1fVJVXrmHEp4CxjKNEMBMasUGBYklExAr6jws+J1Cs2/t2S/UlkZ8/
         nMR4uuqFm+Fi6JpmK1/nwmsdPonY0TlPyZOzEcIUJ5aMROeYxOkjw0I224x5Bm3ymfs+
         epjRhflVdBrPibKniRpiziL7fheW5QE9ZylaY+Q5fJm2JMcf4YS/d19X8Y10UqoyGiiA
         qwFK+ISbec+RArVmDQlomasI49tMoxh8TlBWqDB+wJUIAWZ8SRKBgqEW0L2jWmedsRx0
         QdOg==
X-Gm-Message-State: AOJu0YzvhmfiZag32lctS0oxFKGZk3eTkhxxlyTomIQSUrnFBpH+7rCL
	vAcMxnisZCaOuGWJoDezvKkk9bt1JSyL6w==
X-Google-Smtp-Source: AGHT+IFoCAvYg69luo2amhUgJgv5Zi0Njq2fOPA9W6LJV6j1e2F+frnkpXQsrjM1aeHVb5KQASKZhA==
X-Received: by 2002:a7b:c858:0:b0:406:44e5:b915 with SMTP id c24-20020a7bc858000000b0040644e5b915mr1224169wml.8.1695908151922;
        Thu, 28 Sep 2023 06:35:51 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b00406443c8b4fsm4011871wmr.19.2023.09.28.06.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:35:51 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v3 2/3] ptp: support multiple timestamp event readers
Date: Thu, 28 Sep 2023 15:35:43 +0200
Message-Id: <20230928133544.3642650-3-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928133544.3642650-1-reibax@gmail.com>
References: <20230928133544.3642650-1-reibax@gmail.com>
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
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v3:
  - fix use of safe and non safe linked lists for loops
  - introduce new posix_clock private_data and ida object ids for better
    dicrimination of timestamp consumers
  - safer resource release procedures
v2: https://lore.kernel.org/netdev/20230912220217.2008895-2-reibax@gmail.com/
  - fix ptp_poll() return value
  - Style changes to comform to checkpatch strict suggestions
  - more coherent ptp_read error exit routines
v1: https://lore.kernel.org/netdev/20230906104754.1324412-3-reibax@gmail.com/

 drivers/ptp/ptp_chardev.c   | 134 ++++++++++++++++++++++++++++--------
 drivers/ptp/ptp_clock.c     |  61 +++++++++++++---
 drivers/ptp/ptp_private.h   |  38 +++++++---
 drivers/ptp/ptp_sysfs.c     |  10 ++-
 include/linux/posix-clock.h |  24 ++++---
 kernel/time/posix-clock.c   |  43 +++++++++---
 6 files changed, 239 insertions(+), 71 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 197edf1179f1..65e7acaa40a9 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -101,14 +101,74 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	return 0;
 }
 
-int ptp_open(struct posix_clock *pc, fmode_t fmode)
+int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode)
 {
+	struct ptp_clock *ptp =
+		container_of(pcuser->clk, struct ptp_clock, clock);
+	struct ida *ida = ptp_get_tsevq_ida(ptp);
+	struct timestamp_event_queue *queue;
+
+	if (!ida)
+		return -EINVAL;
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return -EINVAL;
+	queue->close_req = false;
+	queue->reader_pid = task_pid_nr(current);
+	spin_lock_init(&queue->lock);
+	queue->ida = ida;
+	queue->oid = ida_alloc(ida, GFP_KERNEL);
+	if (queue->oid < 0) {
+		kfree(queue);
+		return queue->oid;
+	}
+	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	pcuser->private_clkdata = queue;
+
 	return 0;
 }
 
-long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
+int ptp_release(struct posix_clock_user *pcuser)
+{
+	struct ptp_clock *ptp =
+		container_of(pcuser->clk, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue = pcuser->private_clkdata;
+
+	if (queue) {
+		queue->close_req = true;
+		list_move_tail(&queue->qlist, &ptp->closed_tsevqs);
+		pcuser->private_clkdata = NULL;
+	}
+	return 0;
+}
+
+void ptp_flush_users(struct posix_clock *pc)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct timestamp_event_queue *tsevq, *tsevq_nxt;
+	unsigned long flags;
+
+	if (mutex_lock_interruptible(&ptp->close_mux))
+		return;
+
+	list_for_each_entry_safe(tsevq, tsevq_nxt, &ptp->closed_tsevqs, qlist) {
+		spin_lock_irqsave(&tsevq->lock, flags);
+		if (tsevq->ida)
+			ida_free(tsevq->ida, (unsigned int)tsevq->oid);
+		tsevq->ida = NULL;
+		list_del(&tsevq->qlist);
+		spin_unlock_irqrestore(&tsevq->lock, flags);
+		kfree(tsevq);
+	}
+
+	mutex_unlock(&ptp->close_mux);
+}
+
+long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
+	       unsigned long arg)
+{
+	struct ptp_clock *ptp =
+		container_of(pcuser->clk, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
@@ -432,65 +492,75 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-__poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
+__poll_t ptp_poll(struct posix_clock_user *pcuser, struct file *fp,
+		  poll_table *wait)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_clock *ptp =
+		container_of(pcuser->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 
-	poll_wait(fp, &ptp->tsev_wq, wait);
+	queue = pcuser->private_clkdata;
+	if (!queue)
+		return EPOLLERR;
 
-	/* Extract only the first element in the queue list
-	 * TODO: Identify the relevant queue
-	 */
-	queue = list_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+	poll_wait(fp, &ptp->tsev_wq, wait);
 
 	return queue_cnt(queue) ? EPOLLIN : 0;
 }
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
 
-ssize_t ptp_read(struct posix_clock *pc,
-		 uint rdflags, char __user *buf, size_t cnt)
+ssize_t ptp_read(struct posix_clock_user *pcuser, uint rdflags,
+		 char __user *buf, size_t cnt)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_clock *ptp =
+		container_of(pcuser->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
 
-	/* Extract only the first element in the queue list
-	 * TODO: Identify the relevant queue
-	 */
-	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
-				 qlist);
+	queue = pcuser->private_clkdata;
+	if (!queue) {
+		result = -EINVAL;
+		goto exit;
+	}
 
-	if (cnt % sizeof(struct ptp_extts_event) != 0)
-		return -EINVAL;
+	if (queue->close_req) {
+		result = -EPIPE;
+		goto exit;
+	}
+
+	if (!queue->ida) {
+		result = -ENODEV;
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
@@ -509,12 +579,16 @@ ssize_t ptp_read(struct posix_clock *pc,
 
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
+		ptp_release(pcuser);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 8996ff500392..9e271ad66933 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 #include <uapi/linux/sched/types.h>
 
 #include "ptp_private.h"
@@ -162,20 +163,51 @@ static struct posix_clock_operations ptp_clock_ops = {
 	.clock_settime	= ptp_clock_settime,
 	.ioctl		= ptp_ioctl,
 	.open		= ptp_open,
+	.release	= ptp_release,
+	.flush_users	= ptp_flush_users,
 	.poll		= ptp_poll,
 	.read		= ptp_read,
 };
 
 static void ptp_clean_queue_list(struct ptp_clock *ptp)
 {
-	struct timestamp_event_queue *element;
-	struct list_head *pos, *next;
+	struct timestamp_event_queue *tsevq;
+	struct ptp_clock_event event;
+	unsigned long flags;
+	int cnt;
+
+	memset(&event, 0, sizeof(event));
+	/* Request close of all open files */
+	list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
+		tsevq->close_req = true;
+		/* Make sure the queue is fed so that the reader is notified */
+		enqueue_external_timestamp(tsevq, &event);
+	}
+	wake_up_interruptible(&ptp->tsev_wq);
 
-	list_for_each_safe(pos, next, &ptp->tsevqs) {
-		element = list_entry(pos, struct timestamp_event_queue, qlist);
-		list_del(pos);
-		kfree(element);
+	/* Wait for all to close */
+	cnt = list_count_nodes(&ptp->tsevqs);
+	while (cnt > 1) {
+		msleep(20);
+		cnt = list_count_nodes(&ptp->tsevqs);
 	}
+	cnt = list_count_nodes(&ptp->closed_tsevqs);
+	while (cnt > 1) {
+		msleep(20);
+		cnt = list_count_nodes(&ptp->closed_tsevqs);
+	}
+
+	/* Delete first entry */
+	tsevq = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
+	spin_lock_irqsave(&tsevq->lock, flags);
+	ida_destroy(tsevq->ida);
+	kfree(tsevq->ida);
+	tsevq->ida = NULL;
+	list_del(&tsevq->qlist);
+	spin_unlock_irqrestore(&tsevq->lock, flags);
+	kfree(tsevq);
 }
 
 static void ptp_clock_release(struct device *dev)
@@ -184,11 +216,11 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	ptp_clean_queue_list(ptp);
 	ida_free(&ptp_clocks_map, ptp->index);
+	mutex_destroy(&ptp->close_mux);
 	kfree(ptp);
 }
 
@@ -243,15 +275,23 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->devid = MKDEV(major, index);
 	ptp->index = index;
 	INIT_LIST_HEAD(&ptp->tsevqs);
+	INIT_LIST_HEAD(&ptp->closed_tsevqs);
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		goto no_memory_queue;
+	queue->close_req = false;
+	queue->ida = kzalloc(sizeof(*queue->ida), GFP_KERNEL);
+	if (!queue->ida)
+		goto no_memory_queue;
+	ida_init(queue->ida);
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
-	/* TODO - Transform or delete this mutex */
-	mutex_init(&ptp->tsevq_mux);
+	queue->oid = ida_alloc(queue->ida, GFP_KERNEL);
+	if (queue->oid < 0)
+		goto ida_err;
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
+	mutex_init(&ptp->close_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
 
 	if (ptp->info->getcycles64 || ptp->info->getcyclesx64) {
@@ -350,9 +390,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	mutex_destroy(&ptp->close_mux);
+ida_err:
 	ptp_clean_queue_list(ptp);
 no_memory_queue:
 	ida_free(&ptp_clocks_map, index);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 314c21c39f6a..529d3d421ba0 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -16,6 +16,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/idr.h>
 
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
@@ -26,7 +27,12 @@ struct timestamp_event_queue {
 	int head;
 	int tail;
 	spinlock_t lock;
+	struct posix_clock_user *pcreader;
 	struct list_head qlist;
+	pid_t reader_pid;
+	struct ida *ida;
+	int oid;
+	bool close_req;
 };
 
 struct ptp_clock {
@@ -38,7 +44,8 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
-	struct mutex tsevq_mux; /* one process at a time reading the fifo */
+	struct list_head closed_tsevqs; /* close pending timestamp fifo lists */
+	struct mutex close_mux; /* protect user clean procecdures */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
@@ -109,6 +116,17 @@ static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 	return ptp_vclock_in_use(ptp);
 }
 
+/* Find the tsevq object id handler */
+static inline struct ida *ptp_get_tsevq_ida(struct ptp_clock *ptp)
+{
+	struct timestamp_event_queue *queue;
+
+	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
+				 qlist);
+
+	return queue->ida;
+}
+
 extern struct class *ptp_class;
 
 /*
@@ -119,16 +137,20 @@ extern struct class *ptp_class;
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan);
 
-long ptp_ioctl(struct posix_clock *pc,
-	       unsigned int cmd, unsigned long arg);
+long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
+	       unsigned long arg);
+
+int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode);
+
+int ptp_release(struct posix_clock_user *pcuser);
 
-int ptp_open(struct posix_clock *pc, fmode_t fmode);
+void ptp_flush_users(struct posix_clock *pc);
 
-ssize_t ptp_read(struct posix_clock *pc,
-		 uint flags, char __user *buf, size_t cnt);
+ssize_t ptp_read(struct posix_clock_user *pcuser, uint flags, char __user *buf,
+		 size_t cnt);
 
-__poll_t ptp_poll(struct posix_clock *pc,
-	      struct file *fp, poll_table *wait);
+__poll_t ptp_poll(struct posix_clock_user *pcuser, struct file *fp,
+		  poll_table *wait);
 
 /*
  * see ptp_sysfs.c
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 2675f383cd0a..c02aaba729e0 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -81,15 +81,14 @@ static ssize_t extts_fifo_show(struct device *dev,
 	size_t qcnt;
 	int cnt = 0;
 
+	cnt = list_count_nodes(&ptp->tsevqs);
+	if (cnt <= 0)
+		goto out;
+
 	/* The sysfs fifo will always draw from the fist queue */
 	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
 
-	memset(&event, 0, sizeof(event));
-
-	if (mutex_lock_interruptible(&ptp->tsevq_mux))
-		return -ERESTARTSYS;
-
 	spin_lock_irqsave(&queue->lock, flags);
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
@@ -104,7 +103,6 @@ static ssize_t extts_fifo_show(struct device *dev,
 	cnt = snprintf(page, PAGE_SIZE, "%u %lld %u\n",
 		       event.index, event.t.sec, event.t.nsec);
 out:
-	mutex_unlock(&ptp->tsevq_mux);
 	return cnt;
 }
 static DEVICE_ATTR(fifo, 0444, extts_fifo_show, NULL);
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index 468328b1e1dd..8f844ac28aa8 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -14,6 +14,7 @@
 #include <linux/rwsem.h>
 
 struct posix_clock;
+struct posix_clock_user;
 
 /**
  * struct posix_clock_operations - functional interface to the clock
@@ -50,18 +51,20 @@ struct posix_clock_operations {
 	/*
 	 * Optional character device methods:
 	 */
-	long    (*ioctl)   (struct posix_clock *pc,
-			    unsigned int cmd, unsigned long arg);
+	long (*ioctl)(struct posix_clock_user *pcuser, unsigned int cmd,
+		      unsigned long arg);
 
-	int     (*open)    (struct posix_clock *pc, fmode_t f_mode);
+	int (*open)(struct posix_clock_user *pcuser, fmode_t f_mode);
 
-	__poll_t (*poll)   (struct posix_clock *pc,
-			    struct file *file, poll_table *wait);
+	__poll_t (*poll)(struct posix_clock_user *pcuser, struct file *file,
+			 poll_table *wait);
 
-	int     (*release) (struct posix_clock *pc);
+	int (*release)(struct posix_clock_user *pcuser);
 
-	ssize_t (*read)    (struct posix_clock *pc,
-			    uint flags, char __user *buf, size_t cnt);
+	void (*flush_users)(struct posix_clock *pc);
+
+	ssize_t (*read)(struct posix_clock_user *pcuser, uint flags,
+			char __user *buf, size_t cnt);
 };
 
 /**
@@ -90,6 +93,11 @@ struct posix_clock {
 	bool zombie;
 };
 
+struct posix_clock_user {
+	struct posix_clock *clk;
+	void *private_clkdata;
+};
+
 /**
  * posix_clock_register() - register a new clock
  * @clk:   Pointer to the clock. Caller must provide 'ops' field
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 77c0c2370b6d..8ae76492f7ea 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -19,7 +19,12 @@
  */
 static struct posix_clock *get_posix_clock(struct file *fp)
 {
-	struct posix_clock *clk = fp->private_data;
+	struct posix_clock_user *pcuser = fp->private_data;
+	struct posix_clock *clk;
+
+	if (!pcuser)
+		return NULL;
+	clk = pcuser->clk;
 
 	down_read(&clk->rwsem);
 
@@ -39,6 +44,7 @@ static void put_posix_clock(struct posix_clock *clk)
 static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct posix_clock_user *pcuser = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -EINVAL;
 
@@ -46,7 +52,7 @@ static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 		return -ENODEV;
 
 	if (clk->ops.read)
-		err = clk->ops.read(clk, fp->f_flags, buf, count);
+		err = clk->ops.read(pcuser, fp->f_flags, buf, count);
 
 	put_posix_clock(clk);
 
@@ -55,6 +61,7 @@ static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 
 static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 {
+	struct posix_clock_user *pcuser = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	__poll_t result = 0;
 
@@ -62,7 +69,7 @@ static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 		return EPOLLERR;
 
 	if (clk->ops.poll)
-		result = clk->ops.poll(clk, fp, wait);
+		result = clk->ops.poll(pcuser, fp, wait);
 
 	put_posix_clock(clk);
 
@@ -72,6 +79,7 @@ static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 static long posix_clock_ioctl(struct file *fp,
 			      unsigned int cmd, unsigned long arg)
 {
+	struct posix_clock_user *pcuser = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -ENOTTY;
 
@@ -79,7 +87,7 @@ static long posix_clock_ioctl(struct file *fp,
 		return -ENODEV;
 
 	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(clk, cmd, arg);
+		err = clk->ops.ioctl(pcuser, cmd, arg);
 
 	put_posix_clock(clk);
 
@@ -90,6 +98,7 @@ static long posix_clock_ioctl(struct file *fp,
 static long posix_clock_compat_ioctl(struct file *fp,
 				     unsigned int cmd, unsigned long arg)
 {
+	struct posix_clock_user *pcuser = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -ENOTTY;
 
@@ -97,7 +106,7 @@ static long posix_clock_compat_ioctl(struct file *fp,
 		return -ENODEV;
 
 	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(clk, cmd, arg);
+		err = clk->ops.ioctl(pcuser, cmd, arg);
 
 	put_posix_clock(clk);
 
@@ -110,6 +119,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 	int err;
 	struct posix_clock *clk =
 		container_of(inode->i_cdev, struct posix_clock, cdev);
+	struct posix_clock_user *pcuser;
 
 	down_read(&clk->rwsem);
 
@@ -117,14 +127,20 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		err = -ENODEV;
 		goto out;
 	}
+	pcuser = kzalloc(sizeof(*pcuser), GFP_KERNEL);
+	if (!pcuser) {
+		err = -ENOMEM;
+		goto out;
+	}
+	pcuser->clk = clk;
+	fp->private_data = pcuser;
 	if (clk->ops.open)
-		err = clk->ops.open(clk, fp->f_mode);
+		err = clk->ops.open(pcuser, fp->f_mode);
 	else
 		err = 0;
 
 	if (!err) {
 		get_device(clk->dev);
-		fp->private_data = clk;
 	}
 out:
 	up_read(&clk->rwsem);
@@ -133,14 +149,23 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 
 static int posix_clock_release(struct inode *inode, struct file *fp)
 {
-	struct posix_clock *clk = fp->private_data;
+	struct posix_clock_user *pcuser = fp->private_data;
+	struct posix_clock *clk;
 	int err = 0;
 
+	if (!pcuser)
+		return -ENODEV;
+	clk = pcuser->clk;
+
 	if (clk->ops.release)
-		err = clk->ops.release(clk);
+		err = clk->ops.release(pcuser);
 
 	put_device(clk->dev);
 
+	if (clk->ops.flush_users)
+		clk->ops.flush_users(clk);
+
+	kfree(pcuser);
 	fp->private_data = NULL;
 
 	return err;
-- 
2.34.1


