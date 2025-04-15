Return-Path: <netdev+bounces-182844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431BA8A174
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4603BC667
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAA296D3F;
	Tue, 15 Apr 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="I1vNAebv";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="HavNI0g1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2112144DC
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728229; cv=fail; b=O+o2t8N+2OCz8hPlOKbbjR7eONr+630D4Xoxpppvq5736rOGApYOWk9Ad9LLQZQqgE4b3DHGNAQe6wsxEMEnyireh448p6U2aUJA+36pwSLKaSrkDQD66BvSYvkGU9Oamh9SPAK4AqsDNSCJAfGrEHYxvyVkUNeZG8F/mk8W51E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728229; c=relaxed/simple;
	bh=XRnl6WDibZmGti9jglzN0RuuzHHFv7a9j7xMkIJLQow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW/l1ZlrYwKrPDt7MZkb6Hw3R3nxV5etpBESDhCmby4qCrTn1zd9v24JShgsFmr4nzOUK1wwprWk6OwIjPjnzdA2X9JTNJqY//l/pp5Gb+pp3P1opKplIAOAMsWuU06CyF4QphHzNXOd3OOy5PyODBxOTazxy5JQPdd0g1ZEPOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=I1vNAebv; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=HavNI0g1; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAsTwQ013638;
	Tue, 15 Apr 2025 09:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=Xdp77
	OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=; b=I1vNAebvxbRjmdHoJ3fqX
	SuQBoJ633cWDR83+SxzhE+Uo05E8MmKJA3op0gKJfPdpSlDzBupkX0jEoCiX4vj7
	TtBhUt84E4Mj7QYbdVs72uKZxY2YiWbZdwdnPKmN08TD3p4IvwmKi0v+qVVyfIpz
	Y1CwnpBph13c/NhLJzKWnypd4OvUUsD32ByatWDsTRAJET71TUfbojLGGE1GDP3S
	gSanphLXjopgDA3t4/mltm9/E5gdJ3ZuR2L5qW5SnZEejAYBteypUugiCQbyfCX0
	X4TEIIHIJBApS341c4Y755KABXhM6YGo03nLth1Lc9Ry+rV0XqYIm1s6063t4jPV
	w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 461p3g0g9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:43:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6cxGI/whH0imNaJSmrLbUW9pNWcxlJ9rJoaEQ1PKKlV6pfX00IC3leLODYuJCweD1Q4ecLFZBN65j+t1vqga9MojYcG/33D15C5/4eN5FIHMM/HQPWLSNU/XNDfHIk9PmeOgbKW3ITGJKUhSdHyqq88JdIcZ3UhuobyfNrruUFw2R3FOql+Sm39xkUJI4CK7UNMqOreTBoMVAvLe2moAqkRkWEig2g+f68Ds3l/+YO3CZy0gEPrB89qXcog1PARAZXIMfXl8P7iaNngHUwr7ZJvznJUkUbb3C/EszOSE0+H/HXb5VIzData11KBS310VzX76GEAr9kCi6ii/l2IbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdp77OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=;
 b=CuBqLumsGo9kAmCQak1fJVzhZgXSf1BcrCxsoV3/LKa5ZT6wUCjpcZ2wo3I/GacnFOwiExdIW4JB5cewQ37C19+aSlzcJB5KbsGloGAnSHCb6LyvexCSrGNjehnyEulCKCAWVKACJ3tQA8HlZ7kV2DuWnRiZYGhsYJdxg0lweGKqqgc0bPxJqI9rRpwxAIRhejlgAKaUGq6F31STs0vF41xENNWUpYnGkCsV0Osk5vrApOrc+9Fixqn+Z9tIOu21Te6jW+tMW8iJGxn1+HF8nKWxtEU7nplToVElfHoK4rmdX1OtsL0HxNROqYUGmyV4RF3msWh1Bc9DNUD9RZDinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdp77OklKDd9UxjnooTvfgLG+Bq3aBly2jpvUgkQI+I=;
 b=HavNI0g1OrDprF7m3XyPvgLYT+UOLxNravixJrojBJpVHhp/rXR8tqyGTuq72eOF7AbSLpRCuFNMQaQD/OhncSvxLnIzrxQedPnrzELQN840Re7MZYPzTmOZhHA1IbDU2Sp1IMEcoG0h/p++MMit+fWZUZWe+H2D5XD/OFeVhPZ4W/iNM0/zD9xWMyTNIWtruMzQJB2AP5w7+PmtJFZxUfLo78baYXQWOVMSd7zGEezbQW8zrO/7XNdVvL6cHw1rk28yZpGwdEHFHnU4t5tE4hWznWKgXdOkNwgYCtHlBUrpv63a4VrtDGkE/llXe6n/3JRrg9z9/lZHUCSmZ+8QXA==
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by MN2PR04MB6975.namprd04.prod.outlook.com (2603:10b6:208:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:43:32 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b4) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 14:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:43:31 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 09:43:24 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 15 Apr 2025 09:43:25 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 09:43:24 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Apr 2025 09:43:24 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang
	<Joseph.Huang@garmin.com>,
        Joseph Huang <joseph.huang.2024@gmail.com>
