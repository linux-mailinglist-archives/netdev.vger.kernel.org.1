Return-Path: <netdev+bounces-304921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMyYFfqAS2otSgEAu9opvQ
	(envelope-from <netdev+bounces-304921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10F70F118
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=F9KovZ0t;
	dkim=pass header.d=ti.com header.s=selector1 header.b=t4hB+KKH;
	dmarc=pass (policy=quarantine) header.from=ti.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304921-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304921-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72EB135C7721
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C6414DC9;
	Mon,  6 Jul 2026 09:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4C331222;
	Mon,  6 Jul 2026 09:23:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329792; cv=fail; b=mzN5dwyE6/17/PSQu3Dr4N0TH5sfIhltJQwnz0K4Dfq5hOnHwS+MP8D5gga9QMHPaBWsUVmrBcTw2uoyuOQ7sp1t3Cjk5jtdeRE7pDHlmBsEpxkNuFMASq6goEeKYU68UDKQKjD551BBPtjvMyiqaI5kyB5PopDbl6BVzsTjJcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329792; c=relaxed/simple;
	bh=c9p+N7w4F5UXAulvfL3DbMrwwN/sMBiTIgzM4cvuti4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1rial/e2/t2Y1A0Y/+dvhCwKpNvCqpsy7VxskTfYiL4gtzFMPowHnHRkQGk9w9p6qc97hbhSGwVfPiq36kep9c9CUVGTDx9FXWVOmK/yJkBsiI/1iETpsTpXv5Um+PCGsxZYprs/zg1t/dmOrTF/gSlSH+WKxoTmS9tRJfXxpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=F9KovZ0t; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t4hB+KKH; arc=fail smtp.client-ip=148.163.154.28
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66696qeB321641;
	Mon, 6 Jul 2026 04:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=5AqXo9duUIv1m
	bU2gN7OJn0vhTqFW6Yuow9bvEuUchQ=; b=F9KovZ0tCtSmQNxqwPDEFkS5tXNdF
	vg79ZodoDlud70PrKveVRDyWs+BIWw4U/vDqJ116d4xlZl17wVWspEzR/1BqwbHO
	25LK/uNBLvPYddXktxLJsaeoHZBKxB7ePcG0laobr9kb1LvblR94c3xEpHnkRx1B
	L3hgLLGJJUkgR8pGYuGSa/3GGflL/LM4wj4rFj0O47mcpqYhDKRKAfk8TeO1gDuY
	vefcNr2XTXYPOtL16Stf7/2IBP0qhuhuQ4jfiRCAspx4GEh8YSgs7qCUqUdvxnlO
	uCfYDjWgIlpa3GvNjIMIkE/mk1orEZCB5Mo7FGpc38LMeH5DQZsHGIWUA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f7hakwhxg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 04:22:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4JBgJSnqrEEXQlDCv0vmYAeYkp0hwbZmrlTReJu+rdmr/MFwYrBWtvNqD+tKJF0oW58/PG8USvBx9AHQ18JSXeHpF6icgKE/biNCh6lEQKUIUhx9VSPqcPs1QGDMu1gm/Iosz1V/Kt6/OqP9S9UE+Uw7aQboLdrLW5TRphV6PxhmNyJ8CZSGW68Q0X7tDmJWO7M1Q7XZlxbgZOWmNN7Exh/O0CH5RKKd2uJ+T7zFs3th6s33rKgPWbpPHM04jLJ4H7xW34A3NWbbwih6eLkCut47RqLBFuqu02M36NVuHbGBes1xZanKFgPybz0ZtDGnkQDg3MJkixySFCoXS060g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AqXo9duUIv1mbU2gN7OJn0vhTqFW6Yuow9bvEuUchQ=;
 b=a6A9VrcgcJW4lQZOSnkhGU9b9cNMlJ0lAZg7csEDTNtZKXwd5RDWnKBJ7D0buxRO9eq28MHByBKhSwvlKy1xtWLbvhbFCq8aXoaDONz7wsFmwETKTtU0+mWRZhzRqgAXCR6jx0jR52RGHXnk3GexEuOB85PUtDZ5XH4ofPTcRmdrCMRxl05HVr4/Z59iQTjmhO+qP3uBbwSX1d6qY/WfOBfSJQx6vowp6AkSq4AF1inT3JAGGRgak3S84TPdanoZgQOQudaheCOJyergBrq7Yn2qj9vdkEQbucQIFENFUgFgZJLA/Oh3aL7Q4hyjmcfEARvNisA9raNgJTpIfCffmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AqXo9duUIv1mbU2gN7OJn0vhTqFW6Yuow9bvEuUchQ=;
 b=t4hB+KKHhPnwsRXoNBM/Lr/BFlxWB7SifwglWoiVqtMzxnB69hr5VQmIciXXOZgMwB8+GC1X/Wox/IUVlHj0ZOfH3PGiAQOYb/mr1bHHW8Jt0wYiEy7/lssEkDaas7wQ5g6irFQ1s5Lwh7sjs8awz/OyrbooMLe5RA1Nikv9ZuU=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by SA6PR10MB8135.namprd10.prod.outlook.com (2603:10b6:806:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 09:22:46 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::59) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 09:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 09:22:44 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 04:22:33 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 04:22:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 6 Jul 2026 04:22:33 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6669MXYe965066;
	Mon, 6 Jul 2026 04:22:33 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 6669MWCj032073;
	Mon, 6 Jul 2026 04:22:32 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: <s-anna@ti.com>, <grygorii.strashko@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        <danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH net] arm64: dts: ti: k3-am64: Fix MDIO clock reference for ICSSG0 node
