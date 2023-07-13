Return-Path: <netdev+bounces-17649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61749752828
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFDF280F40
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196891F92E;
	Thu, 13 Jul 2023 16:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF11F92B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9C726B2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmiVFEEQ/Zw+SPG7RozFDcXNnARh/Ywq0YrKlfUjlMHS/791bHD6YA90GyC26OB4WSGa4SovLNoKXR3T9TrP+lnp+3YhEkpKqJ6tgscDCaBmo8K954mNEbTQYKRYy5SQc3u0dq5sU5JXFcTwROWIrUsZ+ZtQTjTyofVHHv5KDdMeNoZXi7JWHv1vzKPxJMQgdLPnVD0lKcFkn+bBBbqsoTpRMvz1DNN84aEJDpnct1AlTlwZK4XNeiEmLpD7oGC9v+z5a2hIEczInKNFPYvY+RtQp9xvbtmLlNXOSaWz+H1tCaK+NsJW2+sf8dzI2fHo/MnssqxHUqlXFAKKixql5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+A3eK4xoha6rWPLXI99AOgvT8+ds8h3XsS4yCjscos=;
 b=DiI7pmSIkJdLF4NW8QwmKgKNYdqXhcP33K7u6iLCk6Tkj4bkZNUY8MBtka3sDXq87jEVC4N6U3QEThxKf8+EroRGCbhN4W58eoqLqjQamidHafOxevfzQwCG4Iyso30bGEzYJlp/cZ61ItDPOTlGZPUA8bb5wJ0sqZNbmkvm1Pwn4pCEyjVoI3UC3QdqsY/m1m48KAEOVeUqj0VWfl7/FDDMGcP2ecU2LfDKpiBFv/3DrU6/7o8OUEKWOkmwEFkm/InINzf7myhdtWLPkhloUtqoF1KZOJT6rgMilnRB9i1oBV3tLzPuhO//8DqkPKKjSJp0+3qvk/JDj0v/I5eTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+A3eK4xoha6rWPLXI99AOgvT8+ds8h3XsS4yCjscos=;
 b=YLF+3mmaogKp1jZZhifuFoK6+6qqt7q8Ikw6btpRyLwgx4zNg57k7vOu6bhcvVQspRjCRqU+918WDF0R0T3XfMj/7KgbqK55Ld0A9iUM/gi9ZZLIsxNr+kRiheyWg6knYEjFL1wx7IXCqgPjgUzLM3E6lYJIKyI91IDs/hSnvEbBA6CiwW1ONt6basXKJlX48f2XKIfPrVNqImUtpUDu6lHwSoESKH7sz1rrJma2ujL/bYvmf+4C0WGQ64LR/hcFIejg7PUFZb/g71APFmJA6svMnLxieSZzawxkQZ6NggcB03SysT2s6mIdhdsHLA/377y2sxuJfzaOED3WsBJUZw==
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 13 Jul
 2023 16:16:28 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::58) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:11 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 04/11] mlxsw: spectrum_router: Adjust mlxsw_sp_inetaddr_vlan_event() coding style
Date: Thu, 13 Jul 2023 18:15:27 +0200
Message-ID: <0f46a159872f3b6ba1d515f13e58198d7a1d88b9.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: de0252c6-ec4d-4924-ad78-08db83bc8324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ejmD5i8cyK5rTu0GHz7bT7d+xk+SReqRqRvh6IwMO2vK3YaNRgaG8ZrAEnfWGMqadmRGHL/DfJpjZRObG4DT4zlKLaTRFHRn2TBzkx3rNo0LlX5tNBbDjblhU9IKrKKrmciOjkTirsXeHKJ8r//BToyk12afKfz+LWFZBXFzuTg04M25s+DVTGnAbWPVQzIy06iqK3fiyZLp9ed+RnUiBSV9vyJf8syYwkJKgjxWRK/OPkAIQEDHpp140azjjfN2ob+FuZS7mqpGPblLeIyziQ5fY/eQV8fXagg+kF4Ygt4/EiwkMUhLtJrlXVoHh252FFiLjNzSfkeBsCQpTo6DT/1oGEA8ddtDTn1BD9YueHANdUVdbKeL4Z8xgD04G+1t5BLU7g7S31hPC7aWjNd50Dkc97CmV6iDfrp5zOQ6AcI50oQiyAcEzlQTzZy7OQebaVG0aF/K9aiUWU8LxdhFZ9s8PbyLSODgp//CM7qBuXwhVzkfQiO0Y+4IfkrG3etY1bGLSInh6ba87JLh2rzx5pA+OF47qahYAF5HsYdj6GplJFNqSUd63l7nEyJOSl7c2Puxrr8wFe4nw3fKnMWthVteDXuIztlALJz+3RSrNGEcnunFFfkALI3KNr0gqOlPG+YRMT6E5v8zd10ADV1smwignmzxksaXKNHDNZpTmmTo6wyKZI6gcI0jDr71u/Rp5wAFD5k1UHwVyCaF/CMp/toB7oKW06JdbNM2blkykYU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(7636003)(110136005)(478600001)(186003)(6666004)(54906003)(36860700001)(336012)(426003)(83380400001)(36756003)(40460700003)(47076005)(66574015)(2616005)(86362001)(40480700001)(70586007)(26005)(82310400005)(2906002)(107886003)(70206006)(356005)(16526019)(8936002)(316002)(5660300002)(4326008)(82740400003)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:27.8491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0252c6-ec4d-4924-ad78-08db83bc8324
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The bridge branch of the dispatch in this function is going to get more
code and will need curly braces. Per the doctrine, that means the whole
if-else chain should get them.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index e840ca9a9673..3a5103269830 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8877,15 +8877,17 @@ static int mlxsw_sp_inetaddr_vlan_event(struct mlxsw_sp *mlxsw_sp,
 	if (netif_is_bridge_port(vlan_dev))
 		return 0;
 
-	if (mlxsw_sp_port_dev_check(real_dev))
+	if (mlxsw_sp_port_dev_check(real_dev)) {
 		return mlxsw_sp_inetaddr_port_vlan_event(vlan_dev, real_dev,
 							 event, vid, extack);
-	else if (netif_is_lag_master(real_dev))
+	} else if (netif_is_lag_master(real_dev)) {
 		return __mlxsw_sp_inetaddr_lag_event(vlan_dev, real_dev, event,
 						     vid, extack);
-	else if (netif_is_bridge_master(real_dev) && br_vlan_enabled(real_dev))
+	} else if (netif_is_bridge_master(real_dev) &&
+		   br_vlan_enabled(real_dev)) {
 		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, vlan_dev, event,
 						      extack);
+	}
 
 	return 0;
 }
-- 
2.40.1


