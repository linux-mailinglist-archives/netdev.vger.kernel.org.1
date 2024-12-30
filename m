Return-Path: <netdev+bounces-154515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044559FE530
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 11:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C261881F5A
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD3199934;
	Mon, 30 Dec 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="WaHM6nQu"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFE2B9B9
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553746; cv=none; b=RgJFzck1GeYr6wPj09KhMu+1TYNvmqk64haDQLlJY+fKvY2n8qPT+LgUn9RhTgvet1ClWUjsWOestiNTo+IBgVgd0Ciu9yKS+vgt/lO7UgSAbHKtx9atNSIZS72arBfHaRMRU3tj0K5Z0xnvOn29f6i+F/+Q7WknCHaP421w3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553746; c=relaxed/simple;
	bh=4H+m9357pbeTSBm1fn/gK9O5ETBa1myp2vPLbHfGDx4=;
	h=Cc:Mime-Version:To:Subject:Date:In-Reply-To:From:References:
	 Content-Type:Message-Id; b=DOk1LfPndE7HB72yhrdIHnsNLHIYx1OuEGAaQq7cQQr0IYvspeyxXBH1JmIfZKXICXNRKus+cOJ04hYTZgmFjHmkWdYjIpjHA3pP8AihekdJO2BUvEaJ0RWsxtVXdOnS57XMciYxAcjdzkjedbWs5VDyT1zunma4n8N3OsLsw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=WaHM6nQu; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735553732; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=faL6+pZz9ITDwcfigFE99wiTBcQ/HL1A8GgvLp6tHo0=;
 b=WaHM6nQu9cqss1Kp3+Vrg2yQtF2WfbPvxr7VH26OnGRrNi0L+fC8CB+zetb/MLrgaDKhQY
 1FZgcb0vp4xJa/rPnOwCJ2ZGDMJ1RhXi956vyJynwWAygQYRNGd6JGgfSYer84X2t3SjLR
 UpdlMiIsc1UeLpdzwrLgap25L4WiXL7iLiAJKSq7hsRzMXh7vkHVTaKpwVx+3A+dQNTFJp
 TDmOfzq2vtnT1wd+09GOGRt9+exNMo01KSBdLI63w5v39JVaqtmNH57bIKihhJLOP7ZJW+
 zNfuB28rDFwJ7o1i6Lbd2+5dS4BzZq9lynn/m111n6kUtVRRpkokwdqwI/u3ew==
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+2677272c2+bd8b10+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Date: Mon, 30 Dec 2024 18:15:29 +0800
In-Reply-To: <20241230101513.3836531-1-tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Mon, 30 Dec 2024 18:15:29 +0800
Content-Transfer-Encoding: 7bit
Message-Id: <20241230101528.3836531-9-tianx@yunsilicon.com>

Build a basic netdevice driver

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   1 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 116 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 +++
 5 files changed, 149 insertions(+), 1 deletion(-)
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
index 2eb9c3c80..ee43b5f47 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -429,6 +429,7 @@ struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
 	struct xsc_priv		priv;
+	void			*netdev;
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..8d29e88cf
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,116 @@
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
+		pr_err("alloc_etherdev_mqs failed, txq=%d, rxq=%d\n",
+		       (num_chl * num_tc), num_chl);
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
+		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
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
+		netdev_err(adapter->netdev, "failed! adapter is null\n");
+		return;
+	}
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

