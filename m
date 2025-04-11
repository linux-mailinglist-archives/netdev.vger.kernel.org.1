Return-Path: <netdev+bounces-181681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63AA86146
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352B97B90D4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C52144BB;
	Fri, 11 Apr 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="rUzv5Z+j";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="HT+/EKu4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306520C480;
	Fri, 11 Apr 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383905; cv=fail; b=gwYCM41OZv7A+zLjSS3r0cva4vjYgtTp6w8/5mJJPHQUgCDFBn+31JxcCV1dIb6f1GSJMfS3wEuZrHXkzGAhoC6qQ0EJc6QXQyyMeyBGnAHOvOvgdbdpIQPFTkD359dAE9UT6Co3QARO3qCXQJtiUfGgR8oy72OGqp4qmutPWwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383905; c=relaxed/simple;
	bh=D4y4BB8xV73hP8OwQgHrdUjSLomI1Ygyp8e7qNytYhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkWiAuuvjVWzZq0EWObRnmcKtgNCvqoIGdWcaZLvd4sBSJiIFiIh+CA4/uIulYzRajOHBYqsYLFLRzI8gOmO+Qz+PQ3pxNZeDLj+5OFfQoJHl3psp+jkWWltodNCAq6p5Fu0JkD4xtPYFzVjTGF007rbJfSjG1ZtGYLQxAxX108=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=rUzv5Z+j; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=HT+/EKu4; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAq3SS023499;
	Fri, 11 Apr 2025 10:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=Lb2Tw
	M/gevKvyXsj1jQgH14jD27m9yYXBg8xFk/nR+E=; b=rUzv5Z+jECVgxR5O1mSud
	gT8CcbSg6RxV8YjtZUOJVFImSLGR28kILpq+RK/p6wilx+e122XhJAbu06Nm0L2K
	pwG5M0AKnQIWUAdn6LbypNVytJWWdueITeZ/j5NAeLtFqBUgXpl8L7jy2oYVSc2F
	8jaByOVerjPg03V5cj/1zhTV68nonzh+eXBquMClznkt5O4gwo6oz/ikw3dje4Gj
	L/53CQY+DYUECm4ptcXtkDBrTBI2zHILlQDTht1WwgEaD49LImtyXpezKuLPjV32
	pNgqYQ7plcUI3r+klZTaPuVA+SHl4hi33bzrKqNJT41ZZF4ZlKqAAcafMuR/tvnq
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012012.outbound.protection.outlook.com [40.93.14.12])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45y1nr0egv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:04:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc8ZPcX/HnFfpyanOG0sShf+Y1hVLzMdR4NJMcMH/29a5Hn9EXyoEIZW9TlYohFZUSP3iRAJYpTJQx5AM3EeU5wSTD2MTmLQWH8vGAAmMTNmOQJAA6wl1oB4kte/SPHuG0mmVAYrragCFeXrbQNe3DqmfHcFG4SRti8xzaZm5bk2Y5i8sXsYCfwSiuAUo+f4Pm1BP7u83nUFnlS6Oh6Kq6j7ukpnPS7wu4cSOJZ1Q6sKIuthl04l0XKx/iLksW+pDFiuSTLbYmNLIp8NbDF2Ih8oy9hKeBaB6B5L1Gpo5Rtt+CIAawWoIPPtbWb4x5WxjO0lY07EdVW/+WOK3CKE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb2TwM/gevKvyXsj1jQgH14jD27m9yYXBg8xFk/nR+E=;
 b=x0EXkw7W0xWZmTXG4vBtgA3hOQgRSYMEPzQIu0+tNVzeo1vc59kxYAeAqx+/n8Ysbe4ogs2ibgy85+O/YsDlkzQYSRBAaOLKWRH9AkipqgUXCHOa1ZHMdGtlh2BmPfttYjFdXx7fVaCCJF0yIBW5SPA0teYchwAi5Bvnr0hFjz62nmfD/HeeUxk6N9e2u77lILfbE7oWnbleEHcMRn7kixLSttZHXH3aL9FowGtaVvyqvZIpwYBHEKKWK7VS/RhI1N8Sgm5RInyvUmsYBlZw/G5zWpkc1Yt8kiaqZ/GKkjVek57UjXUNEEyO6RXcrIeUbOElZAyhiSDPMBVaXVgoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb2TwM/gevKvyXsj1jQgH14jD27m9yYXBg8xFk/nR+E=;
 b=HT+/EKu4e7fGzrQRiMUEAg17gylWJIJ1G/6MaYZBbHfprd5kHGsMxJEg/l9nnPs6mBJE2fEUrf7Eo6DJI15hek7hUg052ejf6/W5UKrPB9i1LMsBMuEFl8CfSKKinBoER+vLYJ3WDuJCB8MAEyn2bbCCoew8/uveGdJLWyoXM0zY7spUzhc8Vrb/Hse3hyfVr4wDFE3aBX90EKbC1otxyDzJTt3QnOxnlANAyL+qdm1Xc3ZjGhNmf+eTejVe6kPYJ60fbGDsa9Jrajp5Zzjt/dBEgesOzQsbkYDYPePS+AjvT+dYhU6y2iUQq2MQ7aIFHVUK+3F3tsPwTFKL57R7hw==
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by CYYPR04MB9030.namprd04.prod.outlook.com (2603:10b6:930:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:04:45 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::fc) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 15:04:44 +0000
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 10:04:29 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 11 Apr 2025 10:04:30 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Apr 2025 10:04:29 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 10:04:29 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v5 net-next 3/3] net: bridge: mcast: Notify on mdb offload failure
Date: Fri, 11 Apr 2025 11:03:18 -0400
Message-ID: <20250411150323.1117797-4-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
References: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CYYPR04MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bde208-49b9-4342-8581-08dd790a31f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGibd1Vh0AE2im/wpO3fY7AazbvrA8iE0ngewhT6WEUrUCktlv3pYauDY4/F?=
 =?us-ascii?Q?1aIGydSU7n9jpy8f7RqrY65lmy093kB15+bK1JOdBCEa/RBLPRXNI8UmtTHN?=
 =?us-ascii?Q?hQZxSDEe4wP9uO/npURd0HtEQ5MOf8fEQcJyjud106YtIVMoXQZGhUs/srwd?=
 =?us-ascii?Q?4fa1sZwb4K3emn/oLoOl0JHuUfNqef4PBRtOd6lZubROZj0iP1+1/GfLniCh?=
 =?us-ascii?Q?RtMAgH3RFNZP/tRn+lCJ9zqpZ7iK7trTzzdnpsDeukqqwuZBcRQfySMEMx2S?=
 =?us-ascii?Q?/Uypu8KAJvFt1DCaBwWA5XRzJI3ac1zgcHfNdwLhM5PaK6Lq+Aj33iL/IX3l?=
 =?us-ascii?Q?F5LFPeyKhVbKMKT7F+aIM/ku0Yrtv8fVas/E3pbzPcpUJk3EcjzJiVGkf+wR?=
 =?us-ascii?Q?vFJCC38vw8jX4UKL5Yjl4ffho2DTwHWyVgbimg5GA8069NzU/3OLMKOty/or?=
 =?us-ascii?Q?U/CxaDWedfYNQIazIuL+cd+uEQqS3DTjyFAKzWXCs4FeGsdD5oWT7liVFOvR?=
 =?us-ascii?Q?RMfRfHYFiOkyNWMZRsdI8vh88Z4dDvdAQDPUXI568Z8Cx89OINlvYXxWREGT?=
 =?us-ascii?Q?Jy0vcXYLRCQzRwaPPUj24fNH49/6EDRShWhiQQSo4jyOFoUYy4N6syZqWoEn?=
 =?us-ascii?Q?3f7/b6y/Gxp4GQmpMGUBNFo3CCkiqmVAjCKhhb1CU3tv4r5Fz0YnQQz/0bxX?=
 =?us-ascii?Q?f9H305bSx/UaZggOYJT2jagP9TYy7/zghOMGOacXsTNjr7duy94zgNDJdt4E?=
 =?us-ascii?Q?d5IM1hkCobiaaLgrl+lFV8kBv0sAklpK/fiZOlfwBiUND6QYtSsxdbILwv4X?=
 =?us-ascii?Q?fG4pwSXhXuHgy99RmDjuq7RsAIkqueCNpOyw68fNAvu5IxzkuePmV9gDoVsn?=
 =?us-ascii?Q?jeep4a6WfJzOFOXLXK75psLvwDcPOPkPdJN2hCUO/5DaLy+a1oIJ+KJmoSSl?=
 =?us-ascii?Q?PZ2vP5W/5GwK+h48UXhlVYRcNPv8+UImeOOXAwXRIDSDk1omQ8h/pI1KKzsi?=
 =?us-ascii?Q?HaYLokDBRoOvI2wuYbifq545Ge7vYwpiktYDEUw4eEp2d2e5D+eDgmRtAf2e?=
 =?us-ascii?Q?x//ocljKmkepvk9Iam06aa+2L43ruS4STo8XxQt0SInLumMxk46sfFZKjgK3?=
 =?us-ascii?Q?v3TGDc1xMWDSWA2CjRS4aAwWkeZY5eNaOU16CpYnKAvp8/GNbJKqFoWxV0sa?=
 =?us-ascii?Q?lcDar5Fp11dre+JDW8fwkwIhQh62zKnWaD5plTZLgbi+tMBqEpUkJFnDGE+X?=
 =?us-ascii?Q?SfY/zt4cpC2XiYqpDK5/Vlq3htUYzBg472YUFbmn8hX5sZV5idhYfdlvoMtd?=
 =?us-ascii?Q?j3eaSvlW85Cv1iX7Ombruj7rFu0QOHVeeV9mz74txlxWbmIU7rN+eIxsM3kw?=
 =?us-ascii?Q?W8naTztS4vJZgx7QH6xbFYoYjRIiF+hu38PZ+CCYSEZoYf4IJ79SwJnwRMgV?=
 =?us-ascii?Q?KpDwj63zabjLrmZuZGj7SR7y/PCpcu9UonnEvqDhep1Wl9R3M8V3soIKAFVb?=
 =?us-ascii?Q?IFUShgGtXGnvZ4pggEotu9L3e4ItgbGqZ1jE?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:04:44.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bde208-49b9-4342-8581-08dd790a31f4
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9030
X-Proofpoint-GUID: HRIvPzKVfDFfbmSfw6gq8nPaF4CFYq8X
X-Authority-Analysis: v=2.4 cv=K7giHzWI c=1 sm=1 tr=0 ts=67f92f90 cx=c_pps a=rJOuE113HAlAKDwVaFkQAw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=LF5D9LMcPqa3_lnOtKMA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-ORIG-GUID: HRIvPzKVfDFfbmSfw6gq8nPaF4CFYq8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110095

