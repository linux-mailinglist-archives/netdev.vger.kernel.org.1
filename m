Return-Path: <netdev+bounces-226766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C8BA4EA6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337FD3B257E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B827B331;
	Fri, 26 Sep 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5tuwHLb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC419CD1B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912336; cv=none; b=QhhZErTr1wJy1AV0ru6NPShWUfQ88zd0ldI/btPBv5iwvnQe07n7shZF4UC92QV+5LMa0LJ2ijvumR92Sl2gMwt/Wv06O80A409MPJGtxHDMY4G+9o3uKiVG+obQ9k3wcW/lblCLfXwZ7oct5LlEEMbmAnUkTybPl9xZ89doWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912336; c=relaxed/simple;
	bh=Qn3dKHpLNKvEuHaXefHzfNlFAZYIwti/Y+04qxDydM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufUImKX3MJVYo9W0p5tgPUZxYtVzGIkpOHye7CzOEV4aULU5ZmbSGfVQic9EAHi5iM2SmNGpjSAeW69sR8Lby1x9FTvAJPzs5vUaUMP5mai2W3sEKNPqDMCpTKe8fDlB81ziiftuAqWBF5uN0QK+h1e2ArHelx5qUw/KqBeLeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5tuwHLb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758912335; x=1790448335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qn3dKHpLNKvEuHaXefHzfNlFAZYIwti/Y+04qxDydM4=;
  b=b5tuwHLb+fNpfM8LTmYX8wA1a9mamEH5rz9nCj0kZwFzkYO0zJJifvYl
   fhmElkt2Ys747B4FMOatid61brzYfIk4ZqCMfF3/bfHhqNw/ghZxo4/P2
   Lh0Hjb997qM/7BARaAiH7mFIX65M0bZl1rkwJTyBA8z4vaco8HKSGsKvg
   Bu2MuMHx8gyGnZfkmW+O/wZhl69ZLw7n0689REbnmcsmQ/QdCa/gwoAlE
   aLNKwgrEJ63urOl5kOf9fAg8TAClzhYM8kwA4aD2smZc0kjh+rV5UFx3A
   ilomYVTiTwRkCBI/zVFdoWyOQSXPcCA15GPbR2l/WBi2uP+kJn3L2H2qR
   w==;
X-CSE-ConnectionGUID: gioZvIzGShe9lNVwR2tb+Q==
X-CSE-MsgGUID: M7IzKjinSGaAIzSnY+3FeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="71935984"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="71935984"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 11:45:34 -0700
X-CSE-ConnectionGUID: B2/Gn5ZOSFy5/FH4hWbuWg==
X-CSE-MsgGUID: Nywi0fwyRfC1kqy3opj2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="214825821"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Sep 2025 11:45:33 -0700
From: Madhu Chittim <madhu.chittim@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com
Subject: [PATCH iwl-next v5] idpf: add support for IDPF PCI programming interface
Date: Fri, 26 Sep 2025 11:45:33 -0700
Message-ID: <20250926184533.1872683-1-madhu.chittim@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
on our current generation hardware. Future hardware exposes a new set of
device IDs for each generation. To avoid adding a new device ID for each
generation and to make the driver forward and backward compatible,
make use of the IDPF PCI programming interface to load the driver.

Write and read the VF_ARQBAL mailbox register to find if the current
device is a PF or a VF.

PCI SIG allocated a new programming interface for the IDPF compliant
ethernet network controller devices. It can be found at:
https://members.pcisig.com/wg/PCI-SIG/document/20113
with the document titled as 'PCI Code and ID Assignment Revision 1.16'
or any latest revisions.

Tested this patch by doing a simple driver load/unload on Intel IPU E2000
hardware which supports 0x1452 and 0x145C device IDs and new hardware
which supports the IDPF PCI programming interface.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
---
v5:
- Removed use of resource_set_range
- ioremap only the register which we would like write and read back
- Renamed function from idpf_is_vf_device to idpf_get_device_type and
  moved it idpf_main.c as it is not specific to VF
- idpf_get_device_type now returns device type

v4:
- add testing info
- use resource_size_t instead of long
- add error statement for ioremap failure

v3:
- reworked logic to avoid gotos

