Return-Path: <netdev+bounces-31223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714778C396
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B8128110B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB651154B9;
	Tue, 29 Aug 2023 11:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8B156CF
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:48:17 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510D12D
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:48:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso20752335e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693309693; x=1693914493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2YROf2QqxRSKLYrTxqdKQV3ivVodB3lrmLFSOx2MuM=;
        b=ZmrXDxougFAX7gnjfBJ1BleNo+TGwHFnX0PQEOf0PhTWJXW63h6ZjMvkWLTcAtKp7n
         GIFi4YHC3fQ+p42wo1LfvD2suE5g07ZWdNA3bOKxYmCMpu7q9rFRnXiTLjazDdqK2ikZ
         Y2cHz5bh/nnj6ktt+rUrbuoZ23e1bgfAZHcAdLcxsbncUhdkms6zo11bchcL8d/KQTUJ
         bxvxBV3NEJTE5utWoNxePAzMTGxmnGkPcp9WSScjJYYlIo755v4DlAlE//IsrYDtsP4F
         VF/ctp6ji0OMmHro0GvXsrME5RrQoOVej9SfqZDGyjIiR/ZQaDS5Tz/HtszmOomgiKQQ
         vqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309693; x=1693914493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2YROf2QqxRSKLYrTxqdKQV3ivVodB3lrmLFSOx2MuM=;
        b=YwlZkc3D3HS7qtBmTTOA7ay4xkhl+zXnd7BzbQpS37V5qcsb2J/qNtnoS5lJlm+6S3
         tuSxX038Oo6SELE4XeU7aD8bgBUsa65Lq9gNhu9HGjd8+L59gZSr8JyDla7OhCa9CDze
         2G52Aa9Q/HfaFORtavprn0X7r2q++LXGmTP4J3vYQqASp8kKgrGxaGTGouqNIlH42hsM
         n0Ok0QmRn/S+enEGxUXln85wJQs8W2n6rqzW95qQXeG4Xssj71h1wsiLxFgDTfNCSFMr
         ngGfT/h2L8ZMrPynGN7Egw2D/zbp297NpgqAPh7r+ZS4KD/bTExOHniQNW+TRvGI38AP
         4jRw==
X-Gm-Message-State: AOJu0YxkzMfsQM/FlMk1IbijuArHssz5i3Q1A0eX3h8OxwVDjiJ0WgiL
	bbNT6wivy0363JyqDGgyEKOf0vjGTFI=
X-Google-Smtp-Source: AGHT+IHcEpT1VLAe63jmLLQZ0bm5XcuKGP8wNXwpMjtgvvao9Mlhm52DHa/HN6hEfs20mzbNygYuYQ==
X-Received: by 2002:a1c:7303:0:b0:3fa:8db4:91ec with SMTP id d3-20020a1c7303000000b003fa8db491ecmr21469554wmb.10.1693309692845;
        Tue, 29 Aug 2023 04:48:12 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id y24-20020a1c4b18000000b003feae747ff2sm16942302wma.35.2023.08.29.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:48:12 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [PATCH] ptp: Demultiplexed timestamp channels
Date: Tue, 29 Aug 2023 13:47:52 +0200
Message-Id: <20230829114752.2695430-2-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829114752.2695430-1-reibax@gmail.com>
References: <Y/hGIQzT7E48o3Hz@hoboy.vegasvil.org>
 <20230829114752.2695430-1-reibax@gmail.com>
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

This change proposes the dynamic creation of one char-device
per timestamp channel only if the user requests the demuxing
of timestamp channels. It allows for on-the-fly demuxing of
specific channels.

