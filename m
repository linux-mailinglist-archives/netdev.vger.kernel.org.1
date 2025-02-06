Return-Path: <netdev+bounces-163617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF21A2AF41
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AAD3A491D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675A198E75;
	Thu,  6 Feb 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9p2xjnF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfmZApLV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9A18BC26;
	Thu,  6 Feb 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863971; cv=none; b=bUgpHtrQaFH2A8zm1cq/guVFMyLQKGOVbnwEiRrDlYXRIA/lhCtbMR8eHktyy789am4thdG7qkV/OsjJ6oHnWn0QEVUE6MqkDM3bTwKPjrvxIVSfeCuHCCHVLKAPYf0RACTALKVjEBD9pPshkJn8BHCO0JBUZPOS2O5mJnNikSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863971; c=relaxed/simple;
	bh=D2uw8E5m7qU4s/kSSq8BNC0Ymfmw4Q5BJg/ZHDFP3ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+hvAw76SjNeVly2W+kvoasEkfgx4/GbfHkU281oChR3yII4e9yYA+hxOEV8g4MWnByGBNc8gs4juhVntF+znKLacQmaRcGjOPcDwu1GCyHq39TOTCVEx/UoUy0TTjVodlEPRHxNcc4DvignCDiyhPusNGERwAW0oNhHxnxij4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9p2xjnF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfmZApLV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738863967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrnoNxsM9IRV2d1rDU60TjRPqbP3VVkVbfOQJnrK0iw=;
	b=K9p2xjnFLnlHq2zXUTt58BRJYqH2RD8kj16NhFO+eUkZhVgGT1KNIsVQ916RnQqiWxCH2A
	9IRFZcOhukmlPpvIUaHySpHR9A+YIHROPRGLhLE2dzDBahsIAPe/kPOGbyqHk+rG0WRTGR
	4FwJV4E3ZRF1ZqK7oR6On1j9ujc7tn97Q1rRvy8MGix13DhDH2QfSHoMpVbz8Gp0mWxQ06
	DAt+p8+DX/uGqtoKs3ACoXX/cguMpS2RZ03utj/XCaa1T5A9gGG/9yVY3+XLDJM34fXZmE
	C/ozf0EqoLOD3GB8DVa+XnvMjYKlqFXqL7TlkGDZk+mGKTBlQ8f+XS7oAhcs7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738863967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrnoNxsM9IRV2d1rDU60TjRPqbP3VVkVbfOQJnrK0iw=;
	b=TfmZApLVMdeGj5gnXNWk3iCiuK3ONlh5BUuuL0gFFfG2frSJNz+uFMMiujSumuGrJbOFYW
	X6Phy+vZMrCY72Cg==
Date: Thu, 06 Feb 2025 18:45:03 +0100
Subject: [PATCH net-next 3/4] ptp: vmclock: Clean up miscdev and ptp clock
 through devres
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250206-vmclock-probe-v1-3-17a3ea07be34@linutronix.de>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
In-Reply-To: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738863961; l=2240;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=D2uw8E5m7qU4s/kSSq8BNC0Ymfmw4Q5BJg/ZHDFP3ZM=;
 b=KeG5k0px0ALp/CI4DLQz/xyTX0xDyuwh7eWqsU4KIpQRZA+f/Zb7mLIP+xZjrXt8XaiO8svnJ
 EIK+CIuNXDlDuMkF/C1envIubr2ATM0BVio4e9VBBtqVwQDakv6Y2vs
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most resources owned by the vmclock device are managed through devres.
Only the miscdev and ptp clock are managed manually.
This makes the code slightly harder to understand than necessary.

Switch them over to devres and remove the now unnecessary drvdata.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/ptp/ptp_vmclock.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 82e6bef72b1b6edef7d891964c3f9c4546f6ddba..b7fa196975229cec6d27b34f7bb235c53b5b5732 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -420,10 +420,9 @@ static const struct file_operations vmclock_miscdev_fops = {
 
 /* module operations */
 
-static void vmclock_remove(struct platform_device *pdev)
+static void vmclock_remove(void *data)
 {
-	struct device *dev = &pdev->dev;
-	struct vmclock_state *st = dev_get_drvdata(dev);
+	struct vmclock_state *st = data;
 
 	if (st->ptp_clock)
 		ptp_clock_unregister(st->ptp_clock);
@@ -524,8 +523,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	dev_set_drvdata(dev, st);
-
 	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
 	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
 	    le16_to_cpu(st->clk->version) != 1) {
@@ -551,6 +548,10 @@ static int vmclock_probe(struct platform_device *pdev)
 
 	st->miscdev.minor = MISC_DYNAMIC_MINOR;
 
+	ret = devm_add_action_or_reset(&pdev->dev, vmclock_remove, st);
+	if (ret)
+		goto out;
+
 	/*
 	 * If the structure is big enough, it can be mapped to userspace.
 	 * Theoretically a guest OS even using larger pages could still
@@ -573,7 +574,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		if (IS_ERR(st->ptp_clock)) {
 			ret = PTR_ERR(st->ptp_clock);
 			st->ptp_clock = NULL;
-			vmclock_remove(pdev);
 			goto out;
 		}
 	}
@@ -602,7 +602,6 @@ MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
 
 static struct platform_driver vmclock_platform_driver = {
 	.probe		= vmclock_probe,
-	.remove		= vmclock_remove,
 	.driver	= {
 		.name	= "vmclock",
 		.acpi_match_table = vmclock_acpi_ids,

-- 
2.48.1


