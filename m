Return-Path: <netdev+bounces-195375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16397ACFF8D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F48189B204
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC742868AB;
	Fri,  6 Jun 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="eJi3FoSa"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D692857E0
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203110; cv=none; b=dX51WCaqArzp4OCH+pRq44GyGeh4uStvUU111pDg3I+bEtQodeXaZGjxtsposCyHSUFugpreM5/JtFSG4WvxQ+tvAHJI67J/OFOQcD+hUNZmvme7WuvFNkDI9zkl3Z2jgpRWtbF7G7PHSA1z1ZguMZCtnOXuEbPjF6ulD2F/dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203110; c=relaxed/simple;
	bh=Lj6jthBiWmZdoYWVsQQGDrVzhO1/EFUG+CI4BhbCTQI=;
	h=Content-Type:Cc:Message-Id:Mime-Version:In-Reply-To:To:From:
	 References:Subject:Date; b=mtctWhpirYV9FASkPLtONNBpCEEiptfUDUqUMm7yBCv4OHjcy/ugMmzaYBn8FJd3zEnsf9Y9LJpo/XJHEIAEIrCT42YKsmQA3RBI6kQo/ZCKEGhDp5CL41dzo8VvR8SpqxaAno5Zi19dD5pt5J9vuX07NMCa3L1Y+7XRKvEbCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=eJi3FoSa; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749203098; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QzUYWl+kPhDCZwIl/qiIBiSp40fFl8rLNCqkIRpaWws=;
 b=eJi3FoSavopyj36MEFWVQO4b8ucgT+kLA3NQ4+gk/THKNxbnbbjO3uWXH3Rtghr67xSEH0
 l32D21TXSNwOhSqgmXHCOjXKcH90cjcy+IGrObE4hBQIGC4yC0BwcOEepJMfd4RsKVoNa2
 mrKLcbrsKd0af1LyFedYLCrB9cz8GewrfpJb7y1ymfhXzh+h2AROKrLCMCRM2wa220wmmc
 ucsBR1n+jE2OV6DchPwMloPlHVBz9qZCEDycRZchQw5NlPQ+30m9raid05LAQb+ackcD3B
 7ZTx+2/vgkXqp5TAXajJcegnYHgKo2hjO1+YTG9741xJCSzfmp9rE9IrOZPpww==
X-Lms-Return-Path: <lba+26842b898+0bbb0f+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Message-Id: <20250606094454.3271886-8-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250606094437.3271886-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 06 Jun 2025 17:44:55 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250606094437.3271886-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH net-next v12 07/14] xsc: Init auxiliary device
Date: Fri, 06 Jun 2025 17:44:55 +0800

Our device supports both Ethernet and RDMA functionalities, and
leveraging the auxiliary bus perfectly addresses our needs for
managing these distinct features. This patch utilizes auxiliary
device to handle the Ethernet functionality, while defining
xsc_adev_list to reserve expansion space for future RDMA
capabilities.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  14 +++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 115 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 60dde506e..e6863cb08 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -7,6 +7,7 @@
 #define __XSC_CORE_H
 
 #include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
 
 #include "common/xsc_cmdq.h"
 
@@ -210,6 +211,17 @@ struct xsc_irq_info {
 	char name[XSC_MAX_IRQ_NAME];
 };
 
