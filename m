Return-Path: <netdev+bounces-47141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82F7E8372
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AB1C20AD1
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753903B794;
	Fri, 10 Nov 2023 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZyfdNYW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBF3B78B
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:08:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32CA9
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:08:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHR3ycuFhOh4jFA0tLU4YaimHuNdQ1k8eQY03HtuRyBGCUN5A5HsyT2NTyNVdxrSXTNcn0pp7REH/4lrZEgtn1UrrYa6ss3/JgzXmbRskU6gDTqL/BEqo92brEmI08yR01n9cOkMxU+gNjkh68qT3A734uCQ220Y4gQN2z4CQBWx5qxjZTlciH6d6U4q1L9pHmVHI04uDdMCOkk6Bp+ugYBdiS58TVKzyAR39U2ul5BtLN322vO0wYDs3Ivq7ua4yi0aJe13dVEHceS4M2196VqJVijLitPZprGrosWTiqdbz+gjtrRut77hoCQVMPRsmrTKFmnS2G4V1VVIKudA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfV8RYKVnPKo8nHJxk6D6gXN3mEj2fFSFvWkjpWWbeA=;
 b=VcsfxPF28wW/iybhrHjE/li08F/FcX/ezFeydoHYCTIpBI7kVYyPRXg4L68iUROmwH2Qggt74RMCT8SmEmP1smRbaaXg7K5+CjotvCCHJHr+7gDnBCpcCJghdi8yiTwEElA0P9xPTqjpLxMSAiLZboJ7joAkVvtwFZVrA+lAYvt1451NOBI5bGCUkIO5DRf1loeNxFMCOvaiPGkZrAZ86BCUbM1xYfGLhYltJtZO7fiUtfBo+s2InfO+Xpkkznm28WMIpG/9ujBZjdT6Ug26w+sjJ1XFDFGLOQIXjHj8X9xsz796dXSQhYI9Om3a91KU1pcDcppGk2G9yjsMPwfIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfV8RYKVnPKo8nHJxk6D6gXN3mEj2fFSFvWkjpWWbeA=;
 b=qZyfdNYW0n8cikk81fXeK9nDk1Mxyg0vxxzQ2VXL6eNOuaS7HGzXUqK86V9u/PswcrlzLQ/T3H2VoVb4LhzpQKgx2FDonR53e7tHbTYnOPnCuCHbNwvLCDVZVBtw4v12j+dEV8Ao7Jjyj9L3USLOHAsQf2cOL9RPCkmMo4WNdEI=
Received: from PA7P264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::20)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 20:08:35 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::34) by PA7P264CA0131.outlook.office365.com
 (2603:10a6:102:36e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 20:08:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 14:08:31 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 1/2] pds_core: use correct index to mask irq
Date: Fri, 10 Nov 2023 12:07:58 -0800
Message-ID: <20231110200759.56770-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231110200759.56770-1-shannon.nelson@amd.com>
References: <20231110200759.56770-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcf4fec-19a1-486e-53bb-08dbe228d1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Xy6TXoBBqsJ9JTW3PMJkrkryLxVggVaiDw+jBIWablwTmLY2+HUwCqvxAPfFexLMcAeIugnKnXuS5KsxbXPeKBrRUqxhJF7NMBa8/dFqF45dSIcsYaXgx03b0v5R9DS9oWBFB1I6A8ZXNliErC1mNTLGfkQ+CImNnADiWjCyenvvHIpchFxXpylaN8wgbxZBYacRQDGJSKiqfPsWluRAshfBONsn8TP++pdgsOD2f4bbQvUVNA0H1SVj3kJeaj0Dqn419/Ljf1PF5oW9q3/NtVh9rQ8xmcs3nyE3+6XPKi3v0RuCly7TJ5pT7qD85s0wm7Lk80dvJVltmYQghxATbEPq+XZ1SCLHIyQ8UlJvTtalsOI7tBL8b0tXmja4n1xdBqH+tJzYxklJUgou4FepRm2LS3gik8/hP//mDNMeqV2ZesAe9L866P98wUX5Axr0epHa2i2N7MiyXPJg7GhB6KoRjmJRa73AggSSrE1u2kL4NOI0Ar32ZlHH2WBcnAW8WAzDu5LhG95tbuj03ZFrHOFZLMACH3U85M7px1/UwEu6JzgJcyR7q9Mbf4xLFvgb/mPwjoIwPBm0ttIZVmIaU/q2nwG8/Vd0GE0pWdKBs6TouAFekvPYd8QFE6uWhHnyY+WW/+ICocbnlOx2gsgavpejMEI7oUS8BD22DDLD7WCMzJruZH7Z9LC/z4CoiCW9m/xCUbfcwZn2ta+FlpGWxxW5mDe/a1dqhBzhUyQtihqDVeIzskKkpKetvKYNLWwgwmS8WDiIjHKzp6X5IQN3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(110136005)(41300700001)(2906002)(478600001)(4744005)(40460700003)(5660300002)(16526019)(26005)(316002)(426003)(86362001)(336012)(82740400003)(47076005)(2616005)(54906003)(4326008)(8676002)(8936002)(1076003)(83380400001)(44832011)(36756003)(70206006)(40480700001)(6666004)(70586007)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 20:08:34.9944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcf4fec-19a1-486e-53bb-08dbe228d1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Use the qcq's interrupt index, not the irq number, to mask
the interrupt.

Reported-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 045fe133f6ee..5beadabc2136 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -146,7 +146,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 	}
 
 	queue_work(pdsc->wq, &qcq->work);
-	pds_core_intr_mask(&pdsc->intr_ctrl[irq], PDS_CORE_INTR_MASK_CLEAR);
+	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1


