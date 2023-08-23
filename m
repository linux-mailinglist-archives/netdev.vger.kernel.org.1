Return-Path: <netdev+bounces-29888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6B7850C4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F948280E9F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E61C3F;
	Wed, 23 Aug 2023 06:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6B20EE0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:45:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A19E58
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ouykb0r/gNDZg1jgXQWdy0esrGBQ2JUuc83A3X7GfCYAxad2tWnFWRe60Hm2WBHLjP1KcNvgIRb6G9562SgqiYIhwIN8B0rL+GIovo3W2nz1FDmSsR3h2RISE95PZ5x2S3jTLgBQlLSecJJzqwis4EM1vXJ9H9kMHH6hiEWYA7fmK47FflE9cnau7YOfgpZfWFlMpOJgZR8bVE5ASJo84D9pybbY8W5ZmSgiFv3TUp2bl/EGIQc0j3RYj7gBDAuWFHsoGz3GqrhajiAzXPmG0eWDVUX3aoNjfJUHW60VQy2TdR+HII0svl4+w02M/w2R4fhE/QmbQPvLw4iPhu/KRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCKzswquWwm8rQcb/2yY9+L/KqkpqjP9N7NEW+cb7TA=;
 b=SYThYImjzA1OYvaTCUn1ayaSm6rOh9XxLP9JPgzIbzUOR32V0rp5p77i6oGpevf3d5U0JNGpX7h1Djt5LCoPxaq3MMC/0tbsKvP0vlmiNb54DqA0foyc3Vxl7dTlJxDq1vlFTeyhgNO8jg/lj1aS4mJqcbQXS6b0Hak+u0SIzgUJhjGtatqGJaYePj2CEysNRRZcUbYsPdNL1YYz9Vral5JD7bL5vQFYw09H9tfxZEMf9v+3iPc+snGGbFz6V7My4dLQwM05HOPZX7uvN1FkqjOdDrPqfNVn/KG7NZmN7wv+JBBr+JgPcIk6Z41mmAe0sTwEPga7l9HsbtS3fdHzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCKzswquWwm8rQcb/2yY9+L/KqkpqjP9N7NEW+cb7TA=;
 b=sS0cv2R0/zN8fuq2L6Yv6APnclIuvmn3XxGGN7xxrCZnX2agWBteQM1XoRsiUO11BgHZI4I6JyLrkvBAX7UiQTUxLSRMqFGiDxJu+dOVBuJBw/+pKra/xSGadSUyLf8rRK6LxfL3XaSrM/Ouda3sLt/M4z/vWKw5kPNmY1hS4AwkVIfzFv3kM9z6j4mQ1cO02hDDCapNmlX2TUTfwGDBaOzdtZrPgcU0zO4rAZYLyaHnFwrM1+HUen2VoFYbX7fMHhl1tmSjDByJDwl79OsiODDEOCrmtAa2Yj0A1aAZeEO+mtm+wMoFnoEyl0DXGWpj0OzSQNXkakD+54hlaXwYuQ==
Received: from SA1P222CA0132.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::15)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 06:44:57 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::8c) by SA1P222CA0132.outlook.office365.com
 (2603:10b6:806:3c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 06:44:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 23:44:41 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 23:44:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <jiri@nvidia.com>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] rtnetlink: Reject negative ifindexes in RTM_NEWLINK
Date: Wed, 23 Aug 2023 09:43:48 +0300
Message-ID: <20230823064348.2252280-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d83a87-bdb8-4bd3-b411-08dba3a47717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	03DUp+8AFcRZjlZQgEXpxZHdsk6We97crQjm/s1lx2dq8GREHgzEJWHyEyOSUHW4KCWP1FNOPWDaj6K8lnzFLc+qjW4an0+CTFWzALhTM/goPBl97dLB1Vc/gsixw28rtYCvb3rc9oEkvxDZGJixAOS9Vew3tcBSdVR3EVH676soBDOUPde8CN6DjD16ZZmWlvfBXnwAfIO4L2oYm3B0m8iboJujqiB67TgWLJP+F79meT4BJlD1tzpZElN33r1HfuBBwQgojpQzHcJtU6VYwt2S5LmRqvgvEPhdREAnfTnowKVBS+HIXrsqUTA8qaIj8yDtan3T4zOiFylK4/FNZvRGtlM8FydNj5sps/ocBOhXb54AKH3pVcxwuSNOdXPUzxqX/aRJExeZtTozWtE4YAqOiN1RAoIT1mjsoLMoez7tZ9xpIlcfpwrrhZx7utGK4ltvL6DYG7Ey/IkeGUkXkB3DubakcML+N8wb4N/f82KT72N6fGnq4Wa/pCGsXuY8cSD4K9qaxc65PS6y4jFFLm7BiWX+bOfeKxUvzBLaUNhOPiSvh+oClmW6b+hOVPv+vzfXudNEsfQiKOK6BGFFPkEY+ZCtjcFn4HP/mtdaniifw/GCFlXpP3picxCBkpDLkOvFEqohQHTw1CRJBxbIVFypkhgMKHWq487s5w+vh9Rr6gX76bV8SghKR5243iyWlgOCJ/dE8IDkC5x/8PhXGfFKU+IGcA6k/pTcApHIKZowG+TehFVJBpLTEJCM0Ug0
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(47076005)(40460700003)(36860700001)(83380400001)(2906002)(356005)(7636003)(82740400003)(36756003)(86362001)(40480700001)(41300700001)(54906003)(70206006)(70586007)(316002)(6916009)(2616005)(4326008)(8676002)(8936002)(478600001)(6666004)(26005)(16526019)(1076003)(107886003)(5660300002)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:44:56.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d83a87-bdb8-4bd3-b411-08dba3a47717
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Negative ifindexes are illegal, but the kernel does not validate the
ifindex in the ancillary header of RTM_NEWLINK messages, resulting in
the kernel generating a warning [1] when such an ifindex is specified.

Fix by rejecting negative ifindexes.

[1]
WARNING: CPU: 0 PID: 5031 at net/core/dev.c:9593 dev_index_reserve+0x1a2/0x1c0 net/core/dev.c:9593
[...]
Call Trace:
 <TASK>
 register_netdevice+0x69a/0x1490 net/core/dev.c:10081
 br_dev_newlink+0x27/0x110 net/bridge/br_netlink.c:1552
 rtnl_newlink_create net/core/rtnetlink.c:3471 [inline]
 __rtnl_newlink+0x115e/0x18c0 net/core/rtnetlink.c:3688
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3701
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6427
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2538
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2592
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2621
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 38f7b870d4a6 ("[RTNETLINK]: Link creation API")
Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index bcebdeb59163..00c94d9622b4 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3561,6 +3561,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
 		dev = __dev_get_by_index(net, ifm->ifi_index);
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
 		dev = rtnl_dev_get(net, tb);
-- 
2.40.1


