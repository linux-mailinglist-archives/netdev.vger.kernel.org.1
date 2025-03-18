Return-Path: <netdev+bounces-175924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17262A67FF0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB83881683
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE72116F7;
	Tue, 18 Mar 2025 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="HwcQW8yh";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="N9qk8HnT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A26207A32;
	Tue, 18 Mar 2025 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337849; cv=fail; b=hftAQUZyDBfqpdom9FvjuwPIIjyZmndFZMed+igQv5/FlFizyWP7JyDxpGEXDS1LpV/WbB0R3gWJ/2QVAUmQZvV1DzLfVJ0LTkOml1xHPfbHMknuaaDwcR0jby1qIyN7twB/6wBaatZya8oRrnQTNvYA/UyWjPHnTH0CN7TpOr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337849; c=relaxed/simple;
	bh=f+7JNQVv3P3ycP7qGQ1oUYdZZS2H/MtraaurVTKikBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEzSLAm2mCoJxE86Np9ufuJVukTiskBHa6IeuJvwFfQ8nTEcW6mwrZs11X8LGhoNUlV9DLYwb13imH0gOPDzANDsnTqZ6hhWo+KatbWW3SqXTFRgxCSeWRBnhetzUbi+t+jufd72y++v2V42Uqm4Na/kSVZVOpdiCvwbO4qJnJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=HwcQW8yh; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=N9qk8HnT; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IJobR7024638;
	Tue, 18 Mar 2025 17:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=q7HSC
	yBqR/yXnB/GIwPyI6DWbOnHASxEFm90MjsXb24=; b=HwcQW8yhV6SqDRkdRIVRx
	o/khO3k1CRUlf9dG1vD0v5AAjVzuY5PGOzCkPjR/e0m0rbADEMMlFGzGmGdZDUDu
	5tNT6PZKNiEDdzAa3kOwt547uaWRZY7QWu1Xx0HijHSnH4ICVEQvycbcejfA7giT
	4homPEZcJ/wT0J06+JPH8qRenCye/aTHFtDHWixXnsO1xe3sl03zIe/RbxxC2YGE
	lBF7hQwKbzgBWgDCI73D0QOdJhBBBAut32E07MTADoSnqAoA/TChrNOIWayvSRlL
	gItzv7wAwZYZWxa0aZUmmkt+KWWF5ySQcSVRURrBM2NIBVktDFAPT+ZaBgmpzM0B
	w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45f6whh9xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:43:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei8cKK0PBU8HooyIVlsQvPqCrObg7lAKfv7+bO7ccVg9Aqgaq+sSZmrTD1CfP91ive2rbLcROXkiDtQ1BDNuJfx5ykrPUrsRhwOi5GmG3ICT6SfVFIfvjRQkgYvF4XCbPvM4meubvuPTUH3Z1mjnmZ6kapHTBMmg8gddv4s5TXwMUhHpjxm7gIxv4qhVyLwbiTT/0c6od0D2P8gN4lDO/+Pqxf68SIn92BGp0WPiMPSN8aHqJ2isBEPmvSKDx1jwAU7dr4IQUpS0gfnrb9WmWS77oiSdmKsdBNxeAPB8qx/UGaJPZMC7sulbZrC3x8NWqtttcQeHnHoZXlUzO1387A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7HSCyBqR/yXnB/GIwPyI6DWbOnHASxEFm90MjsXb24=;
 b=GlJywFk8xO02l8I0HRtl28lJBBfpGHN1iAYmJLV6/MoE8ohF2gc5LDXy68cji2CcHWixqX1tS0LaKIVPGuHLxfJu335E1O3fDcMMpIPflVmC7FQpwO6yh6aXkrZ/IzXG6VKquyLhNYa4o51bvIlGid7cloPpKJHoU0O7w1gU5XkIDmiManIma9hzfXQ1JV6ekQ86AvxhFMpwKHrTBSjT2X7ndg42MK/GGWXNeQ7IsJdyuxbn90Tbp3KkulRFWfqqElt9XWZ30/fAHXzhgIuJuV3qcRBdG4nz544M2FFhLWgUM4zyQH+c+F5emVzylDQtylr3t2iMLKcVqlzulKgL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HSCyBqR/yXnB/GIwPyI6DWbOnHASxEFm90MjsXb24=;
 b=N9qk8HnTkXsZ/lJpR+mOl8bGINu9DZB9EJO6mdNBC9IPALMvHbS/y9VN0nxCtbuX1Pq4MoMNh49lqt1pjIg+IyGLifw1nlskSUS9cUvwg4zcXF4vZUMEc/fmWWf6mHwEK5eFKtyzA3t0LF8FNlq2Bz7cxRqL9kUErz1VVeww3g0MAZue73TEcc35kXdYCZogGDa0QK07duHBuksDFQoLgL+LxWTDOUXocD/xer82WyJcE3Pq5ZveBvRhPA8nHXoOsd24nP8lQQrRMKescAPvdbSwmllmXpUTKCvtnLo0G0GhIIUAQwj0MBKDLEMEI+LL/ERwgZvaTLKu2yQtMcMxoQ==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by DM6PR04MB6591.namprd04.prod.outlook.com (2603:10b6:5:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:43:43 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::7c) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 22:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:43:43 +0000
