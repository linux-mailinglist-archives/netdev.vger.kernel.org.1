Return-Path: <netdev+bounces-25352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC24773C68
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36830281773
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441E14F6B;
	Tue,  8 Aug 2023 15:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D83134D7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:51:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD956892C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD8my+zvCj/OauJV8nrRhex5GjBseA9XWJ2QzJZq3o6HmMTa8zVELLJvOExYloLR438p5+fM6M6Yw401ky6rltBvpJlLleXpuMTR5hZof4BYM9wgLkVI6Qx/Srjc37uwG58XoZjc4gHAqhhhiaJ9Epcnh6E2KBLbn7A73CBWxWez711K1tylbuaAmL9L74MBMC2s5fmoxG/Y3Kj9z8Aaw5inJgcOzVLYn7o5MkLl7mEfvfLFN3d5YhkLXYNWm6WRvaoXZnHlAZdr1HIpG3Rgq1CExsjYRBNP3Lq40bfMMPvgE+ffvoTbOLRXPTau2gQ2mQM2NddD+6bF9TGLSii4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvpZabAlat8o9oKmb1K8TCKCgAyhx7GaFzfXRUDn+uo=;
 b=G7Yi9FoRWKZWEB6Iey+CrhPw8iCYND1RxfKI3Gkh+UKO8iYncxn+8kOwWBBBTJoYw5v6Bu9vg0RmSR/2Chy2+EvXb8aIwX4cOJFqtXFvx/3m0FFbBOBBjoidCJlBjRB6YUnTNOsK3p+E7UcVFE+BOYU6gGRHWa545+R+bMta07jJfp0FUWsDgAjwAlRlxAIzqKqbU1dMB+YqzELkOH5g9pb84ESniyRRYVIrpcqBD8Th1m78UgJiNhygY/VlvOMPgV3cJsND4Xe8+uqUigEM79x/yjBj51+Dvz7niGuHhZaq9bcMusW2e5IRFAu99zojiEF/AT9Ix9tNIyr2rKsJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvpZabAlat8o9oKmb1K8TCKCgAyhx7GaFzfXRUDn+uo=;
 b=YL5GHPFivs95NfODXmBxJebgcALPml9ibl6mzfZX5iadeP9vFj9G2AuytsqJyzxC69tCTY1SwXXnu691uUx2lQRdfB54N1uCgi8I7CeEDMYhLC8qd5xdpC6xE9QUpsuKy0N2Ftim1pW0x+28BhHmQLTb7kbK58A40EsrRCKvoKPwR2S6BzcHX9a6gPzP0y/ld6WhNKQlqrIF2cGd4avTrBcRL0n/6EFy1swQ/u30YBdVgJh+ZstLTvHL1cZDsZXUQV8iVPGSH2HopG6NmM4ukULXcS+ANf6+2HA50L6ogUu9POiloIl6sMX14nFWa1XBcigMCsF3p5fsj9bn2EJofA==
Received: from DM6PR04CA0009.namprd04.prod.outlook.com (2603:10b6:5:334::14)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 07:53:21 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:5:334:cafe::f1) by DM6PR04CA0009.outlook.office365.com
 (2603:10b6:5:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 07:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Tue, 8 Aug 2023 07:53:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 00:53:04 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 00:53:01 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 1/3] nexthop: Fix infinite nexthop dump when using maximum nexthop ID
Date: Tue, 8 Aug 2023 10:52:31 +0300
Message-ID: <20230808075233.3337922-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808075233.3337922-1-idosch@nvidia.com>
References: <20230808075233.3337922-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: e9644a85-59c9-4bf9-f6c0-08db97e48bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jOjhGL3oR9zVsvwMsVeVC007FiVwU9mxfhxbGKWoUMYxa9lvuKB/Xcv/pVM0VUa/DNBUWqIeqxwIPYBkmUekS/QknFS39icPKOIFsSk+IltwKS7YCc/f0EM3Cli91iEoFNnXAHAyO2amWsK3/dwrWRy4GrljnP8aWHAkvFhLBAaj8Q9uHh2HFxlbkd8Tcy9Zc5AGASgvsEKLeGFjCskIJZKwZOy0RCEb8OtO+6l0nKykFdVt9Kjz9QfUJJ8CotuuMDHarpzVporU/uz5kTOVUv/AbxaALTtiTUYjPlVrh0z01H7yWi5KytZhpgVxXRczslyXfId8j+M+cGPK6TQmxAsPLIkfsd6aoZ6MuQwcyRozEbswtWGc+/LV5AF0kyqwP7wbq4fM+mlYWUNtxtVu1dXqTCmNCxQTGaU8XcVt7naX+QV+pwXyD9tNAhXYNgjPPzt2eAEmRAjkZTKv92tyYIZoe4mguT3outmd/k40ul4Azu8EAK2xBnnyo3bONslgVj0HHh884TM7w+uigDBIH0sO0hUegyQ1WoLSsj1DGsGyKHM8Wda+voIaqwnn/M2GiaXhGljO6Zj2wnbvDX0sjIer98dnAHKZ9ZLGpld3110CyGVUHG1lXzRHScr+kvHE9Ax8k6pNa5qtkajPZrK+niNWnHBPSSA3brkP9oakXhnNiidsPQ4oSk4B+gwPbyWqT0Qvu0aL9bzhZUO+KvnUmMsCgAuWmyCas1tN261KWNm1nsqNqG168L+GKZKLloAqbJD3N5hD/+XtagJ/k3M5exj5u8PcHWfVGiJkB7H/VEpc7vZhTOW9nKUOYeZ7gR8ebiNpRpH4p3W4EJc2By/x3lwaYoIBESH+EHBq9F9XLFE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400008)(90011799007)(451199021)(90021799007)(1800799003)(186006)(46966006)(40470700004)(36840700001)(86362001)(7636003)(107886003)(40480700001)(41300700001)(16526019)(336012)(478600001)(40460700003)(1076003)(8936002)(8676002)(26005)(6666004)(426003)(2616005)(5660300002)(47076005)(36756003)(2906002)(83380400001)(54906003)(36860700001)(316002)(356005)(70586007)(70206006)(6916009)(966005)(4326008)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:53:25.5035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9644a85-59c9-4bf9-f6c0-08db97e48bc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A netlink dump callback can return a positive number to signal that more
information needs to be dumped or zero to signal that the dump is
complete. In the second case, the core netlink code will append the
NLMSG_DONE message to the skb in order to indicate to user space that
the dump is complete.

