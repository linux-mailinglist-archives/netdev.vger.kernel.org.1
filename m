Return-Path: <netdev+bounces-17440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A043751965
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624DB281BF4
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24629569D;
	Thu, 13 Jul 2023 07:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17704366
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:10:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53709119
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6kIaESIlHpNbu/xkyxJ0MjukXgb//0XtgpbL3h9KO0GUGEJE+hNN4TBHaHY+BwqJnlbbPgrW+l1yIqe9v3jKppmZyxHjWll5P3wYZ34A6sZgZ+Xz3cfIWvGoBOlZYeInHt5iPsSKQiNAbfjiodcPdV9bONk58gvkzxSMEzecjvG+r4GCZKcw+nNhWy8G/dZF2ZGQo7Y0V0oQrODq5ktkLmLZn4gVI1bH4TDuokRFri2b1dRkAivaj28HFZrvlgMDtg0WJhszmVXVUMCQa1ncZ+DuNid6boFGCDq7wQKkfzXy2MfBRJ9MSHY4t0xIcyb6oD7tvTeBDG6hwyM4eMB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhnOvr4tIltaRv9D/Dtp3wMF3c4zFuy5h5no/eP0Owo=;
 b=OczuUMVsWwFxa2f4ySy5zzLi9rgjXB1Aqr4+t71zLpPy7y9Uzg0jLaZOLgKopBpgHI5EjQB/NaDTpwZzMujpF9xofQAdiPCWKHBppEpeKGypPBAxxxT/qm1jpUkR9ZmFr6V8zMsr+kGeopquQYkSgWMm4TH5fw0SVwc8DaZZoGbcL548N2uz0zCr0m3DD88VINend1om0o9sl9kdpB/q6nyzyFe6/DiltP4KUvuvmnwaWuaaqYlOBK4cg5TNCz12Vn1raa31+c53ulyLiunGBO9tXsjj/xBVT7uys149EdMhY9N6IVOtExP+UukRauqc9xlwIEG+HBw3uoSwxIGxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhnOvr4tIltaRv9D/Dtp3wMF3c4zFuy5h5no/eP0Owo=;
 b=jnzsF4BqbVr1PuL9TKVN+GUeDZzujv3nx0ztUiIyJyIBb+PI7JVGOOfUkLbn++EP2jZyIuVL6j4BanAYtbNhgRiVFV+Zfsj0wJcOCAsXo/uTXacWZoREeZnKGLGYTfxyOdrYiG3r+W0jLkCzFz3ZC4Jk6oqjNXWMqjkouMtA/PMeAQ5mTrRiE5POTCBJBTRYBZhxDWRkOrdbQM5fb6lMP/QagsIq7q/RmcbCcbx/BTxZ/pYyoiunT9BOBu7/xSLgmk19qDwzZS+i4e+Wqj+eP9TmL23SdYEQTIPklB0kNjcd7/Y97UCCyOMpvgtONPZCyPAQSQ9uEqYahzglSNeZ3A==
