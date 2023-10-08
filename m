Return-Path: <netdev+bounces-38927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B597BD108
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5651C20958
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7233997;
	Sun,  8 Oct 2023 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfuUw1U+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12833999
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 22:49:41 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3956BA
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:49:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40537481094so36317095e9.0
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696805378; x=1697410178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k5+MAFhsYftTSV76Xqg3Eq5Ki7v0F2ma63z3/DOQXU=;
        b=cfuUw1U+DN6VB01cajljt1wL85UXovDfiujlQkr2Nwd2XjjFLCWRIMRjPgnTXJ4jkE
         ap2S+9bHvXNocr5M/w9Qa7yH8UZA7GP5XufIOO/3/6625yjbR/0MR5BWthLVRJpqAmKh
         pI6SZqdPRNZn6hOqsohZdDkgdVOCPghxOsQbbVEhkUXqwEXfJYZOHJRFNbSflnFLYN8i
         wSv5phDOAXNbSkMe99131UZae+qHYqkYLkZaSKdr9vimW/UeIFrhomnM8xIKuCJhrDND
         IcaFGFMp4H1W6VNlEle6bGsDszhoKRLMGiLGX/J9iv1g2rZTx7uJOXAfkesIHDs5tuhR
         n1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805378; x=1697410178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k5+MAFhsYftTSV76Xqg3Eq5Ki7v0F2ma63z3/DOQXU=;
        b=hEy1jKDgGmpbXqxEGV+iSz1ZqtqiMq2qNXxeNLUEAXF8hhW5dk9DMgjURnzEr1sU8q
         BPGFveqqXDLCO05siugn4plrjs849jyvDtKVuGHLNw5Iw2YNt5t2J/IItkJ1KcMuN+Jl
         zjuqzbFA2fFFN0HjZHi5RfI7gCPvlEYlVlaqA+zefNXA6wb+2S7z3tdRdBU+JkGxe8hJ
         axD9NT/AVdE1pL0WISxhRK6U+DwqS0a5CqMfuAuNc2s9BocW5xxHoB9ZFmJjZbvd4pYq
         5I8I9tfFedLiPTmI9gg91/xc8ZeGUvWSXgxUJ9Je6aYfhhK+FYg0s+uSqW+FhSq+b0ic
         ctYA==
X-Gm-Message-State: AOJu0YzU6UKTjkRw0FoZzWTxLvWS++jQH/3r3lsO/aWLfFulNECieHbf
	eiafual+O8zHosZiWpqCiF375FSCjLeJdw==
X-Google-Smtp-Source: AGHT+IGeBUjRGetCJmzAiarYFCM07LBNZdH+lMa1q2uf0dpnxY8ph6ufmSWopr8rqaLJQFGPtUdHFA==
X-Received: by 2002:a7b:cd0a:0:b0:405:3dbc:8821 with SMTP id f10-20020a7bcd0a000000b004053dbc8821mr11811445wmj.22.1696805377872;
        Sun, 08 Oct 2023 15:49:37 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm11804891wmg.40.2023.10.08.15.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:49:37 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/6] ptp: add debugfs interface to see applied channel masks
Date: Mon,  9 Oct 2023 00:49:20 +0200
Message-Id: <72ae11ff23793730a64cc1a037f9a6d59dbfbeea.1696804243.git.reibax@gmail.com>
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

Use debugfs to be able to view channel mask applied to every timestamp
event queue.

Every time the device is opened, a new entry is created in
`$DEBUGFS_MOUNTPOINT/ptpN/$INSTANCE_ADDRESS/mask`.

The mask value can be viewed grouped in 32bit decimal values using cat,
or converted to hexadecimal with the included `ptpchmaskfmt.sh` script.
32 bit values are listed from least significant to most significant.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v1: https://lore.kernel.org/netdev/27d47d720dfa7a0b5a59b32626ed6d02745b6ee0.1696511486.git.reibax@gmail.com/
  - First version
