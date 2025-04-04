Return-Path: <netdev+bounces-179396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37CA7C587
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B52D1B618B7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8E1E1DE9;
	Fri,  4 Apr 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="isDS4dzP";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="cg08M1hw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43D42A87;
	Fri,  4 Apr 2025 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802246; cv=fail; b=AXyN5OcivHq8bUrR5T4LCWCXpKWsw+5rHnjQXw8dFzpMSm3aliyHVInALn9xbTSKHDxLsxZ1DYt29aflJLeY895l669MoJFLQUMSMSbG+97jxH7hO7Tw0ShNt7hFmyIA8eMdXfrhnFdmZzV/EddGTA8tTQanDwQ12h8yFLgDZo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802246; c=relaxed/simple;
	bh=XM3dOazz43rZPbCsqT9puVxPWfvszfcpK+89Kia9vuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGprwwZp0pVvAljaMdq7te0ABnQcseQRVOtkg3KSCNXiGy07H+lBtpxdHYIwLT0vUNAh9xiJUdW+HMIeiZTkS3sxd6olo1QFg1Nhf1otCE+61ZRLoIxt9vdAtJoBHV2n2gMGSRVlplooXFZhKp6W1c5T2QnUXIqxXTT/hP5KyCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=isDS4dzP; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=cg08M1hw; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JdLIw001644;
	Fri, 4 Apr 2025 16:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=omzWv
	JQSukc9hdCdAw33YKN3d6zs6MkXWGwcKyx6Zms=; b=isDS4dzPbHZ4RoUYrYUHd
	2cad0/leM5dVFsT+tJtHa4IIdTrQ5RFRgPYHZdhXy/4eY6fOXi2JotWk2oZb/FZx
	jtklH4I4tzCvYQHQB9BvuDht1q3FF49umAlURkABVZXTCgU3ijBTkUzame/cYLd9
	mKbXiC1hLMoBHjej6UseS3MLOZNyIKQWkCotVCSvkLLeCyWfVfYPij9KzKLae5HC
	UhX5c9owPR2TlfQSE4BK6cYqdoz5IyDzFeq7ILtOHO0W2sbgwZa1wqz4cDLzqWf9
	hhWpl7Cjkf6zGqPZDFW8UZ7mwQciNMuuY37CTq9H1kVyTw5sSOmrolOVnwnoa7Ze
	w==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tkkc8bru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:30:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUEpLvUUlB1AIY4f2uaoiIWpswazz1ocgJyHmQsV73+UvOc7mxostTbKUZsDniWwi/5Yep9yUkT0B07vIDPRa1TDDIliDcZm8FmHLYALvPKb6mI7O2vAOM/Y2XtV6FFqIcCKiOSnA05NidFr3LFGvopBSyka/iVtYm89HPld9I4c1DZH+t++ajM84ZkkPf4cRdnJe6ISTmulbA6bGPC1ULOeOEdBwwJp1xu/7s3aYd8S9SHODewLakV2Nn0RiYHSVX+Yw1LrWmYSysP7mxh8AHSOVI7eiRwHETBwLj+vfGr6ZbPFA8O5aMEa7Hkwy053gsG51NLWlh0vBqtgkphoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omzWvJQSukc9hdCdAw33YKN3d6zs6MkXWGwcKyx6Zms=;
 b=AZGO2QQijcqP+pwJAmxfoprTKVNGTl8T61yqOLpL5HVM4LS0aCd8cEEP+gE2BRIVSfxm0JdjHKWQhP8OTVpAxhtxzVMnU+wPaEPm4/MY+UXqKQSUkJHvx6JhKMjbQvPgBiWl09v6kxGNc+SyyEMADvGnIggo8MEdI20m4Ir7/0AxAcuLpabYMeFn//NSOoxc3fNjHbmvqS4AS7YiK42EGzLVPvME5lK0glW6TAFzOj7slEhaqsZop8GX1Y+2BRHKH9M2V6c+ueCm/saTWahY2Fiv0CbKCjMai315Jepi4l4j1r0l4R8H3vKfRfVlS83PipoRAS0RGUXUd/gMYLrNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omzWvJQSukc9hdCdAw33YKN3d6zs6MkXWGwcKyx6Zms=;
 b=cg08M1hw+tg4U/it2UZChMuCuJ+oYdtuDd5QDoSu/rE3Rr4igDScCHFQSyJm3niH9zmyG/RghAg+nidR7MfuxIaC7f2BZzYWb2vojtLxK6n2yjNPxyuhoFV+9OZPdN7bWXqM9JJwa4004h71X4pYUifRg79E0AUlDt+3rAyq3kym+qzE9aWDd/NMYNSTbGNoydCgGp23qjMz9Ipx/AcLzyL4C2FSNdWG6w6do+iUSpQ7Z5Ex5d+RZlBgLt6GPiA8+nxxeNhHXQxONP0ysiK5l9VhKjSQpAhjOwtzRc9lVj4yvT0Sjne0qwzPrUUBpyrsKKRou5TMZJaY1L6jbzI50g==
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by DM6PR04MB6633.namprd04.prod.outlook.com (2603:10b6:5:24a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 21:30:26 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::98) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Fri,
 4 Apr 2025 21:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 21:30:25 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:30:05 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 16:30:06 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 16:30:04 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:30:03 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu
	<roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux.dev>
