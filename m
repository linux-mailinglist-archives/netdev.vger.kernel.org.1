Return-Path: <netdev+bounces-25358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FDA773C89
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE33280AC3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF01CA14;
	Tue,  8 Aug 2023 15:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471E13AC8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:51:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D167C6
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/v5TxvElOEryx/lgxPxLcXhkWd4spJWzp0eJdvZfVEojd6Lwv+arF1TZaf8+NlZDIv8FIdpFCRGviszcG2niPVVePLPtM6me2MN2yzQ8/TtaBys+544OyAktiq3rSMVRVuJcg5dZlbVlOq8CiRVlWtJMQ3LS1iIqzb1heHRrXx1HWOUZJ0sk1QbJj5v3Qmwj7h++mh1a8eqUsUZDkx+hdtAVZ+gRu8giqPI2YwOqm207eBJ58ULude+yTo5fnpeV9CqOmFvZzoshsXVuvXNVLOS4A2NqHFQ1KqHUaFZETT1kAMRszTRCBK9Kl/+FeNS5GOsK3UYr9frqkuwh4ThPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNoA4cQQ6a4JKvQR3QlZxh0iwq0fcwTdfdhbEBBiif8=;
 b=Czsbic/q0Ju146AARCPHXq8Zdad40MPcfJjiOxB/RyswNCdvoraW4+m591hM7LsyB+JNMfiutW3/bbi/tCdGY9JtEHFceXKhGWC8U6htQDLnfq3/TIp58jaBIrhKVsYjO9zYA1plqB/QiHLGYf1h/lErq/QK4wVkUbIFsWZc98f86f3qQcfNTXhoH11gi6BybuaYUVAVG/J8TU4a7wPlGx21nnQMmevRaHtVcKpbtigM01tekh+ltKZHB7wzKVJjWTV5e1saddz5TcR6FK7rgqkxq2aBQTmeX18PRAy/JOsIKlutQMAf3n7WW/jkNmJtco1jSYRzzshDZGY5CM3aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNoA4cQQ6a4JKvQR3QlZxh0iwq0fcwTdfdhbEBBiif8=;
 b=LuQRaeGjU6AUXhhbTSCIAI6sfsgL6qRvHk8HZhTsjiiwerpZEnEEV3s8Nq2soOWfSdQXW3NrmunI1DX2a1L75i5mHlW0oPbmO/DSB5tVDxgtP3Ee0DE5ZLomATyb8nr3V0p2nNzWA3Cx1rR1s/Y5jexsFYxyhbY5B0Zk7/lD+9dWGn+eksZzxu22wksCGJM0OFjflgl6YyM5OWIHhgoRhh6pqGThRPD+xVcYwMG+eMemByZVsFBTStii6vlULqG7McuLIezYTgi2V6JNvMhsyUaCkknIcBDpN1rJd23UFtvzbPY9laX1H8WzvmjUHRfwL0mxHLXz3CiGBMAwNj3qog==
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 07:53:14 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ab) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 07:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 07:53:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 00:53:07 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 00:53:04 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net 2/3] nexthop: Make nexthop bucket dump more efficient
Date: Tue, 8 Aug 2023 10:52:32 +0300
Message-ID: <20230808075233.3337922-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe8b6d7-f02b-4815-43b8-08db97e4877d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jn4Lmn05pm6/jps0JzJR0K3LI4mNpUlNEOIXdGJb8C5kQvXjY8atNqYOe2Oe8Yl2fKBLvvlTCfcJX2BzoJ1wIuHCp0OMsJbmyqGIk437QdUa7gCDwry5UtUIHsy6rz1q2TWmK32D3UinWVorc/ZI1sH7kd3e0l307j0iAOK8nB2UBqQcoN8GkclLFBV3ixfk00KbdAwFypge4q1XmL/1EBXOIpRoubVh9BtctyomFVqj0Vve6JKQFNBWsiGYrU8Z9CeI/0cyji31yf75McqsnUQWA0A341lOfW6v+o8937vE8vJAG4CoyMRCFFAN3hDXAnGrb53D96SBY97aeNJnC3OQKuhgB9l7/YTo2M0m1KzsjvV6by8DXGS6VbXiPA0/b+EfHvdN/PBaTYcTJ+cT3sE/Ov4SNWKxxYZONjKRDz85w20HK6luGZSHSM7Qb+X/lIweDbRppNRHgInZyRgF8Iw8VGO2iVXVm2mh6h9y1FLH++tqM1BFkLW9Gjxf9odf2Xkd5dlWGnA93j+lmhydmrY+Ku9F/eNJ2cpTF99WnWfCX8kaRneAombH0RTA8oy3d0fkdyLsfEBanJStUNYIrmgxMZ4i2xhu4+19KwVrRJS8ZqR/DmEu5RUOkSfD2lt01upvTGH5Q9nwSJYcZFMjx/lA08FjKmjg8EZo6ghIh7byK/OyDxu2YbWMZSgV+b2IN/KQIU7tZI/uwa61JadXpPsUlQj4VCPGsbDTsaE/L7iAtZVrwWqmgszdyYdgE2pbqgbdgXuv5yiVcuJ+gNc1HBOAYcPkyl6ls1rtVk/mSRVLUwGSIacxhJNIs+LNJHSd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(90011799007)(451199021)(82310400008)(90021799007)(1800799003)(186006)(46966006)(40470700004)(36840700001)(8676002)(8936002)(5660300002)(6916009)(4326008)(41300700001)(426003)(316002)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6666004)(2616005)(26005)(1076003)(107886003)(36756003)(16526019)(336012)(70586007)(70206006)(7636003)(356005)(478600001)(82740400003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:53:18.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe8b6d7-f02b-4815-43b8-08db97e4877d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

rtm_dump_nexthop_bucket_nh() is used to dump nexthop buckets belonging
to a specific resilient nexthop group. The function returns a positive
return code (the skb length) upon both success and failure.

The above behavior is problematic. When a complete nexthop bucket dump
is requested, the function that walks the different nexthops treats the
non-zero return code as an error. This causes buckets belonging to
different resilient nexthop groups to be dumped using different buffers
even if they can all fit in the same buffer:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id 10 group 1 type resilient buckets 1
 # ip nexthop add id 20 group 1 type resilient buckets 1
 # strace -e recvmsg -s 0 ip nexthop bucket
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
 id 10 index 0 idle_time 10.27 nhid 1
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 64
 id 20 index 0 idle_time 6.44 nhid 1
 [...]

Fix by only returning a non-zero return code when an error occurred and
restarting the dump from the bucket index we failed to fill in. This
allows buckets belonging to different resilient nexthop groups to be
dumped using the same buffer:

 # ip link add name dummy1 up type dummy
 # ip nexthop add id 1 dev dummy1
 # ip nexthop add id 10 group 1 type resilient buckets 1
 # ip nexthop add id 20 group 1 type resilient buckets 1
 # strace -e recvmsg -s 0 ip nexthop bucket
 [...]
 recvmsg(3, {msg_name={sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, msg_namelen=12, msg_iov=[...], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 128
 id 10 index 0 idle_time 30.21 nhid 1
 id 20 index 0 idle_time 26.7 nhid 1
 [...]

While this change is more of a performance improvement change than an
actual bug fix, it is a prerequisite for a subsequent patch that does
fix a bug.

Fixes: 8a1bbabb034d ("nexthop: Add netlink handlers for bucket dump")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 179e50d8fe07..f365a4f63899 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3363,25 +3363,19 @@ static int rtm_dump_nexthop_bucket_nh(struct sk_buff *skb,
 		    dd->filter.res_bucket_nh_id != nhge->nh->id)
 			continue;
 
+		dd->ctx->bucket_index = bucket_index;
 		err = nh_fill_res_bucket(skb, nh, bucket, bucket_index,
 					 RTM_NEWNEXTHOPBUCKET, portid,
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 cb->extack);
-		if (err < 0) {
-			if (likely(skb->len))
-				goto out;
-			goto out_err;
-		}
+		if (err)
+			return err;
 	}
 
 	dd->ctx->done_nh_idx = dd->ctx->nh.idx + 1;
-	bucket_index = 0;
+	dd->ctx->bucket_index = 0;
 
-out:
-	err = skb->len;
-out_err:
-	dd->ctx->bucket_index = bucket_index;
-	return err;
+	return 0;
 }
 
 static int rtm_dump_nexthop_bucket_cb(struct sk_buff *skb,
-- 
2.40.1


