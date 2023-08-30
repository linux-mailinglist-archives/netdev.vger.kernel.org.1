Return-Path: <netdev+bounces-31455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78178E18F
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 23:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92654281168
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485058486;
	Wed, 30 Aug 2023 21:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35427747D
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 21:43:00 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B7CC
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:42:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31de47996c8so27959f8f.2
        for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693431678; x=1694036478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4SOmJcovueELRWloeT1AZWURy5zGsL6x6LbWkPvTT4=;
        b=ZGevZgSrHPMUIAgaCA2pXP+t88ZkVxBo1SeO+iyBXvwvZYckiGEkfcvdyyqzkYtxzL
         yrVSTNFQW/mH2nsU7xTYjL1Cc/cvBmnVOsSFj0MEIRV6xtA0dxukLN5QfoJnmKqR7/aZ
         5RasdUK37mGuWLkmA46gDwIrI28lT6Jgw6GqHIq1GeR4JyuwQZntrtt4kKC6F7g1HqDa
         L9F+VkSO9IUh5adNtp5n2m5LAhuPZdSZl/Rv14oxesF6Tt+5PnVFW5mdmmPQMIR9qmLY
         KB4GyzsksSA8gepS62t6wlEiU5sitvvsIm6YGL0blYZj7lNfqnqwPVsEtVaNWJ2mJ7qB
         Hhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431678; x=1694036478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4SOmJcovueELRWloeT1AZWURy5zGsL6x6LbWkPvTT4=;
        b=hV1Bxe1DDjjMIaTksdmmh40mTYVBO3iUQBu7Nj701iFWxq+3ajrW4pn+aUvDNVjdL4
         P3B78QYqI2hVPGtXj6zLt8hwj/XjhljTQIR0XNKGqWr/ZAMZeIVEReK26lIQdZULGzr6
         du6B+5dJQeTsmjDZaNJKzZQTnOZoRit46qjkLLhlQqESNbEpUbkmFZThi2z0HVCGFuJa
         GT5luqqyNB52k9h4tNr9oQsDWzWkQoHcdvKY8setupjlaaRdcROYn0tG9EjCFzPXYDtY
         AhmMMIIlFI98L0B0jNdWEffLUCG5nVXZbH00txpKjSgucFybleDSVi0FaRjXKsBuwgux
         Sb+A==
X-Gm-Message-State: AOJu0Yx5lgVGmEmcYe/gnC9/zeAipPRg11liSP1w1iF0cgHpjG8pYkuv
	cIj21QGX7DQYKwNjVDJilbM=
X-Google-Smtp-Source: AGHT+IGCKDkbodo2xrR8YMbyxlmTS7bioqqwIkfBdnxhZ4wM8Jm2HJbTkzRdWd181Z8uomGcARMZcw==
X-Received: by 2002:a5d:6b88:0:b0:319:6fff:f2c1 with SMTP id n8-20020a5d6b88000000b003196ffff2c1mr2694512wrx.38.1693431678079;
        Wed, 30 Aug 2023 14:41:18 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l4-20020adffe84000000b003176eab8868sm33434wrr.82.2023.08.30.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:41:17 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [PATCH] ptp: Demultiplexed timestamp channels
Date: Wed, 30 Aug 2023 23:41:01 +0200
Message-Id: <20230830214101.509086-2-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830214101.509086-1-reibax@gmail.com>
References: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
 <20230830214101.509086-1-reibax@gmail.com>
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

Add the posibility to demultiplex the timestamp channels for
external timestamp event channels.

In some applications it can be necessary to have different
consumers for different timestamp channels. For example,
synchronize to an external pps source with linuxptp ts2phc
while timestmping external events with another application.

This commit maintains the original multiplexed queue and adds an
individual queue per external timestamp channel. All enabled channels
will be directed to the multiplexed queue by default. On file open, a
specific channel will be redirected to the dedicated char device, and on
close it will automatically go back to the multiplexed queue.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 167 +++++++++++++++++++++++++++++++++++---
 drivers/ptp/ptp_clock.c   |  43 +++++++---
 drivers/ptp/ptp_private.h |  22 +++++
 3 files changed, 210 insertions(+), 22 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..c31cfc5b0907 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -10,11 +10,14 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
