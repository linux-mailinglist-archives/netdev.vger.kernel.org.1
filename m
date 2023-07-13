Return-Path: <netdev+bounces-17645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389F75281F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D881C21347
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF71F187;
	Thu, 13 Jul 2023 16:16:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCE1F176
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E43E74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hazaCP6+g0Kb+k1cCDDgt3Au9fYtzwDg22ekuYn023BN1IvKwySdQb9a8i9IsQQ+KyXRs1s/NWX/lMEXKPP0s6cWs/2e03qqDkbHWLp7QvV2KIHK8vruzKORwD1EgEJmDK/7739KwU7satSydt9kRk5soRs0xaf+OAIqLvy4sxVn/R7wGw5QCRqHqnRL2YXIfGUStOFsQ7w3Mue1O4QJa9wMbe+JSVR0T2bAhW7Rc/kZM3mpec2g+1+dtfQP5U9G3xLE5Hd0qWHlC1sa433lvh5a56wSI8zxSl2SpAgzcf/YpgOLHqGclmbFwTioEL26mFUsgkkeAKAQc6pXnhWdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHzbskb8OlTrd+JBYEIKSR2B9MLhKkgJuFLpwCCT03A=;
 b=BuHo04xEu+rBXAFm0TQZDd+UA951FywL37N/+M2Kq3sxBN59QAJBeNXFelqNt041fGf/TCDdF6KbZl0vQfNguECpf3g4sMwRc6HgJqPtdg4yh4+2L1mrsBPF2VU7eoGAf0IQzVeSBKkbUgn6euORYdxv8n1Wf3o96Z7BasIPPYcs1SQC6Mu1JwWF6sRIVwocZSoktUOWyx6SbF18pxV0JLnOpVDwUqlMKA94865Xt72akdPWEYZiPCFeeweBYD9d8uz9DyvK51q7zas/CeHCaZWkskYiAWiLAhppC9RWdu3SH6udQZJTH5K6l7CRE+lmNQQcC0wLtSB7w5p1eV8D9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHzbskb8OlTrd+JBYEIKSR2B9MLhKkgJuFLpwCCT03A=;
 b=dbDGfGkSq7Yubios0r6AB2CdiaPsVqkdLsNKXUdr53g0IQ0MLqwBcnF2Ncks/2sp2wwHx9vJhzKI4ktl8z7hrb+QgJXsr+gcoEpBFN0RY4EubSe4WtZd5adkoKlBdhMUpN4/98jZSoZiWYdtkN0PmSLyJKA2eghzogSu5e0fVJiWGdzl6w/IsbEKkOLa7yMOrHSNyS0tAHuHIpqhfCpEsgz1aW6PW2gRCSuhM/2DSljLVa4JhwE3FycScbt0qwhtwACgwczxJ4/jtsFzgrmZ1QvdfTVBB+i/XzOBiNGhHJfZowQiPVmY8h54VsCNAu7XKuPd57XbxCsQNfNuEf/YXQ==
Received: from BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 16:16:17 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::9b) by BN0PR03CA0016.outlook.office365.com
 (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:04 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/11] mlxsw: spectrum_switchdev: Pass extack to mlxsw_sp_br_ban_rif_pvid_change()
