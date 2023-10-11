Return-Path: <netdev+bounces-40169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53C7C6072
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CA28282F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEB1548A;
	Wed, 11 Oct 2023 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUoFEoeE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37715568B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:40:13 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFF2A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4054f790190so4630775e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064009; x=1697668809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YMt1GOEPRn7/vbYQepJLhccSjuhOt3rZVRvwb+4bRM=;
        b=DUoFEoeEuVfWhoEfM1fRBtoXGFo8zsfuTDpyDw9i4uK/abNiHdGKq6pcuY/DnHCRJC
         h2fMQ62JGHR5WLnV22weYr/AELcummTPYbUHyXSmDTlkHYCNdyHm25UgwQzYlH9cuWZo
         iry21gxCiz4Pa6I3eBR4R4gsSVei3i2BzcxNCp9G8VtlBwHZGRoSf8CCxDZRLPSEWjPg
         0l/q0WsEOKNuLzxhHaSorUu4bHAOf024fMb6KRx2PPJFoYje8KbnT/LYVJWNvMEWgJI6
         qisNhYfIcarW486yHQ7Wd8eec/tJVd/O4sGTTCvWzXkLrzRm7JW6ye8tCiXvIbMkT9RX
         3CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064009; x=1697668809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YMt1GOEPRn7/vbYQepJLhccSjuhOt3rZVRvwb+4bRM=;
        b=h9vWmQ1uqwRNB3KSuiTRWlTvjYsdCrXVHLaYj35w6SbG4zRbjK8KfbaTjC62XlE8Fu
         BjUPPLfzD+jnMyYlDHQfwXDCaH7xDAn2x2GtXU0Jo3689hLZvA0CP4Ay7ECyqN3oWsZf
         RkTWurKo1RTZ/KEMyNeoluIKqtaC1t4MxNrm7SNXBMI0PMpBNpad4U8oHrqBRSCzv25+
         BD0YmrQ1DatvdDKBX+PxPEtBc8+LjeXv8jj/fNN8ubKjKGWGkaNaYCl7HoRiK9eIeh18
         prGGBY2831fN63LU2W1BVs/QrIN3nuL6c6OwIB80gHzb7p2udCmTjMxpUUIfE/giV85C
         agig==
X-Gm-Message-State: AOJu0YwbBfgcf5aWePv5W5taylSm5tPUDcEBQM4UeECEUDMQrPH0dDgp
	YYPuTrvWXfGidxsyodJeZtJe+8hCAtvgQQ==
X-Google-Smtp-Source: AGHT+IFUbYex5/PZD5Gqp3Gng+fDzoY0ooC+vdZWOQji3fj2c3PTH6eeu3sb507jQdhbTyr5S7lW0A==
X-Received: by 2002:a05:600c:2a4e:b0:405:7b92:4558 with SMTP id x14-20020a05600c2a4e00b004057b924558mr19791626wme.38.1697064008961;
        Wed, 11 Oct 2023 15:40:08 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b00405442edc69sm19964031wmr.14.2023.10.11.15.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:40:08 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/6] ptp: support multiple timestamp event readers
Date: Thu, 12 Oct 2023 00:39:55 +0200
Message-Id: <b788540e1f934b912a99e3c3486eea853f62e64c.1697062274.git.reibax@gmail.com>
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


