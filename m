Return-Path: <netdev+bounces-180353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EFA81088
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0E61B63FFC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F422D4E5;
	Tue,  8 Apr 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="w89BaesB";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="FESBAh6G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A722B8C4;
	Tue,  8 Apr 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126933; cv=fail; b=GdCQrCQCYfa7e6Si1IBtz+Ivk92waamoBtRRK1DPs9pMi3/gLZKP145C+SBsjdheImddjLIVddLxJRvjzh4ZgWpzt1J0Ez2H8Pd5EzQYSrVDHnovyiIfRUeZZAL2jo0KFaX73WKf4qbPavA4rnJCJHdcMDnYRZQw7m+9Kf8cb/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126933; c=relaxed/simple;
	bh=BVVBpa3x9tins8KUWLlm6NrkQieYoD0NB2b3BdTxNpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyDjToMAbOvGon9Ah+5UOsvls8wSIz1b7Q+UxYMx00zJ8rLD53yZcIFYdo4Vu21ePhVJ+y1il5fH3CocCoKnK2+g4fJy+26bKmfva//d9nHW3qBxrgV49WjzNWTLP8uTDhCLAJXdxIQds8LFBF9UpHkVMi4FMsYbvSXPTNplRJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=w89BaesB; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=FESBAh6G; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538FOVBq032711;
	Tue, 8 Apr 2025 10:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=LAPdk
	4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=; b=w89BaesBddrmOuZIaUcBw
	rRSKnykXFmeFVQHjpuhYnbeLoshOWSOxUp+ICIqBqVUEYHESb8dh5TnqNYjCCCqJ
	xpepKmM3gWmFV9lyiviiEX/IeFiOu/SIbxHoHHHK7QODNkJbAmoA8m48AR9x7Swk
	L9micP3U75tC6G/xyLHlCkgNfvfE+aAAxdQOnooOuVokEBYUvOsaOio0g0+WOJVS
	nPdkMk5hA1y0SKa6zt86TwSJm2D1tq6mSQy0j6wi1UgTJawaaGzmQASK91OwOPqV
	QNEgO/9bsBDMczKRGjG2YynbTFw19Nx1iYyVgKeRYoCNGxxpi8wI8KIiF9DyYOHb
	A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45w0r98txk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:41:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykyq0SabxXK5T+qWlmZFStpAEY5WF3keU9LQhNCyYqQQ2WWitToRLSJOHzIfBBM/6YfzRFAqgK5qTuaBoT6oZZLWWpcaXj7UdpW78nWFMiyMjJAf+tFkd35hLOOfrKWeK/d18Zg884LInY0Q3gziy0CpnKQcBphA4bTaAQ8Qy+A3jFeN8nNozT/uzBB1PWkDsfuX+E2tx4f/jsK/soMAD03o14WNNYLLYPWYv5tAqEOXX0Fy5lEWJqIVnuOpYvYBbLOFOMH7Ao/3EIywWYLOqDwizdYsse5IHNELxOrI6xVaZFr8mpemtjk/OmF1MCH9C4QIDz0hxN1t+wZoNKeVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAPdk4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=;
 b=Nm7PUpLaLNZ0oKiipC3nwAU73dWgx1vHe3xBoXLpvj6DRQ3uX11sjrQk8GVZU4iVzmQJ6KASxbhKKhHCGZAJud9JwSKCTxXfs4QSEcp/elnxOR5RovbTYh2mC3eWm93F56hBHWg083ddquyuXCpsbnhBxvnrFyTlSUyNDBvALPz1RDxu9kqo2FE58jSWVmq0O1F3JUxAz9snzLNNct/97A1Lg/ip72Im5uNqVjZYo9LZ+xzzfJpea0NJbK90E+lDS6dYSP6FO5D7uTL5sK8jbMbHwtC2kLxS1v8l0JzmMONX32hSa5/lE5rWtwQh++HN4ry4AHQocC25JK3wRFmR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAPdk4IKWbWVNG4e99TR1bO0ub4bMqDP88F7DcxUx/4=;
 b=FESBAh6Gp3HMDhr/0vD7xXmy8wP4dRAQL2GgKgRSMXfQ5GziofjC/gr/U/KBRbWzO+DFvm2Rgd1lHF46KGsz9wUldQCGnBOdCJLox6+wcxKhTRE2N9UZCJfKeDmpZ5MK5y8E7zZbKl9tvMextyhpXsYmX1fdY8iDy0Wlm9LDfy4zDYwkNp4829R3AgTRzaN30ESrgslEjPMMdLQUThg3tBiJb5VZ/J5h6nuWMbPOu+iRoFYZBA5s3GEi7FZdaVDHkVg510fMRcI8gOWkPhCGJpKfLdY1hT//LDCd6QDdQ/J2qicUWxfAsTNGJWmnHiXPJFRjVaR86lkDe0km01vhwQ==
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by SJ0PR04MB7422.namprd04.prod.outlook.com (2603:10b6:a03:292::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:41:39 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:23b:cafe::af) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 15:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.0 via Frontend Transport; Tue, 8 Apr 2025 15:41:38 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 10:41:36 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 8 Apr 2025 10:41:37 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Apr 2025 10:41:36 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Apr 2025 10:41:36 -0500
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
Subject: [Patch v4 net-next 2/3] net: bridge: Add offload_fail_notification bopt
Date: Tue, 8 Apr 2025 11:41:10 -0400
Message-ID: <20250408154116.3032467-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
References: <20250408154116.3032467-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR04MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: e7178cf8-de56-498c-1a58-08dd76b3d9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sZjuS+ho8x06KZ8a+qaRrOnC4tUCEs4TjcnNCzqoUBtnORjG+CN0tEC3cN5?=
 =?us-ascii?Q?tqbr1bkwAj28g8VydRn+Lfyq6nT6DwjZgG3bFV9ROAAB3WPcXHBDd2zRZxtt?=
 =?us-ascii?Q?qakMZ+hayHahNXapu3rNjQhOzG7eqjEhBljJpJkbePgxkgNWS3rFKkvOADbt?=
 =?us-ascii?Q?sy7NTimHh4LjjzEQqV4h4XQBmvMRFoBsIgntcBb+zHUACMAC1EMDStyZ9url?=
 =?us-ascii?Q?RWGqA4abG8lTfDUk7X2jSeO2OKRmnkAQ3Lu/iYsgt+whaXwHgOtlQQASsSWa?=
 =?us-ascii?Q?OvM+venjj0KvNSiIAtgvhV7ffel+KwbdkiC3CZ43u48Vw8v+WL2Xhh0Un4q8?=
 =?us-ascii?Q?mWUoIoQCYo7qR+aZS+G2+7w2gYUpmkhHNNJRSC90/xl6FEV+9T5eJozZF309?=
 =?us-ascii?Q?SCn2oac6zbRKcxNYA4qyBwIYMMEsRxHHRLVP5Hzz19W3BOV0OhXa4trGM1xJ?=
 =?us-ascii?Q?0TE5Xw7jQbf6PIT3KIF4ikbZvOqw5HuKqsZRldhIO4RBcZr3Lnvtofff14eC?=
 =?us-ascii?Q?tmzUUpLYJBvH45O+2x4V8y4JlIAej9Sn/wDjfEkE9K2z8it6PstUL7gNwmjx?=
 =?us-ascii?Q?WYZWyDIniLPvX+7AsWlSP3gSfyxl+0gfUtFf9Z8L+BmyGlMYFnHQepy4uMZJ?=
 =?us-ascii?Q?upYb+KqrKD2Jz/1TMh91WP3k20PUb5PjEcbC/6R3yD44vijxYvYZEqAtX0S8?=
 =?us-ascii?Q?/bUFxDjdnNnqk8iwxEwgwn2DEtj2pHgArWaV3DPhwIYigzaBjTPVttWl5BRp?=
 =?us-ascii?Q?paL/5tXIoMEIRB6WBqeoHzpoIkeJN/atTOqFl8cvc2oovx8ZlyFiROvjwlNa?=
 =?us-ascii?Q?00lO1I89qm5aFTLZhwSh0joJtQpCNpS6c9Zt8djdURk5f6g20VZt2b+9p/yh?=
 =?us-ascii?Q?EJ0NhApfJUTDW97mIuenAhjI3iNfHoDMEb8Di6r+gDpnTSpoQ+QcAX6n315p?=
 =?us-ascii?Q?ZjqgIxK0REjzPXTwMfyIi/8F9OmmZFHagOjCRYOn+IxTzSW4kMfEl94aNTCS?=
 =?us-ascii?Q?bt9BbeyJ1eSQpIDhRg2zjHEfJx+gkdKQYrkyTkrdVODmkvvVoHSohvP7pyT2?=
 =?us-ascii?Q?JgUPq2TDoazn91VzmimIVoL8QHAlcx2xk5wGX7+X4iu9l/lfl0rmGT1j9i2V?=
 =?us-ascii?Q?ApH3wd7QQ2aA7fVUmUULIIwe+U8JBMzQ7397VGYu0Iyi2ashHZoGXWy/eIIf?=
 =?us-ascii?Q?1U5klk8657xk1mxgSARNzM13GJavuXp2E1d8cnBLTBAtqvTJvu2TN3W9fpBC?=
 =?us-ascii?Q?se8khp3deLm4LVPXke8OtGgwXX55pJLM8W3j1DBI3AF/ywuE4mmyKXbuOwnc?=
 =?us-ascii?Q?vpiAqZHU6TXbWyRp3n3lXYEhwsErGoKKRF2W0/YfsWyQJUnkhew/zQr4ImJg?=
 =?us-ascii?Q?RF7DioiKXFbg91B6aqei0SWAt1KY56Ok6B8qAS3TvHMQIyn4rRFb3NOv65Fb?=
 =?us-ascii?Q?IOSsudgeD9GZyrUoIemaovvo0wFaFyHB1QbdAm4S+HnU2suf/A5r0xeGRR0X?=
 =?us-ascii?Q?nZoYjsm5od1umbY=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:41:38.2851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7178cf8-de56-498c-1a58-08dd76b3d9f4
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7422
X-Proofpoint-GUID: f3jlXRoi9o4x2l68xuFz4lWkstO5dyKH
X-Proofpoint-ORIG-GUID: f3jlXRoi9o4x2l68xuFz4lWkstO5dyKH
X-Authority-Analysis: v=2.4 cv=DsZW+H/+ c=1 sm=1 tr=0 ts=67f543b5 cx=c_pps a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=KDSQBeb26tfA5DPfL6IA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=789 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504080108