-
+#include <linux/cdev.h>
+#include <linux/fs.h>
 #include <linux/nospec.h>
 
 #include "ptp_private.h"
 
+#define DMTSC_NOT -1
+
 static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
 			       enum ptp_pin_function func, unsigned int chan)
 {
@@ -443,16 +446,24 @@ __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
 
-ssize_t ptp_read(struct posix_clock *pc,
-		 uint rdflags, char __user *buf, size_t cnt)
+ssize_t ptp_queue_read(struct ptp_clock *ptp, char __user *buf, size_t cnt,
+		       int dmtsc)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue = &ptp->tsevq;
+	struct timestamp_event_queue *queue;
+	struct mutex *tsevq_mux;
 	struct ptp_extts_event *event;
 	unsigned long flags;
 	size_t qcnt, i;
 	int result;
 
+	if (dmtsc < 0) {
+		queue = &ptp->tsevq;
+		tsevq_mux = &ptp->tsevq_mux;
+	} else {
+		queue = &ptp->dmtsc_devs.cdev_info[dmtsc].tsevq;
+		tsevq_mux = &ptp->dmtsc_devs.cdev_info[dmtsc].tsevq_mux;
+	}
+
 	if (cnt % sizeof(struct ptp_extts_event) != 0)
 		return -EINVAL;
 
@@ -461,23 +472,23 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	cnt = cnt / sizeof(struct ptp_extts_event);
 
-	if (mutex_lock_interruptible(&ptp->tsevq_mux))
+	if (mutex_lock_interruptible(tsevq_mux))
 		return -ERESTARTSYS;
 
 	if (wait_event_interruptible(ptp->tsev_wq,
 				     ptp->defunct || queue_cnt(queue))) {
-		mutex_unlock(&ptp->tsevq_mux);
+		mutex_unlock(tsevq_mux);
 		return -ERESTARTSYS;
 	}
 
 	if (ptp->defunct) {
-		mutex_unlock(&ptp->tsevq_mux);
+		mutex_unlock(tsevq_mux);
 		return -ENODEV;
 	}
 
 	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
 	if (!event) {
-		mutex_unlock(&ptp->tsevq_mux);
+		mutex_unlock(tsevq_mux);
 		return -ENOMEM;
 	}
 
@@ -497,7 +508,7 @@ ssize_t ptp_read(struct posix_clock *pc,
 
 	cnt = cnt * sizeof(struct ptp_extts_event);
 
-	mutex_unlock(&ptp->tsevq_mux);
+	mutex_unlock(tsevq_mux);
 
 	result = cnt;
 	if (copy_to_user(buf, event, cnt))
@@ -506,3 +517,139 @@ ssize_t ptp_read(struct posix_clock *pc,
 	kfree(event);
 	return result;
 }
+
+ssize_t ptp_read(struct posix_clock *pc, uint rdflags, char __user *buf,
+		 size_t cnt)
+{
+	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+
+	return ptp_queue_read(ptp, buf, cnt, DMTSC_NOT);
+}
+
+static int ptp_dmtsc_open(struct inode *inode, struct file *file)
+{
+	struct ptp_dmtsc_cdev_info *cdev = container_of(
+		inode->i_cdev, struct ptp_dmtsc_cdev_info, dmtsc_cdev);
+
+	file->private_data = cdev;
+
+	if (mutex_lock_interruptible(&cdev->pclock->dmtsc_en_mux))
+		return -ERESTARTSYS;
+	cdev->pclock->dmtsc_en_flags |= (0x1 << (cdev->minor));
+	mutex_unlock(&cdev->pclock->dmtsc_en_mux);
+
+	return stream_open(inode, file);
+}
+
+int ptp_dmtsc_release(struct inode *inode, struct file *file)
+{
+	struct ptp_dmtsc_cdev_info *cdev = file->private_data;
+
+	if (mutex_lock_interruptible(&cdev->pclock->dmtsc_en_mux))
+		return -ERESTARTSYS;
+	cdev->pclock->dmtsc_en_flags &= ~(0x1 << (cdev->minor));
+	mutex_unlock(&cdev->pclock->dmtsc_en_mux);
+
+	return 0;
+}
+
+ssize_t ptp_dmtsc_read(struct file *file, char __user *buf, size_t cnt,
+		       loff_t *offset)
+{
+	struct ptp_dmtsc_cdev_info *cdev = file->private_data;
+
+	return ptp_queue_read(cdev->pclock, buf, cnt, cdev->minor);
+}
+
+static const struct file_operations fops = {
+						.owner = THIS_MODULE,
+						.open = ptp_dmtsc_open,
+						.read = ptp_dmtsc_read,
+						.release = ptp_dmtsc_release
+						};
+
+void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
+{
+	int idx, major;
+	dev_t device;
+
+	major = MAJOR(ptp->dmtsc_devs.devid);
+	for (idx = 0; idx < ptp->info->n_ext_ts; idx++) {
+		if (ptp->dmtsc_devs.cdev_info[idx].minor >= 0) {
+			device = MKDEV(major, idx);
+			device_destroy(ptp->dmtsc_devs.dmtsc_class, device);
+			cdev_del(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev);
+			ptp->dmtsc_devs.cdev_info[idx].minor = -1;
+		}
+	}
+	class_destroy(ptp->dmtsc_devs.dmtsc_class);
+	unregister_chrdev_region(ptp->dmtsc_devs.devid, ptp->info->n_ext_ts);
+	mutex_destroy(&ptp->dmtsc_devs.cdev_info[idx].tsevq_mux);
+}
+
+int ptp_dmtsc_dev_register(struct ptp_clock *ptp)
+{
+	int err, idx, major;
+	dev_t device;
+	struct device *dev;
+
+	/* Allocate memory for demuxed device management */
+	ptp->dmtsc_devs.cdev_info = kcalloc(ptp->info->n_ext_ts,
+					    sizeof(*ptp->dmtsc_devs.cdev_info),
+					    GFP_KERNEL);
+	if (!ptp->dmtsc_devs.cdev_info) {
+		err = -ENODEV;
+		goto err;
+	}
+	for (idx = 0; idx < ptp->info->n_ext_ts; idx++)
+		ptp->dmtsc_devs.cdev_info[idx].minor = -1;
+	/* Create devices for all channels. The mask will control which of them get fed */
+	err = alloc_chrdev_region(&ptp->dmtsc_devs.devid, 0,
+				  ptp->info->n_ext_ts, "ptptsevqch");
+	if (!err) {
+		major = MAJOR(ptp->dmtsc_devs.devid);
+		ptp->dmtsc_devs.dmtsc_class =
+			class_create(THIS_MODULE, "ptptsevqch_class");
+		for (idx = 0; idx < ptp->info->n_ext_ts; idx++) {
+			mutex_init(&ptp->dmtsc_devs.cdev_info[idx].tsevq_mux);
+			device = MKDEV(major, idx);
+			ptp->dmtsc_devs.cdev_info[idx].pclock = ptp;
+			cdev_init(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev,
+				  &fops);
+			err = cdev_add(
+				&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev,
+				device, 1);
+			if (err) {
+				goto cdev_clean;
+			} else {
+				ptp->dmtsc_devs.cdev_info[idx].minor = idx;
+				dev = device_create(ptp->dmtsc_devs.dmtsc_class,
+						    &ptp->dev, device, NULL,
+						    "ptp%dch%d", ptp->index,
+						    idx);
+				if (IS_ERR(dev)) {
+					err = PTR_ERR(dev);
+					goto cdev_clean;
+				}
+			}
+		}
+	} else {
+		goto dev_clean;
+	}
+	return 0;
+
+cdev_clean:
+	ptp_dmtsc_cdev_clean(ptp);
+dev_clean:
+	kfree(ptp->dmtsc_devs.cdev_info);
+	ptp->dmtsc_devs.cdev_info = NULL;
+err:
+	return err;
+}
+
+void ptp_dmtsc_dev_uregister(struct ptp_clock *ptp)
+{
+	ptp_dmtsc_cdev_clean(ptp);
+	kfree(ptp->dmtsc_devs.cdev_info);
+	ptp->dmtsc_devs.cdev_info = NULL;
+}
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da..0a42c27c3514 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -172,6 +172,7 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
+	mutex_destroy(&ptp->dmtsc_en_mux);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
@@ -232,7 +233,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->tsevq_mux);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
+	mutex_init(&ptp->dmtsc_en_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
+	ptp->dmtsc_en_flags = 0x0;
 
 	if (ptp->info->getcycles64 || ptp->info->getcyclesx64) {
 		ptp->has_cycles = true;
@@ -307,21 +310,27 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 
 	/* Create a posix clock and link it to the device. */
 	err = posix_clock_register(&ptp->clock, &ptp->dev);
-	if (err) {
-		if (ptp->pps_source)
-			pps_unregister_source(ptp->pps_source);
+	if (err)
+		goto reg_err;
 
-		if (ptp->kworker)
-			kthread_destroy_worker(ptp->kworker);
+	/* Create chardevs for demuxed external timestamp channels */
+	if (ptp_dmtsc_dev_register(ptp))
+		goto reg_err;
 
-		put_device(&ptp->dev);
+	return ptp;
 
-		pr_err("failed to create posix clock\n");
-		return ERR_PTR(err);
-	}
+reg_err:
+	ptp_dmtsc_dev_uregister(ptp);
+	if (ptp->pps_source)
+		pps_unregister_source(ptp->pps_source);
 
-	return ptp;
+	if (ptp->kworker)
+		kthread_destroy_worker(ptp->kworker);
+
+	put_device(&ptp->dev);
 
+	pr_err("failed to create posix clock\n");
+	return ERR_PTR(err);
 no_pps:
 	ptp_cleanup_pin_groups(ptp);
 no_pin_groups:
@@ -330,6 +339,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
+	mutex_destroy(&ptp->dmtsc_en_mux);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
@@ -367,6 +377,8 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
+	ptp_dmtsc_dev_uregister(ptp);
+
 	posix_clock_unregister(&ptp->clock);
 
 	return 0;
@@ -378,12 +390,19 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 	struct pps_event_time evt;
 
 	switch (event->type) {
-
 	case PTP_CLOCK_ALARM:
 		break;
 
 	case PTP_CLOCK_EXTTS:
-		enqueue_external_timestamp(&ptp->tsevq, event);
+		/* If event index demuxed queue mask is enabled send to dedicated fifo */
+		if (ptp->dmtsc_en_flags & (0x1 << event->index)) {
+			enqueue_external_timestamp(
+				&ptp->dmtsc_devs.cdev_info[event->index].tsevq,
+				event);
+		} else {
+			enqueue_external_timestamp(&ptp->tsevq, event);
+		}
+
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 75f58fc468a7..c473ef75d8d7 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -27,6 +27,20 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 };
 
+struct ptp_dmtsc_cdev_info {
+	struct cdev dmtsc_cdev; /* Demuxed event device chardev */
+	int minor; /* Demuxed event queue chardev device minor */
+	struct ptp_clock *pclock; /* Direct access to parent clock device */
+	struct mutex tsevq_mux; /* Protect access to device management */
+	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+};
+
+struct ptp_dmtsc_dev_info {
+	dev_t devid;
+	struct class *dmtsc_class;
+	struct ptp_dmtsc_cdev_info *cdev_info;
+};
+
 struct ptp_clock {
 	struct posix_clock clock;
 	struct device dev;
@@ -36,6 +50,11 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+	u32 dmtsc_en_flags; /* Demultiplexed timestamp channels enable flags */
+	struct mutex
+		dmtsc_en_mux; /* Demultiplexed timestamp channels sysfs mutex */
+	struct ptp_dmtsc_dev_info
+		dmtsc_devs; /* Demultiplexed timestamp channel access character devices */
 	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
@@ -139,4 +158,7 @@ void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
 
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
 void ptp_vclock_unregister(struct ptp_vclock *vclock);
+
+int ptp_dmtsc_dev_register(struct ptp_clock *ptp);
+void ptp_dmtsc_dev_uregister(struct ptp_clock *ptp);
 #endif
-- 
2.34.1


