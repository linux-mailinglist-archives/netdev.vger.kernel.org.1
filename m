Return-Path: <netdev+bounces-14686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5A7431C7
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0831C20AF8
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544D1C3F;
	Fri, 30 Jun 2023 00:36:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FA1C27
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:36:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A4183
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNGZyONClVY67CI6aiXaCaGGGSCJU9sdcfad+kVc0GqopRigp42/zXgjGC+W+qTbQ7tS+LyS0vCwm/f0mjhv16MFpk3cLCluUtZuiyen4ug12WU1WgDfNk2llXRrsixhy+3yi6ZkGinkJJ00g+ivavyq1IQI2m4dnhVfHor2RBGHxMfGbSexwMn7F7c98Ro0V6S5gJ07U7OhdQs62NgqW2dEHjGG+eMUbZzYxv9itUZWRd1EzCcxloltAKGVSB+ZsnxGGNCF3MARWnZ2Wn5WIJMQtXWZMsRFJkheFY9G5BsPORQUz27H69Y7zjwmDN9GQQnklXIq2fV3rI139Gk3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLekv9iUTh4QHuNZdGx32XzBN7KDA7YlrtIEG02xfmE=;
 b=KgLxXJZDcRYWKi4XTnnoJ9sgrkKmE+wXqRcI9GeFaF7GrgaNPoHS9YWOXacT41Z/cq2u+ZnTjxv9c2O7Coki/RxgvByBvk5SLjs2PjDuVOOmr/dA0N14UC/LO+GfpR5U4y3sUHztOXJwFHLLNkDhCTzaD1z7dxezHcn8JMFFSAZPVs+UKgZZawyA0Dy3uFkEAdG9SphT7LOEwt7ZcaYEkFBsRLBoh4fw4DR+WJ4Of5U383nSiILQ38Zhsm2nTBgfUm3ln5aWaNiTYK4KP5vlXGD6WhkHbuDEcmpAA1zEmN3Zh5R6czayBclqvOUK3/5msRCqkvWgQVvCwMVozAIxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLekv9iUTh4QHuNZdGx32XzBN7KDA7YlrtIEG02xfmE=;
 b=5csq5/3EYqPFyY94oVs3qRfE/gbDwydnA80FwoGcwVuNpFtA7znlT5+PkJrjJ0TWsXLtJpJFPO1G44cN2Czlh1+looJEa3kK9a1EoMwItS1jupLd5ATk4MNqNjOOUGhFaeFaLiP9Yn3Ll1Q80GTSSeaylDeY9oIctRKSLcrX07M=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 00:36:44 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::8c) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 00:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.33 via Frontend Transport; Fri, 30 Jun 2023 00:36:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:36:41 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>, Allen Hubbe <allen.hubbe@amd.com>
