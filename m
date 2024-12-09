Return-Path: <netdev+bounces-150047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F69E8BDE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD771884DE0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EBE214A6A;
	Mon,  9 Dec 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="VFEZEe0d"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7F214A67
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728292; cv=none; b=bnjuo6P/PejlrybPTfYtTLHhSWHri79suwMGnDGjJBfDaibeYsT+tN2uKBtT8pNLPQ1UZCzxSLANz6pncH80qQ+BOuOHegZvzmMLywZMkR6TbrVFqpzF5+fGyrwmb+TDBMBIEE6I7Gv2P8E1MWx6khtIK3XYev0Kde/+zkU9zIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728292; c=relaxed/simple;
	bh=/bBcBcDRUT60AJQVPjiC2zqi7tPdXXFoKpqM3JiqTLY=;
	h=To:Message-Id:Cc:From:Mime-Version:Subject:Date:Content-Type; b=pwPg7km4jt2PArTyZsc9aEmSUtPi6W9KbC79fOjFDcCFJLSWU7rrIJX3FTdT6ZXkHkASmUrs1YKLH8m/Qv6JQZxYg493CQJlx3WWXuNLCSH7RL/4vnhdOw+XQTOgyVzpY+FD+efkTKVhxfUOz+Zwkdguc20EYb/MqnOvaBjkZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=VFEZEe0d; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728278; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=heJrHCCTJIbnqYTSykcjZ0SMsJbSCb7/1YAwT3Fm0SI=;
 b=VFEZEe0d84sbGsgEDCbHhIjJRm8xH4gxmcTTvM+WfV3BV80Sm3xGMqngRrFnLkn58ahukd
 gdODjDMWqCg3rA9JTmRSP/evNV32xx4zST4lH2XCMDCfo5HJTOIdWB6RwkTDx4C4XVY/Fg
 SPH3yY/7VB3eiVxS1g6lyzOqQoSGYHDaFK8VAgcd9qGhBwKyL1lM99ydMmrnvzrllq0t1Y
 pRm2gvVJ+7d2KIHJv+t4vg/t18M4RdPZ7EHEuKGycjldM1lAmuGC/uD75wmGrSMv7n4+kn
 OhfiXwqDG3gYI4+NfzxKQK589Hn7S2k7FHfCNxZGw0EzszA8mByxAkORp3Jtcg==
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Message-Id: <20241209071101.3392590-9-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
From: "Tian Xin" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267569814+a41e83+vger.kernel.org+tianx@yunsilicon.com>
Subject: [PATCH 08/16] net-next/yunsilicon: Add ethernet interface
Date: Mon,  9 Dec 2024 15:10:53 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:15 +0800
Content-Type: text/plain; charset=UTF-8

From: Xin Tian <tianx@yunsilicon.com>

Build a basic netdevice driver

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 135 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 ++
 5 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h

diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
index 950fd2663..c1d3e3398 100644
--- a/drivers/net/ethernet/yunsilicon/Makefile
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -4,5 +4,5 @@
 # Makefile for the Yunsilicon device drivers.
 #
 
-# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 88d4c5654..5d2b28e2e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -498,6 +498,7 @@ struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
 	struct xsc_priv		priv;
+	void			*netdev;
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..243ec7ced
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/reboot.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
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
+static void *xsc_eth_add(struct xsc_core_device *xdev)
+{
+	int err = -1;
+	int num_chl, num_tc;
+	struct net_device *netdev;
+	struct xsc_adapter *adapter = NULL;
+
+	num_chl = xsc_get_max_num_channels(xdev);
+	num_tc = xdev->caps.max_tc;
+
+	netdev = alloc_etherdev_mqs(sizeof(struct xsc_adapter),
+				    num_chl * num_tc, num_chl);
+	if (unlikely(!netdev)) {
+		xsc_core_warn(xdev, "alloc_etherdev_mqs failed, txq=%d, rxq=%d\n",
+			      (num_chl * num_tc), num_chl);
+		return NULL;
+	}
+
+	netdev->dev.parent = &xdev->pdev->dev;
+	adapter = netdev_priv(netdev);
+	adapter->netdev = netdev;
+	adapter->pdev = xdev->pdev;
+	adapter->dev = &adapter->pdev->dev;
+	adapter->xdev = (void *)xdev;
+	xdev->eth_priv = adapter;
+
+	err = register_netdev(netdev);
+	if (err) {
+		xsc_core_warn(xdev, "register_netdev failed, err=%d\n", err);
+		goto err_reg_netdev;
+	}
+
+	xdev->netdev = (void *)netdev;
+
+	return adapter;
+
+err_reg_netdev:
+	free_netdev(netdev);
+
+	return NULL;
+}
+
+static void xsc_eth_remove(struct xsc_core_device *xdev, void *context)
+{
+	struct xsc_adapter *adapter = NULL;
+
+	if (!xdev)
+		return;
+
+	adapter = xdev->eth_priv;
+	if (!adapter) {
+		xsc_core_warn(xdev, "failed! adapter is null\n");
+		return;
+	}
+
+	xsc_core_info(adapter->xdev, "remove netdev %s entry\n", adapter->netdev->name);
+
+	unregister_netdev(adapter->netdev);
+
+	free_netdev(adapter->netdev);
+
+	xdev->netdev = NULL;
+	xdev->eth_priv = NULL;
+}
+
+static struct xsc_interface xsc_interface = {
+	.add       = xsc_eth_add,
+	.remove    = xsc_eth_remove,
+	.event     = NULL,
+	.protocol  = XSC_INTERFACE_PROTOCOL_ETH,
+};
+
+static void xsc_remove_eth_driver(void)
+{
+	pr_info("remove ethernet driver\n");
+	xsc_unregister_interface(&xsc_interface);
+}
+
+static int xsc_net_reboot_event_handler(struct notifier_block *nb, unsigned long action, void *data)
+{
+	pr_info("xsc net driver recv %lu event\n", action);
+	xsc_remove_eth_driver();
+
+	return NOTIFY_OK;
+}
+
+struct notifier_block xsc_net_nb = {
+	.notifier_call = xsc_net_reboot_event_handler,
+	.next = NULL,
+	.priority = 1,
+};
+
+static __init int xsc_net_driver_init(void)
+{
+	int ret;
+
+	pr_info("add ethernet driver\n");
+	ret = xsc_register_interface(&xsc_interface);
+	if (ret != 0) {
+		pr_err("failed to register interface\n");
+		goto out;
+	}
+
+	register_reboot_notifier(&xsc_net_nb);
+	return 0;
+out:
+	return -1;
+}
+
+static __exit void xsc_net_driver_exit(void)
+{
+	unregister_reboot_notifier(&xsc_net_nb);
+	xsc_remove_eth_driver();
+}
+
+module_init(xsc_net_driver_init);
+module_exit(xsc_net_driver_exit);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
new file mode 100644
index 000000000..ba8e52d7f
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ETH_H
+#define XSC_ETH_H
+
+struct xsc_adapter {
+	struct net_device *netdev;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct xsc_core_device *xdev;
+};
+
+#endif /* XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
new file mode 100644
index 000000000..8cc416783
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ETH_COMMON_H
+#define XSC_ETH_COMMON_H
+
+#define XSC_LOG_INDIR_RQT_SIZE		0x8
+
+#define XSC_INDIR_RQT_SIZE			BIT(XSC_LOG_INDIR_RQT_SIZE)
+#define XSC_ETH_MIN_NUM_CHANNELS	2
+#define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
+
+#endif
-- 
2.43.0

