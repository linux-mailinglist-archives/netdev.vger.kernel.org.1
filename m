Return-Path: <netdev+bounces-27808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D8077D40D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAFB2815BF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192218AFC;
	Tue, 15 Aug 2023 20:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6521426C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 20:23:00 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2097.outbound.protection.outlook.com [40.107.105.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455E1BE7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 13:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imby8gubqHCJ21P/xJf3oL0Me/YEJIOrP+elEc6BH+UsRE7Rz+ZVDWyF5zMo++m6/OEU7l8Oals0F3S+O3xo5yUgXmofuBpAPctBhC3okNsF3w05q181X2KIRqFO9ZghthvTb/k9Gdxmlt8r5vo+CyZsS0uGd/OXjimIMkqy5sQZcolfiXdl5i5wGIsBuqKjyC8pJBgi8po4WGx0uHSO41k9X6awdyMjfoxk0zrMSS5uolCM/N2WZtgyIZ5CJLDCwvc/E4KVowZQscJMKnWXHyWpcXvAWitvpZsUMqGoDl6mrS/4b86pv8EwyXvZc/ZUHo3QhVED8L94EwBtOHJeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv68Lb6W0RWdlo9FAegB6K2be4VJ5AgdgSBzoK+dktY=;
 b=U3vICma98UkoCvVNjlX7QJA347zZQn9OOlmRvJwbyRzVtQZwuhGslEig1wLpZSNJsamjFl/ShXdJRG6/Ji0VR0NE+w/c5IS807wsxds+bOf4Oe0zuxMQmT2rB0YIS50i8SAV9hUjzqdUAfTcLB1sHud4ac4MEjqpk+zpiWQkm9YeJCZe5EHp6HVmS350DCnV5nDPRVZ4J4Nz+1ZOzQCBp+hMHzlwyIUxc4AQXA1ive+Z8eIzYkP7UPFlotQGmgiSbdZpRRsa8A2+A6Equ+ysNMJWzA2hYFplVKioI/NVvRQv1pjR3siKG2G8G/OxR0JMnzYRKJvCH62DHhLfHlzvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv68Lb6W0RWdlo9FAegB6K2be4VJ5AgdgSBzoK+dktY=;
 b=I9Ui/q4Ku5KGXdgczTYi3M09AmHSnMNWqrG6w5eM8gXhl1Q3xyrO0sEFqDOJVRcxQv/+BdlmQTJi4lQBi52zerTziLPxN+6dd0zdkihqJ2OGgfDvzo2WCqU3W5tGbwnVeeHGOu+gItJYNkb/g3zneNiWgxcLbK2FHlJ/ftfVqnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS8P189MB1638.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:351::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 20:22:53 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:22:53 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: netdev@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [Question]: TCP resets when using ECMP for load-balancing between multiple servers.
Date: Tue, 15 Aug 2023 22:10:48 +0200
Message-Id: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::27) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS8P189MB1638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3336cb7c-ff4f-459d-72c7-08db9dcd6788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CkD9UCfXVgyxZ++pQR2heI77EFbMH5OVvteXnYwK6ra5PyStbLpPcNJ6/KpPfcBS0UrX1Dy9NsJjQTf4PAZXVkCH1vlUZE25hGTaakvcPZ9UTRjwnniNXoZQbQGwNL0UG+u5sGHsX/zawCy/uEO3z7wd8U2uCq8dP75ua/llxFu4K+J89y8jJyYAz8mSGQFIxCO1BaU8MXDz3KknUEG9BZBXKPDrsY7o18ldCGNZ7mD3QjSrf8x12sBoy5UnFsczR7VSafzCSJyS10YW6bTZcbx0ni8KO7jmt6u5s7nbPIldGPxje+dZ4rS3YjwqNQGJivrJBbfCqHqP9dDZtMPHgnWG3edBeora8nHaDZvA0HH9RThXS4ZA/kHMaqAp4lSXhY9ayFxjnLy1X52TvUGUgt1+hcqOwpiJz1xUvgtbbozQe2rKFYDFSJqTNQZzV8nsN2WE3x9IPNuRFYisueeiFGkLCwmfMOJP9nEYZQA7nGZxd0BLK28z3AzA5RjdxsS9RWRAxtcD6qcqfAN7gz+wemhiDQw6vrRh6qIDjaaVmNQ4vKJ+uDMuFiaBVCEg7P3Ib/iKc8w6IcejTvBg1CNUOfJg/jpAw6FMDBUiA+dFARWRMyRjm5fvQkrZAUHNYTdbpJItLb6dgidP562SSP35tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39840400004)(109986022)(451199024)(1800799009)(186009)(38100700002)(41300700001)(66556008)(66476007)(316002)(30864003)(1076003)(26005)(4326008)(44832011)(66574015)(8676002)(36756003)(83380400001)(86362001)(2616005)(6486002)(6512007)(6666004)(2906002)(6506007)(478600001)(5660300002)(66946007)(70586007)(8936002)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psKPaRqqHWDXn/YAO5YBqesEUNCl6jkV48XMeGPjYUzMrSAoH2a1yZT0PDx+?=
 =?us-ascii?Q?GsGy0IMWsBekxCyIyxRYVcQ6aeul3v4f78tRglWtpIQp3cofrm9JSyVovfpU?=
 =?us-ascii?Q?sIUF19zSNep3ctEFi/czz3NpJ3I57lTMIXakDBmKParzD3yOVRf1/AUaWvk0?=
 =?us-ascii?Q?coma1+uR4xoh6pBYU6h6yCqzmG5/+vl7E7ZVGqeUZRnmPqb2mHsqFk58yOaZ?=
 =?us-ascii?Q?0nTDm6n6tCYRoWjPfg24SsSGzXkP0mP53OIMm/kyaI5mrurUMyS8VxWR0S8f?=
 =?us-ascii?Q?mc+6VNonzEhMrgEQ7/cxx0KbpcgZPHQHpz7hv4mw6c00cAl1IDiv7jt435+Q?=
 =?us-ascii?Q?lFk8oZwSpxbFD2UmsMQLMamLr6Dg7xcOQiw2Bc1eA1vzQ0qla6pW/AQwPiAx?=
 =?us-ascii?Q?b1bXNRzrkNlqExikoQcpjTqSMrO4ZNdCAiJNJthxCodTipvFhrwmfqni7IzO?=
 =?us-ascii?Q?pOlrDLBnL+R5C1PvDgGyFHupN/huvsLj1dSRqIrfYxeUaDoJl1/jdeunkFbh?=
 =?us-ascii?Q?b6++8+nDwPkfYAkBbQo2VFR0a8fslxzB439w2/UyMoTctcKNFv5/1vBDRzBi?=
 =?us-ascii?Q?5/tgHb6q5waH/eYTF8upA9E8YiKZOPW4JkhLHiBSoxqxol5xs0An6xP6xRNs?=
 =?us-ascii?Q?ZXwR3K46nE9h3pq60GCsSAU7T0sjGBptW+4mOk4kwVL/93cdHMUYVmXorrGr?=
 =?us-ascii?Q?r9mXllNri2f4tyjPQz5eCm4ScVLBmaNPfyyUgGhSnsVCJnxF5J5qvYAzg9n2?=
 =?us-ascii?Q?rDOC5siZoVddqHo+4pVoixpVF6jVoTnRQ8K/WNGXoDzEwQXN+F9jcpjLdVde?=
 =?us-ascii?Q?vfXAElc3+M4edPWkZV+2IOCnmO5JqTzTEExz2dAprM0f/F9ppFDJIiRdapto?=
 =?us-ascii?Q?gSLJewy53nBhpaloJkCr3VZWQluDYlBoJ3mgFMIaICOZLCK74nxK2jQB6MPe?=
 =?us-ascii?Q?or6aQRk7CSgMPJ2INZEErPoL4vAchMJtZaX7pFvaW6G+UrtJZ1w8CtW/sQyn?=
 =?us-ascii?Q?1BOKFo6dkzBnbU+EkOiEpReqqxAVU2OFDYAH5+IqjgbQ4la/ud0qEISR8p8k?=
 =?us-ascii?Q?nTJecsPpJheQKs4CigXUhmJas5uUSCcCG7qNVC20s4BwexGDtxK9tsthU4K+?=
 =?us-ascii?Q?swHP9uMD+LWfEcLZxDy+TOvPtLKS6q66fJRpShZjPGnbv7awbPiuZodqX56V?=
 =?us-ascii?Q?mx4WaaXdGyTmmcEijNu7/a0RRxkpT4uKNApFYc3dlDXB2pd7WNEDcGi+JUR5?=
 =?us-ascii?Q?JthbrtL5WuJHVfbvNgFYuwZ0YJh3K1hmyqWX5RUOz47q6BBEstH6mKgPwdL9?=
 =?us-ascii?Q?6h/xTLZqTjGwVXEr4mhPggr9WYWAFqdiARMT7cXVV0HpHPlttRseII7py/w8?=
 =?us-ascii?Q?3C903K9ElbNZFDDTGcyRmAqDQwxqsQAmOFICk5oRIsg7Nce8RJ1CCYfpq1JJ?=
 =?us-ascii?Q?btAA4aiyJFQHhZjBx14Dm/tvxFtbE2CNUzqBNYZgNU47onxZMZEx1j79gQX7?=
 =?us-ascii?Q?eNKk5c/r4QpmWHHKwUzisRk4SgP049RPasGBQ+TSZIfQfrQhnvkhMnXpQzRQ?=
 =?us-ascii?Q?oOrDh9KYAJLZXI2DSYjw0WUoET8uyRnGV0ebSFZOH9164tvuMZ1h2GWpd7/i?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 3336cb7c-ff4f-459d-72c7-08db9dcd6788
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:22:53.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu8gf3/RwFtg3CXtTxR/OLseRTaIYqN0sFW/JWHe7q0cvpBmJLK6P2HYOyI/VHP2nozOINoNlezvaTLFvVwGRw9290FEGkJDhV7ieieoO2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1638
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All packets in the same flow (L3/L4 depending on multipath hash policy)
should be directed to the same target, but after [0] we see stray
packets directed towards other targets. This, for instance, causes RST
to be sent on TCP connections. This happens on a static setup, with no
changes to the nexthops, so there is no hash space reassignment.

