Return-Path: <netdev+bounces-38258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1F7B9DAB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7F84B282458
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A326E0F;
	Thu,  5 Oct 2023 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJqPRjZm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEA266BD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:53:43 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703C59F4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:53:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40651a726acso8975075e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696514020; x=1697118820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+oNHuvF1eBlNE445jbuEQnB/P9gzbfqPUfco1JEbJs=;
        b=iJqPRjZmF1idAqmfKy1DWKzQxhhl8Yfb5//qzgwOuCJoyO/AhJqJnkm0mhLOq2KMeC
         HpYBSXhjFd8rRPvP/ygMXlkCvLG6YbBYrbIfpGP8LRDehuEmcoLa+gEuxofAkLpaErr3
         eLIWOOr5XwsvzLv6DvLHc2FhTb+MS2/ZltGTijC1PKb4aPwSg8XyPmP6yn70a5f7Vk9x
         11ibE0dOIAFe57OR58Zr3kfuK2DNh0Ug2ubxnj/T+VpKY02UKLc4r1fYu7j6eyeCsWlX
         YIdECPpOK2uk61+c/ECxxkivAxiMw5gNPrt3T+52Cn0TOsPsA37hkaRrU3XQxlWOUp3b
         I47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514020; x=1697118820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+oNHuvF1eBlNE445jbuEQnB/P9gzbfqPUfco1JEbJs=;
        b=icU+v/zuFHQLjbZkEFo7mjukikgFubdrBqpcnPzfdEd0dKbXlLqeaUlURL/w060ErG
         Dat972dE2iAmrqjCXP2DdSU7Ui9JEQ2dv13VIjvFquRhxdHOJ0Zq+rUE9GR78JwprAWC
         AMt1jlwpGzthT2oa7v4NRvm/hGTg/DQsQs9OtOZ78X+Ga26KIcRNgV45BMNZmtg+VBsL
         sqrP7RbzzZ19UNRuGsOEejRDtgG8sqG5eVERaxf4YuL0OnvhjR/wCp5TVkbpOk/nM8zi
         oXa0e0I1eM34SeUSEoaKMbZELDGGwrLi5snpwUesw5iCU8D+IWgZaJXAS5wUZH6eRjCg
         Jf1g==
X-Gm-Message-State: AOJu0Yx4UkujuqQ9jJLG2N+dpuQfhAARnF4hTMi26yde/Hy+aGRleGWN
	CYFGyxW9ugI8A/sqyOKI1oUaH+iOUN3iFA==
X-Google-Smtp-Source: AGHT+IEzdtnuUzYVp8jvzgnZ+kDQ479549zMp2IT7jNq0ZhHhVBcYH7mej9qRPv90yYECS4IWsZe+A==
X-Received: by 2002:a5d:460a:0:b0:321:521f:836f with SMTP id t10-20020a5d460a000000b00321521f836fmr5496611wrq.26.1696514020255;
        Thu, 05 Oct 2023 06:53:40 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00327df8fcbd9sm1867041wrx.9.2023.10.05.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:53:39 -0700 (PDT)
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
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v4 5/6] ptp: add debugfs interface to see applied channel masks
Date: Thu,  5 Oct 2023 15:53:15 +0200
Message-Id: <27d47d720dfa7a0b5a59b32626ed6d02745b6ee0.1696511486.git.reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696511486.git.reibax@gmail.com>
References: <cover.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
v1:
  - First version
---
 drivers/ptp/ptp_chardev.c                   | 14 ++++++++++++++
 drivers/ptp/ptp_clock.c                     |  7 +++++++
 drivers/ptp/ptp_private.h                   |  4 ++++
 tools/testing/selftests/ptp/ptpchmaskfmt.sh | 14 ++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/ptp/ptpchmaskfmt.sh

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index dbbe551a044f..914e4ff7f142 100644
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
@@ -117,6 +119,17 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
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
 
@@ -126,6 +139,7 @@ int ptp_release(struct posix_clock_context *pccontext)
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
2.34.1


