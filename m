Return-Path: <netdev+bounces-132766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF8993115
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E311F21111
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7A1D7E58;
	Mon,  7 Oct 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CwzBLBwi"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661541D798C
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314738; cv=none; b=apPvEj2tGiGiGocNbfqirZmBwnfCjz1caqFgxb/Ip+5ALNOZCBPVEv08bgc+R3Fz3iWYxouAj7GNjHUj+hr8IUGweIOiV2NUbXgt0ShlqVOGfy9LT7R+jvqvBxWzgPTgEhPykcPeu0X8tXIZf/6KJRt5QUPD6a+dKIfyYtdfxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314738; c=relaxed/simple;
	bh=tgbZTW4YKiXzj8b2Y/8r0+O8ngysyHGaOu54JF5mFDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uP0WtIleVGBiKVbXK5p48CQbm9Bi2yrDH390RPdid1JCrAA7VtfAw94DglP6UzkL0fbDhj350/cZdsLdLD0bkgtyCyvM/ooJ3H0MDOW0LJIJU4NUxXLAdeBwlGlf95J2i6BonYnDjXyNddA33JUCmftag4lyF2OmYQtgwIpBv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CwzBLBwi; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Featb
	A97nKxkuFIunBTlT+l+aYBdvieqb7wZo7p/3D8=; b=CwzBLBwiQFLHLUN25Xuth
	NbhyHLyyMH/NJDbelEAUADRVQMR754ZVCj7TDNpie31M9KjL2kk8Efs2b/yBv7JE
	9SBDywntkEpABw61LTSPkIuI1uSsaKl2FNz+o+JZBW29WQPYOL0JeHiMT27KpHTS
	ORPr1TBOPPXaV7YK/gmsos=
Received: from localhost.localdomain (unknown [124.90.104.175])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnrwRc_QNnxkvtBQ--.30605S2;
	Mon, 07 Oct 2024 23:25:30 +0800 (CST)
From: tao <wangtaowt166@163.com>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	tao <wangtaowt166@163.com>
Subject: [RFC] ptp: Delete invalided timestamp event queue code
Date: Mon,  7 Oct 2024 23:25:02 +0800
Message-Id: <20241007152502.387840-1-wangtaowt166@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrwRc_QNnxkvtBQ--.30605S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxXr1kCr4xXFW7tr4DCFg_yoW8Aw47pa
	s3Aw13GF48trs8WrW7Kr4kZas3K3Z8K3yxCr1Ik3Z5WF17uFy0qF4rtFWUJayxXFZrAFn5
	X3W8tws8ZFy8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRROJnUUUUU=
X-CM-SenderInfo: pzdqw3xdrz3iiww6il2tof0z/1tbi7hJx8mcD8wJ12wAAsE

used timestamp event queue In ptp_open func,  queue of ptp_clock_register
 already invalid so delete it

Signed-off-by: tao <wangtaowt166@163.com>
---
 drivers/ptp/ptp_clock.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..9be8136cb64c 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -235,7 +235,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 				     struct device *parent)
 {
 	struct ptp_clock *ptp;
-	struct timestamp_event_queue *queue = NULL;
 	int err, index, major = MAJOR(ptp_devt);
 	char debugfsname[16];
 	size_t size;
@@ -260,20 +259,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	ptp->devid = MKDEV(major, index);
 	ptp->index = index;
 	INIT_LIST_HEAD(&ptp->tsevqs);
-	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
-	if (!queue) {
-		err = -ENOMEM;
-		goto no_memory_queue;
-	}
-	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	spin_lock_init(&ptp->tsevqs_lock);
-	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
-	if (!queue->mask) {
-		err = -ENOMEM;
-		goto no_memory_bitmap;
-	}
-	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
-	spin_lock_init(&queue->lock);
 	mutex_init(&ptp->pincfg_mux);
 	mutex_init(&ptp->n_vclocks_mux);
 	init_waitqueue_head(&ptp->tsev_wq);
@@ -380,11 +366,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 kworker_err:
 	mutex_destroy(&ptp->pincfg_mux);
 	mutex_destroy(&ptp->n_vclocks_mux);
-	bitmap_free(queue->mask);
-no_memory_bitmap:
-	list_del(&queue->qlist);
-	kfree(queue);
-no_memory_queue:
 	xa_erase(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
-- 
2.25.1


