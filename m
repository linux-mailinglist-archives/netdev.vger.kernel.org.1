Return-Path: <netdev+bounces-63972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403BB83091B
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401B81C20F70
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2C2110F;
	Wed, 17 Jan 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDHIq6U9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441C1F602
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503938; cv=fail; b=EKdkrR4bKAcnqmd7osYRYOdAskI3dxAQ+l8y30uIl0k47A2kzDfxDjxHjUv1ZXSVzaH+PyG61DXroe1QaRBDt5q1BXCKEQk8LafH7PDj3+TU4sNB1DOuH7SG4aKHwRgzmU9y4GU9TVNnRydZGgbUdb5H3vPidtJgBFzf34hMDbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503938; c=relaxed/simple;
	bh=qDKF9fKWKXG56CEBrp2xaIW6oTi3j2obXyJoV+yx574=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=jx7tu7ZxZntEESxcdztu5wcuOw7UOCaoLXjkPJ/alzjvorWwTFd1L97s4QJoTc6uvMO7dpPEdGuEuaQ1MXyDvWzMCts8Yy2gBZCdlH4XzbAA+ZkTlhgwoLDDUSfhVHpsY+4zymqS3M9yHZ2ZGsX41CTVzIH0mOPp54u3XcDpLjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDHIq6U9; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/T1mdoP8z8wf8Dr9QBFVU8khFIYDx0nO8ijCWKVIaXs1kZH/9SMI1vAhb4Kt0SNn87kY+5Wre/yDSQzZhXecmgKiQfCMYlc2OwpD6l7sXGyzyoyZsAop12MKVWzXk8IStAGz0/trLNotlV2zBw91E0myACg5FzeebIWBHx+dT9z4a3rzmHeLzQ8IMKNU0xX+njfQxf81K7sJUCsiC88ZvxFSVHa5OrEmlNSGgBPCOX0WnWeEShmU+09PvwyhzlFUZ9LrHNK6MMEQL+rpySdfuQG2J9wwG0UxMsW14hqobws8FQiwLLpfnIO+S6HBw06SYbh22r25LqVSICAFLzneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SevkloSzkgc8QFqNbvWsXuQqdl/t0+q7j1ThfO8oEw4=;
 b=dMhm2AClRLDlvU4N9m4LHglgOMueS5Qz8Gs3z7DR7PRJIRy22Yl3AmWnoEEFQQkrbg1N8ntq8s45jvbwWy3Y3gBfFW+zjE3JEk9CWDDWa0i44d+/lgujR5c0+8o8gbJ24gyaROVvAd1v3oIdIljhEt8pDZOddxSb/+JWb5QSaML/J9SMzCX82XYIhGX1yLums7Ys1t0uPwz2WdRAC1NCAWCOOUsj2j9eyEFij/GHKUK8ge7fJ20JfeBIC//xY7kUB0vo0U8SeDUIc7OvHgwZN/hNscWFm//fzAlU3YjOioymp2/4O/+rqUYO1x18Wx11WIav22jZeF+DzYY8pr/FcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SevkloSzkgc8QFqNbvWsXuQqdl/t0+q7j1ThfO8oEw4=;
 b=FDHIq6U9tiKP3zdGVwS7rrpx8sxjremCUm2jk2bNTjqhXiaqz3I3wLTiFErdHmRwnn7zPHB3H990Pr7PKL+fyZRCzLD0p7MwoeghwDoRHW9HqDd2vExIEclQE+6GoXuuv+VkrSEizo77dWGuxpnsvEhQ0dbZoc9WCufDwyfyhWCRttr3mjb2RErSpInmwLeIolkgDslpfVeEwFSIQadGj0nO2OUBvQTOz47hSSrpO8ae/gA/A/WI+MNp1aUYF2pqq2sjUq7fwp2Aa/0Mq5rKrz1Ug0GFKut5qydUlE1Y5zlL5zkpzaUsdNphPAVNz2VxgYw2XaSF0cBQ5zJ11egt/g==
