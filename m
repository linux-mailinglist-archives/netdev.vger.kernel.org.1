Return-Path: <netdev+bounces-33987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E689B7A110D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EAE1C20E01
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3DAC2F7;
	Thu, 14 Sep 2023 22:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DFCA76
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:32:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6026B7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtA4ylDzeECpZ49oJO53AMyrRvrPx9UIiGTEcwpS+uNq4qWhvANTavfdRqyqjOoCPDON9byTPO5GyDr5oVMJLC9Y5dWRuJjL5HGQk+7h1FxvB5XzwmhYYbKk6bmxQI5eJdVoQqMZop/C0H5KKKC+KL8uL2Em6mzSv5IFhsK3Hrw6+6XPvGDPUJ3zDES39KR42VhmzQX8FfOhKBqQVzQQclyF8RShBNhxOkwBbHauKOyGE3CQW/AAoS+GrHgH5TbUy99Od0hW1Xhsy7pY5q3ePnYdQP0CYvxMXdYK2t9bmQ6kMMHFBM86fw+E7Hiez8RQmpO0yUSENj+pby7nMFRZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsFLkyKKWzJA6kvqLDP9796tMoqIXXWF4K5SAc24fKg=;
 b=hip8apVSP6S1dsD30yalVL4Bc+Nvrdiuoq1lQxISHJdD9zeZzIbANmgFoFcdpI7SRwLW/J/iL7c61GOzrd5sadKmK+z/t+IdiWjdb/+wBW8lBbestK3A4nKBpxeWTNJJ9jOVZiBeAV1i52OiZ4A6xlo361JBaq7orNfJkC2xxSpoQvQUFPxFHW3uZ3VLCskdRkrkPAyFoQWXYeFPB5eXBAJdkxl0IpEW/hTlpSouKk52GptE9A7Se81oBnRZumY5+omIPJXAdErxJEQyfWe0yUiaphHKCPXVEC/+NHAFMh73HMINUNWFwPKolT5LHcVQAneZGuvCnUb2gTKzuaU5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsFLkyKKWzJA6kvqLDP9796tMoqIXXWF4K5SAc24fKg=;
 b=UJ7XCo9rO4BlH6mQdmr9Q69X1R4IVDyQc3inpbTW41AVv4pbWWFS6J4SkhYmYLKwwYnZ/nyoUlgOPGiNghjNDtZdaYWWnle+V2/HUaTUtJv0DczVwoCoBgZN1s0JMvoXfyuP/PfXl5p+R9JkXin7tvIIESyjQ2Xoo2Wng4nNgqI=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 22:32:35 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::cc) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 22:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 22:32:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:32:34 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 4/4] pds_core: add attempts to fix broken PCI