Notify user space on mdb offload failure if
mdb_offload_fail_notification is enabled.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
 net/bridge/br_private.h   |  9 +++++++++
 net/bridge/br_switchdev.c |  4 ++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0639691cd19b..5f53f387d251 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -519,16 +519,17 @@ static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
 	       rtnl_mdb_nlmsg_pg_size(pg);
 }
 
-void br_mdb_notify(struct net_device *dev,
-		   struct net_bridge_mdb_entry *mp,
-		   struct net_bridge_port_group *pg,
-		   int type)
+static void __br_mdb_notify(struct net_device *dev,
+			    struct net_bridge_mdb_entry *mp,
+			    struct net_bridge_port_group *pg,
+			    int type, bool notify_switchdev)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	br_switchdev_mdb_notify(dev, mp, pg, type);
+	if (notify_switchdev)
+		br_switchdev_mdb_notify(dev, mp, pg, type);
 
 	skb = nlmsg_new(rtnl_mdb_nlmsg_size(pg), GFP_ATOMIC);
 	if (!skb)
@@ -546,6 +547,21 @@ void br_mdb_notify(struct net_device *dev,
 	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
 }
 
+void br_mdb_notify(struct net_device *dev,
+		   struct net_bridge_mdb_entry *mp,
+		   struct net_bridge_port_group *pg,
+		   int type)
+{
+	__br_mdb_notify(dev, mp, pg, type, true);
+}
+
+void br_mdb_flag_change_notify(struct net_device *dev,
+			       struct net_bridge_mdb_entry *mp,
+			       struct net_bridge_port_group *pg)
+{
+	__br_mdb_notify(dev, mp, pg, RTM_NEWMDB, false);
+}
+
 static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 				   struct net_device *dev,
 				   int ifindex, u16 vid, u32 pid,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02188b7ff8e6..fc43ccc06ccb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1005,6 +1005,8 @@ int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
 		   struct net_bridge_port_group *pg, int type);
+void br_mdb_flag_change_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
+			       struct net_bridge_port_group *pg);
 void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 		   int type);
 void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
@@ -1354,6 +1356,13 @@ br_multicast_set_pg_offload_flags(struct net_bridge_port_group *p,
 	p->flags |= (offloaded ? MDB_PG_FLAGS_OFFLOAD :
 		MDB_PG_FLAGS_OFFLOAD_FAILED);
 }
+
+static inline bool
+br_mdb_should_notify(const struct net_bridge *br, u8 changed_flags)
+{
+	return br_opt_get(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION) &&
+		(changed_flags & MDB_PG_FLAGS_OFFLOAD_FAILED);
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 2d769ef3cb8a..95d7355a0407 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
+	u8 old_flags;
 
 	if (err == -EOPNOTSUPP)
 		goto out_free;
@@ -517,7 +518,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 		if (p->key.port != port)
 			continue;
 
+		old_flags = p->flags;
 		br_multicast_set_pg_offload_flags(p, !err);
+		if (br_mdb_should_notify(br, old_flags ^ p->flags))
+			br_mdb_flag_change_notify(br->dev, mp, p);
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-- 
2.49.0