Subject: [Patch v3 net-next 1/3] net: bridge: mcast: Add offload failed mdb flag
Date: Fri, 4 Apr 2025 17:29:33 -0400
Message-ID: <20250404212940.1837879-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM6PR04MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: a12e33cf-e393-44b3-50c7-08dd73bfea2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZsRF6Im5s92xDqhCnZnbixbxSfB8/VKbdTIiHaisqFxVkzNI/diTN0gDSXK?=
 =?us-ascii?Q?HDjLtvZdaVYLiUs1eCmzwVNfIozSbXHYhNq0mO2cMvAud3Uv/tDaj78fLMGY?=
 =?us-ascii?Q?5YNOgWWhasfLLUFt3kBHgEXQhpdE9Cdi1hJUNLvZXBLS9WQypwo/kYPm5I8e?=
 =?us-ascii?Q?JUy1V6rt1fU27LmPBqYCZf0wOx1t3hyLChGY00bTfFervNOVb+RK0jTHq7t0?=
 =?us-ascii?Q?ncKuOEHbjanYFq7lgB9DM85t2BJMGWqlakV154rKjVM3G+JkpbzIksfWaOWW?=
 =?us-ascii?Q?l+ryOvnMZV7AmW6SDKqQ8HzSj63eqz5KvugOGZ8GnuEWBLCS1SZmSQ8SS1o4?=
 =?us-ascii?Q?8pM18VREyaoOv+er+WiKguJa/DygKXxpCzdKkejsiF8I4/AGeSJmHI1K8TXe?=
 =?us-ascii?Q?JqPJpBeg38yOCidUBBKPgJdsPeDZ5/OcWe6WnMXWlmUVBp9XnqvF2bz4TkvI?=
 =?us-ascii?Q?6DswXqA9j0D6XzkWuAzajsHhSGU7uf/ZgPp27+1uaDGY/QW/mnxBH+lHAkOl?=
 =?us-ascii?Q?QpkkyD7y6BlK/x/fKrY/Ze8MHQ6hr1QwVkVut0El9tgZiAQ1bX1GaX8z8h2I?=
 =?us-ascii?Q?o6osq0DpLLiJTsx9wRvRyTR6lLNp3eQlPf5Kg3GRxaGKETvjwX5OT0kkwnsA?=
 =?us-ascii?Q?0TNw401w7VSNMzLZsRx/kX6x6wq+MZqfb50lO2LVUUWKGjsBmbjuwNKWB4fB?=
 =?us-ascii?Q?JBnqDEFfldRYWO0MRpugOSa3UUiFuDb6dUKO7KYNl1398BFjzyIVVaC9ces/?=
 =?us-ascii?Q?t/uAljbSBYqEe2Qpfym9iWwK7+SP2AwTPUy9IGkRCiiMg3m9mH8v5P1muwlH?=
 =?us-ascii?Q?TOkOrWu7+MykKL8a7wvnMvI9LdIBUOVLNoVDR0nx+KWIySx/F/yPf9aUszp7?=
 =?us-ascii?Q?D6gnuIjSY/1Fjg8hw3znk1bU5ux1AIwORWaFsBEqMgFw9GsEiKRQH/D2O1i6?=
 =?us-ascii?Q?prMZlea05vH0o0pqz0TN6ZLXPPCUMi2oOHFronNT6wWYjtEE6uZ6TuwpVciS?=
 =?us-ascii?Q?MHzEg9uAf16ZAAjtC3YaGM5DVRuHKJTCa9BSPPer2tkUJ2VR0B/f89y0Z6Uc?=
 =?us-ascii?Q?NZULtaNgRvjWpUrm1EuPVcLXRkGkxC29vzH5pbb6bBgEkCHdPEhlYV1RD+nu?=
 =?us-ascii?Q?h4WqddNZirFAsjUtMTZvmJpu4J+rONjEoehGKuoZe10Hevwhkbd39rWdj1OB?=
 =?us-ascii?Q?yDSfs8BMDRHd80mG6fxMTCiOizDXWtbai9kFdAkfGMD1b684czNoQ+n+xioL?=
 =?us-ascii?Q?I0utFcVQbty84lIbFkhYAUUeWW3t885ts+VZPbAkaYl9xFtNOTIFRDT66TJ/?=
 =?us-ascii?Q?FC6iZm0SCmH2cnhlKiCNDrrb0iyKJzdsiYLaHwC3Zz5r8PO4FKvGR6S3M3XR?=
 =?us-ascii?Q?19hVnfz/SB69cfyutGuEi5oYQLBUtJoznd2hOR4GX9z6txMpSw4+IOukPsiM?=
 =?us-ascii?Q?7VWwlu2AVYbs9seeGF9vsllL6++wsRsfwk/OpKYavKpKC4cXuAupZ67nTuUt?=
 =?us-ascii?Q?WLmQQgDSd5EK+2BiN0KN7hhmFsD8RLneeVOm?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:30:25.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12e33cf-e393-44b3-50c7-08dd73bfea2c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6633
