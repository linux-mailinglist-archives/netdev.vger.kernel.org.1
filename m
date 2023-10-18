Return-Path: <netdev+bounces-42276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FB7CE054
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A07EB21179
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67562E3E2;
	Wed, 18 Oct 2023 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mkUNtpAE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A9341B7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:46:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDD94
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTFfXON8glX7uTfT9zdtAA2qRc6QJcNQvQYdf2S3vdoGv1yNbc0zUOlGWS1shwrhUt9FcMPASwZ1+0qiuFnb3b3fkekAcTE0j5Gi9H71LzJSWLmwlmJxwbm7aJ6wACmzC6XXxmPBtpU4dQXSk9vp9f8aXE3MPL/3Xhfyxcw56F3zen/iBhCNE075/q0jns1jQLsdk8wMtyFv1ZyrhTj6y7hQ0on4JYI6rfNga+vqSygGHJTfGNxLqu1K9W5RAyZs30rASrs86yZDBneChlaPZhZHbEfDRVjRGQ4I1DciU4c43kwSMbRKVF2r9vyh45/Ksr8fsNY/ds0FA/Qfrs3Q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxniuD0slPsyUyPVkvCA4/jwesBiALivEzRDhKmQ+6s=;
 b=RhoZPGgh9Hd4bfEPdCwGXzJ9XuJZsTezCfIlrtZOAkZ7udBNFyfoKeJYS54VFf4svNnnDCRrAqkKGvOr97slk1bYs+ngAQ9CIo6hWVSRTofoMKt6t8G2VwSse/ERnzPu25WvMA3tWmRw62hSiuLZMNr7aSzJrg86EBmZrclb4IKFx7+AzHPsxJEARowgA+/1UCgzateNptDiIH0CVw1YeRfvDgQq23hcqTbjfNDqfvHLheFeDz7ozPNK8GR3HGoxTmCMbizzU5qeXO7JWSv+ZtU4EvqHOkFJHgOnWCFFM1o4HabR2zrPMQDEglpKlYflOLRnH4QEImBUMVroLz7JEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxniuD0slPsyUyPVkvCA4/jwesBiALivEzRDhKmQ+6s=;
 b=mkUNtpAEDrj5hQPJwFdPiJVWlc56W7rk9strfil0GD+RrNcawD67HhmV1MNrOOoH6z9aOVZZzLNt1Pt2Iiq+ZBpT8q2kIEgv1gOWI8wVPucrmFdeWqS7o5rZvp5Ti3LS2Kdjdpo3cnKr/w1bhiU2674x22qVUU7IplcpIz1vqCg=
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 14:46:18 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::18) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 14:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Wed, 18 Oct 2023 14:46:17 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 09:46:14 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: [PATCH net-next 2/2] amd-xgbe: Add support for AMD Crater ethernet device
Date: Wed, 18 Oct 2023 20:14:50 +0530
Message-ID: <20231018144450.2061125-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
References: <20231018144450.2061125-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed4f338-99be-47e9-b082-08dbcfe8fca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	caQ3tP25kSF/gqHLRoU8cLdGeWIdm8UZ3RHVGGt3Lr2fcpjGSjYa0qhlaCVC6aIRuQmOPOG092HWAWkplxqOOcQ5hq5RQTVc6WCnv9u/plAwSm9Lg3bQsI+8rTa8pNw2lsL21MDwp1RVYTwXDz80JNxbzIz5mI2enQ9TpGPhJotqNwHU6S0RuBthoVeGv/G4az/pWzsHFY45YQjmbxpUh+yZH1k5QurR9AL2cn/3IhGv+xgNR73eMMMDWJ2Eh4qSRVNF7fDh6tQgEKx60Dy1tiDqOZsZf6Qu0UBrWnTV4HRsZsoyt8voMXRafLTQD9I/dJS4qJYAPZPyYpH3RZRT0GS5wRkZ8Am6GMeqsZOWAAabLAbANP6rCXoQHr0F9GW40gX+V6AKiYAmMBZILN5gJJA/UxepFQKaEca8AlU0xcQRljZLX/uk3J89k63KQLP4Ln52oKPk6QcEhihFd6e56Y2NbwsJbN1ABM9aut94oMSYhcgKo6dztJx1vJknD/KJrXHjzE38pgwYy2VIxrtWK3nxjU097ZsH8QqdlbxtjgtkCBzEAgRSnAfayRJXzPO0EOm8be3G1QVIi74AL4fwtBk6BZrZm8o7eWDgykZO+lm8IN+tlkyMy1wq+23Kna0hODPvcdwRDnlT3Tf8XGE4kBUfUphfLxhFvSe3vWx48zcTsE6XnYPzQ0DHnW1OPafyIp6uXoHBapklVInuiWNuQrMxNQB/WQfTsFavtHqjnHphfcspimTVrHU753QmBbCd5H8+HAJja8NjWG4IzljREw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(40480700001)(36756003)(2616005)(81166007)(1076003)(316002)(2906002)(86362001)(6916009)(70206006)(41300700001)(54906003)(5660300002)(4326008)(8676002)(8936002)(70586007)(478600001)(7696005)(6666004)(336012)(426003)(356005)(26005)(16526019)(82740400003)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:46:17.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed4f338-99be-47e9-b082-08dbcfe8fca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The AMD Crater device has new window settings for the XPCS access, add
support to adopt to the new window settings. There is a hardware bug
where in the BAR1 registers cannot be accessed directly. As a fallback
mechanism, access these PCS registers through indirect access via SMN.

Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 32 +++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++++
 4 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 3b70f6737633..e1f70f0528ef 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -900,6 +900,11 @@
 #define PCS_V2_RV_WINDOW_SELECT		0x1064
 #define PCS_V2_YC_WINDOW_DEF		0x18060
 #define PCS_V2_YC_WINDOW_SELECT		0x18064
