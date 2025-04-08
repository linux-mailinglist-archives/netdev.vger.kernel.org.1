Return-Path: <netdev+bounces-180351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C458CA81080
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2407446CAA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA222B8A6;
	Tue,  8 Apr 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="nnm7M0Wl";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="AgwAHE8B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD9226D0F;
	Tue,  8 Apr 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126931; cv=fail; b=R46DgSM2FJ6c3loUXS+BPxF8rEJTnLm6b6+JVcM843G1KTa1jwxAyGp/fBoGhYAAKzkcD0S4U8yibTI2MqF8LKKpmWPb9muu/TaRxjkKZLdtzVoCmU78GruvCnR4txHwVHIERNT3j1Gi+fWEnvWoEMkUfhoaKdqo0d4wNSTSz1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126931; c=relaxed/simple;
	bh=6QQC89fEF3RBWs4MMeOWpPDPu97abfPJE31SuXIv/w4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVcLrblEtWJhedQhwHcdvrJCN/PLxbzBRUhxj7igSy+OmovsNsWNz5WSTjb1RswYw4CDUgwJH6vsJwXI4UjgW2RLDsW636qyVZAfxgxG/P1O0kbZKi1GEKPxmCzrxxjLheDHQ3hTzGKkt3szM4J6ZwO7kchXo+zaSr44XHhP2Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=nnm7M0Wl; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=AgwAHE8B; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538FO2sV027809;
	Tue, 8 Apr 2025 10:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=MJytl
	RCfNLemNs9CI6w86pE09ZcZ3F9E//U6KY0wcOk=; b=nnm7M0WlhZlaijwCYEeN1
	0hZ0dEbEQjWcTUZt87ylP/giV9qcCjpDJil0ciHTH4EMCuTK6IKT6CDJMmLrzD9a
	77yaPV8XT7LMGy+G1g3Yr0Xc9edaQE3cCARZDNn3L7o+atJynrOYHWNbEHmSyUj2
	qnSxHsvFEl5bmg2mqMLEHAK+9xjOrnUprCT3l1RA5kkVcgbVoUM3tENy63YbK///
	Pe1ADD1K98fXAUw5DwX/p1XIbXFeHvrWeqP6WjDGCzhS3Hh5Gg8aC3Ug03z/u5ec
	Z00Fbfa573nQz3vmbXZIZ2fG2qS4i9dc5/QidPFhyy64+QcgPnMuxAGHAmAKYRmt
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010019.outbound.protection.outlook.com [40.93.12.19])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45w1s18pn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 10:41:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYEsUvD7BDbDQ2r6YFKGhtFjZUHIC6ik4NL6fLpGCjzDa68Aig7uzWDiECR3tGpDlJJaulDLwxO1blOTVFVrI7/mZrC74sxP+HG8DeR8cx7SVbKkrKAfHMjkscK771S2BWTap56SSIuM2nQEnnSnOLw2ZA8wsHk1zC7fq5piieQ7SZNJv/aZnaCTvnHXdWYgcFuEH59t+CqLxcBc/oIlrFizBa9qxU/Z2i+wbXd5CkNTButzBgktcQu2GoUy3GqXfTCyMM5cHHAgLVp0+gzEHT/zAnSworH4LiQo55mKmP9xLw4tKf6QMg/iUkbMqWW1t4CHTWj/bQelDSrb6/hqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJytlRCfNLemNs9CI6w86pE09ZcZ3F9E//U6KY0wcOk=;
 b=bl3IExUQXYepMN5MFVi2LkmYGpLGSu1b5lxhY4mPw/64sfdTUX/MPV/I42xcySHTkS47EoVI/VDfJeFLA2pG5T84pTO7Zkm7k2PYlABDf8lh6M9hFyYnBG4JlA43t1vC+u/5PbdtXSWi9+0DzyMZRjAhzYNaYHc/xmi13dZWrs79gwCH/ltUcK0ow/Jd02brV1cS7sVHII+A1ucR3R9pjGmglmBUtmqthZ6NXgZiUhLnX6dhQIPV599OMINGJGVCevJnMn2rorHpAu71BjNXWAPRJFdPx29ODt+ezbuO2wqpzwY7Vol2so7Jr/UYN6vDlk8IfMZYra1bPK8IJzuciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJytlRCfNLemNs9CI6w86pE09ZcZ3F9E//U6KY0wcOk=;
 b=AgwAHE8BoqAgGeL2bbPAeeeiK98gc5nCM6fG0euaiQ4RyHrO2AYug5n00xaTyk2U5F9yHHIrk0Su1zFQYRYlAWnJRDMhjsjOuoMOkCoAhINMnW0TMYhPLOAz67QO7Ogq0QGzm2BHcCnDdvd50eV4JPRN/zUlzUoDj0cjRZCy5smydZ2OIJSMvyJeJY7jbThcZckH7Umjh3Xyz4GyvMpWcEM3UOe/Ocvz9g36PMLbuf8MFriz7nxnNjVlCzAsZvK41dB7f3qwqqz95YactGjwa4CWoU7vZ0MLvkcP22OoFhsxvtB8V9jKxwHojqsR8oEboJunLZOh+3CC+jkWqohx2g==
