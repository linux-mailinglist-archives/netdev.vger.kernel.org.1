Return-Path: <netdev+bounces-195545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AFAD11A3
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD401188D36D
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7F2010EE;
	Sun,  8 Jun 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="jRGD+FMc"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C701F4CB8
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373172; cv=none; b=hyC/b/C437U2OaFg6NxsQovlNIPwAq5f+SVF36EJRMIQKMfpZ32Cqm9I47au0QZMN7XoYsK47Vle5dCqeZB4a3aFLNrfrCAUVdO6lhBgzOCU7S7rOweCSSz17wEpfU7l1MswkGn5XnuINTA9HYNt2blkaLseWhp8btAQF5U1JXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373172; c=relaxed/simple;
	bh=cB3zsQ/CNsZAWssxqRUV0Vyfu4JHs07k8F5vj/zVQaI=;
	h=Message-Id:Cc:From:Content-Type:Mime-Version:In-Reply-To:To:
	 Subject:Date:References; b=Vpwp1Ls48eKebNbMWxI3+g1KczanoqL32xEGhzIXTg/hzHAp18k9ZJ0ifmZpsiCIbSY/qzbz/OViTidl59eF47aMp44u4qCi2h2QNq0mVsL+uVdVjN8fu1fOYG4+Qovjkg9LpNZuIomRhuLQrV3mcz0JLXZQzw5l2xckub1dCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=jRGD+FMc; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749373158; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ob7CZwFOseRDKkVP1bTFTiEkK1g23YF2MspH+CAzTJo=;
 b=jRGD+FMcnQnEm4nnqnlDxMC2Ry2cxYJXT51BiWvFeuxnCmoFhPT7Np193wW8LQ7XUYripz
 wgsypX1I1TCA4rpU3onr9jChCsRhA1SHILMpXrkU45kNuaignDrZFsd0F+xbCWxUEqrLdk
 fzAgxQInTZdNksVCfQA8CpzwDg5K4lyreudLrIK/UNsKtQiPy5GVPVtMvYN5xkS+TYsaSZ
 zrdYjiIEFuFQ6vjtW+F1cbe7JtC3oxgTyERmkbfVguO5mckCyrSzqC1HlywtwhrjussGjr
 B2QumzFFL8B1FXMdc0e76LhLv2E7pntpxrIZ6ynOROkHTTOfLOBpoirYVJ1aDw==
Message-Id: <20250608085914.3283672-9-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2684550e4+b18470+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <20250608085857.3283672-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Subject: [PATCH net-next v12 08/14] xsc: Add ethernet interface
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Sun, 08 Jun 2025 16:59:15 +0800
Content-Transfer-Encoding: 7bit
Date: Sun, 08 Jun 2025 16:59:16 +0800
References: <20250608085857.3283672-1-tianx@yunsilicon.com>

Implement an auxiliary driver for ethernet and initialize the
netdevice simply.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |  1 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 98 +++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h | 16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       | 15 +++
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h

diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
index 05aa35c3c..86e241b01 100644
--- a/drivers/net/ethernet/yunsilicon/Makefile
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -4,4 +4,5 @@
 # Makefile for the Yunsilicon device drivers.
 #
 
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..f5e247864
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/auxiliary_bus.h>
+
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
+	if (!adapter)
+		return;
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

