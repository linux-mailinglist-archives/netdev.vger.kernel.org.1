Return-Path: <netdev+bounces-38925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9707A7BD106
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A20A28165A
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDE34190;
	Sun,  8 Oct 2023 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctBe/UMk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BA34181
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 22:49:39 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB89AB
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:49:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so37193105e9.1
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696805376; x=1697410176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFUg6jPRZc3AYh+R1kGnt0LKF7/4xK5wzQKpMKtwzhM=;
        b=ctBe/UMkqv0ikDVtFIYVZYpcmi0AYEymxBd8QIXznd3pa9E1uS8Vve4dq9OjxycnGi
         U0MQfRfWwH+IvPrKmw12JDlNYIAXJVip0Qan+4lifOJNIp3qfG3VfPP5+D5a0bNPQXb5
         hXhD+dUzCQlV0pblCxHsy7VZ2b11AT4Ow/m5XCIbnSgPPHkSN23hx1j3qSAS8mItCuei
         cEubrZk4bCX9NjGO7PwIr+dk4j9Tm2pui1AdCz9VvLWKZuSYHKFRb3pgr1VXSWUmpJGB
         y85phD1zG4L/iKDr4WpZLCeuD8j4h+h6bJrMno/lKTVnbURCPRUCKXaZfrdjUZubZ3ak
         nPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805376; x=1697410176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFUg6jPRZc3AYh+R1kGnt0LKF7/4xK5wzQKpMKtwzhM=;
        b=FUBewMou5Cz4lbGB6kbPgUneZd1R1BXgIQFf00b3NiBgWeI6fe8iOmF7zWYyAsmpZK
         SJ1rS2FHZa1/mUcWGWiRArC/qVquy9rojkmVcT6n6yyBv6fZ+3D5tjnLUnh115lapugf
         8J2prQNC1mic76OOGQt0DbeS6//R2pgYtUCooErAkwgrdfvT/RtYVX6fEQtD/KKLjdIX
         fERdSygEP7BWkX8Iy9mHx8Rsx5OXeb6q3C6vdP87rYJ0VlulQnGtaTMSvqeZpNWOsTBw
         vUQbqtF7G90grJDlU59UqRUjRPbZJxKp53mjto9Rf9FREoFaRi/vXbXqGlBVvsD0UNJd
         XPkQ==
X-Gm-Message-State: AOJu0YyLYHiNmQQW1fQ7MOuujEQOLiI3ubPKr5ueRLlrua4jIqOcUKcr
	1DkT0wO7VNcbkbxXxk50xbRw9VBfEtoABw==
X-Google-Smtp-Source: AGHT+IFF+54HpDVF7liezSgPiIvrq5hioPLh/NyR+Bj3PzSGPRgXMQ/w2gF/abc5NpqPMTn+Z3dwRA==
X-Received: by 2002:a05:600c:510e:b0:406:8c7a:9520 with SMTP id o14-20020a05600c510e00b004068c7a9520mr8929606wms.36.1696805376038;
        Sun, 08 Oct 2023 15:49:36 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm11804891wmg.40.2023.10.08.15.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:49:35 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] ptp: support event queue reader channel masks
Date: Mon,  9 Oct 2023 00:49:19 +0200
Message-Id: <1eada12e90a333860283f1c489ac763fc9df08cc.1696804243.git.reibax@gmail.com>
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

On systems with multiple timestamp event channels, some readers might
want to receive only a subset of those channels.

This patch adds the necessary modifications to support timestamp event
channel filtering, including two IOCTL operations:

- Clear all channels
- Enable one channel

The mask modification operations will be applied exclusively on the
event queue assigned to the file descriptor used on the IOCTL operation,
so the typical procedure to have a reader receiving only a subset of the
enabled channels would be:

- Open device file
- ioctl: clear all channels
- ioctl: enable one channel
- start reading

Calling the enable one channel ioctl more than once will result in
multiple enabled channels.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v5:
  - fix memory leak on ptp_open
