Return-Path: <netdev+bounces-17648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE2752826
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C076C1C21405
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78DE1F182;
	Thu, 13 Jul 2023 16:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB718017
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5C1BEB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxvsOebqH+ut00f6ZfhMhILYZVO2tZvqDLK1aOzqE6/MUmtGWCrEzu7CPiViuJta2J57pjwjnIVcsewVcKYYf4h1J6Hm0Yri+92xu0ClC6UVl8/WY0W5imp9jTdOYi7OJOQM3+w1EHlMQfF0ipcTYWbW+Yt6U/9yYKSw3Kl8L2jAYHXXIz2IFkq9aMWIOmB06RwP3WO+9qzM7z2cImg5TleoifimyjAmaBL8VVz7RiVpvb5noAMlxLmrU5KKSLLDr2I8c0+WBFAjL3jPrb0OHiCjTC+oVgFZbBjwFQm5eApwGtU29db3wcscL5LWasvuXDkxGhVamqn4IH2EZSR+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+0HBZcOU5Sua1PCBwJy5BkIhHYA/mgF3KgjcDJJQcI=;
 b=HANLviGWFQTIPZnBy7+Vgz5a8yJiWElTFSchfgxA4TQ88GuqafzDmqGQgdVUg82ZoBitoOJpZU8hvX+hLlLvUQN8qZdjQ1s25biJs6Qu/NK0Bq7Xzo1ll3x0ocBjWIxnW3RkS5ZYXkBn9XKqjbfw8mn0xAgkvCtFTs7zWJLcoQxNJCiQTyFLH4UFwS1oS3X4R549eIWQETyGFNPwN/GkdQkklN7CWsXggGWM+x0QonsyOWG5qDS/EbxusUWXDiULGu+j7Eftu0B74iY6x6W4keV7dwi4FrJiQ5BqsVifqX2HtU+4ql49woKl9CdE+CFDSzUuTrVNEw3l4AVGeX4k2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+0HBZcOU5Sua1PCBwJy5BkIhHYA/mgF3KgjcDJJQcI=;
 b=DRLmgEdDgE9lUKOBv7N56IQAV8TRz+MwXszvhGHh41eN4eSL0ndPBHHP0FWaKj7ZGxf+tDptNbv0lqzYRMTOBnnOYRbHP0DYzUqXEbTUGtjb+jJQ0WQaZopH5fmtLNoz9njqghFYDNWG1hIGQozjjxvw0LTNsuV4fs366y35CM34tnT9RoqhA1mcHeXoYkPSfK2JwzLJxK46+tCS1WXYJ7XnLDL3gxELBWBU8027ExgshllT6cfz+AU6mUq2k3FZ1S7K8tY/628cJN36i9CMozYCyJSg+wfvPlfwOJM+VC6PetcItAqWNxgw0FDJcEQ1Oso+AINQc3VzenNjAwHtCw==
Received: from BN9PR03CA0112.namprd03.prod.outlook.com (2603:10b6:408:fd::27)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Thu, 13 Jul
 2023 16:16:30 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::f0) by BN9PR03CA0112.outlook.office365.com
 (2603:10b6:408:fd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:14 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:12 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/11] mlxsw: spectrum_router: mlxsw_sp_inetaddr_bridge_event: Add an argument
