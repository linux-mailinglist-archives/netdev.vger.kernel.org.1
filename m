Return-Path: <netdev+bounces-179398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC9A7C58D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E014E17D552
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A5221569;
	Fri,  4 Apr 2025 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="IaFoUpaZ";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="mqSWVcq4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386D21B9C1;
	Fri,  4 Apr 2025 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802254; cv=fail; b=KvCVatYwMzisYWTfA8JbSxnS4N8itZS6yPuIDcq8DR2fwa91KK2rqg6QVa6ScI7NuH+Xs01mY8p9Wxq8+WWeeHxu5pMuINIZOr86XO7wrDasU2zFPp2JZyzktRbtMKkXOry84YenBs/N19HJn8tWjCb9QFDTo5jgNkTF0zd8+gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802254; c=relaxed/simple;
	bh=LZMIX6LakFDTCMDfclJjSO9kGdNm178VrV5mOSjpM10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM2SlujPwtEqkO6KuyLF75Sw3mFEu4ZlwygYuXGtPwZ87M6mrtivNIEGCQllmEfBnNrG2OkPLQqlxpS9Q1iM0BOBlyebC1N5QGAl4BXndotZyZsViEMCqd41Yr+Ri3weINLHvSzIdQx29j22WhWuRc8qJ+2zcK/QM6BW38Mi+Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=IaFoUpaZ; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=mqSWVcq4; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534LUSaS022954;
	Fri, 4 Apr 2025 16:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=8AUWH
	CHxc4k0LCiSfOoNEOs/ffORgCtZfPclg6hJkuw=; b=IaFoUpaZl6/9xNrOEY/jc
	sQsPxhjWQHiV1F4Bef7ZS1pjlX57GkxPgh4a0hpwmVbMXhr5H4J0SiEfsB+92Xb3
	tYOft/g4My1k/IlpIs1XQIe/RaTOCnf/B9iJ/ygynWtYTt98FlKEVXik9GzgHWnS
	bh/SrlQNXfhFRGOBto8ea0wROEgi/AkiYe/eSYssuW+Ewga0hyaUzdBIF7QQan0A
	tRVtxYe+POzSbnj7zw73x48CyF5hIZFWQJP3rJBI/YFKrnbw1Rssa/W9nhdPD+xT
	paRFQ7Gaiqktm70U5z/LEl24rNp6a+tCRPX2//EbfMR+4j81apjwd7JRGuM6iUa7
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tnsn04ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:30:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFwwluStuxOIQ46ZPPvBYmrliq0p3vcZe1L4QuINtLW7XRV8Oig2daYFtVToTMzxcLgM1X9NweO1SFfpPooJjybkFRV/mPcntVHZ8C5AxkgPzXPK8sqE7UfCfyesBV7Drw5PvnmCghlHowh138nO2yBHy2U6ebtVnoxhxg/9MSTVOt8fDD9RT/FaYbnJytTf1bPzkbM5WLrQo8ohWcfZpmcp0bQcoWl6gw5cvHmRDP4Wv+ZGi5+oAO/QVnHjpc11nvVoeF2iZ2WSolU/UDttTTDOA1x+/HD3CF5grh7w2i7A4iipbwrU/zAE5NhdMx4OCPc3yjnGg77KBUP7Rbpclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AUWHCHxc4k0LCiSfOoNEOs/ffORgCtZfPclg6hJkuw=;
 b=AUn2SHYWb2Mi3FOdaB7Wihrc1cKWnGMDn9Rh1gbAv4cdV3ZZbSFPpULU6/D15Fp2uZt+DCGMcNUVB0+mBBcjVuymsF6hye6EzKoCXvWbn/X/E1GynDXGcD3PB5aYaog7ibIy067SkU6CNBdCZt+1Zi1PWoAiK5CbMkUCOzF9aGasxwZzGHBehr0Nrdmq4C2bCoIiDr4L7pRnCPfKOe+JWItIDbb9aqvJ7ybnRKSIHOZzIjwrNoHVeOfpTHQi1d/t0nL+m3RCIM3CgrcNSSUTCJjFTG2HFPLOpWIOGTHYZUeQ0XQBgDH11j4ZeTp8bezALDV45ARog6uxpWEV/FWQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AUWHCHxc4k0LCiSfOoNEOs/ffORgCtZfPclg6hJkuw=;
 b=mqSWVcq4ab8tjGCVuLpkaP3Wg3hXN8W7ukShwLHugUQNXoWhW2Nb83aepem9rUFY0ij0aqY6/AOV5dfs+KuI40wDGFvdOUjWBCrSR3+ICFBYJBGCpphbhyHdzAvSeqsBTIQQFoz7jsfEIpyHo1KeMko6L6DwHOyXIU1ee66PzxqujM7Q2NNPJB9SdCIbzz3Hojtk1uT98d5W5hJRvbumTtvMSoLj9dVnixGtc2rXIvxpLHqWUazgjRcVHyssn4QhgP+y+26HACp1n+Iidd+0Oy+dOhx7SEaGNQSmop/d9Op8fGvvTVJwTmZIlw2xcr/LV8cHtSkjBaYLugrWc+ydYw==
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by CH2PR04MB6984.namprd04.prod.outlook.com (2603:10b6:610:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 21:30:36 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::61) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.8 via Frontend Transport; Fri, 4
 Apr 2025 21:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 21:30:36 +0000
