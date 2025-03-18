Return-Path: <netdev+bounces-175928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371DA68001
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB297ABDF0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C82066DE;
	Tue, 18 Mar 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="BgooQe7f";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="bNfXWOe0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBA2080CD
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338243; cv=fail; b=sBgpnz8Qvv6pY0iyMoJVgAQHLjBrBcTwqstJqYk9FZLG/i0Se18QYasz2HgxBVaP8n0CTgn1x3UspF+90IoZyMnool6WkrjG2pdD6uK/GFY7MZXuSGVCgAUF9SgEIh6L01oxmE4a1s0iTIfloKPFaI+zlIJzFx/Z/Mwwb78n1bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338243; c=relaxed/simple;
	bh=CD/e7h2rqx5kgzB52I3gdDNbV0WwZ6Gp89v7jmXcSWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBZ2p6LNQVBaOlpPjG5IaWYhW3NQHG79AGViEYFo2/0+W1iXB1GwSBN9Fejs2U94LUuBB+q1lCUghevUazC/ITfjr0ORIvKrXJybp70ylpNEOE+SSyYKevniGxZCD1gLi93Ci6EQ9272MD0+ANk3Uk74E8AC5UIKSWNi2tWCY3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=BgooQe7f; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=bNfXWOe0; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILlXMp030516;
	Tue, 18 Mar 2025 17:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=OLRbU
	KynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=; b=BgooQe7fzXaW+j78sx7RI
	vJiyCvhkVkzImTogW0luEhKB04KvWPkVxOhbsTCRwUX4J8ZvuT2pnwLMpNowB8C6
	56T9qHkutPRVmzF4BqEPoKx5PdaEnQ1/IZCCz8EBFOFlbXCAfTHLmYGH45LB80XN
	0KMXmVOcJfDjEVFTNm9/+ZzClWBJfGvyTiehMgxODmV6J0KjbwPHIlVXyNbrPPFk
	fsymGkAx6y7Ed8jgpCubZmS5L3IjGiyvckBAEGS9eOGIkiGqvVFZTXzO6CmI9heW
	WAdTlI14LrLX1gweWMFB3HtAxpzY1pQn9U8GFTW+kymrCyYB3kjbOVmL29H1nKEV
	A==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45f747sbu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:50:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBlAunSJLTxaJl7E8Gwz9KcpX1k/+c5igcarVTTNXcwOfHsPW/iF3XpDllB/l755E47Fh2hjmzDrvw26OX6NrW9q/CIfInYgUachQbGlFNPPQ0s2lFLcjDvvywqyI79CavCuyxTn3UkYxcy/wksawPtjXfkT5R7pezsIeqCNoHUgS/jSzvI5c/sJX4TmEmjXL11Nu9i+gb8yf97BmWyg/Mz5yCHZZDK7vcQz+W14fv0H9otA5zUrNByu+cQ+jq0DLDBe0+ppWkPl6gWIyAwWf9M4ERZQzK/mRr5Soelm7zKV/SEAl20ENItbFKAM7bgus2HO55r81PdbbgwP771uQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLRbUKynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=;
 b=ONpHXwCfD3RkBs/wdsxfbfNvQNO7BBRxIPMOFlA8bgC3tssqp2uSoFjon/GQ7CliGqxxGI2aj64WFZAIQNrZc36xpz5VL55o0neEWVrFDB5gOD+5B2o8jnxMYdYY66+hRpYPM35A7t3l4OtkK/CwOBpf6q2U2r2zxNB3BwX7jBA71cCoXNvwvuF0XtZSeasNL0ys3xi+bgd8Pk5JjPqdZEF1ZhXL1Sv9Pw5KZcHe2lVnfDAW9gKDgKFlwQjgrUy815LvFiU6wurYQEToSboXhnUcR3SlumpfpZCJv/XLQNc5sbUfJg9LQ6vAhvHdmMLxBs8ns/Uhsk9VmMilApW9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLRbUKynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=;
 b=bNfXWOe0We4nG0afYdyVENpoxI8MfeJt/TYP4aoXRC0QZWwkMyFji4/3Kvp/o1EgiBqESn8GMhZw6eeAa10vxGubNsX3Kn48WiMflm0rUjQKysPJp0LMMqLYOtkBS66bSW22zqWohlwLVm6rN3c6prVvH3fEaTAqZX8g+T/imqu/EfmD3g0/Nd3gai1LTlgZkQJqd7eQo0j1ktSbwI+b6YRnmnzQ7TI6dzKF4N3r66ibHeNoV25laZCVAkwgK+26oHwD4CJrIGXUst9OKOHpIIecKz/Rqxv/UdMNjQVvWKzX/36I0xlpaSkZ6ZZmGr9ef40x+Zbu+lhpVC2S1QmK+g==
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by CO6PR04MB7794.namprd04.prod.outlook.com (2603:10b6:303:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:50:38 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::4e) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Tue,
 18 Mar 2025 22:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:50:37 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:50:30 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 18 Mar 2025 17:50:32 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 17:50:32 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:50:32 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [Patch iproute2-next 1/2] bridge: mdb: Support offload failed flag
