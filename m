Return-Path: <netdev+bounces-13081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BEB73A1E1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D09F1C21069
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7431F16C;
	Thu, 22 Jun 2023 13:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9D1E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:33:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F261BC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1D1XASVLwMldQjb1WI7i1Yzx7JipwSetl+TWcrwyjmp6yiGC+hI/p8nsCSgRjBA/FHji4t/0GcZPUyQFE8k4emqQNKT4JMtuLJsi6/cTwN0lHCR0pJWWqrXekTn0M2mLRakatQo2U40TOJ7B4Mgb2hwg9qCHhwgu+7QPT81oqafLUWaRGHt6+LknMgOkGenKcQiac7u12o/kjwo0xSLVRtXM/7dPWQcthEqVwUJlPPDRrFSGt5ZhGjg6a7BwTR22g2y+Hh9IjcTEetpUsmFudtapMOmi2w0yjf6pios7rKb/DcaaoMpOu56EsxqIy5tYZbvgAdnVUwCY2ekYkSCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrRJjg5rSb8LqsQG7acD5KHmNeRKmc7e0X3x0CKYW/g=;
 b=fPFErCN41kYtL0dO6epY4yxF5JGFIcdgc4bUeWGanVmIzmoPVBl6DWeleV+7tbqpZaRpj6KtOmthoZWbQsVzynoSVcKhdzjfW4n/1fQO0DWpGHq4DJQ4QpMoPCxkiF9whB8zNcl3T4EkxkCb4qlfoCFH2Knzl6hBcD8+c8F/mk0o0mZsl598cbwTd6GaCwoD+/5jrhL3P31U21yXPh+5i+5EKb5AZQICeMsKDKNs4hkZ7iLDpsPsOSTAtg9dIohqSvom8mZ4ZwEaet1wIJiyGDUZPw4aYBX5zfmG8pmVo1Gy0rlV0eTnJudF8E7a5YBnDwL+uzSbGrFQefehVGkzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrRJjg5rSb8LqsQG7acD5KHmNeRKmc7e0X3x0CKYW/g=;
 b=Xs7rrox73CojvJdsQi7R7h8k+vViU7L71jqLN9N7SsU0WyDtzpdjDDsTNuKj1bQETrvYUjGQUJMaIaAu0bjjAS7AwHZj1+PPreASyUosJz8j2ogCrwDeslEDTMS5L3WJVR7h/BU1HT4r3y5OfeT/JHuGkjkoucyNVrqHHx58fpERKT9sAMMMAAybK7F2ugugrfQXub7UERPK8jtJSYNfiwB6ZUHIa27P2I1cR4YZTUlQ9xTvagjbmBM4tWMXOd1FHqeuJJuMTrSsmGq/c7c6mbZu991YK7g0i3zlHshPBAzwnsvmZInmAv0zZAyJp4B+aSnjRzUpAmMQFEH31/DMsg==
Received: from SA9PR13CA0153.namprd13.prod.outlook.com (2603:10b6:806:28::8)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:33:42 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::f1) by SA9PR13CA0153.outlook.office365.com
 (2603:10b6:806:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 13:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 13:33:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 06:33:33 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 06:33:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/8] mlxsw: spectrum_router: Use mlxsw_sp_ul_rif_get() to get main VRF LB RIF
