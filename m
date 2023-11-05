Return-Path: <netdev+bounces-46080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDA57E11F7
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 03:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284EE1C20942
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA032EC3;
	Sun,  5 Nov 2023 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DMSkCIQY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EE63E
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 02:18:33 +0000 (UTC)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1BFD9;
	Sat,  4 Nov 2023 19:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699150707; bh=1sul7rx+msAOdbQej+VG6dbs/bVJyeJ5ynZ7Fhh46Z4=;
	h=From:To:Cc:Subject:Date;
	b=DMSkCIQYAYraOytIVtBeieQcM/FMjQAZvM0gR0SSxt4aikYVqbS49Y5Vqi2sJyMi+
	 eFyitHvEtmlcHFAWqjsqxDzQI47n+UOOR98FWADilSIqCyJkJnHsYYg032BS6gHwh5
	 Nnod4eLVCkVf6kV936ZlJsXfw9+uGSSLDXCKb1yg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id 307B66F1; Sun, 05 Nov 2023 10:12:07 +0800
X-QQ-mid: xmsmtpt1699150327tmf327y09
Message-ID: <tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneAArN//1uvZaB24d1RvXicxvLlxitJ+UuZADB6nZYUMkycyQM8v
	 Uvqpjt/t9kSVgIejiiW9sCPUp83QAdxm/KUKEPtECp52LEoNqYkIzdmvaaN/AL4+RO0nls9lF1KZ
	 1CJVFEf1564x55XBz1Vt8r/Xuzkqm3qlzvUbF92wsMw/cVfc6D+2yL+oM79NAOiNSRNbUlOn4V7n
	 6XjNkN/Ibkob7WlSpBQ74dFexfueUXQ0mmZrml4zXqqUZq6+FgHuGuJDJGzKqjZRQxHpnRPLISV0
	 27Hi+bWhsybeCqejXLCovInhmPIjhNKmTG4q5jWXxZYHELIldQkFPbLdfOgVuYcMI1yxa5qvd9mV
	 J0wCBT1Kvl2H7+lcgQSwFxaxM9HFjrXR6c9FfOQFLbYmqLuQKfyglDXcCVk0tP337Vbay4q3igLy
	 Bcc7z4oNdDWm4/XfZ/Yv13YvXCfvkX06Uxw4JzjYXfpVaI8Kf/CV2+vULuEF/7tURdjaUlWcRLNH
	 3i+cc2UBjxhuXTVd6U72Q+2dofHEbV87RUfjTALN5Yd5/zbGrOJRiQiaHtUb2ftbbmyNm5vD1Qxf
	 sgACPzthw1tCX/vLqUEjYIoM1koaKQABiQAhwQvrsSAJQT2doFFQB8fkardUk8WsKfLg4BFok7pm
	 G8m9vMQjMOgBTAL5pxAaqfzK/9s3SUly43dQ973/Qy8vcvrFwvAtElMlUx25e0ZjeceeBwfbNkUD
	 JGZ4fL6hV++lV/58+4v5X95NiF2DyLdXAYPKz+76HVkrQSqnY7XNcRr0UiVlsSa8fseNPT4MHQg+
	 dddrrAfpBp8PYBOOzimtPIsD7i72Bho9BZMPCy4QzVDO1xgITyjCzYX1AAvhPbzh2dzCvuRj6LFs
	 m7hJaKKvG1MB+NCvl/70PihO7PlNAa8wuAIC5JYJfeeIcljKR5OjvVLS6DffP3kHrMCZW1OmFe
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: richardcochran@gmail.com
Cc: davem@davemloft.net,
	habetsm.xilinx@gmail.com,
	jeremy@jcline.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: [PATCH net-next V6] ptp: fix corrupted list in ptp_open
Date: Sun,  5 Nov 2023 10:12:08 +0800
X-OQ-MSGID: <20231105021207.2360569-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no lock protection when writing ptp->tsevqs in ptp_open() and
ptp_release(), which can cause data corruption, use spin lock to avoid this
issue.

Moreover, ptp_release() should not be used to release the queue in ptp_read(),
and it should be deleted together.

Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/ptp/ptp_chardev.c | 11 +++++++----
 drivers/ptp/ptp_clock.c   |  1 +
 drivers/ptp/ptp_private.h |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..31594f40a21e 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -108,6 +108,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
+	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -119,8 +120,10 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
+	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
+	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 
 	/* Debugfs contents */
 	sprintf(debugfsname, "0x%p", queue);
@@ -139,13 +142,15 @@ int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
 	unsigned long flags;
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
 	if (queue) {
 		debugfs_remove(queue->debugfs_instance);
+		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		pccontext->private_clkdata = NULL;
-		spin_lock_irqsave(&queue->lock, flags);
 		list_del(&queue->qlist);
-		spin_unlock_irqrestore(&queue->lock, flags);
+		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
 		bitmap_free(queue->mask);
 		kfree(queue);
 	}
@@ -585,7 +590,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3d1b0a97301c..ea82648ad557 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
+	spin_lock_init(&ptp->tsevqs_lock);
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
 	if (!queue->mask)
 		goto no_memory_bitmap;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 52f87e394aa6..63af246f17eb 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -44,6 +44,7 @@ struct ptp_clock {
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
+	spinlock_t tsevqs_lock; /* one process at a time writing the timestamp fifo list*/
 	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
 	wait_queue_head_t tsev_wq;
 	int defunct; /* tells readers to go away when clock is being removed */
-- 
2.25.1