Received: from CY5P221CA0121.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::19)
 by PH0PR04MB7208.namprd04.prod.outlook.com (2603:10b6:510:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 15:41:50 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::41) by CY5P221CA0121.outlook.office365.com
 (2603:10b6:930:1f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 15:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 15:41:50 +0000
Received: from KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 10:41:40 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 KC3WPA-EXMB5.ad.garmin.com (10.65.32.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.32; Tue, 8 Apr 2025 10:41:41 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Apr 2025 10:41:41 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Apr 2025 10:41:40 -0500
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
Subject: [Patch v4 net-next 3/3] net: bridge: mcast: Notify on mdb offload failure
Date: Tue, 8 Apr 2025 11:41:11 -0400
Message-ID: <20250408154116.3032467-4-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH0PR04MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f0b30b-c863-4255-bf49-08dd76b3e0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zJ8R/w4EY54cZaq8HrxPEin8s773BoRtmKW0iGLCMAUltTaPVFQzkIjwQwYw?=
 =?us-ascii?Q?xO2TVL2zaYjYgsQSpd22x7CVuLNye17tKMIQs1pYaxPuFe3VEKHyyVLeQ+Sq?=
 =?us-ascii?Q?OpuUurMKezJRBjt8rEQ0j/A7P4OvvyuiHvp0stMDeNlkZg9fARQgO2MpcQ1Q?=
 =?us-ascii?Q?kV2vZUt8p7OgCHaghtBlkzc/HULPky+Y9ka/NYhRW7AAnuNPXsohzLLyWfdK?=
 =?us-ascii?Q?phqflyUUSj1eRcV950w4yrklse+ZahKVAcYrJvpMIDmXMfIPRb/GNsKbX/kJ?=
 =?us-ascii?Q?etPpsWblkOiYYFH9y1wdg0FvjTpVtivYQSQ4b222pBtVuMl2lg+tc780d7hm?=
 =?us-ascii?Q?7KFnfVFyjovKUZaz2G63CD/nKiyG0O9mmkQLPWJeMz52X21NGRZuh3iwu2gL?=
 =?us-ascii?Q?7h4arsznm03n1pVQvAjihn76pNVmde/4lk/nDx1Q6CQiIlFcOarObPrOudd8?=
 =?us-ascii?Q?k+mPg30CW+HU+St2HliJA5u/GFIM31qyDIDl9gIGbOOdUgXRE6W0J6BQJ0Gm?=
 =?us-ascii?Q?XGqSsmwPa01TVoiNiM+HRFxAZtKNPzuOrUv56TPHQYdyTskvEiQ8GmDnFW2S?=
 =?us-ascii?Q?2geeWsYSmosWQuVlP3CdGAgXV487iM7OF39A6hEzCiuzrA1oGMNFRjJHbUHN?=
 =?us-ascii?Q?CXTUXLFquJcxeer/kisw/BThlcuns3cL8mz2kTn/i2N2xuNNJD0KzWnLW0z/?=
 =?us-ascii?Q?q7wV73aJBd17nmkQoMn3z9lwBB63H3yMFH14pZfj04sXJpibbt5zyq5fOz+Y?=
 =?us-ascii?Q?sEGQl4l6kSxlt1cQbBJTRDPWB8ksOOIMAj+lkTkO+A+DaKkw84J2moNYbDrP?=
 =?us-ascii?Q?aQq9631YrG2MMxGNqgGcgM6DjF+KF4A1sG+ysDQpHLl+7clG7JGgpT/92oXA?=
 =?us-ascii?Q?FcCeIWvkzFiCqUbx/U3kNUpc4T/VCYZtyH7UrMskwRtwvACKg9J+X5c8sZS1?=
 =?us-ascii?Q?bYh404On14HEAbrpE09mwdJgrtORCSt6WnMBZ3stI28hqEV+Sl/2jvfFcKmO?=
 =?us-ascii?Q?qNA3mwDY7/wzLaIs7OBXRDdFmIFxBYG37alcmF6TfC528Oqsua2ntCddvCl0?=
 =?us-ascii?Q?NBDNHQ65ebJSLbpQe67h5h2LtBN2jlOiveJBAEEc5nNFAP8Nx6A4vPj5WdIj?=
 =?us-ascii?Q?SmLKwVNUQ4W94Ey9hevYpYShs2XoRX4qDOS6DEnxZlEIvydwWQ98Fu8zGDfG?=
 =?us-ascii?Q?jW4tDgxd0YrYrq9U/TnsmA3PxXSoLn/lA0yJ/KUM8vVWnbOamPuajJ61leQb?=
 =?us-ascii?Q?W2SOGhG2IFYrcn+25udLuYrx7NYhpcXAnlFWjx53JZEMc9/eBP3jW3oB2kte?=
 =?us-ascii?Q?TWrf8Ve3P5Bp/0fkkH/LLmt+KwrtIeyYShx2yAR+qQAIUJPRgTiunk/HVNHO?=
 =?us-ascii?Q?ALl8b+NbKPm30JkUFBBwPQYXD6mDLDVXpaBGcoyMHvhx2riJds0IFLgH89TE?=
 =?us-ascii?Q?2SBbVnGtBVJyMlfJum0Kz5hipljpL4E1OTYE6CgBUsCy7gNzOJdEJcXP0I77?=
 =?us-ascii?Q?dl8qgRh1/uEnn+qWsdiQw+phbN2LnQ6N0fC+?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:41:50.0840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f0b30b-c863-4255-bf49-08dd76b3e0ff
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7208
X-Proofpoint-ORIG-GUID: nSmiOHH5Bn87pJdy2DXYzU06qhFeQOyX
X-Authority-Analysis: v=2.4 cv=JrHxrN4C c=1 sm=1 tr=0 ts=67f543c0 cx=c_pps a=b4GTUaH8bIYRMqSiyTmTYA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=LF5D9LMcPqa3_lnOtKMA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-GUID: nSmiOHH5Bn87pJdy2DXYzU06qhFeQOyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080108

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


