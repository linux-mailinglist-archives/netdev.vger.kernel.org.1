Return-Path: <netdev+bounces-172843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D83A564A9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C28189956F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E19F20E713;
	Fri,  7 Mar 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="Nlg4cjyy"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-16.ptr.blmpb.com (va-1-16.ptr.blmpb.com [209.127.230.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BA20E014
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342142; cv=none; b=hdgCx4UZQ5g+sQQrLS7/zJfVa4wm5VNVSgtwhTb96CGzbyeNqEJ9StHGSUBzpmayNg1PSrckdFc2j6YoTFjLgqxI4ctzxQ6fU0NMeWTmOaGR7HtHqasLlPNijttBn8KvT7R6Uyo3IM7/aEWj7RkJYbjCTe+Bq6fuxNxoirPMkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342142; c=relaxed/simple;
	bh=cB3zsQ/CNsZAWssxqRUV0Vyfu4JHs07k8F5vj/zVQaI=;
	h=References:Cc:From:Subject:Message-Id:In-Reply-To:To:Date:
	 Mime-Version:Content-Type; b=B5O9ZLHlGnhn+bf44MtiT/Ju5H5W0ZHSTz88mSyDw+gaiw5RB59DGZ09t+OpNObcf75o9WI6/5VjHV4SB9692ef2W7NK5VKrb1zJ53zlQqEA8/ST3oIU0rAoJv1XojeVZB5ZEnxBm4sLG/gzo72NdHQAfLa3hUV8mCA3RepDr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=Nlg4cjyy; arc=none smtp.client-ip=209.127.230.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741342127; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ob7CZwFOseRDKkVP1bTFTiEkK1g23YF2MspH+CAzTJo=;
 b=Nlg4cjyyBC+SQVfUYiNVVK/TOCzJdmsNc4nA+ug60ytkY0NnPJppypYlEs3oxQ7OYO6aTY
 cnKyc9arpuPJvZakyoSbrHqgrJDbpry8ROM5UEjuAWuL1zEXE6kY9LRIKrp9zB/bfRvk4M
 eZZVFQa1KoxlKtFmaXfEAXKlu9wrvlt7aJ67iebc8xYW80oDODyU7aUlSkIWk8c3bYDpGp
 DCaiu7R8ch53x8jTOH3dtyIubbWUDVN73F+ZrLzo7mOxqTqPF+IyXD4eP0gZO4rZ80qEaz
 KKp0DUJfMNymjvBrU8JihQ7yVNnLccyIc6bt+wQT1c5sk5Sh1U9z6KTUZwci4w==
References: <20250307100824.555320-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH net-next v8 08/14] xsc: Add ethernet interface
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:08:44 +0800
Message-Id: <20250307100843.555320-9-tianx@yunsilicon.com>
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
To: <netdev@vger.kernel.org>
Date: Fri, 07 Mar 2025 18:08:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+267cac5ad+0cb630+vger.kernel.org+tianx@yunsilicon.com>

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