Received: from cv1wpa-exmb6.ad.garmin.com (10.5.144.76) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:43:32 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb6.ad.garmin.com (10.5.144.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Mar 2025 17:43:34 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 17:43:33 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:43:32 -0500
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
Subject: [Patch net-next 3/3] net: bridge: Add notify on flag change netlink i/f
Date: Tue, 18 Mar 2025 18:42:48 -0400
Message-ID: <20250318224255.143683-4-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM6PR04MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd53f19-df5e-4191-9e9c-08dd666e566c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTp3QvP03eQWdtD8dVY86lsoYUt3teMRzOuBZ4VwbudzNZ2KTn2qYq+aNQ7Q?=
 =?us-ascii?Q?73iye2T2YxJEbhAhn+QPXr9hwiX/ujoqOmLMXjtHpfkl+SgByyjS7ZL/xASx?=
 =?us-ascii?Q?U4U1bdyRdXsHJ91s6VdLM+h3mFnUbNV5YJsBxO5oD0Eku6i4XvsExkxkMDTD?=
 =?us-ascii?Q?XJ1ODhzu28ZIzFF/ubgSPuWW/h4NkwhAcix3H+E4nsE3bttDVOB4VVsOMkiG?=
 =?us-ascii?Q?Rygl5+zoiw3HOan2CLGDneu0DLyXmMi3T9tNh5jdyrcRKcLbv5S1kxkiw5SI?=
 =?us-ascii?Q?yGnVyOH+N2v7Pyu9LdZNpUTyKIhzQoFzCdJwVfl7lwm8vo8qhjQQaEC3tBwE?=
 =?us-ascii?Q?1EYBg2U3cqk45mYlN2P36EJMcI+zmmfj1P5nw8W+AWvVvXYSeSSWLpomUpqp?=
 =?us-ascii?Q?YTLfsexxCYus2MC705XSzDkfrAc1BA2jgk5VDl2DS0m8rcSITOxuoirKYorf?=
 =?us-ascii?Q?E+dGfvM+ZbMrq49JaUcwVrKVPfCj7hFvloSsg2uTmlwTfelbUbRttk+QESY2?=
 =?us-ascii?Q?ZiikQyoiLXrDen3mBpcAkb4qClC84tKFpg9JCATadIZNiMQ1utDhEEiHrFir?=
 =?us-ascii?Q?6xzEFNraS7me8FECqcBKunPm5m33+kofOBjy4AEABgAinI8gO9nzTQ/TrPMa?=
 =?us-ascii?Q?fOvbUjrn7Hx4EeiFDuyR++8ZFyRsvKbQ5S5NQinIYEIUXwMPiVVOILoqSBGD?=
 =?us-ascii?Q?KgSnZ5hhWrkkOnIbot1nGVAuh9jAcZSIBIBKMuieL36qDeobs39nTJbzkjAs?=
 =?us-ascii?Q?usOkjENCaDxIdTchbLdKQ8PRk4n6uw6RizWuXqJ9xhyv8ZtvLjhNAtuVeQgq?=
 =?us-ascii?Q?eAI7k2+0SX/fVmfmr1lGlX5hDlNTCYTON+fJOeXOj4m+Tfc3s0Hp+qUgzDVJ?=
 =?us-ascii?Q?hBgYL/qn7UXTWXcvOfziNKNdpbgy0YPPaCVAB52/04Mv5G4h1g4W9AnjTZ4k?=
 =?us-ascii?Q?HZTwQb6+dKIjeIYUa2wHBJb03qZanV/jhHFq4WE+KuCcs014KCHCSGQ8aEkr?=
 =?us-ascii?Q?jHnih6IIQ4Cnun0dnWran2sQG+6rHrYOmb1qk3DPK0s+LRyqmLi0Ho0XjwXu?=
 =?us-ascii?Q?wTOfdlmdu1R3CH8wHMdeO0VuJmj057nZJ3iDN7AT0dLXfqE8eu9KKd95G/MF?=
 =?us-ascii?Q?ZXx8iezpYKzflb1oWbAXNQczPzbZhhzpPtH5uAjCFJu/VmJBFC4RG/BTb1n1?=
 =?us-ascii?Q?M6G9ln+FZjlLgNeFeqo0QYlICh90lTqzqCZpR3qDx495XRELw+X9RzRvA1Jv?=
 =?us-ascii?Q?Ep+jvL+fj63yyEBd0eYjoXwVgqV6zIVHpKVq3fWXUGt8ygtklpRQ3LsR02Eb?=
 =?us-ascii?Q?ufWz7E1THqVNb9A8d37ri8wkDuI6+QfYOP0rz3Og71lO6nwtnkHIcjSQ29fu?=
 =?us-ascii?Q?0+X4XvJp8hYLaNOlL9PTlcIORu3WlnW242H+3kGxEWtvH5FiLxdOQiudsSvl?=
 =?us-ascii?Q?Ns4VxkgAJ2ESMTEiR4sjgD8KBkuQ4uBKXEux+2eCLaarfBYbTUE+dUAla2zO?=
 =?us-ascii?Q?lC9HiEX4x5dePYg=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:43:43.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd53f19-df5e-4191-9e9c-08dd666e566c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6591
X-Proofpoint-ORIG-GUID: BGhGmFL1_I7B0SFR6EqIVOpOpdsrSVhQ
X-Authority-Analysis: v=2.4 cv=b8iy4sGx c=1 sm=1 tr=0 ts=67d9f722 cx=c_pps a=OGaRt8TyNAR4X2Yz4FfAAw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=IcH8VMcKkPr75ZKuGPwA:9 cc=ntf
X-Proofpoint-GUID: BGhGmFL1_I7B0SFR6EqIVOpOpdsrSVhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2503180165

Add netlink interface to manipulate the mdb_notify_on_flag_change knob.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 include/uapi/linux/if_link.h | 14 ++++++++++++++
 net/bridge/br_netlink.c      | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index bfe880fbbb24..8fa830599972 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -741,6 +741,19 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_FDB_MAX_LEARNED
  *   Set the number of max dynamically learned FDB entries for the current
  *   bridge.
+ *
+ * @IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE
+ *   Set how the bridge shall notify user space about MDB flag change via
+ *   RTM_NEWMDB netlink message.
+ *   The valid values are:
+ *
+ *     * 0 - the bridge will not notify user space about MDB flag change
+ *     * 1 - the bridge will notify user space about flag change if either
+ *           MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
+ *     * 2 - the bridge will notify user space about flag change only if
+ *           MDB_PG_FLAGS_OFFLOAD_FAILED has changed
+ *
+ *   The default value is 0.
  */
 enum {
 	IFLA_BR_UNSPEC,
@@ -793,6 +806,7 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3e0f47203f2a..e87d39b148d8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1270,6 +1270,7 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
 	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_REJECT },
 	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
+	[IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE] = { .type = NLA_U8 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1514,6 +1515,18 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 #endif
+
+#ifdef CONFIG_NET_SWITCHDEV
+	if (data[IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE]) {
+		__u8 val;
+
+		val = nla_get_u8(data[IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE]);
+		err = br_multicast_set_mdb_notify_on_flag_change(&br->multicast_ctx,
+								 val);
+		if (err)
+			return err;
+	}
+#endif
 #endif
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	if (data[IFLA_BR_NF_CALL_IPTABLES]) {
@@ -1625,6 +1638,9 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_MCAST_IGMP_VERSION */
 	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_MCAST_MLD_VERSION */
 	       br_multicast_querier_state_size() + /* IFLA_BR_MCAST_QUERIER_STATE */
+#ifdef CONFIG_NET_SWITCHDEV
+	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE */
+#endif
 #endif
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_IPTABLES */
@@ -1722,6 +1738,11 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
 		       br->multicast_ctx.multicast_mld_version))
 		return -EMSGSIZE;
+#endif
+#ifdef CONFIG_NET_SWITCHDEV
+	if (nla_put_u8(skb, IFLA_BR_MDB_NOTIFY_ON_FLAG_CHANGE,
+		       br->multicast_ctx.multicast_mdb_notify_on_flag_change))
+		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
 	if (nla_put_u64_64bit(skb, IFLA_BR_MCAST_LAST_MEMBER_INTVL, clockval,
-- 
2.49.0