The operation can be controlled via sysfs. See file
Documentation/ABI/testing/sysfs-ptp for more details.
---
 Documentation/ABI/testing/sysfs-ptp |  16 +++
 MAINTAINERS                         |   5 +
 drivers/ptp/Makefile                |   2 +-
 drivers/ptp/ptp_chardev.c           |   2 -
 drivers/ptp/ptp_clock.c             |  22 ++-
 drivers/ptp/ptp_demuxtschan.c       | 211 ++++++++++++++++++++++++++++
 drivers/ptp/ptp_private.h           |  25 ++++
 drivers/ptp/ptp_sysfs.c             | 113 +++++++++++++++
 8 files changed, 392 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ptp/ptp_demuxtschan.c

diff --git a/Documentation/ABI/testing/sysfs-ptp b/Documentation/ABI/testing/sysfs-ptp
index 9c317ac7c47a..9d9875e7c56a 100644
--- a/Documentation/ABI/testing/sysfs-ptp
+++ b/Documentation/ABI/testing/sysfs-ptp
@@ -81,6 +81,22 @@ Description:
 		switches the physical clock back to normal, adjustable
 		operation.
 
+What:		/sys/class/ptp/ptp<N>/dmtsc_en_flags
+Date:		August 2023
+Contact:	Xabier Marquiegui <reibax@gmail.com>
+Description:
+		This read/write file controls the de-multiplexing of 
+		external timestamp channel fifos. In write more, you
+		can de-multiplex by enabling a channel or re-multiplex
+		it by disabling it. Write mode can be done in channel mode
+		for single channel control "c 0 1" or mask mode for 
+		multi-channel "m 0x3 1". Syntax is:
+		<mode (m/c)> <value> <enable (0/1)>
+		In read mode you get the enable mask for all channels in 
+		hex.
+		See function dmtsc_en_flags_store on 
+		drivers/ptp/ptp_sysfs.c for more details.
+
 What:		/sys/class/ptp/ptp<N>/pins
 Date:		March 2014
 Contact:	Richard Cochran <richardcochran@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..8d9a24039d67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17171,6 +17171,11 @@ S:	Maintained
 F:	drivers/ptp/ptp_vclock.c
 F:	net/ethtool/phc_vclocks.c
 
+PTP DEMUXED TS CHANEL FIFOS
+M: Xabier Marquiegui <reibax@gmail.com>
+S: Maintained
+F: drivers/ptp/ptp_demuxtschan.c
+
 PTRACE SUPPORT
 M:	Oleg Nesterov <oleg@redhat.com>
 S:	Maintained
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 553f18bf3c83..6dbae0b9aa7c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -3,7 +3,7 @@
 # Makefile for PTP 1588 clock support.
 #
 
-ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o
+ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o ptp_demuxtschan.o
 ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
 ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
 obj-$(CONFIG_PTP_1588_CLOCK)		+= ptp.o
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..0c900042c389 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -441,8 +441,6 @@ __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 	return queue_cnt(&ptp->tsevq) ? EPOLLIN : 0;
 }
 
