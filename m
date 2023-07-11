Return-Path: <netdev+bounces-16895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345274F5F2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2011C20DD8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54541DDC2;
	Tue, 11 Jul 2023 16:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8C18AFE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41458172A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQZz2hjssgM7rlIeVfB9IMu8wR4ZHi6STHzaKFApZz0KmSnPjXsB2hlgOO484JE2GoYQhCvj8q6b7KrUFy6ZLsemkwi5HWTtcyEpQWweS7w2C7w3U9Dcr62iLlebE2emkxp2d9Cn9Y8ceAATRYcR1FJsF8SEXVJzRFsYTw6owdXMcQ+hPVhuy7kSMIsqnPWMjiAOVvd2NxEj31F45IBEDAM4KIHfnHfutND5bmE3KDP8IUcBIaO7q+unG+Mq79azQ5N60zYeoX63OADyAQ/3eyPOzCaPAP2avm4Tqm9FsH/bA4OJhtEToMk0dvNXYRUyjMxMALSLPGDfsBtfOSAlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rblY/kZiMNq0Mp/pvLas7X+0yzhZfObFXQkLxTzBM4Q=;
 b=H7FnxmgHHVFWEU9bCv3EGcz+YhkcmC6XoXtl757E43yJdqLmCGPCabJY6+5I/risA5vf65KlMPo7en+RD80IClxQqt/g5MmqYvUqMtoEfMCt0x6mFxHxnOt1tnCgKDKXEPzMeokLUd1QoFEUzR36VgfpxJZFOTRn9a5a7dcHb6fGHffyVeVykfsgoC5q0JVVy4TawAWlhBjxIR1EFUj9poilqDf80wgUtfS361o/hBoXtGt+G5e+fr3xJaqY5P7P9wkkVYWp/wWDXCEfbyk0Figb1Ru02xq9LupMmWZhPE+qvevgHbwHHzXCjMruXrxz1GYohLZWWsk7CRIu132ATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rblY/kZiMNq0Mp/pvLas7X+0yzhZfObFXQkLxTzBM4Q=;
 b=Nbww8yOjAT8OQ9s7KJHxwNnTtHHK+ipG5dZqMb6AEw8pUSANHTM3AvL6QjJ3ggxgwNW0QIYRv9i9HDIWgrMaeHWc67ENll+FoSRA3a3QHi5DLiRzWy+6ws8wZffJok3XDiuoALMeD6CQwWVQM7w4ImIBi6/LrpH40UWJpp9SGxPk8/hm/7nl8TA4efnfqlIaGSDI67KhkpiZZQVoao9ub2PkEmXORT3+hAOARsRCJCqnKjb98jtJEnWY3b1n5p2PnimlKmuA4hUwLYeUnY6M3oKeyR9P/rKgefbLTzitQPeR++rRRK37YB5xQ4yw8GioU/8uKiDKmuxFYbymohMJJA==
