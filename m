Return-Path: <netdev+bounces-216848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B39B3580E
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EA417BCAC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BB304BBD;
	Tue, 26 Aug 2025 09:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C41E30274D;
	Tue, 26 Aug 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199187; cv=none; b=YkXjETMUhFyrV8fqSrGo/UvApKSHMjbs2Tc+qjq6G9tOT3xR40jq0x9LAb8u7t2x0J4FxBUVJnpL0nhaH/SezaxHxv0L4Ppw+8dwKFVk1zKZLbJ6oKKcrQ2D0X6GdgGzBYX9BOuml41d0FtrIHFzIttJJ6/dB10xqwMAtqCwE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199187; c=relaxed/simple;
	bh=BWgJBpucXj+VfbGK3U/fVcwbqXq4goYZr16I9jeQPGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMgo2KZlEYu3mO3VqoHJZIOdLSUF4dypwxxmn9UmIgIwjTaK4279SGrvTJG+BHj/9uDzItEPo7B1C8jL1ltSADpl+Gqf6/NIy9gcgUFaSaC5/PkFjY+rUHaBV5vtC287lBj2GPz5lRvRHE6KRzTUr5RKdRco/KZiO31SFMLIOvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cB1qj2ttHzPqS4;
	Tue, 26 Aug 2025 17:01:37 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8645F1400CD;
	Tue, 26 Aug 2025 17:06:13 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 17:06:12 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v01 02/12] hinic3: HW management interfaces
Date: Tue, 26 Aug 2025 17:05:44 +0800
Message-ID: <fd4109a250ec65c93a541c3b4088fe265c74cd7f.1756195078.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756195078.git.zhuyikai1@h-partners.com>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Initialize hardware management config of irq, aeq and ceq.
These will send hardware messages to driver.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 129 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  11 ++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 +++
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   2 +
 7 files changed, 168 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 2a0ed8e2c63e..a9f055cfef52 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -14,6 +14,7 @@ hinic3-objs := hinic3_cmdq.o \
 	       hinic3_lld.o \
 	       hinic3_main.o \
 	       hinic3_mbox.o \
+	       hinic3_mgmt.o \
 	       hinic3_netdev_ops.o \
 	       hinic3_nic_cfg.o \
 	       hinic3_nic_io.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 0599fc4f3fb0..e7ef450c4971 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,6 +8,135 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u16 intr_num = hwif->attr.num_irqs;
