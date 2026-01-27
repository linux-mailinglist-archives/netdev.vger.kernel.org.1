Return-Path: <netdev+bounces-253828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAIFO/OieGmGrgEAu9opvQ
	(envelope-from <netdev+bounces-253828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:35:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6393A68
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 920283026144
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E134846A;
	Tue, 27 Jan 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EvP+/7ja"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9111346FD2;
	Tue, 27 Jan 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513709; cv=none; b=P/FYm+AG1ujPXhzu+3vJaR4oxdRTeClFhU8CRicFYjeZdm259lxvTjXlMRWCpu9C7UilzdsxbHW9yR2RKsqsCAanATj4dRbSbofk5YBxpxfWDiyUl0UK9s2EH3ck8eRV7TAYqZ+wIrKzEklA5nAG/q39QPmXsilSXLkxNzSXFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513709; c=relaxed/simple;
	bh=ijqw2O8M7EUIc2BLl4oLs4GoBTynTXwFnDwtGiVmiy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OASEI9mHta5RFbt1sDEBBFUOB96rYf4ZJTs+R23rnNPS+3dSPlIPxFNvqfpp0Vj+Scp0KZ5So0OKrYUDDRTaGDISbnTZ5DK63vqE3S4nbG+ZjYLbgZ7sAnybB/QTuCiPU9cCzjKV0mf0nD7rAFOJI+Rsp5VldD64I3ndxR1Pkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=EvP+/7ja; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60RBYRNZ02868624, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769513668;
	bh=ZxtqcX2ExE4wGpUEJrq36UPhDozF5UQGFh/ckwekslw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EvP+/7jaBi+HNj2q/rj+aX2YvO29pZ6EzOc48j4TzxEZC5V49YL1wgOJgKhRDQawi
	 CUSK3SZvh6TBtmfyqE1KcDxRGyOmJfgK5Sprn6knI4bkXXWhk/CpVq77GJUYlCBnQB
	 xFN63+xX/sEgNPQ9YOWPRjF3UdDs14PBvJReAz9rwZajy51lCui6OlwQz6U71Jck2U
	 fEkCzpDjm2Hp3X09M2A0IfBlnaDW2ixGaGG8MY0jhmojiAW3m7DjULhQs8LPcRpR6w
	 mgUK3fhODA4tVzK2mij1prArgc4Bam6W+gfwrxKHe0x2xChnl50uJJzvM4QfqVpesj
	 +mpDlbNVBtOyg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60RBYRNZ02868624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Jan 2026 19:34:27 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 27 Jan 2026 19:34:27 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 27 Jan 2026 19:34:27 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 1/3] r816e: add a fake driver r816e for RTL8116af
Date: Tue, 27 Jan 2026 19:34:23 +0800
Message-ID: <20260127113425.1989-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260127113425.1989-1-javen_xu@realsil.com.cn>
References: <20260127113425.1989-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253828-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EF6393A68
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

The driver is for the #fun which DID is 0x816e. The kernel could set
correct power state for #fun through the driver when suspending.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r816e/r816e.c | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/r816e/r816e.c

diff --git a/drivers/net/ethernet/realtek/r816e/r816e.c b/drivers/net/ethernet/realtek/r816e/r816e.c
new file mode 100644
index 000000000000..71674019de2c
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r816e/r816e.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  r816e is the Linux device driver released for Realtek RTL8116AF nic
+ *  with PCI-Express interface, which is used for power management.
+ *
+ *  Copyright(c) 2026 Realtek Semiconductor Corp.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+static struct pci_device_id rtl816e_pci_tbl[] = {
+	{ PCI_VDEVICE(REALTEK, 0x816e), },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, rtl816e_pci_tbl);
+
+static int rtl816e_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent)
+{
+	int rc;
+
+	/* enable device (incl. PCI PM wakeup and hotplug setup) */
+	rc = pcim_enable_device(pdev);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, rc, "enable failure\n");
+
+	dev_info(&pdev->dev, "enable device\n");
+
+	return rc;
+}
+
+static void rtl816e_remove(struct pci_dev *pdev) {}
+
+static int rtl816e_pm_suspend(struct device *device)
+{
+	return 0;
+}
+
+static int rtl816e_pm_resume(struct device *device)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops rtl816e_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rtl816e_pm_suspend, rtl816e_pm_resume)
+};
+
+static struct pci_driver rtl816e_pci_driver = {
+	.name		= "r816e",
+	.id_table	= rtl816e_pci_tbl,
+	.probe		= rtl816e_probe,
+	.remove		= rtl816e_remove,
+#ifdef CONFIG_PM
+	.driver.pm  = pm_ptr(&rtl816e_pm_ops),
+#endif
+};
+
+static int __init rtl816e_init_module(void)
+{
+	return pci_register_driver(&rtl816e_pci_driver);
+}
+
+static void __exit rtl816e_cleanup_module(void)
+{
+	pci_unregister_driver(&rtl816e_pci_driver);
+}
+
+module_init(rtl816e_init_module);
+module_exit(rtl816e_cleanup_module);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RealTek RTL816E driver");
-- 
2.43.0