v2:
- replace *u8 with *bool in idpf_is_vf_device function parameter
- use ~0 instead of 0xffffff in PCI_DEVICE_CLASS parameter

 drivers/net/ethernet/intel/idpf/idpf.h      |   1 +
 drivers/net/ethernet/intel/idpf/idpf_main.c | 105 ++++++++++++++++----
 2 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 8cfc68cbfa06..bdabea45e81f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -1005,6 +1005,7 @@ void idpf_mbx_task(struct work_struct *work);
 void idpf_vc_event_task(struct work_struct *work);
 void idpf_dev_ops_init(struct idpf_adapter *adapter);
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
+int idpf_get_device_type(struct pci_dev *pdev);
 int idpf_intr_req(struct idpf_adapter *adapter);
 void idpf_intr_rel(struct idpf_adapter *adapter);
 u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 8c46481d2e1f..f1af7dadf179 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -3,15 +3,93 @@
 
 #include "idpf.h"
 #include "idpf_devids.h"
+#include "idpf_lan_vf_regs.h"
 #include "idpf_virtchnl.h"
 
 #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
 
+#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
+#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
+	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
+#define IDPF_VF_TEST_VAL		0xfeed0000u
+
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS("LIBETH");
 MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_LICENSE("GPL");
 
+/**
+ * idpf_get_device_type - Helper to find if it is a VF or PF device
+ * @pdev: PCI device information struct
+ *
+ * Return: PF/VF or -%errno on failure.
+ */
+int idpf_get_device_type(struct pci_dev *pdev)
+{
+	void __iomem *addr;
+	int ret;
+
+	addr = ioremap(pci_resource_start(pdev, 0) + VF_ARQBAL, 4);
+	if (!addr) {
+		pci_err(pdev, "Failed to allocate BAR0 mbx region\n");
+		return -EIO;
+	}
+
+	writel(IDPF_VF_TEST_VAL, addr);
+	if (readl(addr) == IDPF_VF_TEST_VAL)
+		ret = IDPF_DEV_ID_VF;
+	else
+		ret = IDPF_DEV_ID_PF;
+
+	iounmap(addr);
+
+	return ret;
+}
+
+/**
+ * idpf_dev_init - Initialize device specific parameters
+ * @adapter: adapter to initialize
+ * @ent: entry in idpf_pci_tbl
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+static int idpf_dev_init(struct idpf_adapter *adapter,
+			 const struct pci_device_id *ent)
+{
+	int ret;
+
+	if (ent->class == IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
+		ret = idpf_get_device_type(adapter->pdev);
+		switch (ret) {
+		case IDPF_DEV_ID_VF:
+			idpf_vf_dev_ops_init(adapter);
+			adapter->crc_enable = true;
+			break;
+		case IDPF_DEV_ID_PF:
+			idpf_dev_ops_init(adapter);
+			break;
+		default:
+			return ret;
+		}
+
+		return 0;
+	}
+
+	switch (ent->device) {
+	case IDPF_DEV_ID_PF:
+		idpf_dev_ops_init(adapter);
+		break;
+	case IDPF_DEV_ID_VF:
+		idpf_vf_dev_ops_init(adapter);
+		adapter->crc_enable = true;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /**
  * idpf_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -165,21 +243,6 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_tx_splitq = true;
 	adapter->req_rx_splitq = true;
 
-	switch (ent->device) {
-	case IDPF_DEV_ID_PF:
-		idpf_dev_ops_init(adapter);
-		break;
-	case IDPF_DEV_ID_VF:
-		idpf_vf_dev_ops_init(adapter);
-		adapter->crc_enable = true;
-		break;
-	default:
-		err = -ENODEV;
-		dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
-			ent->device);
-		goto err_free;
-	}
-
 	adapter->pdev = pdev;
 	err = pcim_enable_device(pdev);
 	if (err)
@@ -259,11 +322,18 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* setup msglvl */
 	adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
 
+	err = idpf_dev_init(adapter, ent);
+	if (err) {
+		dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
+			ent->device);
+		goto destroy_vc_event_wq;
+	}
+
 	err = idpf_cfg_hw(adapter);
 	if (err) {
 		dev_err(dev, "Failed to configure HW structure for adapter: %d\n",
 			err);
-		goto err_cfg_hw;
+		goto destroy_vc_event_wq;
 	}
 
 	mutex_init(&adapter->vport_ctrl_lock);
@@ -284,7 +354,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
-err_cfg_hw:
+destroy_vc_event_wq:
 	destroy_workqueue(adapter->vc_event_wq);
 err_vc_event_wq_alloc:
 	destroy_workqueue(adapter->stats_wq);
@@ -304,6 +374,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static const struct pci_device_id idpf_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_PF)},
 	{ PCI_VDEVICE(INTEL, IDPF_DEV_ID_VF)},
+	{ PCI_DEVICE_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF, ~0)},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(pci, idpf_pci_tbl);
-- 
2.51.0