Date: Thu, 13 Jul 2023 18:15:28 +0200
Message-ID: <e040a9f7b52696866702d42b32b46aa71e94db41.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 577d42ce-c7ab-4cd1-9abd-08db83bc835b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dwIbxchc/FjPlWo1FHPJxLLGgTgKDrtf21EA77926J/k2Kk+9ufcInk41/EW1dHZjzOoq3RPRsPkD5Squ6OlAz+wG1z50KNyw5/0cnOsfm2skiaAO5gftG063rlS0ZuCYakZpb65Inf5f54CEplvYyXGYEXCsHdgT7JdHO33WPa68td7IYd7EWGfSmaoZXMh8eAt2xr/irk3KYBDEkHU2AWPTuSb2SgcAvNChbKdcTMjKBL6sSkt4rD+yNffw5/aNlrkmmog8p3ka7WlfIT/l0Sy1WpV2AwUsJmydq+0rWdHjZdVgLr5Jj/ndrCVvqEvrVUsL3RXJPfZ33N2y0/y3m9HG53eKgpM51uUX3ncVv/Su1VOX7MSmT7dg8/IpPBAfclqVWLPwKxb6wpvtzznrOVfjUcRAJgfB0lql+A+UY5L6TPK2VZq4dMd0LVCTt8UyeT3c9BsKdeFI/FzUdQompcK1m8gjYSy0+Dw7dTvLs3yCr3L1hQZjww3UqMo4ce1llwNDIAVKPgr5WhDC8wdstUIT+TK+iKpE0Bj+fkPWNpOexAt2OOvG3pAeYfW8MExJDgLBiK5KcauTrSIIfFR+zgtCtztsR8eZwBQj5WV+9jry1U1Jbg2RxZEXqmTOajlOteJwcrpKoUsBld2tmRd4utzT3qW42bfAG/XqdA9SxmD8qSuiguDRmL5x282uxVr5sbB+JgKXfpqRTlbXv4Cwnu6Zn3XUQPTPwvqvjTr+oohJ3vVT5jqoV8uuB36wq3a
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(70586007)(110136005)(86362001)(6666004)(478600001)(54906003)(107886003)(186003)(82310400005)(2906002)(83380400001)(26005)(336012)(41300700001)(4326008)(356005)(5660300002)(8936002)(8676002)(316002)(16526019)(82740400003)(7636003)(36756003)(47076005)(426003)(36860700001)(40460700003)(66574015)(2616005)(40480700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:28.1622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577d42ce-c7ab-4cd1-9abd-08db83bc835b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For purposes of replay, mlxsw_sp_inetaddr_bridge_event() will need to make
decisions based on the proposed value of PVID. Querying PVID reveals the
current settings, not the in-flight values that the user requested and that
the notifiers are acting upon. Add a parameter, lower_pvid, which carries
the proposed PVID of the lower bridge, or -1 if the lower is not a bridge.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 3a5103269830..63f40d16be3b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -8826,6 +8826,7 @@ static int mlxsw_sp_inetaddr_lag_event(struct net_device *lag_dev,
 
 static int mlxsw_sp_inetaddr_bridge_event(struct mlxsw_sp *mlxsw_sp,
 					  struct net_device *l3_dev,
+					  int lower_pvid,
 					  unsigned long event,
 					  struct netlink_ext_ack *extack)
 {
@@ -8873,6 +8874,8 @@ static int mlxsw_sp_inetaddr_vlan_event(struct mlxsw_sp *mlxsw_sp,
 {
 	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
 	u16 vid = vlan_dev_vlan_id(vlan_dev);
+	u16 lower_pvid;
+	int err;
 
 	if (netif_is_bridge_port(vlan_dev))
 		return 0;
@@ -8885,7 +8888,11 @@ static int mlxsw_sp_inetaddr_vlan_event(struct mlxsw_sp *mlxsw_sp,
 						     vid, extack);
 	} else if (netif_is_bridge_master(real_dev) &&
 		   br_vlan_enabled(real_dev)) {
-		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, vlan_dev, event,
+		err = br_vlan_get_pvid(real_dev, &lower_pvid);
+		if (err)
+			return err;
+		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, vlan_dev,
+						      lower_pvid, event,
 						      extack);
 	}
 
@@ -9022,7 +9029,7 @@ static int __mlxsw_sp_inetaddr_event(struct mlxsw_sp *mlxsw_sp,
 	else if (netif_is_lag_master(dev))
 		return mlxsw_sp_inetaddr_lag_event(dev, event, extack);
 	else if (netif_is_bridge_master(dev))
-		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, dev, event,
+		return mlxsw_sp_inetaddr_bridge_event(mlxsw_sp, dev, -1, event,
 						      extack);
 	else if (is_vlan_dev(dev))
 		return mlxsw_sp_inetaddr_vlan_event(mlxsw_sp, dev, event,
-- 
2.40.1


