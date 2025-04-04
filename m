Return-Path: <netdev+bounces-179403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ACDA7C5D0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A091759FC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC20182BC;
	Fri,  4 Apr 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="hE9o2Wfn";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="eOCBVL9z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FD1A3142
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803635; cv=fail; b=bKNqb+0DiD2z+YYvy2XNYADxYYWmNi3yQmpt2JmtVr0rNpNN8NOpIoAPzBQAwrRGFyq9Wv+6bS7fuTGEKTSVn5YToYOr5EvRuJTCbnVQtxvXheMaXIiUNcT9enBgmrIDFpKgjFPj6vhg69RnwbcXfr9OKwLKdqCtnUM32apbNFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803635; c=relaxed/simple;
	bh=UkqkDj8+BRac2XF4vBJbn0GzK/yp+WWOnFyG1slOUKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8AipLnI6dPhxl60dihxpvKz9XBaVyrOhbmUoeIAyiSG1Z9OsxXXHP0QuEShGMfLMW3UMfjzSHHoOlP5pfeXF0y/U/l5GZ8doQT966ARvySF0Bi8IPsvKDGi7Xtsm3gAKn5gN/kSN6YuO4MRGhVWlOCUTRxwnWM4KpYwVbQro48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=hE9o2Wfn; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=eOCBVL9z; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534LpEwb006262;
	Fri, 4 Apr 2025 16:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=vX1kA
	U43W20zn2VKiWhwmwI7SAjyOnH39K366nnfruM=; b=hE9o2Wfn2RrKy/nq0M+di
	ZuYsaBV5bmT3WAR1ZnMps/4ApkIMoqOZ8jk3dZJgFUJABHarYHswiR87q2dvsyEX
	iftMgHBPNekI/K8vrvgz/TJEfKevttuysaOf6i0Jjxw9yfgRugy8WrpvIkewXesX
	iLs/lBJjghvA76oVNGTjrAPpLhJo1cYScYgLXljWUXSQ8Dwvr4kA/5nuJKySB3Bn
	zP/vyHmiR/0qLEZM4p3f8zemSuu/31W1+KJWuufnfSduo70UV4Q9GQt50KYCf+MK
	bspQjphqyGQGaSsKHiWhtdgnl1k/bTDTtU7UVGp1FJE8pL0ZvPFhqhdj5fcVgmkA
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45tedhs0mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:53:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK2TdVBvbVkHElh61eTdwvOBu3vX63lX1Q5rxnIvCFWqC++cwtGQ0EfQ7JqEYrJNrg07blXc/Wc0yJHXWZUyhanZqu8zt0suvw2t2ULYPOHVfQkosFwRVoJFaceXIObGzLHllZcWMgbUMElyfnjALXI9F/Ka9r9VSYeU4b/3l5GDSeSKcoxPYE5aBy7Iz9+VDMXV6KcJZBkjX2WJX7HTMyUr6p+EvIgMAgVe/PYw5cN4N4Pnnt+KAr7MmY/fS75dYSG8oEEX0nEjU3xJz65o4phv0SrAE8dgQteRql9XHcnCMQ7Nw3YsSo3WWRCALB8o+keFJzAl1NH2oJQ3h3MKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX1kAU43W20zn2VKiWhwmwI7SAjyOnH39K366nnfruM=;
 b=S6erIWka0+EcBk+hJP/tdpjWZcfrz7jiTWhy4Y+gXtLA6MevE0b6lA/G8u1XEKae4qTaHh8h8U7/5fWJcKGLciOJiqDUsmUs+imtbcisraVPamcdcKzeVnVEIgp0o/dE8zoeRSLHVbEfN8AzJl0zDC/xs9s5Y65FqleVSvJ1eqouQ8rJ+SPgK2Zv5JoHx5qDBGERZphJiBcVkgK2Doi50YB4n39FAbRIA2ToZHik2lZ16BcJYgrz1FlZgOZQ097tiQRV53jZ4y4uuWEukx59VBpRmNyNd3TA8fYVAFMbI+hqL9Y9VFHVewNdMi/EUrD36lsoVobsgm3jcraNEKPaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX1kAU43W20zn2VKiWhwmwI7SAjyOnH39K366nnfruM=;
 b=eOCBVL9zAFcxiVI311Pi3hQUqQs/wX0RErs9advAlgipxTxG4IrksIdah5TOiMCV6c9vcrYtGMwjWfPw7Q+ebAF8yCgshHEgUgMexHlDMnB+8KAfdE3kd9Mr8CroQDlkS2AOYcVQyNwpl+83VnkkeztPByOorFAeQTKXRQ6aKp+Zq8aZNqm7P+BbVKNnw74smSyTnUnaoi8v2wpTmlwHayE9+ZxZX6VEpzzYC8UHPZSvwDnUI0wv5L4J98QEzTsnpPa9c+fQyxcpuI1l9Tw1zyKMNsJ2ktaYuRmvoqKzkZx/N8zCzgWLnTObBzvC8BP7vJRky/doIRhgqhh3PXGE/g==
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by MW4PR04MB7234.namprd04.prod.outlook.com (2603:10b6:303:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Fri, 4 Apr
 2025 21:53:45 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::d2) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Fri,
 4 Apr 2025 21:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 4 Apr 2025 21:53:45 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:53:43 -0500
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Fri, 4 Apr 2025 16:53:45 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Apr 2025 16:53:44 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:53:44 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC v3 iproute2-next 2/2] iplink_bridge: Add mdb_offload_fail_notification
Date: Fri, 4 Apr 2025 17:53:28 -0400
Message-ID: <20250404215328.1843239-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MW4PR04MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e5d2c1-3d1b-4e8e-0838-08dd73c32c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sPCB5kxxJAymDEIdSykwVr4DeLN2K5kyVrmI3ss+b/SKKfoVqSiygB12ULNs?=
 =?us-ascii?Q?n40IyDpG5NpRnL7tMH/JVSoWSJn5iMKQtq9WHLHB1n9FEhnjbmYTleI6l66N?=
 =?us-ascii?Q?/sTTd/JTdUQjiBSdx0I5BRnsrXnOXsgUZ5IDMi4Zi45/3j7tCKAJzi6EWLle?=
 =?us-ascii?Q?kIs4kfvC30amVgLjuHiUo0Ooszd6wVTLasYcV0NZHrN2aaBmhnjZfHSsJQu+?=
 =?us-ascii?Q?8TpifU3u5l8Pt23WZ13s3hUYsJW9sZlPq172TF4KGg5FJTVyTJuyxKSGfV+S?=
 =?us-ascii?Q?q6sunqHuGjhjc1pcTz9Ji4pj419lUYytj3ZsVpbKWa+8frvwY2oRDJ06YHkN?=
 =?us-ascii?Q?ZuU6w1e/Sy9/DQIAcBPIGNvrcNETgypPAjg63YzZ1jx3sEDXoc0ySGrw5d0L?=
 =?us-ascii?Q?pGuQ+5LGikgF4WnoUVT/jC0bBLtwWLNQioY5hZ7qzeB4IZlhykbC+zrAQxJg?=
 =?us-ascii?Q?2G5LO8y/ZXtprFQl3aBkiHJDGOavcCkjWnsl4oFCGArZO0mZRXCLwCoJErnK?=
 =?us-ascii?Q?AbMtihTjS+dEh/GGgGoR9aG7s475JCOSCzigqPNS3krpTDUzcR+HtsbJYbez?=
 =?us-ascii?Q?M2fJDguoKnmEoWr13qgfP0xQTAbhsS+y/Y4CALGtf4hYsiu+ktGlh4zwsTmM?=
 =?us-ascii?Q?jQIe4MeVnoIKgWxKxXfHtjIWVpcFHh0Bfn21oQmiYt/76NCRnepZayOeS6O1?=
 =?us-ascii?Q?d5qu0QsbIWd3O/LvqkqkTrBDiQQtfMRX/m3Wkv8I7A07Qqb1Rc9BSO2x2KzW?=
 =?us-ascii?Q?FQJLJnQcmGx9Y3IQtRlz+069obryQ1wWwIwrvY16mFFYh+traRHtQG69+kZj?=
 =?us-ascii?Q?T4IoV8/ZFjQ+0SsZk3iQENGJMmWsVTWQJVbW5qcpumLR7KsL4LHqE+quPMBH?=
 =?us-ascii?Q?1C4UhItgzL2WMn8qPmFxocSF+eXhKBdPT1yVXg14xCyHRfLaA9biIeXsmyDw?=
 =?us-ascii?Q?AQBfNtzdYQ8F+yBmdL1sUstkpz/KgPRXJjsWqybNA0eWVeYHEJPm1ttd68Rt?=
 =?us-ascii?Q?U6HGPUNqQeTvHexs6T87wWLB4Gl6wxnLOivOGpN3TuBDWQaNbgpGx/u0QyFG?=
 =?us-ascii?Q?bpQ0mzx553MzXYNIT0QCLDgWN6qujsURWgEJL/qEgikAj3Ukug3tGHT/NjCS?=
 =?us-ascii?Q?10qDUxcx8AqhRjdPoTGed4erpm8thaPhksJedcs9R+H/wV/3vyjc1X1LzllK?=
 =?us-ascii?Q?ORLpWLE50W7ZrLWfDqQ8Y387aqVMe3Ztd85KqNFMHe22QShtZ0mTHQQXW+8i?=
 =?us-ascii?Q?HERCaaSCv2Y2g86ob0c6Vem7oKQ9Rw3FaFXVUc8RnTX+C0mHhmrojYyEUYzn?=
 =?us-ascii?Q?a1JdI2V+eEBGJ27krcSnCLFMlDR5Po9Zd1lM/gGZ/5zwV3R+p/CGVZDuyz1H?=
 =?us-ascii?Q?1amn5ZYzqg6bsxGcXCs4LyCoQYqACBrfhgtNJ8Sv9gZzzrZjNwSlfHwf6c7j?=
 =?us-ascii?Q?9U4Xsis6II+Z8lSlYAbKaFid+Zl1NhAadz/jPvYI0Rdg6eJArxYXwhWAqmGd?=
 =?us-ascii?Q?E/J4CwvpNsFl3iM=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:53:45.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e5d2c1-3d1b-4e8e-0838-08dd73c32c65
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7234
X-Proofpoint-GUID: GPin82c0k6KfvXmKxdyZO4uycL_TFL1V
X-Authority-Analysis: v=2.4 cv=IO4CChvG c=1 sm=1 tr=0 ts=67f054ec cx=c_pps a=4HTA/yvmbQxnAJvhdENERA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=Vz2XUcs1E-zsfEpk1-EA:9 cc=ntf
X-Proofpoint-ORIG-GUID: GPin82c0k6KfvXmKxdyZO4uycL_TFL1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=936 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1031
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2504040151

