Return-Path: <netdev+bounces-300142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /YzRKmeHMmo61gUAu9opvQ
	(envelope-from <netdev+bounces-300142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2926992FB
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=proofpoint-05-2026 header.b=NIpAX02Y;
	dkim=pass header.d=ti.com header.s=selector1 header.b=qROi7eQI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300142-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEBA3130101
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACF3E44F6;
	Wed, 17 Jun 2026 11:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69582750FB;
	Wed, 17 Jun 2026 11:27:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695629; cv=fail; b=A4gd1+M2/RJEORWxrw35fc7iOIK+W+XjRl0j3Dlky0SAuJ7k/7rhNhfxH9VsFmxuSaLqa/WzsXhWnTOM5HV6W5kAzXPGr+N+7FRvzEUAOKIvcazIvnvE2DjV8bQN6BEtfAeFVLIpL5Kltn/HBUczAzS1GkdzIka4BpKJZOJ47lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695629; c=relaxed/simple;
	bh=llmUkFeoLsP4cP+OyD1OZSqe7K6eReA5AnlaFIZAEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a2hF+1a22B5mizNc3zdY/w8STP9AFhJ1M4o5PjeIanirOkbBGM9FFh+2v4idL5rhD0uRcuPCR/TajOtK6oSEwwSFanxJHEUe9qLuUjHDEdda+MGLZA4gfjGawBAeUbgAUeOS9xkCgwKIYx1rFjkS+ZzUM4SlUESzopmSFyAsYYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NIpAX02Y; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qROi7eQI; arc=fail smtp.client-ip=148.163.154.28
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HBEFsM1874140;
	Wed, 17 Jun 2026 06:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7kEaNSstlwAaFn9NnsJziKpW2MMxDpQT5h/1xFi7v
	n0=; b=NIpAX02YjN2dhKSWEa91kgmNxP1+DYwu8WAAi5ZtlOSJC+WNSlrj7hHSC
	yf4Qq3XrqdVRtwmj3o+7xbuPXFXGvyKlgkJfDx+4ch2Ee/zDI63/r8WW1M7khKZv
	2KtosCeYKgb7piAMuh+NpTGuUaHpCCVEoxlk6+0Qr+Qor26S2h8VJRIR6bitpCSR
	f1x28HTbGewbZRDnR3qfolt+3s5TKoPL5TiJLQtakEXCfT1ord6Ux28tJBBI1HhM
	ARtjrL6uXjAiWPTQYJ+EiIjrxnWlj2HMnMSzH213x92weUghARYoTHTrQEXAbcxC
	gy+fjzXbNU5/C1uJhK1n987rfWpKw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4euther1fx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 06:25:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9sAjEq54XxTxyD+QwCoG64tiQo9uMAJz7HQlYsPbp2zY5TMrAenTdKeNgmL43KSpWiQniY0+69EHVJenV904bXGDi1YxwcO5usNXaFL0DKxrUPwy4RUbIOWwyL0N0QHwvccOvN8Yldr+E/iw8Xam8X8DTrnqLhMoGPNtp9NWmadMqgZh/tNNG5w1hO8Y+jd3KwQRYgJXlji6wew0BwjFbRbakmfoIoPhRza6TGo48xlr1ERlmkQi/I8SDxN/N1+1jcTV1w4mPRq5YRDm2CeFZAUoPw68yldxzVxxp84pOeMZdSIjLzjv7QEBHHnpeLBS/eNGfncJ+o1zylB0xZnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kEaNSstlwAaFn9NnsJziKpW2MMxDpQT5h/1xFi7vn0=;
 b=c1LlT5l5EcUfAERwR4yOFyi/IdjYXzkgPKA+6afCNEbA8ChOaDlgK22L1ztFMrygtTp02+gpKSYckwMzYW/3bRdKLw+qZ69HI+wIOwSNliKms5p5WnG+vp2RUPS7hA7ArHZ/M8q+L2P4PkyQDsXy/z12+UW6Nn8YxAvn2PT6R2R/h+1w2+M4sx71fOEI2Mc8YnQEZdxj1HZMn7mmcEOhvJYlQQMyctQ660zz83LbDOGtMlJW9aONx5IAvMyZ9qhsxa/pF0yER/kkg2Th8p6M2eJ0Kiu7KWsP37WvGMSGySwtLyWw7GsTRBsMvK6idmz+1j3y2sSXwNasK4C4dDMOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kEaNSstlwAaFn9NnsJziKpW2MMxDpQT5h/1xFi7vn0=;
 b=qROi7eQIN+O/uzyZGlF/UfbCY0kO9+OkC8pZjahx+9ZFyws2yvyx81i+j17d/ZHkzQPIrE4mfOfLJcmDtiO/7wGjBpYmIELXmk/biU4vNt5GemTcvWIpSqx70nuWyUOyrmzBKl1bqm8Ts5f7i3od+fAVI88J/4Pv6kN/pY3fYzE=
Received: from BN9PR03CA0860.namprd03.prod.outlook.com (2603:10b6:408:13d::25)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:25:26 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::7) by BN9PR03CA0860.outlook.office365.com
 (2603:10b6:408:13d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:25:25 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 06:25:23 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 17 Jun
 2026 06:25:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 17 Jun 2026 06:25:23 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65HBPGn01616083;
	Wed, 17 Jun 2026 06:25:17 -0500
Message-ID: <c58175a9-27f8-4f21-91fe-b99e7c7ec966@ti.com>
Date: Wed, 17 Jun 2026 16:55:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
To: MD Danish Anwar <danishanwar@ti.com>, Jakub Kicinski <kuba@kernel.org>
CC: <elfring@users.sourceforge.net>, <haokexin@gmail.com>,
        <vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <arnd@arndb.de>, <basharath@couthit.com>,
        <afd@ti.com>, <parvathi@couthit.com>, <vladimir.oltean@nxp.com>,
        <rogerq@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <vigneshr@ti.com>
References: <20260610052511.781752-3-m-malladi@ti.com>
 <20260615231041.1007484-1-kuba@kernel.org>
 <20260615163932.50bb3df0@kernel.org>
 <d0123269-b1e8-4fba-94b0-b94d3d9a5405@ti.com>
 <a62d5243-d641-48e7-a1f5-88150513be48@ti.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <a62d5243-d641-48e7-a1f5-88150513be48@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 28793055-c5f5-4233-2bcc-08decc632091
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|18002099003|22082099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ebXYpKTOIGhSb/HvJ7SPsLlIAvpGKBizjpIZm6Op0ECR7RzY330oC7XQIEJROlAX/4hzqhUu2sxJEtHuEb+LdWrBAVVWph/48qLVA8ursQApjP5a+yZgh7u1GwrGTKadHnaI25k5CJPshDqGcYKdRsDrYogkgibjTBgZyGFnUTOe7h7iwGgvNnaEcv90u9QZQB9619vpD/hYOzzeJqgaEfmAFF1DbdTtaZOnrnicWC6VskB8cOrQQ7ToVV2VJYKAIeyScKKLPVP4UbgK9h8K81YUWuwQWfVq1GUQCGpwfAEwourIFz/KtWVS//lJDqWsz/9RjVjEFL0qs28ZNp1cx2OxGzRL6na3eWtQg429Kf11AASVxvECSCu9r+VAV2TpuiS6UMNs+me47YiByFr2biqjjuB1boYrDyR3z/+u1delBqpIVA72Gh0Xdd+rauZD1KwvGdhloI9QURZgnFouGVJ/EZ9gM/2aCeBEB1uLGZ1elaJ1s4hmxx2O6XpAKzfFkSjPZyKLfI31qnlpK0yY1wyWs2C1SpM1b/yOrc8/hGEjfeALG3XN0Xna7LEAT2IR0GLt4mEXuvW/GHk87KcNTn7K/mylcqCQ+3BcO+yTjAOsp76zlauH/kVfJ2L89no64l11hNyIs/cU2WYelC+e5qBHx6Zd2Dj8weG3v+2koGj0Rm31WreSyQSSn4GJC4bYPb8CiSEVrYrGNjdog5bcpd6q9PNp3DZO5QeQ/fFPl6s=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eeSZ9hg4IDhHEY5R6h1H7rPf8Wj6k9ZhKoauH6s3NzsqKKl9A1Mql9c0tGfaihgKELRgiNwQRAnMiwNx4b7fXXU2kcaaq/LCXSQP1C1iUY5fSZ/dNw8tOYvid3keMqJg9RRUmIWO65vatODzkYrxWpYDICWsaJujG+h+kl6seeeE9ePCHG1H8+65XPSxtxoVnC75GBnY/8J/Ob+vmGibytWcG6mw8DfnWGtCWWN4cXxImIKPCLsIxcom+UOW+E2rJt9NETy4+pm0HEu4FPjTZJuvy2S9NspydvE0aVysYFgCWz/fUb/jxt0IqkVejDL45hL2lplCyycqv3ZOfWehUop8kjCehIuSU2XgB62j6KjDBEDFFgXidXqoOSEiCibWPp/FgGXT1a0e58hKc+sM59L6NefXZmdzJD7SM5A9TirLLtIfFvzWEJxpXC8DNBME
X-Exchange-RoutingPolicyChecked:
	Vp0JVVobnu9cXMLRhqcn2V1IZiC20hdvILATYNnosOGRBm/zacISAeScycdyXsF0FbQwfnyNikHXIQX/bSSsQ2Igoudy1cAi5w7KiMYTswA1+HyHa57BGKRMfeHh2dwlYpIP9i2WFPUqj6G0OiMoum4PbchyUp9uedGAnNXYAJ0XhwnS779hYZb8JUUEpiMfpWyd7iGf8d6RRW4tbSm5LHk20IYQnDlrxq9qcInAS+xZnLgMRbydhLANwU8rjlgpyGpXKLC2Mm5zD5YBLsxr+V/j1967d+pHPu/tMv30VFTQJubbBeFFv9yEfZuPszrE+d61MOmXquJv7HCx35zYLg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:25:25.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28793055-c5f5-4233-2bcc-08decc632091
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwOCBTYWx0ZWRfX49jn44cT+mHm
 ycENlz+r5EnrlGHT3422IUM4vuacN5wHYPJD05/3c1VTh06lQ5B05bxfbBhdsF98v4TXhBYkZre
 QXYlO7jKxM4K7RXINcUQOe+scjkX3D0zkO2vl5kvZDD+CvPgRwAVkIpCUjMp9Gcz5g4vMzlvwDZ
 ZOagWpoPXnJLWfVPN3ixAzSkzA9GMLh97VESyfTdirqfiUF7aqiezedL1Tg/57jbDja2h5vCv9J
 yxWSZoURVQrwdUPbMc0xrPIDImmPDbzHSoNr3bA0eGFZukrqhtbNRCJqZDDsAWW4UGPbIMuLoDa
 9OV2qL3m7vf77+axgokCzFBMg8cIc+Ysysredju4nPcdB7absnh8g1tlGfsM5HMqRMJdYZ2DdPR
 T5kdQyfRJy8XOTD48LgL6zBzCcM2RqPO393WOcr/PzoqDS2dxO9tAo1NZ1WcTL0j7Cbn5Cd0C8l
 wkDFTJ/8iOkx40wwEvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwOCBTYWx0ZWRfX+iYxuEEkbtVW
 xYctTY9lIM87K/urmo4GA4TzfzDhkGq/S8W/T2+ZFn2wm+NhyjHV6bGxrsI5XHJxO/yIWa/uM1e
 15FywqYkq7z+hrs4xyzEt7wUwHMCDzU=
X-Authority-Analysis: v=2.4 cv=AK4+T1yy c=1 sm=1 tr=0 ts=6a328429 cx=c_pps
 a=U8Tqu/vdlUTsaY0Seu/jpg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=YBvtnp3W659tjkMh2GMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tYN0ckySltTGVh1lUy3Uhf9bTAXVrxJq
X-Proofpoint-ORIG-GUID: tYN0ckySltTGVh1lUy3Uhf9bTAXVrxJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170108
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300142-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:danishanwar@ti.com,m:kuba@kernel.org,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E2926992FB

On 6/17/26 10:58, MD Danish Anwar wrote:
> Meghana,
> 
> On 16/06/26 6:24 pm, Meghana Malladi wrote:
>> Hi Jakub,
>>
>> On 6/16/26 05:09, Jakub Kicinski wrote:
>>> On Mon, 15 Jun 2026 16:10:41 -0700 Jakub Kicinski wrote:
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/
>>>>> net/ethernet/ti/icssg/icssg_stats.h
>>>>> index 5ec0b38e0c67..8073deac35c3 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>>>>> @@ -189,6 +187,11 @@ static const struct icssg_pa_stats
>>>>> icssg_all_pa_stats[] = {
>>>>>        ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
>>>>>        ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
>>>>>        ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
>>>>> +    ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
>>>>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
>>>>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
>>>>> +    ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
>>>>> +    ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
>>>>>        ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
>>>>>        ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
>>>>>        ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
>>>>
>>>> [Medium]
>>>> Are these five new entries duplicating values that already have a
>>>> standard uAPI?
>>>>
>>>> The same five firmware counters are exposed through the new
>>>> .get_mm_stats callback as the standardized MAC Merge stats
>>>> (MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount,
>>>> MACMergeFragCountRx,
>>>> MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
>>>> ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
>>>> publishes them via emac_get_strings() / emac_get_ethtool_stats() as
>>>> ethtool -S strings.
>>>>
>>>> Documentation/networking/statistics.rst describes ethtool -S as the
>>>> private-driver-stats interface; counters that have a standard uAPI are
>>>> expected to flow only through that uAPI.
>>>>
>>>> Could the firmware-register lookup table used by emac_get_stat_by_name()
>>>> be separated from the ethtool -S string table, so the new preemption
>>>> counters feed get_mm_stats without also showing up under ethtool -S?
>>>
>>> This -- not sure about the other complaints but this one looks legit.
>>
>> I agree that this is legit, but right now there is no other place holder
>> other than pa stats to put the mac merge firmware counters. I believe
> 
> You can put a boolean is_standard_stats. Only those where
> is_standard_stats=false will be populated via ethtool. Others will be
> populated via the standard interface.
> 
> Look at icssg_miig_stats for reference.
> 

Sure, since you were already doing some refactoring w.r.t HSR standard 
stats I thought this could also be covered there.

I will send out another version addressing this then.

>> the effort needs to go in re-structuring the hardware and firmware stats
>> implementation to address this issue.
>>
> 


