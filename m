Return-Path: <netdev+bounces-17644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE175281E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED1E1C2140B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1D1F178;
	Thu, 13 Jul 2023 16:16:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7211F176
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680E1BEB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnO2DLikgbv3HapNB56a63rPRuTRA7P3uzh73t3xlYnHkwlQia4a9GDIBWIuzxPOEwf6l4QQup5OBY0NfwQDAj1x5/m0oqaH98f1N6d+PXMM3L6uuqBU9DJKq4h1YG43uNjZURCF8qROLVILXh6OB0Rkab/JR5dHHQPiqefOxXTRzJKcg4lDEu7tCdR9KYMYeMtX7Eofz6b3atJTV6q2CJigPnn9p0J0cX51aMHcutQR1EgaqXtMfHynAJYUPLi+OOnmiavJEQAFYOlJQyZRXaD9e9EqvNS+A6q139taymbA6GaU2Nupwb/6ma9wdHvLDlLpLK1OH4uBUxEU8dwqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNoONxnONQ5YsGLIY9k2JyGDdyLNXnVi1rNncdgvQSs=;
 b=UkysmI7t67TQz/OzhYs5yMY8d8LLHyYlSHM0ZQCREh0xzmkiwsk/+XwVFtxNKCDH37VeULxOk0wgJhIJ7ojiaU64DLbwqxC8GvYmZS6yqs67wmn7YDa5j9DMJNOb8JbJTpcu0OZ21+JrRkAv0leF9aRKo4cnFeDsn0cawfTaS77tNod7jKadLGa+LP/qsX4TIumfT33hMLktIbv7iRPS/lep4yM+tukmByCI0fj22GGIYt6pXCDttSJVLIZEPWLfZcBoDBP6faeRlsVhR8LYYcexOpKqEf9u/Y5FZRo0YIZoVF26XARV4MLbiR22JlkG4cXZQ8q7Icle5gDq/Yg6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNoONxnONQ5YsGLIY9k2JyGDdyLNXnVi1rNncdgvQSs=;
 b=dTNPvzN11L8EyvB0rfcFe6X2tb4TgLd7yxrvbJ/ilTsZrwKC36EV2XPQGItJyof3DQQVNIN64PQd+M+tvUQPaDnbYbyQt/F3qNUXgJXwfGM+KYkIFLWez8Z0BaXjau36yNw79rorGPT1MY+6+wlHRx97sOhRTyn6+PWKUlcpoZ/91HJOA+zCNdDC1uAeqLACvEme+/95h+CiLNFFJAyeXulO0KOAQ9ratQJs1DNR/q5clx+WpYKTbtVSilP0Z7wstN8JHcOoIKth3XY+uCshyPgxfybr8flOiMtnRc04KTxbWlhJLA/7voDC/bexwCFty20BK0g/kql20c9ORuPthA==
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 16:16:15 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::46) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:01 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:15:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/11] mlxsw: Manage RIF across PVID changes
Date: Thu, 13 Jul 2023 18:15:23 +0200
Message-ID: <cover.1689262695.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: afa06b7a-2a8f-421f-40fc-08db83bc7b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P9t7VmHHIT4TuQHWlIdZgA8pXPIPZqDacxrLg41Cq5KNskyCqJ3/FhYTX9nAR/RzBeJ5R/Od9R4akXdJ1/myijJEI1kfy5DUvm8qkkQHaObFiyd/6v1jln8VfX4CFN8mE+PUxV7Pq/fWyT1Nh+zMKN1T7Thp/WVDqlVo/6XH+K7MZdwkH3jLak7Kr3sstEp7Jxn1um8yQ1j8LDfsf8kBH8g9M8lQZcxKF7UtXoYLMaPKq2xbA/nq2s2cl6jMZUtgqigB4nlCX+GWu6Ds3QUHBXCC/jXDCFbkGs3XddoT8RYH+O/WajkhIyHXfdeeeMy+0wShl26lkuYqaQP6MTpHKZselIouo5vtVrBHNNjI/ABFfuU+zXxg70fLQT0RxKeu0Ajtkwz7eLPKs1M2qxnou0K+rEamOn5rQUfjETQYYxFF1zdrJrN5Q8vJe5DR6DL0JNYMIO18qu1Xg5wRQsHnSvDhxJOFOFfsgJriUYpchw9PqfwIK1e1U+HqDSn/exc5xTH7+OMOpz6qCp3xKtzS1fgGQxyVZvmuSKQaVMT42W//7I6TGH6UMUZm5tps9zCld727ryuhz9W2pMiPQgS7pgVsvUq5khHEJzDN+GX+RQpwa7xIb4wmlRdBGvypDgYYO8wGlyfAspTZQWvBN3/EFKpdp1FMhiQGSeerqp2nO24P5reH1QjL5gEwNeAeZQXejaad1bWzBoht70OWDWzb96lgL8cHKD4ey/wI1PH+3/UbDKtMt1dXawhotLtGo/JL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(4326008)(70586007)(70206006)(316002)(41300700001)(2906002)(478600001)(5660300002)(8676002)(8936002)(54906003)(110136005)(36860700001)(6666004)(40460700003)(26005)(40480700001)(107886003)(186003)(36756003)(66574015)(426003)(336012)(83380400001)(47076005)(16526019)(2616005)(7636003)(356005)(82740400003)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:14.3172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa06b7a-2a8f-421f-40fc-08db83bc7b16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mlxsw driver currently makes the assumption that the user applies
configuration in a bottom-up manner. Thus netdevices need to be added to
the bridge before IP addresses are configured on that bridge or SVI added
on top of it. Enslaving a netdevice to another netdevice that already has
uppers is in fact forbidden by mlxsw for this reason. Despite this safety,
it is rather easy to get into situations where the offloaded configuration
is just plain wrong.

