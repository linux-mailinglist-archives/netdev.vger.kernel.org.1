Return-Path: <netdev+bounces-224488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F43B857A6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C5B7BDC96
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1B1C3314;
	Thu, 18 Sep 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kPhn0/Db"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1421607AC;
	Thu, 18 Sep 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208046; cv=fail; b=kURZOThSwNKgXKDQv8XHBXIqQDHf5e5CnlB7QriJGYlsP4Q7++GupW3rOwuVd38TsxIUbIJsDBM6uiZifTsxUqg8DpyjlkIl1aajwp8zbduQGC7XJXpg6agRgosftepCxwqFtsPLbSEMDmDmtoMnuyzci+BQ1N9d92jpvKeLZqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208046; c=relaxed/simple;
	bh=BacE1VNELPpDBLck3NutKnug6kqH88XzWkrhn1FTM+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kUp6V60aTBeBCssqByVD4Vx5zPkHpvDyKRN6Roqy7sDoB/FedeW46X8RszXR/tLW9NZ7my0tW9RgbcC6MmgveNCO0C3d0DYaaGzTGEwUFgdOaFX3jaHAWIrXub4syJbyKqluQR4dZbv4GLJqig7nZh7Ae2Xk+u6TYzwBS6rNXps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kPhn0/Db; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDjG2n018046;
	Thu, 18 Sep 2025 17:06:51 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxh1cag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:06:51 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt0nYZTRwS1E/A299u0Uu1u+vkfpF/xPf4Xg25RLO7dEO5PJt4Eyog2GoUgJxHQ/uGne+vLU2kWTX5EBdfRJ0ICPpiuAfYMpmY2nV0XNOCtmo9DIgtB0SR33QLRPSIc767jCFvmVIjhyjpH59+FLO5S25ridO5VWFzFnkrM7viKYqyMAusgqGeh6uDP9GwBMK2CueH8YhLGPdSDT4Uy3qcNpifP86AFdUHEOLfIf4lyxDl7UgOVWXMIvvJfy+pP95n+D/xgUy5VIYbHHMGSSzsbKk4xB9VqEbFhVI5uQQ2xF1AEznXuHhm2cBmUgGTsKcQ22SiFTaramZq8herWeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKi2ANJf0pGpoOCFlFTyH97hfPEdtvbxlpXuVoDZYjI=;
 b=qye9j3SV+xPpRO+JSaiv9jk0HHmXhtTNfkG5MAp+nkEKWZSE3cCuOZXaW7rh0SJFIpAs7OAYnEnJc+QhExtCspZ71JxnxBLdzjRH1WUXMVnN9XQ6407NiTTjRSmGVVTceaSX1c97/FBAsA0awdwEgoUqpTxjauLUH5oLmXArVYZabltrWqP0sFdsiJrcCph6KxsnBIUIJbbvzl/rEhFronkhtF2m4gLMtvQJShkEA3An8KDvzo/N9wJ7WmYgG7gOad9qArL2j1H6SozSGItnuCMmKsPWdaLStKkAjnCPPBjxW6ahxmPAp9OjTc1IAyNRcicho2mMNLIXg8JTlhvnDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKi2ANJf0pGpoOCFlFTyH97hfPEdtvbxlpXuVoDZYjI=;
 b=kPhn0/Db/IRhgsSUulKNsYDV5xWWmcmPB9bphbDMrw/pAoMD22X+uml0t+ZopNnD3Va5rlL+Fy2biQ9VslyDvYCYoBvzkrfmgGzdMnzArqB2ezmV6WXBCsPwSjt6ZOBkGdXO4fnmV8y6p2MQ0u78sZNUw6CpVtOX7xC5Bg1ehCQzYLx5BFwf7Napf5cldQhwUQ7z79PS8gFw8+UrRUUdFQ/tayRmdg45pCizWGtkvd9bjdWIJnVcPgaapaaXKRGgOFo/xsGESwwXJDfWlxIKIMBwuVhk0RasOaPul3w6JmU4HJ8U8dchgZ4EHvXInFGrVoo/f/PhN/hTJog+F71c8Q==