IIUC, route hints when the next hop is part of a multipath group causes
packets in the same receive batch to be sent to the same next hop
irrespective of which nexthop the multipath hash points to. I am no
expert in this area, so please let me know if there is a simple
explanation on how to fix this problem?

Below is a patch which has a selftest that describes the problem setup
and a hack to solve the problem in ipv4. For ipv6, I have just commented
out the part the returns the route hint, just for testing.

[0]: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")

---
 include/uapi/linux/in_route.h                 |   1 +
 net/ipv4/ip_input.c                           |   9 +-
 net/ipv4/route.c                              |   7 +-
 net/ipv6/ip6_input.c                          |   4 +
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_multipath_vip.sh    | 324 ++++++++++++++++++
 6 files changed, 341 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/router_multipath_vip.sh

diff --git a/include/uapi/linux/in_route.h b/include/uapi/linux/in_route.h
index 0cc2c23b47f8..01ae06c7743b 100644
--- a/include/uapi/linux/in_route.h
+++ b/include/uapi/linux/in_route.h
@@ -15,6 +15,7 @@
 #define RTCF_REDIRECTED	0x00040000
 #define RTCF_TPROXY	0x00080000 /* unused */
 
+#define RTCF_MULTIPATH	0x00200000
 #define RTCF_FAST	0x00200000 /* unused */
 #define RTCF_MASQ	0x00400000 /* unused */
 #define RTCF_SNAT	0x00800000 /* unused */
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fe9ead9ee863..e06a1a6a4357 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -582,9 +582,11 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 }
 
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
-					     struct sk_buff *skb, int rt_type)
+					     struct sk_buff *skb, int rt_type,
+					     unsigned int rt_flags)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	    !!(rt_flags & RTCF_MULTIPATH))
 		return NULL;
 
 	return skb;
