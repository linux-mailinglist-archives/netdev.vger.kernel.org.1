Return-Path: <netdev+bounces-33985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66D7A110A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88DE1C20DCA
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12EBC8E7;
	Thu, 14 Sep 2023 22:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D700CA6B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:32:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B42100
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+p36z+T51k4NZYGBE+HRj9Y4gpNba0pHCDlyP1KLC8PuW02U5IobmK1tSgySCfnn+Ket3/Bpi2klHDvWl/frjWnHtrOBMQmFyo6Rd4UM6EDQ/mKg6L6GgVTaTgsFi6bO8FyS11tQ1gPXUGrdKb6OokMf9zL2L0rldFIR+wTIx0KLE6IwuJdYrh/Rs/DjD/IfITcCjc8T7ZyZ2xjjgcCFyDh/xiUxlhpZznw30gDpM7I00TDs7Qz34T8f0eEQ1wclJ8rtbGtN0NAXsZU9uOu0+sNkHbKEbtbjT34vjrOIDEhv3lE4DJ361OtcTZcSHUhb3FwDBZhsuwL/0jQ+GqMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF0FybgIMdUlGftbxyCKrrkpc1FMj/RipQbVc0T5BB4=;
 b=hIX4beBGPK+RBjZEHw6izbiNAMrHtMGSe4Am+PywOEP++F3pVgZnL+pemvb6RQ8O9ohK7PvS+AhsxtaNDjE6SfbHYtE3Zy25YJUqSvOpKH3Yxquuo6pYndpz5ldP3r4RcaHbjV1y98vtDO8M3kHaYg30Wq7+L7s9zf8qq80sq6uE5jkWUYEzVaA/3Ci63vduW/374t8ahMbmwoxO+Td6JHnpKRV0tYtT361oxLdAj1SVLzk780manAHIG7oNdv3Wjii8wyOvIBsr904sGImbx2BpYHUkDwEkMYCPqSpEh1L42+dQlRzmFM2ywN4W+50IzDKDZSk6SzHU4aPM2R5pBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF0FybgIMdUlGftbxyCKrrkpc1FMj/RipQbVc0T5BB4=;
 b=xT6PEgFPMTkSsWtj3UKMcPczAuL67q4eJiO6+RWFV4KLa5n7WFamaMs/xf87btkk2CSkGPmVP9a2fH6PEgNWkfbUah0btGP8ZTMZiL50qXmXebwUDbupGEXF1MxIOnLbbdXD5ii+PC1giMIc2aUvXxchmvRV0+cq8cBkCFStkeA=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 22:32:34 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::b5) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 22:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 22:32:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:32:33 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/4] pds_core: implement pci reset handlers
Date: Thu, 14 Sep 2023 15:31:59 -0700
Message-ID: <20230914223200.65533-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: ec261ffe-9e31-48f9-308c-08dbb5727dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mJS6SWXFh2hBNyYDe1vfE7D+5upRtkUj4LkxTZzX7VNCCIzzkxDVKaqGrYccL6vrFEFqxwRWHO6vV6+0o2VEYZcQsLQ4VFLwSYLCbRdXRQTwkyzkX/sAbcuklJ9UJn/5t+zdyQ70/D4jX0r6FSi0qCfhDveSL5W9o3DasV9WQqADJf3bZtI4J9pe6gVNLCiZQ0O0r8v2S7xY44T10gC3lBhgXJdgcpix7jj02Mnkti6OBBM/1n6aL4ab4eD2g9mYqqpkY94IhUKRFBYrHXjyNsW7drHB7i5ly2CoAcZaIQ9mgVhEtmUaZQuBcUetp0xNbQ192XqS1b/jFybyv2wP3fysGMy8G7VocZ0zE2rZ1mTuG/RVVYgQNJO28ZrE9cVjm4nJ17UFOVuL2ElybnyGh6aP9TblYBGFBrTgY6kDgThfreqKp1Fin6QC5QBNhAl5s7CQr9bW2k+dV1Zvp6566kEYTNtVU/ypI2fdSXB2zTNR8gPkTqiHfAosyBahZFXSCYFQPiJHXV1dc8WjjbeGXgy1lEP0JQorchQvA2n13bUnL0m5ME5w5VKkKfwK13Q8j6q4qeyudW3TRb5PmIlI0LKlHRJwq0IBLR2OLED6kRWH4LllwS9m8yFgTSfk5i/H0aq0oaA5w2DSTRVBUzFLNDtZVc0GbcxtcxBUbKmW98VmWpMDlMm8JLlAWsWzI0UN/5i0hef5hhXWrCJ+xkysCn8B9uFvq1MBBEte7XF++HkDJuUvkcProbvpz2us5Wtdz3O0SmtEOc80d9rvTbUSMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(8676002)(110136005)(82740400003)(70586007)(41300700001)(316002)(478600001)(1076003)(81166007)(2616005)(70206006)(6666004)(83380400001)(47076005)(426003)(16526019)(356005)(86362001)(26005)(336012)(8936002)(5660300002)(4326008)(44832011)(36756003)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:32:34.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec261ffe-9e31-48f9-308c-08dbb5727dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

