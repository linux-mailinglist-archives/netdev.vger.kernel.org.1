Return-Path: <netdev+bounces-45322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E096E7DC195
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 22:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470FEB20D2A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D81BDE9;
	Mon, 30 Oct 2023 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="isthwhDO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DB1BDDA
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 21:07:16 +0000 (UTC)
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44BE1;
	Mon, 30 Oct 2023 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698700030; bh=rSufyCuNOuw1MwZrXCGoaXlZx0/QDVc8j3TSnEo5KEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isthwhDOPdf4BmWnRn/Vb7cQIMed/v/C0y0lKvJXUHI5UO832Tojo+BOvVDjyvMDK
	 Sx9F3FX1cjUoyaASA9FBvsb15ucPTyTuJOOQ08GUlpKe+KQur7sCEZbL4RLQcsrdz6
	 PQYu5Bw3ugdsRfFzeM7gpIN4j+ni2vzTFkt1yQ5c=
Received: from pek-lxu-l1.wrs.com ([2408:8409:2461:9e8e:549b:dd5b:edb5:dcb3])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 1C78C46C; Tue, 31 Oct 2023 05:07:07 +0800
X-QQ-mid: xmsmtpt1698700027txn6m9ai8
Message-ID: <tencent_24C96E7894D0EBA2EDD2CFB87BB66EC02D0A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjFD4d7Cfraxb4mnxtl/SkyQr9EN30aHzDtVKN9fDw7vnqDuWMtq
	 DXHm3L+hkvoFenvEpu+JU/uInfqfYdZ+UNOOsFlfpV2blRvJz1t7jsITMA1zWPbjH2iOXRpC6YLh
	 CaIR4AbWBS8RjxtB/uqr5lgCyw8FLa0EVb7IBM5DOkbRjlsZXAajxsbuECOaQQuIjoQwiqaVuhO+
	 mjBmDggMN0QOgI8DMh1W8RoIka3LIA840foPJ2reAjCnGoNrC4ObQWa6MdWASN8gY4xsHuxW9/L+
	 kCX+4S5cF2scn6XmbxJTow4B0Nw7B2UNzfThp1cweoG/9qCQd6kAZBteyqPLwr3tiLJ34HiSDeDN
	 e3apQHpTudd9ojpDN9XFiXGGb6UGC9kvoS8bKBob+xMUlhcmKaTVMS9+b8+fP0cnTbilQmbkljTO
	 PnRexAMR2Kvhq4F53V1BrQhmSMNWFPtTAp9Ftox1DLjI/NhD2T59LG1YQJwnrNPz6OZCrqpQaCSe
	 8uG5acJ5tBf8KPXE7vzTbowx4gxBqivf2xU1HLIzTfLCXI0Lik6OH1t/9gUUKl6BGc3nViqyFwcp
	 q+U+reVQwqYRaS/xlp5WebCR5HgWyxlUlObk2GJFCLf92wD8bC9zJgDndSxZDCN302NXeg/ER/h1
	 tX6VycAF38F87OaRq1JVGo/qmncNs5jjb5fuH0qaDZI0lR2BstL1cv9/CjgUNeZczFDzAW5T9JO7
	 U8Ctw0qgdYVUM2pXWVI/nmo/REuE26Gzyo1g0k/t7SsvJfdX+Bzq1Q/OY4beeiMAmt+Q7KWd9KIz
	 LQbDHDXMwAP36cQYoIIMXztdowqpiGKPKYvxctThvoi/vh4pbtyVxnIMGI5B/zeLMkRIJIicstr+
	 VsyD3VwHbq4PCE9FPX+4burQpPycyeXzhPcPOelEzWShIK+fbRhSEDlLVvwBWB/SSOrV09w0rpuX
	 SO9NZj/zTEVuFKMx5KxQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Date: Tue, 31 Oct 2023 05:07:08 +0800
X-OQ-MSGID: <20231030210707.2261688-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZT65J4mvFe1yx5_3@hoboy.vegasvil.org>
References: <ZT65J4mvFe1yx5_3@hoboy.vegasvil.org>
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
 drivers/ptp/ptp_chardev.c | 11 +++++++++--
 drivers/ptp/ptp_clock.c   |  3 +++
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..e31551d2697d 100644
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
@@ -585,7 +594,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
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


