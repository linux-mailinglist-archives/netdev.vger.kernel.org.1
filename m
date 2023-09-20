Return-Path: <netdev+bounces-35292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F077A8A96
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD95281EBD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE4339BB;
	Wed, 20 Sep 2023 17:26:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5346D1A5B8
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:26:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE2AF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYFFiYOFUNMGR4MNxkWa8pSiIzffCYPfRYioOwkgWcFd0x1sJAxlcaWE3N2v07UP8UvsBsQH9VUJk7I+ICsc9vijMvxrvgZmu6jYMHNRn0r9pQ3rSsXl3aycOBoxIc/MwNEIMdpR9G7IRHSZpUMLB6dGwU/yu0njLWV9f/dTXJI6RnL/MkNfrKAyi3Dyj1aLysC1Evq/ZlTFtmRZ3t3YyDHTEeamdmcnkFuV7EzHYkhfJSad1Tgp1jqMtyqGYOgHkS6yFPEFveKuVpynRaWrikxKQJxAleuo4Qw9Ib2ck7JEBcboNMNiLMb1WKCTMb1qVbgwukDJr9Ax/grfFiGFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvYXsnBL/A1RLPfHA/vlmWyl0KzHnCBV9FTCPOcxT8I=;
 b=C9yLQlnZ2DyyhgUq7jQUbXCukFx285LKyP2PigwkVkfFLWDWCY/38tayTJ8+Tstcq3ARNYzZo57r4mr3ECsm5bMivO/9ldxhVYSx91LSKabVV+awc1ZyYvIUTSRUY6TyUC+wRD4wrFvyiEQhM6rWyfCQEYsKo1UTGYVugX/nCGoxYcbRaAgCIWs8PO4gBTD4kIDqMOcfOjvAvwUTi79D6kwPAG/iSnxBtmud/YyAZdVRoF1KpNVab94FuYEqYmL7MInuhdT2nOj8gMElXH1Ig0cwnYfTRkuSWQemHvB2zN///lLp4XtDAQnczlEeCYxxn7vulQUKNt9EHFn866hYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvYXsnBL/A1RLPfHA/vlmWyl0KzHnCBV9FTCPOcxT8I=;
 b=KOsJwaLU4KfaNFTCEEB3ylgtnVk59/WVSf2E67zv29ypJUeDgWNgx5n9bohQrekaxy8cpxI9slfQ9Pq6YgWDwUatNto2CMXomrZ9c3uT3a2RhfVyDGOIuAf0rnIpCbsnKyCyCnIpkB0SugflLBV85f/458zURQYU2rvHCCJYdDmsJ4lIcO3/C14UlVd8MwD87JHUsUyMr2RgVQjbiQbzzyDJV/nDBTJdrz08r14KYwRunqTQmTlxRoZ5SFuC6zE5QWljUtzhZRKLjrScsv2NzSgLtGMY854ksmQzXvTlzTzOuq8bDW0AkJU48K6tTstDMMhUlbw/DMkenU+yGYB71Q==
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 17:26:34 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::36) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 17:26:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 10:26:18 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 20 Sep
 2023 10:26:17 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v2 2/3] mlxbf_gige: Fix intermittent no ip issue