Subject: [Patch v4 iproute2-next 1/2] bridge: mdb: Support offload failed flag
Date: Tue, 15 Apr 2025 10:43:05 -0400
Message-ID: <20250415144306.908154-2-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415144306.908154-1-Joseph.Huang@garmin.com>
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MN2PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: db6154fc-9143-4a37-2d6c-08dd7c2be455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BmlPOHJuFPt0Wlh6A9x9tL1gmd4vsy60yCEYQaraoYi6+Y1dGN0ST0ql3KpZ?=
 =?us-ascii?Q?0184d6IgNi8Cu1L7CKCoE6UbDEr/zyKTmSml5Bi0nk5HbneaIoHe5zjQ1vwV?=
 =?us-ascii?Q?UQbYoDkSlBeXIcCp9nFzLmdkspS2ZHIXkY54tbST2cHbDZx2f0kwTl6W0His?=
 =?us-ascii?Q?2BUZFVmjg2YnoCB+tr0cxU7bmYi8IE6ibb7zxqmGXNm3NxTqz5fNkUTiBYgK?=
 =?us-ascii?Q?dHe8jnGl+R8b3Of1VRr2d2stoQ6O3v2VOrJMjRx4+E05AzTcvzQx1Uxv9pi1?=
 =?us-ascii?Q?uCHbk1KFYtyMw6m9XdnDU7tMK4t9dkmuY/Os4+x3iM/10DpEa+VVTVfN8/o5?=
 =?us-ascii?Q?GfLb3PSTWnLx2f6PttSNjJbQb+BIIeBa1eWdqI+xWHpeCkjgoiaXl1es7j1P?=
 =?us-ascii?Q?vPzvZskBxVQpNDZwrVTzWkI2bKzF0qmBN9gYHmPpjydP78vDnhst+/sR+VVN?=
 =?us-ascii?Q?+If45YzwB9kAreNXA5FHpoU/BP9sUxIF+WRTnAQCt4QfAGyyOwSCmOY8Mhkk?=
 =?us-ascii?Q?For8edTp0bYnFXHp0uNjIg1Owm8tbjUybZgwMIOrOoQU7Xpw3FgfYLDnYivi?=
 =?us-ascii?Q?sCRECPRvUPdscPMntf1qYJmYXNWHlgk7jhSh3X7LR2+tQQdk6gKT0mp/NARP?=
 =?us-ascii?Q?vS2SXN11HtjCPd6oRMhWC6OizJ02GjGEK4oglK/BQ60ue9om1CXUnu7ndxGc?=
 =?us-ascii?Q?b8tKJm4xtNTAgcRf5qyIt75iFNs6PosgzUK44/Nd9shi4LUxjdKk3WblVvvd?=
 =?us-ascii?Q?0Yalo8vRjfG2Be1PBqvlt5SAFk0z4DjJcanalzyORVeVpuWJrdofohPYLMIW?=
 =?us-ascii?Q?oasV1bnXO7MWij8qTIk0E7jGylZK61/QPWtwr3bz9hj6Pkt3SxzefrT6bzy/?=
 =?us-ascii?Q?m28H9P/lNsHZqA6DBWUuxGX0ygD4jyxqWqKGHR2WYiHIVdXTFfJtZbwGw6ii?=
 =?us-ascii?Q?BqRMGSJAi2GgBqEC0Y0OCGEwYciTYNY7o1+aTZxqwpmcKgGoPAPHZ4IFDsX9?=
 =?us-ascii?Q?a/ou+FAx6UKDMlAs7E/o/CdiZFfyHvlNOTt0BufKzlbgzhLIk/kGorYGaluu?=
 =?us-ascii?Q?XLa/ycxQ/mqkzZqQQwGBZbqsnkUboCz2fIGaZgtoK8DaDj/wJNgiam32Mn/Q?=
 =?us-ascii?Q?yfcW93KNBdHxw4B8zEL5XY9IeLiLwaj3tQ3cAIhDbsJhCG9qh8CwPSYO8E/e?=
 =?us-ascii?Q?VWtLBNJqkrgjSjrLiH5wPhkbh0NNUVMZ/erYbembJGDC6wnpHW6Zwpz2HF8k?=
 =?us-ascii?Q?Ndop6I9k5qlmgGtFK8lpmzHydgkFhqn0pz4RzgLX8b9xCkrC0/6SXDirVbcn?=
 =?us-ascii?Q?GEIZzGTaK1+Hy4cIv41Gi2jaHZ8MUDr8bdqMSyHUueIumysr7Wcx1DzoEJp3?=
 =?us-ascii?Q?7xiv4aP+ULNtGI833fPqj9J76nq4aW/OsdYFWjG/GfNKYC+ZAUKscsf5Uy7d?=
 =?us-ascii?Q?G3FKPB3UXC3/TZjM1udBSci/HX6EZPfwxWTPlsJJoQoczqSwNk+V1bHUJZR1?=
 =?us-ascii?Q?TJgoYL/SUDi2MoamtIZJSUE7pWna4mLq/YnN?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:43:31.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6154fc-9143-4a37-2d6c-08dd7c2be455
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6975
X-Proofpoint-GUID: Od7TdnEuZHhJCwt5haF2TmB0VMklRrg4
X-Authority-Analysis: v=2.4 cv=L7cdQ/T8 c=1 sm=1 tr=0 ts=67fe7098 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vr0dFHqqAAAA:8 a=vJ3Si-Bo0Wz43vYLVJQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=P4ufCv4SAa-DfooDzxyN:22 cc=ntf
X-Proofpoint-ORIG-GUID: Od7TdnEuZHhJCwt5haF2TmB0VMklRrg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150104

Add support for the MDB_FLAGS_OFFLOAD_FAILED flag to indicate that
an attempt to offload an mdb entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 196363a5..72490971 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -256,6 +256,8 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
 		print_string(PRINT_ANY, NULL, " %s", "added_by_star_ex");
 	if (e->flags & MDB_FLAGS_BLOCKED)
 		print_string(PRINT_ANY, NULL, " %s", "blocked");
+	if (e->flags & MDB_FLAGS_OFFLOAD_FAILED)
+		print_string(PRINT_ANY, NULL, " %s", "offload_failed");
 	close_json_array(PRINT_JSON, NULL);
 
 	if (e->vid)
-- 
2.49.0


