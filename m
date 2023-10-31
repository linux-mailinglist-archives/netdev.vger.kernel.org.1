Return-Path: <netdev+bounces-45397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B527DCAB3
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7390DB20D35
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D412E7D;
	Tue, 31 Oct 2023 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IZI5QOL9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2419444
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 10:25:50 +0000 (UTC)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED783;
	Tue, 31 Oct 2023 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698747944; bh=rSufyCuNOuw1MwZrXCGoaXlZx0/QDVc8j3TSnEo5KEU=;
	h=From:To:Cc:Subject:Date;
	b=IZI5QOL9539loKijZBZo+vj52D/F+2nlI1MZpU74bXZVOxxFORsiki5qQXrQ7ncG+
	 AdypklMaXhlzXHBlmUf9f7wx1MBWfj93Ku+z8YfQZMFm10bRblxvwFEzbQfs3Y6YXw
	 To37cy/kkHY6xyuhbHkJcQzIJE+2LNI+EP1PoSIY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 669A9C7E; Tue, 31 Oct 2023 18:25:41 +0800
X-QQ-mid: xmsmtpt1698747941t1fxy0xnp
Message-ID: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
X-QQ-XMAILINFO: ORVK3kaZDR52LLLomiL8MMii8yTwB+sM5B1dyz/mwJ6pk/oOnqn9LFyJJtb4Vz
	 MBaR9/68tfvRszbkWLMS/5GzCNwJdWM7GrpsyRaurLLaWV+NoiLM/XlGvBH8bm/8jKIRhzcpNNRf
	 2IbrIGjHuN0OhPadm75zgeGFZIRE8mKaaW+INjC5b7OTuXxUfw2Nz/AyJhL2gUHrMTOcI45okZN6
	 Q4VuBw20XwNRdmwsjsal9hWLmbnpGfdFOtIzMdexiaVX+meKX89j4abgVQE5cclcyrRorndmD4Vc
	 arDLV3TXx4LZaakq8EKAVlEPjo3JAaRgUj8roKY0ty5rEE847MmYyIwg3K64f/JgMqDH1un6Jn5B
	 o8qhtgve3eAVusA0S6jaQLvxugx0VfjtjqxXEScTSWnDtGPjMaAJDO1VJqbyoioNmxglveJWXQHx
	 aM1pgltLlXZIsczmwl+WyM+wU6+c8nGZIpSQQQWHx6sqHwwLa2rlXtgxTKHNg1o+f4gLtlB7w7/+
	 6/JWO3Ym96SoqCX6YI4Ta+ZrG0SH3P3dgX9rbt+AxFr/rzOZ1tijToSJS7364yCpuFfGeZtf4S+e
	 aTlrzO5iECKPx2H6DWBRWcvNkRh2eLzClLKfyPAbSetTr5HyiX2P4YUZJl6jQmqRsGSU+mIBXmOF
	 /o8SMr4VVVZokTmmcQkgGuGz1eYTRPMApAV4avBZRtS3NuzqAB3ogpPgHMF6DNDLN7SH1QSXyZN7
	 Pn70RdXZlyBY+Xv1OAFBNRxgBUpu7ChjX+VoByeRIp8SfLtNR46Fh00S/jumdu0K8tUa6Bwb5oCH
	 y0z5HK1ZDNHyvKZceXdvdw/ja1d4HqMG5w+fK+ZBxBXWBs9UOFAv45Lg4NC4vWcoaVYhHRPS5cBg
	 IFOy0EsxTqTfClQ+mz0Q2Sr7ZBrwLW9wyrRPUQMQ+zwJCAU3tQE1uP3cMQmcD3607xPuXh1NoaAt
	 r7f3BUzENqPBLxVEH/hcr7a+kFzxYkl5c1KG46NjE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: habetsm.xilinx@gmail.com
Cc: davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Date: Tue, 31 Oct 2023 18:25:42 +0800
X-OQ-MSGID: <20231031102541.2915750-2-eadavis@qq.com>
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