@@ -615,7 +617,8 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
 			hint = ip_extract_route_hint(net, skb,
-					       ((struct rtable *)dst)->rt_type);
+					       ((struct rtable *)dst)->rt_type,
+					       ((struct rtable *)dst)->rt_flags);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 92fede388d52..232b507faf04 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1786,6 +1786,7 @@ static void ip_handle_martian_source(struct net_device *dev,
 
 /* called in rcu_read_lock() section */
 static int __mkroute_input(struct sk_buff *skb,
+			   unsigned int flags,
 			   const struct fib_result *res,
 			   struct in_device *in_dev,
 			   __be32 daddr, __be32 saddr, u32 tos)
@@ -1856,7 +1857,7 @@ static int __mkroute_input(struct sk_buff *skb,
 		}
 	}
 
-	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
+	rth = rt_dst_alloc(out_dev->dev, flags, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
 		err = -ENOBUFS;
@@ -2139,16 +2140,18 @@ static int ip_mkroute_input(struct sk_buff *skb,
 			    __be32 daddr, __be32 saddr, u32 tos,
 			    struct flow_keys *hkeys)
 {
+	unsigned int flags = 0;
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
 		fib_select_multipath(res, h);
+		flags |= RTCF_MULTIPATH;
 	}
 #endif
 
 	/* create a routing cache entry */
-	return __mkroute_input(skb, res, in_dev, daddr, saddr, tos);
+	return __mkroute_input(skb, flags, res, in_dev, daddr, saddr, tos);
 }
 
 /* Implements all the saddr-related checks as ip_route_input_slow(),
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d94041bb4287..1b7527a4a4bd 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -99,10 +99,14 @@ static bool ip6_can_use_hint(const struct sk_buff *skb,
 static struct sk_buff *ip6_extract_route_hint(const struct net *net,
 					      struct sk_buff *skb)
 {
+#if 0
 	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net))
 		return NULL;
 
 	return skb;
+#else
+	return NULL;
+#endif
 }
 
 static void ip6_list_rcv_finish(struct net *net, struct sock *sk,
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 770efbe24f0d..bf4e5745fd5c 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -70,6 +70,7 @@ TEST_PROGS = bridge_igmp.sh \
 	router_mpath_nh.sh \
 	router_multicast.sh \
 	router_multipath.sh \
+	router_multipath_vip.sh \
 	router_nh.sh \
 	router.sh \
 	router_vid_1.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_multipath_vip.sh b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
new file mode 100755
index 000000000000..0415cf974388
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_multipath_vip.sh
@@ -0,0 +1,324 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------+                     +----------------------+
+# | H1                 |                     |                   H2 |
+# |                    |                     |                      |
+# |              $h1 + |                     | + $h2                |
+# |     192.0.2.2/24 | |                     | | 198.51.100.2/24    |
+# | 2001:db8:1::2/64 | |                     | | 2001:db8:2::2/64   |
+# |                  | |                     | |                    |
+# +------------------|-+                     +-|--------------------+
+#                    |                         |
+# +------------------|-------------------------|--------------------+
+# | SW               |                         |                    |
+# |                  |                         |                    |
+# |             $rp1 +                         + $rp2               |
+# |     192.0.2.1/24                             198.51.100.1/24    |
+# | 2001:db8:1::1/64     + vip                   2001:db8:2::1/64   |
+# |                        198.18.0.0/24                            |
+# |                        2001:db8:18::/64    + $rp3               |
+# |                                            | 203.0.113.1/24     |
+# |                                            | 2001:db8:3::1/64   |
+# |                                            |                    |
+# |                                            |                    |
+# +--------------------------------------------|--------------------+
+#                                              |
+#                                            +-|--------------------+
+#                                            | |                 H3 |
+#                                            | |                    |
+#                                            | | 203.0.113.2/24     |
+#                                            | | 2001:db8:3::2/64   |
+#                                            | + $h3                |
+#                                            |                      |
+#                                            +----------------------+
+
+ALL_TESTS="ping_ipv4 ping_ipv6 multipath_test"
+NUM_NETIFS=6
+source lib.sh
+
+h1_create()
+{
+	vrf_create "vrf-h1"
+	ip link set dev $h1 master vrf-h1
+
+	ip link set dev vrf-h1 up
+	ip link set dev $h1 up
+
+	ip address add 192.0.2.2/24 dev $h1
+	ip address add 2001:db8:1::2/64 dev $h1
+
+	ip route add default vrf vrf-h1 via 192.0.2.1
+	ip route add default vrf vrf-h1 via 2001:db8:1::1
+}
+
+h1_destroy()
+{
+	ip route del default vrf vrf-h1 via 2001:db8:1::1
+	ip route del default vrf vrf-h1 via 192.0.2.1
+
+	ip address del 2001:db8:1::2/64 dev $h1
+	ip address del 192.0.2.2/24 dev $h1
+
+	ip link set dev $h1 down
+	vrf_destroy "vrf-h1"
+}
+
+h2_create()
+{
+	vrf_create "vrf-h2"
+	ip link set dev $h2 master vrf-h2
+
+	ip link set dev vrf-h2 up
+	ip link set dev $h2 up
+
+	ip address add 198.51.100.2/24 dev $h2
+	ip address add 2001:db8:2::2/64 dev $h2
+
+	ip address add 198.18.0.0/24 dev vrf-h2
+	ip address add 2001:db8:18::/64 dev vrf-h2
+
+	ip route add 192.0.2.0/24 vrf vrf-h2 via 198.51.100.1
+	ip route add 2001:db8:1::/64 vrf vrf-h2 nexthop via 2001:db8:2::1
+}
+
+h2_destroy()
+{
+	ip route del 2001:db8:1::/64 vrf vrf-h2 nexthop via 2001:db8:2::1
+	ip route del 192.0.2.0/24 vrf vrf-h2 via 198.51.100.1
+
+	ip address del 2001:db8:18::/64 dev vrf-h2
+	ip address del 198.18.0.0/24 dev vrf-h2
+
+	ip address del 2001:db8:2::2/64 dev $h2
+	ip address del 198.51.100.2/24 dev $h2
+
+	ip link set dev $h2 down
+	vrf_destroy "vrf-h2"
+}
+
+h3_create()
+{
+	vrf_create "vrf-h3"
+	ip link set dev $h3 master vrf-h3
+
+	ip link set dev vrf-h3 up
+	ip link set dev $h3 up
+
+	ip address add 203.0.113.2/24 dev $h3
+	ip address add 2001:db8:3::2/64 dev $h3
+
+	ip address add 198.18.0.0/24 dev vrf-h3
+	ip address add 2001:db8:18::/64 dev vrf-h3
+
+	ip route add 192.0.2.0/24 vrf vrf-h3 via 203.0.113.1
+	ip route add 2001:db8:1::/64 vrf vrf-h3 nexthop via 2001:db8:3::1
+}
+
+h3_destroy()
+{
+	ip route del 2001:db8:1::/64 vrf vrf-h3 nexthop via 2001:db8:3::1
+	ip route del 192.0.2.0/24 vrf vrf-h3 via 203.0.113.1
+
+	ip address del 198.18.0.0/24 dev vrf-h3
+	ip address del 2001:db8:18::/64 dev vrf-h3
+
+	ip address del 2001:db8:3::2/64 dev $h3
+	ip address del 203.0.113.2/24 dev $h3
+
+	ip link set dev $h3 down
+	vrf_destroy "vrf-h3"
+}
+
+router1_create()
+{
+	vrf_create "vrf-r1"
+	ip link set dev $rp1 master vrf-r1
+	ip link set dev $rp2 master vrf-r1
+	ip link set dev $rp3 master vrf-r1
+
+	ip link set dev vrf-r1 up
+	ip link set dev $rp1 up
+	ip link set dev $rp2 up
+	ip link set dev $rp3 up
+
+	ip address add 192.0.2.1/24 dev $rp1
+	ip address add 2001:db8:1::1/64 dev $rp1
+
+	ip address add 198.51.100.1/24 dev $rp2
+	ip address add 2001:db8:2::1/64 dev $rp2
+
+	ip address add 203.0.113.1/24 dev $rp3
+	ip address add 2001:db8:3::1/64 dev $rp3
+
+	ip route add 198.18.0.0/24 vrf vrf-r1 \
+		nexthop via 198.51.100.2 \
+		nexthop via 203.0.113.2
+	ip route add 2001:db8:18::/64 vrf vrf-r1 \
+		nexthop via 2001:db8:2::2 \
+		nexthop via 2001:db8:3::2
+}
+
+router1_destroy()
+{
+	ip route del 2001:db8:18::/64 vrf vrf-r1
+	ip route del 198.18.0.0/24 vrf vrf-r1
+
+	ip address del 2001:db8:3::1/64 dev $rp3
+	ip address del 203.0.113.1/24 dev $rp3
+
+	ip address del 2001:db8:2::1/64 dev $rp2
+	ip address del 198.51.100.1/24 dev $rp2
+
+	ip address del 2001:db8:1::1/64 dev $rp1
+	ip address del 192.0.2.1/24 dev $rp1
+
+	ip link set dev $rp3 down
+	ip link set dev $rp2 down
+	ip link set dev $rp1 down
+
+	vrf_destroy "vrf-r1"
+}
+
+multipath4_test()
+{
+	local desc="$1"
+	local weight_rp2=$2
+	local weight_rp3=$3
+	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
+	local packets_rp2 packets_rp3
+
+	# Transmit multiple flows from h1 to h2 and make sure they are
+	# distributed between both multipath links (rp2 and rp3)
+	# according to the configured weights.
+	sysctl_set net.ipv4.fib_multipath_hash_policy 1
+	ip route replace 198.18.0.0/24 vrf vrf-r1 \
+		nexthop via 198.51.100.2 weight $weight_rp2 \
+		nexthop via 203.0.113.2 weight $weight_rp3
+
+	t0_rp2=$(link_stats_tx_packets_get $rp2)
+	t0_rp3=$(link_stats_tx_packets_get $rp3)
+
+	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.18.0.0 \
+		-d 1msec -t tcp "sp=1024,dp=0-32768"
+
+	t1_rp2=$(link_stats_tx_packets_get $rp2)
+	t1_rp3=$(link_stats_tx_packets_get $rp3)
+
+	let "packets_rp2 = $t1_rp2 - $t0_rp2"
+	let "packets_rp3 = $t1_rp3 - $t0_rp3"
+	multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
+
+	ip route replace 198.18.0.0/24 vrf vrf-r1 \
+		nexthop via 198.51.100.2 \
+		nexthop via 203.0.113.2
+
+	sysctl_restore net.ipv4.fib_multipath_hash_policy
+}
+
+multipath6_l4_test()
+{
+	local desc="$1"
+	local weight_rp2=$2
+	local weight_rp3=$3
+	local t0_rp2 t0_rp3 t1_rp2 t1_rp3
+	local packets_rp2 packets_rp3
+
+	# Transmit multiple flows from h1 to h2 and make sure they are
+	# distributed between both multipath links (rp2 and rp3)
+	# according to the configured weights.
+	sysctl_set net.ipv6.fib_multipath_hash_policy 1
+	ip route replace 2001:db8:18::/64 vrf vrf-r1 \
+		nexthop via 2001:db8:2::2 weight $weight_rp2 \
+		nexthop via 2001:db8:3::2 weight $weight_rp3
+
+	t0_rp2=$(link_stats_tx_packets_get $rp2)
+	t0_rp3=$(link_stats_tx_packets_get $rp3)
+
+	ip vrf exec vrf-h1 $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:18::0 \
+		-d 1msec -t tcp "sp=1024,dp=0-32768"
+
+	t1_rp2=$(link_stats_tx_packets_get $rp2)
+	t1_rp3=$(link_stats_tx_packets_get $rp3)
+
+	let "packets_rp2 = $t1_rp2 - $t0_rp2"
+	let "packets_rp3 = $t1_rp3 - $t0_rp3"
+	multipath_eval "$desc" $weight_rp2 $weight_rp3 $packets_rp2 $packets_rp3
+
+	ip route replace 2001:db8:18::/64 vrf vrf-r1 \
+		nexthop via 2001:db8:2::2 \
+		nexthop via 2001:db8:3::2
+
+	sysctl_restore net.ipv6.fib_multipath_hash_policy
+}
+
+multipath_test()
+{
+	log_info "Running IPv4 multipath tests"
+	multipath4_test "ECMP" 1 1
+	multipath4_test "Weighted MP 2:1" 2 1
+	multipath4_test "Weighted MP 11:45" 11 45
+
+	log_info "Running IPv6 L4 hash multipath tests"
+	multipath6_l4_test "ECMP" 1 1
+	multipath6_l4_test "Weighted MP 2:1" 2 1
+	multipath6_l4_test "Weighted MP 11:45" 11 45
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	rp1=${NETIFS[p2]}
+
+	rp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	rp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+	h3_create
+
+	router1_create
+
+	forwarding_enable
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	forwarding_restore
+
+	router1_destroy
+
+	h3_destroy
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+ping_ipv4()
+{
+	ping_test $h1 198.51.100.2
+	ping_test $h1 203.0.113.2
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:2::2
+	ping6_test $h1 2001:db8:3::2
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.34.1


