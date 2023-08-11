Return-Path: <netdev+bounces-26834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F4277929F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D245280C0A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC82AB28;
	Fri, 11 Aug 2023 15:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F663B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:14:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991B2D7F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeFbX56yF6tihaq4xCvd2mmwARK4G/zKi2jA5Agc0uh6uVh8Rj3hnk8mHeZTfNW7JUjzYNzv3jigyCqBdm2URDhJYgkLW3A3fTMTNokkZZlfPaOz7uQT0Mc7CCDZy+I36VRe6DqBt132i2RM71djHbhfMzMsCrUafvY4fBMGEoWcwasnpNwasdErpKD0siUZnjwPcosfBw/SC6d81raqmHOaPzD7vgjFuQrsnTGD5GMzEdxr394B3GBKp9g5V+WEPEEmxnMR0IklqRpadlkVMp61OusD8EA8gpVe2O1CrdGHjhcSEgcmN8mFvusdZElRHpeH7q7jhg0WrfBstXqWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5gEKgGlkvmds0kF8PjPIPWjacfOz4BrIEjfhqsydrk=;
 b=Q697blAG5MG2fzBBLLw90NgOxF9AxgWUjhX2wTEBNCrSV5N9Mw9JAEGCY4rUt53704gyjosUk5JSNWPU//cNeuyoNKeuZPQ6gG/kmOEEc9+7XnhJ6KQdl4xCPNvkBmB3TQQ4nsuNhFhOg2V2mMXlTVh14kisk6LoJf83xfWYTRLnoACIBoS/cmy5u1qOT31Stu9YHuEETmZJwGkdWmg7fvTAHAyk10aX6fLrOTyeuzlu5nxdXJhs1vvnFww0XRLE/HEx48qMjrHpVxiof5C0UVVmcsIyqsgiR/zpsfV3mA0g4dIV8+RAJb9knBFjEHnNlntcs39C1OBrk8Mv+ZmcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5gEKgGlkvmds0kF8PjPIPWjacfOz4BrIEjfhqsydrk=;
 b=EGH6XyFNWAA5x3BhrIb30SYA061Q90sR0TpTlJ4hWBHUmitKxeamceVf99/Z2yAtvJVe4/s/aP40tOrnibHDfoJozqlRgrwnF/B43vUFBi+qwWFxxeO4L8xiOOD1T37oLy/urshO37s/D/A79OhxozMzfWTuuhlAVNlHMaca8NXAvBUAjgwikMcp8L0tB7tjepcrtWEYK07dfgcQr81jpdGARMEKXOq5rIVEqVZ4y26pbwzCV7uNVgJo4kh2pBvcva1d0nHGmOVxJ8WvRMlTf/m8HT67+UYq8Wh9U6BhlY9zCEAdOcO+Tdl7DDYY0WncBLocb3njQoZ4AkichKOBiQ==
Received: from CH2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:610:4d::13)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:14:33 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:610:4d:cafe::41) by CH2PR19CA0003.outlook.office365.com
 (2603:10b6:610:4d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 15:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 15:14:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 11 Aug 2023
 08:14:24 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 11 Aug
 2023 08:14:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/4] mlxsw: core_acl_flex_actions: Add IGNORE_ACTION
