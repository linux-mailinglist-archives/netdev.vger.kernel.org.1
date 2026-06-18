Return-Path: <netdev+bounces-300386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q1toHdDDM2rEFwYAu9opvQ
	(envelope-from <netdev+bounces-300386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C619169F1EC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:09:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=iF+2EWZQ;
	dkim=pass header.d=ti.com header.s=selector1 header.b=fAp+Z5oW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADDE302D5CB
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0103A16AC;
	Thu, 18 Jun 2026 10:04:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656640D58D;
	Thu, 18 Jun 2026 10:04:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777063; cv=fail; b=TlaSW7qBGisC2BV2Rd6Z62J5IscRbmIGW3NBs7bENrpD3/T6Ij/HaVSib8nlf12ztt43qSL9YrYCTcqGqsN4f0O+zqjqZkBBC9UntuS2w4bLHL4qXKb4v50KQVGGQh/joefyyJKlaOcjtUKlpfJ04Io4ze/82mLCigCF2xMoUmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777063; c=relaxed/simple;
	bh=3nIPRm0ukNYBZZLgko9yZHqso1Cd3bcJ786oUmPDqow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NprouJJxBOBHrKOAN1x724NUd2ixRfSv+fgkGqBYSdxETa2GFrfGCKhpdyAcKrjWcV9dp4TQ4jSF2zKmXcTtxokF75bwmkcZBB6hs7f6NkXagmZ9pFM8CKAJ6AR9KnniGeZj4g8WBXMshdWe13r+Y0jLlt+5mGLYRyNrsCpQpD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=iF+2EWZQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fAp+Z5oW; arc=fail smtp.client-ip=148.163.150.75
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I8IkAI3038716;
	Thu, 18 Jun 2026 05:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=mrHW0eI8pIclg
	5nXV9bymRMD7HNSUU7dYl9XQa5ZmtM=; b=iF+2EWZQzo6krqTffgA87pNB9B1D2
	uKmLlQAIYb6N9njqYUosSeXZmPRFpfZC+AcpK9DlzUGUnTW9SW08Zrfq8p5YKJCr
	A/vYIlVOM8zMcrg6S0Wwum7l9jKqm+LEqeyIy7R3ePL/P9xPZe6F4cWgAHOcPlkF
	YAigQKKsJxj3kRdv8m+zFCimhPJE+klMJJjo0gn+tVkmd5XYgbXDP8+r07Z+FQ5V
	Ov/Whu37x1tmrgkEKtd/r1xybnQZlKVdYEGFN/tm+88MJdyQNRlogp6nR5ncDpAL
	PMkqDkZAFCiYtdrGivIwI8U9MBgFAp3qf7h302kG+pN+BTgumAxRNYtCQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	by m0384305.ppops.net (PPS) with ESMTPS id 4evd290emp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:04:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px4ZiQ8l7Z3GZL1BOwLsOrjOL5SQdl3MJAnKWNQQaA+eSKoi2Ve+mxPwrh1n70w+sl1fK9uMr8bpUXZH8ShK3sJ7c672zIRP4bInlt4cHNoOKoPECjsoRs+wWLwnyU4K3wlxRyZS6q52KXVDV/jx6eEHIMq7RMpjdgybkWoNS7U+uii30MfDyuVC78jCheMBjKp7+MRR+jsANSQgNTY2C19o/KYGoeCL5V0WlLgZkv7bWwrs6Q2xjv/YWtRWsiIgTXZ7Snf4MuAkRx45vP+nHZOQeELKnr+Gm+4x28uEPpKX/I1wuX90XG2sW5xNq9EjCW0HfIVr12l0Z2ONcgiTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrHW0eI8pIclg5nXV9bymRMD7HNSUU7dYl9XQa5ZmtM=;
 b=vvlXsVYCr1LHvOnryw9jIoCkGJg3oe4h8ZoC+LNp3m3wHNU3a63tsPkEbz966YPQzeRhCUOYtZsNEzkyPIcoSL+ChbfV+/bhTVxjOfIbDqH17zZQrRJ3N5p4iY+8iV2ulzwy88RIFTtYBB2OGnADYNKO3KzJxSpHc7at7LjQ6c+CcghXOo1yFeHuO+8G/fawG2N6kJUeZE6efheZ0WLnbV+w6fN9+9vUBHZTsH7yrLbRyDdKHSTQVcrfAmr513KxSG1jUgs4zvfGM/nlzMnRbwg6fdJmKnYosH/q5B9JMLSxQ+3/OCdIoZw+67b0dgXKUhaU9WZADRaETBJHroxVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrHW0eI8pIclg5nXV9bymRMD7HNSUU7dYl9XQa5ZmtM=;
 b=fAp+Z5oWUZOxaSx7Zj8niGaQN2GxeGcwQn1HwKl829IUpen7GoR8MmIjq0IXVanstVgmuufDb9qqLIkWe7oJ+kFkjAKeRs/7bvk1Q6fXyJVyHKHsGZvzYevxY7r7q3KFcpVm12LMQuCsqpn8zZmPxik/ct1pjek5V/kHR+6hh/k=
Received: from CY5PR19CA0083.namprd19.prod.outlook.com (2603:10b6:930:69::21)
 by CO6PR10MB5619.namprd10.prod.outlook.com (2603:10b6:303:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:03:56 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::5) by CY5PR19CA0083.outlook.office365.com
 (2603:10b6:930:69::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 10:03:56 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 05:03:52 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 05:03:52 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 05:03:52 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65IA3qMQ1555570;
	Thu, 18 Jun 2026 05:03:52 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65IA3pVZ020132;
	Thu, 18 Jun 2026 05:03:51 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
        <devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2] net: ti: icssg: Fix XSK zero copy TX during application wakeup
Date: Thu, 18 Jun 2026 15:33:48 +0530
Message-ID: <20260618100348.2209907-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CO6PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e50025-8db3-495c-5a09-08decd20e908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|921020|13003099007|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	r8X8HiNIj8IwU9nJGKlsnKeOo9Ra0P43poBPPCOhc0yyRLhjUf+q2god58E7ZTqNVxelNgZXJLDadjPWpJEFT6HRcDaeie6w+aqY89EltEhtr12hQuz+t98HIAr6ndXlkA1zjgHbtf1SFAsnt0+QKZjcSF4f4kvF5RpRWa0W6YI/ffEshOe3/V/Fpw0rpMwAW0OnPmhs8X+4sODYn1IIXvSSIzW7jPf70AyVinzZDpAx65H/odHnFFcKytfvdyhH3R2ZQAVYdcCtg+8VXFEII3a5CRAgW47tBPx1raq70laWHd4zjTMFJWVOP1RgGweO9ZMyPJrth+ITm2KRYFuduKpSLFqsZ7A7Eck3dbMMa3P6Iorv8mmvO5rFzccKkJHvei1/0otkI3b3deYgUrp4qo+YVcuYEO7+9bUxJzthM2k1JLMcXN4brvmxg50KHBlbywNbD5iJW8/5DOQ4FC+7W2NPZqSgjkUk2KW0xxPeR1bcwGeXDlTY4rw1mpuFMG4s0t+ElUkuMnWAAPG5T72iAvzRSRDEgWWtAPyY9ruf0P3DkUmrxZkAzxAWGPfX/oDXf1WwWpW2U02ULIhh2FBZ+uIqLW41u6EPxdE/1ZAmXGVif+upVR6x9SZfrP79BP/ULK7oad7qsNGepbiOcDX0ccqQ5QWEXdiKUiTBrae51uCn8CGGeR/sdxI2jgUZQLBSOJLzFIN4ugFxT4HS1RtzBGniFtO4MsFfVzDC7eaTzvizj9vPUZ5qJ0xJS2QpxqZJI+sBXy1Z+QIKIHdO3rHWsmEi5u+xF7ZvqPiRh9MyW/k=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(13003099007)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7c7sQHhK6aYT8FwvbCDMQuUDLBTG85xxeLXG4ByC52P02pYguzURGrk4PR7QivOEr7O7AIa5rU2gZOOAOfwXwxkRHmBALNbrMbd1VC82PuNcqK2+R75C8llTy0WBZk27oC3PDPo+E2ouerIBwDkI7och8SSwH97rsu/sCgBRqwU4xFdtwTGbeJAnGASHo3L/Iz2u/2r5vVrkVAhqH/HD0SPjBzGRdwXOruBiwv0t0shHrj0XpimtJj4m9o6u5a33wF1SyPYE+1bKQTXL4MDqpCfnTllP/jiWgkxJG2b+Kb4qzUUuzMki0WjODSilJ6KJ+MIVFq+1ZjJJ2p62T6+0yoODmTTxKArUKV7GTReWfLZ1RfYQVbRRDffGbO9p/0B8ZSYwPNoZAyXpEK8wLmJRIylXnppXDx7YOqOdsOiV5vMZYr09+TuQHOz4s3TxrbsW
X-Exchange-RoutingPolicyChecked:
	rqbtAXWCegsP7x1nXfmO779smCIwDMv/TTZifViVQqcj/EFS7STfu9449EPTMNQiHHHSj+1w322OYZrTB7TLDtaHXeMwq8lzI3lw5BTxk3M+Gb3E8O+ONuswVySO1QjAG/JlyRfuTvt43BYB5ygAlss20oWxlDgI0OemGrR2tBtad7htLm9RptZ+6nu54hbNuAHTTCgpPso+g60K102axYi0wdLvOgZqkTOcEx3DBpHbaCNOnsIWG0ss4q21bIgA+98bnczpkoGV2OPZGjuBJETWZnUrP8AoQ/6Nlf35tJI4dDbHGQyz8w/CM0bFAf/sw+HF8qhX4K+bavz2FvOGog==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:03:56.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e50025-8db3-495c-5a09-08decd20e908
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5619
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a33c290 cx=c_pps
 a=qO1H+kaF9sbjJIkK6g+tnw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=9HYmQO-Pn1BV2iVLnl4A:9
X-Proofpoint-GUID: w5FbghtEZVmOSLZhf62ti9hDc86ZfTbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5MyBTYWx0ZWRfX09nlUMCtLUcx
 k9eIG+9N3UhgJ/Tjtq7jg2nkWoKL642pFxoy57AjGVbpyOo1BBMfeppBrPIi8EgKyZUXDs4rZeO
 QgHSHkw+FQTVXhstUIPpu1g1cEi7OBNrev0VqylbvQTmYz3Sz+AnMRI83+L+4gn3rJxBcTVCqPR
 MK/l/N1cw8GJ+0oVSK5S3cuRESIzl8qn7vBmVJl9TQaEG5uYiItxgOwGXOCNLb1vQFTIAIu5yHZ
 Cv017fswzvzZI8DujJCeT2C0MxibZq4zW4tR5Jyi6k5XsCKr7nePEfNKSQdCXmiuRZpl08rVVkp
 ivTOBh06/dp5tmf8XfeKBUuluZHCUG+fLZlMMX8bhNyq/jrpy0IpvlnHIFhVjgvt2nH1ZXfTYn8
 FtV8t4PXOExyf7V5pDS8WJHDONTEJO4sKl7HApgN9E/SIePX/JnXCT92xAKFGkCwA2ovn27mdzk
 hqjGkA4BguE47MZLPLA==
X-Proofpoint-ORIG-GUID: w5FbghtEZVmOSLZhf62ti9hDc86ZfTbW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5MyBTYWx0ZWRfXxFuFmSmi+Goi
 f0oXwIx7yCIhXTpWgy9+aU4vgGFY0nX3JdLvhu8tVqNqzarECTBPt5jvNMJvVQ1MLfuYVOIyRbp
 HGnvqu+gaCXB+KHYlGaRO3zA6jg6dfs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:diogo.ivo@siemens.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:m-malladi@ti.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srk@ti.com,m:vigneshr@ti.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[siemens.com,linux.dev,gmail.com,kernel.org,intel.com,ti.com,redhat.com,google.com,davemloft.net,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300386-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C619169F1EC

emac_xsk_xmit_zc() handles tx xmit for zero copy and gets called
inside napi context. User application wakes up the kernel while
initiating the transmit which triggers napi to start processing
the tx packets. The num_tx check inside emac_tx_complete_packets()
returns early if no packet transfer happen hindering the call
to emac_xsk_xmit_zc(). Remove this check to let application
wakeup initiate zero copy xmit traffic.

Add __netif_tx_lock() to ensure that the TX queue is protected
from concurrent access during the transmission of XDP frames.
This fixes netdev watchdog timeout for long runs.

Fixes: e2dc7bfd677f ("net: ti: icssg-prueth: Move common functions into a separate file")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v2-v1:
- Added back xsk_tx_release() inside emac_xsk_xmit_zc()
- Added a check for budget>0 to protect the AF_XDP path
- Move txq_trans_cond_update() inside xsk_frames_done check
Above changes address the comments given by Jakub Kicinski <kuba@kernel.org>

v1: https://lore.kernel.org/all/20260611185744.2498070-5-m-malladi@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_common.c | 23 ++++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..6973d4714246 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -93,8 +93,8 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 }
 EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
 
-static int emac_xsk_xmit_zc(struct prueth_emac *emac,
-			    unsigned int q_idx)
+static void emac_xsk_xmit_zc(struct prueth_emac *emac,
+			     unsigned int q_idx)
 {
 	struct prueth_tx_chn *tx_chn = &emac->tx_chns[q_idx];
 	struct xsk_buff_pool *pool = tx_chn->xsk_pool;
@@ -115,7 +115,7 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 	 * necessary
 	 */
 	if (descs_avail <= MAX_SKB_FRAGS)
-		return 0;
+		return;
 
 	descs_avail -= MAX_SKB_FRAGS;
 
@@ -170,8 +170,8 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
 		num_tx++;
 	}
 
-	xsk_tx_release(tx_chn->xsk_pool);
-	return num_tx;
+	if (num_tx)
+		xsk_tx_release(tx_chn->xsk_pool);
 }
 
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
@@ -279,9 +279,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		num_tx++;
 	}
 
-	if (!num_tx)
-		return 0;
-
 	netif_txq = netdev_get_tx_queue(ndev, chn);
 	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
 
@@ -297,16 +294,18 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		__netif_tx_unlock(netif_txq);
 	}
 
-	if (tx_chn->xsk_pool) {
-		if (xsk_frames_done)
+	if (budget && tx_chn->xsk_pool) {
+		if (xsk_frames_done) {
 			xsk_tx_completed(tx_chn->xsk_pool, xsk_frames_done);
+			txq_trans_cond_update(netif_txq);
+		}
 
 		if (xsk_uses_need_wakeup(tx_chn->xsk_pool))
 			xsk_set_tx_need_wakeup(tx_chn->xsk_pool);
 
-		netif_txq = netdev_get_tx_queue(ndev, chn);
-		txq_trans_cond_update(netif_txq);
+		__netif_tx_lock(netif_txq, smp_processor_id());
 		emac_xsk_xmit_zc(emac, chn);
+		__netif_tx_unlock(netif_txq);
 	}
 
 	return num_tx;

base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
-- 
2.43.0


