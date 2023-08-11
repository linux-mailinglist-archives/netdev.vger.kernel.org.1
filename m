Return-Path: <netdev+bounces-26835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38B7792A0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3F21C21761
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74A29E1D;
	Fri, 11 Aug 2023 15:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C263B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:14:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25230CF
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um++wYZYyF3bpqsemA9RwhkUlgJbHJgUPzBg7kviJ2WOkGHLfe6TkuMzdbwKcjY4uazBBeiYvW9joXMSOMdKAIylZKvyXshOSFFe8idbuWV8jSqsCyd1TUiSJOP9vUStliJsiTqX73pTjb93bkn3tg3rt/1PwIscRRzWL1kHleadYuoNGR/7mSx7v4vyCqyG4Kf0cXCd4RnHy/OwR/A38eAwWfxQzKI7VfOWDE/W0+TKWCPE0RL7Tr/JadZB8g8VDQ/2hnxZAbS6CT1Hm+YvNDdrB9mA1LYY/EmJkYG+vGa0/CFhtgOdtw3dpy+hJDOvgXcVrSTJgzMSgZKshz2CaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4wvp/z5fRV51d2LRCBMAZDdrYVZJ/DVy06iM5GphYY=;
 b=XGjiTCg0aCirNKVnhHK+tZQcSX4PhW1VNWDVFWfuroqISRFFZyRVBkeJV1zN4zFLcjOgvxnr/GfE+zrbBYGVlk9PY8/HABUOx3lIy8y6/ikAI2ldcWi29nPMBzBCgvUuCkk8cA8wf1iuM4bgwd8QXdOG1yH4Ob3cauY7AiMCWcaCb94oTwYljIuK7pQKjGxjANC0cSBtYTWe7IPlwahTnDnDnVSA8JzRettHAqdhJWRohONgAcqWc3MkzmOzRbCvbb8hBLqhQ2yBj35sXlJWIVGrLiO+5fMkVkDve2vqhQJ5TSLiJoQ/Y8DeuidIOHfs5yJZft3x2Hn3P/mGlvlwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4wvp/z5fRV51d2LRCBMAZDdrYVZJ/DVy06iM5GphYY=;
 b=I9IdARZl18NzTFNSIgVkZoIW1OuaH9LnqB6o1mF6A5uBxOR5lOwpviAk7i4Jb5Bg8Zd0s9vehcKZ/wa58QSGlZsX1b0Hogk92/RrCElkD45VDnzGBFXv78MSjgTMmTmpTkrrlf9njy3w0KgOrQVbfUZNsQyKh+MkuoHk3BgwZWDZIg461NoYdz5u6U20ijuqNmoRRh4lpKwCW6SP8imEn7jvewVxWjlVnAiYE3qhHZOUwkADv0mlSp0ByY1FXEOGaVCjJjPbtH4qwyi90OxBG+6qf6fGFi1wmE1tatZC7lKFnK52/rV/JWba0Ka8a8Hm4UFI0szQuM2mLrfna6JNMw==
Received: from DS7PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:3bb::24)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 15:14:42 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e4) by DS7PR03CA0079.outlook.office365.com
 (2603:10b6:5:3bb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:14:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:14:28 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:14:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 2/4] mlxsw: spectrum_flower: Disable learning and security lookup when redirecting
Date: Fri, 11 Aug 2023 17:13:56 +0200
Message-ID: <25a88ee9e0a1d9bd9d3a78376f3b6ff02bd53bce.1691764353.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691764353.git.petrm@nvidia.com>
References: <cover.1691764353.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2143b7-82ce-4d3a-9a73-08db9a7dafbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GTIAAGGmSCaeBvkIq7tMjoUxbB1mwjKRVM9UT1KiSFTjEKmuP32n4yq9VYMDzUhWp7wMl4uSV7h3j8h2kq4v5ms8Ts9oevpQi7QFI1A7yHtDABR5/b+KifpdEwHHbhtXUJRs++S90QpN5nOTPCYJQEKPWjXhs39FJvV9qxB2sfp+BfK//jw9I2mmGm2aDq5YvhUPImc+zf0gVHqE04Q29LAgOGe1K4DWCII+xOEKLE5Za9OJz07Bqk/FJd1z3i8wEt4A+rUlwOXaJdZgmyS0c0M0DZmsWi+RYbqJ2Kmquua2w4IAEd72RPpH1MfzQq0HUq4nT9bWWIthM6TmQNvOLNNzXlkyopYdE2fXApgDfJa7VK9EMcY4TDHFjtZPzeGdI0Wa+08rh8bD0N5rmqd/OucAzh3ZmDrRoH4baTEVDKY5LHA4GTU85GHckefy6IQeHvEuGWT3rbYHTtia5vmSR59qowuM8fb9WtUx2aImd5/TMVYm1UyaPzgdzLiTPTAJ1AixnJ9opRfH2/T0P1DMm1gFTONBO41GuRkQq2Pwj1euUZehfRjcEnv/t5wGW1LphJxWrXsI4y4Y+lw3yZXE8AlCj4UEdsdynYYoAc6vDkV6sKElPujjdyWq6buR5dayPTVXtKPCFANhcMDRTShWYWKxCBxeswzTEgaGUPE/dhgrDmsg7ikT7RiyewUS3DsrmeGKo3/szqBLYUOw9yYd4m2gNPedKuHIgmB1UgOVy7xLNCtZ+C8iKqFlll7NlIW6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(186006)(1800799006)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(86362001)(40480700001)(356005)(82740400003)(7636003)(36860700001)(107886003)(16526019)(26005)(83380400001)(47076005)(2616005)(336012)(478600001)(110136005)(426003)(54906003)(6666004)(4326008)(70206006)(316002)(41300700001)(8936002)(8676002)(15650500001)(2906002)(5660300002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:14:41.1613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2143b7-82ce-4d3a-9a73-08db9a7dafbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