Date: Fri, 11 Aug 2023 17:13:55 +0200
Message-ID: <43912efec4eebab2bbe7e24589f258c8f22fa047.1691764353.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e406037-1006-4656-9568-08db9a7daab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3K6P0/BrkKDmEf3D36NOOrm0nPKbAbCThFVON+JagOiXtQhjJpycl6tTFIjtNcuLdVx60tp8Xn51xaXMmatIslE9tRiImp8/+onMz/UXSONJ2OuPRlPufsGiSL3jnzZArSchfYBYYyEJzFOddwy+fGEJcF5dJhGKi63qcxTVXwjb/RUzu3h6b9sZZG9ZUuvkYZtis2zrQza2nGERVE19exG7vwEGAE9PHgYEV2oclJb/Tew/QLjsr1skgnWFkTVUtG2KWfU8N3q7zyAGHcjEb7QOEI1BFU3j/K9DttJBoctpQdsdtGsposKFVkHo0gHZxgbw08tG7PrOFnBxrbTZC4zkL0WZFLxvaUhl0tcLLJe51Tl6Qb/ScwkrsHG35pzr5TSlf9y9VDcfbuWuELhF/jKUy9zAwlyMDKiQpb5sNZ5qk+kKuBue8Mh5m3XM4W50s5sBQoNx0nmhCKxt7UNd3TDZq8LE96LefpsqhJLYXgQ6pfPWGS3xAx6RgSaUP9Rs3CNlJ4Zy5W1+elkJubLVGkZVFKyhjPSzNQeh740MDpvGwEviHabxJu5KBLmiAfMDPrXI8PwpoAUXDNN6Lsj0pai90kWNe7sn9W5Vfj+A8WJO9XurRc8T2UIKBc6BqkdFEhHL6dGxlQjjMeNVW259CD2YR+ngLaVuoB8vLKvrrwBHelh8SJdlsiB6rAJE82sGGsmPduyuxSZBicY0RuZ63AFoc7jrDzQK7Eqv3Vs27tclETKhRz0a2BsS605hcmwB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(186006)(82310400008)(1800799006)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(70586007)(4326008)(70206006)(5660300002)(316002)(110136005)(54906003)(41300700001)(107886003)(40460700003)(8936002)(8676002)(26005)(86362001)(82740400003)(336012)(40480700001)(16526019)(36756003)(36860700001)(47076005)(7636003)(356005)(66574015)(83380400001)(2906002)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:14:32.7267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e406037-1006-4656-9568-08db9a7daab5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Add the IGNORE_ACTION which is used to ignore basic switching functions
such as learning on a per-packet basis.

The action will be prepended to the FORWARDING_ACTION in subsequent
patches.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/core_acl_flex_actions.c    | 40 +++++++++++++++++++
 .../mellanox/mlxsw/core_acl_flex_actions.h    |  2 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
index 9dfe7148199f..faa63ea9b83e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -1887,6 +1887,46 @@ int mlxsw_afa_block_append_fid_set(struct mlxsw_afa_block *block, u16 fid,
 }
 EXPORT_SYMBOL(mlxsw_afa_block_append_fid_set);
 
+/* Ignore Action
+ * -------------
+ * The ignore action is used to ignore basic switching functions such as
+ * learning on a per-packet basis.
+ */
+
+#define MLXSW_AFA_IGNORE_CODE 0x0F
+#define MLXSW_AFA_IGNORE_SIZE 1
+
+/* afa_ignore_disable_learning
+ * Disable learning on ingress.
+ */
+MLXSW_ITEM32(afa, ignore, disable_learning, 0x00, 29, 1);
+
+/* afa_ignore_disable_security
+ * Disable security lookup on ingress.
+ * Reserved when Spectrum-1.
+ */
+MLXSW_ITEM32(afa, ignore, disable_security, 0x00, 28, 1);
+
+static void mlxsw_afa_ignore_pack(char *payload, bool disable_learning,
+				  bool disable_security)
+{
+	mlxsw_afa_ignore_disable_learning_set(payload, disable_learning);
+	mlxsw_afa_ignore_disable_security_set(payload, disable_security);
+}
+
+int mlxsw_afa_block_append_ignore(struct mlxsw_afa_block *block,
+				  bool disable_learning, bool disable_security)
+{
+	char *act = mlxsw_afa_block_append_action(block, MLXSW_AFA_IGNORE_CODE,
+						  MLXSW_AFA_IGNORE_SIZE);
+
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+	mlxsw_afa_ignore_pack(act, disable_learning, disable_security);
+	return 0;
+}
+EXPORT_SYMBOL(mlxsw_afa_block_append_ignore);
+
 /* MC Routing Action
  * -----------------
  * The Multicast router action. Can be used by RMFT_V2 - Router Multicast
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h
index db58037be46e..0ead3a212de8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.h
@@ -89,6 +89,8 @@ int mlxsw_afa_block_append_counter(struct mlxsw_afa_block *block,
 				   struct netlink_ext_ack *extack);
 int mlxsw_afa_block_append_fid_set(struct mlxsw_afa_block *block, u16 fid,
 				   struct netlink_ext_ack *extack);
+int mlxsw_afa_block_append_ignore(struct mlxsw_afa_block *block,
+				  bool disable_learning, bool disable_security);
 int mlxsw_afa_block_append_mcrouter(struct mlxsw_afa_block *block,
 				    u16 expected_irif, u16 min_mtu,
 				    bool rmid_valid, u32 kvdl_index);
-- 
2.41.0


