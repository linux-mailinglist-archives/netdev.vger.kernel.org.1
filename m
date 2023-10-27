Return-Path: <netdev+bounces-44828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B97DA0D2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2636F1F238F9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC93CCE8;
	Fri, 27 Oct 2023 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b/H3dQUQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835473B7A6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 18:45:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54787B0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 11:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1BJyr023Obz864HBLQSgSAPGMaJxINAZwIpHo8NGJrpcvQt/SVRKsYvsnsXsgqfe4VTAgZ759nNSC/KaozTMFREZ8GCc527ycg+gjbvmr7hBClVH/uU8ccw6leFVSSa6t54HIPOlxPOvmCQtbct+acxZQywFfH3TEfiovR5MwXDnEQTpAxcH41f/n3FO9w5BYNJ78CrWMpXMJMyHRmwB1rq0iSW37lZf+VgizowQqeanMM4YL99euQy2DUR9q0MGdCY92rL43QsiYOrIhUnrnACxNL+oGvd+NDBGVWCP4+BOKmNwsw6hqxwxv5oPY57j7YX4oURIIAwG5QvYsVYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urRBZH+zIkQOtVratt676Fw+qpMKdA9lv7mo18OIKSc=;
 b=fBcHA1PP7HSlJJMjicjYX8r5H938oK2ePD79k8q1STb/feqcxIp9tMAwFo+dTLTfq63D5o3rGLadEA8J69WmACPYSpkNEFB3o+TZ+6e+yLpw86x1J+ZyU+snla2p+ELSI+W0o/UCjJY0K3KpXYa/dr7CB+9HqTERkzFuRi/6fPvPNivANnQWRVO5JazunKATJAljK8XZTzPHKUnf92pAwL1ZNDjiX+OuKTlhTXPcPJUyLcxU42hTA1mKNHmBGBhW6mXL8iew1jnKyEUOS3s2Acl4xU1Oz3Wh4Oe7GMAlxDAZJAEESETe5L7OdiprClzFDm4ZhJFubpVVrvrDL8LDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urRBZH+zIkQOtVratt676Fw+qpMKdA9lv7mo18OIKSc=;
 b=b/H3dQUQanIAPUBsYB3eF2eXLVlYt9S1wt4veGxWcmVE0HZETfvx4OK25ntdWJ38tr1KjZdv/saQabrSqEqQTGGz8pYH0g47N5DL9BBCQ/AIZ90QfPp15lM1eO9CsSBdUpsTFlG8WrI+NezJi0APQ8pE6OLQauUA/PBzrCYpUvCe6wyNbUgBh6W6x/lT8vVY8Q4S+rNfnFKg6NdUOQ7oU1drpBLLnTgMC0oJwiq+OWNL/UR8kiBEb62LlaqRmrf2jzNLvqkgfOLGRasdAUwEj3sTT21S96BjUkvlCElp6Jsls5EngKdWflLp6ik55bZzPk1GTuaikv0bsEaLssLB0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 18:45:46 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::1453:2000:9f9:f370]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::1453:2000:9f9:f370%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 18:45:46 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jiri Benc <jbenc@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Gavin Li <gavinl@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] vxlan: Cleanup IFLA_VXLAN_PORT_RANGE entry in vxlan_get_size()