Date: Mon, 6 Jul 2026 14:52:29 +0530
Message-ID: <20260706092229.82674-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SA6PR10MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1202158e-5356-4ab4-a480-08dedb402330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|13003099007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6elxM/LjUDZd9SbKbTtdKvI5Gw+t2kIDhQywPS4Pk0zGPSuWI7pgPQKUE/5FMZSC+0bozn8/2LA7AmTcsh5J9+QRXpaeew5dvqwshPWM2EZP0bvHsvBUhY7rQ5LIsXQD80gimP26TvtNvBQtCiMQvnuSXUPm0OoF9c6pw1U1/A/pG2r09CS9NYaTG7cYzI1Ms5+8p5aL9nOAnsczNOrRpMStfO97uxWr6tDKeRtIS2LJ9iBcrybYc9dMz/c+FzVZ7IaBCVCFb0i4lTvyqP6gqkZWJEfnuKXvNxVwVZrFAE4zNBwfYZjLxxQTqk7gsIeV28Slmm3dMf/oLcjG2R0jvfrMUkUsS9ptkderjdLmhTQf4zwBGSEZ1/sQ/Vbyzl3Bwt8iRD0eT86eyHLfdt2EYvMUZl20AK+c2SRkd72SNsQUAHovEbNd32svuOVakCVcXDIE3yXwuEq0/TIIBbIDwqGSYhLmBFIGd5krWoLAbjlpm5l0iBlC8RkSlrpu7v3dACGkLZFP1SisHvVhTZyAMXllOnDkKwWahEOd8VAJ/0P5HIvU02ljJNCVWtlJdYe6JqDrolKN48NRA3v315x45D1TG/kQ1yoD3qf/2XLbBk7OEGBN0muLOaMfzouo/mMwQV/7YUCPnZhYFqs2uQgpU8c3Sm8rjfFI7gGVGGI6w6J1o0zmlHAgeiiHQ0YYqQb9f0hD64L0lVOKeTLnUpt1mA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NgbQwPRLpERCen5srJG8BkS8INF5bcpnxYWJAndlixCsGAVkf7Yd6bCXzavBR2mar9VPki73G/zD56Mgw1a0ux3IR404AWSGpV6DECslH4mE4iKE6Z8zVHCWsvOWup4TQ7vx33Ug60lnmIbxGRwSO6WTYC2xS2j4VZA+TCkweChsAyIFabgw4PL1JEo5V1MXhErlWZ+4ODrj9uypompDbWWcfe67EvB3fa03PwwFoDhu17JH5cuHiE0TdscJztiuOOdyhI92BMvrUZkYlux+WVi1/IZKcE+auOa04adsbms0YjS6++kYXVdWB/T7UraLoRFyxuw2EWWoViuWz+aft3v8PrdnEF3nVxCPiggeRvi4HrMLQJy6Oc3P0dTohr9C9ZeQbFe61c9nDaK7VTM/4a/bc2HPA5FtoGezplnyEIMHaaflkbL2tXr25lIzupvj
X-Exchange-RoutingPolicyChecked:
	nUaaNMVA5ysOacqBowc1L71UuGSuWWWF5q9ZprYnCJk6/z5BdapUup2LbDxLp5X5Zot9aOjHjTI0YAHcSlGqUSH2r1J/HO1HY89Bewj/KzUPvQvBPGhtJCWw3IWGDsqSMOXxLwHa8UiWVq8v6snXqdTZeRvE601Hx5qu/0cHC7cNn5CzIP8a3FxWi9VIlzik8ya/QOqHaMjhvuMDhRWc9xgcOrsjCvofqtBbAWXlW3CJPdf3tkGs5qjpGuSA+nB0x292+zHEgud10SYqfepwPmTGsyo4wh6qaqBNhihm9lZJzH2pBN8C0Qj7UE+xpnW7OhIHSqU9/Pitc6dpvGMv+A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 09:22:44.6681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1202158e-5356-4ab4-a480-08dedb402330
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8135
X-Authority-Analysis: v=2.4 cv=BpatB4X5 c=1 sm=1 tr=0 ts=6a4b73e8 cx=c_pps
 a=6XSCBLYFY2RPGp+89yprvQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=lIpmK1J5mK34uVAG1B0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX08z8QGve1VhA
 TtCVFjLsaA3hF+7OGD/gtm6m044kszSIfXGds6AcnqbdlfAFBZqTLqJtpeUaCASLKCwQs+cH6np
 KhkFmWdoveWpGpszwp1eqB8pIcM1faE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX5P4eF9z2BBdq
 5RJXvcshiFAKc6ShLa454AaMpmozwuMKUoJGiyQUjwzPTO9HUjhjLyDq1gmQKaL153/DLC+vOLv
 glGuKf1lfYF5p2wrhqmhrvu9NX44Hl/HXRGtyeSCJ8/501Qs5mBkBYIbeaGplkrBbL6HpEgxUqB
 ldk/gNoRz3GS8rnOZ++pfv7gokFJsZgCs/uRuPSULD20YT4fB8QZYbq7aH5coaJyGYkKuR2BE7v
 uC1922BB2hGy3IZuaOSTizSNnFinZwdt57A2xUctQnmsttnMKMKMUFlKKmeSisngNiVjZ7rreOx
 16CS26VLt+ogpQtIJM819G1LSUxUWUNqdIJJQDADJssuCffmezA0JNGEnww1R50skIrrYSgdID0
 vTHy6MKxWBl05sMU1uwTSt3pfdCwFfOP+Uej/73v7+ReCDAJ7scegnPcVYclNT1tQ5IgWOeplHh
 YO5Q7GjQiiXgW6yRBLA==
