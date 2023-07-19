Return-Path: <netdev+bounces-18964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 071297593B7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8501C203B0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B714268;
	Wed, 19 Jul 2023 11:02:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641C14267
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D018D
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELvb5rKBMNg64hy9fRPQ+6AlW+kFC+5ijB7OKHiVgpx0j/iYjzITK0HG4EADwTfBqzz81XwtyiRzVBXS9ay1IOsk0oFHX2+Vt1HlUycKSq2DqA3gE7xoxSEoqKy+HWwpXY3KFf4UfX7z44QQ2tRRtcn+OibV12e4rbslsjjSRMIbePDjtfdB8h6SBbCI0UZEOO1XAOVrLOWzLc4Obh86EgKY/7gyHKLHVYPMgmsaOpF3Rfvvi5GVcwDcFF8OP7jm7J1e+sGGbAVk0lrC8bo5owfGBMOsf6k83MvOYLrM4knQdh2pZOP0i0kGM5qhLcPOMYIuIGHbJbHGhCNHRQk5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4VfrTBvmM+n6PhPjAZEOvqe1/im6TtTvJfrFCPM1Hc=;
 b=Vo3yJUyY+dk18F3L2h6777sfCgf7aNLxejmBLWGjucvjZvFJvITNlRYBUL3H8ToGc5HXzwPjbb2E8WFnok9L8KtFOSu76H3iR8XDsG13sepvPlHxkvBlB9TiFRoT+frTEB+AtYIuFaj4F/Z07Pvgc3eCCslKnUd2epIcP2rZstucxRTkcOWObHqadsJOYgSPVTvsxW+6dVBxNG8qM91nGtr+5NhBEAag7Q+ResGQL7z0plAt9Xy7MibxFZdbstZX6+EKyXLjD/YWXS6aONU9+w8HJkSwC7U+409cjvEPTxFW283qf6Vrs2m+Lq+PCxWXVaya+b5N21rmis6wZwFEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4VfrTBvmM+n6PhPjAZEOvqe1/im6TtTvJfrFCPM1Hc=;
 b=FflWtcWBHcWDkNYUesGlHBNFJs4VJFw8BazYreES3gcvQDHD9f215YBZWSirsZop/m9yOrhIulf1EUJyLrCb4NWhSdXRxgE5xoLccASHvcD0RHpt+5mjcPuAQ0JBf+Wvqn6MutKqvYLdWEulEH3SzRjDYEhj2kTjeDzNlSEus6vghLNzOs1ne56NQNat44iGKYCpuCIyNbWdhqo2XKTy9SuEpObIbHh4e2ZuED1cZTMag4VF6vGUmtWEGlyaQFv9sivJn8/j54PuWjxcSMt6AeBqG6Q9OJxwEZ9mraRcjpqcG7k1wy+7td9kT13+a2CaivOwo3/1W3bgLJ6DbJdI/Q==
Received: from BN7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:408:34::26)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 11:02:35 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::67) by BN7PR06CA0049.outlook.office365.com
 (2603:10b6:408:34::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 11:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:02:19 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:02:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/17] mlxsw: spectrum: Add a replay_deslavement argument to event handlers
