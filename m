Return-Path: <netdev+bounces-25346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23871773C44
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FAA1C208FE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DD14A9F;
	Tue,  8 Aug 2023 15:49:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6D13AC7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:49:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A39EE2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iykl6YgUsQ2lbdkyWVbqXriEMQD5M2GdNJf1iW+S9XBPIB1aQY/+s44dVFyYKQFPJKCM8xcKEBpRLubhJYHPIbxkFN5Ikd/Og9l8Dm8MNzkVhEMaw51KZNNCK/lYS46Rx8mw8f5KqjEbm82wsDnKjnXZjVX6wfQ1Bb9yQx2sj79BbufpOi0gngo9zU+8M9OOfU+6hg0DR0XtKShUxh69r1Y0XeX/Yb6+589nC+lve9OPsx9M0Bp1sNODkKZcHp7RsBpzuV18AtrzC7OjXHjFxknp5LqbLonJNXQk56RdLQO9BSbyjl8bOenVu5yH3kJUwajoIeo8mLjLZMAhG3VKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6XTyRZg5+Gq9s3cviZUbvRy/U4gNBKh0PSILFlkaHE=;
 b=AEmEYzaxgTd8iN7R/+K2+bQKXNMo0k5DhkbKt7K8UMlOYWxvz2cQNLbdzVV3keRo1LKqow/N3e/7d/f7pCxLkB4HvWBRuAdNi+73J3AIfpALOEnD70XbRqmIVbQvNwQV/0d8ZuKPIrP4neelrYWmYzWguxz5WhCgqPvZbibYwcdyDg/mQsyrDezHEP1WkIv5H+IcJlzdS09Y41LUlZolWtMNEpEZrej9VIpDm/4z0qKBj5OuZscdLrYB4UuDvMM+x3j84H2ViQgGWKREr4WK8LsMqSDWcTMgsmddmeKB0fhMCp2MVw/j33ncD5U47H8GTaYT6T2xkJTJ9l5J7HSogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6XTyRZg5+Gq9s3cviZUbvRy/U4gNBKh0PSILFlkaHE=;
 b=EpL9qYhe2Y4QD2dqkwLscqbSsgfllTe9p+N5YT4AqTUhlIlb2bMWSQU9dc7wkpGaOCjjREZ4vG8mcFgoqwD6qQCTvAgtiMy2lQYe72WgP8a/wEwLIjPkghrJFlWxxzeq+w6gNQboI+8PMbQy6qFEK75cg/tXn8Euo0turRbXewLBhlyENQMah0lRAiPBz96wmefWlmmjKYftGaOho7JYgonIaJbIkkOn+OFXdyHb0Rg8ED8NcKOykFuI0d+1xf3onAU37le/DAP4UocD5pcZcCtSuR0pEsTBIvxjD5PegyB3Wei2+2O5XmbwnjOhvWxx+NRrflnic6cIGe3d4UmWwQ==
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 09:36:27 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::75) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 09:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 09:36:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 02:36:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 8 Aug 2023 02:36:13 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 8 Aug 2023 02:36:10 -0700
From: Vlad Buslov <vladbu@nvidia.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <amir.hanania@intel.com>,
	<jeffrey.t.kirsher@intel.com>, <john.fastabend@gmail.com>,
	<idosch@idosch.org>, <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>
