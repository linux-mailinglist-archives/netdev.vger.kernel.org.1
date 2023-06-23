Return-Path: <netdev+bounces-13451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D673BA45
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EE2281CA3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD42230F5;
	Fri, 23 Jun 2023 14:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00D8BED
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:35:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::61b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F7A1706
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFdC9uMMdydjbuAHrtR+ShMxqkS1DgBQS2jQYy1gTBghE8qSO6FkdSGrVO8wlkyKYdwfpfliwcy1DwWyF2Uw7TDYvoJnYB02pGxq7Yie6IBh9tNsL3Qm2ghp31tIfIaUv/+FtLxOu8+RKtwK5QbhWvPJUA+P23DyusAce5MO/A7GQ/NkRfook3cnK0mhZep1638STFoLjB11/rpP5F1XubzwhIR16ITJOh/Aksg3Hr0hb3YeZ7oAy6pMq4yDs8FlyKQRg1Xo+XS9i8Nk83XgNNgkM/ByXoseII/amsyGVaU825J/JXFa12e5KAJ7B1bfaWZCaYaSddc9vXoXl0IkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUg28XA1teom6NjS4fyN6eT7imEf9twK0PJ1zMqYu5k=;
 b=DsmHstZhnSffCBHRWwGQBYtymj1ZPHHNXJi99WW1Fzqij1xsoEJWUJKD1O0knFDtjmcWb83rvfB/t0FrwOWjgns/n/x/AgYR62J/kxOXgNiRWrNtflvgggFCjPkVP3v278VueI01/A/tPJldbNvmPFnX8KdpjdVC4eLFsLGQc+stt8lS/hB8u5djDLECznrOpu/g3OFRdEU3oSZkrLGdYgcwyTBi4E05rXlojiuIPvh7OeBfEFCA9RDZBb7F/llRVwVNsgonc9ANgvPYiuk9lL4H3+m/zRXBJP4Dv8OD617gPICX9JaVWDw9MXQDUXGWfo7U9gVD7QECgRIx0xKMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUg28XA1teom6NjS4fyN6eT7imEf9twK0PJ1zMqYu5k=;
 b=4grLxiRNhxCJe8k8SH/ohWexyqrDpXyvmpEqq1Q+aFHorNKX1n6BWldQExUNOCuYRxobmqybPAhhGhAUihei7/Xel5YPVp5rZBjibQ+ZcfOZ1DTPcJIBoy/PL1R+y6Qnh2BtZagL9MPA9KyFDVM6IVUdq4xxNOuUD6KC6PrDacA=
Received: from SA9PR13CA0118.namprd13.prod.outlook.com (2603:10b6:806:24::33)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 14:35:33 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::59) by SA9PR13CA0118.outlook.office365.com
 (2603:10b6:806:24::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.10 via Frontend
 Transport; Fri, 23 Jun 2023 14:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 14:35:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 09:35:32 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 09:35:30 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net] sfc: fix crash when reading stats while NIC is resetting
Date: Fri, 23 Jun 2023 15:34:48 +0100
Message-ID: <20230623143448.47159-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8483eb04-a137-4797-0e81-08db73f719a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mVxEde/U0GvtDCtvkUImE7PInl1W3S3nKyKMOPGPhulkbIPQA4U/eABiA4ttIPyPsEf//qZ4vF9tFreSjsSdmOdi3IkL+kkL9iweJNi51Mx0Dsd1a6vsSNPxrLA+RHz40siGkmRr5xTGTmdwDkkAHFtRKCKh4Uc+DeuBiDin8sVJ87fTsd3PzlB4MIB97OtqQbbQz8GeTmKTjaCLooOsjGA6+TD6BThFHaNiA4NAGJA3P0nf+ID/H9ElHPxRENzV7vqrGMlg1SDAHUvsRi+K4GzOuKCEHmogj6+nPZlHhYv//ypXdEr7qYzE3p4762odB7Xfd5sYCgcNwHdrvO3Bw5YwCqFAXdCY/4c4I1Wegi2CvGQ+3LgE2PsxzziE+gJEQNaouws3cPa8mqaJsZfWE9oMKaf+Y4Xh05iD8tY2tEhIqQSaooYNlgUjhn2+C0l8CBXE0Y5zNSgZAg/Cd6bWel3p8J6ec0LzcdmcrXVxYD1okH8z8YfW+e9KcafdnChAKdLgWgnRMjNI9g8/e82Pf2eueHfXYDP8ei6mboaa05LE6ITtoFqpYRhbi8qtzB5Bm/7VaINEcabz+o7gZ6WF31+r0obeOWPFkblzaRA1MXBYL+DWjNzDZsmtngw60fNvph46XSex6+4tpPDq27SCHbv2vaO0TSAInBVLpg+PauCYneofGVtUYteS5wOtDTmVwsB5XJU98xtnLh9Ygu2rAncYAEWcU/Io1PvU8Psd1+romGMBgkiF+5ygPW3Boh96PHDo9SIBNozCSNrrNOrGDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(426003)(83380400001)(8936002)(8676002)(41300700001)(81166007)(356005)(336012)(316002)(82740400003)(2616005)(36860700001)(47076005)(186003)(1076003)(40460700003)(6666004)(26005)(54906003)(478600001)(110136005)(40480700001)(36756003)(4326008)(86362001)(70206006)(70586007)(82310400005)(2876002)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:35:32.7058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8483eb04-a137-4797-0e81-08db73f719a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

efx_net_stats() (.ndo_get_stats64) can be called during an ethtool
 selftest, during which time nic_data->mc_stats is NULL as the NIC has
 been fini'd.  In this case do not attempt to fetch the latest stats
 from the hardware, else we will crash on a NULL dereference:
    BUG: kernel NULL pointer dereference, address: 0000000000000038
    RIP efx_nic_update_stats
    abridged calltrace:
    efx_ef10_update_stats_pf
    efx_net_stats
    dev_get_stats
    dev_seq_printf_stats
Skipping the read is safe, we will simply give out stale stats.
To ensure that the free in efx_ef10_fini_nic() does not race against
 efx_ef10_update_stats_pf(), which could cause a TOCTTOU bug, take the
 efx->stats_lock in fini_nic (it is already held across update_stats).

Fixes: d3142c193dca ("sfc: refactor EF10 stats handling")
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index b63e47af6365..8c019f382a7f 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -1297,8 +1297,10 @@ static void efx_ef10_fini_nic(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 
+	spin_lock_bh(&efx->stats_lock);
 	kfree(nic_data->mc_stats);
 	nic_data->mc_stats = NULL;
+	spin_unlock_bh(&efx->stats_lock);
 }
 
 static int efx_ef10_init_nic(struct efx_nic *efx)
@@ -1852,9 +1854,14 @@ static size_t efx_ef10_update_stats_pf(struct efx_nic *efx, u64 *full_stats,
 
 	efx_ef10_get_stat_mask(efx, mask);
 
-	efx_nic_copy_stats(efx, nic_data->mc_stats);
-	efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
-			     mask, stats, nic_data->mc_stats, false);
+	/* If NIC was fini'd (probably resetting), then we can't read
+	 * updated stats right now.
+	 */
+	if (nic_data->mc_stats) {
+		efx_nic_copy_stats(efx, nic_data->mc_stats);
+		efx_nic_update_stats(efx_ef10_stat_desc, EF10_STAT_COUNT,
+				     mask, stats, nic_data->mc_stats, false);
+	}
 
 	/* Update derived statistics */
 	efx_nic_fix_nodesc_drop_stat(efx,