Received: from DB8P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::20)
 by GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 15:06:49 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::b0) by DB8P191CA0010.outlook.office365.com
 (2603:10a6:10:130::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 15:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:06:49 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 16:59:45 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:06:47 +0200
Message-ID: <64b32996-9862-4716-8d14-16c80c4a2b10@foss.st.com>
Date: Thu, 18 Sep 2025 17:07:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Tristram
 Ha <Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
 <aMwQKERA1p29BeKF@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aMwQKERA1p29BeKF@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|GVXPR10MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7a88d4-e7fd-4091-4ac7-08ddf6c4fe06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDAvSXVTS0gza2ptS0FnR0h1bUZRaVJacUVFaytIamYwUWNiOUh0YkNkbjdz?=
 =?utf-8?B?bUpMK3M2anh4eElWNzA0bEdqdVdtQlhCb0drVSs1ZlMxcXo4Y2FHdmV0Y25t?=
 =?utf-8?B?S0I2Qi9yQVNlemdXVE5GcmFmOG8zSnp3R0V2OUtWV1hSYlAzaW1VUi9vVVg3?=
 =?utf-8?B?YWJmNEVaT2FmN3ZYa2lHZTlSMUdMYmJWM1YyTGNtWHZMWEx4M0s2UDVzOTdn?=
 =?utf-8?B?QjFWSmRlTC92bGl4aGhLVi8zcXhjdXErTTVIMFl5R2c2STF6WFNJdCtKSXBR?=
 =?utf-8?B?OHVmS2JZUTNaVlJyM3MxOWE4RXhERkJ6N2MvUTZETEN2K2VwRFdnenVHd1Zs?=
 =?utf-8?B?b3d2OGpYbktzWGU0TWZXaWppVzZ4Vm9xa0UzUEFQWjA2UWlpb1pIZ0EraWY4?=
 =?utf-8?B?bkgyZzR5R1AwcytBQmlHdVBBcVdmWHVYT1I2ZVpnK1V1dDh2eVZjTkRxQ2wr?=
 =?utf-8?B?NTJyNGM5b0hjalkyQjNXWlNpWnFDN0QyRU5lVWVoNXltQWwxY2s0UE5GaWYv?=
 =?utf-8?B?T20xYmRqWWRvTWhXTWFEcFp5NGxtUzR2cGFhL2o5ZmUwRzhXVUw5czBKckRw?=
 =?utf-8?B?bDlzVlIrbGxORVBOa01VMHVWdDM3ZVJUN1dHcitmN2poTzF6cXdJazJSV1Q1?=
 =?utf-8?B?YmorRUF3SGM3TkNZcHBYdHo2WUpLN3ZvV1pEekRFcEhYamk4WXhMMjNCSm9H?=
 =?utf-8?B?REp6SE5TbDVnajl1Uk1tcURaOGhiMlF0SnRXbHdSellqbXd4VzZ4TkRNMCtW?=
 =?utf-8?B?d2tnYm1VeVltQjRnVDhtTUFhN2w0MmxIbk1BcERxTWhCYnRMc2lqMnVZTTZs?=
 =?utf-8?B?ZUV3QXIyVE5RWlZZYmo2YXlMbmI4VUFLeldPTGhsTHJ6Ym1MUythQSt1eDVi?=
 =?utf-8?B?STMza3hVRlZycEgvNVVIYkxjWm9yNWRNM1cwYTEyd0lwbjZHM0lOL2daZmd4?=
 =?utf-8?B?UWV3Q3gwTW9NdC9BQUcwZ3JOUVRrQkRZUFBJdmNsVTVJbVNsaUJqUm1vL1NG?=
 =?utf-8?B?cEExOWRZRTZpRXFsTi9OZHQzVXJyL0JlRFNuUmdreWNIM1lFczN5bzMvY2c5?=
 =?utf-8?B?UDg5TUU1TFJheFJiRzR1Yy96MDF4M25MKzdzVWxUUDl4UWt4aWt0UXlYRnJW?=
 =?utf-8?B?c095QmY5SjJmQU5nVENFdERBbUZ3OUtXZlFqTFk4Uzc2S0VhNmNQL0JLTlln?=
 =?utf-8?B?eURRR00yblRxTC80SStpY1JidnU0b2pGSnc2NVBzM1ZJRDdxdmZ5cWhvRUhG?=
 =?utf-8?B?ancrdEwwbXJzQlJPMklFRmpRbGUxQ1NoSGpEam1WbzZpZXdjNFJTMmNMeDdU?=
 =?utf-8?B?QVcyS3E5L1RyWVMxSWFjLzhDaTFEVnB4YjVKVzBETmIwU3FsVllZUnpBN25o?=
 =?utf-8?B?S2VxdDhNNngyLytNZzJDT2ZHendLQTV2cmZtV1dHcEluc252Q3BrRnpzWnVX?=
 =?utf-8?B?azQ2ZURQeWsySGpRQzZmRjdsdUQ2RXFBS0ZJTm5KbWFjOEQ0TkszL0EwQmpk?=
 =?utf-8?B?alNiNFNha0tBejB0N1pMSHlYRzA0RE5qalkwWDV1Q0FlOWR1T05RNCtCQnBC?=
 =?utf-8?B?Vk12WTAwZFJLQ0tXSVdKSzFlcVFHUmFLN3BqeGRGV1BlYk9nVmtOZjlXZnY3?=
 =?utf-8?B?TkJSdTRzTkdqb0NyakkzQWhneWhsNDJ2NHdla2Y1SGl3ZFdhNWNSai9uL1dO?=
 =?utf-8?B?cTVRM3h4OU1UcDNNTi91d2M0TStnYUsrS1QxRnB5Z1FQTXNXTklpdzFZbkNW?=
 =?utf-8?B?VWJsS3YrVWZFSEd2SkxNaGNFSkVpd0FwWjUzTEY3V1c2SkdsVW00VitoaEVo?=
 =?utf-8?B?MjZKWHJOdVk0RVFBT0VNbVRhekgwQUNyc1EvZGEzUFJRQ0FzY2sxbm9qbWFB?=
 =?utf-8?B?TTJ4RjZ3RnBEakYzdUJTbTFQMmFpMjVoWk9PU0JXdTg1aWFMcGNrWS9tVUoz?=
 =?utf-8?B?aVVWODY4UC9kKzdtSjlONnhLTVRpbDVGVjZzT2tmMXNBN0VOSWtYOE9yeVRt?=
 =?utf-8?B?cGV1NGk5MmJURjE3cVRkSUp4RE1ERXZZc2JaZkdEMVcyUnJwUWZUUGZmcWNQ?=
 =?utf-8?Q?Lh2eOO?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:06:49.1388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7a88d4-e7fd-4091-4ac7-08ddf6c4fe06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9484
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7ebfEQ1FjnT2 fZ9v6TgyNRiQ7H7Q2yGHvVYj90Ck8eqRaJ9uyhLb58Gu0MIOpAJwe/8aGxNZftIGSiAUZEfhLTW gd4udujLswm/9EqNzNHhc+/TqAHH4wSeVoOihhVNmMl1PwLJCtHHjQXGoVg3aPPCkA0/Yq0PTFL
 ABwg/sz9RqcK4OgqE1h2JRJ6K9xpXs/JupwpZTu/zoZh1s3qBMuH14PUYTxn/4iXoBjqNByZfSw pkFlQtj3ePmTOxX9GS6RI/ro4czPKf6mLPXfYrYr8ZbXc0GDgPqtvrEuGrMv/BaqJYI/p0WZHS+ mG37+L92T8/sQNmz6SF58oZkPgev68jOYWJOc6Li7oU+9lPW95ISwToHRTOZpbL5mpzWPT1uROU 2NcNCO8I
X-Proofpoint-ORIG-GUID: FCaxw_JlwIQ3SGjxOZSAJtw2wd1_2YyM
X-Authority-Analysis: v=2.4 cv=aJLwqa9m c=1 sm=1 tr=0 ts=68cc200b cx=c_pps a=7WY7GTgoQuM1Lo32AUII8A==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=sL_G-GOk0kdtY-0adKIA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: FCaxw_JlwIQ3SGjxOZSAJtw2wd1_2YyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/25 15:59, Russell King (Oracle) wrote:
> On Thu, Sep 18, 2025 at 02:46:54PM +0200, Gatien CHEVALLIER wrote:
>> On 9/17/25 18:31, Russell King (Oracle) wrote:
>>> On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
>>>> If the "st,phy-wol" property is present in the device tree node,
>>>> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
>>>> the PHY.
>>>>
>>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>>> ---
>>>>    drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>>>>    	u32 speed;
>>>>    	const struct stm32_ops *ops;
>>>>    	struct device *dev;
>>>> +	bool phy_wol;
>>>>    };
>>>>    struct stm32_ops {
>>>> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>>>>    		}
>>>>    	}
>>>> +	dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
>>>> +
>>>>    	return err;
>>>>    }
>>>> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
>>>>    	plat_dat->bsp_priv = dwmac;
>>>>    	plat_dat->suspend = stm32_dwmac_suspend;
>>>>    	plat_dat->resume = stm32_dwmac_resume;
>>>> +	if (dwmac->phy_wol)
>>>> +		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
>>>
>>> I would much rather we found a different approach, rather than adding
>>> custom per-driver DT properties to figure this out.
>>>
>>> Andrew has previously suggested that MAC drivers should ask the PHY
>>> whether WoL is supported, but this pre-supposes that PHY drivers are
>>> coded correctly to only report WoL capabilities if they are really
>>> capable of waking the system. As shown in your smsc PHY driver patch,
>>> this may not be the case.
>>
>> So how can we distinguish whether a PHY that implements WoL features
>> is actually able (wired) to wake up the system? By adding the
>> "wakeup-source" property to the PHY node?
> 
> Andrew's original idea was essentially that if the PHY reports that it
> supports WoL, then it's functional.
> 
> Sadly, that's not the case with many PHY drivers - the driver
> implementers just considered "does this PHY have the ability to detect
> WoL packets" and not "can this PHY actually wake the system."
> 
> Thankfully, all but one PHY driver does not use
> device_set_wakeup_capable() - my recent patches for realtek look like
> the first PHY driver to use this.
> 
> Thus, if we insist that PHY drivers use device_set_wakeup_capable()
> to indicate that (a) they have WoL capability _and_ are really
> capable of waking the system, we have a knob we can test for.
> 
> Sadly, there is no way to really know whether the interrupt that the
> PHY is attached to can wake the system. Things get worse with PHYs
> that don't use interrupts to wake the system. So, I would suggest
> that, as we already have this "wakeup-source" property available for
> _any_ device in DT, we start using this to say "on this system, this
> PHY is connected to something that can wake the system up."
> 

