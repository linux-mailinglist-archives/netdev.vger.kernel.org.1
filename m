Return-Path: <netdev+bounces-17603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C288D7524E7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D711281D10
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3118017;
	Thu, 13 Jul 2023 14:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA9182AF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:17:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60885272E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoxHOK8cWtQfqLnTuBLqYkmX0OlstmSP0M8E/IrwTaa4m46nwbWXtij5ErS/WQCkREg7iD63o9YJv5T8l6CCnCpz2GNzuesvQEa0mMKZ3rV0gQjK0XNfPjnqYrg04VjqrVtj1LGaUIvuHAPSzqbbOez21BR9iAgvFczFc/0quxd8TjJ1ktFr/xsA5mQvlcVBKljoCEBAGatk/CtNOhINkMO9F3nDNtJUjBzeRJ4heyre+dx7vcqJpqoRQprRkEoTQ1M44/EFO+z6LSVguUwAh6Q+BgvYuC2+dnkKjfXOr7VSZ2fWYOml4sIXCqUxB5Lw1XUL59Xxi5D4Hn8x4/Dgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVXA4saHfxsVePY77buBLo5Yp+kpuC28uWNDgSAwycg=;
 b=oL3Z2awzWEeZl54ftSfrctLtFMEb1h8zjDRX+QBRIVbweaQMUsKV6ra2UQ617m+IvVAn2hMczHh56yQcm17dAp3pjWxwOnvBt/6tzBbfEYUvPdSCDMhDvyRjxdJoOJ54SmOLtNn5cWvL8j8ZJ6tebKXaTuatPii5e+k6FjFEgLdro9lq3ib6d4ROmpnR55dhy2LxRHf8LP8fWd6KgEY3Vq8/egAqk6EhUB74dJz5lAgvjOvxrisM0VGVoP/o++QOuh+Z8AzsmLg6XM4ToFfq+ClIsUNpbdqHjw6jeQtQ8lk45g9Ms4evrsLFJxdbvgdzA4TAo6nu3v9m0kR6YeOA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVXA4saHfxsVePY77buBLo5Yp+kpuC28uWNDgSAwycg=;
 b=TYc9x9mrw2/kS4ZnSRz/zG/zlNBfshl5Cy6+U/jJB4VVasmdDSUXQesouBHoH22x0oNQlvfOajUzBqbS4RE6qbUVLf/zIVaLBv/63rRYIq+k13dfjpL3znd5fdkkgSPzwk91GrbgkMvWwZaMGd0GmnxoqbNAY3n4t5pVmdJFQxGZF90t3hJNNvgePdRcE08rPvEWE4gNC7fS07i1LgvTOujkicuhO3CM4g6XKTV4owOv5BI3XEEPHdGMmSdh5CoTpIz4F7OjHXeZ8kfICps2kAQt9dGcRcxmfyyJMFSIorBUnh3lRljniX0fjVJu5UvfRswB5EEBA60NnSA2hhmLuQ==
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 14:16:56 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::e4) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 14:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 14:16:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 07:16:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 07:16:47 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 13 Jul
 2023 07:16:45 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next] rtnetlink: Move nesting cancellation rollback to proper function
Date: Thu, 13 Jul 2023 17:16:52 +0300
Message-ID: <20230713141652.2288309-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3446704e-104b-4a5c-e0a6-08db83abd056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1lT+3E+M2gwgh79xaERXa5TmN9k8oHpWUTANJD8okxuh599jZjMXeqNmHv/Z2k3MgqBQ4hAXeSar/D7JkN4Pl4Z4iHo+Dxn0DxqzjbYujCu3yQBuHjig8ncwjVS9xR+sXdCYRcXxW6O+LCz+hYE654PdjeV0g5G1fnXgAj7CMFiRdyIZnZNvd4T7EaUViI0gtLPvV2dQi1sZkUSRlyG0uVjVCa8SeXw7IrE+iKjqVndQSTLOX9WsW69UVEWq4PWKdXH6OWjT1yEe79q2rZSJ5/aF21pxIWaSvA7rxsBGfsO+q+jLGNn0tDpevObkX/SOhrhEkLqNG4yDbbLFwhkk3cQGh/4BkaKGCD4rZUSmqtxeqTZqFDIUv3ynD7YDu9+kGbO4H0JsE46WqLPb2OGKXLK7C2nes+bw0ZdSSJjXKkmk7aXXxV2yCatY7FPwf3kSZPRg+Xxzuzr+zYF6+tNnkvl35ybyrwVuTHivOuAJDYqbCjhy6LuZAlGel6JguNVBn/iRIv5i3xpLvSpnUU5Wose5rDRZaTommlzby5giuDprxOjFSbEZQkCIzDTOC071lieAi/xFVDHJvYmKzwqkRR9xW/OXpfiJwnfptAxcfof33+QglutNkn4U1Mg3/U884Tscxv3XPaHX5uBZq+7n6C5LePORaFdaXaJhgWWSFvUKMn4QcWkskUzNIRyMvlK8YS0kAjgnXQirYOZz2IUdyx6HwpnmO5gdoOqPlE+llQOEToxQNpGxm0MbIu4/Ae0
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(82310400005)(86362001)(40480700001)(40460700003)(7636003)(82740400003)(356005)(478600001)(110136005)(6666004)(41300700001)(8676002)(54906003)(7696005)(8936002)(5660300002)(2906002)(4326008)(316002)(70206006)(70586007)(2616005)(47076005)(426003)(336012)(26005)(1076003)(186003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:16:55.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446704e-104b-4a5c-e0a6-08db83abd056
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
inner rtnl_fill_vfinfo(), as it is the function that starts it.

Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/core/rtnetlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3ad4e030846d..ed9b41ab9afc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1343,7 +1343,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 	vf_trust.setting = ivi.trusted;
 	vf = nla_nest_start_noflag(skb, IFLA_VF_INFO);
 	if (!vf)
-		goto nla_put_vfinfo_failure;
+		return -EMSGSIZE;
 	if (nla_put(skb, IFLA_VF_MAC, sizeof(vf_mac), &vf_mac) ||
 	    nla_put(skb, IFLA_VF_BROADCAST, sizeof(vf_broadcast), &vf_broadcast) ||
 	    nla_put(skb, IFLA_VF_VLAN, sizeof(vf_vlan), &vf_vlan) ||
@@ -1414,8 +1414,6 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 
 nla_put_vf_failure:
 	nla_nest_cancel(skb, vf);
-nla_put_vfinfo_failure:
-	nla_nest_cancel(skb, vfinfo);
 	return -EMSGSIZE;
 }
 
@@ -1441,8 +1439,10 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
+		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask)) {
+			nla_nest_cancel(skb, vfinfo);
 			return -EMSGSIZE;
+		}
 	}
 
 	nla_nest_end(skb, vfinfo);
-- 
2.40.1


