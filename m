Return-Path: <netdev+bounces-17681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC4752AF1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED14C281F36
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15E1F943;
	Thu, 13 Jul 2023 19:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE51F937
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D82D78
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWXbzqm9zXS4tSvlycgdHMiJxEsO/KHwPL5LV0kaK097z9iAuJyEa49N3/tXs/sMUQjI99qPlEBITkyMniFtHe3qqO/7CtRHSguvl27Z9vwMzJc7fbMbXSWf2T1+24VIf3v5zHfMGy9jXZiR5o6qndYUsBgdo1Atq9dPLgIgebgl50PcOJCaU6E1Ztf2pnz8ZmexWBg+jotLpXC9nF1MebhIG9WEHpUXaZ04PemuPOWlgYEwRj7Rwb9hTrmCKFL85rIjFqiwrh4oY2f7nl22L1FI7wJLliUMJ2BmUrMK4hXvHdINgywSzVzeKfD+2YXK4a24grlxRQ1tuMabY6YDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=CFa/SiJqQ++pxobePuGuJ7nqujHPX5b48pdyLmoAqPzBzeJ8G7rPaSL2iX+HuMULJOVvuhLd69eECki+K+opoYg3KaGkSc43K4tjg8Hm2iENsPvPhAlCvjhkGRNSGY3D9QuNCOUefJyG4VrXhcoTpj0LG4t+beDndyn7ZiZH1h5rk80OhteorNirq7e72Dg/wk7s2oFYpYTwHeJ48Hz0MXqXka/Mqn6X6b+ioRW6xzsfecmri6Z3irIhyB4h43XjwtvgkCQx7JdAvsfKWXtcH497i2JhatzIJqIjU840kcAH4b2U2W+W98Rb4q5BY/eQ/mon3vd0mVNqr9XbjQ4hnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=2TpU4K11kMrbFTOHqU6zatTEDk+B3TTJUrw3KhYeUW4lXa/zG3Hp6jEsRDlMA1ECW1LFECAd9tiT3PlC6GyAGY4+LNsNpU82ICtML7pjK+8oVe+f4Wukx44CB+VrDNEZh3iflLDfJI9f0XbSguCftUyuidPRMJ+OQrpQF4L9/VE=
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 19:30:00 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::ef) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 19:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:30:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:29:58 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 3/5] ionic: extract common bits from ionic_probe
Date: Thu, 13 Jul 2023 12:29:34 -0700
Message-ID: <20230713192936.45152-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713192936.45152-1-shannon.nelson@amd.com>
References: <20230713192936.45152-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d992bf9-9aeb-49de-deb0-08db83d78c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6KyM2SNlm72ZWnWpW/7VNGuI1/l6O7FOa13R3OsZasJfEKmvd98yZHD3a7S9UTbArWZnVlY6eU9LAfCtzBrhXxbP+CL63+07+hKYyu6ppOyuqSINjDQiDIlciCXZuKV31YhxUMWR+wvdY6l9PklsIEPXUMY6dzNl/jbW0q2/df39FOps5Qgrm9Hm8pf35ZhE8x4l7n7PxKN8dF6G0CzUnw1fKG/LWn/JVBT42IFseDmZ0VHxo3nfAgrJTcKosc0LMAucrSpiYX332EN6hmViItuHf8ntjQpHf8XqlNF6iDTM/36uSIeUC3prPIRY322ab0f4/5UjBdYz+BJAQMqqr4DNELS6knWEMQBOVJ0ZOMSdxacxOnBHRHt5cgmIZsqWy6ku8GMj6/ut2vfIHnOwrgMkawEZ+h4GozCdqxcdVtcGKLjY9XLXArb042lWYWTar6zuXlucEzyXhWgFBs8nUT2tREWO4WcBhvpgrnWZb+He4iS2Y15pGlFIiGN6dZ2T/lDR5IE1JnoQspZnvHZVL6hGdcGVSzNJ2XQkUZdGK8acL2FPyfBfbaymnxJs1q50mWRREY/eQqtApbWW0wgFTqEPwBykzAVKrziwgQ4dvDc5NiJoyw+5WJphwb54phM54sLm4dDjhQyA4HO3YYIAJLBDcjYjrgLLAM7TEJKmpQv7vs1oQ2iVpgi7gAs52gvPTMeLGHQSiaSUIQJG9SZbpL3v8LMEsGXnJSSDALnk+HX/SSFrJS+yPZe2vr5fQMJb86ilv3nZIDaIyOuu/53l4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(8676002)(8936002)(36860700001)(47076005)(83380400001)(426003)(36756003)(2616005)(2906002)(81166007)(82740400003)(356005)(86362001)(82310400005)(40480700001)(26005)(5660300002)(44832011)(1076003)(186003)(336012)(16526019)(316002)(6666004)(70206006)(70586007)(4326008)(41300700001)(478600001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:30:00.2165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d992bf9-9aeb-49de-deb0-08db83d78c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some chunks of code from ionic_probe() that will
be common in rebuild paths.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 85 +++++++++++--------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 2bc3cab3967d..b141a29177df 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -220,30 +220,12 @@ static void ionic_clear_pci(struct ionic *ionic)
 	pci_disable_device(ionic->pdev);
 }
 
