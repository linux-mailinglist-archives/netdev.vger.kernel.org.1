Return-Path: <netdev+bounces-195399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A0ACFFFB
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC53AF9C9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48FE286D64;
	Fri,  6 Jun 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="TEopzsgN"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-34.ptr.blmpb.com (sg-1-34.ptr.blmpb.com [118.26.132.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE78286D56
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204124; cv=none; b=uNB0S69c05MwRQp+/b9vQrAqPQGRtN+yoyklC2rvXocUYFrSYQDEFddFxqadc9QJekBmJ2yx8HlXCAMEWQysbtq3vmj4DXiGalKuwHs34ZBcAgDk2JbNyyxSsCPPZ2IADfjTS2uQRZsHtl/e/qpORse7DpAgMUpznAE8IZ1OFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204124; c=relaxed/simple;
	bh=Lj6jthBiWmZdoYWVsQQGDrVzhO1/EFUG+CI4BhbCTQI=;
	h=In-Reply-To:Cc:From:Subject:Message-Id:To:References:Content-Type:
	 Mime-Version:Date; b=fQQSUUN9DuayDpSSYhiBFWKnQ6V8/QP+vOY+YzedlEilx4t+YfThf+kKLDZfxJDx78jQ/YTLCh/16ONrL/xmnpxO/szHZtuvDdUmKD9gBW9IQ8lmwwG1PScum9FKKq4ZdLvjuF9yDPx2ol0R0AtjBj9HLccr0YVskRTokrWSp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=TEopzsgN; arc=none smtp.client-ip=118.26.132.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749204114; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QzUYWl+kPhDCZwIl/qiIBiSp40fFl8rLNCqkIRpaWws=;
 b=TEopzsgNW7Ol8yXF9Cf54qvbHkpiAMwr34t1a44buxPU5WkZ7tryGmGHrt57MvUay+RqvV
 xbCn6oJZVCtcMXQopJpjkjjUMohMmcZZaZkXIArvgauOsbLYomWvkjzyQICOD1c5uljKqN
 dJR0jkGICviuHEkK20oqe+5Rdzzv6XHaciiGMQdLwojDXV2j0tq+nQokUIj3oz7GZ2MGy+
 HzJmpQh9+/Qq1jRsvUQofygYwPRH7agO2ECAKGb7H5x74++kNC2XvSRHaNtEaW6WGABmDJ
 k/e7u3VqTVjcTy/hV8wVcoahYJyEw7CRgtTDGF4F81WvWS5avgXM7YDMYUVPAg==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
In-Reply-To: <20250606100132.3272115-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH net-next v12 07/14] xsc: Init auxiliary device
Message-Id: <20250606100149.3272115-8-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26842bc90+9e5932+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
References: <20250606100132.3272115-1-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 06 Jun 2025 18:01:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Date: Fri, 06 Jun 2025 18:01:51 +0800

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

