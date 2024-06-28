Return-Path: <netdev+bounces-107580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C191B9E2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BC81C23210
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E114B94A;
	Fri, 28 Jun 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GvXkIbKy"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015143AC0;
	Fri, 28 Jun 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563428; cv=none; b=e6uBPKDd3yNLcxAjzo7oBBcQEzOodcza4eCoX+Ip6w5HwqNR5IOzVRpIf0fuycxz0HtbzR2CSEnZNzqO5dAuqz1OxZtYRdNrITh/ZkV8BzDJ1JNO0ywhBOl8aY9EJlOIqwQDsVK4kcMsDkgZuEEPUbA/6s9ujzP0FOayc/MqTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563428; c=relaxed/simple;
	bh=M5uXdjRtlvtzH6mdxQAz6HkPBOUMp1T9Lc8HTXB/nW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwNNXky0uJEY1anNu43RmfQA2d3F93L9R58d+oAgzwhdi0SQnVYhnkQ/+3ayDyOyST1TkjhP7ZGbO+RUuwRG+GDug6J/8xRCu3U1nS+SL/OjT4a9KSxZQL/KXOjuO7YjfU+sRzyduXyx3ybJeuNtrzpjys8vocFrMlDKsADMmzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GvXkIbKy; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YWxaJ
	rajJaFRSG0iQHRmjSZbVIZSCWAFGQbHbwsY/O4=; b=GvXkIbKy4kXec1nmnJecZ
	w5HKcGeJTr3zz27gXDtt+oOD08YPGekYY1owCi3siJ69PmsumfVN29b04eby5/aZ
	b0p1FeCaNksQYdCwIQjjziiBrgVPeg+obDrM4+y7Tha1SUZGQU4m0IXSCi8OBu0N
	OJvm6MV81pGGM9+Rvdl/is=
Received: from localhost.localdomain (unknown [112.97.61.84])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3v7BzdH5mWbI3Aw--.3813S3;
	Fri, 28 Jun 2024 16:29:44 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: manivannan.sadhasivam@linaro.org,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	quic_jhugo@quicinc.com
Cc: netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v3 2/3] bus: mhi: host: Add name for mhi_controller
Date: Fri, 28 Jun 2024 16:29:20 +0800
Message-Id: <20240628082921.1449860-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628082921.1449860-1-slark_xiao@163.com>
References: <20240628082921.1449860-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7BzdH5mWbI3Aw--.3813S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWfJr1DAr1DWFWrXr4fXwb_yoW8Aw1fpF
	sYgrW3Ar1fWrWjkryqk34kZry5Xw4DGFy2kr47W342yr9xt34qvFWqga4FqasF9rWqyF13
	tF1rZayUWw1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_g4SUUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRsMZGVOB7oF2QAAsc

 For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
 This would lead to device can't ping outside successfully.
 Also MBIM side would report "bad packet session (112)".
 In oder to fix this issue, we decide to use the modem name
to do a match in client driver side. Then client driver could
set a corresponding mux_id value for this modem product.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/bus/mhi/host/pci_generic.c | 1 +
 include/linux/mhi.h                | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 1fb1c2f2fe12..14a11880bcea 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1086,6 +1086,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
+	mhi_cntrl->name = info->name;
 
 	if (info->edl_trigger)
 		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index b573f15762f8..86aa4f52842c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -361,6 +361,7 @@ struct mhi_controller_config {
  * @wake_set: Device wakeup set flag
  * @irq_flags: irq flags passed to request_irq (optional)
  * @mru: the default MRU for the MHI device
+ * @name: name of the modem
  *
  * Fields marked as (required) need to be populated by the controller driver
  * before calling mhi_register_controller(). For the fields marked as (optional)
@@ -445,6 +446,7 @@ struct mhi_controller {
 	bool wake_set;
 	unsigned long irq_flags;
 	u32 mru;
+	const char *name;
 };
 
 /**
-- 
2.25.1


