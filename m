Return-Path: <netdev+bounces-30378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE87870B3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9AD2815B8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25BDF5D;
	Thu, 24 Aug 2023 13:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7C1118D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:45:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63B19B4
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWSjMGT9iGHR0t218w6QW1rPTHpGiCYq1dkyYE1r0B4oyb4dlKndQfJhqEK4XCoeOyBoC2Xw26HZyVo5cmEAzTiY/HhasYFbVOd3LAhpNM35/lH8jwr/m91xGfx0jwpRcGM3fD1SfCzMepjHuvzCkvfdbbwomDr690fyrE/QtAv8KoD7S3WAM4MaWTRUdIUz6qRUe3Chnjh2QlFpHZOhC8xbjT2Q8bzPRlpmHFVmYDBbIzhacGh7U5/BlXAZ/ijTgNOIDP4+GipXiV2Ul1axkDBsgc1YpBX5ifAOieFKaf1TwkzNfmBJzFtEdF1AESqNM96HLWGu396NWyOBzNBLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL4kQVyh/wrQF4o//3OdKeUvHrr7e+lglpX5xTnLVBA=;
 b=Be7DFMhe8S/q4Kup/vB/10F4AoPTdP6tqCj7boQhU/ZRPpgPCp67PMh5B6O+PJ5mYiz820wZRFF66iifvgK2y5l4Wh4667WAvXIUvPdIOcr6B1UXup4nOxBbaiisgtw6n8VsTDXUNZcoTG8Nyl5dZmPaZot382CLRlBAYPmNmt0CYf2A+yzJ+FMQFbGLWwoyIVKpZvJXjlcopgO3mOghC30A5BFOl/E/em1F/wukXmmSSCN7yP9oacFIjBuS01jbx4N34QhhcHcBNuV8Lz89KuPHtuFnixtXG1bn8rjstwQhGgJ/LNriD0Sg2lWQzgrbIRGzl0rDwzS0HBv8A7KZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL4kQVyh/wrQF4o//3OdKeUvHrr7e+lglpX5xTnLVBA=;
 b=pVp8P9qL5Myt+NTB6hoUlTj8b6i0zpwrC4A8+756NL/opEhOEjJHPaeSenGEw+qbqZ2UEfjezWgWrND32WojQchz/K7yKrHRH1/lrZSKtfivpT8YADTqn5PP6yYsQr7kpuh9HYoOVQc5VjkjhWsu53hEssNp8CVP1kM3R5QGmgg6N4wmEMK8wdGVAgVXNBL7lZip3IQlGD3BkPPbc/u52GTcMpf5xJpO6C3rXCHajS7IhaWF0VufMhe5ANIWbRimWQoRFYpxvJileLuVv8hr5QzDEyfsnpxgCtqb9EfXxbh/OrJJqJrvSIW1OCQwGrk24QHVk9FH1DKyPzO9bEBJdw==
Received: from CY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:930:17::6)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:44:05 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::54) by CY5PR17CA0001.outlook.office365.com
 (2603:10b6:930:17::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 13:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:44:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 24 Aug 2023
 06:43:53 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 24 Aug 2023 06:43:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Vadim Pasternak <vadimp@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/3] mlxsw: i2c: Limit single transaction buffer size
Date: Thu, 24 Aug 2023 15:43:09 +0200
Message-ID: <8b083ce42e395da966fada1e93524e180660121a.1692882703.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692882702.git.petrm@nvidia.com>
References: <cover.1692882702.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ffed1d-dfba-4019-6c11-08dba4a82e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Uz+sfv87Tj605mg1YOteVzzAZ/rZIHKdTHHJyUgd8h9S2u9kT1ARca4ukJUqJ5l0XM5yky1mLzrkDk28CwoWkWglJYq7STXAyj10+U3vjvob9Q/nq8/+ZnkRqJeLRcl9NyJFM9QsT98pvRkTIuRwBBBXpRLLuz/4rj2w5wwC8apLJeEW34szdZqGKeESN44RUqwH4Y5P9CCyoJ4YeLnpH2K6X8Z0bHg/smQBbMGku66WlnhNJPUwuZdyRbkG59rU6sanTtzqU4onG49ocPeB/lgipNB4CtkpLzim9H/SjOf3pD2J/H6wqcfBGDAirX1d0FneIB00pIxcHVzzrvZuWAQj/NXv+QDygNHxOF+PxIYjwDvrcoBrjbGkeaJjJxjzVZvJhmZBGBQol1DQZp0OWGPB2Zlf1G1hOoJWHGMA43+RxmnoJMne21DrnSrCbPm67ok8qGdItohsNdd4EU5nOG4sfY2D4Xq+Yj2nAFkBfQqG4MXU3VddMZDle9Gqu5bEgVtzAna/XkzMREOrXiXM4mKvGJf0g9Imywv3R54ntvJ38YHqW7yjFKooF8Uo+Sd1IiInF5hHwICLUHZmIJ1sE91BxnLGNfh84w4Sly1kaJYNZU5Fzefn5/AR80DRDZdpszPAnxWoX+ZeDFDZHmIs+GLCZV9/JqrtcG+yDbeCOJ/UcAzECzbIBi5ngpaqF4nd6IVs9cKnuTafiTrUsfPtxbkdmRhmahZyQCiqK0doh4tjSG9KhPYE/UOmtzGJ7vA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(478600001)(110136005)(40480700001)(16526019)(26005)(7636003)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4326008)(8936002)(8676002)(83380400001)(2616005)(40460700003)(107886003)(5660300002)(47076005)(426003)(336012)(36756003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:44:04.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ffed1d-dfba-4019-6c11-08dba4a82e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vadim Pasternak <vadimp@nvidia.com>

Maximum size of buffer is obtained from underlying I2C adapter and in
case adapter allows I2C transaction buffer size greater than 100 bytes,
transaction will fail due to firmware limitation.

As a result driver will fail initialization.

Limit the maximum size of transaction buffer by 100 bytes to fit to
firmware.

Remove unnecessary calculation:
max_t(u16, MLXSW_I2C_BLK_DEF, quirk_size).
This condition can not happened.

Fixes: 3029a693beda ("mlxsw: i2c: Allow flexible setting of I2C transactions size")
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index 47af7ef7e4ee..d23f293e285c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -48,6 +48,7 @@
 #define MLXSW_I2C_MBOX_SIZE_BITS	12
 #define MLXSW_I2C_ADDR_BUF_SIZE		4
 #define MLXSW_I2C_BLK_DEF		32
+#define MLXSW_I2C_BLK_MAX		100
 #define MLXSW_I2C_RETRY			5
 #define MLXSW_I2C_TIMEOUT_MSECS		5000
 #define MLXSW_I2C_MAX_DATA_SIZE		256
@@ -653,7 +654,7 @@ static int mlxsw_i2c_probe(struct i2c_client *client)
 			return -EOPNOTSUPP;
 		}
 
-		mlxsw_i2c->block_size = max_t(u16, MLXSW_I2C_BLK_DEF,
+		mlxsw_i2c->block_size = min_t(u16, MLXSW_I2C_BLK_MAX,
 					      min_t(u16, quirks->max_read_len,
 						    quirks->max_write_len));
 	} else {
-- 
2.41.0


