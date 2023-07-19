Return-Path: <netdev+bounces-18955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4277C7593A7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16C62814E7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15082125C8;
	Wed, 19 Jul 2023 11:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029088830
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:02:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35219A
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShH5uRlreUNyKtsG8xVzjk6ZR31cK3OHxTe62T7XFQrRiYBTzk9/J2BQZekaQKBk+P8sEx5nZc8ctoAsuR/ugaGrb2pr6WvZXdZsgfi2JB47OSl1k2G+O3u7uzoGyOrzooL2mrzq551Yjb5AukYPUnlM4jTvXTIkA5SrMs5lPy4OnmSRRyCZfu2wZeqzUKgWSxGzlARQVo6X7WPqqbGUGjVY5ioT39TUnSj9YEfiE0PSCbnvBtvNgsdsrCY8fbFP1GSJ+L3q6yEiVWL/1idHvZtpspmN1BemDMaeYqi7fn4VXw/U2ng6CFSkSL7+I3LRvmsECLA94FXKQK+iHGHrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=060pTV76J7lk2Jb6rDTWGNEqLGOng+mmfr+/2fuhMFo=;
 b=aBaa8sCGxvYT1rIrdopcoApgcalPI3TC4v9ZVNmWv+o1UaGLH5yGGXYtdYN5nlnNgRyJG9WWf5mzGapnrg3yw9v06V2/oFXE5sim5JbRkUJrRsqxr2GsPs9tNuA7AVrCjMc0V/6V9rlRSGsvUFZdB+LYznONjapq+b1SfLZLjEEbWVjrF00UiMkUwjEK2Nygeaz9qtVEGoPciZ5ufyw0K0tBwCDpVTscnB3N5YWzqstx8gWvkAZPGfSRKIx/3oaiOPim4PrNrK1gGpxkkAPfq6fzg4qWpmCo5+4YOYToh+jRTqqX/oQLqqM2F33GczSUEmh1EJAWveddXoQMcaQaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=060pTV76J7lk2Jb6rDTWGNEqLGOng+mmfr+/2fuhMFo=;
 b=DAQ+qNAOvJ0+x3A0LAGeuID0CapCs80QNp5kY7GNPZuzMvE07v7/oER+7MMU6zG0Z0T8+CKtTdG0QM9UZdDCo4d0IPKs+H35UHvmf29m5BLtOuReyV4sRbEgcXlzS7T0PyoGMvYUHXNYm4Vk9Ec9F5f2+wljr6VOtvcF6NEEGMCP0eX5LXbZD4BzEhelWaRDGbEw7c2cK7OLN/4ZV/jMZeHmmuNM8ybZILrCRDSgf1PL28lMbznz6rNVYM3MTBOmR+qKq3RMfIEhHlxxCfsN8Gskx5onRBF0a3PPRWN7IF7SdNFJ88PecHvcNwgRzvzq1MwxJ2TMkQI5V2Ky8+EX2A==
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 11:02:10 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::eb) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 11:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 11:02:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Jul 2023
 04:01:56 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Jul
 2023 04:01:53 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/17] mlxsw: Permit enslavement to netdevices with uppers
Date: Wed, 19 Jul 2023 13:01:15 +0200
Message-ID: <cover.1689763088.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 579411ad-c8e5-4a2c-0986-08db88479926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9Tkwr6eBJF1H1D6c4HEZFibECPMvhgF5bbb0q/FzQPMO1DX6Uo62fMfVKjSoUM8W7JFpjmMBKis4xxtYtBAM1FEq1Er1cHoflXBh2z+3kpSW37DNLbFeFEsqsdiKSo+tm9Mp7tu3hHjk5zUx1yU3PiGa4u8Jnk6WyxvvDb91H+up240wNu1z6kf3ygw4JYp54n4o37tAl+EaDOWuURYq61RiAAyTtPxFloNR6s21KGDBzcECvYyNgr+FYy4tKXXaP9riELH/yZaZUza4K6/phrX9pFIibt3tmAW9UCcuPsWKSMu7pFSJDT4jb2Si1fdR0zHopXee4/+4IOF1j3cYbrpWS6CquducleQO7oqM9n+mb1uMBc3Bru+/gyzcY81ABbw5OnCs9aaB+T2SLaRxYgPaxOTw7HedtjrY6Ilbhs1zf/S7TPtcgFQ82kgIIxHTuPsrWWJHEwWNgy8OFELDjoaeToejABoig0Mjj8RZfDP0jtGQ2Ldvgz067Aoo/eCGjENL5J1GbR4rtoT3iqeg95j3oAGwTOyDoyPunzjmM8XfqF9K0HeIga7ofNnxOLGnLy1gryhA7FHUOY9DU7f/y6BEv71zK0TBnXFFxvnYYhjxXEqSViVga93GHnGYPNnEfpx+CQ8CNI6GzIrtsp1lnPLv6k6iiLYmeGFij9Qm9DvX6cNj5sLNrhndkJzO4ZLgXMRCe34LuaIv7fXBbbYrnc7+7p+xtQ5rUKHyNeK8CRdQ5Hw5d9IHCQY5bdxFl7s
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(40460700003)(40480700001)(2616005)(47076005)(336012)(426003)(16526019)(83380400001)(186003)(36860700001)(66574015)(107886003)(26005)(7636003)(6666004)(54906003)(82740400003)(110136005)(356005)(4326008)(70206006)(70586007)(478600001)(5660300002)(41300700001)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 11:02:09.4332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579411ad-c8e5-4a2c-0986-08db88479926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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