---
 drivers/ptp/ptp_chardev.c                   | 14 ++++++++++++++
 drivers/ptp/ptp_clock.c                     |  7 +++++++
 drivers/ptp/ptp_private.h                   |  4 ++++
 tools/testing/selftests/ptp/ptpchmaskfmt.sh | 14 ++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/ptp/ptpchmaskfmt.sh

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index ac2f2b5ea0b7..282cd7d24077 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
+#include <linux/debugfs.h>
 
 #include <linux/nospec.h>
 
@@ -106,6 +107,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
+	char debugfsname[32];
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -119,6 +121,17 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+
+	/* Debugfs contents */
+	sprintf(debugfsname, "0x%p", queue);
+	queue->debugfs_instance =
+		debugfs_create_dir(debugfsname, ptp->debugfs_root);
+	queue->dfs_bitmap.array = (u32 *)queue->mask;
+	queue->dfs_bitmap.n_elements =
+		DIV_ROUND_UP(PTP_MAX_CHANNELS, BITS_PER_BYTE * sizeof(u32));
+	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
+				 &queue->dfs_bitmap);
+
 	return 0;
 }
 
@@ -128,6 +141,7 @@ int ptp_release(struct posix_clock_context *pccontext)
 	unsigned long flags;
 
 	if (queue) {
+		debugfs_remove(queue->debugfs_instance);
 		pccontext->private_clkdata = NULL;
 		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ed16d9787ce9..2e801cd33220 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/debugfs.h>
 #include <uapi/linux/sched/types.h>
 
 #include "ptp_private.h"
@@ -185,6 +186,7 @@ static void ptp_clock_release(struct device *dev)
 	spin_unlock_irqrestore(&tsevq->lock, flags);
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
+	debugfs_remove(ptp->debugfs_root);
 	ida_free(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
@@ -218,6 +220,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	struct ptp_clock *ptp;
 	struct timestamp_event_queue *queue = NULL;
 	int err = 0, index, major = MAJOR(ptp_devt);
+	char debugfsname[8];
 	size_t size;
 
 	if (info->n_alarm > PTP_MAX_ALARMS)
@@ -339,6 +342,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 		return ERR_PTR(err);
 	}
 
+	/* Debugfs initialization */
+	sprintf(debugfsname, "ptp%d", ptp->index);
+	ptp->debugfs_root = debugfs_create_dir(debugfsname, NULL);
+
 	return ptp;
 
 no_pps:
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index ad4ce1b25c86..52f87e394aa6 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
+#include <linux/debugfs.h>
 
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
@@ -30,6 +31,8 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 	struct list_head qlist;
 	unsigned long *mask;
+	struct dentry *debugfs_instance;
+	struct debugfs_u32_array dfs_bitmap;
 };
 
 struct ptp_clock {
@@ -57,6 +60,7 @@ struct ptp_clock {
 	struct mutex n_vclocks_mux; /* protect concurrent n_vclocks access */
 	bool is_virtual_clock;
 	bool has_cycles;
+	struct dentry *debugfs_root;
 };
 
 #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
diff --git a/tools/testing/selftests/ptp/ptpchmaskfmt.sh b/tools/testing/selftests/ptp/ptpchmaskfmt.sh
new file mode 100644
index 000000000000..0a06ba8af300
--- /dev/null
+++ b/tools/testing/selftests/ptp/ptpchmaskfmt.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Simple helper script to transform ptp debugfs timestamp event queue filtering
+# masks from decimal values to hexadecimal values
+
+# Only takes the debugfs mask file path as an argument
+DEBUGFS_MASKFILE="${1}"
+
+#shellcheck disable=SC2013,SC2086
+for int in $(cat "$DEBUGFS_MASKFILE") ; do
+    printf '0x%08X ' "$int"
+done
+echo
-- 
2.30.2


