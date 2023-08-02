Return-Path: <netdev+bounces-23544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2076C77B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6FC2811AD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30965255;
	Wed,  2 Aug 2023 07:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46285226
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:52:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B25259
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHBBphx0mOe3uOuYC5fP/1G33uIImDuqjIRfpbYDXlfAnt4iY2J3yfuxSX7bS4c2iX8SUWAJzWR6eSIog0mYuGeGtzEEjGfxziTJiu4PnLMaohlDDQccP8UI2f+9IyxAiIR8eJMJVogZryB9yhbBEU3QN7TWDXF4SUgKLhukaG1MVZ2BASBQxqyBVjvWGrNnR5x0w2F8AnSKtc13S/BadFzh70IWWZUij6Zkwn8ju3YYyKNni/MaXPqQSRAi5tibiEiiSYPDuK6XDLS4qVy5ZvGNi4QCFnQTt6F9QBY2XdI6dOXaxs6hm+owTxM3MBwtsWsolFC+8F2XAFtRSeCMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAonF9ZKjlc1MKKLzUTyE5SMT482DXabXaXGCDtk8Rw=;
 b=fySLrerkc2jZYfxsfWLEd5MoFhq3j0Vs5Zh7xqmo82wcdT1JiTKii+dufN7FF7POzhMcoa0bpRlsndJQIGES7AqKV6AGMqj479OuIIq5ODu0xZ1shliSbKOPgUWQQjGcYjXPJT1lbDBafuj6nMaWhvBsf2Gvp8vMSfsXnSwa8nOmVR5eDYEpiyPLjcqB6QzeTPlbuobeWTM9/cWeZRbFOr2TNmJh3shgYuyRngZUOey5EFJFtxGnyRva2XwbZAIRZCF44mZWWUWM3Pdz7W2g8ap5i7p6VrmXxJ7454npg0TBJbVnbg2RokdEdHYwDzzw3Wf6G+a40ygSzAqXqK39Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAonF9ZKjlc1MKKLzUTyE5SMT482DXabXaXGCDtk8Rw=;
 b=fA4hjSIm9kMw36hYIflwY0eEyo5RdUh0hkpvPpNdpuLvxjnOVMg4ela87U12RTtAfuUDjZIs08+6lfUezObsXlBZILrMtYa8v+jrj4if+zt0k6rG1nHrnzugAg7+iWr4vz3AiHr4ReSBRazLuh4gYK5WP7UiI85XG8Dc0szWSoaXFoMPixLRXXELap+F4oqfv6jnDx/UWufn5XCnPbktlRRsM62WgtPQ1jWB+iizQJBkfNMIdlDzeRBIJROQi0tR1CZn8AwagWFaeHcXScZr+FJpXcGN75z1bAxA0fLl2srqnQwzapVfHae6UcQZLw9PSFDtxvUuFWyg4lDDEIB0Zw==
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:52:29 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::ee) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 07:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Wed, 2 Aug 2023 07:52:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 00:52:17 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 00:52:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<mirsad.todorovac@alu.unizg.hr>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 00/17] selftests: forwarding: Various fixes
Date: Wed, 2 Aug 2023 10:51:01 +0300
Message-ID: <20230802075118.409395-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: bc662c10-19f0-4a74-f06c-08db932d6b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/JA5dhNMoYEiUxLYVS5jG2IUN6tx/OWd6pMLnVsU0d/Vts3zWRpwKPnoiYIvTTf5+esB4XzI9Ar+lBAgA/kOhUc8jKYkDXYmqtGhTuwshNEYYwHlQXx47VkiN7M0Y4+9GnLFZp3MxG6euIP29qbncuzi1kux/aC+8wddodZTniFLvDoAWMPyw6VxhnuHAa9IrEb6DXWLE/CpLbG0VdblOtPyVLJB958k1B30cbUL7YJvxwUJa8fHjiQzXNxD+0hS1eRV2yLaZcQT7f7xprRlSp2AwCiQiFPu3KtB2Oj9+MmvO2rEHPlllD+L20hxVAWhkulnQ8ViMpZyDK3UVAuKfnwYWDK+Bnrhyo2vyEYKwvn9uHSOJDI+tXvHLVyblaUg9+wXcTSnJa6ct7q1Gy/fYr0Fw82cbz+8oRDHsplPZlzgHTqyfxJ2S/aHxExKaBgMa3RlIyPmqDRe81A5cUCNn3HFqo/+i5IPeX70o3SxlaeDomzYp1gUzhhERIewb0hP0UVAKv6ldv615GvFa5t08LwFmwij2kPpFStpDcLNOkU282CfST1YhlqS1OQojwmA+wS4Lf8nizatnpjXEIG3MVRN4lD4DAh0ZK/9daz+bBaRCMXbnVm+cO8wSH9hHl5KUgc1MYctlTaqRwJ+L4sPSGQxpWrFPf3/35J1v5xIXyLOECr/ady28PfuktdCd+uUcYdvAyMT/QILsabhc8HkgZRhmSbTp+9TwvEv79B5kc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(82740400003)(356005)(7636003)(16526019)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(107886003)(36756003)(478600001)(6666004)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 07:52:29.0272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc662c10-19f0-4a74-f06c-08db932d6b98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix various problems with forwarding selftests. See individual patches
for problem description and solution.

Ido Schimmel (17):
  selftests: forwarding: Skip test when no interfaces are specified
  selftests: forwarding: Switch off timeout
  selftests: forwarding: bridge_mdb: Check iproute2 version
  selftests: forwarding: bridge_mdb_max: Check iproute2 version
  selftests: forwarding: Set default IPv6 traceroute utility
  selftests: forwarding: Add a helper to skip test when using veth pairs
  selftests: forwarding: ethtool: Skip when using veth pairs
  selftests: forwarding: ethtool_extended_state: Skip when using veth
    pairs
  selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
  selftests: forwarding: ethtool_mm: Skip when using veth pairs
  selftests: forwarding: tc_actions: Use ncat instead of nc
  selftests: forwarding: tc_flower: Relax success criterion
  selftests: forwarding: tc_tunnel_key: Make filters more specific
  selftests: forwarding: tc_flower_l2_miss: Fix failing test with old
    libnet
  selftests: forwarding: bridge_mdb: Fix failing test with old libnet
  selftests: forwarding: bridge_mdb_max: Fix failing test with old
    libnet
  selftests: forwarding: bridge_mdb: Make test more robust

 .../selftests/net/forwarding/bridge_mdb.sh    | 59 +++++++++++--------
 .../net/forwarding/bridge_mdb_max.sh          | 19 ++++--
 .../selftests/net/forwarding/ethtool.sh       |  2 +
 .../net/forwarding/ethtool_extended_state.sh  |  2 +
 .../selftests/net/forwarding/ethtool_mm.sh    |  2 +
 .../net/forwarding/hw_stats_l3_gre.sh         |  2 +
 .../net/forwarding/ip6_forward_instats_vrf.sh |  2 +
 tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++
 .../testing/selftests/net/forwarding/settings |  1 +
 .../selftests/net/forwarding/tc_actions.sh    |  6 +-
 .../selftests/net/forwarding/tc_flower.sh     |  8 +--
 .../net/forwarding/tc_flower_l2_miss.sh       | 13 ++--
 .../selftests/net/forwarding/tc_tunnel_key.sh |  9 ++-
 13 files changed, 98 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/settings

-- 
2.40.1


