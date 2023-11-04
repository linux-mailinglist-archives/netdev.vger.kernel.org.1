Return-Path: <netdev+bounces-46012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E59697E0D79
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 04:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B356B21431
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B021FA2;
	Sat,  4 Nov 2023 03:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w4GtO0E+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3017CB
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 03:26:59 +0000 (UTC)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F068D52;
	Fri,  3 Nov 2023 20:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699068412; bh=uScNyXL7NZlRj5Up/uhHzzuVVWj82T1cweLIeGgSe2Y=;
	h=From:To:Cc:Subject:Date;
	b=w4GtO0E+D6zasKx5vZR30g1Imt7ePGbsE5O10uhNK6Yfzj85djm94INtt27YxW47u
	 QZLndtjiR6X4o4gIAfEyAoIxQfNp5GYxq4iuNo9gWIL9s8tyTCpJoph8foiletZg5H
	 akqNF3bWmLizWu8TSPbzGei5xbytQ29/aK7lV9DQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 66105EBB; Sat, 04 Nov 2023 11:25:33 +0800
X-QQ-mid: xmsmtpt1699068333tpvkcnde1
Message-ID: <tencent_8A38BBB333189E6E1B4A4B821BF82569BA08@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+ZlvzrTYMYBA0coqLpnNMXZh9itbweZXkF3uKsXFisdfXTsfP3Q
	 50I/CS2qW3uXrxTnpKFxmID2Sjk14G2hX24fWa86EzJqrJ0OULCeKUHtfjfW3TFLLljoX+VsVQGG
	 aAKcgBKYNI3DMVtE1n4PILoqrmg6QKoE1qy+ol4Bj0y2TsuOyhNyoX0nTgxqFDo4EEinnK3xjiSO
	 /FXBWG5hvZzsEhcQ+kvIvkGb/thAmnzdguZsNyCJf9sjSjpVogICNpc20D9vkyMo9sGbiD4PgUmY
	 0FLjw1/zKSYSmOuLQKWvGmAZwCCkTQrn0cHK8r6ywskR4P5dLxXh4RbcbH1Vddrw1B4QBSnlZNri
	 QD2LAUVUEGA7z6h9aa0N0Po2bwfLs7khZ7XrAa6zWEIzz8p0Jgayz7srx9bdP0TCYGPU59bT/UZb
	 rhYsgspFeVg/yH5KFplvEg+YOUD7/fQjtbp7ru3EJ6wD86yvl3zKmJ7sR0ZeX9zag3RLIKae8Ym5
	 t+QlX4Tm30ApiIzLye9T9jsQVksmTsUTWeE8abCEQBjyd5Zy5LXqATK6QzKfbR+tyH6c8MUWu14g
	 nwOn1VXboEzBvEun0rzYNgddUl3B4k29QqhbN4b1kWX1HP1PePrmVFBSCmH8rotjhjDB40mGTzoS
	 vGXaPVXJWKL3vZw3iTLpErWfA/C3p0A5SFgV1rmdy5laTGfcB6nY7gmQ2GoHXuRFinCfj1PcAHo+
	 M3t6yDBI9TyZTAjUvUswz2boa5aRMXWv4gfcnMyh6gGr+4lt79eyh/nUs9k2Cq95vPoO5/5fNdgG
	 voqq9MRqVKnsBXPZ8sg9QJN0ZqZS7p7/lEShrj3o3O7lNuOFSIdyGZjFF4QxzH/2s7CBa3Ox0aN/
	 joqhfU/39ss9MAXFEcyLIB8VUhqKE830SU0aasT0T1PSZkmrEjOJGP/RsD81wZ/Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V4] ptp: fix corrupted list in ptp_open
Date: Sat,  4 Nov 2023 11:25:33 +0800
X-OQ-MSGID: <20231104032533.1354507-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no lock protection when writing ptp->tsevqs in ptp_open(),
ptp_release(), which can cause data corruption, use mutex lock to avoid this
issue.

Moreover, ptp_release() should not be used to release the queue in ptp_read(),
and it should be deleted together.

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 13 +++++++++----
 drivers/ptp/ptp_clock.c   |  3 +++
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..ba035d6c81ae 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -119,8 +119,13 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	if (mutex_lock_interruptible(&ptp->tsevq_mux)) {
+		kfree(queue);
+		return -ERESTARTSYS;
+	}
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+	mutex_unlock(&ptp->tsevq_mux);
 
 	/* Debugfs contents */
 	sprintf(debugfsname, "0x%p", queue);
@@ -138,14 +143,16 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	unsigned long flags;
 
 	if (queue) {
+		mutex_lock(&ptp->tsevq_mux);
 		debugfs_remove(queue->debugfs_instance);
 		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
+		mutex_unlock(&ptp->tsevq_mux);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +592,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..7930db6ec18d 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -176,6 +176,7 @@ static void ptp_clock_release(struct device *dev)
 
 	ptp_cleanup_pin_groups(ptp);
 	kfree(ptp->vclock_index);
+	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	/* Delete first entry */
@@ -247,6 +248,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	mutex_init(&ptp->tsevq_mux);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
 	if (!queue->mask)
 		goto no_memory_bitmap;
@@ -356,6 +358,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp->kworker)
 		kthread_destroy_worker(ptp->kworker);
 kworker_err:
+	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
 	bitmap_free(queue->mask);
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..7d82960fd946 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	struct mutex tsevq_mux; /* one process at a time writing the timestamp fifo list */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1


