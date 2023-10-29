Return-Path: <netdev+bounces-45034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338017DAA79
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 03:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7E1C2091D
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 02:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A9803;
	Sun, 29 Oct 2023 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wopizG9m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDED62C
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 02:16:09 +0000 (UTC)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821889E;
	Sat, 28 Oct 2023 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698545754; bh=TeGL/ruicGTt/TU4zXKMm4s2wVxGs0xWLZ5ZFCL0jMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wopizG9mDV/CeEB7B4KrLHgan1BCBX7qBiWHSktt22hZQpgmW7PSMnryAy6jnY0PX
	 66zxkZsqxwW0zjCGvqCFAL6nu9cm3vXJ3Q1Lys3r/zE8gxKcsXoHCgmkQmeNSO05CV
	 SK6CW7ea1sCvTdQbW45mzxiMUEErlraAVZSOtKRs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 26A0EAAA; Sun, 29 Oct 2023 10:09:42 +0800
X-QQ-mid: xmsmtpt1698545382twkg9homf
Message-ID: <tencent_D71CEB16EC1ECD0879366E9C2E216FBC950A@qq.com>
X-QQ-XMAILINFO: NwcVoNZsSZVxnWIfSv4ddjusxzaNrdL4KXJzdnPl7tlIKaYruKmVXGdpzUZLl7
	 FzxfQI3H/H8jE6t1JIHfw+YhWqSmf0WswZfAnhnAmJO1waphgppOPdSNC7frlYivy+h/CeAFb2KO
	 x6KSsnvERkCsBwcz5S5ppDp5g8FiKoQsKdfBoLuCswX7eXMOvk9QS60fo2rC+7izhkMG5E8c/B8D
	 +Yxw6V5fbl/xei+MMfZjU0WtqgW8UCn4BSVhQxIOBPUzq1FuKORmT9zfKBYLokXNbZvcAOFMp6G6
	 iGfLaaPTP52TNGgHSTni4jSmNxEaC0H6WKsWo2JC9zgEUjkYL9nzrKoI1Xhzm2TRBwMJTxwm7Dwv
	 A9q6pUmgoYe83xqU/qC/ZDVebA+fUoydq/67B7dxu107ho1RPDi0ZBgu3PuKPKXKzJckiRnpNS7b
	 l0NXTBIA5V7RQ0ELn2SbtyUvLYMWmJ7a7DZj/1sy52H0x1OLLuV6RIVfcIoXsGrmiPrU+Ua0XzjS
	 fevWPiTJ7av3m8JU4WPlp8PBQdc6WwXyWHbm0kSv8eikfp+zlxvlhDQtCb2nkFIS6sueooSiGL64
	 jj+p/fE5D+NaKoZEQxPTHQdwnF7SQnuTVW172UerjFfNQtXX2ZqSAFK6MkNw33diT9XV/moU+VvT
	 gT5VpzGtBLMJkgV7+SWFBK7eYBZlgKpqD5EULtcFfP30V10XQniDZf0KzaIADBDS4NgpxXOuD0M2
	 TA+RO0LpCZksHVH/V/N0rDWmk375H9GtwoLts6YmvgJQ/OoqxFacwyPvIDFjJmIbtjZUrBod8wL9
	 3Zls0GMW1/3GRa37ESnjq0P8AZtHXQWoG67g7E1cZrsXy/Pi32ZT2+JOOttP+Bq6ji+Te1PENfsi
	 L/ajxLi+OuV6bZMaVtQm29Ig3y2kAR4yAR/jI8rGxAJbTwLzMEJP8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH-net-next] ptp: fix corrupted list in ptp_open
Date: Sun, 29 Oct 2023 10:09:42 +0800
X-OQ-MSGID: <20231029020941.856425-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <tencent_61372097D036524ACC74E176DF66043C2309@qq.com>
References: <tencent_61372097D036524ACC74E176DF66043C2309@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no lock protection when writing ptp->tsevqs in ptp_open(), ptp_read(),
ptp_release(), which can cause data corruption and increase mutual exclusion
to avoid this issue.

Moreover, the queue should not be released in ptp_read() and should be deleted
together.

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 14 ++++++++++++--
 drivers/ptp/ptp_clock.c   |  3 +++
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..5546e4b4e083 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
 
+	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
+		return -ERESTARTSYS;
+
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		return -EINVAL;
@@ -132,15 +135,20 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
 				 &queue->dfs_bitmap);
 
+	mutex_unlock(&ptp->tsevq_mux);
 	return 0;
 }
 
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	unsigned long flags;
 
 	if (queue) {
+		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
+			return -ERESTARTSYS;
 		debugfs_remove(queue->debugfs_instance);
 		pccontext->private_clkdata = NULL;
 		spin_lock_irqsave(&queue->lock, flags);
@@ -148,6 +156,7 @@ int ptp_release(struct posix_clock_context *pccontext)
 		spin_unlock_irqrestore(&queue->lock, flags);
 		bitmap_free(queue->mask);
 		kfree(queue);
+		mutex_unlock(&ptp->tsevq_mux);
 	}
 	return 0;
 }
@@ -543,6 +552,8 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 		cnt = EXTTS_BUFSIZE;
 
 	cnt = cnt / sizeof(struct ptp_extts_event);
+	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
+		return -ERESTARTSYS;
 
 	if (wait_event_interruptible(ptp->tsev_wq,
 				     ptp->defunct || queue_cnt(queue))) {
@@ -585,7 +596,6 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
+	mutex_unlock(&ptp->tsevq_mux);
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
index 52f87e394aa6..1525bd2059ba 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	struct mutex tsevq_mux; /* one process at a time reading the fifo */
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1


