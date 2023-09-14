Return-Path: <netdev+bounces-33986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6597A110C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855BE2821AB
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976DD50B;
	Thu, 14 Sep 2023 22:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454BC2F7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:32:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB74270E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvyWFPE8AQWvZySgwG1jZS19YnIJhzhxKstyDaoOQYU3OFWKF+4GtnpLsVFJcl60IdWEW+u7nxJkiffVQGz2nD/siDHlxB8yfUL395BoO/cQ773ENmdc3SJNcnpzM/d5A5gc7BWzoVS6w96srJlrRRGBpaR/tbQoMjb9UHDy2P8PWJxOH0mTmQII7Avh+qa//nkAVdEb7Su88FhEEtABNeyWxh7XEFrM8HMWHu7mRpyBoSKNlyaDLUBTZIgqrOnMse+Vto5FmNeVQQplDo2qHj1WGl32sOAiDd/PdAqjsprjmGnB9XcwzNA0WAAADIUYEiS2nKVXnV38XW5HZ9Rrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdFloJpEMzcc8mX4ZPgmczGLBcaCSFmG6TF21BQ/2Ws=;
 b=gXRp4kHsVwpDKuThrZKJ1hF07Ic4eSir/AolpkbrFRXufyon2zSjR+oboDJ40USiO/gyx2NzqGIGqcRTGGIPPdjYtCw93aUgRDCEsHTtO2rXu5rqMZMrX+WC1bj+65wyzCL10WD8SUF0avLz29T4p3F1XU94MASHnz3AX1I9jm6QUyAfsrtHiSkOLI1sOmtsHQn8Tfu4FE2+k+rknfU3Zd90AI25zoy0uxu3VdYRyTU4mOhxhLA1UU+Ewq76aAk4hoTa+uj3zGwx+nYZC92G0dOvjE0jfMdUW7+Iwj8nYYiSH1YUrNTQbHt+IWQWI7+TYph3fXUoZ66R4Ys8h4oLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdFloJpEMzcc8mX4ZPgmczGLBcaCSFmG6TF21BQ/2Ws=;
 b=WcybrZGPSAVfu3eteLoycTzEIis++HgA/BTI6ga+cJTAOC+rgNVJ2Ww36vu4JY95OAIhnFNWzauIQuY+TUHCjj2SzzGdd1fE97Ry/BgAqZkSQM70qNXDlC5Kizg2TUOR+UBw+bMTLScohApBFEotIBujnEC2skr/gCyiO+htjjk=
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 22:32:34 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::71) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 22:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 22:32:33 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:32:32 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/4] pds_core: keep viftypes table across reset
Date: Thu, 14 Sep 2023 15:31:58 -0700
Message-ID: <20230914223200.65533-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 01548e50-8089-4ea9-ab67-08dbb5727d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UQ+vV3d/0T7o5zjEpdRm1p0BBcBYp4xq9+5fHHdRCn+tnvBMzZidsfjK6fu8P90tc8jE2LuU+Gx+rtOPP9ou1qfDWNjmq/EVspyfXqKlrSJ1oidPJGmuhGGT/w2ZqMcmwX3qIBJ25hMUlVeuaU2REMYGST3k3mob5sj4EYBjaQRWrkiZ4S74wdJ2YPEohNV+iUOYskdneAxng3gGn3TQBMFiH/6uOvQ3OJDbveYGVCvhz14PbsALu7D/G6IYn47ObP/5Cs5vl/hsuET9PfIKKjl8H/bamTsKLacb01JwjWFvLC9tJpPnCFHxo+h8fiYtQs327X/AvdwIUX1vQn3oGCIAV5roLhHT5xFfFYq0PU09nUPO9t9Yao0OKNn0f3BnEWYCXpDVeQwNZxhCjoO7ddOxE8PQH30LkMsmYP9Bhmp13ziYj09/VrLAG2A1yHYoBtXmNlY06d95pG/iiKG5SVzgj4uSFhXAqJPapDlsLaD5NVqLS8UCngnGL7gFjfzxqGL/YazKkkjRSbKdaGcT88gIAqQven6VP+elIXCw8xEnt0cPA89HY1TGqiEnMj1HrkmPKW1heBBM6MT7Knph2WU17+2hsLmxok8TS3Ty/fUMWwTI7HAljWGp5e3jHV3oaB5OYMr0WZ7HSrsY8trQiP/55QGK0vnKtwKWOeVz5smX71KHHTKX6/cfc2tjeAIwj3H+2k0AKi7fKAlbE8CxKgLWIqqxqsW8tsaq3fpGvoP+bClqyQZAgVqerwJJz2T2HRsIVKt3HIOpfmVp7rJ8PQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(2616005)(82740400003)(41300700001)(8936002)(8676002)(86362001)(5660300002)(36756003)(44832011)(4326008)(70206006)(70586007)(110136005)(316002)(40480700001)(81166007)(356005)(40460700003)(47076005)(36860700001)(16526019)(1076003)(336012)(26005)(426003)(83380400001)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:32:33.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01548e50-8089-4ea9-ab67-08dbb5727d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288

Keep the viftypes and the current enable/disable states
across a recovery action.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 36f9b932b9e2..6e426202ab83 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -445,12 +445,13 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 		goto err_out_teardown;
 
 	/* Set up the VIFs */
-	err = pdsc_viftypes_init(pdsc);
-	if (err)
-		goto err_out_teardown;
+	if (init) {
+		err = pdsc_viftypes_init(pdsc);
+		if (err)
+			goto err_out_teardown;
 
-	if (init)
 		pdsc_debugfs_add_viftype(pdsc);
+	}
 
 	clear_bit(PDSC_S_FW_DEAD, &pdsc->state);
 	return 0;
@@ -469,8 +470,10 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
 
-	kfree(pdsc->viftype_status);
-	pdsc->viftype_status = NULL;
+	if (removing) {
+		kfree(pdsc->viftype_status);
+		pdsc->viftype_status = NULL;
+	}
 
 	if (pdsc->intr_info) {
 		for (i = 0; i < pdsc->nintrs; i++)
-- 
2.17.1


