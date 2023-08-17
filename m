Return-Path: <netdev+bounces-28468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B302A77F839
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68075282102
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12614F65;
	Thu, 17 Aug 2023 13:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7511427B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:59:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEC2D68
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awbpp4CNiLJR/2dID1Ji+jKrQ7R/OX0iSJ4owFlSStQkMqdqHQpJ2yCdIU8ocDA8qkAawoOeQDeiz4/l4oxzJoIwAZUoX0w2aoVdRoJj2sHYornZw5yF07DcaWfD4rxOIMuRS+joeybxpWDSGvOqAy2IV5Zvkb8UZ9QShVh0JuyVKuhts1mIDtQhl9Ar+pYevX1gAT7vF6kAWhSlTkuA9cCYYZ0aWKwdk1Mq+e4PDevoz5vc9RGBo1q68qu1aeIv8xesaUH7FVE7o1zLCEV0UvNg6PWkwCe4GJuPqr/JdMZT9q1Bz9/FG9M2etFkxc7Qni/GyZ0xs/ghVCZVTGsL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5jg7g9SRH9MeR4DuJNJcUGbNNXCDuka7W+ipMnNmII=;
 b=JFqcSYo51/wQLqwdDQnTVCOGdXW7EdiNgMgAEWRh31EJ9QukE9+vqkJndyZduZFwRAnZA7L//vLatqXWE80SaOaV2aErWCnWcfLwPyvoEvVzrKwdswRy7QBmnBJ5JUdkdUqsp09bMM4oMzK0hMZ4XIBYxqj92ciSQo7SfRWajURqvh5oizLO3CBEPZ92RXj6RFFRciS57cqAln8UucvtggsMeELSahIc3wJ12bDt86axEunbvOheKA8uG0hKTFt1pQE2g2vh4gJugY1WhwI78uF9HK5lRNCARBzNdpXTxZZATkppqZF1Nj6IE8iUaBqUlyzQIBt13Ip3213ND3ybQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5jg7g9SRH9MeR4DuJNJcUGbNNXCDuka7W+ipMnNmII=;
 b=Qfsn0246MPCns9kQGf+ayIJUf1FYG4PzXNllD9hvG64a4gogTK9mXprsQMLXtNVU5RHqz3haPO/9RIZ+F//Ao217TdQi7/GSm5CqNoEd2nvl7ohd0ciDqPpuBRbKP4TYiHyjZSbMf8c1DDqEp+1lS99ftvWzS4VAFNTRfKeFbfj3N9QPSJHrgBnw4IXDBSVSRJ6lb+Eaz8bbHZc9cJrN4r+oOcTyQF3TdgLHze4hF9A6PuEpAaPcpyj6lLX+2iysBNqKP58T+YpLyZUZOuorB+CXHXogK4vXWhiHGVY0nVFyDvtHKAwt8p6ICGq5e4SoFyoxeGTc+qpQpsgAO9h2kg==
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 13:59:28 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::50) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 13:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:59:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 06:59:14 -0700
Received: from localhost.localdomain (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 06:59:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Danielle Ratson <danieller@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 4/4] selftests: mlxsw: Fix test failure on Spectrum-4
Date: Thu, 17 Aug 2023 15:58:25 +0200
Message-ID: <f7dfbf3c4d1cb23838d9eb99bab09afaa320c4ca.1692268427.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>
References: <cover.1692268427.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e820bcb-c63d-40c4-905b-08db9f2a2c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5CU8p/un0RzTyHphYYL/gP6CeNfahBs1c5A+LnHi1JeYEz9xxr0qA1/f67E/n3OKQEEvUwWQKoPdkPLH2srwgi9NZfUB7WlyxCKW6aH5AHIcqsFmtdLH1T1Rck07Lw/qkfLKxw/DZNdDGcmcK1BS9o6KsxvuK3XbiEs7GPdjh3BA7Em04TWlP1pS+jHlN37wLsaGx6AuS1nH0RQspfEXqm6yhRLcuBs1JvblOpsRGG/qyQc+g4xwthWRFsw4GDh2X6KPmo2ioc8pD4U2dYRucJ0JtwuE7F9KOaSzHa9mf1i/+bywzjYGTDN0waBEF9u3tR86uwfiaJ62fIwLQ9mPnU6lGjmmOAImgkCoQYqMI3jyuzQnk2FkNKXENMaOj6AWP3gNgzNq2u5MjjGeBFUWejjsf9BwD/ux3hsS179swIq4qdSiLdomtC+TcjoDXPRoWuOhRr/cWfa21SrBYS4VlTumA+N0zwnVdxcJvzvCJkrNt7BZEHqOHgiY3Glf8P8ckTPjH3/GJ/YfMKFuU1BsG3IBowKKgeHYsLl+FKeKoGu1JuPXiGew7sdaBYqy1UMzI7kg+Ef2h8SuiFkfwvBe7Owd6pg7jsQH/XyxWj9oLa+nCMfrXcfeFhgBkbAi90cq4aMGlZ+Q9b9UzSaq5AMtPUY+1wXJZBiUV5S23dyYL1JsEIfIysRfHtDhGCZ86yn4IwC62rHrKXkOy0NSjNJeEs+SPGNTtIxtwmXZz26UaiRXKWDr9yuIqwhmnfr+x+MD+7xcG52jpyn6X/mmD1WQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(36756003)(107886003)(6666004)(2616005)(16526019)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(7636003)(54906003)(70586007)(70206006)(110136005)(4326008)(8676002)(8936002)(47076005)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:59:27.9107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e820bcb-c63d-40c4-905b-08db9f2a2c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Remove assumptions about shared buffer cell size and instead query the
cell size from devlink. Adjust the test to send small packets that fit
inside a single cell.

Tested on Spectrum-{1,2,3,4}.

Fixes: 4735402173e6 ("mlxsw: spectrum: Extend to support Spectrum-4 ASIC")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh  | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 7d9e73a43a49..0c47faff9274 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -98,12 +98,12 @@ sb_occ_etc_check()
 
 port_pool_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -126,12 +126,12 @@ port_pool_test()
 
 port_tc_ip_test()
 {
-	local exp_max_occ=288
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
+	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
 		-t ip -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
@@ -154,16 +154,12 @@ port_tc_ip_test()
 
 port_tc_arp_test()
 {
-	local exp_max_occ=96
+	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
-	if [[ $MLXSW_CHIP != "mlxsw_spectrum" ]]; then
-		exp_max_occ=144
-	fi
-
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
-	$MZ $h1 -c 1 -p 160 -a $h1mac -A 192.0.1.1 -t arp -q
+	$MZ $h1 -c 1 -p 10 -a $h1mac -A 192.0.1.1 -t arp -q
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-- 
2.41.0