+/* adev */
+#define XSC_PCI_DRV_NAME "xsc_pci"
+#define XSC_ETH_ADEV_NAME "eth"
+
+struct xsc_adev {
+	struct auxiliary_device	adev;
+	struct xsc_core_device	*xdev;
+
+	int			idx;
+};
+
 /* hw */
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -347,6 +359,8 @@ struct xsc_dev_resource {
 struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
+	int			adev_id;
+	struct xsc_adev		**xsc_adev_list;
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 	int			numa_node;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 3525d1c74..ad0ecc122 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o adev.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
new file mode 100644
index 000000000..c9c6328a4
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/idr.h>
+
+#include "adev.h"
+
+static DEFINE_IDA(xsc_adev_ida);
+
+enum xsc_adev_idx {
+	XSC_ADEV_IDX_ETH,
+};
+
+static const char * const xsc_adev_name[] = {
+	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
+};
+
+static void xsc_release_adev(struct device *dev)
+{
+	struct xsc_adev *xsc_adev =
+		container_of(dev, struct xsc_adev, adev.dev);
+	struct xsc_core_device *xdev = xsc_adev->xdev;
+	int idx = xsc_adev->idx;
+
+	kfree(xsc_adev);
+	xdev->xsc_adev_list[idx] = NULL;
+}
+
+static int xsc_reg_adev(struct xsc_core_device *xdev, int idx)
+{
+	struct auxiliary_device	*adev;
+	struct xsc_adev *xsc_adev;
+	int ret;
+
+	xsc_adev = kzalloc(sizeof(*xsc_adev), GFP_KERNEL);
+	if (!xsc_adev)
+		return -ENOMEM;
+
+	adev = &xsc_adev->adev;
+	adev->name = xsc_adev_name[idx];
+	adev->id = xdev->adev_id;
+	adev->dev.parent = &xdev->pdev->dev;
+	adev->dev.release = xsc_release_adev;
+	xsc_adev->xdev = xdev;
+	xsc_adev->idx = idx;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(xsc_adev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	xdev->xsc_adev_list[idx] = xsc_adev;
+
+	return 0;
+}
+
+static void xsc_unreg_adev(struct xsc_core_device *xdev, int idx)
+{
+	struct xsc_adev *xsc_adev = xdev->xsc_adev_list[idx];
+	struct auxiliary_device *adev = &xsc_adev->adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+int xsc_adev_init(struct xsc_core_device *xdev)
+{
+	struct xsc_adev **xsc_adev_list;
+	int adev_id;
+	int ret;
+
+	xsc_adev_list = kcalloc(ARRAY_SIZE(xsc_adev_name),
+				sizeof(struct xsc_adev *),
+				GFP_KERNEL);
+	if (!xsc_adev_list)
+		return -ENOMEM;
+	xdev->xsc_adev_list = xsc_adev_list;
+
+	adev_id = ida_alloc(&xsc_adev_ida, GFP_KERNEL);
+	if (adev_id < 0) {
+		ret = adev_id;
+		goto err_free_adev_list;
+	}
+	xdev->adev_id = adev_id;
+
+	ret = xsc_reg_adev(xdev, XSC_ADEV_IDX_ETH);
+	if (ret)
+		goto err_dalloc_adev_id;
+
+	return 0;
+err_dalloc_adev_id:
+	ida_free(&xsc_adev_ida, xdev->adev_id);
+err_free_adev_list:
+	kfree(xsc_adev_list);
+
+	return ret;
+}
+
+void xsc_adev_uninit(struct xsc_core_device *xdev)
+{
+	xsc_unreg_adev(xdev, XSC_ADEV_IDX_ETH);
+	ida_free(&xsc_adev_ida, xdev->adev_id);
+	kfree(xdev->xsc_adev_list);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/adev.h b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
new file mode 100644
index 000000000..7515c85a6
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_ADEV_H
+#define __XSC_ADEV_H
+
+#include "common/xsc_core.h"
+
+int xsc_adev_init(struct xsc_core_device *xdev);
+void xsc_adev_uninit(struct xsc_core_device *xdev);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index febbca244..1ebf366dc 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -10,6 +10,7 @@
 #include "cq.h"
 #include "eq.h"
 #include "pci_irq.h"
+#include "adev.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -215,7 +216,15 @@ static int xsc_load(struct xsc_core_device *xdev)
 		goto err_hw_cleanup;
 	}
 
+	err = xsc_adev_init(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_adev_init failed %d\n", err);
+		goto err_irq_eq_destroy;
+	}
+
 	return 0;
+err_irq_eq_destroy:
+	xsc_irq_eq_destroy(xdev);
 err_hw_cleanup:
 	xsc_hw_cleanup(xdev);
 err_out:
@@ -224,6 +233,7 @@ static int xsc_load(struct xsc_core_device *xdev)
 
 static void xsc_unload(struct xsc_core_device *xdev)
 {
+	xsc_adev_uninit(xdev);
 	xsc_irq_eq_destroy(xdev);
 	xsc_hw_cleanup(xdev);
 }
-- 
2.43.0

