Return-Path: <netdev+bounces-175925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446CA67FF1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8D8813AD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFCB2135BC;
	Tue, 18 Mar 2025 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="c6hy4+9x";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="nnwjI264"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819337E9;
	Tue, 18 Mar 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337850; cv=fail; b=hDkbUOEjvmuBtQDMo/z2dsgsHR/P5iCxfHyydm/qOtr3XEHJELpjdr5p6QgyGPx64/6fkWZFzTPz0C5kuarwBzooRo+iLRyQS0OQ49XLkZmpc2YL51VkqDyvttLA05tlJL2sVW8vvwXgK5EWDNwNclWtIR1mZCO0PMSO/KH/LsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337850; c=relaxed/simple;
	bh=FV0ggYcvQmupmghgj0ZQ5hk80GfklRnP0Bv3R+iULxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsUZvPrv+D+xrjQ0HUSk63K46ilX3Z0MY4VnATJukrvbsCBlK4FNnvgHnGS89TZvk6vkoVKGu/XZi2UyABYVw++8uy62qqKLf3eKzK5lEX4M1mMGyZ6dlz/ACyzyDoLRppvzRkS3NbMrIkNW34lLn3Nubkvu2g7sYgtfggwbu/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=c6hy4+9x; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=nnwjI264; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILqVsx027544;
	Tue, 18 Mar 2025 17:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=WBwD6
	hd47xClh+PmD0jdENGg4VXS44G+LR/HbwfXRMA=; b=c6hy4+9x6PDEgTZbo1lrP
	lz6hD/aDUpRxgMNeOpwVQh3v338FjjhQBxv4TLdXHqp0+iLsnU/JftmFY8F7cUCD
	PlEm8Ub8SRy+PqdHCht4Lciv2/K9ZLiUxTElPhZY7oPcBT+yAn+H7lNCEliC8bsp
	A4Yjl6Z9y9UyTatLP4LM5zUpiCLKZyH9Bs5T8F6OZPBxInuWtfcWu3DLqYc/nBK5
	TXEV+p+JTkNCBM6tNQA7grNn5BIZg7etYpI6YFwGkmmx120kltt3Uh5Bk7Y3fs2H
	FsL6W+7pU3/SxlCE3dFkVl7lvUntyH+byg/ncOwGJ3WWos7MYuXO/wif3ih9xRsD
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45f6whh9xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:43:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNdJhwuRHFJc4Ser/SBudRTCRXMfACMEG4OGq90B7mYGtIn/9VgD93Lq5GR2rnqwVinTIb7v0o7KkjZdQkeTRRKD+T/2RYz1uz86Grk4Mh9Qk2xLbiylOOOPv5jIobnaAaP6dCpKEWf9Jir5n0fE3d9sd+CEf/1TeIEj9Dcz30gsum4mnzqw18W1ke1eTP7wWzPhzSyh+EV2G0YkAXk3hLQYuutxUpTcHhCeAqFedyYzq3Js6BDowSkqVrJ9XfNoEekGeJPaKxmES+lriPLE8vGmAXYYDh77LXITXVmdS0RJxkbnpBxyB1q+etXshTaT/4P74pegGyallfvmm6MTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBwD6hd47xClh+PmD0jdENGg4VXS44G+LR/HbwfXRMA=;
 b=Jwkp3Q+WR+l4XTKdr/xYw1oW3CgTR/MuowHK4X8kybTCnvcBGncrBiHCdYnhPtnsjXerXSZJY9CwyW1eaY5WNfy0BRLsLYrop32Rj5oDUyszRn1xi+eDQMIj7ws5/QOGXMTTAK0O8/KqcEPwNQmVKuCDhHvrUzoYt9//mDVKz8xWtzJDU1XUjjZw/emNogCoPZug8wQazeC+Xxtscy0pG81ys2PFDTpzHMgdOvFqk13b2Ix5+ZVsobqeo1bZI3hywSHRI0/rzd4a9xp+kGTxOwQ1DgfMJ/4HR47UoJXdvEFHSOBes3PL0VANJY1oQMgqN3Nb4h9IIlx+4TworPQT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBwD6hd47xClh+PmD0jdENGg4VXS44G+LR/HbwfXRMA=;
 b=nnwjI264M5sL9C6WVCqnQxK6yZo9FastokkbZP5kAzlryHM5H/U0cKZLkaDphhJ88CaQycOgfWIwFfxW7gwmvQ/PUBnpijyxDFTscJNQIXWXT3rgr/vaM4r6dVTTxm7dpLIGE0Mfrrxd/F0udXCJVLSOKS2b3Q+05StV1MM4cJyF1aJpNLKhIOA7YwvizqcxVQ/lPY13ZOr21rko52V3WhMf/ijWB+Yx1Cog/WFyulmk94eeHB406v2p4evX9GLMJuJtEWAYtxsBUyuyrhNNcMVl4OcAJTC8pwis9EG2Qx2vpq3NILOFhpfdBzkkED0++LaocqgaUOu2ba0FFPGxAA==
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by DM8PR04MB8005.namprd04.prod.outlook.com (2603:10b6:8:f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 22:43:42 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::fa) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 22:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:43:42 +0000
Received: from cv1wpa-exmb6.ad.garmin.com (10.5.144.76) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:43:29 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb6.ad.garmin.com (10.5.144.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Mar 2025 17:43:31 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 17:43:30 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:43:30 -0500
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
Subject: [Patch net-next 2/3] net: bridge: mcast: Notify on offload flag change
Date: Tue, 18 Mar 2025 18:42:47 -0400
Message-ID: <20250318224255.143683-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318224255.143683-1-Joseph.Huang@garmin.com>
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c836cd-3101-4dd3-7e68-08dd666e55ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QY19kAmD18J2UtoF0+5z1glj9HkQVugaglj2x1t7iZi/STOQh7Bt4Ef/tQTG?=
 =?us-ascii?Q?H1KUsSds4wh16ciQ41jbMl46DjSRar5A9hW5MoRTGbzgGtGt7H3NqIIIy26/?=
 =?us-ascii?Q?ivUAn2aFtmPaT0l3FpVtHbmVC4nGegfPCl++MWW8FboGMsWTp1fwT8X/FXW4?=
 =?us-ascii?Q?bcATdnC9Ddivwfii4gjWYqN24V1UEJjvVlAtEOSAbSBaPUxCBCsla3YSbOVN?=
 =?us-ascii?Q?q+wp6XlpH9fqNTqGNrfv/2DpSPx4vAXh+4dVk5yYUtARkGh26Ha9hLLgko/o?=
 =?us-ascii?Q?965AZDyoBG52D0d9isliPAdohKV8zZYzt/2co6OMNEAM6jV3XRMTsOPvKros?=
 =?us-ascii?Q?tGJ+xrhxYTMnEh8OLXappm6hiojDuKHqC92a5149sLIh1ygPBbe+L43fRCA7?=
 =?us-ascii?Q?u3Mu5ULyyfCLwcxkGwkLzKFCqWHopxCsl4hwYXu9c3WUxoWiZXC4sSAB8hjY?=
 =?us-ascii?Q?KNcbYDMnFqC5J/rweJ1UOhqUiRDsIqCtmzxrSPHaRPyUZhlbMc2fmT3nyPjn?=
 =?us-ascii?Q?GRYTNIzQLE0ta4qcd4Rvy5l9jeYTzwsIWctro1hGWY4hgxFeOB4c5OccZMtJ?=
 =?us-ascii?Q?/MxvdTZChjZo4GSatG6RdJsGpbqn1n4+VMWgZ2D9kU9WrEz3mSqXa81kgEXa?=
 =?us-ascii?Q?aK2ajCbb9Gy8nfTdOvp+SwUWNvGsBm5NguToXOzOvp15mqJJJ4KoI2zE8pvd?=
 =?us-ascii?Q?JQMOI55u5090439dGx57l4iCUwZkgptbLHl5+vsYevRLT/t6AZ+LRuNODu+6?=
 =?us-ascii?Q?OwMdr+E5mVNvGkCjn5zDraydP/cypchSQ3P0/3T/dU7OrRWlBVHqTNFAg26Y?=
 =?us-ascii?Q?4Vt700hqh/JrIBdIg3v0KtA04vlvzoKKMu/22nQmjz8GTb0W8oBNl46L5UxF?=
 =?us-ascii?Q?ChInPSNaQQUIprqywemgETlWTr+s+rJX9RI0YxUNjRm6fnyL5SzxMRfG1mo7?=
 =?us-ascii?Q?KfkNNztjn0PLOZ4k5qzVcv5J2wWXrxOzEcluy6Xq/2wrqqTwJvZgUH8NBH3Z?=
 =?us-ascii?Q?jGjEUUtnfWYAZQwSOh3bPs9EV1dn/J4+7R8O6W8DlGFiAbSyquy2XGFcIO+C?=
 =?us-ascii?Q?yLNj/Q90GYZe0uFUazmu+/xZB49r4pWry04TsKJr+LBz/aHwvPhJO1G+WZBz?=
 =?us-ascii?Q?e8JGXvP34m+n/kfMKkfSgamP49SxX1YlhG1Wxo8P+KLNxVNF8bHG23vmOQew?=
 =?us-ascii?Q?S2IhD7ZYdjTvRW4sjAcqCs1Qsy1eGJxV1KbiM40Xy5B/XMPUwvlfbMGE0YS8?=
 =?us-ascii?Q?7AgT/Q3p9+MVnHQEUvveNLrqI+L0Oq9JyrYEbaqdtdo8XR5ZA3P3KIL3mof1?=
 =?us-ascii?Q?Tf+eYoNQngb9oCyq3noTL30DQpI+YRN+G4v/GRtUemXwjrWbDwQPqMJazEij?=
 =?us-ascii?Q?UE3ETQQKYXWBOY7IO+UmIiSoHhGZYY+ajRdMWabXPV8rjOqm+hGI9HMHYr5u?=
 =?us-ascii?Q?oLL2b+Dk5a3zG354eWiKi06eJquLq82lfubcb5hyxJKJR9sRSvneuYfIHms0?=
 =?us-ascii?Q?o6bqX5ZaJyX1MQA=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:43:42.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c836cd-3101-4dd3-7e68-08dd666e55ca
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8005
X-Proofpoint-ORIG-GUID: 9zVcsFn71wb4tvfsLqepICERyHoAYZVV
X-Authority-Analysis: v=2.4 cv=b8iy4sGx c=1 sm=1 tr=0 ts=67d9f720 cx=c_pps a=8NhCg2oU0sQOR5chO7ltBw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=VGaYpauLdRoLlJ9qq5IA:9 cc=ntf
X-Proofpoint-GUID: 9zVcsFn71wb4tvfsLqepICERyHoAYZVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2503180165

Notify user space on offload flag(s) change.

This behavior is controlled by the new knob mdb_notify_on_flag_change:

0 - the bridge will not notify user space about MDB flag change
1 - the bridge will notify user space about flag change if either
    MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
2 - the bridge will notify user space about flag change only if
    MDB_PG_FLAGS_OFFLOAD_FAILED has changed

The default value is 0.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_mdb.c       | 28 +++++++++++++++++++++++-----
 net/bridge/br_multicast.c | 25 +++++++++++++++++++++++++
 net/bridge/br_private.h   | 15 +++++++++++++++
 net/bridge/br_switchdev.c | 25 +++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0639691cd19b..d206b5a160f3 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -519,16 +519,17 @@ static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
 	       rtnl_mdb_nlmsg_pg_size(pg);
 }
 
