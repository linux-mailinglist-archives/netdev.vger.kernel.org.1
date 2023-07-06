Return-Path: <netdev+bounces-15879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A474A3AF
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559E41C20DF5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016FC155;
	Thu,  6 Jul 2023 18:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087EC14E
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 18:20:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8361BF3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 11:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6/+ZPKct9DrpauwIhlduQFrS+iMhT9Gq9EobJF5pMfRi9hfFCNWXq/CBE0VLNd5suwBD6Fz+q1SSi3I6BV8LFpBog1tyRzthW6JXSI5ZBmNRZnVVKeSyGnm6POUGjEDFwJT0LRDDYXmU6QHFHmR8+bLbEyTxoff74jLhOWdW1wlA9S8Qabdo0YuZ3Bt1YCD3uxP4oQxfT/Hkyb5RvSBkPG3mRbemHeQDQWMinzAgQg3/Dnz0v53oqwflE78+i/Jj8cMIleXv4uL2SPVFsA9yLzuaQkH8p3nSt1X7gz137NaOgPdsvKPlnAY1OatDaclj0reYszo0/HTGgg6C7vNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMUXOM7Nr7PL6/QqLaV+l7G7YUd9RMT64UOk96QPY/w=;
 b=P3b1v8Km3/VyhH0vC92u7rhVozFy1+/kAaVGBAABoymVtEotBZBSZrQeEWMJGj1Z7vCXjmtbtznulsorvTCcHdQ17u0058M6Raa/JCmODUhba+Qx3UodVy4Hn2lKzjqGUn+FGvBx03UUOZ8mXZnGbRvz8jJLbMn/1Nmg6xxElSmshjargiLIJ7oCd5yS1sM85REmLW1vsJa/CuZqwekaqpclJ2hsbgMkedgX4joAvz4FQ2HWaVRKmIlfW+FXRwEYG7QdCv7k68WATefNe6L/9MbsDMib6q3uDi97+LAxaLXVg/Keew+26tE2XJwuqsMtlRt2rywImM77z9lKUh5fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMUXOM7Nr7PL6/QqLaV+l7G7YUd9RMT64UOk96QPY/w=;
 b=ndSBMAqLfR9S2fX3j74t4pqtLGrXOxgFBtZ5uWUnHvmBdazkSxjD/xiMVGB0emKXMYooqWTcZueBxh+Bjicr40K6hqx9N7v+QdaF3LOmrlEsPtNivreVkrF7QVZvuoLUX1vyRX/9Iirkm2op3JZkrDNqf3AmSpvdS1KNIl5KhaA=
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 18:20:23 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::a7) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:20:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 13:20:20 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, <nitya.sunkad@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net] ionic: remove WARN_ON to prevent panic_on_warn
Date: Thu, 6 Jul 2023 11:20:06 -0700
Message-ID: <20230706182006.48745-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cf1ff2-f5c9-4710-1708-08db7e4daa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HbLH9XXkqzDVzS5FM5OGoYh2IqYt2qDkY0TDcyaZAN9ZIpo0qn+jxP81zsUvqVruWT58hKFciTViSZN53BvoCiQ/i7xKWvTWkBNMOwoptOXHENxQWHsfzQa6NSm5HzMPcGTLBorfUDjAANwv4ICqvGCNtxhqjcEssw70Al0ZAPUlKJEt+00SGSy0oVoYDStd9ifkmtcpHG/De+5XSn2w98dgp7SxI/e6aqQkm05NnIUibxCoAVy/C6Xj3uC7FClOp5NJyXN5rE0mW+BEMvHWO+N2/LSxptkB6BwYqgzzHKvnKgRRbX8zozv9q1t8TqtHBsMTVAbDrZRNHWECSUZGZDRr4s+Ypb/BU1WxKQXsaHzzNFT1jPGysaNiIJ9JghZ8HS+3Xc1hjP1qe/S+pTl5PPKAQIzz89QSSH6lRggTo1zHJKFEPquYHcVFSEQLWBrXxO6MiciisWyrGCVjg9NjmEqvcdlwO2ltxtrN62gS5gEqKxP8DPy0FCEKikxFPKbjZIXHyexmaYQQPru8pz/nvvxTkbnakOVatNL3jqUYF0HfjzpVgAuJQ9Ghs8FkfiP0iwtoswcEMIB4hVb6DPu0ypZl9TQ5iCc0wvhdbYD7iIa7twO7R+vN0inbUS6T2EvcV4HNFpeGy46rRg9jWMugAvJtodbEZG9YI/eWzJO46gnBnCAuVOrC6Sumcw2rga3km7IaXvZbEMfeIQN7f7Trn42CiRoI/VCYKmQK9U/h7eOXWju5Zg8LBD/hFFlTgn88+MoXWXaDCih6HGL2Yt4+Jg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(2906002)(2616005)(40480700001)(16526019)(5660300002)(44832011)(1076003)(26005)(186003)(336012)(70206006)(70586007)(41300700001)(40460700003)(81166007)(82740400003)(356005)(6666004)(4326008)(426003)(83380400001)(316002)(47076005)(36756003)(110136005)(36860700001)(54906003)(478600001)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:20:23.1183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf1ff2-f5c9-4710-1708-08db7e4daa02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Nitya Sunkad <nitya.sunkad@amd.com>

Remove unnecessary early code development check and the WARN_ON
that it uses.  The irq alloc and free paths have long been
cleaned up and this check shouldn't have stuck around so long.

Fixes: 77ceb68e29cc ("ionic: Add notifyq support")
Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
v2:
- Remove unnecessary n_qcq->flags & IONIC_QCQ_F_INTR check from early
  development

 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7c20a44e549b..612b0015dc43 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -475,11 +475,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
 static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
-	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
-		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
-		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
-	}
-
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
 	n_qcq->napi_qcq = src_qcq->napi_qcq;
-- 
2.17.1