Similarly, detaching a front panel port from a configured topology means
unoffloading of this whole topology -- VLAN uppers, next hops, etc.
Attaching the port back is then not permitted at all. If it were, it would
not result in a working configuration, because much of mlxsw is written to
react to changes in immediate configuration. There is nothing that would go
visit netdevices in the attached-to topology and offload existing routes
and VLAN memberships, for example.

In this patchset, introduce a number of replays to be invoked so that this
sort of post-hoc offload is supported. Then remove the vetoes that
disallowed enslavement of front panel ports to other netdevices with
uppers.

The patchset progresses as follows:

- In patch #1, fix an issue in the bridge driver. To my knowledge, the
  issue could not have resulted in a buggy behavior previously, and thus is
  packaged with this patchset instead of being sent separately to net.

- In patch #2, add a new helper to the switchdev code.

- In patch #3, drop mlxsw selftests that will not be relevant after this
  patchset anymore.

- Patches #4, #5, #6, #7 and #8 prepare the codebase for smoother
  introduction of the rest of the code.

- Patches #9, #10, #11, #12, #13 and #14 replay various aspects of upper
  configuration when a front panel port is introduced into a topology.
  Individual patches take care of bridge and LAG RIF memberships, switchdev
  replay, nexthop and neighbors replay, and MACVLAN offload.

- Patches #15 and #16 introduce RIFs for newly-relevant netdevices when a
  front panel port is enslaved (in which case all uppers are newly
  relevant), or, respectively, deslaved (in which case the newly-relevant
  netdevice is the one being deslaved).

- Up until this point, the introduced scaffolding was not really used,
  because mlxsw still forbids enslavement of mlxsw netdevices to uppers
  with uppers. In patch #17, this condition is finally relaxed.

A sizable selftest suite is available to test all this new code. That will
be sent in a separate patchset.

Petr Machata (17):
  net: bridge: br_switchdev: Tolerate -EOPNOTSUPP when replaying MDB
  net: switchdev: Add a helper to replay objects on a bridge port
  selftests: mlxsw: rtnetlink: Drop obsolete tests
  mlxsw: spectrum_router: Allow address handlers to run on bridge ports
  mlxsw: spectrum_router: Extract a helper to schedule neighbour work
  mlxsw: spectrum: Split a helper out of mlxsw_sp_netdevice_event()
  mlxsw: spectrum: Allow event handlers to check unowned bridges
  mlxsw: spectrum: Add a replay_deslavement argument to event handlers
  mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
  mlxsw: spectrum_switchdev: Replay switchdev objects on port join
  mlxsw: spectrum_router: Join RIFs of LAG upper VLANs
  mlxsw: spectrum_router: Offload ethernet nexthops when RIF is made
  mlxsw: spectrum_router: Replay MACVLANs when RIF is made
  mlxsw: spectrum_router: Replay neighbours when RIF is made
  mlxsw: spectrum_router: Replay IP NETDEV_UP on device enslavement
  mlxsw: spectrum_router: Replay IP NETDEV_UP on device deslavement
  mlxsw: spectrum: Permit enslavement to netdevices with uppers

 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 312 ++++++++++---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 +
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 432 ++++++++++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   7 +
 .../mellanox/mlxsw/spectrum_switchdev.c       | 138 +++++-
 include/net/switchdev.h                       |   6 +
 net/bridge/br.c                               |   8 +
 net/bridge/br_private.h                       |  16 +
 net/bridge/br_switchdev.c                     |  15 +-
 net/switchdev/switchdev.c                     |  25 +
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  |  31 --
 11 files changed, 862 insertions(+), 130 deletions(-)

-- 
2.40.1


