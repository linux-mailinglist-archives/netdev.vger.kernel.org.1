Return-Path: <netdev+bounces-23555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CD76C79F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156C4281D25
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8863CD;
	Wed,  2 Aug 2023 07:53:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FE6D3F
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65193C1E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPdRfGtWETHSh2S1TubNhOoqAscchvgyEKAK9IMGdp5hipWepUepJuI26lcLAGu/RAGVbzAiVIjKwy+aZHk7loi5dfnQwRdaR+BmEaHAUosYaeUlb7aWAqDTOTc++ZjJU7fpzj7IzvX3t32vY6akWP566hSEW4uOYODREkweJDdyVwRLBo1S5bNX207CAIAF3Og/fpiUHYjaG50PDcAtnv1QwKpkBnR+KQa1TOcIlfVxhdbGWS0JXSKpwzMXQl9Eujra5y6JC+ilAKrZ6iXdC4yx+lqlhuM5kXX2GbMOPeNvFth1bFUOGZZDrmFf5F+yamfh3UEhlJ6vm9AcCbsXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfREWyNO25yJIz7rr+cssbXOGkP9Is5EGsMxq9XjX5c=;
 b=FNrY20cwZygUogKO4McVj5J2d0j5FrIHHbc9LjNLc9xOZoTD3G66sD4wq9VBKs3rV+jIvdBSLGZpe1QpGstEdycs+FsqVOcl804EMOxqBszSN3hLHTsGFfUatHCR7LrACJ3SHPGkCqz5ohEdNaiwpxu6RxKLFutuSnty02pjDbqyMOTpW96tmh4xylLUczCf5UPtuxRRC4TatAATTKkt/XRroh/63C3eo2dA7ZqSU3LdElIsS1AzzU5CFZ/3Ke6fTyjKE1KUjhajc05h5+8za84KHSMYamD3YM5Tj265wTpG55vYEe9rSEgaP1dyy2ZvQamSUESBRbNdLOxFKuxGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfREWyNO25yJIz7rr+cssbXOGkP9Is5EGsMxq9XjX5c=;
 b=HkEKGM5URrIHbZ6bkOV4NKpURlzSUTXobkXD62OVBnRsViSCPoi/e8lGng8MoeRdUhqF8XVlkaBYbcDlWbNCmh5BgNgYGSWn5G4WyMUhhJyRXJc3Q1Vo71lSQM+RXzL/QKLSNXKzGurwHlQ50E/D4B3L8XsWBW2YfJ/RIK4qXlh1GIRdJ3lii5RCAELBDMma8MjPvufD16hy7yzBWO82QvAR5SEEY4+tHm98FBX0WxioJyf0T10iJjg79fTIh8hjHpWnh1fU85zGiXl/6Oq0sAAFkKxTBt6/90fPBxMTnST7OrQJNdsRsmeiU6Prbc863ssrkTZUyIShvivMH8dQHA==
Received: from MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:53:05 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::f9) by MW4PR03CA0093.outlook.office365.com
 (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:53:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:53 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:50 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 12/17] selftests: forwarding: tc_flower: Relax success criterion
Date: Wed, 2 Aug 2023 10:51:13 +0300
Message-ID: <20230802075118.409395-13-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802075118.409395-1-idosch@nvidia.com>
References: <20230802075118.409395-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: cc530351-c086-4ff0-ff7f-08db932d80c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ydAbLbYgxBcrlWbXNUb3fKZ0AwRRHG83V1AsZ7lyxBAu0xvB7/dk9hhFxSkjCgHq4CM6meS3QFLTGxTyvT0irMsy3IS/1I4zKc6h3HbhFLFmLwBWTgBroFs+jm5EHWepwS8ohldxzOTdneUPF0RlYNBvjOG5qGCTxZlMscj4CzVYWes8unwrXlGsnR0yVLI72SrWfURwXJMlmNvUCLboLrGiP79Yg1YrwSf6SEAdzZ2P1z/ErT3s4Lg+cZPxdbzmhPn6HGvfLyFom3cTskHZ+uI2wRUw5RWWQ69xug4pGSg0StBcaWySR78i1IDfGGkWlvD1PyOfXh6zP9JQMudRg6dAhx0FwUwLXj9IBSzI9tn1wQMcsPBKmHYntWZe/oY0M79XnEE+Jx5XQaS3D8yqjOCzYXAU7X8AoFaM3uOwVRx3s9h/C+NTSEBRLdEfnMtVYlFuwxXp3DM/YA3h12XB1RPOjTcTxHyAgkNTw3nX6Cp3vjGf93JeapWBqpD8YJzacPSF++sHHRy+OYSbPlqlzqdefImAl8zFx/P7gWhppscol/yQ++SAJdYT3m7ZJWkTqy01GZbV6xkFf+osN6/5lP1kwEsZnbQfM2UVa9ab3KZBfTWWMPeRIFyYQD+BfqaRbugbeJK/Yczv5WJHq+xjpJPqosZvRx+JGG8z2pBeLcfwDiRja2eJYqAKJ5n1i+NBYDjfod/6lyGu0dDa6NkTRLN4XkhTzetRwJKalD7rsFwr8tgZAx0C0ZWyvEFLie3OzOAc4VNH5m5X/jVt7VPuK+GLsSDXKxDmj4Za+rH0eqs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(82740400003)(4326008)(6916009)(6666004)(70586007)(70206006)(478600001)(7636003)(86362001)(356005)(40480700001)(966005)(54906003)(2906002)(2616005)(40460700003)(41300700001)(26005)(316002)(107886003)(1076003)(336012)(186003)(16526019)(36756003)(47076005)(5660300002)(83380400001)(36860700001)(426003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:04.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc530351-c086-4ff0-ff7f-08db932d80c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test checks that filters that match on source or destination MAC
were only hit once. A host can send more than one packet with a given
source or destination MAC, resulting in failures.

Fix by relaxing the success criterion and instead check that the filters
were not hit zero times. Using tc_check_at_least_x_packets() is also an
option, but it is not available in older kernels.

Fixes: 07e5c75184a1 ("selftests: forwarding: Introduce tc flower matching tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/tc_flower.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index 683711f41aa9..b1daad19b01e 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -52,8 +52,8 @@ match_dst_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
@@ -78,8 +78,8 @@ match_src_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
-- 
2.40.1