Add mdb_offload_fail_notification option support.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 1fe89551..c730aa68 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -62,6 +62,7 @@ static void print_explain(FILE *f)
 		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
 		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
 		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
+		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
 	);
@@ -413,6 +414,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
 				 nf_call_arpt);
+		} else if (strcmp(*argv, "mdb_offload_fail_notification") == 0) {
+			__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			__u8 mofn;
+
+			NEXT_ARG();
+			if (get_u8(&mofn, *argv, 0))
+				invarg("invalid mdb_offload_fail_notification", *argv);
+			bm.optmask |= 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			if (mofn)
+				bm.optval |= mofn_bit;
+			else
+				bm.optval &= ~mofn_bit;
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -623,6 +636,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
 		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
+		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
 		struct br_boolopt_multi *bm;
 
 		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
@@ -641,6 +655,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mst_enabled",
 				   "mst_enabled %u ",
 				   !!(bm->optval & mst_bit));
+		if (bm->optmask & mofn_bit)
+			print_uint(PRINT_ANY,
+				   "mdb_offload_fail_notification",
+				   "mdb_offload_fail_notification %u ",
+				   !!(bm->optval & mofn_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index efb62481..3a7d1045 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1753,6 +1753,8 @@ the following additional arguments are supported:
 .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
 ] [
 .BI nf_call_arptables " NF_CALL_ARPTABLES "
+] [
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
 ]
 
 .in +8
@@ -1977,6 +1979,11 @@ or disable
 .RI ( NF_CALL_ARPTABLES " == 0) "
 arptables hooks on the bridge.
 
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
+- turn mdb offload fail notification on
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " > 0) "
+or off
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " == 0). "
 
 .in -8
 
-- 
2.49.0


