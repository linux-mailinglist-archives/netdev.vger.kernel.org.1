Return-Path: <netdev+bounces-103510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEB90861F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD28289EF9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964218F2D2;
	Fri, 14 Jun 2024 08:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A41836DE;
	Fri, 14 Jun 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353214; cv=fail; b=dMGKqffcmvz1j0G8LKXP1xyGi0m7+avXZS+qkb2xZ6rqJsNEFtpHzZ/0gwuWV7xOODiVj8/kONuSb1An0FHzWu3ye5GMyLjY4gFL8zcnxwzxENpBVmzr06r9aURX84tvhP9N6kdVSV4vxAT9vnsAnl0hLfomoGcy9bix/EBEJrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353214; c=relaxed/simple;
	bh=/FLUZ42IQlFcEjBt8OaAogmSarjDRDNbwGRBW7KI8IY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZVbvyho4fxONUw9/KHYE68Hh5CSS7ijWidmCfElxs1Tz5TBQRfZch+Yu0cOwqRYHer0X+7mY5+eX0ThTQtpoGCIaiD+XH/3Mz6VcHTP2eZe+SBAZHR24kRLMlFD/RQYP2IduGlpf45f9VpViWXm5nPOE1yQW3Ob7m7UggC5sx10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E5PTdS004145;
	Fri, 14 Jun 2024 01:19:38 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymptg5va5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 01:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY76+NT+KsRyBZc8NxYr7PfCITG3yaGlE0AEGnZUawizYNcu79KoeWkp1ea+54pqQ5qMDEeR+m0YnIQKnH76/lopHt53+eX2Gjnacv43u3axWasu4gUXne6FJcCRTRQ9YEIf45R9sQ0gq70mpGcjX3OgJY99nw4F+Gb/YRBl3gq3k3khBmeuR0PQh2C3aweg6dbQfjEw9CbWuyxfytCS6U5FwGpLbRLoal12JeR1yfZQSZXCVwJbuYoHMvUYif1zEjvKkuORdCwkq7P1a0JYeyls/EbYlT0NctuFK2pWGKi19e8EHwyYPl5pLXGuBkxjAAlEWvdx7SZbmfOagRG7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeXbjjTJLlYkneSiQqQsSdiB3YGUapid3QeRajDiq/4=;
 b=NcJlZrGLMJnohi60uKO7Km3V+0yqd4VpRsJw+B3ihTydU2hbeZCQ5wYn8M36tj3VPKH2a/xYLVlOAcsfBXmMHOGCnGaMsswZJU6OqsVnFBkpkzRmxJ5pwPjPZdHRgHweDcwGm/bdbvCRKixm17NcBxbH0y2aopuJRf6TAo17vc6rrWMSCink8YpSTY4ymhIw/Ek5MHMxi4XD2KAd/uL9g/drqdcFqtHsv0gC22BSHz7a2L2o7MWyGRv9CsgHQfBBnSNR81dMvmUAJ65KyT9Nu4G9waM02a4KbOtvlEXXhzVRYCl3UXVIrpjvQtf9h0dAFloF71tz2dc7hnTZu+9AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 08:19:35 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 08:19:35 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
        andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [net PATCH] net: stmmac: No need to calculate speed divider when offload is disabled
