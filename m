Return-Path: <netdev+bounces-37454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E27B56DA
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 3CAC2B20A5B
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3461CFBB;
	Mon,  2 Oct 2023 15:45:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE81CFA6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:45:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CC6D8
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY8A///KGDVsk32SfYbAiZRYyOTcXK2CaHQkc2Pb/qIa4LovyQsw6kG+gBs8iFJ74GkEjbDYuBv3xO7+euLJRTa/XSu6QFsBB34L4/oeR+C46BKHkqVASLxjehLJFeYcFrOfCe3iphVqbQbzxWV//i1vgoukHdo+5QE+05WROZasS79QD2hQ/27ujROYeuRrwPEOivwfDRg7dwPgGoaYqs9KcOWQVKBPV6u/WBpf8fXBlqNgb+mc9srzJ0DhPUc19GfKxVwYPdn9sov0bthC6/mOBI1bqh3hhuEciWYvihL6R/N3lSGcnUgPaIIy5kFnRtC7mKV+XL1Xh2v6+ZxWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOaznqtpMH9jlvdp6fF5fumxDh4r0qqVPyQptVrU0LY=;
 b=jvl2ot6wMOt6MQDwCMhTgjxICNzeBuFbGuRod7TSVGATuGVDvcR2nCmb+3rzIioi+XVw4lGXuuMp5nF4pElQtyHbEy5HQtBDlaIV61SeMrXMaQ7CMQ7Z/q6PA9EQdP/PfKEM0bbfD0TG99BCMYfVd9wngCEjAB58jUeZdOJ/M635sBjGAO6L9i9axs302+s17nTWz0FIAoawboawnQ7IqZk8w5hMpkNz7yi2C6eTRsSwYPa3sEusbz+yRapgMM/+BxJ2Y9YaY1PXsI25Z0XchMRUZBmun3z5oIxttzT+lLMAACbjLfrmnGqwTtBC0j8y0irLA+KPezcbJ+82ChYaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOaznqtpMH9jlvdp6fF5fumxDh4r0qqVPyQptVrU0LY=;
 b=QYvyOO/uzIS9kOjJQ5C5uJhvnpDNFcsdNzPbIfII6yz3h2M2Ctq6K7E7f3dAq2p9TSJkJkkuCcIgCgJr8e3hp20jaWAod/RnRPYu+wHrXyXaRo+uYXhdHUL9sAQgG7lzxHLyL38/oLGCUh1hUiZy38f5qlugwIt051P2LEgVEPk=
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 15:45:48 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::bf) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 15:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 15:45:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:46 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:45 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 3/4] sfc: ensure an extack msg from efx_tc_flower_replace_foreign EOPNOTSUPPs
Date: Mon, 2 Oct 2023 16:44:43 +0100
Message-ID: <60e3aaba6d6874f76d9c67b804cd1bac297bc7b7.1696261222.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1696261222.git.ecree.xilinx@gmail.com>
References: <cover.1696261222.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4df7e9-c623-4f40-e0db-08dbc35ea5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eJgqmOSKGZ3eGaFZIFfaz/lQVepzGpiO1ffYPDqWV+oBZv1Ua3l1JxtswWMhyl5B6PSr1wGJvm92c7jV+G/nXyZUryJH31AGis/2xSMw0DeAfCeRUbBw2PdviNJ4x+WEn9tzRjSu8AqqQJja3cWB8EwcSKf6z0OJ6Ij+LKUQKjWTMH9IZLPt6PLYHQQN+DaQhXDo7sz4PEVGb7qQtp7w+LLWVs5AssbEWAMqYLC8kEsEkL0YcSd3v8ynvx+/llq3UcyBVxj51+Km/3iozjMhG0aNwHZGyMoKpQz1sPSYyy9URjqiCAemkWeDPXZQjko7GH5JuVYlMMq/zjPs27bfo1z6UjIYswymh6+OSbBddnRM0OIypIa+6O7QEUfVpGJOt/T24aEQjcusPILL8kdaM1K13ot80TLpjsGXnR9WLLRycBGlZL5uYhMuzKXjQv3WsR8/eKmRJuJCKAt3AY+rd6CqXsy3hX55j6BczZDivZE0xrahP4di+bNUEm1IFoGt1Pu2nzwzNKsOuHTvZFSjMVhwCh/x34HU+sz6RB1WOPps1JEfLDBolQGtRU/VOuaWvHIuNfkLpUcMv1kdtcK/HIXkXi6o4MCg/xYvB/CWZblrUpYAgPusdFRW7vzmjRpvPDk6FZrvT7b9xpPwF+VQ+7k6WZIlKTZWniuwuEMV0mptsNGKVTWHbcsZ8DZEJF9JzhkRNQEctNdxF6O/aa0rCiH0YWTWCTB3OyopECqRxp8gau4k1SbyyEy+TddrtdxocAxUsd7Xl2euQoUBfyGrDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(336012)(83380400001)(426003)(26005)(9686003)(36756003)(2876002)(41300700001)(316002)(110136005)(54906003)(70206006)(70586007)(5660300002)(8676002)(8936002)(4326008)(2906002)(36860700001)(81166007)(47076005)(356005)(86362001)(55446002)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:48.0397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4df7e9-c623-4f40-e0db-08dbc35ea5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

There were a few places where no extack error message was set, or the
 extack was not forwarded to callees, potentially resulting in a return
 of -EOPNOTSUPP with no additional information.
Make sure to populate the error message in these cases.  In practice
 this does us no good as TC indirect block callbacks don't come with an
 extack to fill in; but maybe they will someday and when debugging it's
 possible to provide a fake extack and emit its message to the console.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index f4172fc6bd4f..6acd30f2db1e 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1580,7 +1580,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 
 	/* Parse match */
 	memset(&match, 0, sizeof(match));
-	rc = efx_tc_flower_parse_match(efx, fr, &match, NULL);
+	rc = efx_tc_flower_parse_match(efx, fr, &match, extack);
 	if (rc)
 		return rc;
 	/* The rule as given to us doesn't specify a source netdevice.
@@ -1629,6 +1629,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 	if (match.mask.ct_state_est && !match.value.ct_state_est) {
 		if (match.value.tcp_syn_fin_rst) {
 			/* Can't offload this combination */
+			NL_SET_ERR_MSG_MOD(extack, "TCP flags and -est conflict for offload");
 			rc = -EOPNOTSUPP;
 			goto release;
 		}
@@ -1655,7 +1656,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 		goto release;
 	}
 
-	rc = efx_mae_match_check_caps(efx, &match.mask, NULL);
+	rc = efx_mae_match_check_caps(efx, &match.mask, extack);
 	if (rc)
 		goto release;
 
@@ -1743,6 +1744,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 					goto release;
 				}
 				if (!efx_tc_flower_action_order_ok(act, EFX_TC_AO_COUNT)) {
+					NL_SET_ERR_MSG_MOD(extack, "Count action violates action order (can't happen)");
 					rc = -EOPNOTSUPP;
 					goto release;
 				}