Date: Tue, 18 Mar 2025 18:50:25 -0400
Message-ID: <20250318225026.145501-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318225026.145501-1-Joseph.Huang@garmin.com>
References: <20250318225026.145501-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CO6PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: b561dd9d-21bb-465e-783b-08dd666f4d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrGLga3M+DznTR46yfZABmH3suXUsoJcvsUQe7B/NmO29JxaBmfYUCJK+Q3I?=
 =?us-ascii?Q?5dp2EebLpR3/AhYo8Sgy/EdiMehjJy7HpXkufQHbE1Is0b6OFwH+oZGUIAZx?=
 =?us-ascii?Q?qckNVDSs5+lVAcJLLiEzA4zcJAkeVhY+pbcZgCOWKMuaHWYTx6iA/3jMTNxD?=
 =?us-ascii?Q?7SXeSwvY1ahvax3kgDGi5pVM7K9tzoeddGG54ZtnO0y/1rasE0JyBp0sKW1I?=
 =?us-ascii?Q?56Dwltr1oOtVBACgTfYxD2NwhUnDwpQ6kHYOMuZU96AnP5OEnTb666H4IF+f?=
 =?us-ascii?Q?i7hx8XLJTcqhP2yQjVp7NxE46wGha3wNs6I5VkDGuXVXpAdJediXD+o0qFsD?=
 =?us-ascii?Q?s+NPXW3CBloncgWf8/JzhdX63bs7bj2rAi/z4+RibfGBtV9hWVCDRmsVPqvS?=
 =?us-ascii?Q?lxv2jR6YrwDEbr4wEgLw/iDpid77AW0efwOIxsE+e2CfoJ9oqI3aTgZgRg1O?=
 =?us-ascii?Q?UAdaxMAtjb+YgqeReeDakmyGFl1lWPc1d1O4Spl9JyR3GSdK+fEYnLAr1HPV?=
 =?us-ascii?Q?jZ+Tr8Qpsc6V7ZXxBj3vTHxVI8W2A4eB+7qMUQtF3lgJpoCYBvDRivmhTLRu?=
 =?us-ascii?Q?2IhnLodHfFU6Z/ezaXitvx71k5c8ubLliZrr2c4nQv3hHaZu/lbbL84Hzmqm?=
 =?us-ascii?Q?lgU8ZXM6bUUuGa5jeeryXwbFmj2Yjs5X8mcWKZSn9gURCQtq1ZlGrWp4IyMy?=
 =?us-ascii?Q?y3a2cIaotYRPAFGwNufjjOeUbYeqK8+KTD7q3awcGh7ZtJuVSMzwNih4a3RG?=
 =?us-ascii?Q?W30pWFzop6J51Hd63BAcYxRCxRDvcfJf+7Pz7IdFuQimIUW7ZCZb9S+oc2FI?=
 =?us-ascii?Q?erRBdKKFpiefqO3NBzGxphDPWhD2PK+/01KRn7x0KZPLIfxTlA9R3+RdNeUc?=
 =?us-ascii?Q?fnYkDEAmzhxGa4dwkkPcX0OLqLFIbcX31eOAAeqIZl9l23bUlqgTAmqznmcZ?=
 =?us-ascii?Q?YvGPiyElOxQs7Nb54rRpfgBC1gMauohLITsKYcqnz1oSZd9b7Gwl7fuapycp?=
 =?us-ascii?Q?CmsWSLT6eYaNjwXUvO09aKZwRL+B/nU+3AaizxbPjUfKkxJ/XJPhJL/z1Muw?=
 =?us-ascii?Q?1A6k0C+CizgM3U7ZdD5lMTQgTKy/UmBt8rp4AgNmMzrcfWROvxAbnQ854It8?=
 =?us-ascii?Q?DKRCV0JreO6Q/0hKbuO9UMvsyt5b9QoZXIafh9PI0RG27b554jLs29TWwWBP?=
 =?us-ascii?Q?OZCuo4bs2NqbkOwpr8fQQidItDBuPAPi5AdnEzde7+QYk3fWVmKOZ3QyqJIq?=
 =?us-ascii?Q?Vizlxt/DGOAYoSlega5UcYwRwQgy62cvtbJHBxJ1AM6PUj9r/8pCv/qLqi5H?=
 =?us-ascii?Q?Vk8+bpQemKND4cciaj52GDx7vhkmQPrKfJTtJ1fWWrhSYlfQ7Cb/xvRB7372?=
 =?us-ascii?Q?RewpdSYA1AiLaZuThNVNQBMXYn5lma/i5hIigqRX80M2DCFjF6fCf/2P05fZ?=
 =?us-ascii?Q?c9/kzszTdXvRU4iZdWVSCYEEywVrcDOYTMSUrVPVkACv0C3B9PCRUKLjUmC2?=
 =?us-ascii?Q?quNzYFAPKfb4VbA=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:50:37.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b561dd9d-21bb-465e-783b-08dd666f4d2f
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7794
X-Proofpoint-ORIG-GUID: KGqhfm9E6pQZ8gQxtqXX6cik-2FMw5qY
X-Proofpoint-GUID: KGqhfm9E6pQZ8gQxtqXX6cik-2FMw5qY
X-Authority-Analysis: v=2.4 cv=WpwrMcfv c=1 sm=1 tr=0 ts=67d9f8bf cx=c_pps a=yZcDG7BW7OBBh6O1hU8nvQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vJ3Si-Bo0Wz43vYLVJQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1031 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180165

Add support for the MDB_FLAGS_OFFLOAD_FAILED flag to indicate that
an attempt to offload an mdb entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 bridge/mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 196363a5..72490971 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -256,6 +256,8 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
 		print_string(PRINT_ANY, NULL, " %s", "added_by_star_ex");
 	if (e->flags & MDB_FLAGS_BLOCKED)
 		print_string(PRINT_ANY, NULL, " %s", "blocked");
+	if (e->flags & MDB_FLAGS_OFFLOAD_FAILED)
+		print_string(PRINT_ANY, NULL, " %s", "offload_failed");
 	close_json_array(PRINT_JSON, NULL);
 
 	if (e->vid)
-- 
2.49.0