Subject: [PATCH virtio 4/4] pds_vdpa: alloc irq vectors on DRIVER_OK
Date: Thu, 29 Jun 2023 17:36:09 -0700
Message-ID: <20230630003609.28527-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630003609.28527-1-shannon.nelson@amd.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CH0PR12MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dd5afb-b53d-4fd6-d2dd-08db790213d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SeYNblKLLZL7QYPJvpG72gk/rb4fugMNrDYXTah6W7GDwfLF3LbLZEJrgaAMU5E7+nMOCrdun3XJMZvxQscW9HLZhoSJ6OZ4flRr1A00uPkFR3Q4s6UgLCmRA77WwVKRg7n0Ib6KfO36nDHn6S6Qt4a6cQHiTQifkjkcIeWbubfavDZxpnXvCLnNi7Sj4hB0BPMIfgAEfhP6JPaj8us9GYuh3oMnQjfab2tJtKpmLsv2O/7tcS+TH6CkkOIAPhP3Ev0k45/4F58g9+qvLQrY9M6l+q9sqYeYzd4rSYdmy69m9/cQRR81F5utrYZrQUbmU+HwO9GnKAFZ8gEGeCALYZuaMUlzdAmra2rFfxIzdFm3fz/+ABuCMvVkK3p7Tt1Ah4hKTadCCYYWR1QSQCZwyxV0dm/naoxDfSLf25ZpTdOTq8mYpashG8WlUT4l2fNJw/DjE9nZSzD9obbL+OwhNpTVzrg+6LCMGuWMKvnCFlXLfjOH6rhngB3FwfonRWchXQxrsWQyFRbz0bbeGY3p6Scef6g27kOtH2rRBWa1JtPOgUQftluEURNtm5mlLMnQdTYmDzyvY91Bmh7rk7msS+MSKDfOVRPh9Di1LCNedHqq9I2HT9R6krq10rxHWkG8PcYANzIrjD56dv9B04NG/scMSONptvxFHQtXOj4aHl7fMTSCUrG9nd/tHWfHM/PQaMjHV6FNyy2Y2PQ8AmwVpdj5scl98ROX3apftYXdZcrXXWpFiclVXo9eDHTUpfoOCSG78T+S8yTd3d79NfCx6A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(316002)(70206006)(8936002)(70586007)(186003)(426003)(41300700001)(16526019)(336012)(4326008)(1076003)(26005)(6666004)(2616005)(54906003)(110136005)(40460700003)(82310400005)(44832011)(5660300002)(2906002)(40480700001)(81166007)(478600001)(356005)(36756003)(86362001)(36860700001)(82740400003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:36:43.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd5afb-b53d-4fd6-d2dd-08db790213d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Allen Hubbe <allen.hubbe@amd.com>

We were allocating irq vectors at the time the aux dev was probed,
but that is before the PCI VF is assigned to a separate iommu domain
by vhost_vdpa.  Because vhost_vdpa later changes the iommu domain the
interrupts do not work.

Instead, we can allocate the irq vectors later when we see DRIVER_OK and
know that the reassignment of the PCI VF to an iommu domain has already
happened.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 110 ++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 29 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 5e1046c9af3d..6c337f7a0f06 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -126,11 +126,9 @@ static void pds_vdpa_release_irq(struct pds_vdpa_device *pdsv, int qid)
 static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool ready)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
-	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
 	struct device *dev = &pdsv->vdpa_dev.dev;
 	u64 driver_features;
 	u16 invert_idx = 0;
