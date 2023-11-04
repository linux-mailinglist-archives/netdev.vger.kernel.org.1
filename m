Return-Path: <netdev+bounces-46018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937187E0E2D
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1561C209DD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE438F4D;
	Sat,  4 Nov 2023 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LXveU469"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BA847E
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 07:07:33 +0000 (UTC)
X-Greylist: delayed 13311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Nov 2023 00:07:30 PDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDE1BC;
	Sat,  4 Nov 2023 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699081646; bh=Bqd95PbuGQElN4Of7bJRLKQNmHTzaiUlOszYrhbj318=;
	h=From:To:Cc:Subject:Date;
	b=LXveU469VZO5nj3lD1iqOBNeMhKQKLmsipm1iQZMEHSfvRYAGt+bFH6xyvIZGg+L9
	 5HM67XjtlNkEk3lZNdPLOLMuqD3euceOcQ2VVkLWuhWO5NEkVH1YFqiI27668tEtIT
	 GFLyQAPSCtbwAtvZZx3e7cz7/QfSPxOb0bonuLIk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
	id 1D831A41; Sat, 04 Nov 2023 15:07:24 +0800
X-QQ-mid: xmsmtpt1699081644tmoguzs89
Message-ID: <tencent_33056C0C97FCEA56EF7ECD4C7B266DCC2D0A@qq.com>
X-QQ-XMAILINFO: NKvGkmu+zWvN61OR1ANItrOJhlFpdarAYqB85MhAunGx+RKe4eltiBw0XB0BmU
	 WhqRViPDufwSgThNJe52JZlTRoajReQv1zl2xhEUCCQWzj0jajLA+J/HekkIvfipBa8NP1pbqHS5
	 iztU8Qo7uodWRMzyZq5hrLovjrWsg8ISH/XlfxUY0O1Vajph6a3f6kwveJKeevHoWy+cIs5Q5Ka/
	 4733jhhyx/8n50kd2Mit/aHMc4x80vKT/1nvudjXho4JB/GBL45UWLYpYytqCdoifkS7I4JHMZY4
	 dgdL2xERqe/9um+VNhTFJqugEYF0rm70EHR8cAOB+YDN9RFXZ6bkGk05JtbMlIUnM4m+GHqL+yXj
	 vQSpWNUL2J+BJgh8jTzw614G7gQkGzi45HU2lApkW89sjy+nOH3TGiWfmZamDHkMC9Eerm2MoY+7
	 vcwVFcnscaj3ey32He6HuMgdhzmSnXoK6BFqBsYGOn2dSU/BlLjCOHoRyFD147UEdn9lcc4PYru2
	 RlJoA8WuA0dhh4OsMDTZEpNM06g1MA/wKTOBFI1c2en3HkuQ1YYB7aDmN/J41NZYL5eQF/N5i4/7
	 eVyOnyakjNvU5KMsTlbuESj4gHQFTJnhAgryO9/V3EsePd13WWP1BrPYheZ/iC6PQ1kkLpr01DDw
	 KfzFFBTUngUf+08zHlGckTY5ZePp/P3WC1LTmpbEAV75W1DlYk+QhEMugNgtBLV7VBr18bYym6Dn
	 b6MpEp3/EWaWEPoY2wccNVXHz8KdYnNZgdyqBjvzV2BjlV7a4Artl5omuKnkSSB6CCTW2hdkSHCU
	 kmkh6lNQpxcKXNFlVjtU/fEpLVFbiSbcO4dk/RWF+/+GfiotvoaoDcsyWnKU2AKZjuLO0uHpPplm
	 Y5G4X2fYSAvGBREGR6p42zv3L8FOQZHilQ/huCmh4x2kLKz/LP/xR082xtq5eEow==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V5] ptp: fix corrupted list in ptp_open
Date: Sat,  4 Nov 2023 15:07:24 +0800
X-OQ-MSGID: <20231104070723.1637923-2-eadavis@qq.com>
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
 drivers/ptp/ptp_chardev.c | 14 +++++++++-----
 drivers/ptp/ptp_clock.c   |  3 +++
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..0f4628138af6 100644
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
@@ -138,14 +143,15 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
-	unsigned long flags;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
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
@@ -585,7 +591,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
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