It is possible to add a filter that redirects traffic from the ingress
of a bridge port that is locked (i.e., performs security / SMAC lookup)
and has learning enabled. For example:

 # ip link add name br0 type bridge
 # ip link set dev swp1 master br0
 # bridge link set dev swp1 learning on locked on mab on
 # tc qdisc add dev swp1 clsact
 # tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw src_ip 192.0.2.1 action mirred egress redirect dev swp2

In the kernel's Rx path, this filter is evaluated before the Rx handler
of the bridge, which means that redirected traffic should not be
affected by bridge port configuration such as learning.

However, the hardware data path is a bit different and the redirect
action (FORWARDING_ACTION in hardware) merely attaches a pointer to the
packet, which is later used by the L2 lookup stage to understand how to
forward the packet. Between both stages - ingress ACL and L2 lookup -
learning and security lookup are performed, which means that redirected
traffic is affected by bridge port configuration, unlike in the kernel's
data path.

The learning discrepancy was handled in commit 577fa14d2100 ("mlxsw:
spectrum: Do not process learned records with a dummy FID") by simply
ignoring learning notifications generated by the redirected traffic. A
similar solution is not possible for the security / SMAC lookup since
- unlike learning - the CPU is not involved and packets that failed the
lookup are dropped by the device.

Instead, solve this by prepending the ignore action to the redirect
action and use it to instruct the device to disable both learning and
the security / SMAC lookup for redirected traffic.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h        |  3 +++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c    |  9 +++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8da7bb04fc3a..2fed55bcfd63 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -1050,6 +1050,9 @@ int mlxsw_sp_acl_rulei_act_count(struct mlxsw_sp *mlxsw_sp,
 int mlxsw_sp_acl_rulei_act_fid_set(struct mlxsw_sp *mlxsw_sp,
 				   struct mlxsw_sp_acl_rule_info *rulei,
 				   u16 fid, struct netlink_ext_ack *extack);
+int mlxsw_sp_acl_rulei_act_ignore(struct mlxsw_sp *mlxsw_sp,
+				  struct mlxsw_sp_acl_rule_info *rulei,
+				  bool disable_learning, bool disable_security);
 int mlxsw_sp_acl_rulei_act_sample(struct mlxsw_sp *mlxsw_sp,
 				  struct mlxsw_sp_acl_rule_info *rulei,
 				  struct mlxsw_sp_flow_block *block,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 186161a3459d..7c59c8a13584 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -775,6 +775,15 @@ int mlxsw_sp_acl_rulei_act_fid_set(struct mlxsw_sp *mlxsw_sp,
 	return mlxsw_afa_block_append_fid_set(rulei->act_block, fid, extack);
 }
 
+int mlxsw_sp_acl_rulei_act_ignore(struct mlxsw_sp *mlxsw_sp,
+				  struct mlxsw_sp_acl_rule_info *rulei,
+				  bool disable_learning, bool disable_security)
+{
+	return mlxsw_afa_block_append_ignore(rulei->act_block,
+					     disable_learning,
+					     disable_security);
+}
+
 int mlxsw_sp_acl_rulei_act_sample(struct mlxsw_sp *mlxsw_sp,
 				  struct mlxsw_sp_acl_rule_info *rulei,
 				  struct mlxsw_sp_flow_block *block,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index af3f57d017ec..9fd1ca079258 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -160,6 +160,16 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
 			 */
 			rulei->egress_bind_blocker = 1;
 
+			/* Ignore learning and security lookup as redirection
+			 * using ingress filters happens before the bridge.
+			 */
+			err = mlxsw_sp_acl_rulei_act_ignore(mlxsw_sp, rulei,
+							    true, true);
+			if (err) {
+				NL_SET_ERR_MSG_MOD(extack, "Cannot append ignore action");
+				return err;
+			}
+
 			fid = mlxsw_sp_acl_dummy_fid(mlxsw_sp);
 			fid_index = mlxsw_sp_fid_index(fid);
 			err = mlxsw_sp_acl_rulei_act_fid_set(mlxsw_sp, rulei,
-- 
2.41.0


