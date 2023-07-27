Return-Path: <netdev+bounces-21975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ABF76582D
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7AE28241F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7071418024;
	Thu, 27 Jul 2023 16:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AA19881
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:00:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A36ABC
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxgW2YR4mVTF9EdLisNSLv+K/HwinaHvnqeDzd2TTg1NYQ0eCYAPvwuccH2MFd1lTMQtnlxJg5emptT7Fg8uLCLfEsB5d2YM+9EhBeXCSdCYaOGu7viG1/E+nRTVVRnWvvSgrX4wPhqioY9BQJXvluuGNVu+AHHLyTDILWb4Gom0NJzplLvjWT2OHIBag/wZD8TAC7OLilYVl6hYEBGHFBLzmc4ToqSL8zm6NJ8eX85jcpVshggWI/KHkbuyz0QP1H/5OQY94PV47A6YeO0faw7DigY2mdFL/qjek79VJdZazv7hdYLBovH75g7UFYq0gNjMFxhahxy/eH9PR0IQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI/1D6h8az6sW/WZ4ko+e2xjaNWNlHfN6HEIUHFxccM=;
 b=B9GS2dRKQbyMshh909x+PJWW8p8IevgGESSxdKWdQz1R5cg4ZJmE0SXUUz4tES1FbgcJHMrFZzVR9772vZv+ts9p4F7eoSauw+yoq35x/hmg6xTacNEX3MPk83ri4yZn9/unSSmLhPzCbCvqcwx2Esb25U/nP/Xmy2PcKmi/FRhCIL0OWjX/igAdK+j43hl710pf+YcHKRuePz7N9IFfJlY4nEGRGwONi/20/mm9+Skhu4aj6fEWK2XkFiy97Y2LTg7Srw1fvz1SBKxRBNnYCnhqL848Mg5n9eTqhd8UPGKdq3oMOGhdq3lZDX29TUsdHsFLUiOWtPb8lnNCCllKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI/1D6h8az6sW/WZ4ko+e2xjaNWNlHfN6HEIUHFxccM=;
 b=q9qDLb1RWdLItmRLMVMfZ+VDAxmxt+Y3cc+bLhgwiU3XZATBmqo3fna7UvVF3hgJxdVD1FhoLHCtjBbg4qwCBwCPVT2/cbDp14yBHYYxpj2zy/zQYdoSEwvckXK2/y7B6FVvjV4MO3LGRTrfc2QMsNkWaOHqZ6o8auQiXL6DFwiPzJVOta3vcZSNve/9QJ8ohQTIKep9tSt62qLnFFhYHT8wIeSwTtgVFZvaGVARd3qkLjc8hBXa0XfrLmwcsflAfsATYjtFz8XlzLu2MsDUk+PB7EPnLIxqBvLzazR3xrzagYZC4qogNjmClkeyOmr0EQ5ir3phxMQXzYgNrJDX2w==
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:00:15 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::9b) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:00:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:00:04 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 09:00:02 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 2/7] mlxsw: spectrum_nve: Do not take reference when looking up netdevice
Date: Thu, 27 Jul 2023 17:59:20 +0200
Message-ID: <341d1046f89d8d839d9d00e4a3d58cdc351e9397.1690471774.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690471774.git.petrm@nvidia.com>
References: <cover.1690471774.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acdf1c7-6a40-4ed0-dd11-08db8eba9139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ns891eDbbCEamWWx2b5we78tn97WIziT2Q02Ugo7xZg+sNVrupphkenvobGU6nIxUN0rjSnzQEBpZ08MlRFDO1YxoZ94mRNgBv9+Taw4E4XOCm76pZCtzZ8pUNPzf5lDUUcFPlIFEmB9EjDvXeSWGi6VgOPYXfqsvSz7x88nFzKsGFEI8lVGxxc2C73rZzttlFJLDFDc/zFZKTA6p2s+kipwKV4/328+W/RpASdrPpyQYzfqfJ0liLZcikmht4+VSGylja7dya+K2F38rx54woc8ZPrxVFmGIh64GvCMuxnTrlmWjGqplOGOEKWl/oFXxSWUug/wNn11DZqO9WhBIL05vakc7QbFO5Wvcmfc+jmccqjOcEYSp2PdSjWY4rVKkuXvhly3fKZfYK17lWyv4Cy6G71AxKMYz3ejeQijeFCsT0nA3QsoCeqy0EaYc0UDlHE2gqkBj9eaasxgI1JOYl4jGHG7//i8QHv2KAPNCQ6QO8R1GVx5HC+a5yA0IxSOeaiUsKx1hx+vidp3szXjVFkufO5cQJnWML8u08sW5z3y01Q3ORce4H1xpLimPBJCyfNsSzAykhxLTOyXFzg9NOrBuoJcRbUG4opy+9t8AQGOQqkIpF00uhRf7X1pGfgRw6K0d2YNDvQeuIk3BIMJCnLYwWAOrFSDy4+sdvotyUsO2AoGGzsnt9b4aj1AaPmxSnrIM/X58fc6AqkCshR0pCmtwYkiz1EUghLkmAr2v4aEzBpDmSXAex75sXrUpSl
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(110136005)(54906003)(7696005)(6666004)(478600001)(36860700001)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2906002)(2616005)(47076005)(107886003)(16526019)(426003)(336012)(186003)(26005)(82740400003)(7636003)(70206006)(70586007)(4326008)(316002)(41300700001)(5660300002)(356005)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:00:15.2575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acdf1c7-6a40-4ed0-dd11-08db8eba9139
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

mlxsw_sp_nve_fid_disable() is always called under RTNL. It is therefore
safe to call __dev_get_by_index() to get the netdevice pointer without
bumping the reference count, because we can be sure the netdevice is not
going away. That then obviates the need to put the netdevice later in the
function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
index d2b57a045aa4..5479a1c19d2e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -989,6 +989,9 @@ void mlxsw_sp_nve_fid_disable(struct mlxsw_sp *mlxsw_sp,
 	int nve_ifindex;
 	__be32 vni;
 
+	/* Necessary for __dev_get_by_index() below. */
+	ASSERT_RTNL();
+
 	mlxsw_sp_nve_flood_ip_flush(mlxsw_sp, fid);
 	mlxsw_sp_nve_fdb_flush_by_fid(mlxsw_sp, fid_index);
 	mlxsw_sp_nve_ipv6_addr_flush_by_fid(mlxsw_sp, fid_index);
@@ -997,15 +1000,13 @@ void mlxsw_sp_nve_fid_disable(struct mlxsw_sp *mlxsw_sp,
 		    mlxsw_sp_fid_vni(fid, &vni)))
 		goto out;
 
-	nve_dev = dev_get_by_index(mlxsw_sp_net(mlxsw_sp), nve_ifindex);
+	nve_dev = __dev_get_by_index(mlxsw_sp_net(mlxsw_sp), nve_ifindex);
 	if (!nve_dev)
 		goto out;
 
 	mlxsw_sp_nve_fdb_clear_offload(mlxsw_sp, fid, nve_dev, vni);
 	mlxsw_sp_fid_fdb_clear_offload(fid, nve_dev);
 
-	dev_put(nve_dev);
-
 out:
 	mlxsw_sp_fid_vni_clear(fid);
 	mlxsw_sp_nve_tunnel_fini(mlxsw_sp);
-- 
2.41.0