-void br_mdb_notify(struct net_device *dev,
-		   struct net_bridge_mdb_entry *mp,
-		   struct net_bridge_port_group *pg,
-		   int type)
+static void _br_mdb_notify(struct net_device *dev,
+			   struct net_bridge_mdb_entry *mp,
+			   struct net_bridge_port_group *pg,
+			   int type, bool notify_switchdev)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	br_switchdev_mdb_notify(dev, mp, pg, type);
+	if (notify_switchdev)
+		br_switchdev_mdb_notify(dev, mp, pg, type);
 
 	skb = nlmsg_new(rtnl_mdb_nlmsg_size(pg), GFP_ATOMIC);
 	if (!skb)
@@ -546,6 +547,23 @@ void br_mdb_notify(struct net_device *dev,
 	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
 }
 
+void br_mdb_notify(struct net_device *dev,
+		   struct net_bridge_mdb_entry *mp,
+		   struct net_bridge_port_group *pg,
+		   int type)
+{
+	_br_mdb_notify(dev, mp, pg, type, true);
+}
+
+#ifdef CONFIG_NET_SWITCHDEV
+void br_mdb_flag_change_notify(struct net_device *dev,
+			       struct net_bridge_mdb_entry *mp,
+			       struct net_bridge_port_group *pg)
+{
+	_br_mdb_notify(dev, mp, pg, RTM_NEWMDB, false);
+}
+#endif
+
 static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 				   struct net_device *dev,
 				   int ifindex, u16 vid, u32 pid,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2434d2..8d583caecd40 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4051,6 +4051,10 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