Received: from cv1wpa-exmb6.ad.garmin.com (10.5.144.76) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:30:14 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb6.ad.garmin.com (10.5.144.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 4 Apr 2025 16:30:16 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Apr 2025 16:30:13 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:30:12 -0500
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
Subject: [Patch v3 net-next 3/3] net: bridge: mcast: Notify on mdb offload failure
Date: Fri, 4 Apr 2025 17:29:35 -0400
Message-ID: <20250404212940.1837879-4-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH2PR04MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff66032-7fd1-417d-2be5-08dd73bff03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIREL8bHujchMTZ2DkaxYFg/Q+AG6FYma3bYwJpW8koojeXGTZO6a19/7xLF?=
 =?us-ascii?Q?HwDz/ruiAU5rxewTY6AaJXe8ncHvO3O094v2j8Lj3R1OHWD/JyncZTCNLWRl?=
 =?us-ascii?Q?o789dQTwD0T82GgKXxWVq35LO8aewtoxCZj2KNOBPKM0ZvPVI0JM+sWTDkgO?=
 =?us-ascii?Q?uS6mRIaQ87fSzI+wIn9ciPfNKZgc8gV8I3jd6I9D6Sk6txLSXJKHa+RQ7HJw?=
 =?us-ascii?Q?XOm2M/cbX/9YD2rjcX3QMXRJevAR3FeRSNR5cQanOYMhYgF1Gx7Sp6mCJXyj?=
 =?us-ascii?Q?n489Z3ezim8YwZ99xLdAjO2bZ2oCydDIs7Oqgf2uKO2Wrt6nTEFG93Q90pcK?=
 =?us-ascii?Q?aLALQkz7e2gU9cDuEK2/8JLRD/K0HuaXhQu3w/Lg2OYMXxqTxZi1wZQTnrg0?=
 =?us-ascii?Q?8riV7Mx040oBBeLvt7Lp+DE7/xqiSi01XvR+1gWighvQf/dOQuv1ChyfzEe3?=
 =?us-ascii?Q?4cEtVxBSZwbYJIIfIozwjHU8DzJ3y5pI8DgSDi0ekONJtvm3BUx+NGpmqygs?=
 =?us-ascii?Q?/m3nxDGB342t0rFk5+X68ic4Q1VCgewXIzBaKfwfgz1SWnSWwIsQKcXzmDdl?=
 =?us-ascii?Q?j8GYVjrKlwqrjbpNdPLiH4+B4Urh2+evquwFEYSU/uz0/fIl4qesRiB3OzVn?=
 =?us-ascii?Q?I+HbTnfVRqzz30QRx3fruv5R8tVlfQl2zzE5tQkBLbjv6hnYftU98SLFJcBZ?=
 =?us-ascii?Q?No8IXHBXKHZJrOKF9Jg/PQi03RfAbH/5VqPevPpZ2RxrKkFbXabvUp8OQFUB?=
 =?us-ascii?Q?7g0MRTFq8PfY3QQ6TKSiFL2hR1jM/V+PIj5u2Tytj+3X/VqI9UT67tX+dpml?=
 =?us-ascii?Q?867BacZRkMEKLagrThO0bpu3/k4eoqNZmPP1FCkgcVbMsUucEVy4cwMQfUKK?=
 =?us-ascii?Q?iJZlCTiDYBwdJIbMtMZvN5vBOiQJml7RF9weT1xGUPFIAH+Diu7Fm6L+knky?=
 =?us-ascii?Q?Wc+FnioypWsxUDqsa7wgOy3ljG9x6P0WLlNVSmMFhVW+IzplHQuIcdCkVUIW?=
 =?us-ascii?Q?rmSTUWHEdwHkFXV/G7G4KTosITtvl5S16q6Xv1YMXxGKT5OnvZBUpk4Kz6iw?=
 =?us-ascii?Q?qtrEefXIJGM9+elSm2WsaFOrBbHPrh5sx7Jg7wsez+tpcgdQMzyoKDWmWs/p?=
 =?us-ascii?Q?RjZbpxTkZC8SZnKSMM0gz9lYyyCL4rJEYNZUTRpZOxCfWWGpP0BfKfIvVV8v?=
 =?us-ascii?Q?wkNi20fQmx43bRJcsFywV8hwtaykBNhESaHLhDvALMZKl083v4iirsE4KRkH?=
 =?us-ascii?Q?t0p9+eYS3mTBO4ArO7/iNou1pjUuqj2S5hsB08YLhu77FVZGP83UYmJRuFiV?=
 =?us-ascii?Q?30FCPp9d65lJTZBUsQnhDu8p9ESM6LO4AEJVEcQvXwX30KTaXxwMIBirR/+p?=
 =?us-ascii?Q?rVFwtrXMOh+s/9AwoaurWgI5Ymy8tXQRJtZdImZsKAtBVHqC3cUaAstsstWw?=
 =?us-ascii?Q?3QAbHyex8qLrYWmcEtDa3ur9Z1HYGhnMw1nZ3iXDFNJjV7L9VLHGsZy8MUpf?=
 =?us-ascii?Q?apNSnf1F7Deot1I=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:30:36.0688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff66032-7fd1-417d-2be5-08dd73bff03e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6984
X-Proofpoint-ORIG-GUID: nBNQO1VNAU9iw9LOfsInxe3Vje5_ZLzc
X-Authority-Analysis: v=2.4 cv=OvZPyz/t c=1 sm=1 tr=0 ts=67f04f7e cx=c_pps a=b4GTUaH8bIYRMqSiyTmTYA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=LF5D9LMcPqa3_lnOtKMA:9 cc=ntf
X-Proofpoint-GUID: nBNQO1VNAU9iw9LOfsInxe3Vje5_ZLzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040147

Notify user space on mdb offload failure if
mdb_offload_fail_notification is enabled.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
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
index 57e1863edf93..bbdf6a3ba941 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
+	u8 old_flags;
 
 	if (err == -EOPNOTSUPP)
 		goto notsupp;
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


