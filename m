Return-Path: <netdev+bounces-16689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846F74E5CB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6D1C20D9C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1E7523C;
	Tue, 11 Jul 2023 04:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBE523A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:25:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D3D1BB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvWh3E2q3xUOxTen0mTH/Ey1v7KbCbzFG23/3o4RPXTJXFVQxtix6rxobmijD7E30w5TZZm+rhqjJE3pVAJiqIO7fEBdj7bWvkpDAxlzm9y4/0VNfFW7HoAuCCFQHX2MIpT43XjVsdPmCTqNiyfPWekrno/dz7xfXfFmAj6fDnUmECKJhuDAhkLnUR+u4ZJoQtNaeRDOsj40RZ+sc0I24nz+Xy2mB6e2VrHGYWWzXxUWDImWZ5bI0WEvuhq2dNUz9BqDtmjDVbCla2imD06YlR/xrK2+EEKriBrntlkyrcfbTatsBguWQdriqr6VKQxPpoH9vGrcbi/Z/a4SGd0MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpvMCpMkjeIu2CCN75zHIRXSdRlC8h7luEfMSf6jTpk=;
 b=EGbHY0uD4UYS6p6Cj5GPKdj2P9IGMrVtoJen9vl3F0JKQHbn8iG9ciERNYUFe60ipIzWmaJNDZXyRDygwBCJncuAjxGkIXUV4v0+SGWXmDzZwsVJj8FhAgALWEYZZCjh9zzZHuzYRpbzLbfyCDhAgrNKSck5mSO0eYRK55GbIVC8PLAgt/gy7/4GDf5rBJwrOWoh+8qJ0Nj8jw3saW9vvurb5N+DDIPFXhzQfKJ8zh7NWGOa0RK/V+TZAnazyduvLYxwXNoRGITzEhJjq1g3PuyFzCPpfWlNXu2VInf3JcADI+es/UVqD8iXU5p5Fqg53wC932LybMfFODhh/56HdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpvMCpMkjeIu2CCN75zHIRXSdRlC8h7luEfMSf6jTpk=;
 b=v8lVW8Mm/1ZiMiqoirSp/AXqUwmL4s0jTQeopBd4fC1yJKrYF9IxrKF+ukLuU5TCe3Lu2aDxRSq0ixT7O0L+WMl+DhCBZiTFoR/riBcfY9E9U8IAez3Ux507WRWKT3Qi5LKmVVeQYy/+YTyx0HqhycIibJJ2Z0LxCKl4JIXe3Co=
Received: from BN8PR15CA0059.namprd15.prod.outlook.com (2603:10b6:408:80::36)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Tue, 11 Jul 2023 04:25:01 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::9) by BN8PR15CA0059.outlook.office365.com
 (2603:10b6:408:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 04:25:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:25:00 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>, Allen Hubbe <allen.hubbe@amd.com>
Subject: [PATCH v2 virtio 1/5] pds_vdpa: reset to vdpa specified mac
Date: Mon, 10 Jul 2023 21:24:33 -0700
Message-ID: <20230711042437.69381-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2506b104-7eca-4b45-614e-08db81c6cb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kBTvrFuN8yetllyQZI3gvNbmZOnNz4wYpe97tvpozgx2QIUghXdLaEcnPA7lxx4JWeDHTSimAyGSeV0fX4oEp1yKAKzMVFrKdbzJ7R+kvIZey1fn+I5mBH9OGwwKQqrGxmvWauVS6kUtqEnIG7Abc6S9QxwNBf8LvL/2sg/+1d+5aI8c5w2LsZrAm2Zgq1IkjwS9E5F2rRbMYnBnbdfcrWV7fPqeupzriuT0YrFwZBl+copv2MhUSn3v/f+NIII2uMWOBOXSUXzSqtOvUdkVvwkvFrzuRFj6vWuZy0OloZOQCMzsiZ8hezHhIPUTgW1caRnXsi/Fo3ZFdtYPilaRw5hXrHxwoqGfVfE1M1qKIhnIdCqwiA8ntDhVrVOQLpnGn4//gZvgDDpzTX+j1aArFq0Gs2mWzNvKL1RI+UvhCG1QYfrcD934xwZPabYVLqSIf4W5GMV8u3+bMvdt5dIA/OHnn+7undRio8se4sSD+IFd4mLR70e7y056/YUZPnu2T9BYCTUctPcGiYwJbz8Ww6bsU03SBRy8YT1skaMNwhB5GhyLloQQolD3CH5/oFb3IIX7tCHsTmaRKVffOlQ/nE2CgXWkYKnqARQqqhoqGM6TvpxRK4wlH6eJGeVK8EMH+nJ3RaATCPUmcXeR78TdDTRcTthK8rKMLu+ioyEgsOluKvcxP3CfXoxSfOoRfTCigDIhvNUMAIeWJz3RmqJvJ5bA1HbH1ObWVQKqcCTupMDaI47gYD+wzObd+F6wnI1zVSNf5Y5DMG5BLb2lOX3/KQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(26005)(1076003)(5660300002)(426003)(16526019)(2616005)(336012)(47076005)(36860700001)(83380400001)(2906002)(40460700003)(36756003)(8936002)(41300700001)(86362001)(186003)(44832011)(478600001)(8676002)(110136005)(316002)(82310400005)(6666004)(4326008)(70586007)(54906003)(70206006)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:01.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2506b104-7eca-4b45-614e-08db81c6cb36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Allen Hubbe <allen.hubbe@amd.com>

When the vdpa device is reset, also reinitialize it with the mac address
that was assigned when the device was added.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
 drivers/vdpa/pds/vdpa_dev.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 5071a4d58f8d..e2e99bb0be2b 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 			pdsv->vqs[i].avail_idx = 0;
 			pdsv->vqs[i].used_idx = 0;
 		}
+
+		pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 	}
 
 	if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
@@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	struct device *dma_dev;
 	struct pci_dev *pdev;
 	struct device *dev;
-	u8 mac[ETH_ALEN];
 	int err;
 	int i;
 
@@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	 * or set a random mac if default is 00:..:00
 	 */
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
-		ether_addr_copy(mac, add_config->net.mac);
-		pds_vdpa_cmd_set_mac(pdsv, mac);
+		ether_addr_copy(pdsv->mac, add_config->net.mac);
 	} else {
 		struct virtio_net_config __iomem *vc;
 
 		vc = pdsv->vdpa_aux->vd_mdev.device;
-		memcpy_fromio(mac, vc->mac, sizeof(mac));
-		if (is_zero_ether_addr(mac)) {
-			eth_random_addr(mac);
-			dev_info(dev, "setting random mac %pM\n", mac);
-			pds_vdpa_cmd_set_mac(pdsv, mac);
+		memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
+		if (is_zero_ether_addr(pdsv->mac)) {
+			eth_random_addr(pdsv->mac);
+			dev_info(dev, "setting random mac %pM\n", pdsv->mac);
 		}
 	}
+	pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 
 	for (i = 0; i < pdsv->num_vqs; i++) {
 		pdsv->vqs[i].qid = i;
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
index a1bc37de9537..cf02df287fc4 100644
--- a/drivers/vdpa/pds/vdpa_dev.h
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -39,6 +39,7 @@ struct pds_vdpa_device {
 	u64 req_features;		/* features requested by vdpa */
 	u8 vdpa_index;			/* rsvd for future subdevice use */
 	u8 num_vqs;			/* num vqs in use */
+	u8 mac[ETH_ALEN];		/* mac selected when the device was added */
 	struct vdpa_callback config_cb;
 	struct notifier_block nb;
 };
-- 
2.17.1


