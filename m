Return-Path: <netdev+bounces-40599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E17C7CEE
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104CC282BF9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597E3D017;
	Fri, 13 Oct 2023 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="MQ6lgRHG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BF1C3C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:15:10 +0000 (UTC)
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 22:15:08 PDT
Received: from rn-mailsvcp-mx-lapp02.apple.com (rn-mailsvcp-mx-lapp02.apple.com [17.179.253.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA7B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:15:08 -0700 (PDT)
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by rn-mailsvcp-mx-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S2G00NGF957MY20@rn-mailsvcp-mx-lapp02.rno.apple.com>
 for netdev@vger.kernel.org; Thu, 12 Oct 2023 21:15:08 -0700 (PDT)
X-Proofpoint-GUID: owqJLjsidpSyObSLgQkWvJQTYw5EKLoa
X-Proofpoint-ORIG-GUID: owqJLjsidpSyObSLgQkWvJQTYw5EKLoa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.980
 definitions=2023-10-13_01:2023-10-12,2023-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : mime-version : content-transfer-encoding;
 s=20180706; bh=6GZIe1d2aL92Peh3619UFR+wLbJkMJ7ge5gdwrhNG6U=;
 b=MQ6lgRHGWLW6xBPvQ0rismuAAsBm1yZ6/WWRgB6rdlSvwCYCZahTR83Y5X3/vvtmz4g4
 zUBgnXNNdw/E89x5fbx05Sm28uL+6/1JULgNjsovWPQyUpVuxGW3I33NoKDCESJK2ICX
 4w9k1ysKcDDntVPW54bC1YR1r/kDJj7TD3r4u2XFzY564gwoJHOjaQ1JSxGIcnYtTj7L
 qKlwu9eyCJw6+e+IgP/EsFOjGIqb6izQN9qIebxKy0FFRHn8vuB8fNvkdBmZLqF1lQiP
 7KRl1QsVkXnSLcad0evngKqDNz8yuiPpRohugeFSp2b7KNXWdnl/eZs9tfxwrkaHCxnp 8Q==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S2G00CQL954MCI0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Thu, 12 Oct 2023 21:15:04 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S2G00H0091AZE00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Thu,
 12 Oct 2023 21:15:04 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-Va-E-CD: 5b67512ebc0f3a59e57679205d89800b
X-Va-R-CD: 122cbf043c0eba0f1a82b7401699a05a
X-Va-ID: b85f9733-081b-4044-9c3f-003645df7035
X-Va-CD: 0
X-V-A:
X-V-T-CD: 5c1d590bbb3e9640019563b4ec412a7e
X-V-E-CD: 5b67512ebc0f3a59e57679205d89800b
X-V-R-CD: 122cbf043c0eba0f1a82b7401699a05a
X-V-ID: b969109c-55a4-42d8-adf9-12f2ca442ae3
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.980
 definitions=2023-10-13_01:2023-10-12,2023-10-13 signatures=0
Received: from Christophs-MBP.localdomain.com ([17.11.168.141])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S2G00W4H954DY10@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Thu,
 12 Oct 2023 21:15:04 -0700 (PDT)
From: Christoph Paasch <cpaasch@apple.com>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
 Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] netlink: Correct offload_xstats size
Date: Thu, 12 Oct 2023 21:14:48 -0700
Message-id: <20231013041448.8229-1-cpaasch@apple.com>
X-Mailer: git-send-email 2.32.3 (Apple Git-135)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

rtnl_offload_xstats_get_size_hw_s_info_one() conditionalizes the
size-computation for IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED based on whether
or not the device has offload_xstats enabled.

However, rtnl_offload_xstats_fill_hw_s_info_one() is adding the u8 for
that field uncondtionally.

syzkaller triggered a WARNING in rtnl_stats_get due to this:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 754 at net/core/rtnetlink.c:5982 rtnl_stats_get+0x2f4/0x300
Modules linked in:
CPU: 0 PID: 754 Comm: syz-executor148 Not tainted 6.6.0-rc2-g331b78eb12af #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:rtnl_stats_get+0x2f4/0x300 net/core/rtnetlink.c:5982
Code: ff ff 89 ee e8 7d 72 50 ff 83 fd a6 74 17 e8 33 6e 50 ff 4c 89 ef be 02 00 00 00 e8 86 00 fa ff e9 7b fe ff ff e8 1c 6e 50 ff <0f> 0b eb e5 e8 73 79 7b 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900006837c0 EFLAGS: 00010293
RAX: ffffffff81cf7f24 RBX: ffff8881015d9000 RCX: ffff888101815a00
RDX: 0000000000000000 RSI: 00000000ffffffa6 RDI: 00000000ffffffa6
RBP: 00000000ffffffa6 R08: ffffffff81cf7f03 R09: 0000000000000001
R10: ffff888101ba47b9 R11: ffff888101815a00 R12: ffff8881017dae00
R13: ffff8881017dad00 R14: ffffc90000683ab8 R15: ffffffff83c1f740
FS:  00007fbc22dbc740(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000046 CR3: 000000010264e003 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 rtnetlink_rcv_msg+0x677/0x710 net/core/rtnetlink.c:6480
 netlink_rcv_skb+0xea/0x1c0 net/netlink/af_netlink.c:2545
 netlink_unicast+0x430/0x500 net/netlink/af_netlink.c:1342
 netlink_sendmsg+0x4fc/0x620 net/netlink/af_netlink.c:1910
 sock_sendmsg+0xa8/0xd0 net/socket.c:730
 ____sys_sendmsg+0x22a/0x320 net/socket.c:2541
 ___sys_sendmsg+0x143/0x190 net/socket.c:2595
 __x64_sys_sendmsg+0xd8/0x150 net/socket.c:2624
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7fbc22e8d6a9
Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc4320e778 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004007d0 RCX: 00007fbc22e8d6a9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000004007d0
R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc4320e898
R13: 00007ffc4320e8a8 R14: 00000000004004a0 R15: 00007fbc22fa5a80
 </TASK>
---[ end trace 0000000000000000 ]---

Which didn't happen prior to commit bf9f1baa279f ("net: add dedicated
kmem_cache for typical/small skb->head") as the skb always was large
enough.

Cc: Petr Machata <petrm@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 0e7788fd7622 ("net: rtnetlink: Add UAPI for obtaining L3 offload xstats")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
---

Notes:
    Another fix would be to make rtnl_offload_xstats_fill_hw_s_info_one()
    check whether the device has offload_xstats enabled. Let me know if that
    is a preferred route.

 net/core/rtnetlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4a2ec33bfb51..53c377d054f0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5503,13 +5503,11 @@ static unsigned int
 rtnl_offload_xstats_get_size_hw_s_info_one(const struct net_device *dev,
 					   enum netdev_offload_xstats_type type)
 {
-	bool enabled = netdev_offload_xstats_enabled(dev, type);
-
 	return nla_total_size(0) +
 		/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_REQUEST */
 		nla_total_size(sizeof(u8)) +
 		/* IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED */
-		(enabled ? nla_total_size(sizeof(u8)) : 0) +
+		nla_total_size(sizeof(u8)) +
 		0;
 }
 
-- 
2.32.3 (Apple Git-135)