Date: Fri, 14 Jun 2024 16:19:16 +0800
Message-Id: <20240614081916.764761-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ2PR11MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: b0747d33-e408-4c3f-f512-08dc8c4aba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230035|376009|52116009|7416009|1800799019|366011|921015|38350700009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IW2ES8iNkJscncCVfgX4o1erGJn2uJ7tXMppMktG9oW+LlVwoV/vXXjhqlpE?=
 =?us-ascii?Q?QKky1PULcLIg5a7eNqb8CYOD/hNg4J1n3kbJLAn8PSBr3lOyvwEpHRe25Out?=
 =?us-ascii?Q?L3rt/eaRjaJZR/xL7Ejuspgjo2rbbdGzrOyZqXdQ/IILVq0KPYOPXdrQOgk+?=
 =?us-ascii?Q?QeXsCdujjMo7bHRpGVvMhsvrQDabdBt4EgEoyFYFI0Id9a8SHjHGVwzeOsYV?=
 =?us-ascii?Q?ZhQrGnS/QLWIs14kki8u6KmS17QDlpLz/jWOUoVmwulXaBYVkSO1WYxGi0Vu?=
 =?us-ascii?Q?eOVzx1/r/NVCRLfOeMPs7b/S6UVuBUEYtYGrSvgcj4sZScoIxwUaosCr2RJ9?=
 =?us-ascii?Q?OObZzYawZod6KRSMQ6j+loB9XW2s/dxAkNcXCQmELCxYHnlUXsOBHTstiEzd?=
 =?us-ascii?Q?BT3K+q153UF9b6LNQYYUd7kjz5JE3V6uRFlnbvX4M5DFDNrHNZgVxGTfPt2R?=
 =?us-ascii?Q?yq58LsYcXy3EDYrZN0GS6u7mF5UMCeCFNMfIP/sBHCxzKNV6JHRBd+RgkVh7?=
 =?us-ascii?Q?zRaOLRAMnWdMLoiYkfxzVgDsynaTJIAVtKvY15As7sn21jNx4r3iXR8Grl4M?=
 =?us-ascii?Q?9eThnrY194wugYl0KSiFAoiYfJnK2zVR02oix0IoTeOlvYOpZ0MhR0Dj3r62?=
 =?us-ascii?Q?tpAPiY197XARgC0seVRvKB6kjhnfwEVSsenNfNc+k1fTo+xaRuCqXy5BGMgY?=
 =?us-ascii?Q?CQWxZLHsZQgUJNmTyrXWYC0tBxS4FDdxiRiTpo7MITgFIJIiZoOJlLqEhl7O?=
 =?us-ascii?Q?Zv07yY/oHcEFDNjLeitPdbKg6pzgZFWEyv72mYWfAEWM6YPeC3FBJ/wNVnuh?=
 =?us-ascii?Q?lnWrOcTapaJMnms/+1BQGaEbZlbcSEXx8pAGkrQf50V3pxJ9H09DsSw5Xbx3?=
 =?us-ascii?Q?MKCFbjlgiKcZzqIAJ9+sqahbTg0QKAt08kH3TAlMLcOzOiPb5Hi8Mrrwmskh?=
 =?us-ascii?Q?cmu9kH3gjbWgiraJw/IecZlxnlhYlyJq6F92dznn123PHxj/8YrgyuZ44sir?=
 =?us-ascii?Q?psv1VJFbRpGEJ7tdNaJLhd98p/AXEc2nbBTR1XHjWe8t3Q3dsG770BDMqUQb?=
 =?us-ascii?Q?9Q6BAiK3GEQShQHandDS0YUZX8zLU65ZJTgDVoG+PVVsBgJ/u2PcPRhRFCH+?=
 =?us-ascii?Q?6ZEe32Bi/yXGrY5aAYqONiwEHc5bQ5XeYMSHzjfxUidFL5/xZSdRDUSrjPJ5?=
 =?us-ascii?Q?BY3gsK85Yh3aa65eUMQKTA5g8orkUQx8UjlgMUkk9ra+FIV7RN8b9dPzaWkW?=
 =?us-ascii?Q?Z7O1oNMJc9MgbC0UXCa/5Ew0EK0vi9TohmnW4Swdd1QEouM3QFXU9ifoRf19?=
 =?us-ascii?Q?e9dd1cJ4RdQwtqj/KIM6uk6C36EkWvGoCYHDnAyfWz50e7AtMuYdZVougcBl?=
 =?us-ascii?Q?UXTcSXMUSEq2oqDheIwTT3ZIqn21?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(52116009)(7416009)(1800799019)(366011)(921015)(38350700009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zYJtoZr8tUkRNtBhiKk9NZ9qJIB1ib8l+y34eYfUsgtCMcVMy1HoMLF1mX8O?=
 =?us-ascii?Q?ai0BHb63skME2jXX/YFq09ImplUf7vWf6KDaTy9c8xx03tKrbTMsoq57vqje?=
 =?us-ascii?Q?Ny2sDt5C9W1JeGDY/QEWO9EaYUZy82meI7+hQGxHyyjK+g+IJdBrDpY2JuWb?=
 =?us-ascii?Q?zZE88Ne88uX09FOLNolZampMSvjJ/HOSTkEtkGq6C2wPTxJi9sTfIqHI2QHl?=
 =?us-ascii?Q?cvNj4zIP/TcDTklfUm9U0g8i29dcpMJXItSXMF1RLeqnBqanGQ7Xadt0zOLz?=
 =?us-ascii?Q?fA2rbkrL9W9YnAO9SroA10O7SeXOeab8xmta2SjHlJVfRZrntWuDXbqkcByv?=
 =?us-ascii?Q?jMaUrATKOa1b935QDzscQztuFLkFZdJeS+PVziIl9VSuv1vn4c+iyTq5Z92P?=
 =?us-ascii?Q?NBcgdQgu67ii6GeEsjnOUmcheCpcVzI8bQ8w0cvJLsThlBWOez7vSrbGlhZ3?=
 =?us-ascii?Q?zOxD429fzHnKS9Gvf6+5Bcj7iaugjyYGpB5F10s7McBqG7U3QNLsSEU2cjMa?=
 =?us-ascii?Q?oy3g1YvPTelmXUgxVEeonzmCOR4EGD+q12D5ZPq/7zbI0pbzzgH4dqbI54M3?=
 =?us-ascii?Q?nqb9p1XiTR1hCYn/5vhSOUwFVwIp4x+oY7DDaGNaFv2VIQsvM2yYUJk834sj?=
 =?us-ascii?Q?KAwAeTv3Haat0wDnj1L7J1hsWY7eLnhVlPza0RNASH3IGXhNVz3kcRJFnKHv?=
 =?us-ascii?Q?qr5XI4KoIx8e9Brmr1Gn5Az1qEB6zYohR1DslGoLltOVAHFCVLseg5+N+cp+?=
 =?us-ascii?Q?iSZsH/8SXWZjux7NkM3y0cHOHk3k923NLU7JSp7L3kpuFK6P65zkmVtK52RO?=
 =?us-ascii?Q?ZjtntzLE613KQ4+bHsPwnvxzp1pznaUJDDixvuoYz7EbEl91FOhavNYnYeY8?=
 =?us-ascii?Q?uEMAjMck4JRpm+iu5s8ew8FXo+MTl8JGVR8Mtkf+1tA6Kq+cjak/vxL1ZsRR?=
 =?us-ascii?Q?N3fz6PCgh/hr4jsFPPQxRjzsHq7yroG015ih8vT7ysg8Tc95wv8hqcQ8VdMw?=
 =?us-ascii?Q?eGShVEUrR8hogzGzQaUUicz/NC6rgW/FTaC+BuBjfGRmbsIcT6nEX7remm7J?=
 =?us-ascii?Q?asxis7ZtVHcOhlXMH1QuUHxwN7bJUXmIcf9LrnheCBF5ykYjgqUSDHOezYuF?=
 =?us-ascii?Q?xUKpFUOrAcUYsc4uCsq0V39k6ELxTCHN63Js1o2YIbpk6RzNZMIlHJwGpJ74?=
 =?us-ascii?Q?V/II4TKUjKyjiYqsdDkq5fGGRxEFa/XuoiSihFb6I8W/O5djn9LTAev/grcX?=
 =?us-ascii?Q?LZ7FRz0iBUsdhtfPjVvBv3eHGS3Xk5hZ7BJ5GYU2/M74jqLC5G2bwGwIy1Xx?=
 =?us-ascii?Q?eI2Dj+CU8GbPwi4jo42gVcFsvc7xR+F9t8XdEpWITehYRow8MlLiC39//ysv?=
 =?us-ascii?Q?x/heoVl7OnlW0Q1ghyeAdSF7g9zvYl1jYLA/kmo/g4QNjRtNTv3LZbzFATaz?=
 =?us-ascii?Q?kRvblOBJ0t6qhxvYo5AKqJz2CswumcDX7RGo/Ff34MQJOMXhrri6Xsnekv5f?=
 =?us-ascii?Q?dos6AEHa1g5c85UgEO6DqDGiMocP3NOrwOmr/+D6ZihM/VtPWrRP1sALySki?=
 =?us-ascii?Q?oPeZVUYepI94nCGvaytkJITZURAvNNL8Q84XyhrW6EVILkpMmxzf6WQrIHv6?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0747d33-e408-4c3f-f512-08dc8c4aba0a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:19:35.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXxS1f0utGAx6HdYwmGa13W8XDzIgjWuny6JH/X3LgT411HQGJsq9HSd0AGf+7cHENQV4HQewxXl83Np9HeH7BaefO8FV2fudkn8rQ7pxOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-Proofpoint-ORIG-GUID: Ym9aAWO3xe3v3zIQ-dwz69WCgpKXDrJG
X-Proofpoint-GUID: Ym9aAWO3xe3v3zIQ-dwz69WCgpKXDrJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406140057

commit be27b8965297 ("net: stmmac: replace priv->speed with
the portTransmitRate from the tc-cbs parameters") introduced
a problem. When deleting, it prompts "Invalid portTransmitRate
0 (idleSlope - sendSlope)" and exits. Add judgment on cbs.enable.
Only when offload is enabled, speed divider needs to be calculated.

Fixes: be27b8965297 ("net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 1562fbdd0a04..b0fd2d6e525e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -358,24 +358,26 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 
 	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
 
-	/* Port Transmit Rate and Speed Divider */
-	switch (div_s64(port_transmit_rate_kbps, 1000)) {
-	case SPEED_10000:
-	case SPEED_5000:
-		ptr = 32;
-		break;
-	case SPEED_2500:
-	case SPEED_1000:
-		ptr = 8;
-		break;
-	case SPEED_100:
-		ptr = 4;
-		break;
-	default:
-		netdev_err(priv->dev,
-			   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
-			   port_transmit_rate_kbps);
-		return -EINVAL;
+	if (qopt->enable) {
+		/* Port Transmit Rate and Speed Divider */
+		switch (div_s64(port_transmit_rate_kbps, 1000)) {
+		case SPEED_10000:
+		case SPEED_5000:
+			ptr = 32;
+			break;
+		case SPEED_2500:
+		case SPEED_1000:
+			ptr = 8;
+			break;
+		case SPEED_100:
+			ptr = 4;
+			break;
+		default:
+			netdev_err(priv->dev,
+				   "Invalid portTransmitRate %lld (idleSlope - sendSlope)\n",
+				   port_transmit_rate_kbps);
+			return -EINVAL;
+		}
 	}
 
 	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
-- 
2.25.1


