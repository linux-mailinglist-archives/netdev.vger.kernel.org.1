Return-Path: <netdev+bounces-17683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E958752AF8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE41281F1E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9F1F937;
	Thu, 13 Jul 2023 19:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B3200D8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E6272C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMDnL6jKs7V/XMRZ+6qh0DCrL03ikJxoCKwMy/WLf50WKPSBjtpT/qH6v+j5FtzF+Dm1HZTfTcE9uSQeSiAviVgOA95WYkH/7KXy8cEOswjvQdVQz+g9W8paxFuj8zJPPALZbcQQUrxNSR/Z5lvbfhDEiW+7r6LAE2LsN4zJvi2ARCtUEz3f9ek5++h+UUnafXID2NeG9sUd3bGqZifz+jw445A0YK128W1s8dMNW218GRw7spgZUSR7yha6tJHct/ciu4TL2wpmuIhKn+ms7WzZK2ZPARiCkbZ+ybjDPV6AD/MRKbMh95KHFuPdV49yR5ATD3ddS6PK9Ri6bNSwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiKRpcunudOFTbYRCNEIZTvQ0BA8R+g9Wr0JwvBPWEo=;
 b=lcMKufzSXzQTiGJFKOYf90WM+0gaToSEutvBP7Dgmqm3/BBdjGRKorHO+r/Vn/CfC4wA6Y7Gb/k9HLFS/SHxg5easeZQZA4PU9DS2ZkF6md1mRH2gfgsOYSDDUTG4uLCZR2nW7xAwnzjouM+FjhNUyIWnFxQNsOYET3lmysiMSRt6uzQ26aZfn2L0mcY+jC9OOtwyHBq6LzyM4UmURs2HT7v04jhxT1YXn79bTec9FfEeAjkElLDS+wFlLFaKOJv+nDkGq8Yqgqj5utxpNRLyTpZbDvNQoquYR72WVOprlU7b2XLzWykFBdBHMG1YTq3SarqNI267t6GUQ9qCvxDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiKRpcunudOFTbYRCNEIZTvQ0BA8R+g9Wr0JwvBPWEo=;
 b=NWFOOC5Ps6Q8oUpnhb/0wJZvryPZ516hrOnbluqamgcC2ix7yD6GmTG4gB4CReltyXqvFYVpadgYY3xO/837vye5t8iKPJ9hr6zsja2+6MkJquel11427XU4zIyLY3kIkjJqwtAvXc3rZcreaSvp9g+zlaNrRBjnyr5srX7zV5U=
Received: from BN1PR14CA0029.namprd14.prod.outlook.com (2603:10b6:408:e3::34)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 19:29:59 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::75) by BN1PR14CA0029.outlook.office365.com
 (2603:10b6:408:e3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 19:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:29:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:29:56 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 1/5] ionic: remove dead device fail path
Date: Thu, 13 Jul 2023 12:29:32 -0700
Message-ID: <20230713192936.45152-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: b29175b0-cf37-42b4-cfd5-08db83d78b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YThs9kOAu/K/gqXKBpf4SHAaS2ixlVIUFFKsay0XxVUqQP1KA+2YeRFb5UVfCAi5OksfEFcwh4b769eIEZX8UohsZjZ4rbM617vmC8qWsa12jemTuV4tGwuiS7fjGSlyQSjGi15pqYbtP/P5ZhW1ls/LyztyX1ZCWTVGDvPz8TF5NI+8xuByQQiW/vILCEVLzkpD8l5qy63VdGFKSGC+SLyVbLGwTvRp6aJBBFQlNJJDetrWtN4hYgePKoHAbfLTTO+buvcgfold/BtDNX3yWfwTX18SYVKMXygdF48iolxR9XZUB52dq9aZgof8WxX+BXogFIhxPuM1s1oAAxa/7ito/Da17BD9JvKg4Y20mSdVBWxzy190HptzWeM7pemZxviXSNyVdgJT6rQuvHYqZ/5M17LlqnsG9VNgaZqjXRQ0YXxb3oPoflfzC4KGBEJTPjSDTT+bqY241NEFxCD9Xx1brGsCN9P/uiIDOft56cjvJEwQPqJ/4u1ZBsosX4A3a1tZ6EXMcRPVcTDbQdlRO7mlz1fWk3YLasQw7CfSReFFbbF73OtZr/5o1/ppeWBR0lVMfxEnR08gViBgm56kBTQ9Auy47KWPqJjbwcPXb6uzRMBKxzFmxjzQrnuuYs8hCp+g2Pr/GI7TdOj/qXYUmUPKJ79Q1KqRARK6EhTJmOmfEaY+lXsUksQrBPzCHPtMR541ozza5K9IgoH6asT/lLz2jN/dtzFdbMkYQIqmbfPzhwJrsrJhVchPF4aF+9GKUO8h/fYPW96CLF91z0XHRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(36860700001)(47076005)(16526019)(426003)(1076003)(83380400001)(336012)(82310400005)(186003)(36756003)(2616005)(26005)(86362001)(356005)(82740400003)(81166007)(40480700001)(70206006)(4326008)(70586007)(2906002)(41300700001)(316002)(44832011)(8936002)(8676002)(110136005)(5660300002)(54906003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:29:57.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29175b0-cf37-42b4-cfd5-08db83d78b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the probe error path code that leaves the driver bound
to the device, but with essentially a dead device.  This was
useful maybe twice early in the driver's life and no longer
makes sense to keep.

Note: This patch is cherry-picked from commit 3a7af34fb6e
      because the following patchset is dependent on this
      change.  This patch can be dropped from this series
      once net-next is updated

Fixes: 30a1e6d0f8e2 ("ionic: keep ionic dev on lif init fail")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b8678da1cce5..ab7d217b98b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -353,12 +353,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
-	pci_clear_master(pdev);
-	/* Don't fail the probe for these errors, keep
-	 * the hw interface around for inspection
-	 */
-	return 0;
-
 err_out_unmap_bars:
 	ionic_unmap_bars(ionic);
 err_out_pci_release_regions:
-- 
2.17.1