Date: Wed, 20 Sep 2023 13:26:08 -0400
Message-ID: <20230920172609.11929-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230920172609.11929-1-asmaa@nvidia.com>
References: <20230920172609.11929-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: fe07576d-9701-48eb-6381-08dbb9febcca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6X8qMobrmz4+8eEitgx3jwnziztRJFuC9nvEzaunqELExBlmaOk8MAsqjYcNkjCwS37Uec+7y3DdCLvI7vnXNGi6PTehLu2kst/Go7yJBLmP8ED2e/EdGoja9XRklemwkHQ9Wiy4wzVIt7uZgQvkiEDROUSSeB9KZz8Cbi4+1BJzpxdJ0cZbQOO9aCdmTiFkArTLO8pHh+dQjJ0OfBuq5GO4dbJdWDLt5nxPjFHvcsu4gcxWQ9GUKeY9mzEp91zN3MdpVl3pcr4c3IAY+2H0I07af/iGQeTIjTPgJ6eTL12l+nd95xjANi6yRgdKF95EjffMlUb0HK6vhTt508qsFslvzvoI0tIgsOnaw4UjSiKCyNUJIMpxDvvmOhDZJQYN/F1s5tNRRhvhoDj9jzBfYlRbzUlXfsuEKha4aBaKnYt5pslu5uTXVHLyNjJ5LH7Vwp34+Dddj58zTSt9Z9I+XyMzO+6JSiyzcLnJKm2g3rfk4B6a+UePk5yA8aUVyxg7JGh5Z1Kjefcx+gwm9YmeuyylhPktNEqH8hsm7B4QaflxEfpINhcp8rZvqX9hxsaG+whk66GQ5XFd63V9US649y8yH8ltSy0sDEXIR9/l8+3UIZb6gD61BF+TzP46U7KYWVELIsL4xwSfXs9xYpQjnqDaj+TBtZmgLxB0zwtcZG43IrVoVwB3JMxqN9Rljz3GnOdgTDZlaWWzpUkypxTJMOpLAyr2UFeC6PMJkjKq+FOAeaNTkKtHTt5TwH77J1xp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(7696005)(6666004)(478600001)(83380400001)(8936002)(8676002)(70586007)(70206006)(54906003)(110136005)(316002)(5660300002)(40460700003)(107886003)(2616005)(36860700001)(36756003)(82740400003)(86362001)(40480700001)(4326008)(47076005)(336012)(2906002)(426003)(41300700001)(26005)(1076003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:26:34.1394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe07576d-9701-48eb-6381-08dbb9febcca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Although the link is up, there is no ip assigned on a setup with high background
traffic. Nothing is transmitted nor received.
The RX error count keeps on increasing. After several minutes, the RX error count
stagnates and the GigE interface finally gets an ip.

The issue is in the mlxbf_gige_rx_init function. As soon as the RX DMA is enabled,
the RX CI reaches the max of 128, and it becomes equal to RX PI. RX CI doesn't decrease
since the code hasn't ran phy_start yet.

The solution is to move the rx init after phy_start.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
v1->v2:
- No changes

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 14 +++++++-------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 98f75c97b500..f233c2c7b6c1 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -147,14 +147,14 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	 */
 	priv->valid_polarity = 0;
 
-	err = mlxbf_gige_rx_init(priv);
+	phy_start(phydev);
+
+	err = mlxbf_gige_tx_init(priv);
 	if (err)
 		goto free_irqs;
-	err = mlxbf_gige_tx_init(priv);
+	err = mlxbf_gige_rx_init(priv);
 	if (err)
-		goto rx_deinit;
-
-	phy_start(phydev);
+		goto tx_deinit;
 
 	netif_napi_add(netdev, &priv->napi, mlxbf_gige_poll);
 	napi_enable(&priv->napi);
@@ -176,8 +176,8 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	return 0;
 
-rx_deinit:
-	mlxbf_gige_rx_deinit(priv);
+tx_deinit:
+	mlxbf_gige_tx_deinit(priv);
 
 free_irqs:
 	mlxbf_gige_free_irqs(priv);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index cfb8fb957f0c..d82feeabb061 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -142,6 +142,9 @@ int mlxbf_gige_rx_init(struct mlxbf_gige *priv)
 	writeq(MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS_EN,
 	       priv->base + MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS);
 
+	writeq(ilog2(priv->rx_q_entries),
+	       priv->base + MLXBF_GIGE_RX_WQE_SIZE_LOG2);
+
 	/* Clear MLXBF_GIGE_INT_MASK 'receive pkt' bit to
 	 * indicate readiness to receive interrupts
 	 */
@@ -154,9 +157,6 @@ int mlxbf_gige_rx_init(struct mlxbf_gige *priv)
 	data |= MLXBF_GIGE_RX_DMA_EN;
 	writeq(data, priv->base + MLXBF_GIGE_RX_DMA);
 
-	writeq(ilog2(priv->rx_q_entries),
-	       priv->base + MLXBF_GIGE_RX_WQE_SIZE_LOG2);
-
 	return 0;
 
 free_wqe_and_skb:
-- 
2.30.1