Date: Thu, 14 Sep 2023 15:32:00 -0700
Message-ID: <20230914223200.65533-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230914223200.65533-1-shannon.nelson@amd.com>
References: <20230914223200.65533-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 669825c8-b13d-4e5d-b5b0-08dbb5727e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JKdONJco7BRGufFDaJoU3pMJuojk84q6DLBIcIZg8eN6UPuGeb2TWi7kIbB8jYrxd+rV1jwOISf2qj+K6LoIwIn6IbQqeWjAwqNTQ8Kn3ZtfWkfYK0AIv2JwZ5QakMie1fjH+Xey4lCL1m+rwWMgRhYDI1QpasuDPlFVzATCyQ9JpyUU7fFW4UICD4+oXsnucVIeXDFNnoUqKGx6FOXBKZXG23D4WPG3nADpZaoPWEC9zb794XrzKlkEL3a7MXYI9yeEZ60mFtCf/ofOPjHYJkL3O9OWUBuSMn4P1/8NVBoeSneph9VFlcQW7qAxiVc0bD6TEhOtrpu5G2eiFaGJv4dJm0fN1RZfqUpfifA0zC1lR6cNdIkZ4fGtbahP+jxx1HIc0ROlw7kSWDM7+mCp9meEiyigEig05oYbrMrtrvWV5Woladyb/6aT3/+XJKQhtDNFa0qOV2n1BQ/xGKT6NTdmA5Lvxzll3Ne2JdswMPZmLk4T6NRDd32Laif78gttzzUuSPLXmUQx5bgDmH/7UGoI7fsQNvcFMZ8ZCfLV1GOWD2FbpH2KMCBepRFYphF/r1AnFWXknI+IiRd6pS9+Mwd8xSkpD+iHiafISe7+RgmXItIuQIZJ27igcOPF9hMLowt5viRl5uOKFPm+LE7onfp1pPnCVF/VqoQ8V6CnvAQqCtd4fWtAF57+UJRtWZCM9V2e0akW14z4PkFi+GJO4IxO/YxsBdKwOQ6kp2AAXngZkn2rMd2/bfZo+ZdXVGUd7qfjrbqNBpcdcT6guLssCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(82740400003)(6666004)(356005)(2616005)(40460700003)(26005)(16526019)(8676002)(1076003)(2906002)(44832011)(8936002)(5660300002)(4326008)(41300700001)(86362001)(110136005)(36756003)(316002)(70206006)(70586007)(81166007)(478600001)(83380400001)(47076005)(36860700001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:32:35.0820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669825c8-b13d-4e5d-b5b0-08dbb5727e38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

If we see a 0xff value from a PCI register read, we know that
the PCI connection is broken, possibly by a low level reset that
didn't go through the nice pci_error_handlers path.

Make use of the PCI cleanup code that we already have from the
reset handlers and add some detection and attempted recovery
from a broken PCI connection.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 14 ++++++++++++++
 drivers/net/ethernet/amd/pds_core/core.h |  3 +++
 drivers/net/ethernet/amd/pds_core/main.c |  4 ++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index c1b6b5f7c0b5..2a8643e167e1 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -578,6 +578,18 @@ void pdsc_fw_up(struct pdsc *pdsc)
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_RECOVERY);
 }
 
+static void pdsc_check_pci_health(struct pdsc *pdsc)
+{
+	u8 fw_status = ioread8(&pdsc->info_regs->fw_status);
+
+	/* is PCI broken? */
+	if (fw_status != PDS_RC_BAD_PCI)
+		return;
+
+	pdsc_reset_prepare(pdsc->pdev);
+	pdsc_reset_done(pdsc->pdev);
+}
+
 void pdsc_health_thread(struct work_struct *work)
 {
 	struct pdsc *pdsc = container_of(work, struct pdsc, health_work);
@@ -604,6 +616,8 @@ void pdsc_health_thread(struct work_struct *work)
 			pdsc_fw_down(pdsc);
 	}
 
+	pdsc_check_pci_health(pdsc);
+
 	pdsc->fw_generation = pdsc->fw_status & PDS_CORE_FW_STS_F_GENERATION;
 
 out_unlock:
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 19c1957167da..f3a7deda9972 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -283,6 +283,9 @@ int pdsc_devcmd_reset(struct pdsc *pdsc);
 int pdsc_dev_reinit(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
 
+void pdsc_reset_prepare(struct pci_dev *pdev);
+void pdsc_reset_done(struct pci_dev *pdev);
+
 int pdsc_intr_alloc(struct pdsc *pdsc, char *name,
 		    irq_handler_t handler, void *data);
 void pdsc_intr_free(struct pdsc *pdsc, int index);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 4c7f982c12a1..3080898d7b95 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -445,7 +445,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 	devlink_free(dl);
 }
 
-static void pdsc_reset_prepare(struct pci_dev *pdev)
+void pdsc_reset_prepare(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 
@@ -457,7 +457,7 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static void pdsc_reset_done(struct pci_dev *pdev)
+void pdsc_reset_done(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 	struct device *dev = pdsc->dev;
-- 
2.17.1