Implement the callbacks for a nice PCI reset.  These get called
when a user is nice enough to use the sysfs PCI reset entry, e.g.
    echo 1 > /sys/bus/pci/devices/0000:2b:00.0/reset

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 14 +++++--
 drivers/net/ethernet/amd/pds_core/core.h |  4 ++
 drivers/net/ethernet/amd/pds_core/main.c | 50 ++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 6e426202ab83..c1b6b5f7c0b5 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -515,7 +515,7 @@ void pdsc_stop(struct pdsc *pdsc)
 					   PDS_CORE_INTR_MASK_SET);
 }
 
-static void pdsc_fw_down(struct pdsc *pdsc)
+void pdsc_fw_down(struct pdsc *pdsc)
 {
 	union pds_core_notifyq_comp reset_event = {
 		.reset.ecode = cpu_to_le16(PDS_EVENT_RESET),
@@ -523,10 +523,13 @@ static void pdsc_fw_down(struct pdsc *pdsc)
 	};
 
 	if (test_and_set_bit(PDSC_S_FW_DEAD, &pdsc->state)) {
-		dev_err(pdsc->dev, "%s: already happening\n", __func__);
+		dev_warn(pdsc->dev, "%s: already happening\n", __func__);
 		return;
 	}
 
+	if (pdsc->pdev->is_virtfn)
+		return;
+
 	/* Notify clients of fw_down */
 	if (pdsc->fw_reporter)
 		devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
@@ -536,7 +539,7 @@ static void pdsc_fw_down(struct pdsc *pdsc)
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_RECOVERY);
 }
 
-static void pdsc_fw_up(struct pdsc *pdsc)
+void pdsc_fw_up(struct pdsc *pdsc)
 {
 	union pds_core_notifyq_comp reset_event = {
 		.reset.ecode = cpu_to_le16(PDS_EVENT_RESET),
@@ -549,6 +552,11 @@ static void pdsc_fw_up(struct pdsc *pdsc)
 		return;
 	}
 
+	if (pdsc->pdev->is_virtfn) {
+		clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
+		return;
+	}
+
 	err = pdsc_setup(pdsc, PDSC_SETUP_RECOVERY);
 	if (err)
 		goto err_out;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index e545fafc4819..19c1957167da 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -309,4 +309,8 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data);
 
 int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 			 struct netlink_ext_ack *extack);
+
+void pdsc_fw_down(struct pdsc *pdsc);
+void pdsc_fw_up(struct pdsc *pdsc);
+
 #endif /* _PDSC_H_ */
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 3a45bf474a19..4c7f982c12a1 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -445,12 +445,62 @@ static void pdsc_remove(struct pci_dev *pdev)
 	devlink_free(dl);
 }
 
+static void pdsc_reset_prepare(struct pci_dev *pdev)
+{
+	struct pdsc *pdsc = pci_get_drvdata(pdev);
+
+	pdsc_fw_down(pdsc);
+
+	pci_free_irq_vectors(pdev);
+	pdsc_unmap_bars(pdsc);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static void pdsc_reset_done(struct pci_dev *pdev)
+{
+	struct pdsc *pdsc = pci_get_drvdata(pdev);
+	struct device *dev = pdsc->dev;
+	int err;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device: %pe\n", ERR_PTR(err));
+		return;
+	}
+	pci_set_master(pdev);
+
+	if (!pdev->is_virtfn) {
+		pcie_print_link_status(pdsc->pdev);
+
+		err = pci_request_regions(pdsc->pdev, PDS_CORE_DRV_NAME);
+		if (err) {
+			dev_err(pdsc->dev, "Cannot request PCI regions: %pe\n",
+				ERR_PTR(err));
+			return;
+		}
+
+		err = pdsc_map_bars(pdsc);
+		if (err)
+			return;
+	}
+
+	pdsc_fw_up(pdsc);
+}
+
+static const struct pci_error_handlers pdsc_err_handler = {
+	/* FLR handling */
+	.reset_prepare      = pdsc_reset_prepare,
+	.reset_done         = pdsc_reset_done,
+};
+
 static struct pci_driver pdsc_driver = {
 	.name = PDS_CORE_DRV_NAME,
 	.id_table = pdsc_id_table,
 	.probe = pdsc_probe,
 	.remove = pdsc_remove,
 	.sriov_configure = pdsc_sriov_configure,
+	.err_handler = &pdsc_err_handler,
 };
 
 void *pdsc_get_pf_struct(struct pci_dev *vf_pdev)
-- 
2.17.1


