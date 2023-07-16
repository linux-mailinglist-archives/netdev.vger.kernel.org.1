Return-Path: <netdev+bounces-18097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F7754D9C
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7391C209B6
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 07:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5C2103;
	Sun, 16 Jul 2023 07:24:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA1EA4
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 07:24:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE11985
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 00:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+vXaC56wKBDUVhReMgSZiie9dbTiYF7DJeTWEHpVhaY43qsqGwXYfGsr+1Lt6aC2DKrUi5n7N5RkYn/bM5euKO5lyONc88bv9pqjbdj6SPyRwjuLiKj+rWSxWcSCJSXknnHn9KPeTPDmzm6WZY7agZIAS82dDngDliI7Kz9QMgKsGW8tzlguNqy7lm4qiyGWeDGKmQ34LYE5AIj/hPmUYs2f1tYpYPadaiTu+YbV/+BBL2qzbtGEK6lFVsIAmC+NcrjC8kX4RNn0tZjd18zqplTeSMM1fKR3z5qogJhkP/V1P8k+BJ1omrUPiVa9s5XIuG6IUzw/J+ivMVAdxRjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqBawghNWE7NU0jsH/xRPuH/HJrassUTze1xIUHk4ZY=;
 b=D0e0mNKamP/KfZtSrTduGj+YrfIPqtIytcIy462WF0wcz7tkM3Yrcbr9NypAwbql3XnnUdWIiSSCr94Lb469SrM/ey9u38U4okNspAxA9zNNE8t0dOUHhwZ63E1T61oBzY9TN7oyC7f13JTD9TcI2qutff0cDDOOkDqaDSb7079zYP5PF7rwkvKMLv/ijMXRcZPk8szVpDisvWv9Oumpkrts3nOu+i11KAn6t4/EnEjptsjSVaO8bkEmcbvN4AcRM9ekDN9641/Y66wd4irwNuXis4HBjxCYYlemxlK3vPHykslN4aL0XxnZoL2Blu1jzY6breo4nMQcuL2f9xog4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqBawghNWE7NU0jsH/xRPuH/HJrassUTze1xIUHk4ZY=;
 b=PGtNXEd2tf/4ZmtRM74dQQ4VFxL+ZUVV7lbog2aOCVaLlrhjKxmftMVXixQnw4JpmbaqMSsfxrg0XMT1AyKUWHxVwAsYA3edQN6/7tJxqLdepljN8hGFnjCJMCKnIGMWlPtQkbeNRAiHRAoEOH99P7xNr+TEntmNaBPJhMG1lUWbLmyK4ihn8mf77GgcpEJ4v2Tcear3S6uSKqizAkXPl5RJtxwgZJED5WTPpcagndr7ol8vTsPJQ0fIkV3hkPXJRrwOWalTwq5iJaBuGKWnHz1j0Dwxa8R2hkbvYeIhUggbGWYZCbVHfwBGwUsVy8l8N+6Ch0S4X9/cTLRXweiRDA==
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sun, 16 Jul
 2023 07:24:51 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::14) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.20 via Frontend
 Transport; Sun, 16 Jul 2023 07:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 07:24:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 00:24:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 00:24:40 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 00:24:38 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Simon Horman <simon.horman@corigine.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v2] rtnetlink: Move nesting cancellation rollback to proper function
Date: Sun, 16 Jul 2023 10:24:40 +0300
Message-ID: <20230716072440.2372567-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f202ed-122d-4da4-ebbc-08db85cdbe22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jB0f9RGhJ0Oxb3PMmoCaa1hFQrLU4NSPBPojxNVyw9Ik0HDHDCyW9+EVq/3ETzKMKnp5TAhn4R1sxHScqBWvekjAcjwd1INAPDh0AfhA2RpoOWeFMAnjeBMPRxdvscYgn6E1KD56MPezK1p1pURHmRvHFMyYv+oS9qhKEkFzPTbj1S0jnU4vzeHHFllukL0KpIKDCf9Aiuo2Q9IAQUF8ACx5EEHXFZHAmPecqAnVggPEyIO9ptQk1f8PWm8TguM23H3UiLwzv/RysI9DqAwNStmaoyOkU85/tliGubpOHmg3x5y++fUoTFyX4x1FT+3vXg2HLo8oiGrmKWQQThVwS7+ubLakPbB4IRRoenUxPCRlVhR8vsb707Xbw9XmztUc3LlWJJYJZUxx4Ik2bKjhMEsgW4Pdwh+wwWd1zRS7P/gcwFZ6Iq4WKq10aUW+yvEAiJyk6N7WluAx8ppcn/iGlyKVG6G9r+cJc6bCfqATbtl37lefXtZJclFxPUPmL8A5xCe4ieYpG+gDrc+3AAkXf+922+En9ZQVAB/pgHwbk+YQnEbYaDpvwnECG7VeddmMtKICbdBORTmhYHGeiPBbPSJOXoMJXQPFS+CHiu69xA9LNKht2x8TXTm4CQLv7u3W++sXPLVVhpaNhFe2yIi5NfCicFtm/e2GwtiboP0jiJdtJ/8yYsUN0eksxRpwn3tfRhAt1kKkuANqXBP6NU6/9aOYujyZynoxUR6dTl93OmSkdtsH++64rp4NcaqtXRVhFsR9vVUXAtpGoHQFkytwTw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(356005)(1076003)(26005)(7636003)(186003)(47076005)(82740400003)(107886003)(2616005)(426003)(336012)(36860700001)(83380400001)(2906002)(36756003)(5660300002)(40460700003)(478600001)(110136005)(54906003)(966005)(86362001)(316002)(6666004)(41300700001)(70586007)(70206006)(7696005)(40480700001)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 07:24:50.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f202ed-122d-4da4-ebbc-08db85cdbe22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
inner rtnl_fill_vfinfo(), as it is the function that starts it.

Signed-off-by: Gal Pressman <gal@nvidia.com>
---
Changelog -
v1->v2: https://lore.kernel.org/all/20230713141652.2288309-1-gal@nvidia.com/
* Remove unused vfinfo parameter (Simon)
---
 net/core/rtnetlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3ad4e030846d..70838d7e5b32 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1273,7 +1273,6 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 					       struct net_device *dev,
 					       int vfs_num,
-					       struct nlattr *vfinfo,
 					       u32 ext_filter_mask)
 {
 	struct ifla_vf_rss_query_en vf_rss_query_en;
@@ -1343,7 +1342,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 	vf_trust.setting = ivi.trusted;
 	vf = nla_nest_start_noflag(skb, IFLA_VF_INFO);
 	if (!vf)
-		goto nla_put_vfinfo_failure;
+		return -EMSGSIZE;
 	if (nla_put(skb, IFLA_VF_MAC, sizeof(vf_mac), &vf_mac) ||
 	    nla_put(skb, IFLA_VF_BROADCAST, sizeof(vf_broadcast), &vf_broadcast) ||
 	    nla_put(skb, IFLA_VF_VLAN, sizeof(vf_vlan), &vf_vlan) ||
@@ -1414,8 +1413,6 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 
 nla_put_vf_failure:
 	nla_nest_cancel(skb, vf);
-nla_put_vfinfo_failure:
-	nla_nest_cancel(skb, vfinfo);
 	return -EMSGSIZE;
 }
 
@@ -1441,8 +1438,10 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
+		if (rtnl_fill_vfinfo(skb, dev, i, ext_filter_mask)) {
+			nla_nest_cancel(skb, vfinfo);
 			return -EMSGSIZE;
+		}
 	}
 
 	nla_nest_end(skb, vfinfo);
-- 
2.40.1


