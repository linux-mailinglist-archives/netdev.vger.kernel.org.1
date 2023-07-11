Return-Path: <netdev+bounces-16708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B174E79B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5AA28135A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866F171A3;
	Tue, 11 Jul 2023 06:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D1168DF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:59:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68718D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO5t3PMk+0lzXM8tLOKlbTFH3IBKkdXWapAFYZGHjpzscax3ZVQCmDtwr4OVx26FcnNW47cKNLgjxL4NeriSxaNn25MZi5IS7S8UbxM2xkpsktmQb8M6Cbp3IdcdDQ7NB1o8zWfVsPyMv+4ESY15jSfvPUEtSgAQvxPPXc9CpS235edE7hKfkEJn20xdyBmfDzqK4WzjXsIPe0lD6eWVuy3B6TsK7VOQjJN/55OEe8M3KJJDJyE/CxQsw4Xy/DdJZEm4nwvaWHGWGGvSophNIHu5ySBTorEkRU7k2sqCO2eE63Nn0rBqWAu/YMAvFnvZ4IVz2jhm1hYx7qmBh/3nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE9QCqyJVv1HoWxQ6QSXS6tSRPWUp0KgRkfzKlqK1n8=;
 b=ofop49AT1zKrwhF0QliG2oxUI5VVcsF32qqPgItIEnHHwNbw9IrMXnlpHtT4Vy58+NXEnRCW7na/979kd5+C29+ihdx1oIlJHH5otxYRnKXYqKWGLud3Hzsd4yy8NShf78Ho1PgtSFuDYTjNNMLicBLulag6CqdynDPLdaNuKbbo5n5/pkC94R4VOblq3tzmdF0oZdu7+nGz++VeMjXFfY7jnjKkreH/fZGmu0Tb6kdihDk+V/Qr1by/sbFzFzdTWfG+G7F+szH8GZhR8wyzEHlGSjv6PzTT23L2GFzzTZ1uD8LyoORPVzn3iXMpp5bRAjsCjYOuP+nRBbnvKnTzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE9QCqyJVv1HoWxQ6QSXS6tSRPWUp0KgRkfzKlqK1n8=;
 b=R84oNVyH7D3xmRDGvb0+CHLkHEWywH/1UGikRP63AONyxJ3JYiPN9QcZSvA6aOK4S6tketLfGvmhXA5RsULrkJzzyYzqiEtF9r8avUvx4MPGm4WFoEQworkdvDTf1vjA45UHSrnCFqqVlcI+gFzniMlOiGf6o6bG7BLV5L/VoEdUriRB8o66i5gnA71fhFrqndRNKW0Oe9qZNxV9cXt7Hb2s9KXFiqUZsI0GJQewB+woESiE9ZKaQxApoCJpBz8STOeQ+sAYOQIJ+80WAfn8xWXSVcsHTydb4jiBrpivsrPmlF48XfgJgBfrEXTTFd1+2ud2oh63lUk7FHykkoozRA==
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 11 Jul 2023 06:59:48 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::33) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 06:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.44 via Frontend Transport; Tue, 11 Jul 2023 06:59:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 23:59:32 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 10 Jul 2023 23:59:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <petrm@nvidia.com>,
	<lukasz.czapnik@intel.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2] f_flower: Treat port 0 as valid
