Return-Path: <netdev+bounces-25357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94919773C80
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4827A280D80
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4E1CA09;
	Tue,  8 Aug 2023 15:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7613AD7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:51:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91246B2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwRN6QUPeyKuOI4Q3Cbmw8aA5rD/M9OyXP/4xgOWm52ELo3Wh1JE3ZffeVK5j9NoUalX2ydgLalfDrid5StmuFuMI7nvL9fOOBcXhrXi5gqIiUgkyw92NzlfYD+GJREHSdeX/ePOXaBeY0thsv7aVodHSfED2yU4pWWIt2gIR4aEOD46dR/3tFi+1IqmBGTdQKJlF8t5s3/ZlExhPsZUSBDWWXMKNkykZ+UFofkfAX3JgJS9TRTmO53Bt4JyhyC/9Roji/a08j54YB7KMXWOtw5spGMbNaUEhBvM0hH2yIvSZbXnv7t7ieaGsj5OpHRVRiyNTgTAe333NgVukLl3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsMvnmW9BZ/h6TD5kZziA+Eo14tOrc0UpEhC18OAmOo=;
 b=H7xD9SNqsz7KSsgMqmGwO0WeaOjjFsSJffe1oivQA12Ec7KYTsQsH44YRZbA5maEHuKkxEo5LCBlwNqLtSv+NMzHF27gPDanN+8cf4RQLqmw7oUoMrtAkhtFMdyg2SqOCa7BDbazyTmpRyfFhbnmLEfF4cIlKxrVOl/8AKSbk230LNcpHifwLuhD7+Z46CKsp6MmASBSB/Q2DeC1IwNb3lYsUG89VXlMR3qFiq4KRYVk2USQhxIMUNaYHZtQYb2HHb125ZT85JUicB/qec5ebUd7SS/gGNAs1v0dLRVw3nB5yBKFbLpSeqBJJFXQJsG978axepuCqIfOktOgU82HDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsMvnmW9BZ/h6TD5kZziA+Eo14tOrc0UpEhC18OAmOo=;
 b=qM1//o80YmPga5eE5ysl1UVAM9Pxj42K789+06bOY0BiiYrUQQaCYtsAyKMJyktxFy213KMxre/WjSBghvg1rpyMylkt8Xi+YaOuo81G6yjUDb43pWRVbDXXYWG0rXdoVpaPTmtcc0GiCJy+21MBznsODFTbAZF2jtC28yH21v3pDfm2ihMVOp2c9bY8lcmzPQmpZAS1KT3C/3D7W2WzL3et4v41iC9NNZXn2Vw5QehJU4e79bKMkE/I0o0KOQD0Tg+1kp5ahloqoCsOrX3dnMqRMGVLFU85oLSLjv31l0FVd3sa26VqwgJGUkXxWW1tbefk+kNy0M5uKmL1cNxEbQ==
Received: from SA1PR05CA0016.namprd05.prod.outlook.com (2603:10b6:806:2d2::25)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 07:53:16 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::5d) by SA1PR05CA0016.outlook.office365.com
 (2603:10b6:806:2d2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 07:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 07:53:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 00:53:10 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 00:53:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 3/3] nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID
Date: Tue, 8 Aug 2023 10:52:33 +0300
Message-ID: <20230808075233.3337922-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eed962-3046-437c-87ba-08db97e48864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wfp5FoQGlUX/rvVQU3hyY9PeD2DCWisC2X0pEzOXe9sRfGxb0o80s0O3HNlFIFQJXsd0z39BiTCh7dbo+YKlAMxOp9j30UoE73PF3kjtI+yoqrCLtnWHb5/ovHxRKctoXzZuIC0Y62yE6Q7p5PUhAtCY8FDvaLtpLy3iZ6hIqVTHprqw2gei5CCIoWITEir3FJer6ezlF+1qDqpOgpgFs2udwdRYCiOJfnJBSfvzvRbJCXoK9VSKw4Oo1kUptmb1lwg0xZDACsNmJ5N3NpLN9nxwoL+9A3fL8EdHFy7V2cx2nbnAfBnBUamgB+cEMuJmhjHVPY3RrR6thvXihY99EhJNBT9s+TQfFoEu7CfQr0H/Z+YnOkoIaJMcMhWITmZpYB4OWKNMFw4II52DiHdnvr0VUc/lM/9kThG//rIghOiRyDdEn8IXXJzefKjvzzxiR9FiMZ8jb2859Jy+I4nUKaqj5uQBDybGAtrliAHeW/4GFxYKmSRHv5MXFBNKF6mrCgY7RaRwK5gIs8OO22HnzB2e5quvHRzRvYk2PKZJZhMoZpu8iwa40mwgcFDZdS5VC5qzg8E1/I65CvZppljqdnwtD+derbU3HwWpyesV8sciKBBk5RrP3DBNPzOgNVmpMEfw3RWjfSZKXtkETCoXGyTzR4xV2smA0+b5VTG5H7Qv6PcprK2VHj7wdcA8mP9Sb0g/qBiRbRRdwDYDpZTB3uDjUk/Gmo/9IqYcPhfMXCOtC0HePTuaaVq/ipy9H7hoIFlqojtJgb5BN822DJrohH9Jz8SthV5DjOERCICVQ9VgdVJ55J8DOIpCpJ0dzWXf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(90011799007)(451199021)(82310400008)(90021799007)(1800799003)(186006)(46966006)(40470700004)(36840700001)(8676002)(8936002)(5660300002)(6916009)(4326008)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6666004)(2616005)(26005)(1076003)(107886003)(36756003)(16526019)(336012)(70586007)(70206006)(7636003)(356005)(478600001)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:53:19.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eed962-3046-437c-87ba-08db97e48864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A netlink dump callback can return a positive number to signal that more
information needs to be dumped or zero to signal that the dump is
complete. In the second case, the core netlink code will append the
NLMSG_DONE message to the skb in order to indicate to user space that
the dump is complete.

