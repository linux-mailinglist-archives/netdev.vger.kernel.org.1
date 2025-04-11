Return-Path: <netdev+bounces-181680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195BA86143
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BE319E9040
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5220C47B;
	Fri, 11 Apr 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="N4JKOr6a";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="BZULEIfp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8026211713;
	Fri, 11 Apr 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383902; cv=fail; b=GL6lxVuxNg+QqAo4r6IbshNPa8h/Ef/Rw60CSVLKQFGXGM5gZyN/25vH482nmPz6CoUVVMqDaNaChNPfNd1Vsq3oZGUo+GMGvamuXHKVuXe6shCZQYZ1N1sxfsgLi/uYQaD7ZdsBzBgvWEwMRFSL9rYMcA6QQ7wrXFUUjfLiwYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383902; c=relaxed/simple;
	bh=8eOaF6qeuqRJ9Tp498jjpNMnDdUc7mdguYhhH8Cnbro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw/zUW061XZHvsVE/GzaUNyThhRLGs9pUWuovHM4CEEX8bAFellQfaQFHVfb+fuHGOBtUN3OUY/zXhjJ33IvxGLUd+J2MCcGPBLRGyTGEmBdwV0PgOGsRUo9fpixNmFV3Vhwm1fXKolA9zBCL/tt++z/KIJOV8NgIJ99n6VFJBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=N4JKOr6a; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=BZULEIfp; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAodYa020079;
	Fri, 11 Apr 2025 10:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=6P3dc
	QHYLhvZ9lkTin4ugOR7tPvwhl1NEwiH2IpHxnU=; b=N4JKOr6aZBb8A7jdX+Irc
	XNtxEZ2iDliVe7KHeQRaHWOzg2lnGtii4yLKcWE55sB/JO4yImKAamPTlv9Hqs1m
	aHeoj6mNi44Yx9gua4j+MLTxcU6JeOr6UMXrgmZDZTqfkgzjebddvDVxnf13B3Lj
	2rNBiziBkJ9yytrWUFx0Was4jBduWUb41mPxqhfSvkPY2izCKNlGGaXL5Z6vIC+e
	4AssUsTmEKbgHSkVpH1P6aHH0NhIbNsNz180azxx789lPSeJH/iIC4gioJkiFV20
	rx5C6oIRg2eCHcqEdzL422gAkog+FZoUGcfTRJXQnxyCXsown3LOO+C3nC3OdOkX
	w==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45y1nr0efq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 10:04:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CStxoY5z2yzUjxrFe+p4paJkOSHxixIO1h1kbEAhedR4XVcgqlnveaUD7D9OBRZJsLLKRWH4V2QcOFlZoqBZaakXDY1xtTY8H2SlxLCREzLvKmPUPcnIaL3E8peG7ekXxSfWELt913YdtFHLO57EthtqaO6hmBziNqCnBFA6ZIlCq8GuS/n9RhHuX0BGsJFZU+hIqcxs5WcqXxCoIjTWILLgUIxUo5FaPOdwFcSHluKLCCPW84ndXOPSrjc4tZF+mJaWYskwhD/Gbac6YShkkwy8lvXWUNAdk8qbwCuDUX2vGH+ZBIJqNRwMogYiKb5aj6OhuklP2AbEzyNsRGzjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P3dcQHYLhvZ9lkTin4ugOR7tPvwhl1NEwiH2IpHxnU=;
 b=SVvs/oYdyp5GVHKx5Fx6ZE0u/H9V5SASbOtMbhgazv3c89Hl2AV5KN6Y9t489KTBvL4Cw7vDhV4OxJu2tW9bNMSPl7NfBc2ustNGpVHQ3An8Zpub+Cpd8kPKryLWSOHP9kUfC5K2MBn5udiAtTpHzT9gpVdRoDogf9rsOX/B/SXJbVJZLVsRbo1wYMD3480kjZTjNWYmNzQ4h5yK6PfDuOeh9VVRorghYWwvwWWV5nZZKkdqPaOnXftwU0NtAO8QlS7YjAgQnrEfizpwdzz69/l0Y01YGUJi7xOxn/PuBLCBU5MA5eYbnh4zypee+uvJ9y78TMZn4MYLmkVnus2lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P3dcQHYLhvZ9lkTin4ugOR7tPvwhl1NEwiH2IpHxnU=;
 b=BZULEIfp0UnmTwEERuKJ27XSVwWrntZjGHBh203fWgKqFN5kwmiitFFCGmsBytcDIuQRAfE62dIea9nioCQf4HEfoh78npx5A9XHJJLTavrjcsp7SkOet+51WXem2Mpcdgroak+8sv9iYPqm8AoLGn4Ib7mxKG1BPDoxdR2NJ+C/lSH9neszuzIvq+oNl0MeehpNJ4w2GWoZbp9/3YgJqTr+fGLKct8SyS11geAiBYiGmH3whePrMKk8qxyb6gPtG+mZxw+4soMSzkaTCPyALAaSNRzuFy4BPxLFHthsmN0zt2NP4a2CkHQE/fSodh9pUP9SweLUIgw/zUeqRWBfPA==
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by CH2PR04MB7110.namprd04.prod.outlook.com (2603:10b6:610:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:04:29 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::12) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 15:04:29 +0000
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Apr
 2025 10:04:19 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 11 Apr 2025 10:04:20 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Apr 2025 10:04:19 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Apr 2025 10:04:19 -0500
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
Subject: [Patch v5 net-next 1/3] net: bridge: mcast: Add offload failed mdb flag
Date: Fri, 11 Apr 2025 11:03:16 -0400
Message-ID: <20250411150323.1117797-2-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CH2PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2f83e5-839f-45b2-8abe-08dd790a28c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?daaL+vIAWQxmyNh8id0feKg0O1xiarjge4VAS6ZiENIUGTVvb+81k5GOMV1O?=
 =?us-ascii?Q?eo/5PKPR2IqLAe71jskWfIkHP2T6J58ej0SBfIxSj1zzt/EljgyKmNU9oLfo?=
 =?us-ascii?Q?ngQhYwlIr0KQTt+aE4K4wPSzTGGpkaFqNRQHVcjfoNifCmgqqbFv+i9znGQb?=
 =?us-ascii?Q?/DulC6u4JxIfPHB7qYOeHy5MZF+yP3o67iZWn7efBOZH89veyLsAJm0E3Y6v?=
 =?us-ascii?Q?yWJaOBFPCuo0LqmOk0VfeKv46sS3Z0BSmdAuLTAq9E1gZP7tbWz8ufDooQ3p?=
 =?us-ascii?Q?Cfe0k98JLrNgaHw+hlqe+20yEkcjQkDJc3UpnW9Bd8TTRkuGxl0fCHyvce7U?=
 =?us-ascii?Q?61WGwCc6+2e5BzW0C1b7XBXIvrWtlqbdw3iqisCdd/MsnN3vlRx2thmSMx/6?=
 =?us-ascii?Q?QpaqhqiuD0bN3sWj340vU6JqjcNQdw/yGDCIfTh4qEo+xbxL7kiqeY8NF//H?=
 =?us-ascii?Q?jRI23OI/QGjbUrJTfquwEwSIIo/9WDJJ1pjiMeuqxWJcupRq0ihqescLhtwO?=
 =?us-ascii?Q?aq+ONcoAjj2bOQvOrCt5LfLBGCnJyPHjJAuyKjxWxhWUjksGrl2/kFvcYGGp?=
 =?us-ascii?Q?W2bImzMf/Ygb3FKC9dYkAxBOvUf2tqedes+dfh8ePdSPRSLV7hPoum8xK2U9?=
 =?us-ascii?Q?qisC/uTsZ9SoI0eY8EGCCHLlIqN9MLehrj3LAHBB+z12buEadTt5+aE+nBsJ?=
 =?us-ascii?Q?UbS1oa2zTkfeqdd//sYtTIyxw/PCXQipPwRkUVFbjj03wfuLc9v5qxaNeh1U?=
 =?us-ascii?Q?aGiGFBWziSY5HfO4uc/j4PSQWtzLR1x09TmzWOKDFrmnnDTMO5/FBcgQbRDJ?=
 =?us-ascii?Q?WHM2v2Rpl/2oGgQRIzypFIVoBCVhpbpTYp4VkI43jUPccvZgEeDDLOmpY1C3?=
 =?us-ascii?Q?BHVt4MYfzJqkGqDZLePIZE+pwTw0sK20neA88cQn+MPjTJdT/iFBCdfAjc0Q?=
 =?us-ascii?Q?mEs3j/XpRE3nZ6jNO8BzTN6YnE8EMTga+1hNmbwOz7AHGgy91NZy4UZAkEPf?=
 =?us-ascii?Q?tjUCCNn6/iB7mTRL+w5Q2rWlAfX080nlY7qNs88Wbodyf/F3bJQopsXAVDj0?=
 =?us-ascii?Q?FHlmRevOfMU7klbbpGAXL6IKFbDj6qXFa/HFPYpVhqRFxdMyV6sTa8ZbKGn7?=
 =?us-ascii?Q?J2bijXUj/0cUb/0J4k5Y2Nkg7GlrbbwMHegS0WA9iRuLjbuV+AwL1Z8g3k/B?=
 =?us-ascii?Q?2d88frpu8czd7+YVAr+gP+pGGJ++Rb8XVCT//cr1iSMMzyo5HdvPcm6ilrSm?=
 =?us-ascii?Q?l/IRdPgSDasWa+LfvR52ct1qUOZLVVw3z3lmEwlUKkyqwGcL1AmJXwgoM4wI?=
 =?us-ascii?Q?s58WWJokfYCNJzO/jfn+QLXLZk0MrL2iEbaXdP9pL3tSg528QzWigLKYGNdY?=
 =?us-ascii?Q?3PLLxHQvtS5JB3a+8iGHM7OJIRQc/FytjOx9loi0i6tSN6FnQJZVoNMGcbNo?=
 =?us-ascii?Q?/4tooc+9hNMMnt/n56bw3WuX9TPW9WI6cmuWaClBS54BN6ixFm27nEaTGRbt?=
 =?us-ascii?Q?iqRmUzU9QAF9Q7cLALugpBEL/xksZ1aIxja5?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:04:29.5937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2f83e5-839f-45b2-8abe-08dd790a28c8
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7110
X-Proofpoint-GUID: cWxsosEibt09JpexgD0F-kCWSFx714Ha
X-Authority-Analysis: v=2.4 cv=K7giHzWI c=1 sm=1 tr=0 ts=67f92f7f cx=c_pps a=joY0rRILPjs92yFVhGOM/w==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=5MufqnWcH8VpvfedoaMA:9 cc=ntf
X-Proofpoint-ORIG-GUID: cWxsosEibt09JpexgD0F-kCWSFx714Ha
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=991 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110095

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
index 7b41ee8740cb..2d769ef3cb8a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -505,8 +505,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 	struct net_bridge_port *port = data->port;
 	struct net_bridge *br = port->br;
 
-	if (err)
-		goto err;
+	if (err == -EOPNOTSUPP)
+		goto out_free;
 
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
+out_free:
 	kfree(priv);
 }
 
-- 
2.49.0