Received: from SJ0PR13CA0100.namprd13.prod.outlook.com (2603:10b6:a03:2c5::15)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:10:22 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c5:cafe::a9) by SJ0PR13CA0100.outlook.office365.com
 (2603:10b6:a03:2c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 07:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Thu, 13 Jul 2023 07:10:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 00:10:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 13 Jul 2023 00:10:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [RFC PATCH net-next 0/4] Add backup nexthop ID support
Date: Thu, 13 Jul 2023 10:09:21 +0300
Message-ID: <20230713070925.3955850-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|BN9PR12MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 895dfac4-8ddb-4bbc-fff3-08db837038cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4FnzueCJb6Zkc4DQK3OLXrh3PFCHOJaISxi5fQNV3efXZBgE7XPU89g5Sze2rAoTanHvq0iWa/GOCa1Qw6ljWkNRo4SW2RbzRtePk1+f+g2yW+/ZcAwijjNd7cvsn5Q2H6j10eA4arjTmgCtwNSeJb942nYOG2+QsZr8R7yGqZupcUn395ARrosZRGdm5atdt9c8kGMAU7T+jm42khP9Jf8sb07jS/dfPYPBwE0WWe/ZNWtsvuo1cmoY8XDmv652Lnk4d+QGxQESh/x4/y9rOBm9qYueQkJX0bzB3l8JmV0elK0qklk2BRub5uomyuWuCENeU9dziqTyZcUfJjxwnEzB5lQ2viCdrMDQg9PcgjwAKiLqwvOTOCzmdD2jgCKPXT+qFl2faD6mf9gGEre2azmfJM6mEVLHrRAcC7kXa7OiyLrvhkF5Zsl5NTO6u13/SiTHs84b+Pw4/bMVe/oUkyIiDLfzALkDq+zeg7bSkQoyUFUsw/hdZrZ30iwyoqhD0iqvrGxd980jQE0Mx9nEsyfXfg1McAZ+XfFn8PROEFuF5OOk7N+DG0d6lpECVzlimUbKmNj/nUpx8vldve97LYsdAFILXztZJogcuDs9jysif5oZdH59j5kpVeq9FoK5b6VkYAEqY6xy1rbM1pYSIvHqUUR5x3UU92ZDs+4bgbJiow9Z1m+yoxxMvZ+MbHXqmCnRes+qgsXbfoxchYmGt9Bn5f40946wER5iVPFQXNkyxdU6UfuFfQDV97yMlaDUFFl+2dv+guvTTZcxjx0Tt74PBs2xjdVXtMULQzIeY0t0JN1onmCKRXRtFWasMlxo
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(82310400005)(110136005)(7636003)(356005)(966005)(336012)(82740400003)(47076005)(83380400001)(2616005)(107886003)(186003)(1076003)(26005)(40480700001)(16526019)(36860700001)(86362001)(5660300002)(426003)(40460700003)(8676002)(8936002)(36756003)(41300700001)(54906003)(6666004)(478600001)(70206006)(70586007)(4326008)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:10:21.4382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895dfac4-8ddb-4bbc-fff3-08db837038cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tl;dr
=====

This patchset adds a new bridge port attribute specifying the nexthop
object ID to attach to a redirected skb as tunnel metadata. The ID is
used by the VXLAN driver to choose the target VTEP for the skb. This is
useful for EVPN multi-homing, where we want to redirect local
(intra-rack) traffic upon carrier loss through one of the other VTEPs
(ES peers) connected to the target host.

Background
==========

In a typical EVPN multi-homing setup each host is multi-homed using a
set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
switches in a rack. These switches act as VTEPs and are not directly
connected (as opposed to MLAG), but can communicate with each other (as
well as with VTEPs in remote racks) via spine switches over L3.

The control plane uses Type 1 routes [1] to create a mapping between an
ES and VTEPs where the ES has active links. In addition, the control
plane uses Type 2 routes [2] to create a mapping between {MAC, VLAN} and
an ES.

These tables are then used by the control plane to instruct VTEPs how to
reach remote hosts. For example, assuming {MAC X, VLAN Y} is accessible
via ES1 and this ES has active links to VTEP1 and VTEP2. The control
plane will program the following entries to a remote VTEP:

 # ip nexthop add id 1 via $VTEP1_IP fdb
 # ip nexthop add id 2 via $VTEP2_IP fdb
 # ip nexthop add id 10 group 1/2 fdb
 # bridge fdb add $MAC_X dev vx0 master extern_learn vlan $VLAN_Y
 # bridge fdb add $MAC_Y dev vx0 self extern_learn nhid 10 src_vni $VNI_Y

Remote traffic towards the host will be load balanced between VTEP1 and
VTEP2. If the control plane notices a carrier loss on the ES1 link
connected to VTEP1, it will issue a Type 1 route withdraw, prompting
remote VTEPs to remove the effected nexthop from the group:

 # ip nexthop replace id 10 group 2 fdb

Motivation
==========

While remote traffic can be redirected to a VTEP with an active ES link
by withdrawing a Type 1 route, the same is not true for local traffic. A
host that is multi-homed to VTEP1 and VTEP2 via another ES (e.g., ES2)
will send its traffic to {MAC X, VLAN Y} via one of these two switches,
according to its LAG hash algorithm which is not under our control. If
the traffic arrives at VTEP1 - which no longer has an active ES1 link -
it will be dropped due to the carrier loss.

In MLAG setups, the above problem is solved by redirecting the traffic
through the peer link upon carrier loss. This is achieved by defining
the peer link as the backup port of the host facing bond. For example:

 # bridge link set dev bond0 backup_port bond_peer

Unlike MLAG, there is no peer link between the leaf switches in EVPN.
Instead, upon carrier loss, local traffic should be redirected through
one of the active ES peers. This can be achieved by defining the VXLAN
port as the backup port of the host facing bonds. For example:

 # bridge link set dev es1_bond backup_port vx0

However, the VXLAN driver is not programmed with FDB entries for locally
attached hosts and therefore does not know to which VTEP to redirect the
traffic to. This will result in the traffic being replicated to all the
VTEPs (potentially hundreds) in the network and each VTEP dropping the
traffic, except for the active ES peer.

Avoiding the flooding by programming local FDB entries in the VXLAN
driver is not a viable solution as it requires to significantly increase
the number of programmed FDB entries.

Implementation
==============

The proposed solution is to create an FDB nexthop group for each ES with
the IP addresses of the active ES peers and set this ID as the backup
nexthop ID (new bridge port attribute) of the ES link. For example, on
VTEP1:

 # ip nexthop add id 1 via $VTEP2_IP fdb
 # ip nexthop add id 10 group 1 fdb
 # bridge link set dev es1_bond backup_nhid 10
 # bridge link set dev es1_bond backup_port vx0

When the ES link loses its carrier, traffic will be redirected to the
VXLAN port, but instead of only attaching the tunnel ID (i.e., VNI) as
tunnel metadata to the skb, the backup nexthop ID will be attached as
well. The VXLAN driver will then use this information to forward the skb
via the nexthop object associated with the ID, as if the skb hit an FDB
entry associated with this ID.

Testing
=======

A test for both the existing backup port attribute as well as the new
backup nexthop ID attribute is added in patch #4.

Patchset overview
=================

Patch #1 extends the tunnel key structure with the new nexthop ID field.

Patch #2 uses the new field in the VXLAN driver to forward packets via
the specified nexthop ID.

Patch #3 adds the new backup nexthop ID bridge port attribute and
adjusts the bridge driver to attach the ID as tunnel metadata upon
redirection.

Patch #4 adds a selftest.

iproute2 patches can be found here [3].

[1] https://datatracker.ietf.org/doc/html/rfc7432#section-7.1
[2] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
[3] https://github.com/idosch/iproute2/tree/submit/backup_nhid_v1

Ido Schimmel (4):
  ip_tunnels: Add nexthop ID field to ip_tunnel_key
  vxlan: Add support for nexthop ID metadata
  bridge: Add backup nexthop ID support
  selftests: net: Add bridge backup port and backup nexthop ID test

 drivers/net/vxlan/vxlan_core.c                |  44 +
 include/net/ip_tunnels.h                      |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 net/bridge/br_forward.c                       |   1 +
 net/bridge/br_netlink.c                       |  12 +
 net/bridge/br_private.h                       |   3 +
 net/bridge/br_vlan_tunnel.c                   |  15 +
 net/core/rtnetlink.c                          |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/test_bridge_backup_port.sh  | 759 ++++++++++++++++++
 10 files changed, 838 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/test_bridge_backup_port.sh

-- 
2.40.1