Date: Fri, 27 Oct 2023 14:44:10 -0400
Message-ID: <20231027184410.236671-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::19) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ace7a1-cc9c-4118-379d-08dbd71cee98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fn7f3I4P/l1tKoaUV6sfw7JMI8FrxWGsB/bUxlcp3tBoyKsB8R0QF3x+gV1ejlZb/WEsXH++oF+feONd5cIxmOj233YW9ll8T22pDZXNVcR2xYJx2+GbAg+s6/fKaQcIWgwhg3X9exifq8J06oFMHlScwdSQ2jnma9b+y3wRinHzVnQdS3VD16t10UF4lpMNTccIhIGOktHtk0x28bvmSERgt3ojbPQQEw3v8LDs3s1espE/E3HS3PYuPZSrokQEHSGEvzb9OFgseg8jCpL5pcY+baQSsFqWWRB2vRcU71YF3S8hrAsETQ+JTRR6hd1BvXFK4H4mS+dxqHAKWizKUh6tl3z+CRfIqhi/jOSBZ8Q/KycD9ZcXUr2cU2dD+dAouks0zojzDGkZzSKnTVlhwHLDUbnxKUK7WMPrPVylu6H44ETzic5Qw9yiFiC12lfScynWEKnJz2n4SdIDzOun4TfPq6CU8CG0lItHPQ5wXMBgNJ3Sig17laR5QWdCKJotCKEIYx6cNqZKEP//pbuh/ybP+xA5yvWnAtO8wyzKvzdVQ5kHRxq/aP946RkpygI3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(8936002)(316002)(6486002)(478600001)(41300700001)(8676002)(54906003)(66556008)(66946007)(110136005)(66476007)(4326008)(5660300002)(26005)(2906002)(36756003)(86362001)(6666004)(6506007)(2616005)(83380400001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ycuT5I/j5/O0j5Nzoe1+emEVayYKWxtQDBzmOfz2w8bcc4eoF0YO9fe11t6S?=
 =?us-ascii?Q?k4ObsNjMrLorbBf3o0VBEpNBK8VIE3wp32uyBNiSzk74JGNqGgZ5JX6HG1g7?=
 =?us-ascii?Q?ynIa9FyhUOmDjKF03WQUMAcJzWJlxnl8BLuxpuHy2jkqqA6sQNX/ZAOuyPcq?=
 =?us-ascii?Q?V6zcwAEkl0xXGZIeDTvtgY9nXQGz1XzYgPmNOiMWVM5hPbdoDPfMuWcmvfR0?=
 =?us-ascii?Q?i+tlk7TEcfrExxnBijYiPG1tkMo57wVOfo2HHiX61vpELMtm6/NSEAiXjdtb?=
 =?us-ascii?Q?gb2T2RZ7AOr8Ns6U5mp33vZ0E7YkBnGe5rt892NUlwMIMs4yU0qILvoKZFLI?=
 =?us-ascii?Q?72Iv2rBal/sZ2CjhPnPCCWxWJykzbik516RYTELOyKrBV7FPRDbCWCUpysAF?=
 =?us-ascii?Q?tY88nGJ2bh6QWrVx59DldIUXK3XYvibNEPO8cdl4A/06kmF4cMReVnWsBScX?=
 =?us-ascii?Q?1K1MzdDQMOkDs3moLxs7xvx81MzA9a+v84n0MSojso/io+/JqgV3amqwboEf?=
 =?us-ascii?Q?jsmeK2Vkko0EvSOuyWFTYFfIKMxTlkOo/vaYsJAvhkEywklfsSJbmxKIYN2Z?=
 =?us-ascii?Q?z9nngqSot/ywGgjQlJxdDvfCmHGWZ1S2BTMJndjzoprbXka88H3ULcgTC27s?=
 =?us-ascii?Q?+AedhXQH3DQDH86oo9UqBamg/om2HuJ5X/G8UALV5LoJEo8+CTTwFk52IRrR?=
 =?us-ascii?Q?lLE6V8idGBnmy+xffcqoFkDTRH3K2gQA0q9ZeyI3jE7pWWCNK0GJtLoZ4pHc?=
 =?us-ascii?Q?ZXgKJ1lcNpQ0nEdLMlDZU/Wab1l0zfM9dy+Nh0Zrr9DgFlVjwCpsrrB+9n2o?=
 =?us-ascii?Q?QVhwlqKVKJkyLLqhIAwP1OlwAqfYkJXiGtYQ5OYiBFyyCnHd5H7mrdpqAmm2?=
 =?us-ascii?Q?7HP+jzlBK/hCG6DbCfddZjehVufUO9PSWoTTU8kTIEN66bzwrmsgcz/KF3p9?=
 =?us-ascii?Q?iqDw9M7ehQs0HuiNcBj8UXipAl1b7k3cdatgPIa9OgMXzSqtzzzVUTDWkVPy?=
 =?us-ascii?Q?2CwAQwaBV7MpUA91Uj/g0PaxxPKvp+wBxd5q9sYuSXMUq3HVTu3NCkdakpau?=
 =?us-ascii?Q?mjt0hqqQ4sGOsvAoFDzAIH+LwmxlmUwWf+LfJJYETty/Vs+ZrSw1Ft1UU3Y4?=
 =?us-ascii?Q?Wm3mbGlJxidYW4CtQWYMlqzrWLi92FSg7TTWIAsrWEPtwzSRS8LfbuMIj6nJ?=
 =?us-ascii?Q?GME6Q0BO9xLCGbfpfgPpmvGX9HgqV6nuWFfda0Ptbb60cLgMYeiU6kyONcMM?=
 =?us-ascii?Q?7KWp0vg27Hh9XRVC4qkTNcCgkfpwTk1dpjAIRp9OaKJUv3LZXh5p6+oRZyt7?=
 =?us-ascii?Q?wtgX03BR7pkeq3muW4Tnej5Rz6qUXJqKfsWrEy6lLpANRX/gc4QuMGbJPrU0?=
 =?us-ascii?Q?oTWVdT77Icf7yzF7yivaod32gWLEvOvLCq/lIrxR3a0qZ2LT1gamZl+9aVuY?=
 =?us-ascii?Q?H0iIYOE1xcBHlNFuxxTpPA7tPGZpoeTwihMLnKYmxy9x91QpcYXEltS4GzTx?=
 =?us-ascii?Q?kJSKV5ggKDyomd6okpTaHs/H92HthOkzz1kZ7rMCTlV6z7yzhTygXD6EmHEa?=
 =?us-ascii?Q?etCt3XkPy8XVZ+uHVMgewo8Kwg57hWNcYToU3q8m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ace7a1-cc9c-4118-379d-08dbd71cee98
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:45:46.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4FaPDwVWsw/csiFePb0VvoGNufJNfS5P2XB3BhBNZKF8kXYQBtcr3HZhzdatqRRbyH96p9S7UgsEQTO1HcyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313

This patch is basically a followup to commit 4e4b1798cc90 ("vxlan: Add
missing entries to vxlan_get_size()"). All of the attributes in
vxlan_get_size() appear in the same order that they are filled in
vxlan_fill_info() except for IFLA_VXLAN_PORT_RANGE. For consistency, move
that entry to match its order and add a comment, like for all other
entries.

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 901c590caf24..412c3c0b6990 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4389,7 +4389,6 @@ static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 
 static size_t vxlan_get_size(const struct net_device *dev)
 {
-
 	return nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_ID */
 		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_VXLAN_GROUP{6} */
 		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LINK */
@@ -4407,7 +4406,6 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_COLLECT_METADATA */
 		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_AGEING */
 		nla_total_size(sizeof(__u32)) +	/* IFLA_VXLAN_LIMIT */
-		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
 		nla_total_size(sizeof(__be16)) + /* IFLA_VXLAN_PORT */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_CSUM */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_UDP_ZERO_CSUM6_TX */
@@ -4415,6 +4413,8 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBYPASS */
+		/* IFLA_VXLAN_PORT_RANGE */
+		nla_total_size(sizeof(struct ifla_vxlan_port_range)) +
 		nla_total_size(0) + /* IFLA_VXLAN_GBP */
 		nla_total_size(0) + /* IFLA_VXLAN_GPE */
 		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
-- 
2.42.0


