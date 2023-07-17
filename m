Return-Path: <netdev+bounces-18220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5C755DFF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B8D1C20A2F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DC946B;
	Mon, 17 Jul 2023 08:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4C15A8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:13:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD101B6
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdfs2wb62n3hmIZiasGNfutr/CB5FFWtf9mpDxJiTTQshj6do3R8KJxl9BTj/5o2EXXiVhgA4QfvY3dkax7A+lxUrTyHDsgyjMSBEfcX+j8mEa4LYJUYS/uFtQ8YteUAEw31V0fL0fBVG1rDYuY7tFNbben9yhcSrHud4MUcJMzvZZpkbz4oBcANJhXw7h+6EFrwkmi9NeBs5lIm3AXoxsBEK5lW/QQOHMbRVrThhwtIfu4ZvgJfWKmSu2msp4Zl27JUPcU7IWWrGQSOXgeiGv5L5kDwtSDLJPn1Kvfit5QzrJ3aN7yz7tIBkbQG/i2bz7ZqbS8poTXFhV6J5gBDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHnrAb6jHBkVv4Flz3tgHmHWAuQ1pTAPUlLP8SHsiUk=;
 b=X2ShIYdUDV9lxulNESZ8wcV1YAq48PtI33h8RwZcIgyQ+yKy+oQ/ZoUx+8X2j8Bm/N57hWHpvI7zTNlBBPhh7oL0Hw0LRGOS0CQwaiR7vTSYL7weyjqWJnjGlSusc0UmBfScsrVor3ta8UUuIXAuO9I9cQfSxW+hOb8zd4TyYA9D51RPzvUnJb82P0bZ3aV7pouDT2nkn23p3TDBDtZmTv2UgZcCANmysz/7t8K8edZnKlb4UEp2xKPGV2ZuErEDp4Xq0sw+/CKPicI7g/K6c8qxb9oUha9WA//wx6t2XobG4QJwfEOpkdlMTzm+GXb4qKoUv3tMOJ2vVctJq8vZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHnrAb6jHBkVv4Flz3tgHmHWAuQ1pTAPUlLP8SHsiUk=;
 b=sBbpyKbDwNrTas8RvCGhR9j9wmpBXJUivz9zDWw9mc/AY4Sg+SdTS2/rYmxZaflB7Pl8CzayGkQXCMWudEIaDtS7u10/uS1vAm4qa/SMeehdUvDCBCL8iRH4gAz62+7m7TjgPmbxRbNu42zzannFccM617M3HY0Kcx0TvY2D8NqEpXdikdFwm2wJccKTo3LNahfcR+LlR5gZHPomgn812+JYqvNWd1DMi3+qqgCg3V7tSUA/s8vMK17w+uLS8aA8vkyt4TX8ca6tkBE2R26n/P5M52vX8x8IQPC53za5MFlkg34aitM5F3FlxsQPjqDblGanwQT0v4MCBGwShOEvXQ==
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 08:13:11 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::33) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 08:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 08:13:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 01:13:01 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 17 Jul 2023 01:12:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <roopa@nvidia.com>,
	<dsahern@gmail.com>, <petrm@nvidia.com>, <taspelund@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 1/4] ip_tunnels: Add nexthop ID field to ip_tunnel_key
Date: Mon, 17 Jul 2023 11:12:26 +0300
Message-ID: <20230717081229.81917-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
References: <20230717081229.81917-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbe3cfc-cfd6-4445-f0a2-08db869da99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tw0EddutPego25sjG5UGZdW1SIhgpafs/JdBPXQ5FPfexv2vcl920OTXgpUsoo5gXVDsuzxWL2iMAmnj1VPIJHTJxC7U+7hyFljtM+KEZjD0G7NrRjDWRRELlm2aQqWExiVSaM86RDkY7lPzJl2Puu3AYjTva/EQgAfnHv8BL3R8Z/I5OZq1um3fhhWybl3iCsiX5K0dkdndWmGAwy4PB3tk+Z0kSXikTKfMOwPCNdb7iPndjCcyml0MtVivdbJWMAOLzVWSnUvt4D6nQWpB4QujkPNWPO3VS7F4bJzPGUwFGcR8WK+qDvNWYXGMhsNzBgLfo6L+bcEAhw+46CkkzdsZQfohXyX0D4YTyqHqlq1EDZjL8JMOdA6bNjQN1sOWR+Z9wCRG81WYXMVc6YRt5uz6iXyFtgXuqRdquhacWr+PtCoW9C3NQmNUQPYKaQAShraOZOjZr1/4wJAgHAWeA4mxiux2hJkfGOJx7TbS9rq/gkbP7/7VC4z3x6+vYhOpRUleDLIFWdAyFiKD8L3Ypr1ogvvvj9f2khUnMWnENGssmB8/B6Cl0i/xaCRziNzZCGMTtX4QSeAE/3h1FBOksmw/b4241i/eReTO37d/qqUl76nPd/e9hGKYetznQeyvixKbmMQBzrrNOc3fwR2NWtCTUtXJw2O79XAlMNllcUYEPLoW9mFW87T/WL+BKZx+njN6eSqsN8Hp/n+OAOBDJOci/L2vUpaQuZFnbWLqSZX8uuskx/xH27MdqGlvGd1H
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(4744005)(2906002)(36756003)(40460700003)(40480700001)(47076005)(426003)(16526019)(336012)(186003)(83380400001)(36860700001)(1076003)(26005)(107886003)(356005)(7636003)(82740400003)(54906003)(6666004)(110136005)(4326008)(70206006)(70586007)(316002)(2616005)(5660300002)(8936002)(478600001)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:13:11.5142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbe3cfc-cfd6-4445-f0a2-08db869da99a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend the ip_tunnel_key structure with a field indicating the ID of the
nexthop object via which the skb should be routed.

The field is going to be populated in subsequent patches by the bridge
driver in order to indicate to the VXLAN driver which FDB nexthop object
to use in order to reach the target host.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/ip_tunnels.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ed4b6ad3fcac..e8750b4ef7e1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -52,6 +52,7 @@ struct ip_tunnel_key {
 	u8			tos;		/* TOS for IPv4, TC for IPv6 */
 	u8			ttl;		/* TTL for IPv4, HL for IPv6 */
 	__be32			label;		/* Flow Label for IPv6 */
+	u32			nhid;
 	__be16			tp_src;
 	__be16			tp_dst;
 	__u8			flow_flags;
-- 
2.40.1


