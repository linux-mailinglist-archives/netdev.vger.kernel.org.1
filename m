Return-Path: <netdev+bounces-18084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8D7549D5
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA501C20A29
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50A07483;
	Sat, 15 Jul 2023 15:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00113732
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 15:37:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E780B30C5
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 08:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEUvE/7WYf6fDhJVzL5sjimfDTrOSBoEW8odhIF1EBri04oOUCrDaH3R/E2eXy50knQbVgZuHPPYTVrBzMCg0Algl1JmyHNVK3KO9mT7SCd75lRnSvhmA2g30l4v8uZF6qxlHaoeISBVXafnhLiHafjcONj6FGkNw4CCA54iKu3MsRXszzfLyV/DhU0pd7HUQPd9eF2vJW14O6J699XSv6NYwJ4eh22thEO8t4xSYsbk56xEr1tl+b0dbiDJCw0Z/9Buki6BYQv/fKG60ijx93RzRs1NLYodRfJKfk42IAr8nlBDLD/3YQ45KtfqALSde35s/k29r/2EOrOZUfNroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v83+93VSvfkDNgm0TmBtwcb8ZBlM5RKgfVvfUaCe9dI=;
 b=JaMNUsu21tysAF/thsCp4PNoPRQNujlvJmyPIJ/lGtkIx6d0/hx0whGKJUvWrfnc6YrLfygb1kqV0oGzVtfIOOwBPgznIo6oAtH/EVMnM7Tb3reGVGciVTZ9UQHUN7M1an8LGiGmZg+MUVnE+QMdL8mVYSy5hQlimxscnU/VAhE7vnibFsxJPzo6ic0uNajT9n8P4OyYH7LfZPaQJdT0t4T2BBA6xp7nT1fHo7jghxF9x3FlK4pmDRt/TPQ/+8cMcdhpi2Uf5A2WwoqbR3gldiTC4acjshw4CxvFZzd5+R2kDQPT4+YV/vdwOy42zzecGSjjD7pjBZT61rQtJ41RwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v83+93VSvfkDNgm0TmBtwcb8ZBlM5RKgfVvfUaCe9dI=;
 b=mRodNkKSgOze8X8azmFSCHsoc9js0OJ2aQGZXyAaTQqQZnY6Jap2/sm7oA6WHF9TEhTX066lbXdIOcqVdE+vo4ZTqR4/5kZC7NdQk21EONVu0QitI/idETrAJtPXWrzGWzs8/hzqhcdkPIbanYTC2/5UOC+YqkuHNFNpzDDIOMgaLz5qn1n9krFZGc3bmWxTFvRrck/xz6tfVXZR79xOl7XFJWrr/5t4YdOdC7CJHJ1Vjm6XQS/O5s8UgkckhQXlv5FhRDRcFTBuzEeY52iAuUF4DwPOiAR3LuJrzf0yc3wM8/HXsSbJjza592b6BEXZEkNcO78WeNcBjYcsmw0B1A==