The nexthop bucket dump callback always returns a positive number if
nexthop buckets were filled in the provided skb, even if the dump is
complete. This means that a dump will span at least two recvmsg() calls
as long as nexthop buckets are present. In the last recvmsg() call the
dump callback will not fill in any nexthop buckets because the previous
call indicated that the dump should restart from the last dumped nexthop
ID plus one.

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id 10 group 1 type resilient buckets 2
 # strace -e sendto,recvmsg -s 5 ip nexthop bucket
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOPBUCKET, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691396980, nlmsg_pid=0}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 128
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 128
 id 10 index 0 idle_time 6.66 nhid 1
 id 10 index 1 idle_time 6.66 nhid 1
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 20
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396980, nlmsg_pid=347}, 0], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
 +++ exited with 0 +++

This behavior is both inefficient and buggy. If the last nexthop to be
dumped had the maximum ID of 0xffffffff, then the dump will restart from
0 (0xffffffff + 1) and never end:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id $((2**32-1)) group 1 type resilient buckets 2
 # ip nexthop bucket
 id 4294967295 index 0 idle_time 5.55 nhid 1
 id 4294967295 index 1 idle_time 5.55 nhid 1
 id 4294967295 index 0 idle_time 5.55 nhid 1
 id 4294967295 index 1 idle_time 5.55 nhid 1
 [...]

Fix by adjusting the dump callback to return zero when the dump is
complete. After the fix only one recvmsg() call is made and the
NLMSG_DONE message is appended to the RTM_NEWNEXTHOPBUCKET responses:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id $((2**32-1)) group 1 type resilient buckets 2
 # strace -e sendto,recvmsg -s 5 ip nexthop bucket
 sendto(3, [[{nlmsg_len=24, nlmsg_type=RTM_GETNEXTHOPBUCKET, nlmsg_flags=NLM_F_REQUEST|NLM_F_DUMP, nlmsg_seq=1691396737, nlmsg_pid=0}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], {nlmsg_len=0, nlmsg_type=0 /* NLMSG_??? */, nlmsg_flags=0, nlmsg_seq=0, nlmsg_pid=0}], 152, 0, NULL, 0) = 152
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=NULL, iov_len=0}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_TRUNC}, MSG_PEEK|MSG_TRUNC) = 148
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[{iov_base=[[{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=64, nlmsg_type=RTM_NEWNEXTHOPBUCKET, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, {family=AF_UNSPEC, data="\x00\x00\x00\x00\x00"...}], [{nlmsg_len=20, nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1691396737, nlmsg_pid=350}, 0]], iov_len=32768}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 148
 id 4294967295 index 0 idle_time 6.61 nhid 1
 id 4294967295 index 1 idle_time 6.61 nhid 1
 +++ exited with 0 +++

Note that if the NLMSG_DONE message cannot be appended because of size
limitations, then another recvmsg() will be needed, but the core netlink
code will not invoke the dump callback and simply reply with a
NLMSG_DONE message since it knows that the callback previously returned
zero.

Add a test that fails before the fix:

 # ./fib_nexthops.sh -t basic_res
 [...]
 TEST: Maximum nexthop ID dump                                       [FAIL]
 [...]

And passes after it:

 # ./fib_nexthops.sh -t basic_res
 [...]
 TEST: Maximum nexthop ID dump                                       [ OK ]
 [...]

Fixes: 8a1bbabb034d ("nexthop: Add netlink handlers for bucket dump")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c                          | 6 +-----
 tools/testing/selftests/net/fib_nexthops.sh | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f365a4f63899..be5498f5dd31 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3424,13 +3424,9 @@ static int rtm_dump_nexthop_bucket(struct sk_buff *skb,
 
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
index 10aa059b9f06..df8d90b51867 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -2206,6 +2206,11 @@ basic_res()
 	run_cmd "$IP nexthop bucket list fdb"
 	log_test $? 255 "Dump all nexthop buckets with invalid 'fdb' keyword"
 
+	# Dump should not loop endlessly when maximum nexthop ID is configured.
+	run_cmd "$IP nexthop add id $((2**32-1)) group 1/2 type resilient buckets 4"
+	run_cmd "timeout 5 $IP nexthop bucket"
+	log_test $? 0 "Maximum nexthop ID dump"
+
 	#
 	# resilient nexthop buckets get requests
 	#
-- 
2.40.1


