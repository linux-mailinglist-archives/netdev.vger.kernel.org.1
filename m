Return-Path: <netdev+bounces-16691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDAA74E5CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C319A28161B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2315492;
	Tue, 11 Jul 2023 04:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAF523A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:25:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E251A8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrAAOiU9/OXKbSTHKpVv1tsn+sC/2ktSmFKDbFJYk2QAQSm9daRjgMK2IO4AI339mHjtmBP/sSCAW69aBtANz2fUuxd0os3XFNWMwVCJKXJ8YI+iIT2mGxM1kVjtiyDsrWpHnPPqFpqOJqXs3LBBT3bqiOi4KQiWaVVkTN2THqd+NOxzlCPSOMqQuD5Ry4gU1+JR/yDf0+wA39W1ypkFwmKACF5CsNsLIxCZj+Ms9PxBFCn2zAF6bR6PWbUbnHVEeVrtPXiyzPvbym4cWH+IL4Rec8i1iDRQQIHYrwP7uJq/VUlJtvr/wY1bWyISvclthGnZ8h42kaLYqJAgvMrYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJi0nGEWwdtEfopKnzujq1SPuSE6XqRyKpb3WeiZAr4=;
 b=M7pcFcrhvaNxqzrhrn0peCysjqbjm1gbt1yJTP9JwHdjwkY35uD7anajrztkJJlI4RKdFlmORFhP3tOS5zUf5FZe/Os1GsTzV0HnS1ug0ehy1g40hs3rD6GerlOIVxBxoL4zBRYoL3bNHMe7GcSWPyxRB2v2ueUsf/fxYhn8z9HO5mAjSPMDWQgJCv5NfQOFiahY/LKcrch+5gF7ZsCyg055VjhOzQBeSN5Spl+LI7oKejHUrvT85++zt/R3ykmfb1idunUkvrsZHkH0YXqNEgRw+hCLH7QiKFYjURuRTETQE3L7R385576gORJp0d6cDo2FrfwtSpkoC8aLddTasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJi0nGEWwdtEfopKnzujq1SPuSE6XqRyKpb3WeiZAr4=;
 b=XELNd/gpJYJXu5f87tTxutyyMDV7Y7Wg6ZPxi7jtOo3Uk3WX4iHNR38YLfCt6yCH0WRBFJrUis6MiAh7CWrBiuTFxmkzeCqbeiG4tfS0a+SERpMFs8BETjUOe4VUvk6BJg9d+lTEJM0jwVQATRzhSbby+g8iawzoEaUBGc/lnrk=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 04:25:03 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::22) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 04:25:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:25:02 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH v2 virtio 3/5] pds_vdpa: clean and reset vqs entries
Date: Mon, 10 Jul 2023 21:24:35 -0700
Message-ID: <20230711042437.69381-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711042437.69381-1-shannon.nelson@amd.com>
References: <20230711042437.69381-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f899cea-7edb-49b0-be6b-08db81c6cc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9W2zJzRYw5bNe5CSzhipFWjp+cXOz8gNniwgNcf6em6lRB0yzelDJuWa5yLJx4FN6tlYaYcRdVtbpEBdSEI1iPXAntbtOou1QifeGHGYFigwWq2qgFnjvSo9CTi2PHr7lz8GQ1C6WsqtvjL+6ZPe6fnxX6D9o1/v+4Z505xQelCzlzPqQOLPv7IRAD1Y2vzjLDlWgRC6ZSsP/q1hATPe/Xu9KD/JmB8lnjsRn3AWOOtwNVn0XiyXfGF3Z9bIveVaTx9OcnHFRLyZubozQ4/9RO3G8gQ1w+EDy6t/Fdyod5B5xacE+/FS04Mjbb6MUUZ3yzk/y9N24gVcGxEp5mbTvoA6vY0Tco8ABpV0TfU8aDWTvPHRCSMvhHT7LrYLEcGCpeWEUW3awsxqULjfRrXiKRzpM+tIbmdN9bgP+HK3yro1q5GnjHU4VxS5RcnBLcMMLjlkHQ0wZH0ToYD+upVmE6hI/axiSjmXZpsHZm2Re7LWQbzAWy27JnOrD+CCZu1MyCKqNzwXhY4V6NdquGv8GgDKHoHjnKYH1kadYcXjcIUIfRfAXzBA3wgUf2zj/qY1g1fj0YLsRmKuh78vw70zuDCSAxzJ1oK035vrD2RZkMRpjkxK3xkBwpqDchIcebu2fwVP4+WvDTKZEPDCC1pB9xknbfHWut8KVO2XRSjmBqR+OajckuKUlGBuZQxYSPXqHYOsRSmnDoJrB499NNbA/ML0QzQQat+lKTB+XXAsG3XG4cehwqT1k+YlJlo8PpQkFVd0nPasXZCmeE5gA2Q7PQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(36756003)(86362001)(40480700001)(110136005)(40460700003)(81166007)(356005)(82740400003)(478600001)(6666004)(8676002)(316002)(44832011)(5660300002)(2906002)(4326008)(70586007)(70206006)(41300700001)(8936002)(2616005)(426003)(336012)(26005)(1076003)(47076005)(16526019)(186003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:03.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f899cea-7edb-49b0-be6b-08db81c6cc58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure that we initialize the vqs[] entries the same
way both for initial setup and after a vq reset.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 5b566e0eef0a..04a362648b02 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -428,6 +428,17 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	}
 }
 
+static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qid,
+				    void __iomem *notify)
+{
+	memset(&pdsv->vqs[qid], 0, sizeof(pdsv->vqs[0]));
+	pdsv->vqs[qid].qid = qid;
+	pdsv->vqs[qid].pdsv = pdsv;
+	pdsv->vqs[qid].ready = false;
+	pdsv->vqs[qid].irq = VIRTIO_MSI_NO_VECTOR;
+	pdsv->vqs[qid].notify = notify;
+}
+
 static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
@@ -450,8 +461,7 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 				dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 					__func__, i, ERR_PTR(err));
 			pds_vdpa_release_irq(pdsv, i);
-			memset(&pdsv->vqs[i], 0, sizeof(pdsv->vqs[0]));
-			pdsv->vqs[i].ready = false;
+			pds_vdpa_init_vqs_entry(pdsv, i, pdsv->vqs[i].notify);
 		}
 	}
 
@@ -640,11 +650,11 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 
 	for (i = 0; i < pdsv->num_vqs; i++) {
-		pdsv->vqs[i].qid = i;
-		pdsv->vqs[i].pdsv = pdsv;
-		pdsv->vqs[i].irq = VIRTIO_MSI_NO_VECTOR;
-		pdsv->vqs[i].notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
-							      i, &pdsv->vqs[i].notify_pa);
+		void __iomem *notify;
+
+		notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
+						 i, &pdsv->vqs[i].notify_pa);
+		pds_vdpa_init_vqs_entry(pdsv, i, notify);
 	}
 
 	pdsv->vdpa_dev.mdev = &vdpa_aux->vdpa_mdev;
-- 
2.17.1