Subject: [PATCH net v2] vlan: Fix VLAN 0 memory leak
Date: Tue, 8 Aug 2023 11:35:21 +0200
Message-ID: <20230808093521.1468929-1-vladbu@nvidia.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 74196ef9-64f7-4485-6a79-08db97f2efdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ts1CMDDAlt49DhTCVXdsKIK03bvoWalmNLSmo8uPhNRwfVECSDNlP1iQp49WkAIL66/q8LkegdK+ek+NaKK7B6NRX38bBQo0pE34FbXVHmON84F+P239d9OFBO1zQN/vgPOCtMGuwaB8YmgW8pGqF1aYcAr2OolVhm7o6sF12GUgLM8CPW3potFD93fqnjkS4ccfi6CfbAT/v59auklL+b6+tlaO+Zj1epb6Kmi71sEyMW3WpFdWvAgVNu5z6vNo3FuiILvxfzKHu2quVVFZyQ0NVAjb0Mc6b3rO5FlX9a/lVeQFNiwZRz9DylAVA73gNni084Mxm+coMrhoyke8hStvwVh1TnQLbUg5o/z0wRJfdscHIDf9MnWqCLXikMKl7Nbe6NAwaE8ccToDPYp0RhgU8ulQC9LNWWxWkU1/KRdiAUmYWnqcquuDomHlGYI5nH8SpdYYVxL+1ELXofDZUmw+Dzec45vHsFHflQH2hXRn+bJsIRJhfMJ7UxW0TbbqCH/XcF52RKgRh6emC3nHUnuYEKR+hrL+TrJDW2n08wWLb4uJHyy6SX+cfhlM9GOUSCLoMaFpspl9ViJ5eyqdbB9zmGb25f38KDmjGKYcuYECU6x6b3pNgHDNlllYxjNg2Vfun1rx4VFrLDN2VXP1VG8+LnX1C85zUNXaPqf2SVAAaev4pG55k4GjOqjHQkjSSOfeYdbeqNjNmF0pUSWkjigQsgZY4e8Hkzg7M/MZ1szhVXhoPHCfkQLFiQc46Rtdr5tO6PFPJ1zPOJanzl64jA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(1800799003)(186006)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(47076005)(83380400001)(426003)(41300700001)(40460700003)(5660300002)(8936002)(8676002)(7416002)(36756003)(36860700001)(86362001)(7696005)(82740400003)(478600001)(7636003)(356005)(54906003)(6666004)(110136005)(336012)(2616005)(316002)(107886003)(4326008)(1076003)(70206006)(26005)(70586007)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 09:36:26.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74196ef9-64f7-4485-6a79-08db97f2efdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The referenced commit intended to fix memleak of VLAN 0 that is implicitly
created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
doesn't take into account that the feature can be re-set during the
netdevice lifetime which will cause memory leak if feature is disabled
during the device deletion as illustrated by [0]. Fix the leak by
unconditionally deleting VLAN 0 on NETDEV_DOWN event.

[0]:
> modprobe 8021q
> ip l set dev eth2 up
> ethtool -K eth2 rx-vlan-filter off
> modprobe -r mlx5_ib
> modprobe -r mlx5_core
> cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888103dcd900 (size 256):
  comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
  hex dump (first 32 bytes):
    00 80 5d 03 81 88 ff ff 00 00 00 00 00 00 00 00  ..].............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
    [<000000002889a7a2>] vlan_vid_add+0xa0/0x210
    [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
    [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
    [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
    [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
    [<00000000982807e9>] do_setlink+0x28d/0x10a0
    [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
    [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
    [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
    [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
    [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
    [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
    [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
    [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
    [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0
unreferenced object 0xffff88813354fde0 (size 32):
  comm "ip", pid 1490, jiffies 4294907305 (age 325.364s)
  hex dump (first 32 bytes):
    a0 d9 dc 03 81 88 ff ff a0 d9 dc 03 81 88 ff ff  ................
    81 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000899f3bb9>] kmalloc_trace+0x25/0x80
    [<000000002da64724>] vlan_vid_add+0xdf/0x210
    [<000000007177800e>] vlan_device_event+0x374/0x760 [8021q]
    [<000000009a0716b1>] notifier_call_chain+0x35/0xb0
    [<00000000bbf3d162>] __dev_notify_flags+0x58/0xf0
    [<0000000053d2b05d>] dev_change_flags+0x4d/0x60
    [<00000000982807e9>] do_setlink+0x28d/0x10a0
    [<0000000058c1be00>] __rtnl_newlink+0x545/0x980
    [<00000000e66c3bd9>] rtnl_newlink+0x44/0x70
    [<00000000a2cc5970>] rtnetlink_rcv_msg+0x29c/0x390
    [<00000000d307d1e4>] netlink_rcv_skb+0x54/0x100
    [<00000000259d16f9>] netlink_unicast+0x1f6/0x2c0
    [<000000007ce2afa1>] netlink_sendmsg+0x232/0x4a0
    [<00000000f3f4bb39>] sock_sendmsg+0x38/0x60
    [<000000002f9c0624>] ____sys_sendmsg+0x1e3/0x200
    [<00000000d6ff5520>] ___sys_sendmsg+0x80/0xc0

Fixes: efc73f4bbc23 ("net: Fix memory leak - vlan_info struct")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
---

Notes:
    Changes V1 -> V2:
    
    - Simplified reproduction steps.

 net/8021q/vlan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e40aa3e3641c..b3662119ddbc 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -384,8 +384,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			dev->name);
 		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
 	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+	if (event == NETDEV_DOWN)
 		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
-- 
2.39.2