Sure, seems fair.

> See the past discussion when Realtek was being added - some of the
> context there covers what I mention above.
> 
>> Therefore, only set the "can wakeup" capability when both the PHY
>> supports WoL and the property is present in the PHY node?
> 
> Given that telling the device model that a device is wakeup
> capable causes this to be advertised to userspace, we really do
> not want devices saying that they are wakeup capable when they
> aren't capable of waking the system. So I would say that a call
> to device_set_wakeup_capable(dev, true) should _only_ be made if
> the driver is 100% certain that this device really can, without
> question, wake the platform.
> 
> If we don't have that guarantee, then we're on a hiding to nothing
> and chaos will reign, MAC drivers won't work properly... but I would
> suggest that's the price to be paid for shoddy implementation and
> not adhering to a sensible approach such as what I outline above.
> 
>> However, this does not solve the actual static pin function
>> configuration for pins that can, if correct alternate function is
>> selected, generate interrupts, in PHY drivers.
>>
>> It would be nice to be able to apply some kind of pinctrl to configure
>> the PHY pins over the MDIO bus thanks to some kind of pinctrl hogging.
>> This suggests modifying relevant PHY drivers and documentation to be
>> able to handle an optional pinctrl.
> 
> How would that work with something like the Realtek 8821F which has
> a single pin which can either signal interrupts (including a wake-up)
> or be in PME mode, where it only ever signals a wake-up event.
> Dynamically switching between the two modes is what got us into the
> crazy situation where, when WoL was enabled on this PHY, phylib
> stopped working because the pin was switched to PME mode, and we no
> longer got link status interrupts. So one could enable WoL, plug in
> an ethernet cable, and the kernel has no idea that the link has come
> up.
>  > So no. In a situation like this, either we want to be in interrupt
> mode (in which case we have an interrupt), or the pin is wired to
> a power management controller and needs to be in PME mode, or it isn't
> wired.
> 

