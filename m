Return-Path: <netdev+bounces-179397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892B6A7C58A
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911CD1B61946
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD7121E0AC;
	Fri,  4 Apr 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="hSJe7cJD";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="T5+RwHTo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EA91A072C;
	Fri,  4 Apr 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802250; cv=fail; b=kSa2ka1wCN+ykg5zpxgnf5ik1TedkRvHkJOJ4melbZOKyKJmSqlramRReTiWJaB52uujIvjSBX47nrSkvD5heyn7/yzSL9GlgfZwehytSBfl0TU0Q5mszmM0nLhloQAMePEApiOahJFhmqTzkhf8UE7q50rqpweWQhwQhZ6dRCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802250; c=relaxed/simple;
	bh=WvwId8o0Y3S60WLzDglZJS3tCzTqCdRNHXEE8v4td1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lshu3tKUJMHsShi19liFAKzKyMCq39+10CLPg7qgD3J1kQNwlU+Vha40pAO8cXHB1FElCMpI5oPgO/AMpLGIiA4+Qn9DnibA5nHkhRoTQDlNhXVKGFMIkddjJDsQFHnse8qx2cvgzrIIr2sg76nWe3FIV4gHStBnBi6cELu1DG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=hSJe7cJD; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=T5+RwHTo; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534JXBmL025122;
	Fri, 4 Apr 2025 16:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=f0v4p
	PXThLv2NUyDcTSdxRWJMQ8/3WX67gNvjLsQXqs=; b=hSJe7cJDq9wWKeX+cHmhL
	qPCf3FVletm83bGzrJH19Ordrm9FoVpUPYL1BFlqJWgGQqPTx5z6XIUujtlduQj9
	OZwxFq6hfAYarl+dx0dTfNn3bvOaeH+XempBZ5A8yf19GnIDr1NCYEvMOf4pfFhz
	HzzUvS/Treg/gBBeBHVzAY/za5W6viH1Hnh7/3ZlKO38roikn6JV9O0FHgbuxziE
	YJX2wurJgPp8KWNGTzxpchwt2xRTNxpzZmhyoPmT95AAxhteFPncROTNHbACJBQN
	7Hzm1Tyn/cVpmAf4HFdi/HI/wpo2jbSqtZqSIjzoM04AAqeNRSkabGDTYj8h+9u5
	A==
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45swpejjxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:30:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzS2B1ecOvC9GaatXvYwiVaPuo2HJvpSNYqtgOsMXEnWJUa7oON5QZFZOhsNsnaa7f5PvDsJP9t/M7DnED6fsv59DhGPQWgkCV6aWbEXUSK7x97ejgfDlhjN+yNfyUkEjZcwSZV2LkZ2XykIydVAanMaRnlTZoKdEM1EqTsDZNLhqN9Km/wJNQ73B6RXbbjOjY6r7N/w/u+UbL6ON/XtKuMOar2aLhU8ocsAyVOC8YhJVBW0gNjLZhpS1uFEKcvuJMEhS1cIOjPfX2cLZmaZIo7GIUXHeBH/Z1Wv1N33mc0sn2BPCGM5u3ObEjAM6otgjQ61+qTuDFNgp5bQ/R7x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0v4pPXThLv2NUyDcTSdxRWJMQ8/3WX67gNvjLsQXqs=;
 b=Cl8cpccjITw8q6FTYInWwLYfLphDKiEUVkY6W4ErUsF9n1r/D55slHURAHasG2EUNhi3Tu/ZxSSMbviOvuAsY92aIgJf3xfRNntyiXCRGFE+3AVW685kzHdy4k3wGsvR4HTnZT6kUjqbQsFXKTsEGvB9+HCZ67w/KuG6ffIxJK2yE4klXlQqLSF/TGGaR6PxfS5KwCUMYg6728NmXzLx4s3uvhvAWKeSNXFEsj+xVXCWcYmUBtOP0LPnLz42S4V0aDH6c/HcycgYdYJ6EgjsK3QtEe26k3dYKosPnV/UZM3CT85Pid9wI+k4J2Ylo02fESvu46tER8bmw9HOsTDAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0v4pPXThLv2NUyDcTSdxRWJMQ8/3WX67gNvjLsQXqs=;
 b=T5+RwHTokvqoafvV/sxw6E2kvC3lS8OxBpER53+btaoPq+EDrlf+oLs6tOnJUDRNaZwib0xds63TDvSIzEuUuRh7P6ks9K0WzDG/w9tjR0QnkoKT6wS4ginv9D2SWTN6tLYAx46r9iH+AkgBA7Pa2albt5JUZm4b2+e1qsRRRYl/QYNuzS0km6OLY4cHoEZEipFsFWdfOPEPMCJSCMS6ases40i/m+U7Uz1PIq8AAK5VJD01l/AtZ7HVRZEczcYIGf3wc9QtvP0P6svdDiNZVrIKhgMlAb/Rddti5SYZ7FrJH0wfjLtvGDpzwG6U+BtHT0nMQdEceIlyOkXr9swtzA==
