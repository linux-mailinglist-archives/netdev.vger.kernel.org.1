Return-Path: <netdev+bounces-16989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D311174FC0F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860EC2817D6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674B393;
	Wed, 12 Jul 2023 00:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E238F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81650171F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJMy8NkBpbl3BbjsJR+1mveFxUcNUUcRsDyoRaU+K64ElRXPkH7DHbkwSGPV2nImsl95tLmNz/4A/Jz/MyntBwA7bQRUCnzd3hGc7kDHaf2vw014SSHr5unkk5gdVUY8x8C3JZCnbLAd4wf2H/Nq4I/mcT4336txPDngVXkWfl8SzkLyF0mY8XUILQ2Q4SEBMDFM7KyRmnoFX1zfSudMZEv4XjZyk7RUDkvErssV3Yx/XX7KVxql1zIBlkoL57mOCcxXKnlDTbS1e4/bAsBK8O7dfVlf3gW4sf7/ICNxt4WbHVSfoyEgRDClD+hkacFjhfnK9XKbZMyD6WaC9AB9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=Lto2JUFi6vzmm1x+NC9L5hT48hu3kX6TWt8kkL91DDlsCYNAAoji02jZ3woe7zVDG34ZIHi4RKu4q3VbZm+/lo6u5QBmVcSFIXeqiJPkD3ZrxUfAwt02sere5kiMvaNrEXlEaec7tDpDw+EIAZGBasLKjH1JxpM58Qot3RhzQEGO3db6vVRkGAHoXnsCNsFAusoUaLQTD6ihP7Nn8aRKAhXwanuMQnP9uZZ3zMAZ1bvbvpXRArA53kLGyI7nljzXAtKPWbNKbZgMM+tDRktUFbwzthzJ6T5d4MNTmI9gE4MpLJBcXuCI3SG7eC3iW5R+1xOZkPgRqu2ZRrkVMrIj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=pZwKk43ORnK/qzEy4rZdry5W16VBkuKDis3ibFgRamkWmgpytYJS+lqh6LAm1D6rNzIJ3/yQkOGhjnjyt8xSWvnxO1llzgEDMULL8A07EdsQXMNfDbPYtlGroOp8pyZPcSWEWu6pQ/NvwWiOxS3B4ZpYtap7D4pUXSwkp/xjoGs=
Received: from BN1PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:e1::8)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 00:20:48 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ff) by BN1PR12CA0003.outlook.office365.com
 (2603:10b6:408:e1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:46 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/5] ionic: extract common bits from ionic_remove
Date: Tue, 11 Jul 2023 17:20:22 -0700
Message-ID: <20230712002025.24444-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230712002025.24444-1-shannon.nelson@amd.com>
References: <20230712002025.24444-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f287ad-62c6-480e-24ef-08db826dd733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fZrGIfVeyjB9gBY1rjYBP1OoOGPA8slpDA/TF1CE2Bq+tPHsRxFEbFwFuOr31unQ0nzxPQWOc4BDpb4bz75QbIov4G5dNXM738jQyWCxbS0dwsqcF470I6a34xyr8AZvMQXtq0zcZaUl0YTQNDsO5WkF7rOx+xw2VU+SjC6RtMSB9pV906uQPa0K+TuJeJ8AO5fChVHkPxIEe3r4qer4UOLUXYaHubsHbDIKfSLGt+lnZD3rDM3gj50qNDWbTnNJD6bJkiZdxMFTST0q8L2vwN3iicZdufAz11ScOzY1nfRlf9bHtoqtYQsO2dyqZ8QNXH6v3ehfKcqrYkQun3vS5/FXaGcxzSKt51EeUFT+JIM1aR4bFiOUaGp+aYWLDClB8NsKkxPKz6bi48kcj36E7agd4RQY9d1nZL+SxpW3Qmxtg9XjfwffsZTeBj7aNYnlbrI1y1tIeConr559npS7WncoiK6AM31YVLIP7vvpr4degetpqQ3R57oB+dGZZQzAx8HEnpSZ8wJlFuNJDche/diFFOTRAZEoZznlKp0OM1D5qauyCetectaF8s15z/7WSqP6/454L/do1IRR+NXDPLgGfgqtL8wGOqYe0DTIuw4f0QU90N0YklxHAPoJpf2iWE8FuERC4GPy/lbKlNL2hHAZHeukC9hnaDVHTw/jQ481bx85462ozfr3v+D0a5kTocPapORrCcmXRFB89ykkvP8Xf0Y5uprf1McRx32yWF84HPZDI3KGO7peCMxEU0JQd5qpuoJQI/5wtwPRCgZDrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(82310400005)(8676002)(8936002)(186003)(16526019)(36860700001)(336012)(36756003)(47076005)(426003)(2906002)(2616005)(5660300002)(44832011)(1076003)(26005)(40480700001)(356005)(82740400003)(81166007)(6666004)(54906003)(110136005)(70206006)(70586007)(83380400001)(4326008)(478600001)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:47.6087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f287ad-62c6-480e-24ef-08db826dd733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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


