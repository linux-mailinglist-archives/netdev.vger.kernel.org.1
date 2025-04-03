Return-Path: <netdev+bounces-179219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E451A7B278
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5677A7544
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D91E47DD;
	Thu,  3 Apr 2025 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="dKac4oR6";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="NZfGKWGh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D61E3DD0;
	Thu,  3 Apr 2025 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743723950; cv=fail; b=MC6P7la3mdX5K5A2bI1ZquBSaQTYrrl7u7wJLgHg16kuWdSKx7QFkFAojmhwSxW1eJO6ESiJhDwsKGXgjCywWpvwuYmQ6vMw3P1pFe60ndHWi90/uB+7SxxZRAQdrkAkv2+3hCs1xAbBtJhEScQldEYbYn/4JWtbUHqx6G5cdo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743723950; c=relaxed/simple;
	bh=5LDNoEmw05QEq8LNsMLKbcCFBxQ5JPYWf8vbelaa9Ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTULswjuAdqwWq2V7tcY9RbKaov4WY9xFZhwZV9AccIrkKbdP7axsAhaMLbwVidelzJJVyACzpd4xDUtC4Ibl1Cm+37UGSdA9P+9NrEaUD08N6gbIZHBPqdW5V61SKKfW7jTFZ/mC72MoScOs8NfkAuNOyKexBYzKjKzgJ9bMSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=dKac4oR6; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=NZfGKWGh; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533I26Kv006307;
	Thu, 3 Apr 2025 18:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=3Efxb
	oWe9tj7piTfwBfuaZBhriOy8K1wUgVoHO7jTYY=; b=dKac4oR68Ft3ozEyoMfxs
	79DXpw6B4OfgggRx6SaaoXISkOtXLQrRaTME3mPdKgQXd3+QjmHOdq3nL4vnHwF3
	tyj/ShlF3qi4GJtXDuAGwYUr8Lh0csfueeSJvwHcHluTBTFO5luw7g0oGB8V5TS1
	J/7SnQZushR1VrI2iNS7grNEgv80zobNiJMYsDZwUaadwj/B/MCjHYkKWDMBYA85
	4KkmdlbqT/x23lSfKl7wCSMpTuMvd2eLPAWTUow34zDwNKCSdJ1WvZ/LvQIqqTTT
	YxJXN3cTxWTBuDPcszBThaekjoTBYnYm3JGeDvmKd4aX0r/b4M/+FkWvxMpcF+uM
	w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45ssgwhbum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:45:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY+ZcNFBFUU4AzgGkKpMwCp4ItSwoWiDIFNt7Z1UizqVa/K4Jmyg16cpR/prd8/FGwuZXqKRXAbjTW58ManTer8ybpmrmBXuhhxTqStJvKbIKdIHTvog1Wa8iRBnPe/24cMmg+c1fommg2LsWoyz5TlWmPxDawFj46mJNBiKtssiRe8DTV3ZxcZ4Tk9Za4SBP0O2eFnR4qkHQOGlLRVf9WXNzCHmrVoHro0iRwcD2UyrUE/mMMg8J3EKb7+vX3FdiUphtes62ZP2mqMZotizdPjLljy35IT2Cvr922KoR7/Oy+XMO2a/hV0iEdsCifjtXzkeW59xrKB+QdRuQSBPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EfxboWe9tj7piTfwBfuaZBhriOy8K1wUgVoHO7jTYY=;
 b=gxaJlWf/Jg4xhPLQAjIud6qXHDW4c2lHdNrbFmfS+otCZcfQsF1aMXFuFv4BDOlG9CFu3FqTWGNpiea6nTJ6hCjCVHUIMNOgrp5MIrrs3a929+yBFoHf4HG8Zzn7UW7qyV6mNMLhyy22TDTv64fxdXV0tE5Ak9FysNdymBTsAtcqWXGD7jT9c8+M6ytMIfhkLhWjdCoEePkgkKg0jvNDMZc5kJWsKgn/CLXCUalSRqhUaWnLu6y0NeAddwx5dlIzeyXr+eXH9FUTiEZ8kvQriqEX6ECYsUkKBrE2FSmi7ssq0kpC/fTPuTmBIpXbHLAULLwm4tAlphcEbcOPr2L5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfxboWe9tj7piTfwBfuaZBhriOy8K1wUgVoHO7jTYY=;
 b=NZfGKWGhhouAahAUApIIX3+0+r/yzP4EMrAsueS1J77ZMfBKwPbmBe4CD7u4+/dV/U70fkMZPVHzKnPYfU7vBV7xKlp3LX+plCXqEOnI2iUCif0q+XHkEOEYxzgWJFYmUJ7YdoYaDk7t6Pmmkaw3ee+Aydq6FUt1BbD3oQjmjRzT27KQ+2Zr6mT+m/lizB65DVXWBnRjeD6gIe6XxSpnCF4rszFPB5W599oit6eXrhN9XVUe/TJH3x3exMb6GcpTGA2uOYvV7+0oj0Xdo7AZ+jlJZnXjMYrl2HjStkjNq+gywP6WsI1gfZSb+6oz4ThGn/9vFv3dHMtR8AYwQ4MsVg==
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by DM8PR04MB8199.namprd04.prod.outlook.com (2603:10b6:8:2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 3 Apr 2025 23:45:26 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::88) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Thu,
 3 Apr 2025 23:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:45:26 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:45:23 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:25 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:45:24 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:45:24 -0500
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
Subject: [Patch v2 net-next 2/3] net: bridge: Add offload_fail_notification bopt
Date: Thu, 3 Apr 2025 19:44:04 -0400
Message-ID: <20250403234412.1531714-3-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM8PR04MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 21876a77-1856-44c9-139c-08dd73099bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xePmH+uQ+bKtS4lYlJPOQ8eWYY6+DgzWwwRMRzBhbEZKwBtX5jzIQyatJb+R?=
 =?us-ascii?Q?mAuvMoU+vwBQZTJMybUx6r/axb7cBnKp5gLEQY0pC690uEZdD0cx+FI0Avo0?=
 =?us-ascii?Q?eEdBd/Rmts8T4k97yPIe8OgAUEtmuSPqQTLy3U+JnoF6IEostX83+bRDHCai?=
 =?us-ascii?Q?DcVMqKf5R8auDKhxIwZc7akRsuiAyGzBCQlqYC4z2p/aAEoAlswFHOA9a6nD?=
 =?us-ascii?Q?doRrwHezw164/xWx7MQgjzvFPc83FF1th/78DNYcbHndFQGMc1iq+WY4N4oL?=
 =?us-ascii?Q?1LVzgTuOg+JPEGuJPwCjC774RbMGEs8l06mO//dyAVWMlgMpY89hdpeY/s+e?=
 =?us-ascii?Q?tIk7QcihjHLdGraYhp2VP4gpk/qFCx2gGDKaW3rT8hcCsBDrAg0MVOgFQ8Up?=
 =?us-ascii?Q?rgtdmKafpWjwLNUv2ve+R6xFM9T+nzvUbBmvCqGPs02gUa0dzYkuAJz/0e9z?=
 =?us-ascii?Q?bUVIcLZPWTu+PfRQRUw43nbJwil2i6QKSxMyh+x4Wiygwf1NCTITVm705kU/?=
 =?us-ascii?Q?FRsFUvHwL0LOBwPckuoqg5FjMZZfwxWXveoiRDZNstIIf1T6Ex4Cok6BYlUT?=
 =?us-ascii?Q?45tBhnNCf3o6N6/9dp52ihEyOZerEldmIs2+DgEFO+d5qinLANSUUVp3/LGz?=
 =?us-ascii?Q?824x75UqeW8GHAT/SVjSXTfCQM/zMj37KaFDDR8ay+oYncVm0vfJYrZ8gTxb?=
 =?us-ascii?Q?gaZsLaU5vlJamZBSLzMDCPcWu2pjhNvOUS+O4pNVvOWVulTduwU8XoxdqBxc?=
 =?us-ascii?Q?VoMDmDN7FHDR8iwv0Pi+o9jbI3fyu7wOoTRXzl7Efy3Z6uG2skvIqplz+Kpx?=
 =?us-ascii?Q?6Ekxmk55/ny/ALKtTmeDoyc6JeICXmHy/BS3VBG3VaqORr3f1ke4TohXxvwG?=
 =?us-ascii?Q?OTgnefBTQpeb6Rc9FmOlSnhgOONYPnPuFi5cf765jToW8TQISV7Th46pvIPZ?=
 =?us-ascii?Q?l34X2M6SB/5oP8QVo555g2fbWzP2JyWJagbryYQve5J/mp4cpmMEqZyARC+o?=
 =?us-ascii?Q?fnj+vssLBbE0tdBDqYVOaaMr+KtzaVJ+iKnQfjfytMpdt1rtB92SFNBCpkJZ?=
 =?us-ascii?Q?VA/PtlJrH8pNRUReqksvhNgHubpnmKoWOE9JypYmDggeuFlu5RWmaWGQ0366?=
 =?us-ascii?Q?rBTozzpdQSSo7JhmBWJ1B4VRQQaourMMGNttxzeD3FnzbKVIKkuXGHNFsrns?=
 =?us-ascii?Q?Ov9aTjYcPQvaGuy0fCp8qZmzRCKcRzxiIr1MJHZQuFZEH0ijxVy067eyJ4o1?=
 =?us-ascii?Q?dHG0740YkrgtcKfD0COREshQN7Esajv1YzLTN2gtFUrLuYBALdFHrN7kicAS?=
 =?us-ascii?Q?sdHjz0hICgD5db7GGXGiRo/Kd0nNaTxJr3C78+XRG4NvbHc1w5bLmtqzA0IK?=
 =?us-ascii?Q?AFByeidAu5NWQ96qXo0gVFNz2X2fVXentrCk8orZHxTPnwWJrRwFgSkU0T1Q?=
 =?us-ascii?Q?N35zkgQw8qU6b4you+OIVWLLRrlylQtJ3zePtarBrObymkYXIfjTUgkxg3iR?=
 =?us-ascii?Q?Nlk5aeJzpSMVUJs=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:45:26.0094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21876a77-1856-44c9-139c-08dd73099bc1
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8199
X-Authority-Analysis: v=2.4 cv=OcqYDgTY c=1 sm=1 tr=0 ts=67ef1d98 cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=VezfpCA85l8IIUIIOpcA:9 cc=ntf
X-Proofpoint-GUID: 20CpRuu3gamEM1sYqNuxI_11xRXmK5lU
X-Proofpoint-ORIG-GUID: 20CpRuu3gamEM1sYqNuxI_11xRXmK5lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=882 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030126

Add BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION bool option.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
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


