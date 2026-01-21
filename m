Return-Path: <netdev+bounces-251936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK9NG5z0cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:45:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C32596AC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 395DF88F014
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D424BC027;
	Wed, 21 Jan 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nQMs9/OI"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B946AF34;
	Wed, 21 Jan 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006086; cv=none; b=lVg+YpXZWSotfq70bgJivdFG+ihO5d4tZSX/CxCn0pmEph0eeX0soXoHdxyDDsz6GPhhWhb6F800Crm7RH2vFav41vwAFJh9uHttkSKnCCd25WBDO+fsiAP3ngEx+Ju7WzIY8D/flKDPvhHxXLD1LJ4JxwBHD5zrRGe+GafWwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006086; c=relaxed/simple;
	bh=Wyjt5j0MSPUTGhX5/gxgjd9pNhNBVOCn12i3hU16UUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuC/PD1nZ9SSOXcgxIyMG+6S5gSH5hiskOiPk0CKtnGsOWBxDuDQNFdt7O6r93Rw9/GJXiF9ZNODUnDKPSGOWp/KjkXpj+XxsEyf+iSTPP67HIZdFuw2ik1mEUCO/8Zq5xiqvFlIY/uIvehfVjuc9ADSSKhQx2+x6h0droCOvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nQMs9/OI; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006083; x=1800542083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uW31CrHkZb/NKZG8IVePzIRSaNVbZs1c92ImhXgCTzY=;
  b=nQMs9/OIf8O78wfswpTzbKmDDpwl+mbl23yIPzxrJTg6NpFEFF9IJEjC
   NmJhTFGfE/Gy/joWtnV39UgWPIVpSmQL9NFxZqoHcoSiZYib/jwZtn2wq
   gJ9OZSNPSH/7glnbsAzOVzNJbzFmEvzifT4XcWntckV5RDhQanbJZLjUe
   KKwn4fpV9f6QVTAmxwkmkdjD/CLzWNi7Oe5IGkP97mFNPSiARDxEPM7iO
   HdXAJo248LJkQ/SPcr3aklyh9X08wpnk3lpylY7IGMp2zaGYx/uL3wU59
   iHhDoEe4NiAC+xADRfS1lpj3/yTvs3Anf4T29QAnrA95BUY2cH6pdQaAI
   w==;
X-CSE-ConnectionGUID: 6ur7NnJSRD662DUteQOM1Q==
X-CSE-MsgGUID: c/a+aS3BSTeEwi/hd+K/nQ==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11093519"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:10765]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id 22e797d9-6f2d-4454-ac8c-6cbfa32f8b23; Wed, 21 Jan 2026 14:34:39 +0000 (UTC)
X-Farcaster-Flow-ID: 22e797d9-6f2d-4454-ac8c-6cbfa32f8b23
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:38 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:35 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <dwmw2@infradead.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.co.uk>
Subject: [PATCH v6 4/7] ptp: ptp_vmclock: Add device tree support
Date: Wed, 21 Jan 2026 14:33:41 +0000
Message-ID: <20260121143402.3092-5-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121143402.3092-1-itazur@amazon.com>
References: <20260121143402.3092-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-5.96 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251936-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,infradead.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[amazon.com,quarantine];
	DKIM_TRACE(0.00)[amazon.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amazon.co.uk:email,amazon.es:email];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3C32596AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Add device tree support to the ptp_vmclock driver, allowing it to probe
via device tree in addition to ACPI.

Handle optional interrupt for clock disruption notifications, mirroring
the ACPI notification behaviour.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/ptp/ptp_vmclock.c | 70 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 38b2bacb755e..8605e441fad7 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -14,10 +14,13 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -535,7 +538,7 @@ vmclock_acpi_notification_handler(acpi_handle __always_unused handle,
 	wake_up_interruptible(&st->disrupt_wait);
 }
 
-static int vmclock_setup_notification(struct device *dev, struct vmclock_state *st)
+static int vmclock_setup_acpi_notification(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	acpi_status status;
@@ -548,10 +551,6 @@ static int vmclock_setup_notification(struct device *dev, struct vmclock_state *
 	if (!adev)
 		return -ENODEV;
 
-	/* The device does not support notifications. Nothing else to do */
-	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
-		return 0;
-
 	status = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
 					     vmclock_acpi_notification_handler,
 					     dev);
@@ -586,6 +585,55 @@ static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 	return 0;
 }
 
+static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_st)
+{
+	struct vmclock_state *st = _st;
+
+	wake_up_interruptible(&st->disrupt_wait);
+	return IRQ_HANDLED;
+}
+
+static int vmclock_probe_dt(struct device *dev, struct vmclock_state *st)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	st->res = *res;
+
+	return 0;
+}
+
+static int vmclock_setup_of_notification(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_irq(dev, irq, vmclock_of_irq_handler, IRQF_SHARED,
+				"vmclock", dev->driver_data);
+}
+
+static int vmclock_setup_notification(struct device *dev,
+				      struct vmclock_state *st)
+{
+	/* The device does not support notifications. Nothing else to do */
+	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
+		return 0;
+
+	if (has_acpi_companion(dev)) {
+		return vmclock_setup_acpi_notification(dev);
+	} else {
+		return vmclock_setup_of_notification(dev);
+	}
+}
+
 static void vmclock_put_idx(void *data)
 {
 	struct vmclock_state *st = data;
@@ -606,7 +654,7 @@ static int vmclock_probe(struct platform_device *pdev)
 	if (has_acpi_companion(dev))
 		ret = vmclock_probe_acpi(dev, st);
 	else
-		ret = -EINVAL; /* Only ACPI for now */
+		ret = vmclock_probe_dt(dev, st);
 
 	if (ret) {
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);
@@ -654,6 +702,7 @@ static int vmclock_probe(struct platform_device *pdev)
 		return ret;
 
 	init_waitqueue_head(&st->disrupt_wait);
+	dev->driver_data = st;
 	ret = vmclock_setup_notification(dev, st);
 	if (ret)
 		return ret;
@@ -690,8 +739,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dev->driver_data = st;
-
 	dev_info(dev, "%s: registered %s%s%s\n", st->name,
 		 st->miscdev.minor ? "miscdev" : "",
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
@@ -706,11 +753,18 @@ static const struct acpi_device_id vmclock_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);
 
+static const struct of_device_id vmclock_of_ids[] = {
+	{ .compatible = "amazon,vmclock", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, vmclock_of_ids);
+
 static struct platform_driver vmclock_platform_driver = {
 	.probe		= vmclock_probe,
 	.driver	= {
 		.name	= "vmclock",
 		.acpi_match_table = vmclock_acpi_ids,
+		.of_match_table = vmclock_of_ids,
 	},
 };
 
-- 
2.47.3