-	int irq;
 	int err;
 
 	dev_dbg(dev, "%s: qid %d ready %d => %d\n",
@@ -143,19 +141,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		invert_idx = PDS_VDPA_PACKED_INVERT_IDX;
 
 	if (ready) {
-		irq = pci_irq_vector(pdev, qid);
-		snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].irq_name),
-			 "vdpa-%s-%d", dev_name(dev), qid);
-
-		err = request_irq(irq, pds_vdpa_isr, 0,
-				  pdsv->vqs[qid].irq_name, &pdsv->vqs[qid]);
-		if (err) {
-			dev_err(dev, "%s: no irq for qid %d: %pe\n",
-				__func__, qid, ERR_PTR(err));
-			return;
-		}
-		pdsv->vqs[qid].irq = irq;
-
 		/* Pass vq setup info to DSC using adminq to gather up and
 		 * send all info at once so FW can do its full set up in
 		 * one easy operation
@@ -164,7 +149,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		if (err) {
 			dev_err(dev, "Failed to init vq %d: %pe\n",
 				qid, ERR_PTR(err));
-			pds_vdpa_release_irq(pdsv, qid);
 			ready = false;
 		}
 	} else {
@@ -172,7 +156,6 @@ static void pds_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid, bool re
 		if (err)
 			dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 				__func__, qid, ERR_PTR(err));
-		pds_vdpa_release_irq(pdsv, qid);
 	}
 
 	pdsv->vqs[qid].ready = ready;
@@ -396,6 +379,72 @@ static u8 pds_vdpa_get_status(struct vdpa_device *vdpa_dev)
 	return vp_modern_get_status(&pdsv->vdpa_aux->vd_mdev);
 }
 
+static int pds_vdpa_request_irqs(struct pds_vdpa_device *pdsv)
+{
+	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
+	struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
+	struct device *dev = &pdsv->vdpa_dev.dev;
+	int max_vq, nintrs, qid, err;
+
+	max_vq = vdpa_aux->vdpa_mdev.max_supported_vqs;
+
+	nintrs = pci_alloc_irq_vectors(pdev, max_vq, max_vq, PCI_IRQ_MSIX);
+	if (nintrs < 0) {
+		dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
+			max_vq, ERR_PTR(nintrs));
+		return nintrs;
+	}
+
+	for (qid = 0; qid < pdsv->num_vqs; ++qid) {
+		int irq = pci_irq_vector(pdev, qid);
+
+		snprintf(pdsv->vqs[qid].irq_name, sizeof(pdsv->vqs[qid].irq_name),
+			 "vdpa-%s-%d", dev_name(dev), qid);
+
+		err = request_irq(irq, pds_vdpa_isr, 0,
+				  pdsv->vqs[qid].irq_name,
+				  &pdsv->vqs[qid]);
+		if (err) {
+			dev_err(dev, "%s: no irq for qid %d: %pe\n",
+				__func__, qid, ERR_PTR(err));
+			goto err_release;
+		}
+
+		pdsv->vqs[qid].irq = irq;
+	}
+
+	vdpa_aux->nintrs = nintrs;
+
+	return 0;
+
+err_release:
+	while (qid--)
+		pds_vdpa_release_irq(pdsv, qid);
+
+	pci_free_irq_vectors(pdev);
+
+	vdpa_aux->nintrs = 0;
+
+	return err;
+}
+
+static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
+{
+	struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
+	struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
+	int qid;
+
+	if (!vdpa_aux->nintrs)
+		return;
+
+	for (qid = 0; qid < pdsv->num_vqs; qid++)
+		pds_vdpa_release_irq(pdsv, qid);
+
+	pci_free_irq_vectors(pdev);
+
+	vdpa_aux->nintrs = 0;
+}
+
 static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
@@ -406,6 +455,11 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	old_status = pds_vdpa_get_status(vdpa_dev);
 	dev_dbg(dev, "%s: old %#x new %#x\n", __func__, old_status, status);
 
+	if (status & ~old_status & VIRTIO_CONFIG_S_DRIVER_OK) {
+		if (pds_vdpa_request_irqs(pdsv))
+			status = old_status | VIRTIO_CONFIG_S_FAILED;
+	}
+
 	pds_vdpa_cmd_set_status(pdsv, status);
 
 	/* Note: still working with FW on the need for this reset cmd */
@@ -427,6 +481,9 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 							i, &pdsv->vqs[i].notify_pa);
 		}
 	}
+
+	if (old_status & ~status & VIRTIO_CONFIG_S_DRIVER_OK)
+		pds_vdpa_release_irqs(pdsv);
 }
 
 static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qid)
@@ -462,13 +519,17 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 			if (err)
 				dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 					__func__, i, ERR_PTR(err));
-			pds_vdpa_release_irq(pdsv, i);
-			pds_vdpa_init_vqs_entry(pdsv, i);
 		}
 	}
 
 	pds_vdpa_set_status(vdpa_dev, 0);
 
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+		/* Reset the vq info */
+		for (i = 0; i < pdsv->num_vqs && !err; i++)
+			pds_vdpa_init_vqs_entry(pdsv, i);
+	}
+
 	return 0;
 }
 
@@ -761,7 +822,7 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
 
 	max_vqs = min_t(u16, dev_intrs, max_vqs);
 	mgmt->max_supported_vqs = min_t(u16, PDS_VDPA_MAX_QUEUES, max_vqs);
-	vdpa_aux->nintrs = mgmt->max_supported_vqs;
+	vdpa_aux->nintrs = 0;
 
 	mgmt->ops = &pds_vdpa_mgmt_dev_ops;
 	mgmt->id_table = pds_vdpa_id_table;
@@ -775,14 +836,5 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
 
-	err = pci_alloc_irq_vectors(pdev, vdpa_aux->nintrs, vdpa_aux->nintrs,
-				    PCI_IRQ_MSIX);
-	if (err < 0) {
-		dev_err(dev, "Couldn't get %d msix vectors: %pe\n",
-			vdpa_aux->nintrs, ERR_PTR(err));
-		return err;
-	}
-	vdpa_aux->nintrs = err;
-
 	return 0;
 }
-- 
2.17.1