The nexthop dump callback always returns a positive number if nexthops
were filled in the provided skb, even if the dump is complete. This
means that a dump will span at least two recvmsg() calls as long as
nexthops are present. In the last recvmsg() call the dump callback will
not fill in any nexthops because the previous call indicated that the
dump should restart from the last dumped nexthop ID plus one.

 # ip nexthop add id 1 blackhole
 # strace -e sendto,recvmsg -s 5 ip nexthop
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394315, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 36
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 1], {nla_len=4, nla_type=NHA_BLACKHOLE}]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 36
 id 1 blackhole
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394315, nlmsg_pid=343}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
 +++ exited with 0 +++

This behavior is both inefficient and buggy. If the last nexthop to be
dumped had the maximum ID of 0xffffffff, then the dump will restart from
0 (0xffffffff + 1) and never end:

 # ip nexthop add id $((2**32-1)) blackhole
 # ip nexthop
 id 4294967295 blackhole
 id 4294967295 blackhole
 [...]

Fix by adjusting the dump callback to return zero when the dump is
complete. After the fix only one recvmsg() call is made and the
NLMSG_DONE message is appended to the RTM_NEWNEXTHOP response:

 # ip nexthop add id $((2**32-1)) blackhole
 # strace -e sendto,recvmsg -s 5 ip nexthop
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOP, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691394080, nlmsg_pid=0}, {nh_family=AF_UNSPEC, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 56
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=36, nlmsg_type=RTM_NEWNEXTHOP, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, {nh_family=AF_INET, nh_scope=RT_SCOPE_UNIVERSE, nh_protocol=RTPROT_UNSPEC, nh_flags=0}, [[{nla_len=8, nla_type=NHA_ID}, 4294967295], {nla_len=4, nla_type=NHA_BLACKHOLE}]], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691394080, nlmsg_pid=342}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 56
 id 4294967295 blackhole
 +++ exited with 0 +++

Note that if the NLMSG_DONE message cannot be appended because of size
limitations, then another recvmsg() will be needed, but the core netlink
code will not invoke the dump callback and simply reply with a
NLMSG_DONE message since it knows that the callback previously returned
zero.

Add a test that fails before the fix:

 # ./fib_nexthops.sh -t basic
 [...]
 TEST: Maximum nexthop ID dump                                       [FAIL]
 [...]

And passes after it:

 # ./fib_nexthops.sh -t basic
 [...]
 TEST: Maximum nexthop ID dump                                       [ OK ]
 [...]

Fixes: ab84be7e54fc ("net: Initial nexthop code")
Reported-by: Petr Machata <petrm@nvidia.com>
Closes: https://lore.kernel.org/netdev/87sf91enuf.fsf@nvidia.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c                          | 6 +-----
 tools/testing/selftests/net/fib_nexthops.sh | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f95142e56da0..179e50d8fe07 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3221,13 +3221,9 @@ static int rtm_dump_nexthop(struct sk_buff *skb, struct netlink_callback *cb)
 				     &rtm_dump_nexthop_cb, &filter);
 	if (err < 0) {
 		if (likely(skb->len))
-			goto out;
-		goto out_err;
+			err = skb->len;
 	}
 
-out:
-	err = skb->len;
-out_err:
 	cb->seq = net->nexthop.seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	return err;
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 0f5e88c8f4ff..10aa059b9f06 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -1981,6 +1981,11 @@ basic()
 
 	run_cmd "$IP link set dev lo up"
 
+	# Dump should not loop endlessly when maximum nexthop ID is configured.
+	run_cmd "$IP nexthop add id $((2**32-1)) blackhole"
+	run_cmd "timeout 5 $IP nexthop"
+	log_test $? 0 "Maximum nexthop ID dump"
+
 	#
 	# groups
 	#
-- 
2.40.1