As an example, take a front panel port, configure an IP address: it gets a
RIF. Now enslave the port to the bridge, and the RIF is gone. Remove the
port from the bridge again, but the RIF never comes back. There is a number
of similar situations, where changing the configuration there and back
utterly breaks the offload.

The situation is going to be made better by implementing a range of replays
and post-hoc offloads.

In this patch set, address the ordering issues related to creation of
bridge RIFs. Currently, mlxsw has several shortcomings with regards to RIF
handling due to PVID changes:

- In order to cause RIF for a bridge device to be created, the user is
  expected first to set PVID, then to add an IP address. The reverse
  ordering is disallowed, which is not very user-friendly.

- When such bridge gets a VLAN upper whose VID was the same as the existing
  PVID, and this VLAN netdevice gets an IP address, a RIF is created for
  this netdevice. The new RIF is then assigned to the 802.1Q FID for the
  given VID. This results in a working configuration. However, then, when
  the VLAN netdevice is removed again, the RIF for the bridge itself is
  never reassociated to the PVID.

- PVID cannot be changed once the bridge has uppers. Presumably this is
  because the driver does not manage RIFs properly in face of PVID changes.
  However, as the previous point shows, it is still possible to get into
  invalid configurations.

This patch set addresses these issues and relaxes some of the ordering
requirements that mlxsw had. The patch set proceeds as follows:

- In patch #1, pass extack to mlxsw_sp_br_ban_rif_pvid_change()

- To relax ordering between setting PVID and adding an IP address to a
  bridge, mlxsw must be able to request that a RIF is created with a given
  VLAN ID, instead of trying to deduce it from the current netdevice
  settings, which do not reflect the user-requested values yet. This is
  done in patches #2 and #3.

- Similarly, mlxsw_sp_inetaddr_bridge_event() will need to make decisions
  based on the user-requested value of PVID, not the current value. Thus in
  patches #4 and #5, add a new argument which carries the requested PVID
  value.

- Finally in patch #6 relax the ban on PVID changes when a bridge has
  uppers. Instead, add the logic necessary for creation of a RIF as a
  result of PVID change.

- Relevant selftests are presented afterwards. In patch #7 a preparatory
  helper is added to lib.sh. Patches #8, #9, #10 and #11 include selftests
  themselves.

Petr Machata (11):
  mlxsw: spectrum_switchdev: Pass extack to
    mlxsw_sp_br_ban_rif_pvid_change()
  mlxsw: spectrum_router: Pass struct mlxsw_sp_rif_params to fid_get
  mlxsw: spectrum_router: Take VID for VLAN FIDs from RIF params
  mlxsw: spectrum_router: Adjust mlxsw_sp_inetaddr_vlan_event() coding
    style
  mlxsw: spectrum_router: mlxsw_sp_inetaddr_bridge_event: Add an
    argument
  mlxsw: spectrum_switchdev: Manage RIFs on PVID change
  selftests: forwarding: lib: Add ping6_, ping_test_fails()
  selftests: router_bridge: Add tests to remove and add PVID
  selftests: router_bridge_vlan: Add PVID change test
  selftests: router_bridge_vlan_upper_pvid: Add a new selftest
  selftests: router_bridge_pvid_vlan_upper: Add a new selftest

 .../ethernet/mellanox/mlxsw/spectrum_router.c | 169 +++++++++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   4 +
 .../mellanox/mlxsw/spectrum_switchdev.c       |  32 +---
 .../testing/selftests/net/forwarding/Makefile |   2 +
 tools/testing/selftests/net/forwarding/lib.sh |  18 ++
 .../selftests/net/forwarding/router_bridge.sh |  50 +++++
 .../router_bridge_pvid_vlan_upper.sh          | 155 ++++++++++++++++
 .../net/forwarding/router_bridge_vlan.sh      | 100 ++++++++--
 .../router_bridge_vlan_upper_pvid.sh          | 171 ++++++++++++++++++
 9 files changed, 643 insertions(+), 58 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_pvid_vlan_upper.sh
 create mode 100755 tools/testing/selftests/net/forwarding/router_bridge_vlan_upper_pvid.sh

-- 
2.40.1