Received: from DM6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:5:14c::34)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 15:37:26 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::f8) by DM6PR11CA0057.outlook.office365.com
 (2603:10b6:5:14c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28 via Frontend
 Transport; Sat, 15 Jul 2023 15:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.28 via Frontend Transport; Sat, 15 Jul 2023 15:37:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 15 Jul 2023
 08:37:17 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sat, 15 Jul 2023 08:37:13 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <naresh.kamboju@linaro.org>,
	"Ido Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] vrf: Fix lockdep splat in output path
Date: Sat, 15 Jul 2023 18:36:05 +0300
Message-ID: <20230715153605.4068066-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4d1a87-1cb0-40ba-2718-08db85496480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CPWxb0P/LRpKDVmNM6g1nLaDFoujBbKctt5GL5rldyc4vNfpukHeCO8mN0UtwI3vPhFmQ2sqblizR3RAF8ADCUF9quZLLbGjgM25lj6kWZuUEzIIcCgyq5jAiOlRj/m8a0JuWnOzBLxek38ojsjtg2QR8kANNtTAFylF8UCwSZ0jfwKZ4Q6no8mSSGDRcMzPOiA89MZTEuRsejo1/SZ4Nf3Wie3XZCtU4wnQ3COhPFqrTxn17ec9Su8tSGdhgxKseWBYPZF07HbW8VGWwGk8AMkN0MdPcVdBlKqJosBJob6jU459wIbMk/cbYmzVGt+HRGAn60dZi/ArphpRa69yUHmEREYopwVfEm2BYfqTYyNSnYrvXk0PxPz7jsLVWD0ZYCY5DgO+b4SBzabtkUnIVP49sqREAsEVlE+3Eg6HrwMfdGedU/zjcufrvikPssgGrnz9hDuJJLOVjzCNY0HUA19LnYideIe7QA+jR/RF79lqGpZEwYhJztTXkjVfsnjwfDl9i3Fiu6BIt7jI60eQknaUaE0j6WGEO+Gpvjp1jRHY053bucH8R79ZEBasp4pLJjzbHPdtQQhq20LNJN6794YsnBNvB7N4YQDTOQBo8DufX4Mq6DnqoRLneab+bPL0Sj/8Q4SBFOv0CerAwt7dSHeuDsqYYs3RhfI0DpBSZ11q1JP+8y7Hr4XyZxumFlQFLR1M9rgYh20T78SSlhO1d3jWy4t8VDnPr900rkeQ+jXsmjTdEXzpkJgD+sLkKPa72VTMK2LW4ZCd1te54YH+NsZUv9A6uXypdkYalJdiNFA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(2906002)(7636003)(356005)(82740400003)(336012)(83380400001)(47076005)(186003)(426003)(2616005)(36860700001)(107886003)(1076003)(26005)(40480700001)(16526019)(5660300002)(86362001)(40460700003)(8676002)(36756003)(8936002)(478600001)(966005)(54906003)(6666004)(316002)(41300700001)(4326008)(6916009)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 15:37:26.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d1a87-1cb0-40ba-2718-08db85496480
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cited commit converted the neighbour code to use the standard RCU
variant instead of the RCU-bh variant, but the VRF code still uses
rcu_read_lock_bh() / rcu_read_unlock_bh() around the neighbour lookup
code in its IPv4 and IPv6 output paths, resulting in lockdep splats
[1][2]. Can be reproduced using [3].

Fix by switching to rcu_read_lock() / rcu_read_unlock().

[1]
=============================
WARNING: suspicious RCU usage
6.5.0-rc1-custom-g9c099e6dbf98 #403 Not tainted
-----------------------------
include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by ping/183:
 #0: ffff888105ea1d80 (sk_lock-AF_INET){+.+.}-{0:0}, at: raw_sendmsg+0xc6c/0x33c0
 #1: ffffffff85b46820 (rcu_read_lock_bh){....}-{1:2}, at: vrf_output+0x2e3/0x2030

stack backtrace:
CPU: 0 PID: 183 Comm: ping Not tainted 6.5.0-rc1-custom-g9c099e6dbf98 #403
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xc1/0xf0
 lockdep_rcu_suspicious+0x211/0x3b0
 vrf_output+0x1380/0x2030
 ip_push_pending_frames+0x125/0x2a0
 raw_sendmsg+0x200d/0x33c0
 inet_sendmsg+0xa2/0xe0
 __sys_sendto+0x2aa/0x420
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

[2]
=============================
WARNING: suspicious RCU usage
6.5.0-rc1-custom-g9c099e6dbf98 #403 Not tainted
-----------------------------
include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by ping6/182:
 #0: ffff888114b63000 (sk_lock-AF_INET6){+.+.}-{0:0}, at: rawv6_sendmsg+0x1602/0x3e50
 #1: ffffffff85b46820 (rcu_read_lock_bh){....}-{1:2}, at: vrf_output6+0xe9/0x1310

stack backtrace:
CPU: 0 PID: 182 Comm: ping6 Not tainted 6.5.0-rc1-custom-g9c099e6dbf98 #403
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xc1/0xf0
 lockdep_rcu_suspicious+0x211/0x3b0
 vrf_output6+0xd32/0x1310
 ip6_local_out+0xb4/0x1a0
 ip6_send_skb+0xbc/0x340
 ip6_push_pending_frames+0xe5/0x110
 rawv6_sendmsg+0x2e6e/0x3e50
 inet_sendmsg+0xa2/0xe0
 __sys_sendto+0x2aa/0x420
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

[3]
#!/bin/bash

ip link add name vrf-red up numtxqueues 2 type vrf table 10
ip link add name swp1 up master vrf-red type dummy
ip address add 192.0.2.1/24 dev swp1
ip address add 2001:db8:1::1/64 dev swp1
ip neigh add 192.0.2.2 lladdr 00:11:22:33:44:55 nud perm dev swp1
ip neigh add 2001:db8:1::2 lladdr 00:11:22:33:44:55 nud perm dev swp1
ip vrf exec vrf-red ping 192.0.2.2 -c 1 &> /dev/null
ip vrf exec vrf-red ping6 2001:db8:1::2 -c 1 &> /dev/null

Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/netdev/CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Using the "Link" tag instead of "Closes" since there are two reports in
the link, but I can only reproduce the second.

I believe that the rcu_read_lock_bh() / rcu_read_unlock_bh() in
vrf_finish_direct() can be removed since dev_queue_xmit_nit() uses
rcu_read_lock() / rcu_read_unlock(). I will send a patch to net-next
after confirming it.
---
 drivers/net/vrf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bdb3a76a352e..6043e63b42f9 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -664,7 +664,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
@@ -672,10 +672,10 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb, false);
-		rcu_read_unlock_bh();
+		rcu_read_unlock();
 		return ret;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 
 	IP6_INC_STATS(dev_net(dst->dev),
 		      ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
@@ -889,7 +889,7 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 		}
 	}
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 
 	neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	if (!IS_ERR(neigh)) {
@@ -898,11 +898,11 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 		sock_confirm_neigh(skb, neigh);
 		/* if crossing protocols, can not use the cached header */
 		ret = neigh_output(neigh, skb, is_v6gw);
-		rcu_read_unlock_bh();
+		rcu_read_unlock();
 		return ret;
 	}
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 	vrf_tx_error(skb->dev, skb);
 	return -EINVAL;
 }
-- 
2.40.1


