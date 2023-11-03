Return-Path: <netdev+bounces-45904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829B7E03A8
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D301C209D9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D6179A8;
	Fri,  3 Nov 2023 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GIWDXxzn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF317729
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:15:30 +0000 (UTC)
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD810E6;
	Fri,  3 Nov 2023 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699017305; bh=Z7Py128A6wVRG9h8Xah3BdBSpJ4tKOtguNiUuiUYQgA=;
	h=From:To:Cc:Subject:Date;
	b=GIWDXxznMK5hNbiIDzmiOxdsUi+RF1Mabvz0YP3G4muASeDCj4zWbIrRv0RBJ8ktC
	 Zea2ftmkoIx/k/fLZF7TowH+XVYFom84STGN9G4Eb2NNtlMz+sYT78TxZHXN61e7wS
	 /aA/RrBpHx5SQ9zSkhdSzLwoa2x7O7++5Og9+XqU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 3C31AC15; Fri, 03 Nov 2023 21:15:03 +0800
X-QQ-mid: xmsmtpt1699017303tpu4bwr0r
Message-ID: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
X-QQ-XMAILINFO: MqN/FiDJuNHiveQO5/BvLuA02zXi+2++aiAzqiVoCX3xEz/DjWy9vQsYDwB/27
	 zM1bQq9v2yDLWAdNgBvZGu3Oi+ah4l9uiuiYpslE05LZ7ZoKLD9v6CW+foJgWpHRqxU5Ga/JcrQe
	 NRUyopKxx03Z2fas2z1B3xQTcxh0W8zQgafWcKoi4KxtavfUOzA0UKIUn9jUnkO6yMdzTL47ZSS4
	 R3J7Q+DTdorX3BQk39di4sfAY+lWty+UKHlQE/CTc1SDveVM+vFtrpwQ3DpuouId/iqkulGeIFaL
	 05na5AY3mudY94DQVZjz7u449Z2NBjSZ+90qiTif9kd9pqFTnlAB8mTawxk7bIVkKRetBMfGv/Ml
	 WnfqRk59j63tp+g7+nEEieHwDVtlhYCcG/S/vpOglwMN/zi11d52qVpK/pMRbfqefG/cJp58Zz9+
	 F4JITLUOrjV95b8Jk/XuQRgc/vGvAv+wX4F88eEbS/LXEHBgX8E3UKUCG6BpWJlE6+vETGUHjF18
	 bQeLZYZnMMI6fxwVmdSapSIp5kksjUvDZ7ws0ArnT7FiFZspHyAti2CjnrMDn6v2Rd2d0ZYzfNSf
	 g2PiNElKanoBeeJbvLZf2/DC/KcWqBMucRYW60gE7wgTntctsmMwCkFJc+a5QbzyRj5QXe6Vv156
	 r4nMZ+CqWm73cydAep6/rkKj+JnMVmgDXqvXTvUpnQNBQTOT90Nu6z9J0YpUj4wT0CRe56txMtYt
	 hApLOwENVUgALyeKXNIRI+NlCTVZqiyscbZYPMh9OqAnp15RDLAB1abLmF8KYiMCHzmo6KALOWno
	 mdXRSfnIQOvKNtAN0hcoubqEhr4PDtpF2vIi528SAnPZTKpw2UVbFiJdpQ24llHmuGkwaWp29cDu
	 mEWOVmtzzXM9E503caZB5sIP4hBJmDjfT0Qzfg2mvRW48tun96DQj0iJKVagFGwQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: jeremy@jcline.org
Cc: davem@davemloft.net,
	habetsm.xilinx@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Date: Fri,  3 Nov 2023 21:15:03 +0800
X-OQ-MSGID: <20231103131502.1046033-2-eadavis@qq.com>
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
 drivers/ptp/ptp_chardev.c | 12 ++++++++++--
 drivers/ptp/ptp_clock.c   |  3 +++
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..6e9762a54b14 100644
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
@@ -138,14 +143,19 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
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
 		list_del(&queue->qlist);
 		spin_unlock_irqrestore(&queue->lock, flags);
+		mutex_unlock(&ptp->tsevq_mux);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +595,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
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


