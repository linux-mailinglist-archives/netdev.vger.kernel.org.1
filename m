Return-Path: <netdev+bounces-35888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCF7AB7C5
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0BBABB20A9E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7C436A1;
	Fri, 22 Sep 2023 17:36:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6127709
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:36:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFFACA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndyi2ZOq5VYz1aXkrdb4dCuGAeG4+Y4j04YloN5/dTOU1e78D877+Bb4vnyUPIS9TOUvOKPyFzfyuw2wooZ0TYwkHxa+HIQ20LN7ZoOFRagqRkyPtGLXJPpAAqaDnRKLkOiEEZTc7lI/PygVkFw1CuzEDi4g65fr5BpGsbnHG2JtxqV2Bug/P2NpCV0RiLSQc4kaMinNj7LxxVv2b4Uvbta3g3CEYQWC9UzTv7zoxomdLHwPZZ6WeD17yALCZQhgoDQY1TydBwLVG710OwKxzOOUZesFS7mjBnKf++7PHldQcR5IkmUq47bxKi7rIL2eSPjh+bJsdh8iQIHSyZTodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kftcsyrSR/iwqsPInWpSLKsnh0Zng68hHYcuTpB41zk=;
 b=PrmCB2G4ic5ZU5TZeBCN3VN19bcUQ3JL6bziqbLECtvvZcgJlGSkT8n8jIwl/hXqpHH0o+hJI/vQz4p0j+1jADGnMXqGF7K40WFo5C5f/pGWEw5SaAOHVgpwHE7PLqx3BbgwfkH1Jkp0rrqAPzmDrSZ1ZLM7qliRZQ33Rd4sx77YdL5BXrIh2zEZIHmHfhsBwZu0QD+LDTEf/HtLts3PXdfVpqovCa+k4FXiL42i/9QbAKVddl5H5kZBe//2XkTpJIJscoqSbHf+FQPEo4oaBzIDQeWPjKhYRKAvn1YK+fmSCBELsdEfcoGZLuWq3Xchouxk9VJFiM4T41Sgn1B+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kftcsyrSR/iwqsPInWpSLKsnh0Zng68hHYcuTpB41zk=;
 b=Aw5L1HTNuypVAFl49X/b5GyX2n1Bj4UQEbNZV1XuYkIPSDHu0Gwq4jvdJQAXWsCMn/fm6PYRbZM+M8FE/zIKTDdpdEo5Tm/2QvzCYEwfRBn/45YkQPJbiuQm7d4CNXrYADxSrUD6bGEpgglDUr9B73xcBRVkbsWCCv1aG9a0bZgJEm8SzXYF8I1D4w4N7rIodSVEjdLLWQF8jelFk2oefR0FDzUnuTJmVY3VfBnk3Xai+vRwLx2vQ2WR/1MWDxrkF3xuer0W81EmAkBbUsxLZUcAT1sB4491I/CzmMfXEekrFiTG+dfRVvlbdSe3/Rekvnb/S+2KJcMnfo0ZIzTSHA==
Received: from MN2PR17CA0021.namprd17.prod.outlook.com (2603:10b6:208:15e::34)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:36:45 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::ab) by MN2PR17CA0021.outlook.office365.com
 (2603:10b6:208:15e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 17:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 17:36:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:36:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:36:34 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:33 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Date: Fri, 22 Sep 2023 13:36:25 -0400
Message-ID: <20230922173626.23790-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230922173626.23790-1-asmaa@nvidia.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c20f3c-896d-4277-f416-08dbbb927d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hzwt7jF+Glwn3xsuCQ3QQyEesqniGFVuuaaQ4N26l2P1l+0SZ2WOQokzKeV51ZdFwOahS7p+oQWltuE7s3/GrI8GMBCatBV4YUO3xCjueePpMde6LEbB9/SKEt1zKe0l9h0ozAAQvDdOrmO2pK+r2GvF358lx97UV3BedEIovEdWJNR1HonK5tUp3Rj3eAO4H9siOWYbwFFFFMyikiNxutKRWWlSz+61/i0xbxj6kqy7j90xeVbsK6w7la1KTKNe7iaWVbLwzInwVL8PrPVWQqOKyf+1/qnaGset4AFHzVWh3jnS4BzO0bEok7gr5GLxidSnvBA495n/NMiGzjKglUD8MZ95cfHaCFuF1D6WROYvXIpfs5N0PZ0Um/SGcvOeRwdj47AmsIB3z62tQIgXSlsM8tCVRXU0IIEkmUquFSOFJvDV/N0gxMME1aNRcFKuIVzVnEqYeojocai45kXmE0dsSSBmOmpfHISCP0mmUETi4RoEUv07FBLMFQAIsOEHqUsszl3seBdXUDP7n3RNg7Fh1d1JmEa9ooBhFygtqkFeGiWg7qbss1STdRubfEHTQGJ2lQaTOy2ojkN1VAP/jMy0RY99LwXxebiAtSSYjWMQNh7acta0yFf2sV/JhOU3Xxvnuce88bmsGhnhTvKrcjbxq4AW6Wq+hJy+gMg5YtUTcs65b47WkpSiu4pqfQNp+Rsfjf2HrQ1Vvkf2y+4tJKW/lMU4MT81yoBhT3hLWFaSFWMmnJwjEFqrf6/8u/OeFjW7yYhmDnQ6l+cDFXtsCA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(451199024)(230921699003)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(70206006)(2906002)(5660300002)(8936002)(8676002)(4326008)(110136005)(70586007)(478600001)(6666004)(7696005)(1076003)(107886003)(316002)(2616005)(26005)(40460700003)(426003)(336012)(41300700001)(54906003)(83380400001)(47076005)(7636003)(82740400003)(36756003)(86362001)(356005)(40480700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:36:44.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c20f3c-896d-4277-f416-08dbbb927d5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
v2->v3:
- No changes
v1->v2:
- No changes

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 14 +++++++-------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 74185b02daa0..fd4fac1ca26c 100644
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