If you are in interrupt mode, plugging a cable would trigger a
system wakeup in low-power mode if the INTB/PMEB line is wired to a
power management controller and the WoL is enabled because we're no
longer in polling mode, wouldn't it?
I tested on the stm32mp135f-dk and it seems that's the case.
Or in this case, maybe I should never describe an interrupt in the DT?

You can argue that as per the Realtek 8211F datasheet:
"The interrupts can be individually enabled or disabled by setting or
clearing bits in the interrupt enable register INER". That requires
PHY registers handling when going to low-power mode.

There are PHYs like the LAN8742 on which 3 pins can be configured
as nINT(equivalent to INTB), and 2 as nPME(equivalent to PMEB). The
smsc driver, as is, contains hardcoded nPME mode on the
LED2/nINT/nPME/nINTSEL pin. What if a manufacturer wired the power
management controller to the LED1/nINT/nPME/nINTSEL?
This is where the pinctrl would help even if I do agree it might be a
bit tedious at first. The pinctrl would be optional though.

On the other hand, if the pin is wired to a power management controller
and configured in PMEB mode, then an interrupt cannot be described in
the DT because the polling mode will be disabled and the PHY won't
generate an interrupt on, let's say, a cable being plugged => no
link as well (I had this issue on the stm32mp135f-dk board where
the LED2/nINT/nPME/nINTSEL is wired to the power management
controller and there is no other nINT-capable line wired).

