Return-Path: <netdev+bounces-38926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95E7BD107
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ED01C20A94
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEB34195;
	Sun,  8 Oct 2023 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmZkbo4e"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C51328D9
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 22:49:40 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71CAC
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:49:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so38217865e9.3
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696805374; x=1697410174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YMt1GOEPRn7/vbYQepJLhccSjuhOt3rZVRvwb+4bRM=;
        b=lmZkbo4eWcQegrMrsRKGjJ+/DTNAW8Ki1bc8939ldfdqBt73123cpsQG5Z4CqtlO/N
         2S7C/WmxyKi/8lqUPDBwE6/7rxBrt+xgBn5ThwvoAb9JK8ILkzc2M7bxLdM/g0y/SJIG
         Y7k52ekM4e8wgPtBzh8d6dM/78jg4ZN4aLs8S4cJg+lKCw1A1wEsme3z7rj7p0YlCyce
         Hv66E7KjVzPd4QKU17MTCo1dQkP5KgvhOiewQ9GRbNnN8iGVwB1UcqaLokt9869ffHOq
         G3SKZnkqI9WjTZMY2kU3goCzAjS/hD5Kzhh6aTH1sdXW14Q/o9+Ah+AC7bwO/g/Vt2rL
         AsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805374; x=1697410174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YMt1GOEPRn7/vbYQepJLhccSjuhOt3rZVRvwb+4bRM=;
        b=D6xuByJYv6gI1Y79vPJIBeXPHRgoG0mGcf6LJ24xgjhM2j7JNTX4lPMrjRF3IXLcqQ
         W6YhUv7GM5bzzDvxz0ipT2Re1LWG34ySCBDoNLhonwO61DHI3bwkbV/h1iwE+y7qJr/b
         K+JWQbSRn/EygDz12YXn6L1LPa07wtnFX6dZ3ZgNCPfyP/ZyiT+s4l1NNldexOk5nVpE
         YNzde0ZQtTq+91luv3o7hRH5UwLI+SkSukQBpTgA2ZoY22X3nhUBz0wnJcXLgJHRwknn
         RoRsVOgs4VfoS5U5C7NxeBJrTwfLVIBt72iUhXNFrPVbEkT3QHnHC6xSjtnbNxVOBETW
         Ltkg==
X-Gm-Message-State: AOJu0YwhCjqmqLD4S/MHeWkYatMvDoswK8Basd8UcEYaUU1kyFy1q/fK
	vvySRf698lIvnghsBtZ4c6KucVjkTsr8Ag==
X-Google-Smtp-Source: AGHT+IGNR7739sVRaZpiFxqITf+Krf9xzwSV78nYkkReHR0WvZcvV0CZJ4d9ABFZNGvm/4nvG9zc5w==
X-Received: by 2002:a1c:ed07:0:b0:405:37bb:d93e with SMTP id l7-20020a1ced07000000b0040537bbd93emr10975127wmh.9.1696805374174;
        Sun, 08 Oct 2023 15:49:34 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm11804891wmg.40.2023.10.08.15.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:49:33 -0700 (PDT)
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
	shuah@kernel.org
Subject: [PATCH net-next v5 3/6] ptp: support multiple timestamp event readers
Date: Mon,  9 Oct 2023 00:49:18 +0200
Message-Id: <8d00077cc37ec9f709b1b4a7fae8d5bf5a0c043c.1696804243.git.reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1696804243.git.reibax@gmail.com>
References: <cover.1696804243.git.reibax@gmail.com>
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
v4: https://lore.kernel.org/netdev/32cf9345e1f06f62ad36b54bdd107baea7b079b6.1696511486.git.reibax@gmail.com/
  - split modifications in different patches for improved organization
  - simplified release procedures
  - remove unnecessary checks
v3: https://lore.kernel.org/netdev/20230928133544.3642650-3-reibax@gmail.com/
  - fix use of safe and non safe linked lists for loops
  - introduce new posix_clock private_data and ida object ids for better
    dicrimination of timestamp consumers
  - safer resource release procedures