+#ifdef CONFIG_NET_SWITCHDEV
+	brmctx->multicast_mdb_notify_on_flag_change =
+		MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE;
+#endif
 
 	timer_setup(&brmctx->ip4_mc_router_timer,
 		    br_ip4_multicast_local_router_expired, 0);
@@ -4708,6 +4712,27 @@ int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
 }
 #endif
 
+#ifdef CONFIG_NET_SWITCHDEV
+int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
+					       u8 val)
+{
+	switch (val) {
+	case MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE:
+	case MDB_NOTIFY_ON_FLAG_CHANGE_BOTH:
+	case MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_bh(&brmctx->br->multicast_lock);
+	brmctx->multicast_mdb_notify_on_flag_change = val;
+	spin_unlock_bh(&brmctx->br->multicast_lock);
+
+	return 0;
+}
+#endif
+
 void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
 				  unsigned long val)
 {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cd6b4e91e7d6..8e8de5d54ae3 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -132,6 +132,10 @@ struct net_bridge_mcast_port {
 #endif /* CONFIG_BRIDGE_IGMP_SNOOPING */
 };
 
+#define MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE	0
+#define MDB_NOTIFY_ON_FLAG_CHANGE_BOTH		1
+#define MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY	2
+
 /* net_bridge_mcast must be always defined due to forwarding stubs */
 struct net_bridge_mcast {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -146,6 +150,9 @@ struct net_bridge_mcast {
 	u8				multicast_router;
 #if IS_ENABLED(CONFIG_IPV6)
 	u8				multicast_mld_version;
+#endif
+#ifdef CONFIG_NET_SWITCHDEV
+	u8				multicast_mdb_notify_on_flag_change;
 #endif
 	unsigned long			multicast_last_member_interval;
 	unsigned long			multicast_membership_interval;
@@ -988,6 +995,10 @@ int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
 int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
 				 unsigned long val);
 #endif
+#ifdef CONFIG_NET_SWITCHDEV
+int br_multicast_set_mdb_notify_on_flag_change(struct net_bridge_mcast *brmctx,
+					       u8 val);
+#endif
 struct net_bridge_mdb_entry *
 br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
@@ -1004,6 +1015,10 @@ int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
 		   struct net_bridge_port_group *pg, int type);
+#ifdef CONFIG_NET_SWITCHDEV
+void br_mdb_flag_change_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
+			       struct net_bridge_port_group *pg);
+#endif
 void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 		   int type);
 void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 68dccc2ff7b1..5b09cfcdf3f3 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -504,20 +504,41 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
+	bool offload_changed = false;
+	bool failed_changed = false;
+	u8 notify;
 
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
 	if (!mp)
 		goto out;
+
+	notify = br->multicast_ctx.multicast_mdb_notify_on_flag_change;
+
 	for (pp = &mp->ports; (p = mlock_dereference(*pp, br)) != NULL;
 	     pp = &p->next) {
 		if (p->key.port != port)
 			continue;
 
-		if (err)
+		if (err) {
+			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD_FAILED))
+				failed_changed = true;
 			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
-		else
+		} else {
+			if (!(p->flags & MDB_PG_FLAGS_OFFLOAD))
+				offload_changed = true;
 			p->flags |= MDB_PG_FLAGS_OFFLOAD;
+		}
+
+		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_DISABLE ||
+		    (!offload_changed && !failed_changed))
+			continue;
+
+		if (notify == MDB_NOTIFY_ON_FLAG_CHANGE_FAIL_ONLY &&
+		    !failed_changed)
+			continue;
+
+		br_mdb_flag_change_notify(br->dev, mp, p);
 	}
 out:
 	spin_unlock_bh(&br->multicast_lock);
-- 
2.49.0