X-Proofpoint-GUID: U4gbENSVkl4-mDs9tO3z66hUaoVON_N_
X-Proofpoint-ORIG-GUID: U4gbENSVkl4-mDs9tO3z66hUaoVON_N_
X-Authority-Analysis: v=2.4 cv=drnbC0g4 c=1 sm=1 tr=0 ts=67f04f74 cx=c_pps a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=nTqqLMH9PYxWBGmw_pQA:9 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=940 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040147

Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
that an attempt to offload the MDB entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/uapi/linux/if_bridge.h |  9 +++++----
 net/bridge/br_mdb.c            |  2 ++
 net/bridge/br_private.h        | 20 +++++++++++++++-----
 net/bridge/br_switchdev.c      |  9 +++++----
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index a5b743a2f775..f2a6de424f3f 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -699,10 +699,11 @@ struct br_mdb_entry {
 #define MDB_TEMPORARY 0
 #define MDB_PERMANENT 1
 	__u8 state;
-#define MDB_FLAGS_OFFLOAD	(1 << 0)
-#define MDB_FLAGS_FAST_LEAVE	(1 << 1)
-#define MDB_FLAGS_STAR_EXCL	(1 << 2)
-#define MDB_FLAGS_BLOCKED	(1 << 3)
+#define MDB_FLAGS_OFFLOAD		(1 << 0)
+#define MDB_FLAGS_FAST_LEAVE		(1 << 1)
+#define MDB_FLAGS_STAR_EXCL		(1 << 2)
+#define MDB_FLAGS_BLOCKED		(1 << 3)
+#define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
 	__u8 flags;
 	__u16 vid;
 	struct {
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 1a52a0bca086..0639691cd19b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -144,6 +144,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
 		e->flags |= MDB_FLAGS_STAR_EXCL;
 	if (flags & MDB_PG_FLAGS_BLOCKED)
 		e->flags |= MDB_FLAGS_BLOCKED;
+	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
+		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
 }
 
 static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1054b8a88edc..5f9d6075017e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,11 +306,12 @@ struct net_bridge_fdb_flush_desc {
 	u16				vlan_id;
 };
 
-#define MDB_PG_FLAGS_PERMANENT	BIT(0)
-#define MDB_PG_FLAGS_OFFLOAD	BIT(1)
-#define MDB_PG_FLAGS_FAST_LEAVE	BIT(2)
-#define MDB_PG_FLAGS_STAR_EXCL	BIT(3)
-#define MDB_PG_FLAGS_BLOCKED	BIT(4)
+#define MDB_PG_FLAGS_PERMANENT		BIT(0)
+#define MDB_PG_FLAGS_OFFLOAD		BIT(1)
+#define MDB_PG_FLAGS_FAST_LEAVE		BIT(2)
+#define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
+#define MDB_PG_FLAGS_BLOCKED		BIT(4)
+#define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
 
 #define PG_SRC_ENT_LIMIT	32
 
@@ -1343,6 +1344,15 @@ br_multicast_ctx_matches_vlan_snooping(const struct net_bridge_mcast *brmctx)
 
 	return !!(vlan_snooping_enabled == br_multicast_ctx_is_vlan(brmctx));
 }
+
+static inline void
+br_multicast_set_pg_offload_flags(struct net_bridge_port_group *p,
+				  bool offloaded)
+{
+	p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+	p->flags |= (offloaded ? MDB_PG_FLAGS_OFFLOAD :
+		MDB_PG_FLAGS_OFFLOAD_FAILED);
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..57e1863edf93 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -505,8 +505,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
 
-	if (err)
-		goto err;
+	if (err == -EOPNOTSUPP)
+		goto notsupp;
 
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
@@ -516,11 +516,12 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	     pp = &p->next) {
 		if (p->key.port != port)
 			continue;
-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+
+		br_multicast_set_pg_offload_flags(p, !err);
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-err:
+notsupp:
 	kfree(priv);
 }
 
-- 
2.49.0