Received: from PA7P264CA0245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::6)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 15:05:32 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10a6:102:371:cafe::38) by PA7P264CA0245.outlook.office365.com
 (2603:10a6:102:371::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:05:09 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:05:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>, Maksym Yaremchuk
	<maksymy@nvidia.com>
Subject: [PATCH net 4/6] mlxsw: spectrum_router: Register netdevice notifier before nexthop
Date: Wed, 17 Jan 2024 16:04:19 +0100
Message-ID: <74edb8d45d004e8d8f5318eede6ccc3d786d8ba9.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e381cd-eb9a-4388-ca38-08dc176dbf7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HcD5IcxcCmOmvi+TDJOag5L3v6Fl/LEkZXYmwDbn4XbwNPKRYJHycagy6SwlFk+7iYalybhC7jH4+KhqYzZgHbcwW/xWMd2k0mG8XgN5iXmihKY4V3absaQImXhAHADCs4dLVCNjnPuXfaGX3T6dAUDsd/MeymjhE34zrjx9SQYnD9QLp4bF2t4omE0fN8ptnbAtwhPDUtTiXyKq+Jlp9cGMtsTvmYBXG+mvrGYCY6Q1jv6N+k6Z526IH7LQtzdrIr2sQQjH80l/MMoOonhb1N7zY8pLst5G9lWCBdPKEeon9774TlzHtNDsS1hs4L8zdm7CRhiQqUOuIj/QzkvG9l+LJcsLPGrOGRMYfVHI8EtRAEjTNTH+sjF+K0M++BKxrfk2gzSeOEhGPmJ7UpLY4gKCnUTOgoCZ5LJ3SHaQAPWnGWgPAzyxqGjH6xECh7AgSqqxfKzKC7xovH9i5h73xjH+1BvWzzxRKeb0IV+HhJ25+ytWzL70R5UJv3wIBv8onfceolaCF7n05e74PlAgU5qvNSFmq4Z0yOTLaWYj0CNPPK315ucpxMRMSxQezhs4mYxat5gF/5Pcm48L/OOtB6piGpcSRMQk62KIzitENEfK/xpqCsm86bApoNRma1XWOBjfK2PCX40ybbw03UXK/MKuW+CKZ4LIfYN5fMLRSSvviEN8nY5CviQotqj5SL9JPCDDj5axpxSLiDVWUWlPWJ4vPZ2o3k/Ab0ee82hq3/CGKeFOuudoXATNQeyH4LhcvQnFPvp2m4EUjCCV+vn/rg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230173577357003)(230273577357003)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(36840700001)(40470700004)(46966006)(4326008)(8936002)(426003)(2616005)(336012)(26005)(54906003)(110136005)(70586007)(70206006)(5660300002)(2906002)(66574015)(16526019)(107886003)(86362001)(36756003)(316002)(8676002)(478600001)(6666004)(7696005)(40480700001)(40460700003)(41300700001)(7636003)(356005)(82740400003)(83380400001)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:30.9796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e381cd-eb9a-4388-ca38-08dc176dbf7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215

If there are IPIP nexthops at the time when the driver is loaded (or the
devlink instance reloaded), the driver looks up the corresponding IPIP
entry. But IPIP entries are only created as a result of netdevice
notifications. Since the netdevice notifier is registered after the nexthop
notifier, mlxsw_sp_nexthop_type_init() never finds the IPIP entry,
registers the nexthop MLXSW_SP_NEXTHOP_TYPE_ETH, and fails to assign a CRIF
to the nexthop. Later on when the CRIF is necessary, the WARN_ON in
mlxsw_sp_nexthop_rif() triggers, causing the splat [1].

In order to fix the issue, reorder the netdevice notifier to be registered
before the nexthop one.