X-Proofpoint-GUID: sSO7Y0LsygNBazmzkOHPNSNtXoylhnLh
X-Proofpoint-ORIG-GUID: sSO7Y0LsygNBazmzkOHPNSNtXoylhnLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304921-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vigneshr@ti.com,m:nm@ti.com,m:s-anna@ti.com,m:grygorii.strashko@ti.com,m:conor+dt@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:kristo@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:srk@ti.com,m:danishanwar@ti.com,m:m-malladi@ti.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ti.com:dkim,ti.com:mid,ti.com:from_mime,ti.com:url,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E10F70F118

MDIO clock index changed from 62:3 to 81:0 to match proper clock
definition in the SoC device tree. Clock Id 81:0 belongs to ICSSG0
core clock, where as 62 belongs to EQEP2 device.

reference: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/clocks.html

Fixes: c9087e3898a1d0 ("arm64: dts: ti: k3-am64-main: Add ICSSG nodes")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 1b1d3970888b..a9a83781d40f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1401,7 +1401,7 @@ tx_pru0_1: txpru@c000 {
 		icssg0_mdio: mdio@32400 {
 			compatible = "ti,davinci_mdio";
 			reg = <0x32400 0x100>;
-			clocks = <&k3_clks 62 3>;
+			clocks = <&k3_clks 81 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <0>;

base-commit: d7a8d500d7e42837bd8dce40cb52c97c6e8706a9
-- 
2.43.0