-static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int ionic_setup_one(struct ionic *ionic)
 {
-	struct device *dev = &pdev->dev;
-	struct ionic *ionic;
-	int num_vfs;
+	struct pci_dev *pdev = ionic->pdev;
+	struct device *dev = ionic->dev;
 	int err;
 
-	ionic = ionic_devlink_alloc(dev);
-	if (!ionic)
-		return -ENOMEM;
-
-	ionic->pdev = pdev;
-	ionic->dev = dev;
-	pci_set_drvdata(pdev, ionic);
-	mutex_init(&ionic->dev_cmd_lock);
-
-	/* Query system for DMA addressing limitation for the device. */
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
-	if (err) {
-		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
-			err);
-		goto err_out_clear_drvdata;
-	}
-
 	ionic_debugfs_add_dev(ionic);
 
 	/* Setup PCI device */
@@ -258,7 +240,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
 		goto err_out_clear_pci;
 	}
-
 	pcie_print_link_status(pdev);
 
 	err = ionic_map_bars(ionic);
@@ -286,24 +267,64 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_teardown;
 	}
 
-	/* Configure the ports */
+	/* Configure the port */
 	err = ionic_port_identify(ionic);
 	if (err) {
 		dev_err(dev, "Cannot identify port: %d, aborting\n", err);
-		goto err_out_reset;
+		goto err_out_teardown;
 	}
 
 	err = ionic_port_init(ionic);
 	if (err) {
 		dev_err(dev, "Cannot init port: %d, aborting\n", err);
-		goto err_out_reset;
+		goto err_out_teardown;
 	}
 
+	return 0;
+
+err_out_teardown:
+	ionic_dev_teardown(ionic);
+err_out_clear_pci:
+	ionic_clear_pci(ionic);
+err_out_debugfs_del_dev:
+	ionic_debugfs_del_dev(ionic);
+
+	return err;
+}
+
+static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct ionic *ionic;
+	int num_vfs;
+	int err;
+
+	ionic = ionic_devlink_alloc(dev);
+	if (!ionic)
+		return -ENOMEM;
+
+	ionic->pdev = pdev;
+	ionic->dev = dev;
+	pci_set_drvdata(pdev, ionic);
+	mutex_init(&ionic->dev_cmd_lock);
+
+	/* Query system for DMA addressing limitation for the device. */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
+	if (err) {
+		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
+			err);
+		goto err_out;
+	}
+
+	err = ionic_setup_one(ionic);
+	if (err)
+		goto err_out;
+
 	/* Allocate and init the LIF */
 	err = ionic_lif_size(ionic);
 	if (err) {
 		dev_err(dev, "Cannot size LIF: %d, aborting\n", err);
-		goto err_out_port_reset;
+		goto err_out_pci;
 	}
 
 	err = ionic_lif_alloc(ionic);
@@ -354,17 +375,9 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic->lif = NULL;
 err_out_free_irqs:
 	ionic_bus_free_irq_vectors(ionic);
-err_out_port_reset:
-	ionic_port_reset(ionic);
-err_out_reset:
-	ionic_reset(ionic);
-err_out_teardown:
-	ionic_dev_teardown(ionic);
-err_out_clear_pci:
+err_out_pci:
 	ionic_clear_pci(ionic);
-err_out_debugfs_del_dev:
-	ionic_debugfs_del_dev(ionic);
-err_out_clear_drvdata:
+err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
 
-- 
2.17.1