Add BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION bool option.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/uapi/linux/if_bridge.h | 1 +
 net/bridge/br.c                | 5 +++++
 net/bridge/br_private.h        | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index f2a6de424f3f..73876c0e2bba 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -831,6 +831,7 @@ enum br_boolopt_id {
 	BR_BOOLOPT_NO_LL_LEARN,
 	BR_BOOLOPT_MCAST_VLAN_SNOOPING,
 	BR_BOOLOPT_MST_ENABLE,
+	BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 	BR_BOOLOPT_MAX
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 183fcb362f9e..25dda554ca5b 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -284,6 +284,9 @@ int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on,
 	case BR_BOOLOPT_MST_ENABLE:
 		err = br_mst_set_enabled(br, on, extack);
 		break;
+	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
+		br_opt_toggle(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION, on);
+		break;
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
@@ -302,6 +305,8 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
 		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
 	case BR_BOOLOPT_MST_ENABLE:
 		return br_opt_get(br, BROPT_MST_ENABLED);
+	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
+		return br_opt_get(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION);
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5f9d6075017e..02188b7ff8e6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -484,6 +484,7 @@ enum net_bridge_opts {
 	BROPT_VLAN_BRIDGE_BINDING,
 	BROPT_MCAST_VLAN_SNOOPING_ENABLED,
 	BROPT_MST_ENABLED,
+	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 };
 
 struct net_bridge {
-- 
2.49.0