So it seems there are still some issues but I may be missing
some elements here.

> Which it is can be easily identified.
> 
> $1. Is there an interrupt specified (Y/N) ?
> $2. Is there a wakeup-source property (Y/N) ?
> 
> States:
> $1  $2
> *   N   we have no idea if an interrupt (if specified) can wake the
>          system, or if there is other wiring from the PHY which might.
> 	Legacy driver, or has no wake-up support. We have to fall back
> 	on existing approaches to maintain compatibility and void
> 	breaking userspace, which may suggest WoL is supported when it
> 	isn't. For example, with stmmac, if STMMAC_FLAG_USE_PHY_WOL is
> 	set, we must assume the PHY can wake the system in this case.
> Y   Y   interrupt wakes the system, we're good for WoL
> N   Y   non-interrupt method of waking the system, e.g. PME
> 
> I'd prefer not to go for a complicated solution to this, e.g. involving
> pinctrl, when we don't know how many PHYs need this, because forcing
> extra complexity on driver authors means we have yet more to review, and
> I think it's fair to say that we're already missing stuff. Getting the
> pinctrl stuff right also requires knowledge of the hardware, and is
> likely something that reviewers can't know if it's correct or not -
> because datasheets giving this information aren't publicly available.
> 
> So, I'm all in favour of "keep it damn simple, don't give people more
> work, even if it looks nice in DT" here.
> 

