Return-Path: <netdev+bounces-17684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECB752AFB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D3281EF8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25668214E5;
	Thu, 13 Jul 2023 19:30:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AA20FB7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5F30C0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSnkqNelBmHr4h/m1v4KwlOm0R1JUCEvOfQoGF40pC1hGHqZ/pAegWBW9gZRNnIygY16SSN2oFlfcjYBEsqD8tn0bs0aRPL+nLMu3Z/066jtlt84009hVT1AMpriBRMxZ/0GsQaR7N672C6V1SYFkvCEp3gDqhD812GdWdpE8JX07dvQXxyg6mCUcueSIk7s1wemL34c7z0gmJfTLPrDT/2efFlt36g+9HkvPlgbrFjoot8/BjcFwOLT9IEL1ybH7WcXhJYAUOTKrLdaZpznj2GVdIqKLeash9c4qtRxMj8y/Qpff1ozHmjH9zGcSkTvk4pzrXSRs3Vmx09sF6A2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p69culPUvzbyPeOVzWaL6Zyka4UZbEMtewwAIyNc0Bg=;
 b=SdmkmzslmejG6A+foLCIWjo51zGBpNcmpXO+Ide1BmVPxigN83aQgkjo/hlpu2tPf55I1c/7KNXUNqpnfopgk2k4tlFdPf4P1BDIgtcjfy6BT+719777ChBznDP90HRqldVzROfexX1qL4DdcrF2zV0XRhYfKVQrrwYF9eKw11XDAHaN3af0bZ5KFVckoQaOMmkF5UAFmZo+kNVnvV043Ezfu0BPsv4kfMZSdXGbKizZDup1U1bw0x8jsw5AwrvLb2gMdk9S8pOJjzhwCjQXK2jGKom8vmp8Qzd2GpIkC8bK9ixZLBqzR2PiPZchtCTsML5oNkEJCXTizY7gEFkRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p69culPUvzbyPeOVzWaL6Zyka4UZbEMtewwAIyNc0Bg=;
 b=kiT49Pxk8TU+YgnB0LquShQsh012WPIVfuMRmho96RQslXJZm+L+lW94bM0nWy1wkpAs3uMdsAhBPuEc8cGxtLnSimLPQxIeW6cYYuZXUXBeoWPkNXJfZOIYzq4PcOeklKIowsPZLJDI7t+xT85FS4T1bOCE+Aw8mGeJLcf5ak4=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 19:30:02 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::da) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 14:29:59 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 4/5] ionic: pull out common bits from fw_up
Date: Thu, 13 Jul 2023 12:29:35 -0700
Message-ID: <20230713192936.45152-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 044571d9-f182-43d1-2688-08db83d78cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a/540iKtRXQgQ3sqVd5PKQyE66A1ZJYOymPVBwwN5RvnmQvwmsH6HLQha+Fy9Mxmx0sHZritqztr0Z6voq0b8uaypoRtiO7cbt/7s4S3WSHuxexcl8eNXPt6c+fMCjW4a3jdH4BaSotjK603BaMVtaP2UgrJbyN2x3sbu62WCJ9y7EC1rQ3h/Z1Ac4eE0rCJYzXI2mRwlxx1YNIc/peYgFmUQ2J4ECvLcSOwIknRjc+qN8pmsYMNzH9Iybf7dhewbG2Cx394YL2ycY7mClVHeZV6gilxBWfLrrrzz7ddcgjTxgLmh6AFutHoSL134wZ3FPNEC10RLe7xpOSZsxdOtzpHYGUtsPUUaydygbWLEkOPOU42WHr9birWzpnVOrNgvUxa5L/yunmo+QzDcVa66Lq7wSFEVeiYbH2Cket6YYaZ/58Y2bUL5/RSMA4EZdVsS7wqI4h0hus5WpZAxqJTceZyzfZsDQkEOK65QYRvs61G0ExdqTzl57p6djp2auSjomk/XiXY54dGoYPMf0M5fvtZ5WMLOAZaPYppbXejcmdX20dooDKbCk+WS38P60nBF/09HZ/SsnSqhv90NVZSX/FVOzHeU58W3tWKQuNx+QRetcPcttgSjVTedbpSuLVFulAxTqkb1ghqPA0ABnLGMFRBlkf5ndBjrpjrjdZcymEzlk0PSC9ztKF9MxYMcMgmGHd5LP1bWSLhTM9Z6IQCDRx5xGj0uZcCTxL21AVhudvUUV7LAwGhb4L0T+VeUQdv34x1FFeO8vBZYpBm8E2/1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(16526019)(81166007)(356005)(82740400003)(83380400001)(426003)(47076005)(186003)(336012)(2616005)(26005)(40480700001)(1076003)(36860700001)(5660300002)(40460700003)(86362001)(8676002)(8936002)(36756003)(44832011)(478600001)(54906003)(6666004)(110136005)(70206006)(41300700001)(316002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:30:00.9352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044571d9-f182-43d1-2688-08db83d78cfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some code from ionic_lif_handle_fw_up() that can be
used in the coming FLR recovery patch.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 66 ++++++++++++-------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7c20a44e549b..57ab25b9108e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3271,27 +3271,11 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
 	dev_info(ionic->dev, "FW Down: LIFs stopped\n");
 }
 
-static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
+static int ionic_restart_lif(struct ionic_lif *lif)
 {
 	struct ionic *ionic = lif->ionic;
 	int err;
 
-	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
-		return;
-
-	dev_info(ionic->dev, "FW Up: restarting LIFs\n");
-
-	ionic_init_devinfo(ionic);
-	err = ionic_identify(ionic);
-	if (err)
-		goto err_out;
-	err = ionic_port_identify(ionic);
-	if (err)
-		goto err_out;
-	err = ionic_port_init(ionic);
-	if (err)
-		goto err_out;
-
 	mutex_lock(&lif->queue_lock);
 
 	if (test_and_clear_bit(IONIC_LIF_F_BROKEN, lif->state))
@@ -3322,17 +3306,13 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 			goto err_txrx_free;
 	}
 
+	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	mutex_unlock(&lif->queue_lock);
 
-	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	ionic_link_status_check_request(lif, CAN_SLEEP);
 	netif_device_attach(lif->netdev);
-	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
 
-	/* restore the hardware timestamping queues */
-	ionic_lif_hwstamp_replay(lif);
-
-	return;
+	return 0;
 
 err_txrx_free:
 	ionic_txrx_free(lif);
@@ -3342,6 +3322,46 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	ionic_qcqs_free(lif);
 err_unlock:
 	mutex_unlock(&lif->queue_lock);
+
+	return err;
+}
+
+static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		return;
+
+	dev_info(ionic->dev, "FW Up: restarting LIFs\n");
+
+	/* This is a little different from what happens at
+	 * probe time because the LIF already exists so we
+	 * just need to reanimate it.
+	 */
+	ionic_init_devinfo(ionic);
+	err = ionic_identify(ionic);
+	if (err)
+		goto err_out;
+	err = ionic_port_identify(ionic);
+	if (err)
+		goto err_out;
+	err = ionic_port_init(ionic);
+	if (err)
+		goto err_out;
+
+	err = ionic_restart_lif(lif);
+	if (err)
+		goto err_out;
+
+	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
+
+	/* restore the hardware timestamping queues */
+	ionic_lif_hwstamp_replay(lif);
+
+	return;
+
 err_out:
 	dev_err(ionic->dev, "FW Up: LIFs restart failed - err %d\n", err);
 }
-- 
2.17.1


