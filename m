Return-Path: <netdev+bounces-18366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C77569C8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C7328185B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC61FD5;
	Mon, 17 Jul 2023 17:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6C1FAD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:01:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87EAE1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNUT9XJCcngHuSfuWcyEFAiKXSmLCbpGx8Gd4lnRu11XA0bCfqcAGFIHlNSg/2fes2J06PuWnfsOIirz+YwMcnGhemSSnyUR5arAlEvtGD3IroTBKYoAdAXKLRngs9sb+ic2jkIyqZrAhTG3rOHo3wKHKBE7mZX4k4PcFCgpaqieUJcXOorcRlMRqmAW8jCOrOO+p4b81pubimaM3r+t/HzT8leaG7dn32x+l+s3K4fhgnhyxtXMGjUFr65sXklWtjezd2aBp3sOQ52Nt6jK8M9hT7GzIdI7qbm/IBrZ1/MYR/bA/EaMFWDBeKYEmSBDEs42dKB1JtnMk8JwwFrtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=DEgcAOOxJAiYT1mBLnMlVFpCarP+/me/t2sejYJgumSKUpmJsnvk6/caFlbKG0+v85uChq5NHXpXEco5NQ3l+EXiN0mH8LslvtzIUhhIhKRr8XtCA1k/GIdLBzBzxILcp+RLFqxGW0ZrXM/J9rho5pPcdC64CHs8z5LsykfHH6Bcr7cVh1bs5XZGqMFrPyBmONOY/m06p4b1CIFjWcQbbV803kv0cROmqlZgv+Js95uPIamXcGExlFIrLlrnl0iyKWbG+W1W0vwDQ7q748s2GUL96hlVGiccPQZvuEB+E5Deuo0ULuMnCRxBtl2ZiOCrl6HOGYF8m6SFibdQXI83JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=YyWTbhV+TjMedyloM9kEJE/Up1PdWgkAC4FvHipwhgB5SEZMcdIzAMrfWiAo4blae+na7P/4VuxxHJzize71OxAas+J929BDnq6ANEWYrNLiDoNbYWuIMEDr4PHTKAsMz4NzEH53LNpNp1VVgKKqbjRSraE8NFxyuepb4M+tJ/Q=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 17:01:14 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::19) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 17:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 17:01:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 12:01:12 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3  net-next 1/4] ionic: extract common bits from ionic_remove
Date: Mon, 17 Jul 2023 09:59:58 -0700
Message-ID: <20230717170001.30539-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717170001.30539-1-shannon.nelson@amd.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4d5f28-b5c1-4725-bc17-08db86e76dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k3jExCByA6mXkI+M7F4vO3ZsPy2xraZYG+2lDY7YBFrBZ08Oe5N4dMe3/+PsDs4AMh7lN3SnXF7YIYbrBE7MAQqhuqxsjtfvfQ5AsF68DToOIGPTXdEmVsRWHKbQ0kMHSEY5j+3LemIuA9733Q3pUcy7fWggIMIefam//LHiij5MwNx8Uh0+OWWAuziWBmc1wJo9x/dj4k37b//59vD+hbp/W6qgkVCb3xpeV8a62eNSX0AwIHWkDdSSSxVa0x/aIe3nXpoMseTx5XeWYPt4VIg/qKVSznDCsT2kCMld5DTFJheE25jXmXjTILbzgzBe2P3wz22UWda5Uitrx/b5jrh33veP8FwoVRT64c2OPSGkx7EcxCDZ/CV8a77pFiyrmxJXgmO/5QpbpbcWZfV0iteKHKvSChoz8f8BYc9cwVAxsxKpB3A0u2t7sHAIx0SCYUFhIIg58WeGNQ14FMmDOgrPHEVzBWdhUHmh0ek5S3uDf7CO7JZAzpx+OPBqlCcxQkyi3LDHd6JGxYAgvxGe7oxmJg36gThaSy9u/KMuq4NawFlx5M2gDMKZ/prRbtkGZ4APsSB/B07sM5zt9c0sKEE4brDrIO4dXUGbOe8s1EJNe1tdUFuxPS3cF89NudfxgXQ+j7Eg4nja7T47H/2zkqORjKH0/g/nORVKiYlf4SgRX1/SegKUTRCcI2bO0TTwc1rbbLiqmEW4VyXAcbJQSoduXEoV9pbMNpd4d9lhkREQkWdt0Y2B4Bw7m6+Y2QjLBQb2csm5pBFsr1pEBico24Wrntanc1o50EB8ayL7rol7PqSrCUx2F6W1F2nl72T9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(110136005)(478600001)(6666004)(54906003)(186003)(1076003)(26005)(16526019)(2906002)(44832011)(41300700001)(70206006)(4326008)(316002)(5660300002)(8676002)(8936002)(70586007)(81166007)(356005)(82740400003)(86362001)(36756003)(40460700003)(36860700001)(426003)(336012)(47076005)(2616005)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:01:13.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4d5f28-b5c1-4725-bc17-08db86e76dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out a chunk of code from ionic_remove() that will
be common in teardown paths.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index ab7d217b98b3..2bc3cab3967d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -213,6 +213,13 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return ret;
 }
 
+static void ionic_clear_pci(struct ionic *ionic)
+{
+	ionic_unmap_bars(ionic);
+	pci_release_regions(ionic->pdev);
+	pci_disable_device(ionic->pdev);
+}
+
 static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
@@ -249,20 +256,20 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = pci_request_regions(pdev, IONIC_DRV_NAME);
 	if (err) {
 		dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
-		goto err_out_pci_disable_device;
+		goto err_out_clear_pci;
 	}
 
 	pcie_print_link_status(pdev);
 
 	err = ionic_map_bars(ionic);
 	if (err)
-		goto err_out_pci_release_regions;
+		goto err_out_clear_pci;
 
 	/* Configure the device */
 	err = ionic_setup(ionic);
 	if (err) {
 		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
-		goto err_out_unmap_bars;
+		goto err_out_clear_pci;
 	}
 	pci_set_master(pdev);
 
@@ -353,12 +360,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
-err_out_unmap_bars:
-	ionic_unmap_bars(ionic);
-err_out_pci_release_regions:
-	pci_release_regions(pdev);
-err_out_pci_disable_device:
-	pci_disable_device(pdev);
+err_out_clear_pci:
+	ionic_clear_pci(ionic);
 err_out_debugfs_del_dev:
 	ionic_debugfs_del_dev(ionic);
 err_out_clear_drvdata:
@@ -386,9 +389,7 @@ static void ionic_remove(struct pci_dev *pdev)
 	ionic_port_reset(ionic);
 	ionic_reset(ionic);
 	ionic_dev_teardown(ionic);
-	ionic_unmap_bars(ionic);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
+	ionic_clear_pci(ionic);
 	ionic_debugfs_del_dev(ionic);
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
-- 
2.17.1


