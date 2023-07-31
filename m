Return-Path: <netdev+bounces-22871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7205769B16
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB3F1C20C5F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342B18C3A;
	Mon, 31 Jul 2023 15:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CE18C35
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:47:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04E133
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epI+GkrrH07zKXt4bufA7poiEmvJ4ODCF71UbLpRYi9yuC8EVAUOJYkTq1W1ibS5IGzm0KSU0GjBZPjCoRLQy8Av7mm3+HJPVt7sBE5IJyrAg2ff39BudM2bFOT8iUy/LoujGhT+C5N9gms7QxXQV1rynZ29fNg67aM84a1b0KW09W3vXsuka6OyqDrqiVKTuO+wqsVgyIqHRXpyVDjSDmYEWL80mrh1DltZXImr2V7x2bVY08R3ylRjuI7LfZEybKO1Bzz4ngHd4Cx302oxTxB7CdqGbycrT2sKzS/U44CH6otsWBCjMdrQHv+CEm6YE2wxRdDW9Ff7+4DFJ0wubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOnmsMDv6frqoLC45cOQOSNTtazILBR8EbmpOHRH1i4=;
 b=BRrGqWlz1TGSLN10l+D0j27tWikyxwRYY3Sp2Tg8WGEuLe6E4Zssmsoczb0CK9y/nkUaDtDZb4OGXFL7szKR8UJ57T+QOKhRckDm/jRmLX+rILBowanCvjfI1ahWF5BYNzSz2rYWTtqOonBRRSegYuS16fZVApqFqjJzy6BfBKi1d1+2OU2n3oLSHkAYC+ZaiLgTqUUtNo0rJflgKTFa6Mhbj8cT2orm7c9/hLsPBQoSdONrWggGMf2gJXC+S7f9FwaAm8RT8EpT3Q7tdTEPrFnOGcgufAoH5muAwKdQrxlALSOjq9BR2z5QRo1ymqHWEp29p1Wcdqj0lvMu+XxMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOnmsMDv6frqoLC45cOQOSNTtazILBR8EbmpOHRH1i4=;
 b=kcedGXXmAgkxH7/2/6NPZPdx+j03WGNz87z8x/Wtj3MLjoImGgNEYLKzpKV/JpNGF290cGV4Vx1YUK55qdOMD+0pWSfuHea9v2UoI5AQsVqGktnJFfHMQBy5Yg9a3+xqRLx1rQluu6qJl0tah6nPzy4Chaa0z4ZyHYv8ADDiUdw7HaYPytfmcRD8nO7UewsKCfXNjyhcpLGpAWkAcJTpigh91Am3SfIhvPk/HOdYDNtT0iuFOS1eS/tWbmsnMcTTfr8vqDsJqni+9Zn4qdxnB1Wi8rST0hRTOhVglDQPzlq6OId91kikfoqEcGKSUx/zrOwtIM8BNygaAxCPfeb19A==
Received: from DS7PR05CA0080.namprd05.prod.outlook.com (2603:10b6:8:57::18) by
 PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Mon, 31 Jul 2023 15:47:53 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::6b) by DS7PR05CA0080.outlook.office365.com
 (2603:10b6:8:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Mon, 31 Jul 2023 15:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 15:47:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 08:47:43 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 31 Jul 2023 08:47:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/8] selftests: New selftests for out-of-order-operations patches in mlxsw
