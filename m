Return-Path: <netdev+bounces-35084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1B7A6E7A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F941C20A0C
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A93AC32;
	Tue, 19 Sep 2023 22:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6E3AC2C
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:14:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74BCFC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOzqcwKzc38UKfUIAMKgczxf/+kM46j6Bm1UmnuZc6W5HD33lb2ChCMQTVFTWDt3RWTci+U5jAE3GaAZ3OeThT2ktLwb9IP9+RCJqy/nGBgU42/i5npkyjT7ehJ2WdLcz/UQ7s00t20UyAG8qQ9U2DN8Wx282Rn8TX3d3KegTIQv31m4oy08FB4l+R4OOBqDPm2fsVLqqpITQtthfRtn3UNHayBNAGvoR0rCnGra5KW6Wo1CV6lPPwBXplW5MgfUTmMPqBfUX8CLpfPkmw3zfm/aiqTgw+Yt2XUdK12RdoMJS2lc5LsZTDxojagGuw2wibdz9PfQ2WcnlFR4Tewbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c09YQe3bv9SCJdaRzX0t17PL0KdilIxLfl/lutbLh8=;
 b=gC1aUaUVu7YxAJcuHrVZ7d9qqAoOFLLAqXtVfjkNl4i36Eyew2Oq+3QnITgCnP6TlYe4iYSbVOIu6AynSsPqqzbjtscmjtQy/HIzlbhb2kU1gXj328UoZ5UasE7jCVgo0sI4p1ZhKKPlMLgI9gMABWcYPEUtQVPWTmH6POHknSK8WGprbuAI58mzf+YFniUOFydDo3JYItwYuJEzv0ttSQj9wvCMoC5jGOIaG/GHoXKOGk3kpqOEb1fMrH3zzbfIRt7P9T7awc5RMRvQds9tHmkI84A6WNxjzxnl9GTqnmVGV/m1nOFZzJbGiklhZWlzOvuAgZlqzf8pn6obn3zasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c09YQe3bv9SCJdaRzX0t17PL0KdilIxLfl/lutbLh8=;
 b=RAgx2sV1s6dEsLK0IbDV77i2y9AiUA3br4HxK8gonoo6z+GS65xNl2TrRgXIkdSrd+mJDLCF06crulEnYXA2XAM6l6i2tk4+yRU6mHJ9GogX4KPAjss542qVg8p5SZHayuMRCluTUwIiq2R07enjK7WKQR8dJ7y9fU/VMNQT7NvHSws6zXL8HJu8KC4GjWrm4pCBz2cLapIP6OuLXR7s6nHeRS5/2MZpM/mnFTZWIT94yJMGZoXvWyXHln7scCF9tddimNQrAj06iRloxl1kO7WjH8bPvP3fpC3slypsXy8BA/Sx9YXJlaHxfe1rpoxXNsR2F+S15nI09vUlQ1XkSg==
Received: from CH0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:b0::34)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 22:13:26 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::a8) by CH0PR03CA0029.outlook.office365.com
 (2603:10b6:610:b0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 22:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Tue, 19 Sep 2023 22:13:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:13:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Sep 2023 15:13:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 15:13:15 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v1 2/3] mlxbf_gige: Fix intermittent no ip issue
Date: Tue, 19 Sep 2023 18:13:07 -0400
Message-ID: <20230919221308.30735-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230919221308.30735-1-asmaa@nvidia.com>
References: <20230919221308.30735-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: b89d9af2-3118-484d-9288-08dbb95da591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7v1Z3E+tXwKrW9YXYMKxUF75HSVN8VIa+A3e3g+D8Mt8BO0LBixQ19Tb6G44AB4nuy2yiRgWEokbYnx5KG1AIfPig8jy4V+4F8MOrMrtCD+BUh/XQ3Zpdrwj2ViRZgTGLWkAD26g9vK/oZ+mjXAhf6OoxPOp1uNCRxJ/dz/bLCYZuYPFwgcOXIx6quxzGVBqOoZF9J05gA/+LItl9MmphnzLQHzBSboddPofOE9c2+rbBvljrh/ad/ISvlpnLpf7fg93+tmjrspZFRkTZRH2VBndw/tr8zcq+51P6Hw6dSBor8Rx63dZbZa+6IEedAN7BcVqQjnj2slquhHkVvSQYzYBMnGp/3EZ9Ll9wJO/KePEMg+FRVA80e3SkAvFRjY7tzoj7NeP4R977M+v0vy+sqIuo8mABC9vZJVbHrc5zsmm3s98mcY91AAZiY8E0O6ye3BOFTGW94HhGIR49py6Hxp/LFvWlh+u7kGJCkq6umpoLb38HbsYzC11cDD+VOm00DcccD6J6Fwh2evzthkcfXKCh99lqcTq+SvQ0nBPtoNW/ddwUFTfE0Lhik9+PTGAcWpadel2vNwQHYR3e7+Q5j9hgQ2U8Se2Unttl0c1SyO3k5LFiRxBdctdfbXgKf9XLrgXI/5RFXSuOCU8yxV7Gme8nA6zaKLoLfeTO1+jPo5ENiZzl6db1zr/n/ZqggqZp+8MZ4TDSzx85W6VuMJtfCWZR0/mENSJnsg+65UxBIbR4i9Tz8eALRp8RBRa4BdZ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(86362001)(40460700003)(36756003)(356005)(82740400003)(40480700001)(7636003)(36860700001)(107886003)(1076003)(336012)(26005)(2906002)(8676002)(426003)(47076005)(83380400001)(8936002)(5660300002)(110136005)(2616005)(4326008)(41300700001)(70586007)(54906003)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 22:13:26.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d9af2-3118-484d-9288-08dbb95da591
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
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
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 14 +++++++-------
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 694de9513b9f..7d132a132a29 100644
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