Date: Wed, 19 Jul 2023 13:01:23 +0200
Message-ID: <34822af84ea869634e909f5cbac2915fa48acd33.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
References: <cover.1689763088.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 88db0979-b5fb-43f6-cc4a-08db8847a7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wNeh4eluXWB3EdzeQFIpLVKBPLhar71uPz88wKQp7TbjpEuxGJhaeysbljuz0W6jKQhqzSWrrVv2mCCe55mNlbGU1IYH9DZS8uDOCV62GHSx14jgdVaENurmUW0CJwhoVVtxrxBQQqCANSsho3dPmm2BQJMO+dX+8CHnzEkI+cCsxia9YaOU4zEg/kKX3UnHTE0LG8cFO2kQP2ju2a7nuO32JCkL+UEZtprM8q/pfjnMUWF84qokMKC3LS2DksbfnxZGyySHxZRalMrvtA6AGv8dWNkv0TWDu+rKmlLy1FaI0G8S6jwogEI9Ou398bRBxXVz8MX07drrB3T6NAknsr4jWJ1cdotOyCPwwigPywwBubUDNPtEPetxM9lb1Lww6DTK0khtLLy3Z2h9DkvhL5anda60m/z5hOkoMRazpQhSF9i3M88Y11WNObRl1J66wnVATYao0kbwzau9vi+DaBqD6CnPw75sRhUAMMDGKqB0wylAEiTmhJQwuDFLk/O4xEqXDOCVF96k0DPSsnJk1lf82HG8myWMHyK8F4oMHIQLCqLXiLx/W2XW75ABMJBlmZaoW0d8t1+9VrjwmnJSChEGBZkAx8Fin9fXEnkV3xyOj/7QLZsvnc1gokXX94DERWpYxwnMzJ/sGHfo15WUie3D72rxQVOxwnHpNUPXRxV7fdlmE/Mi5ni0hiYr3Il9STp1WGA1OwYZBfwLeYvD8cOvTB57d13u9T4gviNqbsY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36860700001)(41300700001)(316002)(426003)(66574015)(83380400001)(26005)(2616005)(107886003)(186003)(336012)(16526019)(47076005)(40460700003)(356005)(7636003)(82740400003)(478600001)(110136005)(54906003)(6666004)(4326008)(40480700001)(70206006)(70586007)(5660300002)(86362001)(8936002)(8676002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:34.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88db0979-b5fb-43f6-cc4a-08db8847a7f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When handling deslavement of LAG or its upper from a bridge device, when
the deslaved netdevice has an IP address, it should join the router. This
should be done after all the lowers of the LAG have left the bridge. The
replay intended to cause the device to join the router therefore cannot be
invoked unconditionally in the event handlers themselves. It can be done
right away if the handler is invoked for a sole device, but when it is
invoked repeated for each LAG lower, the replay needs to be postponed
until after this processing is done.

To that end, add a boolean parameter, replay_deslavement, to
mlxsw_sp_netdevice_port_upper_event(), mlxsw_sp_netdevice_port_vlan_event()
and one helper on the call path. Have the invocations that are done for
sole netdevices pass true, and those done for LAG lowers pass false.

Nothing depends on this flag at this point, but it removes some noise from
the patch that introduces the replay itself.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3d1a045ff470..b9ceffe258bf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4641,7 +4641,8 @@ static bool mlxsw_sp_bridge_vxlan_is_valid(struct net_device *br_dev,
 
 static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 					       struct net_device *dev,
-					       unsigned long event, void *ptr)
+					       unsigned long event, void *ptr,
+					       bool replay_deslavement)
 {
 	struct netdev_notifier_changeupper_info *info;
 	struct mlxsw_sp_port *mlxsw_sp_port;
@@ -4815,13 +4816,15 @@ static int mlxsw_sp_netdevice_port_lower_event(struct net_device *dev,
 
 static int mlxsw_sp_netdevice_port_event(struct net_device *lower_dev,
 					 struct net_device *port_dev,
-					 unsigned long event, void *ptr)
+					 unsigned long event, void *ptr,
+					 bool replay_deslavement)
 {
 	switch (event) {
 	case NETDEV_PRECHANGEUPPER:
 	case NETDEV_CHANGEUPPER:
 		return mlxsw_sp_netdevice_port_upper_event(lower_dev, port_dev,
-							   event, ptr);
+							   event, ptr,
+							   replay_deslavement);
 	case NETDEV_CHANGELOWERSTATE:
 		return mlxsw_sp_netdevice_port_lower_event(port_dev, event,
 							   ptr);
@@ -4840,7 +4843,7 @@ static int mlxsw_sp_netdevice_lag_event(struct net_device *lag_dev,
 	netdev_for_each_lower_dev(lag_dev, dev, iter) {
 		if (mlxsw_sp_port_dev_check(dev)) {
 			ret = mlxsw_sp_netdevice_port_event(lag_dev, dev, event,
-							    ptr);
+							    ptr, false);
 			if (ret)
 				return ret;
 		}
@@ -4852,7 +4855,7 @@ static int mlxsw_sp_netdevice_lag_event(struct net_device *lag_dev,
 static int mlxsw_sp_netdevice_port_vlan_event(struct net_device *vlan_dev,
 					      struct net_device *dev,
 					      unsigned long event, void *ptr,
-					      u16 vid)
+					      u16 vid, bool replay_deslavement)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -4927,7 +4930,7 @@ static int mlxsw_sp_netdevice_lag_port_vlan_event(struct net_device *vlan_dev,
 		if (mlxsw_sp_port_dev_check(dev)) {
 			ret = mlxsw_sp_netdevice_port_vlan_event(vlan_dev, dev,
 								 event, ptr,
-								 vid);
+								 vid, false);
 			if (ret)
 				return ret;
 		}
@@ -4989,7 +4992,8 @@ static int mlxsw_sp_netdevice_vlan_event(struct mlxsw_sp *mlxsw_sp,
 
 	if (mlxsw_sp_port_dev_check(real_dev))
 		return mlxsw_sp_netdevice_port_vlan_event(vlan_dev, real_dev,
-							  event, ptr, vid);
+							  event, ptr, vid,
+							  true);
 	else if (netif_is_lag_master(real_dev))
 		return mlxsw_sp_netdevice_lag_port_vlan_event(vlan_dev,
 							      real_dev, event,
@@ -5168,7 +5172,7 @@ static int __mlxsw_sp_netdevice_event(struct mlxsw_sp *mlxsw_sp,
 	if (netif_is_vxlan(dev))
 		err = mlxsw_sp_netdevice_vxlan_event(mlxsw_sp, dev, event, ptr);
 	else if (mlxsw_sp_port_dev_check(dev))
-		err = mlxsw_sp_netdevice_port_event(dev, dev, event, ptr);
+		err = mlxsw_sp_netdevice_port_event(dev, dev, event, ptr, true);
 	else if (netif_is_lag_master(dev))
 		err = mlxsw_sp_netdevice_lag_event(dev, event, ptr);
 	else if (is_vlan_dev(dev))
-- 
2.40.1


