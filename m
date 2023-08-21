Return-Path: <netdev+bounces-29342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBF782B8C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEE2280E9A
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AE749A;
	Mon, 21 Aug 2023 14:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60464747C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB2110
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9xPn8BF+JEW9rcX3nNDU9Xc6YpEzxKyRGQ+qakQpnB+Z9i84PyINHcPARdqMJdKJEQQXzP1XgjG+3IyNEq1Ff3mc2qBBWWJZU7cp4bsNxFjL3GKxjqBnHhqMt75j5WEzn6YtV0l/tc0PTa7F9rF76GTD2Jf3UCFZ6CQsFjEm1dbNfU5snarIgkZsUfhPkIvdCgiND7bQyx6oWbynfkp6K7aS3CekZMI2MpLdeU3yY2oSKy++mgisa4fPNBNj3ucXqB7FmVPoTIBsFwr2w7joySSpKJXvIdTVQWvxz8ZVzkzhQWV+ciUrvaX5fyiUrgrj0Hn4X/bnh2ckKKA2dgx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29qggdFgyvTMzfAnx9lOaRRyAedpai7jnMUhI+Cn/mY=;
 b=hld4TnYiu9+yHYYeqzOHT/aefWPmMyLQFOdG4uJ35DV+IIRgP4msmLYx44/RfCZUijAvxtAvZ2yWxvwnLrxT5sW2hXKi4WdrCMlr75FnNVkWB9VfdkOKKovexQ50LDZGZ8Wuv+R6WheQav7//AaoNzJqYML//52pqIeUqFHBFyLxqC4td2tnQmG4rmRDQT9i52ngphc0W6m9mGKFC5MMRug22HjcWpCrwmqzr3PcdRgtFSLylQRY0axbORW75dh2Ph9lw0yNHDTTOFvGD5VfViLn3V69jj1goW12E93swGTyqtnIUNrGo0ZtG+S0JZC3EN21VsrvIBVn4l8CLuvdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29qggdFgyvTMzfAnx9lOaRRyAedpai7jnMUhI+Cn/mY=;
 b=nEgCQFCwLEGJz8Q0xKwV9LG8lCJV1qKeGaSs1RhMuL1B+b4r8++V/NM1dDFvleM3S9XARqgrKi4fWVmNf/NJwwTTvxXWpZAWfVY2REutnmrDcdBajChfIHSoRerdIDPMPpURkvEvca6GumvSunmsfxE9Wgm87ueNkluS0IMwhyZ5acqlVVb+em9KqtDSa18Q3M4/VFf5jdNtNTKRPBLqfQwnfOZWaCVH6T9Y5Wtp1I5aL6+HtRP/CZLQ+lrV34eGJBHx1FaFZkzWS7hYDO7GjTOmFttpfzfUimiPJiLLmhO3IsGsjxm4mOLpuNRZB9LbP1r8J+d8+WkFdU8Gb5bRCA==
Received: from CY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:930::28) by
 BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 14:20:12 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::45) by CY5PR13CA0020.outlook.office365.com
 (2603:10b6:930::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Mon, 21 Aug 2023 14:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 14:20:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 07:20:00 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 07:19:57 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <mlxsw@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] vxlan: vnifilter: Use GFP_KERNEL instead of GFP_ATOMIC
Date: Mon, 21 Aug 2023 17:19:23 +0300
Message-ID: <20230821141923.1889776-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa62fe0-39fa-4f38-6859-08dba251bb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aTD+4GX23maXLBlt71QXeKgEe14WBV+iu3eIfs6CETzftKWrO+q4bBOvIb1IRQQGib25ozjChbzMp8rSdDaFeklLuJNQjR+oUwI4w9gjZiaEiVcCCr8VlMLtlCVLfre0Hmvy29M1RJsDYnBBnO24ZU71YLa3hfhG5arrGj4yAnC8EN/AvBDEknMGR5C9CC0JhRZjFXGLxyaWx5CSa8D/fLvHx4ASCeMfEFDiCnTla9IMNv91WdIWobs8XVLcogf13GPcuw4ePGjPFeANxrUvGohyUzfvvaneAFsSjjUqdw3ExMulADBh+xtbo4BZwxVlKDYUNZm870PIHWgSILyl8FtvolNGtWlWSHeN1Gz2pfK893DdgyASN9LqPwzKQSz27aP7dBdWWD6dd6OnXE9N4u75hz0C0Pvw0uFL90Mme1xpfIHEnnsCSxa1IvycJ4EnsmpRMqDqAaGpTmfMB4KjD1UmpKgAuE0S0nwNCmsg0evdLuJdfOvwhwXPBMmpy25mOpk+KI9vk24XnvCKajPGMa99auHJFj/uAcQO17zYeB7nn4//i+77CSpzmojn1g1RfHEOnlRbjgI0wOwx2q9GYrgxKvQETa5lUl/8i/hwJhhGP3lb7p1+e/Ug5XATzwwxdFQCccCfXtqdj8ZT6v6IJeYYUYPGXNdVCyKfOnLAnAAWwD7HyIo+wN92K9KefMZRN7NzYSon+nmIpHQ7UR5N83nWI5/UkfttBDx1tYO27yCft0itBUHoGrMNOgih8UYQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(4744005)(40480700001)(83380400001)(5660300002)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(107886003)(4326008)(70206006)(316002)(54906003)(6916009)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:20:12.4504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa62fe0-39fa-4f38-6859-08dba251bb90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The function is not called from an atomic context so use GFP_KERNEL
instead of GFP_ATOMIC. The allocation of the per-CPU stats is already
performed with GFP_KERNEL.

Tested using test_vxlan_vnifiltering.sh with CONFIG_DEBUG_ATOMIC_SLEEP.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index c3ff30ab782e..9c59d0bf8c3d 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -696,7 +696,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
 {
 	struct vxlan_vni_node *vninode;
 
-	vninode = kzalloc(sizeof(*vninode), GFP_ATOMIC);
+	vninode = kzalloc(sizeof(*vninode), GFP_KERNEL);
 	if (!vninode)
 		return NULL;
 	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
-- 
2.40.1