Date: Tue, 11 Jul 2023 09:59:03 +0300
Message-ID: <20230711065903.3671956-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca8df0c-3c09-4a30-6307-08db81dc6a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NV+NqvqVXbNaWFlWwWXcr7RYoUqa/l6KNjzdLVt5Gbec35yXmk4eWm8nigufKfrrJy1qlJDSXho8Oi7XlgI67U5i2UPG4qPJVgGEG4yPTQ/OLIOghWGO+3DnIYoN8vrl2WYNydwi6B3B/AyRwtKkiZsVfcjdIuc8O7Mq7uvIKtebJ4zCACDBdVQJjSxdkavgCUa+W/Rk/+NwR+pAkvtlOnplNSw1z2YR3Xg7cU6xyEb9JC9BVRFYyfB13HYghixkDtTmgoTnRFynAuHS4qbtkTpGlcPOe+iN0xPs2PM9H/rUVPP3MVUMjDSJ0YrYNv9wG5Ec51mr27/NOWpiUTuCabV1eTI7w2BJ6QSf7udZ34C/S6jsK1uMFaxbkTv2oDePPML/rvGG7dw6xyAeejy2GC80cS5z2q8V6JEEmBIGDNTlaL761yaMmP7E8ZHZ/zxAuZM3cf7yURgZMRyryp/gUMst/+j8udycg1nxVO+2ZCbjvv1ib7BY2F/4t5RTkVXrIz20OTpS1VCmofK6KKk5BPv7WJD5yutKlx9ZLobkJiyaOdpb/Cuqlb1NvPix14uyc4dVnQr24FBh/MZo1MzbvXgI12TMFzjDWqurEuOF8B4l5UCDEkcOEti6RYwAATBHdbKwgu2pJp0vcDr9tQIsPWttM6cqw1xAGU/ISEoj5fzhRr07WkPt3TBFUjbAiISX7+p5MpLuiqvq3JzNOG0+PJbNq5k8gAy+ieKsI7aUTGBEoyUsZEOwW+Ql9bJ+sm1B
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(83380400001)(47076005)(1076003)(26005)(2616005)(16526019)(186003)(336012)(426003)(40480700001)(107886003)(36756003)(40460700003)(36860700001)(316002)(82310400005)(2906002)(41300700001)(356005)(7636003)(82740400003)(70586007)(70206006)(6916009)(4326008)(86362001)(8936002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 06:59:47.9377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8df0c-3c09-4a30-6307-08db81dc6a66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is not currently possible to add a filter matching on port 0 despite
it being a valid port number. This is caused by cited commit which
treats a value of 0 as an indication that the port was not specified.

Instead of inferring that a port range was specified by checking that both
the minimum and the maximum ports are non-zero, simply add a boolean
argument to parse_range() and set it after parsing a port range.

Before:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 0 action pass
 Illegal "src_port"

 # tc filter add dev swp1 ingress pref 2 proto ip flower ip_proto udp dst_port 0 action pass
 Illegal "dst_port"

 # tc filter add dev swp1 ingress pref 3 proto ip flower ip_proto udp src_port 0-100 action pass
 Illegal "src_port"

 # tc filter add dev swp1 ingress pref 4 proto ip flower ip_proto udp dst_port 0-100 action pass
 Illegal "dst_port"

After:

 # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 0 action pass

 # tc filter add dev swp1 ingress pref 2 proto ip flower ip_proto udp dst_port 0 action pass

 # tc filter add dev swp1 ingress pref 3 proto ip flower ip_proto udp src_port 0-100 action pass

 # tc filter add dev swp1 ingress pref 4 proto ip flower ip_proto udp dst_port 0-100 action pass

 # tc filter show dev swp1 ingress | grep _port
   src_port 0
   dst_port 0
   src_port 0-100
   dst_port 0-100

Fixes: 767b6fd620dd ("tc: flower: fix port value truncation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tc/f_flower.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tc/f_flower.c b/tc/f_flower.c
index c71394f753a6..737df199acf8 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -735,7 +735,7 @@ static int flower_port_range_attr_type(__u8 ip_proto, enum flower_endpoint type,
 }
 
 /* parse range args in format 10-20 */
-static int parse_range(char *str, __be16 *min, __be16 *max)
+static int parse_range(char *str, __be16 *min, __be16 *max, bool *p_is_range)
 {
 	char *sep;
 
@@ -748,6 +748,8 @@ static int parse_range(char *str, __be16 *min, __be16 *max)
 
 		if (get_be16(max, sep + 1, 10))
 			return -1;
+
+		*p_is_range = true;
 	} else {
 		if (get_be16(min, str, 10))
 			return -1;
@@ -759,19 +761,20 @@ static int flower_parse_port(char *str, __u8 ip_proto,
 			     enum flower_endpoint endpoint,
 			     struct nlmsghdr *n)
 {
+	bool is_range = false;
 	char *slash = NULL;
 	__be16 min = 0;
 	__be16 max = 0;
 	int ret;
 
-	ret = parse_range(str, &min, &max);
+	ret = parse_range(str, &min, &max, &is_range);
 	if (ret) {
 		slash = strchr(str, '/');
 		if (!slash)
 			return -1;
 	}
 
-	if (min && max) {
+	if (is_range) {
 		__be16 min_port_type, max_port_type;
 
 		if (ntohs(max) <= ntohs(min)) {
@@ -784,7 +787,7 @@ static int flower_parse_port(char *str, __u8 ip_proto,
 
 		addattr16(n, MAX_MSG, min_port_type, min);
 		addattr16(n, MAX_MSG, max_port_type, max);
-	} else if (slash || (min && !max)) {
+	} else {
 		int type;
 
 		type = flower_port_attr_type(ip_proto, endpoint);
@@ -802,8 +805,6 @@ static int flower_parse_port(char *str, __u8 ip_proto,
 				return -1;
 			return flower_parse_u16(str, type, mask_type, n, true);
 		}
-	} else {
-		return -1;
 	}
 	return 0;
 }
-- 
2.40.1