+	struct hinic3_irq_info *irq_info;
+	u16 intr_needed;
+
+	if (!intr_num) {
+		dev_err(hwdev->dev, "Irq num cfg in fw is zero, msix_flex_en %d\n",
+			hwif->attr.msix_flex_en);
+		return -EFAULT;
+	}
+
+	intr_needed = hwif->attr.msix_flex_en ? (hwif->attr.num_aeqs +
+		      hwif->attr.num_ceqs + hwif->attr.num_sq) : intr_num;
+	if (intr_needed > intr_num) {
+		dev_warn(hwdev->dev, "Irq num cfg %d is less than the needed irq num %d msix_flex_en %d\n",
+			 intr_num, intr_needed, hwdev->hwif->attr.msix_flex_en);
+		intr_needed = intr_num;
+	}
+
+	irq_info = &cfg_mgmt->irq_info;
+	irq_info->irq = kcalloc(intr_num, sizeof(struct hinic3_irq),
+				GFP_KERNEL);
+	if (!irq_info->irq)
+		return -ENOMEM;
+
+	irq_info->num_irq_hw = intr_needed;
+	mutex_init(&irq_info->irq_mutex);
+
+	return 0;
+}
+
+static int hinic3_init_irq_alloc_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_irq *irq = cfg_mgmt->irq_info.irq;
+	u16 nreq = cfg_mgmt->irq_info.num_irq_hw;
+	struct pci_dev *pdev = hwdev->pdev;
+	struct msix_entry *msix_entries;
+	int actual_irq;
+	u16 i;
+
+	if (!nreq) {
+		dev_err(hwdev->dev, "Number of interrupts must not be zero\n");
+		return -EINVAL;
+	}
+	msix_entries = kcalloc(nreq, sizeof(*msix_entries), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < nreq; i++)
+		msix_entries[i].entry = i;
+
+	actual_irq = pci_enable_msix_range(pdev, msix_entries, 2, nreq);
+	if (actual_irq < 0) {
+		dev_err(hwdev->dev, "Alloc msix entries with threshold 2 failed. actual_irq: %d\n",
+			actual_irq);
+		kfree(msix_entries);
+		return -ENOMEM;
+	}
+
+	nreq = actual_irq;
+	cfg_mgmt->irq_info.num_irq = nreq;
+
+	for (i = 0; i < nreq; ++i) {
+		irq[i].msix_entry_idx = msix_entries[i].entry;
+		irq[i].irq_id = msix_entries[i].vector;
+		irq[i].allocated = false;
+	}
+
+	kfree(msix_entries);
+
+	return 0;
+}
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt;
+	int err;
+
+	if (!hwdev->hwif->attr.num_ceqs) {
+		dev_err(hwdev->dev, "Ceq num cfg in fw is zero\n");
+		return -EINVAL;
+	}
+
+	cfg_mgmt = kzalloc(sizeof(*cfg_mgmt), GFP_KERNEL);
+	if (!cfg_mgmt)
+		return -ENOMEM;
+
+	hwdev->cfg_mgmt = cfg_mgmt;
+
+	err = hinic3_init_irq_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hinic3_irq_mgmt_info, err: %d\n",
+			err);
+		goto err_free_cfg_mgmt;
+	}
+
+	err = hinic3_init_irq_alloc_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hinic3_irq_info, err: %d\n",
+			err);
+		goto err_free_irq_info;
+	}
+
+	return 0;
+
+err_free_irq_info:
+	kfree(cfg_mgmt->irq_info.irq);
+	cfg_mgmt->irq_info.irq = NULL;
+
+err_free_cfg_mgmt:
+	kfree(cfg_mgmt);
+
+	return err;
+}
+
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+
+	pci_disable_msix(hwdev->pdev);
+	kfree(cfg_mgmt->irq_info.irq);
+	cfg_mgmt->irq_info.irq = NULL;
+	kfree(cfg_mgmt);
+}
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct msix_entry *alloc_arr, u16 *act_num)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index e017b1ae9f05..5978cbd56fb2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -42,6 +42,9 @@ struct hinic3_cfg_mgmt_info {
 	struct hinic3_dev_cap  cap;
 };
 
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev);
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev);
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct msix_entry *alloc_arr, u16 *act_num);
 void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index d145d3b05e19..345f570abc1e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
+#include "hinic3_eqs.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
@@ -60,8 +61,17 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_free_hwif;
 	}
 
+	err = hinic3_init_cfg_mgmt(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init config mgmt\n");
+		goto err_destroy_workqueue;
+	}
+
 	return 0;
 
+err_destroy_workqueue:
+	destroy_workqueue(hwdev->workq);
+
 err_free_hwif:
 	hinic3_free_hwif(hwdev);
 
@@ -74,6 +84,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 
 void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 {
+	hinic3_free_cfg_mgmt(hwdev);
 	destroy_workqueue(hwdev->workq);
 	hinic3_free_hwif(hwdev);
 	kfree(hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 0df6b3ae5805..3db8241a3b0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -311,6 +311,7 @@ static void hinic3_func_uninit(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
 
+	hinic3_flush_mgmt_workq(pci_adapter->hwdev);
 	hinic3_detach_aux_devices(pci_adapter->hwdev);
 	hinic3_free_hwdev(pci_adapter->hwdev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
new file mode 100644
index 000000000000..c38d10cd7fac
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include "hinic3_eqs.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev)
+{
+	if (hwdev->aeqs)
+		flush_workqueue(hwdev->aeqs->workq);
+}
+
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				  u8 size)
+{
+	if (MBOX_MSG_HEADER_GET(*(__force __le64 *)header, SOURCE) ==
+				MBOX_MSG_FROM_MBOX)
+		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
index 4edabeb32112..bbef3b32a6ec 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -9,5 +9,7 @@
 struct hinic3_hwdev;
 
 void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev,
+				  u8 *header, u8 size);
 
 #endif
-- 
2.43.0