Date: Thu, 22 Jun 2023 15:33:03 +0200
Message-ID: <7a39a011a02a84164cd7f5da7985ec5b2ae01ba5.1687438411.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687438411.git.petrm@nvidia.com>
References: <cover.1687438411.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b01216-c37c-4549-bc45-08db73254b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ylbJdCyOaNVe+hRmM5A+BTpdg8+A86G/VtkqRQMZCAaoRpSZKVDGNRfoQ9vYNY4n9yvtMp1+GzWTbsO8n/UdThSuNgDCBS19epsf4gJ1+CsIwg3jiT+XO5JLm4qe0sPN+GzJ9tbHg6eWKxee20roUO+j8H+dH0nS1iwQoAN9rSleUIKnI1z63Qvw36XQfpk9zX+Y0yFMkjTw271C06Hn4qMJKCBu90vqGMul/uJsIy2eIuMuD9+K74c3gI42fmvWbq9fnY2KOwcGvnxF3vBg/JT3v0odS2aLCTOGJNtFZSX+awEnEGgByQAo4Jis291aHbPfsSLVuzZdwCWyVp42VEn35A1e564QEkszG4bSFJDJUzuTEFAaTlCk5ekKagTOgPbwRboZ2K3MHg8f/y7ez0W+KitKNie1DL7V0/h0kjDQo6P4rLH65ItRg3k9edj7hyq0WwBpOhjZQDI40DXoTxihCw7n/m7z2KfqyNxFbr0+hhyyVPM9a59WV3tjF+XnFt5aJV5edPehh+msjiB566ms/lxYtYP9MMniHknSN6d2whtfPsNvvlP1g1rINd8zTJNpMO0U1r3Hfdg8fQhX6Y8aT/t6ITkG3K1Gi+SC1Ba0BxQ0yRLiQB5c0MqDPqD/XgBu77yPfDX2Qg3YeRhqe4ThytaJftFC8/eAv5kXWM2VQQvcdKiRVLml3uqBAGcZdulvRJVPky32ok4Pd/pl+Jd6EEvtozIuRzJarUCzYPc0s8yThP0YZaJSExAGrAJ5
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(40460700003)(82310400005)(7636003)(356005)(82740400003)(4326008)(86362001)(2616005)(316002)(8936002)(8676002)(336012)(41300700001)(70206006)(70586007)(83380400001)(66574015)(426003)(107886003)(478600001)(110136005)(54906003)(6666004)(36756003)(186003)(16526019)(26005)(36860700001)(5660300002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:33:41.5249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b01216-c37c-4549-bc45-08db73254b46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current function, mlxsw_sp_router_ul_rif_get(), is a wrapper around the
function mentioned in the subject. As such it forms an external interface
of the router code.

In future patches we will want to maintain connection between RIFs and the
CRIFs (introduced in the next patch) that back them. That will not hold
for the VRF-based loopback netdevices, so the whole CRIF business can be
kept hidden from the rest of mlxsw.

But for the main VRF loopback RIF we do want to keep the RIF-CRIF
connection, because that RIF is used for blackhole next hops, and the next
hop code can be kept simpler for assuming rif->crif is valid.

Hence, instead, call mlxsw_sp_ul_rif_get() to create the main VRF loopback
RIF. This being an internal function will take the CRIF argument anyway.
Furthermore, the function does not lock, which is not necessary at this
point in code yet.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 0b1c17819388..15ce0d557f39 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -10564,19 +10564,20 @@ static void __mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp_lb_rif_init(struct mlxsw_sp *mlxsw_sp,
 				struct netlink_ext_ack *extack)
 {
-	u16 lb_rif_index;
+	struct mlxsw_sp_rif *lb_rif;
 	int err;
 
 	/* Create a generic loopback RIF associated with the main table
 	 * (default VRF). Any table can be used, but the main table exists
 	 * anyway, so we do not waste resources.
 	 */
-	err = mlxsw_sp_router_ul_rif_get(mlxsw_sp, RT_TABLE_MAIN,
-					 &lb_rif_index);
-	if (err)
+	lb_rif = mlxsw_sp_ul_rif_get(mlxsw_sp, RT_TABLE_MAIN, extack);
+	if (IS_ERR(lb_rif)) {
+		err = PTR_ERR(lb_rif);
 		return err;
+	}
 
-	mlxsw_sp->router->lb_rif_index = lb_rif_index;
+	mlxsw_sp->router->lb_rif_index = lb_rif->rif_index;
 
 	return 0;
 }
-- 
2.40.1