[1] (edited for clarity):

    WARNING: CPU: 1 PID: 1364 at drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3245 mlxsw_sp_nexthop_rif (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3246 (discriminator 1)) mlxsw_spectrum
    Hardware name: Mellanox Technologies Ltd. MSN4410/VMOD0010, BIOS 5.11 01/06/2019
    Call Trace:
    ? mlxsw_sp_nexthop_rif (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3246 (discriminator 1)) mlxsw_spectrum
    __mlxsw_sp_nexthop_eth_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3637) mlxsw_spectrum
    mlxsw_sp_nexthop_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3679 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3727) mlxsw_spectrum
    mlxsw_sp_nexthop_group_update (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3757) mlxsw_spectrum
    mlxsw_sp_nexthop_group_refresh (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:4112) mlxsw_spectrum
    mlxsw_sp_nexthop_obj_event (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5118 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5191 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5315 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:5500) mlxsw_spectrum
    nexthops_dump (net/ipv4/nexthop.c:217 net/ipv4/nexthop.c:440 net/ipv4/nexthop.c:3609)
    register_nexthop_notifier (net/ipv4/nexthop.c:3624)
    mlxsw_sp_router_init (drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:11486) mlxsw_spectrum
    mlxsw_sp_init (drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3267) mlxsw_spectrum
    __mlxsw_core_bus_device_register (drivers/net/ethernet/mellanox/mlxsw/core.c:2202) mlxsw_core
    mlxsw_devlink_core_bus_device_reload_up (drivers/net/ethernet/mellanox/mlxsw/core.c:2265 drivers/net/ethernet/mellanox/mlxsw/core.c:1603) mlxsw_core
    devlink_reload (net/devlink/dev.c:314 net/devlink/dev.c:475)
    [...]

Fixes: 9464a3d68ea9 ("mlxsw: spectrum_router: Track next hops at CRIFs")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2c255ed9b8a9..7164f9e6370f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -11472,6 +11472,13 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_register_netevent_notifier;
 
+	mlxsw_sp->router->netdevice_nb.notifier_call =
+		mlxsw_sp_router_netdevice_event;
+	err = register_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					      &mlxsw_sp->router->netdevice_nb);
+	if (err)
+		goto err_register_netdev_notifier;
+
 	mlxsw_sp->router->nexthop_nb.notifier_call =
 		mlxsw_sp_nexthop_obj_event;
 	err = register_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
@@ -11487,22 +11494,15 @@ int mlxsw_sp_router_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_register_fib_notifier;
 
-	mlxsw_sp->router->netdevice_nb.notifier_call =
-		mlxsw_sp_router_netdevice_event;
-	err = register_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
-					      &mlxsw_sp->router->netdevice_nb);
-	if (err)
-		goto err_register_netdev_notifier;
-
 	return 0;
 
-err_register_netdev_notifier:
-	unregister_fib_notifier(mlxsw_sp_net(mlxsw_sp),
-				&mlxsw_sp->router->fib_nb);
 err_register_fib_notifier:
 	unregister_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
 				    &mlxsw_sp->router->nexthop_nb);
 err_register_nexthop_notifier:
+	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					  &router->netdevice_nb);
+err_register_netdev_notifier:
 	unregister_netevent_notifier(&mlxsw_sp->router->netevent_nb);
 err_register_netevent_notifier:
 	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
@@ -11550,11 +11550,11 @@ void mlxsw_sp_router_fini(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_router *router = mlxsw_sp->router;
 
-	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
-					  &router->netdevice_nb);
 	unregister_fib_notifier(mlxsw_sp_net(mlxsw_sp), &router->fib_nb);
 	unregister_nexthop_notifier(mlxsw_sp_net(mlxsw_sp),
 				    &router->nexthop_nb);
+	unregister_netdevice_notifier_net(mlxsw_sp_net(mlxsw_sp),
+					  &router->netdevice_nb);
 	unregister_netevent_notifier(&router->netevent_nb);
 	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
 	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
-- 
2.42.0