Date: Mon, 31 Jul 2023 17:47:14 +0200
Message-ID: <cover.1690815746.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d688f2-3d08-49b0-ad2d-08db91dd8029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A8/w6XPvF9svocmT5xzS8u61jLVHeuddm7krNsmbpKsIBanl4kq/kUxz0nPJ8OytaR6rcja36dp+/GxvrXvfH6FrybB2Bd+jBld6dumuCAbUBkNpXbnXjlXq/uq84l0YTcWwMW+9NBBlVEOKMMsP/87GszfmppPqPO12+JCdd9V8zS/+nP0JRm1Uv3d6SFff2Z+qLFGqQ2CXlN2bs5LIS7pNCwkCRgmdPnM0svpJvwRxtNGZEw3dvtlUAnu8d0jWH5Y4fS9AgFfT+qwD3lSI1b1jY37HutSEEHrPYed4MQMRXdtiDgTHAlZxr+Ew1doj2Ouy5dTprFnbI3WNux5cKq86LJACo8PSohC3P+daypH5NvR6ElQLrSCziVWX0EjTVo0zP/dXP2em4ZSLrEdyo0kc36iB2nvt8ThMzMd2AK/4xwnkPRn7ESxTtBdU4/3EUYqYcfAz2wdKfFo2RYYcCWTEzEFgJpzr9mrs9dIGu+QD3NllX2RyxH2VxyE0fc2Dmkii0vzIlVcjnKRFU0vek473BncIEY0UqGxkAaSOOwG6VKlWI/Fmzo8UMabj465ISlOIy67BeNWZfcFaXNG12X5PrYRcVw7NcohhQD9lFV6/PTfLT+Dj1iYGRBlsBI4mchk0gZcnI3QB3LIAXF7k5dFMPBRuiQG7IPJeIl6QC8ZZYax3UoXXaGqPL/LAnLxNHLI9oRXCcAYSSv83mhs4bnl3LtZxYj2X4iin/WEFi4p04voqBNi/5p0OglhT8gfCL2c72cmFZmpfikoS2eQN9g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(70206006)(70586007)(4326008)(316002)(110136005)(54906003)(41300700001)(2616005)(478600001)(7696005)(6666004)(8936002)(8676002)(26005)(107886003)(16526019)(336012)(186003)(66574015)(426003)(36860700001)(47076005)(83380400001)(7636003)(82740400003)(356005)(36756003)(40480700001)(86362001)(40460700003)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:47:52.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d688f2-3d08-49b0-ad2d-08db91dd8029
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the past, the mlxsw driver made the assumption that the user applies
configuration in a bottom-up manner. Thus netdevices needed to be added to
the bridge before IP addresses were configured on that bridge or SVI added
on top of it, because whatever happened before a netdevice was mlxsw upper
was generally ignored by mlxsw. Recently, several patch series were pushed
to introduce the bookkeeping and replays necessary to offload the full
state, not just the immediate configuration step.

In this patchset, introduce new selftests that directly exercise the out of
order code paths in mlxsw.

- Patch #1 adds new tests into the existing selftest router_bridge.sh.
- Patches #2-#5 add new generic selftests.
- Patches #6-#8 add new mlxsw-specific selftests.

Petr Machata (8):
  selftests: router_bridge: Add remastering tests
  selftests: router_bridge_1d: Add a new selftest
  selftests: router_bridge_vlan_upper: Add a new selftest
  selftests: router_bridge_lag: Add a new selftest
  selftests: router_bridge_1d_lag: Add a new selftest
  selftests: mlxsw: rif_lag: Add a new selftest
  selftests: mlxsw: rif_lag_vlan: Add a new selftest
  selftests: mlxsw: rif_bridge: Add a new selftest

 .../selftests/drivers/net/mlxsw/rif_bridge.sh | 183 ++++++++
 .../selftests/drivers/net/mlxsw/rif_lag.sh    | 136 ++++++
 .../drivers/net/mlxsw/rif_lag_vlan.sh         | 146 +++++++
 .../testing/selftests/net/forwarding/Makefile |   4 +
 .../selftests/net/forwarding/router_bridge.sh |  26 ++
 .../net/forwarding/router_bridge_1d.sh        | 185 ++++++++
 .../net/forwarding/router_bridge_1d_lag.sh    | 408 ++++++++++++++++++
 .../net/forwarding/router_bridge_lag.sh       | 323 ++++++++++++++
 .../forwarding/router_bridge_vlan_upper.sh    | 169 ++++++++
 9 files changed, 1580 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_bridge.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag.sh
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/rif_lag_vlan.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_1d_lag.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_lag.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper.sh

-- 
2.41.0


