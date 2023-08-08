Return-Path: <netdev+bounces-25312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC16773B7C
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18E2280DFC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEC815494;
	Tue,  8 Aug 2023 15:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4F134AE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:43:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535B5248
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmw+AZ7Kc7fVJL8j0XxihVmoFILJasZ4pVOYvF4AjhLL0jhpY0Tti4oQZ3ywI6IOxe0QPZpqhPigANwNDD7Qt1qbrEHb1fM0ot3RdfReInoLmvbT6EAigqX2sxTOcAggD3p/6W9qaYmfVSJQUP0RI6FK0B7QI2XOXRBS4QFZuNOCy0P47qtCqeJV0twDO7ysDO5Ru/2c1z76vFP1bwM8YK41kIymbhWN7hT2799BFY4UXEsmAjm3GI+Zkn9EsmpBeqFqf4xZ9VUOT9E8tpeFN7hEJttoYiQOP8Qy7QMEICUHeqcaUDMTRf97+PZVR+bRcapNKSz47ZutPBY4lBQdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdWODSVQNS5zBOgElmsfaMHEQZkqQLtllyIBYH6NnaU=;
 b=Os0WzubcszB4Jq/3BJEJu0jgnH1kk3TM+0EcJa5+KaqawOUBg9qOz2LRogAHOyH1b6oZGZb+JDQ3aXWD4fcMsfPC2hItXaztaeAWA2XLyeE0TSKT2Hd5rebP0uWtB2bwM2QZHWiV4ww1sE9hv9S3N9jSdM55UpE5vPvCtfjFEBUmWAh8z8a5qglX4TCqmk7/FPzO97iAzxchTClYUZceGp0u6rnK7Et16ARy9/babwQmLR9treCQIRBuKuoMEh0D99DjfDRcCVn3AD8wL1pIkOuRdL3rZ3bt8+jGT90xa1kZxRhhdRU4y2ZsPb7UWKDbHRO95WC8I4e6+VMX8Y5ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdWODSVQNS5zBOgElmsfaMHEQZkqQLtllyIBYH6NnaU=;
 b=FkNwmDh3tgR5SJSI1oAmAaoqBbkbACqRJilKaTNOnorEUSsDxcucdQLLSoXnPEoOp0k2uQ9ieCc6yIC0gpEzEPSgEGY7nkjrMTarP9FSNjqSDV0Ens3yvEECtzy9IObmdKxi6hNuf2limoscW0T2HLlEqbnkNqxQeTUW9bmiWYTwQi/Nx5AI6JgG2KFZC+1md+IrilyuXJ7kijswn6MuJKnsIF+Xo9uD2OYChrHqpWONnNy7bIqGAowgVHUewCp9Pwh7UihTMYqZGuBbu/37CdKnHJcq9KA8OAgwCYcpOeyZCkOGJ55ZJ3mk21xBbVJ2U2bqPK9bPyfF8M/4hb6w9Q==
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:18:54 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::99) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 13:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 13:18:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 06:18:44 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 06:18:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/2] mlxsw: Set port STP state on bridge enslavement
Date: Tue, 8 Aug 2023 15:18:15 +0200
Message-ID: <39f4a5781050866b4132f350d7d8cf7ab23ea070.1691498735.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691498735.git.petrm@nvidia.com>
References: <cover.1691498735.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: a39c17e8-d046-4ea2-d91b-08db9812033e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HsRqNMvt9u7RtuyoFgM9wH5vXEWkCNEoUNY1bKB3wcndTNgtdbaqbooEeXqebY6/qe0PGrl/fJqL78x+PgyhYJQVonENdS+ecievP5Jb/8FpYQyTiG9XbyeSHdbnHOFCuqFhipE4Tm5ACR8mF6TZivMTGb85vmfcMjpotuJWAfrQmJIMUVMRD2PDWf5+zFm3Z8cDfSNzjTl2eFDvQfrvPKUe1aSjpBisgzh3WPxk0AZbrFqlX+GMTHYiMChW0HtIFognPVqIoDd0n/IvlbfAD/99XyFNyDcfjihr+/k5iDKg+TgJexMJbRWU846j2rRDzDlzLXR3CoeovYUptXEVTGXetdSeigrvDJaggIQDr+jc8qRsBmHulUPHtMq4b3T5w+0eopMIEh4MNp1+yBCje0+izS9aIT5F4GJsFdqmFQag1BvjXVVjJbH/NzvxsfroZDD0Hw4eVa7rMNYoNyiFOhcVYotXqSnF5VnmKd9e1otmHSihdyyickdpeH31XQ/0T5FCaRjQbiQfpNbeglfE2o/V4mKOoLcgOqpZuJKXnQ5Q6o6UHyQlUkaRt3phTNDX9+ww2W/gJnibiNWk9Mwepd93JTYGUsQRku21V0ckgCDzwWXTMgbUJsOjkTz8PMz19UtsRmUdmL3X0ApTyxMDQVGVCwTfMb4EGDSGyrt2UuxRuBr2kbYE/jPH+6ITBEahK5PUlca3hk42VblT74NvAqf1DCPtwAqAEcFVJ69yvNfHQ/OBL3rPbuMGVqaTlZU6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(7636003)(40480700001)(356005)(110136005)(54906003)(426003)(2616005)(86362001)(26005)(107886003)(36756003)(6666004)(336012)(16526019)(2906002)(4326008)(47076005)(70206006)(70586007)(40460700003)(8676002)(36860700001)(5660300002)(8936002)(316002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:18:53.2934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39c17e8-d046-4ea2-d91b-08db9812033e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the first port joins a LAG that already has a bridge upper, an
instance of struct mlxsw_sp_bridge_port is created for the LAG to keep
track of it as a bridge port. The bridge_port's STP state is initialized to
BR_STATE_DISABLED. This made sense previously, because mlxsw would only
ever allow a port to join a LAG if the LAG had no uppers. Thus if a
bridge_port was instantiated, it must have been because the LAG as such is
joining a bridge, and the STP state is correspondingly disabled.

However as of commit 2c5ffe8d7226 ("mlxsw: spectrum: Permit enslavement to
netdevices with uppers"), mlxsw allows a port to join a LAG that is already
a member of a bridge. The STP state may be different than disabled in that
case. Initialize it properly by querying the actual state.

This bug may cause an issue as traffic on ports attached to a bridged LAG
gets dropped on ingress with discard_ingress_general counter bumped.

Fixes: c6514f3627a0 ("Merge branch 'mlxsw-enslavement'")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 5376d4af5f91..ad90f7f5eeb7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -490,7 +490,7 @@ mlxsw_sp_bridge_port_create(struct mlxsw_sp_bridge_device *bridge_device,
 		bridge_port->system_port = mlxsw_sp_port->local_port;
 	bridge_port->dev = brport_dev;
 	bridge_port->bridge_device = bridge_device;
-	bridge_port->stp_state = BR_STATE_DISABLED;
+	bridge_port->stp_state = br_port_get_stp_state(brport_dev);
 	bridge_port->flags = BR_LEARNING | BR_FLOOD | BR_LEARNING_SYNC |
 			     BR_MCAST_FLOOD;
 	INIT_LIST_HEAD(&bridge_port->vlans_list);
-- 
2.41.0