-#define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
-
 ssize_t ptp_read(struct posix_clock *pc,
 		 uint rdflags, char __user *buf, size_t cnt)
 {
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 80f74e38c2da..383508c269a2 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -172,6 +172,8 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
+	mutex_destroy(&ptp->dmtsc_devs.dmtsc_devs_mux);
+	mutex_destroy(&ptp->dmtsc_sysfs_mux);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
@@ -232,7 +234,13 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	mutex_init(&ptp->tsevq_mux);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
+	mutex_init(&ptp->dmtsc_sysfs_mux);
+	mutex_init(&ptp->dmtsc_devs.dmtsc_devs_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
+	ptp->dmtsc_en_flags = 0x0;
+	ptp->dmtscevq = NULL;
+	ptp->dmtsc_devs.readers = 0;
+	ptp->dmtsc_devs.clean_request = false;
 
 	if (ptp->info->getcycles64 || ptp->info->getcyclesx64) {
 		ptp->has_cycles = true;
@@ -330,6 +338,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
+	mutex_destroy(&ptp->dmtsc_devs.dmtsc_devs_mux);
+	mutex_destroy(&ptp->dmtsc_sysfs_mux);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
@@ -351,6 +361,8 @@ static int unregister_vclock(struct device *dev, void *data)
 
 int ptp_clock_unregister(struct ptp_clock *ptp)
 {
+	ptp_dmtsc_dev_uregister(ptp);
+
 	if (ptp_vclock_in_use(ptp)) {
 		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
 	}
@@ -383,7 +395,15 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
-		enqueue_external_timestamp(&ptp->tsevq, event);
+		/* If event index demuxed queue mask is enabled send to dedicated fifo */
+		if (ptp->dmtsc_en_flags & (0x1 << event->index)) {
+			enqueue_external_timestamp(&ptp->dmtscevq[event->index], event);
+		}
+		else
+		{
+			enqueue_external_timestamp(&ptp->tsevq, event);
+		}
+
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
 
diff --git a/drivers/ptp/ptp_demuxtschan.c b/drivers/ptp/ptp_demuxtschan.c
new file mode 100644
index 000000000000..516a1dabe8dd
--- /dev/null
+++ b/drivers/ptp/ptp_demuxtschan.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PTP exploded timestamp event queue driver
+ *
+ * Copyright 2023 Aingura IIoT
+ */
+
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include "ptp_private.h"
+
+static int ptp_dmtsc_open(struct inode *inode, struct file *file)
+{
+    struct ptp_dmtsc_cdev_info *cdev = container_of(inode->i_cdev,
+                struct ptp_dmtsc_cdev_info, dmtsc_cdev);
+
+    file->private_data = cdev;
+
+    if (mutex_lock_interruptible(&cdev->pclock->dmtsc_devs.dmtsc_devs_mux))
+		return -ERESTARTSYS;
+    cdev->pclock->dmtsc_devs.readers++;
+    mutex_unlock(&cdev->pclock->dmtsc_devs.dmtsc_devs_mux);
+
+	return stream_open(inode, file);
+}
+
+int ptp_dmtsc_release (struct inode *inode, struct file *file)
+{
+    struct ptp_dmtsc_cdev_info *cdev = file->private_data;
+
+    if (mutex_lock_interruptible(&cdev->pclock->dmtsc_devs.dmtsc_devs_mux))
+		return -ERESTARTSYS;
+    cdev->pclock->dmtsc_devs.readers--;
+
+    if ((cdev->pclock->dmtsc_devs.readers == 0) &&
+        cdev->pclock->dmtsc_devs.clean_request) {
+            mutex_unlock(&cdev->pclock->dmtsc_devs.dmtsc_devs_mux);
+            ptp_dmtsc_dev_uregister(cdev->pclock);
+        }
+    mutex_unlock(&cdev->pclock->dmtsc_devs.dmtsc_devs_mux);
+    return 0;
+}
+
+ssize_t ptp_dmtsc_read(struct file *file, char __user *buf,
+		      size_t cnt, loff_t *offset)
+{
+    struct ptp_dmtsc_cdev_info *cdev = file->private_data;
+	struct timestamp_event_queue *queue = &cdev->pclock->dmtscevq[cdev->minor];
+    struct mutex *dmtsceq_mux = &cdev->pclock->dmtsc_devs.cdev_info[cdev->minor].dmtsceq_mux;
+	struct ptp_extts_event *event;
+	unsigned long flags;
+	size_t qcnt, i;
+	int result;
+
+	if (cnt % sizeof(struct ptp_extts_event) != 0)
+		return -EINVAL;
+
+	if (cnt > EXTTS_BUFSIZE)
+		cnt = EXTTS_BUFSIZE;
+
+	cnt = cnt / sizeof(struct ptp_extts_event);
+
+	if (mutex_lock_interruptible(dmtsceq_mux))
+		return -ERESTARTSYS;
+
+	if (wait_event_interruptible(cdev->pclock->tsev_wq,
+				     cdev->pclock->defunct || queue_cnt(queue))) {
+		mutex_unlock(dmtsceq_mux);
+		return -ERESTARTSYS;
+	}
+
+	if (cdev->pclock->defunct) {
+		mutex_unlock(dmtsceq_mux);
+		return -ENODEV;
+	}
+
+	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
+	if (!event) {
+		mutex_unlock(dmtsceq_mux);
+		return -ENOMEM;
+	}
+
+	spin_lock_irqsave(&queue->lock, flags);
+
+	qcnt = queue_cnt(queue);
+
+	if (cnt > qcnt)
+		cnt = qcnt;
+
+	for (i = 0; i < cnt; i++) {
+		event[i] = queue->buf[queue->head];
+		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
+	}
+
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	cnt = cnt * sizeof(struct ptp_extts_event);
+
+	mutex_unlock(dmtsceq_mux);
+
+	result = cnt;
+	if (copy_to_user(buf, event, cnt))
+		result = -EFAULT;
+
+	kfree(event);
+	return result;
+}
+
+struct file_operations fops = {
+	.owner = THIS_MODULE,
+	.open = ptp_dmtsc_open,
+	.read = ptp_dmtsc_read,
+    .release = ptp_dmtsc_release
+};
+
+void ptp_dmtsc_cdev_clean(struct ptp_clock *ptp)
+{
+    int idx, major;
+    dev_t device;
+
+    major = MAJOR(ptp->dmtsc_devs.devid);
+    for (idx = 0; idx < ptp->info->n_ext_ts ; idx++) {
+        if (ptp->dmtsc_devs.cdev_info[idx].minor >= 0) {
+            device = MKDEV(major, idx);
+            device_destroy(ptp->dmtsc_devs.dmtsc_class, device);
+            cdev_del(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev);
+            ptp->dmtsc_devs.cdev_info[idx].minor = -1;
+        }
+    }
+    class_destroy(ptp->dmtsc_devs.dmtsc_class);
+    unregister_chrdev_region(ptp->dmtsc_devs.devid, ptp->info->n_ext_ts);
+    mutex_destroy(&ptp->dmtsc_devs.cdev_info[idx].dmtsceq_mux);
+}
+
+int ptp_dmtsc_dev_register(struct ptp_clock *ptp)
+{
+    int err, idx, major;
+    dev_t device;
+    struct device *dev;
+
+    // Create fifos for all channels. The mask will control which of them get fed
+    ptp->dmtscevq = kcalloc(ptp->info->n_ext_ts, sizeof(*ptp->dmtscevq), GFP_KERNEL);
+    if (!ptp->dmtscevq) {
+        err = -EFAULT;
+        goto err;
+    }
+    ptp->dmtsc_devs.cdev_info = kcalloc(ptp->info->n_ext_ts,
+        sizeof(*ptp->dmtsc_devs.cdev_info), GFP_KERNEL);
+    if (!ptp->dmtsc_devs.cdev_info) {
+        err = -ENODEV;
+        goto fifo_clean;
+    }
+    for (idx = 0; idx < ptp->info->n_ext_ts ; idx++) {
+        ptp->dmtsc_devs.cdev_info[idx].minor = -1;
+    }
+    // Create devices for all channels. The mask will control which of them get fed
+    err = alloc_chrdev_region(&ptp->dmtsc_devs.devid, 0, ptp->info->n_ext_ts, "ptptsevqch");
+    if (!err) {
+        major = MAJOR(ptp->dmtsc_devs.devid);
+        ptp->dmtsc_devs.dmtsc_class = class_create(THIS_MODULE, "ptptsevqch_class");
+        for (idx = 0; idx < ptp->info->n_ext_ts ; idx++) {
+            mutex_init(&ptp->dmtsc_devs.cdev_info[idx].dmtsceq_mux);
+            device = MKDEV(major, idx);
+            ptp->dmtsc_devs.cdev_info[idx].pclock = ptp;
+            cdev_init(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev, &fops);
+            err = cdev_add(&ptp->dmtsc_devs.cdev_info[idx].dmtsc_cdev, device, 1);
+            if (err) {
+                goto cdev_clean;
+            } else {
+                ptp->dmtsc_devs.cdev_info[idx].minor = idx;
+                dev = device_create(ptp->dmtsc_devs.dmtsc_class, &ptp->dev, device, NULL, "ptp%dch%d", ptp->index, idx);
+                if (IS_ERR(dev)) {
+                    err = PTR_ERR(dev);
+                    goto cdev_clean;
+                }
+            }
+        }
+    } else {
+        goto dev_clean;
+    }
+    return 0;
+
+cdev_clean:
+    ptp_dmtsc_cdev_clean(ptp);
+dev_clean:
+    kfree(ptp->dmtsc_devs.cdev_info);
+    ptp->dmtsc_devs.cdev_info = NULL;
+fifo_clean:
+    kfree(ptp->dmtscevq);
+    ptp->dmtscevq = NULL;
+err:
+    return err;
+}
+
+void ptp_dmtsc_dev_uregister(struct ptp_clock *ptp)
+{
+    if (mutex_lock_interruptible(&ptp->dmtsc_devs.dmtsc_devs_mux))
+		return;
+    if (ptp->dmtsc_devs.readers > 0) {
+        ptp->dmtsc_devs.clean_request = true;
+        mutex_unlock(&ptp->dmtsc_devs.dmtsc_devs_mux);
+        return;
+    }
+    mutex_unlock(&ptp->dmtsc_devs.dmtsc_devs_mux);
+    ptp_dmtsc_cdev_clean(ptp);
+    kfree(ptp->dmtsc_devs.cdev_info);
+    ptp->dmtsc_devs.cdev_info = NULL;
+    kfree(ptp->dmtscevq);
+    ptp->dmtscevq = NULL;
+}
\ No newline at end of file
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 75f58fc468a7..9fc7b6ec6517 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -20,6 +20,8 @@
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
 
+#define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
+
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
 	int head;
@@ -27,6 +29,22 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 };
 
+struct ptp_dmtsc_cdev_info {
+	struct cdev dmtsc_cdev; /* Demuxed event device chardev */
+	int minor; /* Demuxed event queue chardev device minor */
+	struct ptp_clock *pclock; /* Direct access to parent clock device */
+	struct mutex dmtsceq_mux; /* Protect access to demuxed event queue */
+};
+
+struct ptp_dmtsc_dev_info {
+	dev_t devid;
+	int readers; /* Amount of users with chardev open */
+	bool clean_request; /* Signal userspace open chardev preventing safe device removal */
+	struct mutex dmtsc_devs_mux; /* Protect access to device management */
+	struct class *dmtsc_class;
+	struct ptp_dmtsc_cdev_info *cdev_info;
+};
+
 struct ptp_clock {
 	struct posix_clock clock;
 	struct device dev;
@@ -36,6 +54,10 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
+	u32 dmtsc_en_flags; /* Demultiplexed timestamp channels enable flags */
+	struct mutex dmtsc_sysfs_mux; /* Demultiplexed timestamp channels sysfs mutex */
+	struct timestamp_event_queue *dmtscevq; /* Demultiplexed timestamp channel fifos */
+	struct ptp_dmtsc_dev_info dmtsc_devs; /* Demultiplexed timestamp channel access character devices */
 	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
@@ -139,4 +161,7 @@ void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
 
 struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
 void ptp_vclock_unregister(struct ptp_vclock *vclock);
+
+int ptp_dmtsc_dev_register(struct ptp_clock *ptp);
+void ptp_dmtsc_dev_uregister(struct ptp_clock *ptp);
 #endif
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6e4d5456a885..fc85aa1d3d23 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -316,6 +316,117 @@ static ssize_t max_vclocks_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(max_vclocks);
 
+static ssize_t dmtsc_en_flags_show(struct device *dev,
+			      struct device_attribute *attr, char *page)
+{
+	struct ptp_clock *ptp = dev_get_drvdata(dev);
+	ssize_t size;
+
+	size = snprintf(page, PAGE_SIZE - 1, "0x%X\n", ptp->dmtsc_en_flags);
+
+	return size;
+}
+
+static ssize_t dmtsc_en_flags_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct ptp_clock *ptp = dev_get_drvdata(dev);
+	int err = -EINVAL;
+	char mode, val[7];
+	int enable, channel, cnt;
+	u32 req_mask, new_mask;
+
+	/* Read mode, value and enable
+	    - mode: "m" - Channel mask mode
+		        "c" - Single channel mode
+		- value: channel mask in hex or channel number in decimal
+			lsb = channel 0
+		- enable: '1' - enable
+				  '0' - disable
+	*/
+	cnt = sscanf(buf, "%c %s %d", &mode, val, &enable);
+	if (cnt != 3)
+		return err;
+
+	if (mutex_lock_interruptible(&ptp->dmtsc_sysfs_mux))
+		return -ERESTARTSYS;
+
+	switch (mode) {
+		case 'm':
+			if (kstrtou32(val, 0, &req_mask))
+			{
+				dev_info(dev, "dmtscevq invalid arguments");
+				goto out;
+			}
+			break;
+		case 'c':
+			if (kstrtoint(val, 0, &channel)) {
+				dev_info(dev, "dmtscevq invalid channel number");
+				goto out;
+			}
+			if ((channel < 0) || (channel > 31))
+			{
+				dev_info(dev, "dmtscevq channel number out of range");
+				goto out;
+			}
+			req_mask = (0x1 << channel);
+			break;
+		default:
+			goto out;
+			break;
+	}
+
+	switch (enable) {
+		case 0:
+			new_mask = ptp->dmtsc_en_flags & ~req_mask;
+			break;
+		case 1:
+			new_mask = ptp->dmtsc_en_flags | req_mask;
+			break;
+		default:
+			dev_info(dev, "dmtscevq invalid enable value");
+			break;
+	}
+
+	if (new_mask == 0x0) {
+		// All queues disabled. Remove all character devices.
+		if (ptp->dmtscevq != NULL) {
+			ptp_dmtsc_dev_uregister(ptp);
+		} else {
+			if (ptp->dmtsc_en_flags != 0x0) {
+				dev_info(dev, "dmtscevq. Unexpected error: TSEVQ exploded buffers presumed unitialized. Skipping.");
+			}
+		}
+	} else {
+		// At least une queue enabled. Create all character devices.
+		// The mask will feed the selected character device and keep others inactive.
+		ptp->dmtsc_devs.readers = 0;
+		ptp->dmtsc_devs.clean_request = false;
+		if (ptp->dmtscevq == NULL) {
+			err = ptp_dmtsc_dev_register(ptp);
+			if (err != 0) {
+				dev_info(dev, "dmtscevq. Error while trying to register exploded queues");
+				goto out;
+			}
+		} else {
+			if (ptp->dmtsc_en_flags == 0x0) {
+				dev_info(dev, "dmtscevq. Unexpected error: TSEVQ exploded buffers already initialized, skipping initialization.");
+			}
+		}
+
+	}
+
+	ptp->dmtsc_en_flags = new_mask;
+
+	mutex_unlock(&ptp->dmtsc_sysfs_mux);
+	return count;
+out:
+	mutex_unlock(&ptp->dmtsc_sysfs_mux);
+	return err;
+}
+static DEVICE_ATTR_RW(dmtsc_en_flags);
+
 static struct attribute *ptp_attrs[] = {
 	&dev_attr_clock_name.attr,
 
@@ -333,6 +444,8 @@ static struct attribute *ptp_attrs[] = {
 	&dev_attr_pps_enable.attr,
 	&dev_attr_n_vclocks.attr,
 	&dev_attr_max_vclocks.attr,
+
+	&dev_attr_dmtsc_en_flags.attr,
 	NULL
 };
 
-- 
2.34.1