v2: https://lore.kernel.org/netdev/20230912220217.2008895-2-reibax@gmail.com/
  - fix ptp_poll() return value
  - Style changes to comform to checkpatch strict suggestions
  - more coherent ptp_read error exit routines
v1: https://lore.kernel.org/netdev/20230906104754.1324412-3-reibax@gmail.com/
---
 drivers/ptp/ptp_chardev.c | 68 ++++++++++++++++++++++++++++-----------
 drivers/ptp/ptp_clock.c   |  6 ++--
 drivers/ptp/ptp_private.h |  1 -
 drivers/ptp/ptp_sysfs.c   |  9 +++---
 4 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index aa1990d2ab46..abe94bb80cf6 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -103,6 +103,31 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 
 int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 {
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue;
+
+	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue)
+		return -EINVAL;
+	spin_lock_init(&queue->lock);
+	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	pccontext->private_clkdata = queue;
+	return 0;
+}
+
+int ptp_release(struct posix_clock_context *pccontext)
+{
+	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	unsigned long flags;
+
+	if (queue) {
+		pccontext->private_clkdata = NULL;
+		spin_lock_irqsave(&queue->lock, flags);
+		list_del(&queue->qlist);
+		spin_unlock_irqrestore(&queue->lock, flags);
+		kfree(queue);
+	}
 	return 0;
 }
 
@@ -441,10 +466,11 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 
-	poll_wait(fp, &ptp->tsev_wq, wait);
+	queue = pccontext->private_clkdata;
+	if (!queue)
+		return EPOLLERR;
 
-	/* Extract only the first element in the queue list */
-	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue, qlist);
+	poll_wait(fp, &ptp->tsev_wq, wait);
 
 	return queue_cnt(queue) ? EPOLLIN : 0;
 }
@@ -462,36 +488,36 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 	size_t qcnt, i;
 	int result;
 
-	/* Extract only the first element in the queue list */
-	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
-				 qlist);
+	queue = pccontext->private_clkdata;
+	if (!queue) {
+		result = -EINVAL;
+		goto exit;
+	}
 
-	if (cnt % sizeof(struct ptp_extts_event) != 0)
-		return -EINVAL;
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
@@ -510,12 +536,16 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 
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
+		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 157ef25bc1b1..74f1ce2dbccb 100644
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
@@ -174,7 +175,6 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	/* Delete first entry */
@@ -242,9 +242,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		goto no_memory_queue;
-	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
-	mutex_init(&ptp->tsevq_mux);
+	spin_lock_init(&queue->lock);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
@@ -345,7 +344,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
-	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	list_del(&queue->qlist);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index cc8186a92eec..9d5f3d95058e 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -38,7 +38,6 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
-	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 2675f383cd0a..7d023d9d0acb 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -81,15 +81,15 @@ static ssize_t extts_fifo_show(struct device *dev,
 	size_t qcnt;
 	int cnt = 0;
 
+	cnt = list_count_nodes(&ptp->tsevqs);
+	if (cnt <= 0)
+		goto out;
+
 	/* The sysfs fifo will always draw from the fist queue */
 	queue = list_first_entry(&ptp->tsevqs, struct timestamp_event_queue,
 				 qlist);
 
 	memset(&event, 0, sizeof(event));
-
-	if (mutex_lock_interruptible(&ptp->tsevq_mux))
-		return -ERESTARTSYS;
-
 	spin_lock_irqsave(&queue->lock, flags);
 	qcnt = queue_cnt(queue);
 	if (qcnt) {
@@ -104,7 +104,6 @@ static ssize_t extts_fifo_show(struct device *dev,
 	cnt = snprintf(page, PAGE_SIZE, "%u %lld %u\n",
 		       event.index, event.t.sec, event.t.nsec);
 out:
-	mutex_unlock(&ptp->tsevq_mux);
 	return cnt;
 }
 static DEVICE_ATTR(fifo, 0444, extts_fifo_show, NULL);
-- 
2.30.2