v4: https://lore.kernel.org/netdev/5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com/
  - split modifications in different patches for improved organization
  - filter modifications exclusive to currently open instance for
    simplicity and security
  - expand mask to 2048 channels
  - remove unnecessary tests
v3: https://lore.kernel.org/netdev/20230928133544.3642650-4-reibax@gmail.com/
  - filter application by object id, aided by process id
  - friendlier testptp implementation of event queue channel filters
v2: https://lore.kernel.org/netdev/20230912220217.2008895-3-reibax@gmail.com/
  - fix testptp compilation error: unknown type name 'pid_t'
  - rename mask variable for easier code traceability
  - more detailed commit message with two examples
v1: https://lore.kernel.org/netdev/20230906104754.1324412-4-reibax@gmail.com/
---
 drivers/ptp/ptp_chardev.c      | 26 ++++++++++++++++++++++++++
 drivers/ptp/ptp_clock.c        | 12 ++++++++++--
 drivers/ptp/ptp_private.h      |  3 +++
 include/uapi/linux/ptp_clock.h |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index abe94bb80cf6..ac2f2b5ea0b7 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -110,6 +110,12 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		return -EINVAL;
+	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
+	if (!queue->mask) {
+		kfree(queue);
+		return -EINVAL;
+	}
+	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
@@ -126,6 +132,7 @@ int ptp_release(struct posix_clock_context *pccontext)
 		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
 		spin_unlock_irqrestore(&queue->lock, flags);
+		bitmap_free(queue->mask);
 		kfree(queue);
 	}
 	return 0;
@@ -141,6 +148,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_sys_offset *sysoff = NULL;
+	struct timestamp_event_queue *tsevq;
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
 	struct ptp_clock_caps caps;
@@ -150,6 +158,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct timespec64 ts;
 	int enable, err = 0;
 
+	tsevq = pccontext->private_clkdata;
+
 	switch (cmd) {
 
 	case PTP_CLOCK_GETCAPS:
@@ -448,6 +458,22 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 		mutex_unlock(&ptp->pincfg_mux);
 		break;
 
+	case PTP_MASK_CLEAR_ALL:
+		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
+		break;
+
+	case PTP_MASK_EN_SINGLE:
+		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
+			err = -EFAULT;
+			break;
+		}
+		if (i >= PTP_MAX_CHANNELS) {
+			err = -EFAULT;
+			break;
+		}
+		set_bit(i, tsevq->mask);
+		break;
+
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 74f1ce2dbccb..ed16d9787ce9 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -183,6 +183,7 @@ static void ptp_clock_release(struct device *dev)
 	spin_lock_irqsave(&tsevq->lock, flags);
 	list_del(&tsevq->qlist);
 	spin_unlock_irqrestore(&tsevq->lock, flags);
+	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	ida_free(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
@@ -243,6 +244,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
+	if (!queue->mask)
+		goto no_memory_bitmap;
+	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
@@ -346,6 +351,8 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 kworker_err:
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
+	bitmap_free(queue->mask);
+no_memory_bitmap:
 	list_del(&queue->qlist);
 	kfree(queue);
 no_memory_queue:
@@ -400,9 +407,10 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
-		/* Enqueue timestamp on all queues */
+		/* Enqueue timestamp on selected queues */
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
-			enqueue_external_timestamp(tsevq, event);
+			if (test_bit((unsigned int)event->index, tsevq->mask))
+				enqueue_external_timestamp(tsevq, event);
 		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 9d5f3d95058e..ad4ce1b25c86 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -16,10 +16,12 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/bitmap.h>
 
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
+#define PTP_MAX_CHANNELS 2048
 
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
@@ -27,6 +29,7 @@ struct timestamp_event_queue {
 	int tail;
 	spinlock_t lock;
 	struct list_head qlist;
+	unsigned long *mask;
 };
 
 struct ptp_clock {
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..da700999cad4 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -224,6 +224,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
+#define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.30.2


