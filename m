Return-Path: <netdev+bounces-158462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD2A11F29
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D97188D7E2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB223F27C;
	Wed, 15 Jan 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="KDKKct3C"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3E22FDFB
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936590; cv=none; b=WyOkAj7yIqqk5mbBU6/hxsTphWSvISSf8cNMVBY6WQ5krjs3WXkhygOFLIpQYyTDiTKScNqiKGZ4ign6/USEbPz1OVZgV5odhH1Rws8cBO6OVSEoWO1j20ZuoZR2ZlqadHeEqie6TroHDQ8U8sGeNKgc1q4QvyNXLF8VxHEXHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936590; c=relaxed/simple;
	bh=wPr24lyhGp0AegPwnFPHBJr+Ckjo5kKY256Pipppnjk=;
	h=From:Date:Mime-Version:References:To:In-Reply-To:Cc:Subject:
	 Message-Id:Content-Type; b=ageiVXz7evJ4mv8bSzI4MeZ3s6ct6PGCvuTmGccp71yklwF/rNsUKUOCqIFviqMYAZr6yfDF4lySZmMjYeglUX5mwloIo+1D7U9pLPEZ1l7FFKcv4tfarxRj1gpmSJcRgtz/mCtnFMqukFaOm/fNfFU+g92nJx3k/iJGQ0Bp2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=KDKKct3C; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1736936583; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/T300Wy0X6Ju0a6J/YBFbg4US6oqdbDMmAKwoRlXjyY=;
 b=KDKKct3C0d4kDKbH/qYezLnZxn7WhaDVaUkC4jv8ujblPzQ1zPuKdTqHYMsI0sAM0OcXJw
 KLpxBwu43LYMG/sEJA3OVgoBkksU+6J4oo2jxI+KfgrnMwtwkj8v3e/Ls5Ha1iIczYVLPl
 YGBzaOq/2IeYWM0aDVHVSavkSUbvV7DOsA4eX7wsma1UQHL+Ke12dLTuMuqeZkrtVWPAUV
 tyseu3G63uEpfee0LC2hjjXSa3l1YhKVMiszFy7ZJLh6n+XYAkDQA1sp4lFzFc/F8GVFzm
 ieHn3yQ3A/GQ4FSV+YjVmOh0pBKppzuXmWXcPDISfZLkPItLpEFf0U3670n27A==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Wed, 15 Jan 2025 18:23:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 15 Jan 2025 18:23:00 +0800
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267878c85+27ec6d+vger.kernel.org+tianx@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
In-Reply-To: <20250115102242.3541496-1-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: [PATCH v3 08/14] net-next/yunsilicon: Add ethernet interface
Message-Id: <20250115102259.3541496-9-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8

Implement an auxiliary driver for ethernet and initialize the
netdevice simply.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |  2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 99 +++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h | 16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       | 15 +++
 4 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h

diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
index 6fc8259a7..65b9a6265 100644
--- a/drivers/net/ethernet/yunsilicon/Makefile
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -4,5 +4,5 @@
 # Makefile for the Yunsilicon device drivers.
 #
 
-# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..42636bec1
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/auxiliary_bus.h>
+#include "common/xsc_core.h"
+#include "xsc_eth_common.h"
+#include "xsc_eth.h"
+
+static int xsc_get_max_num_channels(struct xsc_core_device *xdev)
+{
+	return min_t(int, xdev->dev_res->eq_table.num_comp_vectors,
+		     XSC_ETH_MAX_NUM_CHANNELS);
+}
+
+static int xsc_eth_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *adev_id)
+{
+	struct xsc_adev *xsc_adev = container_of(adev, struct xsc_adev, adev);
+	struct xsc_core_device *xdev = xsc_adev->xdev;
+	struct xsc_adapter *adapter;
+	struct net_device *netdev;
+	int num_chl, num_tc;
+	int err;
+
+	num_chl = xsc_get_max_num_channels(xdev);
+	num_tc = xdev->caps.max_tc;
+
+	netdev = alloc_etherdev_mqs(sizeof(struct xsc_adapter),
+				    num_chl * num_tc, num_chl);
+	if (!netdev) {
+		pr_err("alloc_etherdev_mqs failed, txq=%d, rxq=%d\n",
+		       (num_chl * num_tc), num_chl);
+		return -ENOMEM;
+	}
+
+	netdev->dev.parent = &xdev->pdev->dev;
+	adapter = netdev_priv(netdev);
+	adapter->netdev = netdev;
+	adapter->pdev = xdev->pdev;
+	adapter->dev = &adapter->pdev->dev;
+	adapter->xdev = xdev;
+	xdev->eth_priv = adapter;
+
+	err = register_netdev(netdev);
+	if (err) {
+		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
+		goto err_free_netdev;
+	}
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+
+	return err;
+}
+
+static void xsc_eth_remove(struct auxiliary_device *adev)
+{
+	struct xsc_adev *xsc_adev = container_of(adev, struct xsc_adev, adev);
+	struct xsc_core_device *xdev = xsc_adev->xdev;
+	struct xsc_adapter *adapter;
+
+	if (!xdev)
+		return;
+
+	adapter = xdev->eth_priv;
+	if (!adapter) {
+		netdev_err(adapter->netdev, "failed! adapter is null\n");
+		return;
+	}
+
+	unregister_netdev(adapter->netdev);
+
+	free_netdev(adapter->netdev);
+
+	xdev->eth_priv = NULL;
+}
+
+static const struct auxiliary_device_id xsc_eth_id_table[] = {
+	{ .name = XSC_PCI_DRV_NAME "." XSC_ETH_ADEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, xsc_eth_id_table);
+
+static struct auxiliary_driver xsc_eth_driver = {
+	.name = "eth",
+	.probe = xsc_eth_probe,
+	.remove = xsc_eth_remove,
+	.id_table = xsc_eth_id_table,
+};
+module_auxiliary_driver(xsc_eth_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Yunsilicon XSC ethernet driver");
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
new file mode 100644
index 000000000..0c70c0d59
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_ETH_H
+#define __XSC_ETH_H
+
+struct xsc_adapter {
+	struct net_device	*netdev;
+	struct pci_dev		*pdev;
+	struct device		*dev;
+	struct xsc_core_device	*xdev;
+};
+
+#endif /* __XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
new file mode 100644
index 000000000..b5640f05d
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_ETH_COMMON_H
+#define __XSC_ETH_COMMON_H
+
+#define XSC_LOG_INDIR_RQT_SIZE		0x8
+
+#define XSC_INDIR_RQT_SIZE		BIT(XSC_LOG_INDIR_RQT_SIZE)
+#define XSC_ETH_MIN_NUM_CHANNELS	2
+#define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
+
+#endif
-- 
2.43.0