Date: Thu, 13 Jul 2023 18:15:24 +0200
Message-ID: <3bf4fd2d1776fb70015f5d4ebb996fce8f427a1c.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|DM8PR12MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c752059-71ae-4abb-2b4e-08db83bc7ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iT1hu6tnZKeqSP7JGJ1xmfhAVxXMEzr4o/facPVFkdUwYfMOIc+Y23hsKp7BXzJC0jqc05GxaWW5SXmXmZHBvV2zGYVyYSWB5KbRnfhCJzc7PWZLwx0Frdbw1wD3igKPsBikE/QU8xTAyNKy5yJpryTNFYRT4KqJPYExPuPNfK3gWJpjkDdrGSAOGtf5r/uy3oSo+P5PMX+518nz9980UmXC8ZzdGUWK4Yi4bxmu1bgMzGzKVzubf16Aszvom/EjswNwhtLYlBLgabazkhXY8wkSuH267JCEmrk9aKmvwpGkfBkZOKeqIb7DxGZZPbpj1ohfUSdUzthWvLXzfpZoPWomniAmdEuV9x8xvc8mo849MFZ8vdN6KTqZ0zbohS/9RHZ9oNliWBL0sazP85qoFrWxG0RC8qx+1xe8GFxJvDHxUkq2D8XwhqWoONzi1TV5q319G+NPLUtdUFb/rQoYH6xKEreu6TCMBlR5fHI7IK5UCm2TP1TzRf9A9NIGR3/HDPpBW7ubUmbyanWbRDb8DN/Kc2jINrnbJU1jc6Hm04CTwg9KYP6W+rYsSIeJGkK/bHjmVYaqp/0cpzaVv2LJMWVlov3MVwYL4yd0jmqE9HqjC5Sw6LuHCEwnRv9ZJf0rEWP4T4hbdChihSyWFcPfNPOA4uMT7je8EvAPOXbfexBOxy+tPfrYYoUL78DqFLg8pA0AVpIw1XnSpx6KJTPN7x8Y0q7MKJU7Lq/XC9u08Gc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(4326008)(70586007)(70206006)(478600001)(82740400003)(7636003)(356005)(40480700001)(26005)(6666004)(54906003)(110136005)(41300700001)(316002)(82310400005)(8676002)(8936002)(86362001)(40460700003)(107886003)(16526019)(186003)(5660300002)(2616005)(83380400001)(2906002)(36756003)(36860700001)(66574015)(426003)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:16.9577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c752059-71ae-4abb-2b4e-08db83bc7ca9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the reason for rejection of PVID manipulation is dumped to
syslog, and a generic -EBUSY is returned to the userspace. But
switchdev_handle_port_obj_add(), through which we get to
mlxsw_sp_port_vlans_add(), handles extack just fine, and we can pass the
message this way.

This improves visibility into reasons why the request to change PVID
was rejected. Before the change:

 # bridge vlan add dev br vid 2 self pvid untagged
 RTNETLINK answers: Device or resource busy
 (plus a syslog line)

After the change:

 # bridge vlan add dev br vid 2 self pvid untagged
 Error: mlxsw_spectrum: Can't change PVID, it's used by router interface.

Note that this particular error message is going away in the following
patches. However the ability to pass error messages through extack will be
useful more broadly for communicating in particular reasons why a RIF
failed to be created.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index d88e62bc759f..a3365f7437d6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1481,7 +1481,8 @@ mlxsw_sp_bridge_port_vlan_add(struct mlxsw_sp_port *mlxsw_sp_port,
 static int
 mlxsw_sp_br_ban_rif_pvid_change(struct mlxsw_sp *mlxsw_sp,
 				const struct net_device *br_dev,
-				const struct switchdev_obj_port_vlan *vlan)
+				const struct switchdev_obj_port_vlan *vlan,
+				struct netlink_ext_ack *extack)
 {
 	u16 pvid;
 
@@ -1491,12 +1492,12 @@ mlxsw_sp_br_ban_rif_pvid_change(struct mlxsw_sp *mlxsw_sp,
 
 	if (vlan->flags & BRIDGE_VLAN_INFO_PVID) {
 		if (vlan->vid != pvid) {
-			netdev_err(br_dev, "Can't change PVID, it's used by router interface\n");
+			NL_SET_ERR_MSG_MOD(extack, "Can't change PVID, it's used by router interface");
 			return -EBUSY;
 		}
 	} else {
 		if (vlan->vid == pvid) {
-			netdev_err(br_dev, "Can't remove PVID, it's used by router interface\n");
+			NL_SET_ERR_MSG_MOD(extack, "Can't remove PVID, it's used by router interface");
 			return -EBUSY;
 		}
 	}
@@ -1519,7 +1520,8 @@ static int mlxsw_sp_port_vlans_add(struct mlxsw_sp_port *mlxsw_sp_port,
 
 		if (br_vlan_enabled(orig_dev))
 			err = mlxsw_sp_br_ban_rif_pvid_change(mlxsw_sp,
-							      orig_dev, vlan);
+							      orig_dev, vlan,
+							      extack);
 		if (!err)
 			err = -EOPNOTSUPP;
 		return err;
-- 
2.40.1


