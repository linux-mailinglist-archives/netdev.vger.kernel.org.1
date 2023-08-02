Return-Path: <netdev+bounces-23549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA576C78B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33448281CF5
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E55678;
	Wed,  2 Aug 2023 07:52:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D15677
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724E55273
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/fcZ0RU223gt/kjFlL/2yUwoM7P0pQLmgTHmCeiUg37dcFOrCmcQBlAroQvZPC8BHWz+VxvQ1mbCEHfGhRWiuK9BYYEyUdJKLBuPLSVQ3Ls6Uq6t/l1Ivo6a7A0Wf5ggl0cr3xPHtdTAKz4m+XUOryxMHs3lG81Jv2L+Q9xWoZZsKmqhr5BHvPnwl96TgOP2tqE8Dpo4qxCLXSvlsFlBkLg1hP85hS2zKB5GN25l3mkVtyCuX9ramkIwYwcmFIx+4vuomg9RrBxQC8+DJ60R1wTahX8xNPQW3mlUZf6niPF4d2Zr12H0m+hTdmttIfLonwsxSWbz4g7Cwdnc/FbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMH7/T/+FkOW7OBEITpo7Jk2nnS/EDOloQLZqEulg0=;
 b=VfGeVf94WK7EJjzYIz2GDYIpXpkj7x2Gxgp9s3t0A3EekONh6m5dRe5tVeFG/qsFToEaAAb1a2SFs2thGx6FgurOhPeu+UqV2ndhwtYf34+4OF+zJQv+p6kQ0GZa87TV0YKTDy7L7YEj01b/RWY+q7Sw9815JERBbmuO0LNrhQA4YfswG8T+AsFMeL9uWe9tjNkypHoy+8PY9OoYT3MyyLIl5SpC3MFQT6H73N0Zcbx7IF+gD5dyFV2Nr4W50z8yF3BskE71tyf06mevhd+4V/CMYfHW4LEuAJAwsLJZehgSq8tqi2NmS4QSivsfvYsEsenp7Hvmyc5ed050eMO67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMH7/T/+FkOW7OBEITpo7Jk2nnS/EDOloQLZqEulg0=;
 b=RwU3f+N9b5nV8MPxjZtiLiaVFRsGuNbhCFtY0adCYmn/nEPmW9jtZqecfrA8x3Pyrw1B34RV8euNMpoDSkEu9kzVip0ezugK8B9Gx7Z1bHmOrXOq5ioV93pU6WySWSDZygWM7B9/ZGIEwJCRjDZ4SnZfzhioEIj8iBXaH6lBEM1UQXzfus6CfafTCwvVbVd1/G4Xfqt4SY52J7eLGXcaji915cIc5SzTi2oSNMXCPEqnudBIJVd2qbfnEel/3sJYh6m0CUOEgcvFazU9n/r9z+4LOoalnuQ+TXnS/R0YQGg/wIw06gQ6TSAC3X1dyhBT1o5QgFvNpwl9QgNOJ3gH1A==
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:45 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::55) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:32 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>,
	<ssuryaextr@gmail.com>
Subject: [PATCH net 05/17] selftests: forwarding: Set default IPv6 traceroute utility
Date: Wed, 2 Aug 2023 10:51:06 +0300
Message-ID: <20230802075118.409395-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bca429-6faa-43c0-7168-08db932d7530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vu3H76xd+ywzNKkbEaexjX/+XRJmJWnFI+J4zOEaHcotcWrfPPNqXvlX3t1f8sETKtMopU59+hQ1DijLWJRvVgYwPemZ+NyBLl3OtgFss5zvh43ONY9xCBDz4fk/hUb61WkhgMdZKu2ScOr2hwOzpYh7Rvdiun4howJol0/aigtK9PemcvM9mxMEw8Bf/kqVAO4c8IPsDHNQOpveRwZgUEIMqhLYbBqiC8Z5QfOBRYEXrq9GuCUvLcljqGRvaTPzvO2B4FbOnejbw5XX/JQ4nEJh2DVq7oreDaej7TM5jmbQc6TXqmFw/yitA7yM5ByBPfTm/DGDnRExQXxvDr7lHkek8kHKZSNtt9ocrHxsa+eCe45Ie9gimoROXJigZCTtZaWyTIpIMINHFJRXx65I4BwPPJi1bCWif0qyf65vaKaa/zlV6wYJpaWBk9sXY9FjLVl7sp0jvNdRbe38dIxxF82FATZCWu4JYRpRW6bQNtW6JRSNEj2URPPob5OHsnFU56K+HPTjV9bhSW6JglDJnQ9nY6nXtyi7LrDeWvLOxmApPki+VcBxPlR3AbTn9jiErIVn2n1ph+h3k407OzFk5R17h+Shbt6ZO5Oez7voklJsJBMHta297BnedH0W9aGBlW/XBlYLlj3FK77AO8l098lo9TaDUDKkwjRKlL97fQXUjsu+io8opC+gVXQfIWNH96ZeiytT0CTHmqBMSKs69bwviMSrh9Mhb0swGIM2nOshjD+o1yLBGAi0VtfzX58U7Kv/l7W1ptCYMzb3dKKKkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(26005)(1076003)(7636003)(356005)(16526019)(82740400003)(336012)(186003)(426003)(2616005)(36860700001)(83380400001)(47076005)(36756003)(2906002)(5660300002)(8676002)(40460700003)(478600001)(8936002)(54906003)(86362001)(966005)(40480700001)(6666004)(316002)(41300700001)(70206006)(70586007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:45.1040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bca429-6faa-43c0-7168-08db932d7530
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The test uses the 'TROUTE6' environment variable to encode the name of
the IPv6 traceroute utility. By default (without a configuration file),
this variable is not set, resulting in failures:

 # ./ip6_forward_instats_vrf.sh
 TEST: ping6                                                         [ OK ]
 TEST: Ip6InTooBigErrors                                             [ OK ]
 TEST: Ip6InHdrErrors                                                [FAIL]
 TEST: Ip6InAddrErrors                                               [ OK ]
 TEST: Ip6InDiscards                                                 [ OK ]

Fix by setting a default utility name and skip the test if the utility
is not present.

Fixes: 0857d6f8c759 ("ipv6: When forwarding count rx stats on the orig netdev")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
Cc: ssuryaextr@gmail.com
---
 .../testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh | 2 ++
 tools/testing/selftests/net/forwarding/lib.sh                   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
index 9f5b3e2e5e95..49fa94b53a1c 100755
--- a/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
+++ b/tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh
@@ -14,6 +14,8 @@ ALL_TESTS="
 NUM_NETIFS=4
 source lib.sh
 
+require_command $TROUTE6
+
 h1_create()
 {
 	simple_if_init $h1 2001:1:1::2/64
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 975fc5168c63..40a8c1541b7f 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -30,6 +30,7 @@ REQUIRE_MZ=${REQUIRE_MZ:=yes}
 REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
 STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
+TROUTE6=${TROUTE6:=traceroute6}
 
 relative_path="${BASH_SOURCE%/*}"
 if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
-- 
2.40.1