+#define PCS_V2_RN_WINDOW_DEF		0xF8078
+#define PCS_V2_RN_WINDOW_SELECT		0xF807c
+
+#define PCS_RN_SMN_BASE_ADDR		0x11E00000
+#define PCS_RN_PORT_ADDR_SIZE		0x100000
 
 /* PCS register entry bit positions and sizes */
 #define PCS_V2_WINDOW_DEF_OFFSET_INDEX	6
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..da8ec218282f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1176,8 +1176,17 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
-	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
-	mmd_data = XPCS16_IOREAD(pdata, offset);
+	if (pdata->vdata->is_crater) {
+		amd_smn_write(0,
+			      (pdata->xphy_base + pdata->xpcs_window_sel_reg),
+			      index);
+		amd_smn_read(0, pdata->xphy_base + offset, &mmd_data);
+		mmd_data = (offset % ALIGNMENT_VAL) ?
+			   ((mmd_data >> 16) & 0xffff) : (mmd_data & 0xffff);
+	} else {
+		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
+		mmd_data = XPCS16_IOREAD(pdata, offset);
+	}
 	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
 
 	return mmd_data;
@@ -1186,8 +1195,8 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				   int mmd_reg, int mmd_data)
 {
+	unsigned int mmd_address, index, offset, crtr_mmd_data;
 	unsigned long flags;
-	unsigned int mmd_address, index, offset;
 
 	if (mmd_reg & XGBE_ADDR_C45)
 		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
@@ -1208,8 +1217,22 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
-	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
-	XPCS16_IOWRITE(pdata, offset, mmd_data);
+	if (pdata->vdata->is_crater) {
+		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);
+		amd_smn_read(0, pdata->xphy_base + offset, &crtr_mmd_data);
+		if (offset % ALIGNMENT_VAL) {
+			crtr_mmd_data &= ~GENMASK(31, 16);
+			crtr_mmd_data |=  (mmd_data << 16);
+		} else {
+			crtr_mmd_data &= ~GENMASK(15, 0);
+			crtr_mmd_data |=  (mmd_data);
+		}
+		amd_smn_write(0, (pdata->xphy_base + pdata->xpcs_window_sel_reg), index);
+		amd_smn_write(0, (pdata->xphy_base + offset), crtr_mmd_data);
+	} else {
+		XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
+		XPCS16_IOWRITE(pdata, offset, mmd_data);
+	}
 	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
 }
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index a17359d43b45..90ad520d3c29 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -279,15 +279,21 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
 	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
+		   ((rdev->device == 0x14b5) || (rdev->device == 0x1630))) {
+		/* Yellow Carp and Crater devices
+		 * do not need cdr workaround and RRC
+		 */
 		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
 		pdata->vdata->enable_rrc = 0;
+
+		if (rdev->device == 0x1630) {
+			pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
+			pdata->vdata->is_crater = true;
+		} else {
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
@@ -295,7 +301,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_dev_put(rdev);
 
 	/* Configure the PCS indirect addressing support */
-	reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	if (pdata->vdata->is_crater) {
+		reg = XP_IOREAD(pdata, XP_PROP_0);
+		pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
+				   (PCS_RN_PORT_ADDR_SIZE *
+				    XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
+		if (netif_msg_probe(pdata))
+			dev_dbg(dev, "xphy_base = %#08x\n", pdata->xphy_base);
+		amd_smn_read(0, pdata->xphy_base + (pdata->xpcs_window_def_reg), &reg);
+	} else {
+		reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
+	}
 	pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
 	pdata->xpcs_window <<= 6;
 	pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index ad136ed493ed..a161fac35643 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -133,6 +133,7 @@
 #include <linux/dcache.h>
 #include <linux/ethtool.h>
 #include <linux/list.h>
+#include <asm/amd_nb.h>
 
 #define XGBE_DRV_NAME		"amd-xgbe"
 #define XGBE_DRV_DESC		"AMD 10 Gigabit Ethernet Driver"
@@ -305,6 +306,9 @@
 /* MDIO port types */
 #define XGMAC_MAX_C22_PORT		3
 
+ /* offset alignment */
+#define ALIGNMENT_VAL			4
+
 /* Link mode bit operations */
 #define XGBE_ZERO_SUP(_ls)		\
 	ethtool_link_ksettings_zero_link_mode((_ls), supported)
@@ -1046,6 +1050,7 @@ struct xgbe_version_data {
 	unsigned int rx_desc_prefetch;
 	unsigned int an_cdr_workaround;
 	unsigned int enable_rrc;
+	bool is_crater;
 };
 
 struct xgbe_prv_data {
@@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int xphy_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.25.1