Received: from CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46) by
 LV8PR04MB9114.namprd04.prod.outlook.com (2603:10b6:408:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 21:30:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::be) by CH2PR05CA0033.outlook.office365.com
 (2603:10b6:610::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.9 via Frontend Transport; Fri, 4
 Apr 2025 21:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 21:30:26 +0000
Received: from kc3wpa-exmb4.ad.garmin.com (10.65.32.84) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 4 Apr 2025
 16:30:08 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 kc3wpa-exmb4.ad.garmin.com (10.65.32.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 4 Apr 2025 16:30:10 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Apr 2025 16:30:09 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Apr 2025 16:30:08 -0500
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
Subject: [Patch v3 net-next 2/3] net: bridge: Add offload_fail_notification bopt
Date: Fri, 4 Apr 2025 17:29:34 -0400
Message-ID: <20250404212940.1837879-3-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|LV8PR04MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cf6f07-9e09-4c9e-241f-08dd73bfea3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1DLlE2VRVp69ufz3CtraBQvHLYMtnTfXr5zJrNoH0LpTV9UIc3FOgUqXmYsj?=
 =?us-ascii?Q?iO1rwfCRCKLud+vSrUtxGhVtiBAFVaL38FvXa/bNYsLtxXL6swSIV6CuTdYL?=
 =?us-ascii?Q?KtojKxUD1h2Q3kTG1GzEZe371btGHBfIzM436csVVseWTTFlLAWd5RlPnXR6?=
 =?us-ascii?Q?VN5A43egqX09w1guqEzR4/G9xK+0X5ezRBxruUa068cq79hEzYyAjNX71x4q?=
 =?us-ascii?Q?8z1YWIVlpFHmpgfMg4XxPji8vtrPi7GDQypoz9Wk7qf6ETx2W990VDpEaWl6?=
 =?us-ascii?Q?eo4jAzvXzWJx5Pq2BIQNauKRkGz4OXvvEQ71TeyHepIlk2R4RRGLdyk6BjNC?=
 =?us-ascii?Q?9DuJv2Ozs9ry51WPj6SmX0v7sQlCBJj9n+KZrFPcQWBVoR69/8Y381w9BcEq?=
 =?us-ascii?Q?5OuDS8nINLSiSK/Iul3sZQ8VcuhXXXNF5AO/KUtKY4X7u7o5DTjntNI+Rd94?=
 =?us-ascii?Q?/LF10+oVrsHtw98VutVlAIW7tW2oCDPMXgETpNdZfexBM9HVbcxI+oaZYVqL?=
 =?us-ascii?Q?0ErEy/PCBIpnZKvFKdrCho2TsRcWVcfzDJvtWXV7rFqk8NgPDybOKD/AB7Zj?=
 =?us-ascii?Q?YkZ9WuRn7v8xeXdc1lvt+O68UlFMCqLotVkkbVYVyK1H7DZPBVv2/FTlQLOR?=
 =?us-ascii?Q?Qu8516WGunxh/vKu6F+i9KU81i2R03PIcYDwFZvHpf50ven8ziZXICFxeyQ/?=
 =?us-ascii?Q?27rcdLnBP2fjUibosqQgSvQO5JFwekK8xLXXvIxAdfZKpxRVbC4tzG5m4t8z?=
 =?us-ascii?Q?8cVXujXLwk3TOEkqHhe57+nrUIfMiHsQbt7O3GkAzBIvcnc6iqacPWXeCq+m?=
 =?us-ascii?Q?mEzba30BGhGJ8fZ07zJp/DoIiNyCxe+bq6aUk1ej1bmWsnlsaWObN1WpSE6D?=
 =?us-ascii?Q?gz+2pXtp+kegXsfcIY9No2QnLAy5dnohcVYwbNUdDIDUXQgbBHeHDLgNsmFp?=
 =?us-ascii?Q?zaTBy+6igim1e36rmVp9CIGwGXzFa1qXXFTnVBN08vnHdfIgVdvoYf51TBRy?=
 =?us-ascii?Q?Prjtpsuc7WYeZX8hlSkMnF3eyh5Vzi/nnKvcr84JZstJiC+KTSFRCITT1jT/?=
 =?us-ascii?Q?Wz4kZ4QIZfZkT55JZ3aO+ZQ4Gr7OIJ/ZBAyOgSLxV4G/+Wl1DVo9bEJgHXb+?=
 =?us-ascii?Q?jIkC2o0dFd5KiY4ifql+9WzU7F5KuERF206cf8gufKhO13HSLD3UI8vFNQUV?=
 =?us-ascii?Q?bJeBFmbvLprkQ4F3nIu5CNfXtVK9JMUuoi8voEzKTUVUJz5R0PvO6fxA0Dh7?=
 =?us-ascii?Q?H7aLaby0sIIVGpAPohcA26XxVwk8dDOllxQ6gRZIxlTHewGQh0WW4zQ3dHkY?=
 =?us-ascii?Q?6mVrgSQD6qyjOIzseRmuQwsoireFYZM4q9Kksswjh8b8c3+1OXXSg1UQyttu?=
 =?us-ascii?Q?4sjaPogrm3YIMispnjC/9mqY1rxToFjAuTUWovMBBtJ+F70wHaUGgRHzOS5a?=
 =?us-ascii?Q?sime/hu4zqk0bh37SE0SYp7VOZUbT64exWJi9Q9szdLcNghDSFb4bwzxPcPQ?=
 =?us-ascii?Q?EN+us9vTUiKjGthLVwcPpRDpxFnH1K5RJRBt?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 21:30:26.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cf6f07-9e09-4c9e-241f-08dd73bfea3b
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9114
X-Proofpoint-ORIG-GUID: gcZltM3PboxpcpzVWimYwIYD53qb352h
X-Authority-Analysis: v=2.4 cv=ZtrtK87G c=1 sm=1 tr=0 ts=67f04f75 cx=c_pps a=1Ha7URm6ceckcZ/uwdfrUQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=KDSQBeb26tfA5DPfL6IA:9 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-GUID: gcZltM3PboxpcpzVWimYwIYD53qb352h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=792 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504040147

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


