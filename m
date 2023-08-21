Return-Path: <netdev+bounces-29344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0AA782BAA
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6369B280E97
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB679C7;
	Mon, 21 Aug 2023 14:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791475258
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 14:24:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375CCE2
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaFGu04z0849u0T+vSamXs7dRXhUIFu6cAWCWKKG61uuHqQZGkP7+/8+nK4jl2XEt30fTavZwTD7FOoxyrdWKn7SDb1/J8pajNFTFt/832BJiCl3CgLPfkX4WeeIrmbol0O4hEpjg3gT18DCZnBRiTzTikAhv3BKfvHdiqU7DyNhL8JwBYlEpz0jJOBNVAGCXNgvbuxoJOk3w3Rt8BD9DB1mQAq6r9ucD0/cYZm9MTOZ1b847LtabyeCDJQq+b/YlmS+iaQEO/xTWHngbyHBJFWhLzh8zI8Zq/TvbrfVecHlrB3JxvnwlBbwxWQkDoU6aHm2tx0RXy0h/IEqtqEJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/tRe0MDu/dv5MKbIwFtu0RKhEhvT2FDqGKNAizr1rI=;
 b=l5uzxWdCjENCb+k6V6VinRpVhcmq+C3pFEqw0d5l7L0R6MOAnH9zdTputHwaN8cMDd1eYrOczMjNmkskyZQEePorZoRjwxtQmwGuJYpsZ1rMAXC8LkTxgzx1+fF7sVf905/PocCFmixXE/cVmUoTPXgGKsJ2xk+qeQlRSwT5YytLD81rkYe6ZGxIIvg4lKDLqgLChm+DBr3ZpU7yP5VWONXoh8CrTlFp6Cnnn3F7OtI7sMxJ2FtSqbVTMoX8bvwLhK2LYqgJN1Jo67Bjc2ENxlpmgkk5wskb8UZLz7mrHEq4Tu7MNt4+OysoJT+nSfTHKlhowrDb8LlEVPCsRntEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/tRe0MDu/dv5MKbIwFtu0RKhEhvT2FDqGKNAizr1rI=;
 b=PPar9t9cGiQMWZq1C5bMAO2/EbyI0St3s1L6lDo5uOyluHNzfnwai5S6iVoafjEVgBIh/JckPHjaDHy8eegSkOC+wekgeKiljowB8w64zwyQZtzCB4rgAdRTGY928Qj2fbtgXTEcIad/oOGHKk8dGu/eqPHnHY9mjmI1BMx6bBhscztyFDyKc/fSKkXtRh8PgKZW6z7s6V61Pf9gCQuY/Yba+SDj32As7qCJvxk3+/BX9rru06CxDj+3StsyTCO6Rj/zOU70x+oNCfFReQckem1OoyFn+H3ArbmY3ErweE61r0U3F+S5fxWJ32QDjnVMwC7xEaLyMybqlXKWhJwCag==
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 14:24:15 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::56) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 14:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.2 via Frontend Transport; Mon, 21 Aug 2023 14:24:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 07:24:04 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 07:24:00 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <mlxsw@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next] vrf: Remove unnecessary RCU-bh critical section
Date: Mon, 21 Aug 2023 17:23:39 +0300
Message-ID: <20230821142339.1889961-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: e3503a6c-e7e6-41e9-4334-08dba2524bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbZJKXfF1j3jITBBbvf5sqKcNPk2QNkYmHe4w63zyg9iULLeOYgAPspKRjEzHbMGK38+pxajS9TAfAqy+C2vNgdy7/RxPYr3zAlrIl/HW0Wb8hr/akLwgLZ39SpoInpwVM/06DH0TVYZVyNb/tETGH6AbzxJI6/aHV1F9ZGWrS+eDCRkbL7buaZ2lMnz4139UaUM5HOSXZFTEMbxoxj268z9dPn9rjOV6P1xK49SNtJCXd4h19p7YcF4iqG86tOjVz0nAYlf3c4Ksxo3O3y7ll5qqlvFZz+1emnfYHvw/7SS4sl/2h21FdL4jd1ovheY8lGN+zUDA2FkjyA3YktGrtgRg/lptzi2FWixeNGdH0b0ANj7E3zdmg8VODRd2aL3fldSqFV1fsUjRrqaf+CUAoo38gbkkTWt8z/eLDx4OFq7VQjgPPJOltt21hDPq+iDlICcTZ/V7rcYwQHoY3XKRMslIbj8SBPrNhAMnvzjBsicHyeJxAPk5kyGiMWS4Zig0mLvicvzeo0jzFicQRU7FPRxVlsGyveLXXY0qWNS0wktqfCdDHfMjv4Nv3CuTiJITCf3Jw41HpI7dXWknA4mbAwzw5DSTvObjsqTPB1ourTnTKc/jP0DxlLX7unUWpzq57Vwt0AdvYJfrmbug8D629HDFR9T0EenUy+7CgJRfkZnFCPTMV2zkptFX4qbQTdlm5TJHUie6r3JLfPgeo2zK4qzoWF5WybMTEXgE/b6qEziGcfHbf7luzhXH9VPFqtc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(6916009)(54906003)(70586007)(70206006)(316002)(8676002)(8936002)(2616005)(4326008)(107886003)(1076003)(36756003)(41300700001)(40460700003)(7636003)(82740400003)(356005)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(47076005)(36860700001)(336012)(426003)(5660300002)(16526019)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:24:14.7376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3503a6c-e7e6-41e9-4334-08dba2524bff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

dev_queue_xmit_nit() already uses rcu_read_lock() / rcu_read_unlock()
and nothing suggests that softIRQs should be disabled around it.
Therefore, remove the rcu_read_lock_bh() / rcu_read_unlock_bh()
surrounding it.

Tested using [1] with lockdep enabled.

[1]
 #!/bin/bash

 ip link add name vrf1 up type vrf table 100
 ip link add name veth0 type veth peer name veth1
 ip link set dev veth1 master vrf1
 ip link set dev veth0 up
 ip link set dev veth1 up
 ip address add 192.0.2.1/24 dev veth0
 ip address add 192.0.2.2/24 dev veth1
 ip rule add pref 32765 table local
 ip rule del pref 0
 tcpdump -i vrf1 -c 20 -w /dev/null &
 sleep 10
 ping -i 0.1 -c 10 -q 192.0.2.2

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 6043e63b42f9..43f374444684 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
-		rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
-		rcu_read_unlock_bh();
 
 		skb_pull(skb, ETH_HLEN);
 	}
-- 
2.40.1


