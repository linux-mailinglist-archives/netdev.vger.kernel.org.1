Return-Path: <netdev+bounces-152898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB19F63E1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B29B160430
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01619A28D;
	Wed, 18 Dec 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="e2oxioEo"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-32.ptr.blmpb.com (va-1-32.ptr.blmpb.com [209.127.230.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B15199EB2
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519191; cv=none; b=EEgtP9XTrV6zaXRshKk6pOw5Z7DgDfjFftY68OkWQx+VhWCpeJ0dIhh8+ef8bzHoISh87gkf9V0aeJjCZvUS9XTOtcG1RQvyWND3mAS4UmML2AAcPHnrbLHObaI5MYq2v30OG3XMX7qjAQ1Rd/tHXiohhfMwCHi39KRteAXQnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519191; c=relaxed/simple;
	bh=ttOFnHJ4QzNitCX71WbRmvFxM12Kk8giOsVKY7hsB0Y=;
	h=Cc:References:Content-Type:From:Subject:Date:To:Message-Id:
	 Mime-Version:In-Reply-To; b=ZV8vwabzJhjr22+AVvE/KzoCGMUVTVn3LV9JqB0QBRx5SDVBvs/yor3gmHJljrgjhkvODf36tjmrsj7bqmExfvt/jUdjWiwcbIyOkKIiiiv2KnOtqHVokD2ZNtY/hm49wP1zCKfkp8NtcVT9kg3mULgXEzjCzXQPep4RBP4NKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=e2oxioEo; arc=none smtp.client-ip=209.127.230.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519043; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HSxtc2N8ecpm7wyhbEqEYwv1cYs2rMEtzc3dN07mDHk=;
 b=e2oxioEoYhv4lautYkMRuUPbgWeq9NFKk2XPIlkWrhaId8y4kh790GO1azaLpN5leue2P3
 wjZGbdQJSWZlde3m0DQMQ13dHX7raZSYV2xVu9Z81Mn4BZApmr6kikVD3gNsxyEo0KiUuz
 eG8GtAnhFRd7CAolxtuVHpmSQgqfB1FnGS5VPXRxf+DwsZrSJdWcUT0kcHNepZbf+IMY2b
 rrRtrWemS7FO5qDgOCtsVVeYGhlE1X42riaBEguyGrxqEvg8uGbKfnVVs7gaelcydOEvmA
 KS8jy8V5zRXF+SmowWnWfDxiF4ZMu7pnQTTPY36GiyZj6FOHVrGKPxV+3YSY7Q==
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+26762a901+428bf8+vger.kernel.org+tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH v1 08/16] net-next/yunsilicon: Add ethernet interface
Date: Wed, 18 Dec 2024 18:50:41 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:50:40 +0800
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Message-Id: <20241218105039.2237645-9-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>

Build a basic netdevice driver

 
Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 118 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 +++
 5 files changed, 151 insertions(+), 1 deletion(-)
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
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index fc2d3d01b..b78443bbf 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -497,6 +497,7 @@ struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
 	struct xsc_priv		priv;
+	void			*netdev;
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..e265016eb
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
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
+		goto err_free_netdev;
+	}
+
+	xdev->netdev = (void *)netdev;
+
+	return adapter;
+
+err_free_netdev:
+	free_netdev(netdev);
+
+	return NULL;
+}
+
+static void xsc_eth_remove(struct xsc_core_device *xdev, void *context)
+{
+	struct xsc_adapter *adapter;
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
+	xsc_unregister_interface(&xsc_interface);
+}
+
+static __init int xsc_net_driver_init(void)
+{
+	int ret;
+
+	ret = xsc_register_interface(&xsc_interface);
+	if (ret != 0) {
+		pr_err("failed to register interface\n");
+		goto out;
+	}
+	return 0;
+out:
+	return -1;
+}
+
+static __exit void xsc_net_driver_exit(void)
+{
+	xsc_remove_eth_driver();
+}
+
+module_init(xsc_net_driver_init);
+module_exit(xsc_net_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION(XSC_ETH_DRV_DESC);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
new file mode 100644
index 000000000..7189acebd
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_ETH_H
+#define XSC_ETH_H
+
+struct xsc_adapter {
+	struct net_device	*netdev;
+	struct pci_dev		*pdev;
+	struct device		*dev;
+	struct xsc_core_device	*xdev;
+};
+
+#endif /* XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
new file mode 100644
index 000000000..55dce1b2b
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
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

