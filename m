Return-Path: <netdev+bounces-18221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D0755E05
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A66B1C20970
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74625946E;
	Mon, 17 Jul 2023 08:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F845946B
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:13:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B710E9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kcav2V2mPb4hpgkdYoFwHbh/JQNwTJ2e07vZdLIVo5CTrYCDmoorxpSuHqbRBLrWq5FM5IZqcT7p5oQtebOOkVZnIdg5RiJ6XPpX9eaFH+6G1YE4Z0OmvUmxXDChG63vuSHueG8Ssq2bQl7Ae4WVG3HcdJPBGgxWmJFhK1EelPDvCinO8dDuHkItqi9/aVYIPh4Un4YBpIz4dKV6Br42CDgvNfUIy8qxh77YqEczTgEmtgB4ou/Bul0ZjxkblQXV41ryy6ginSl3WCUDCisgfZ3eBE2BCxIDVPYuPYwl8bFLZ9wGnSGHZrc5AuFiRJuYiL0DmxFDeeja+wiBZfuvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+iQ0s1rK5KgPLPkmCFHegwglNel4iwcAWbFfrXdWlw=;
 b=ghm/Doxj9rvaswHuL7OY8WmqzRywz2xyPTvU8TZYtsOxxxsF/5BdjczyTvdcvd5yR9KQoDYtYDMdwClux2NodJKzM+jdAl4zLzTZX/d/jthD1BPhxfTxX+1zqeXsC/aCCYvT7SjivMY6uoIbL2XXKftUkoPY2KJL72lvfNypq/f+fx4IDPq0vfN7nQn0InuR/txeAvHyjzGyzVq8gNQcn2wJEZToluekeumanx//F5nnTuJV8iUas1v8UjvZUtPwkp1tK3LYgvVPm/0QO9qQImSagJGKpLsLvYL3MAEILhbaRZHFdCupDjxzAQTTRmIxAf6qcHcsEc38B2Hk8Ezu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+iQ0s1rK5KgPLPkmCFHegwglNel4iwcAWbFfrXdWlw=;
 b=l54AGazwqtVLQQ0I0j/OIn7a/fCld4ZxOQ9yK0wvVA2yorpHzRdMD84plIZswJQTzqIchc2OFaxQA+gEsxOV6Hpw7d0zTblqO31CU3oTwYvi+V0z8jZfZ7dYysXMD8NcV7WbvjQApGnZ/MMwAXENjknR3lzEBN0oowxb59lFt2qx5aSgYdgW9bzJYFOUxWAOpV7EOfmm2JMn2+dNcLJGwKAyz7od7blF6LokWF2mEJLXQX4cJKWOOjSVkY3CC3d8JK4MLHGgTKx5UlebW7Ce8lbGVhS8IAwYrApbEB7LzHth5+bqhXXB0LjzQKczDGL3MBm8uKJUdiHZeGOdePwhsQ==
Received: from BN8PR16CA0013.namprd16.prod.outlook.com (2603:10b6:408:4c::26)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 08:13:11 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::5c) by BN8PR16CA0013.outlook.office365.com
 (2603:10b6:408:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 08:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 08:13:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 01:12:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 17 Jul 2023 01:12:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 0/4] Add backup nexthop ID support
Date: Mon, 17 Jul 2023 11:12:25 +0300
Message-ID: <20230717081229.81917-1-idosch@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d0af08-cf85-4270-0f99-08db869da983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FzeE6GTQIMAyVLCizcPSkR8d3+d1l2WpUCEr9D9xXOK2KYAlbv6rbfc5T039XBICRsuY07e6cdij1G6Ccs30KZYLrZ/yzYDxctm2P1NvRwh8nYN+bOlRaZrzaKvkc5MSGnsrwu183zmpaZJSAV2DvW94H28D91wnBYfObqAh0uPamPbLZdyAPCoKbos9OS3YqxkzT+OK/qV+LsblTRC9+yQhtPfxLZ44as4s1QvuQskeJU6ipp4y4n/OkJX29Rauf0AJvnhHwk8LaLCNJem9JGPkpMpPyBEKHhSpzTy6/kRoInYJTv3kGDEaIE4kP4B7MnximHUviSVt033gUnGrOki51aT8MfC6LjJCDuiVolSTjSBT/1KYtuCK2V5DuIZUM78K520a31JsOcuyKuNwGVzcJz7DgLbobQWrKMP42Kw1bj1OhAXumYsVcas1W/y8/7ZQSVUaW/FUn/XQvCtegpLIigu2zbQGFqWp30qnfXaxvKcV6HP432DNHyDjHKxjJN4TVf+XIlXl3G4RpPIC3x/OJ37eS/cwVu8iYTZvvek4uqONf5Dsk1z108Zj8j2/2r0h6kZT04TrcpiH726fezwNSUjbsMVLCkHZcTCDSyZQnoWRUwIIOurzFH0ZroUuLxCeWV1rv3jQ9nJ5lrusWOR/pxl+pIcchkK+6G//RjWV8u/C/Eq8UuLGr+GIX58ujAO6Mt8u3IzzvDkl8AuirkoQnbuwobMxJhqTjE6ZweuU5ZJ2bUZ4aN2xNGAJKmN+OTJEkIhb95TTiMYFs42MuzNnVmcBPOO5CPF//aIG+VAZ5J67G5TAiylSTGx7YOpr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(2906002)(7636003)(356005)(82740400003)(426003)(83380400001)(336012)(47076005)(186003)(16526019)(2616005)(26005)(1076003)(107886003)(40480700001)(36860700001)(5660300002)(86362001)(40460700003)(8676002)(966005)(8936002)(36756003)(478600001)(110136005)(54906003)(6666004)(41300700001)(316002)(4326008)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:13:11.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d0af08-cf85-4270-0f99-08db869da983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

Changelog
=========

Since RFC [4]:

* Added Nik's tags.

[1] https://datatracker.ietf.org/doc/html/rfc7432#section-7.1
[2] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
[3] https://github.com/idosch/iproute2/tree/submit/backup_nhid_v1
[4] https://lore.kernel.org/netdev/20230713070925.3955850-1-idosch@nvidia.com/

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


