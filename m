Return-Path: <netdev+bounces-23561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A676C7AD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FFF281D47
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACF7482;
	Wed,  2 Aug 2023 07:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962BD7476
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:53:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4B4483
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfG4Oh66OY6zeUYX1Prs2abh1EHnZL3DAOzHRvc3c1SvCPjR/r7RPogZJKSI3e4n6ZPOEMlxIhoOJrsxJrhiDlb4ujJZaHzdgFXR13wJtB6/jW86Ufjvb3nLVR2cIfU8ZPXpieSIxWU6OsuAnAR7NJ027KtTVPaL5FD5MMqdCSFIpYrgncXtjig5AQLCW3X8EAg/xbByUlfe4X+q0fkwbPWd9UPtNWsxMyohZRZXA7FYWdF3YS+GK0TaPbgjz1xsio8yYelnt4SBqNJbalfeSVc//NqkJ02w0CJ/YfJcRGbQqHKzUcAep7LrdJviSFuVrXNGBJP8F4NXi7KSYyX7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY4LdH3HUJjXdfHMOCXvQlivPPQzWf2Vzu6e96uaQ48=;
 b=FSc29mzCBKL/x5/gr/YnTCVPbSU8YrtBnh8ADLzs3SkxMo4AM3aAC1jCDCqtMhf9tyMSXpBQJcSKnU3Ncb52PHozYPlegv60/MyajmthKjpEZZOA74NdyPP6jb7fBY3ty/8JR7vhHn7Htrpn+b7lHHbq8k/KI8a3LR7bXSjCnkVQrDwZAPCzpycObYV5eBUoDiMfPbAldr6vqopOIQf0ApCQG3gxVR/cl4FBgELeF3Ex79S7N4VpacXnoCwt//OQDfKh3ZLX3DzWcpvkAnLROU3wBMrMk3lebbSxjth5BzNShmWxMQed3I7zEXH28tm5OC6F27dATmU9XChcF0HFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY4LdH3HUJjXdfHMOCXvQlivPPQzWf2Vzu6e96uaQ48=;
 b=R5ruXfGJITrPIiHpMSg56EOCWDqqaZatYFyqkSelhL40tJlLDlyE3AnEC9cXO2x2BUu7Xdi7mbU/iQ82pspdoOW7XLjRKY49KAcY54FuTv/hKg6jVC7awU7x1mE4fxFpgR+Gz/6vFu+iYFZQ/pJRVDDIPul5bTbYhlGNNL9BwYI6ht67yhmmAbbK7O6UpMqSIQM5Rb5zao2WrjlDqGApyhEhMIb46e9XIShyW0V+6I8+Yk3np5pYawJUICx+opaObbXcJ+YrWzYt3JdGh7waLKhi03lOCvExzlBAA0BY6QnjzWueWMEQUbCGL2rt5ZbesIPblmD2faR2q+xzU91Riw==
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Wed, 2 Aug
 2023 07:53:20 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::79) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47 via Frontend
 Transport; Wed, 2 Aug 2023 07:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 07:53:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:53:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:53:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 17/17] selftests: forwarding: bridge_mdb: Make test more robust
Date: Wed, 2 Aug 2023 10:51:18 +0300
Message-ID: <20230802075118.409395-18-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6d5761-baab-4f05-666f-08db932d8a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IEc2hYnSQRbD1zoOMbNdGOLhQzVv43YGS2I30rYt+0zUod1VuHUs8AYHSEdS1tdEO/o2V+84+1aXC4v2WE1VOMcbTZM49KGV6wGO94eeqsLgOAHq6l+Z7z64KoAZO0qI9CzrN1GYh4LuKpzwwD6IKeZZvYlHzuMXG0jWJe/LsyMqLYDw5z5fFDjh0Zs1YZwokoUeDJohDEpyvUfGROe20MRrpalHU5/Di4HUqCGxXlOAGqx6NVf+A3ZSAv19G6nzRgk1nJzaPS/GzcCx035Gls2blBeev5ysQ5obUYH5MV8TSiz1dXi/djpSk9lsmhp33/HpE6AoPH20yKOJrYOWn8vpPE+yTwMpwYMECKwT6R3q4VQTynQ830YXiIm4QnDiRIK/Elqn4OjZXiIq+H84u3PJAgqoI/1p0Xf8BVDFnNILmsd75rYtlxaGR42K7OFouc9z5SALi5wLvE5a05on27yPBEaga5RQ3oEqbSC4xc/46jaOQqrEAP7dUDrYok4vyaWlrrwzUS123Ai8ZxB2QNwJap/Nud8a9Zndb0sWvWtWFY7tL8+Ri/Pqa+CFuLNXTXDJqay2MfYdcNNZgg8mBFsWUaHgPZTtIcQxJZ5lJKS5WblaGnjCCc0eMUKvwHYb0fwB+4BP1FHbwM4mWOb9/JH+jt6BarIh94nTp7z3LscyIXIJbYyZeRQjXz+Xi6naWKtUVN3PTOE3aRbxZ7KDP8bMyd3lhmZXKhfFP/DZDjHNfNJbK16G8oXvI7lHYyFMWoj5+5qK5QE8lgJ9u8c5fT7pTVcx1gjqvA75shYlZWw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(4326008)(41300700001)(8936002)(5660300002)(6916009)(70586007)(70206006)(8676002)(40480700001)(2906002)(54906003)(478600001)(316002)(107886003)(6666004)(40460700003)(966005)(186003)(82740400003)(356005)(7636003)(1076003)(26005)(16526019)(47076005)(36756003)(2616005)(83380400001)(426003)(36860700001)(336012)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:53:20.3676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d5761-baab-4f05-666f-08db932d8a3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some test cases check that the group timer is (or isn't) 0. Instead of
grepping for "0.00" grep for " 0.00" as the former can also match
"260.00" which is the default group membership interval.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 4853b8e4f8d3..d0c6c499d5da 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -617,7 +617,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not added as \"permanent\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "\"permanent\" entry has a pending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -626,7 +626,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not added as \"temp\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "\"temp\" entry has an unpending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -659,7 +659,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not marked as \"permanent\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "Entry has a pending group timer after replace"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
@@ -667,7 +667,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not marked as \"temp\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "Entry has an unpending group timer after replace"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
-- 
2.40.1


