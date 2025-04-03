Return-Path: <netdev+bounces-179220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D27A7B279
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE143178D61
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268101E5B74;
	Thu,  3 Apr 2025 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="X3hRnVgk";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="IqaezgIR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A311E3DF4;
	Thu,  3 Apr 2025 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723950; cv=fail; b=pyIpiM7D6pp+/DPIWuti0uZvLdxk9/wurmB0SH8YYycrRjwuF2msVscRDyIj31gEzq3HvCyJUgj3xf0rD6xRsPZH8oCx+2BfB8lDhCiqo2bGVGsiH8YeP058MJJLWZP/sLC/hoH2zeiXTlG0BvMyFl/mW/Eibrz4vkL+ge38jFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723950; c=relaxed/simple;
	bh=1TJrK9ti31pyhSm7AV1r76/UNVwua3CK0655DlwK47E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSLUClXcGpzbeJjgn8Wjm+K0IFNtIzzyB63KBPgTk1mPQNiLad3RGXFFo+7r6orrVq8DACQ6XatW+h8Ext6+bV+9ddj7rl+zVTHvRZhy2S8t+nab+KcAw3XH8qDqc0D5CVo4PNWoWAxR2qVRNQVK9drY+sHEIwYfuA2TEy1hVok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=X3hRnVgk; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=IqaezgIR; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533Ndsaj018207;
	Thu, 3 Apr 2025 18:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=jCjQH
	+qhPtAADqXCrcPT1UwXWjr/TbxrPuO6RSOgKDw=; b=X3hRnVgky5YHXW8bLsoux
	AsGdYEo0Gv+Lm+RWfrF4aNOgIyHI+k8+ALFd3yMssWJ+I/OiaMhthvQ4MLdi6YDF
	taapPCDey2Pf0w6NDAqaf3kN+Wd2b6D5FuoWk2cBx1jWr2U7lw3ccZtR8hdXSeSI
	B327N8xmBtr2YeEbtVAcK1jZ/oYNzOm4OfVGdxXn8m9yRGBvhaZRpEUWSlwtNbLi
	Ws2TBzugYP1nQns3ID4LgcSV2M7X1C4McaNFtWFdCfP8xOBEeY05doO4eIC8S69u
	+Q7iFY4e7vCzKloIhVtGIWdRkgNZogRrsNym1NvjRqwicq0AqE7LewKxTH7/xDue
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45ss7j9cfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:45:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCEbaBLYET4Gbjsmd/geiSG1hyL5uFATrnfRxxU/QarEULrCHOMKjKJVQoXCQ3GdesDa3bIN53SYQ+pJz+pEP/HEDsJ6n6DPL/O1o5tHtw0zcgksc2ofnh8c6A9k7TPID7/e47l/rKebRy0ZKBMJSuVkWfG+hokW/QW4QueyuQlFP8/eAi8vR5Hw7XFfGoUtZupAqqj6hAxnlIJHn5yWSp0Hk03LVsvvIWXzioma6ylZIo06PufARpnwfVun4mYNzVTRsM6wHosfQ7degd/znCsCLAbS0ppZJK+QNnBXYQOGPxIy+qj+PJOT1u2dWgctxFZpOUThD5K9wFKu8vgJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCjQH+qhPtAADqXCrcPT1UwXWjr/TbxrPuO6RSOgKDw=;
 b=CC+UWJ8BmkVhW5JZd+rN4u3zbNV4J33A4eLWPCC2SpsWE7PrZQa/aFPLgeHm/ikGN5vZMXMqUaf/PfqZhdnarY4QSByPqQI54rFU1yKP5d5O3nGLSdM5vG+bEQKwYUImaks1JE/sNtZC6yMkt5X9DWvt1ZR78H3bJOEbaVF+kCl+wAFUNQCfAiqsGT87lDv1iT61BeBd2SRrg5Sx/CBZY0mpF2ShzVNXK9+cwxNN59LkoIbYTuBaknKFPOxsAPI7AtkiT2OEjT0tPayrvDsRI4U64l8U8RHHDkneXU9jkZzOa/SoQcXrOSsaX9siCgcStzEtYPHY6/H4wZfOM+/eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCjQH+qhPtAADqXCrcPT1UwXWjr/TbxrPuO6RSOgKDw=;
 b=IqaezgIRqvnQjuNoZJ/VM8VpnMBJDGcEBwL+GKrLtVSBClpHKeUP3/Bi2SEztSyy6uETPVWXlUQIp/Q8KZK7u0p3ZhQJnGVdYXPZTKgSUzoaxvpDBi4J2g32l/EqYQmODOy2P79p5PzgBcNjQGo1O3EhjSzZVcQdLMopgCxxYRPPZGui2WS4AwnVZ0J7UgvE2aaoN6QIP/7Jj0CsLBmEc3fU3Dq5jdh90L0+BtZDdCS6I3ux1ShrWuoCd/nJlyDetsQrwpVXGLvgmjVB5Z9G5637KJwoiM3bEICsi0EuxSnRs3g/g/tjZtHrepq+7IjqHwg0YN5Ds82JAdpikcyL9g==
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by SJ0PR04MB7615.namprd04.prod.outlook.com (2603:10b6:a03:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Thu, 3 Apr
 2025 23:45:30 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::5a) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Thu,
 3 Apr 2025 23:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:45:30 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:45:27 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Thu, 3 Apr 2025 18:45:29 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:28 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:45:28 -0500
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
Subject: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload failure
Date: Thu, 3 Apr 2025 19:44:05 -0400
Message-ID: <20250403234412.1531714-4-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ0PR04MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9da522-1031-4ddd-e07d-08dd73099e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YWvuJp/M51q674FiXWPKslAoVhbYD1K2jELbTrx77w905u0PfsITk9b5bSra?=
 =?us-ascii?Q?MBUDHupmiEyERHXfbo01SaHdlxbpveR7x58ghGpfhteWcE3jWn9xEdQ9/ac0?=
 =?us-ascii?Q?Dyu6gXm82r+DuVdKwf372M280LHYK5mQFYuanjqp0NdBZly0KQc7ZcfHwb8R?=
 =?us-ascii?Q?Xp7+SBQpVsFq34ld7VsGA+adeMMF8hCBnNXpfFfA6GnuzZcYU1bbyrDGH2sI?=
 =?us-ascii?Q?U7ZI8GGGPucxEhrCXJJQ2Nf9pvxVw6dwXwXeu1RKUqv4BMC7PMLDU9XHeBbC?=
 =?us-ascii?Q?YtAolEI64jEzb+GOE+NU1agxOsYmJFeGzVB/YkWXKk4sS/oLvyE6RHBmtLvG?=
 =?us-ascii?Q?zp5IUTXpyjE6X2FDoto8YkGtrgwGQOhzrQFYbUaxp02PDLdvghPqRa/nV4pp?=
 =?us-ascii?Q?nKujy8FUIoiiTDza5dit/fdJ2lv8OSishylqljFnjQ5UUZDB9qUliUBfZcVL?=
 =?us-ascii?Q?NTJwyR2OWuV0OpEhzTqbU6Aq2iBhLl9IHgPwdE3MJPwsOdzt0wtbVs3XH7an?=
 =?us-ascii?Q?lSLArSOM+hv/rT0GUcrOYh/zdTTTeIMUoN8eSV6r81fku/EWBzSzbq4D8Q7I?=
 =?us-ascii?Q?J+69tmbaB4Szo6/LB7QN/wKYR2LzTsFloqw7RpvQfvIrM6ONaMpVGq5jXL8W?=
 =?us-ascii?Q?Z+9on8zKJ+ZqJENy2pQ57qSnlhOZZ/4VHG4+p06jNWbg3leUklkjUkzm4XSk?=
 =?us-ascii?Q?JNt77DjMVPtb51aESMUR7QCifKUS+WRSCd6W7KYqCTn+PcRll4psOBGj3T/0?=
 =?us-ascii?Q?Msw01H71DoRC3m1wXp/+S3uNI7wj1GbRT0Y3nkSMIT6Oitr9NP4L2iHl3Gc8?=
 =?us-ascii?Q?aIVECM47+NCcLt6CObs82g1rTDf2EoZP9MmpN5YYe4T+DkImSvYtiU2EijpD?=
 =?us-ascii?Q?S84sqbBIALuK4nv4W7OJE6WAqsZCAEpOqd8YibOGU1tIBbyYAaU4cMr3DLVk?=
 =?us-ascii?Q?nIU5jpvpXo012BdqMmlQVgwyrwlEJ3jXtdDDS3WpRg6z5OZaQK1dVWEzA5dB?=
 =?us-ascii?Q?/Aoa72OoYV5BYpCSrUjokN8+IKU4tN07LsM9vGxND2eStD0YBmA/dyPhwS1o?=
 =?us-ascii?Q?hzAo1Nt/A8FZBjPq/Gi9HioH+ZaI6aicu2NeYTpM7zljEUKgbgmj/k6Df8SX?=
 =?us-ascii?Q?h/ol+6s90JBH8On7ZcuetKx9kDruL7KGph0pyCmNEZHwCRJd4FulywDJFrFS?=
 =?us-ascii?Q?ilJX/O6jxr1nwfdNSyAovrG415d24KeN/q+QQsGEqrMB3yUu8xrDTEuzon/U?=
 =?us-ascii?Q?LRI9RPlpDBXlxyHga79BMae4QPAZdcKQ5J7fD+9rso34miZBWS478pGpImO3?=
 =?us-ascii?Q?um/Isfp5LznkYQDd/Y9EBBOK5dhGgRbNo/c0y75RU16pv+TFeJCeJhEhr2bP?=
 =?us-ascii?Q?juRgSHfSRGC18sVXPZiuf73Xr36oYa6wdmvJpYUK3zpQtEd/V5CPNLWw6k+c?=
 =?us-ascii?Q?4B6RZFml/iY94LEZNNSsrHDJfd5XPAwrPRb8FP55QycRB3v616J+WIcWVskK?=
 =?us-ascii?Q?kAr/rNCSDIuh+gk=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:45:30.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9da522-1031-4ddd-e07d-08dd73099e57
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7615
X-Authority-Analysis: v=2.4 cv=GfQXnRXL c=1 sm=1 tr=0 ts=67ef1d9c cx=c_pps a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=kv1pVitMRhVdw8weP3UA:9 cc=ntf
X-Proofpoint-ORIG-GUID: 3acdXBATy-qIANphG6fmeK7kmDGk23ge
X-Proofpoint-GUID: 3acdXBATy-qIANphG6fmeK7kmDGk23ge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030126

Notify user space on mdb offload failure if mdb_offload_fail_notification
is set.

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
index 40f0b16e4df8..9b5005d0742a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
+	u8 old_flags;
 
 	spin_lock_bh(&br->multicast_lock);
 	mp = br_mdb_ip_get(br, &data->ip);
@@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
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