Received: from MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) by PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 16:44:37 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by MWH0EPF00056D02.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.12 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:25 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/10] mlxsw: Add port range matching support
Date: Tue, 11 Jul 2023 18:43:53 +0200
Message-ID: <cover.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 44941d30-1be4-4c0c-7022-08db822e1cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1fynJ3bpNPRLyckyrVJU0a8zGBYLgshG/cVbOfZi4WcN4jXQQigAN4xh5KXCVEtWuQnpSq+ZbiaAXQM3B5DffVPQmsjnoyt9kREIJ1Y79DMqOVndfzWjVJh1vBOsHmAq0mw5MPhXcCzrW1K44XewxuxMnQXPblaZmbBgVz0VblxVvafPTwYoqhmU5RrSbMq8xpI/eYCeQQ96+9z39CDtmBU5IFGxXzhTC7AmQmuWC2xZN6vooG5/7/i4mRajcZ/UF64+fcCxeFIUI96AfGqyO4kdYdo9AcmnqfEcls1j5MZILmcv0qQFb7nQdacjyjRujoYPQz6q3urDtOV8AvzJV2/ar2gej8lgTsuXX3jrmIVI7MwW6jb8acLBx72SUeBe7nqFavulvFmRQiVrHuIunAMRIKjhsZa3abUzkTLZNH4hd9M+qGYYBpBtT+V0epahxQPgmZqa5Bh7R+Z4oOkAfyEUjUAw0X11t8UHWfGVEA+mJ66jFKsGcLxFmbhAd537Hsr+WkD1GQrPt3l9iT+OzvxudO5SiihmzG1EUv4hX3XxdnlHYEX92c0KY++DWR5cYoJRAbU/iR2MmgF2pSpMvSBge6j5FNOP8ni2zl4yXwAYZA3r6tTkUVp5if5FezSkGxC5PEe94ONSFQ4wCDoX37ky0uJQm1CdLcoDeUhbjtW1zL/gBJR39RiW/zp3Q2odH5SNSv+jQRaQRe+D6dEbGMoqkS7cuLOIQSZZaWFYpTSd9aohOJHb1JTslHyk/d1L
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(82740400003)(40460700003)(40480700001)(36756003)(54906003)(6666004)(70206006)(110136005)(70586007)(356005)(7636003)(107886003)(26005)(186003)(2616005)(336012)(5660300002)(2906002)(316002)(8936002)(16526019)(8676002)(426003)(83380400001)(4326008)(478600001)(36860700001)(41300700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:36.8663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44941d30-1be4-4c0c-7022-08db822e1cfe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ido Schimmel writes:

Add port range matching support in mlxsw as part of tc-flower offload.

Patches #1-#7 gradually add port range matching support in mlxsw. See
patch #3 to understand how port range matching is implemented in the
device.

Patches #8-#10 add selftests.

Ido Schimmel (10):
  mlxsw: reg: Add Policy-Engine Port Range Register
  mlxsw: resource: Add resource identifier for port range registers
  mlxsw: spectrum_port_range: Add port range core
  mlxsw: spectrum_port_range: Add devlink resource support
  mlxsw: spectrum_acl: Add port range key element
  mlxsw: spectrum_acl: Pass main driver structure to
    mlxsw_sp_acl_rulei_destroy()
  mlxsw: spectrum_flower: Add ability to match on port ranges
  selftests: mlxsw: Add scale test for port ranges
  selftests: mlxsw: Test port range registers' occupancy
  selftests: forwarding: Add test cases for flower port range matching

 drivers/net/ethernet/mellanox/mlxsw/Makefile  |   2 +-
 .../mellanox/mlxsw/core_acl_flex_keys.c       |   1 +
 .../mellanox/mlxsw/core_acl_flex_keys.h       |   1 +
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  73 ++++++
 .../net/ethernet/mellanox/mlxsw/resources.h   |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  39 +++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  25 +-
 .../mellanox/mlxsw/spectrum1_acl_tcam.c       |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    |  11 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   |   3 +
 .../ethernet/mellanox/mlxsw/spectrum_flower.c |  68 ++++++
 .../mellanox/mlxsw/spectrum_port_range.c      | 200 +++++++++++++++
 .../drivers/net/mlxsw/port_range_occ.sh       | 111 +++++++++
 .../drivers/net/mlxsw/port_range_scale.sh     |  95 ++++++++
 .../net/mlxsw/spectrum-2/port_range_scale.sh  |   1 +
 .../net/mlxsw/spectrum-2/resource_scale.sh    |   1 +
 .../net/mlxsw/spectrum/port_range_scale.sh    |  16 ++
 .../net/mlxsw/spectrum/resource_scale.sh      |   1 +
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/tc_flower_port_range.sh    | 228 ++++++++++++++++++
 20 files changed, 876 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_port_range.c
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/port_range_scale.sh
 create mode 120000 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/port_range_scale.sh
 create mode 100644 tools/testing/selftests/drivers/net/mlxsw/spectrum/port_range_scale.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_flower_port_range.sh

-- 
2.40.1


