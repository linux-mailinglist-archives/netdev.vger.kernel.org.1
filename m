Return-Path: <netdev+bounces-225512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBBEB94F57
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFF1899F2F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D331A04E;
	Tue, 23 Sep 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gVpn7jA2"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5331691B;
	Tue, 23 Sep 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615632; cv=fail; b=F0IlfbJzTmKHLIVPz9H+O7VD7Jd5/ja0FMFRMtuKhMYqilnNqkmnzsF2vljh4YHoUmEmbmpg/PK9uyYiXF/iErmBn8laB93dLsExFmG0qM7DBS8IrASSPqNPPn+Nb9LlTse95OuZX4eL/hP6R+rzMSQ+gTpWw0jKxSaStAwKFdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615632; c=relaxed/simple;
	bh=g2TF/dWmDp+5bg7NoOdAIGLA3lEu+XO3ogyMZb6L8iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BrLTpVmO+C2ne8ageORpIDvGnmOHEht1m+ODxLrRI8/PHj0v9mXbAele6TgFVCwKF4mnmN/rAUebtLoXe2lfzIYi7ub+yxdihM6j26jw3xPusZijOjxWFNEiVZtePywaerOK987kSyBHhrXLTLezSalOHVc+mdefv3h8bJ67QgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gVpn7jA2; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N81mXD015882;
	Tue, 23 Sep 2025 10:20:07 +0200
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49b7pf3g3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 10:20:07 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8yC2eEY6lpYfxXnoCYUavI738eapqkRQ6sScmrjM6IlrPTUp21r1lKva2VCEpEH1fV+fgoP9vOuzjLrHL8GDLrDORJLuMz1DGuR0IMUZDMEbUsxXKKFWhmenqwwTt9tNDHIz5C0MbOBlbq4UL5ToWqip6LdKawNghGjpvQuwxlubjowgIiRq6fMD2I/3QiCCYeh5kk6X+uL4Ym6R86mUEA98C2PHzQgt1TgoVNb0n6KidPVm9VHE0sKrj9s1MwrCeY78y/rjRqHz1Wclat+s9fJCU5dBLZI0w2h++JAZUHAyOqTNM/d9AXexpmwxh9Duscl+7qawyJU4bm8p4giDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx3JnukKcin3hQdFQWZ5JtPeTp2j19rhqeAQMxkJ/LQ=;
 b=PNmjEPbYOwsg7RKWuZdFek8RNX7sRE05xjRSEt+fpjmqNvWYk5bS7CjsLsExQ9DdGO37XI501dDrh/h3kisVrJjSd/8FnM4t5MBjyBewe5xxGGUR1m8b06xeoiyXbzgrqXWlfbnSHXaDvU2Ur9evN0HY8PaewBvlrq8lw8jRHXOQscUIGFgdMDUHJCjKxr7XuqOQ2rA9k5t86zQdOB2PcmaYmK3QTFCTNYysS05ErnGrnnMRtM2JQMM+QWVC9+/UFYC8uKBKm6FeD2qAcsJQiTRXldCs8kNML6ixfXOCX8ZTqHJd/jo+3Pk0GExl6//vtRy+4mEa33Fjhjfv/na7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx3JnukKcin3hQdFQWZ5JtPeTp2j19rhqeAQMxkJ/LQ=;
 b=gVpn7jA21WYyV0MCy4szjDY7w//DGhlHt+crdvGI4MyBEC9OoOZ1/LbuMEZjJU7ZwqZyyay59ixDCt+Jf1cTy7HacyV83Pxvb8ayihqnKKGmuAIp9PTLpHDP6FicVcJEbF39ltpkFrNupDYDjEJCVZFWWoSBQUPkjk0Xc5SgCYqUWMyI5kOyGkBYOeFlEm2nrP6h1unFRnHz6omDXFRQ5mGRP2KdtN9uKr5agepayQx4NUsi+DsZViuw+K52U4dat/So/uaUMbHzZ0oXEiCIMAS8dYwuVQC8WfuNMDfK+yHxzqyP4C+lnTGBTOFh4iYCMl71ppmlw70ulmNxVLPnxw==
Received: from DUZPR01CA0299.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::10) by DBAPR10MB4059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:1cc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:20:05 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::2a) by DUZPR01CA0299.outlook.office365.com
 (2603:10a6:10:4b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 08:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 08:20:05 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 10:12:44 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 10:20:03 +0200
Message-ID: <e95085f4-ff7f-40e1-a0fd-514bff4bcd1c@foss.st.com>
Date: Tue, 23 Sep 2025 10:20:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Tristram Ha
	<Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
 <46f9bdf8-a35c-4e94-9d4d-c87219444029@lunn.ch>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <46f9bdf8-a35c-4e94-9d4d-c87219444029@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|DBAPR10MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bc1368-e908-4002-2812-08ddfa7a002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhKakh6dXRYS0c2ZjhiQXJwNVpvMm9kdFJ3NDJMRkhBUSt3SlFWZ2RhVExG?=
 =?utf-8?B?QmpBOEREcG52ZlFVQ3VsazBJb2hOUkgrbnlTUGZCc3VZVGhzcHhxSlNET25k?=
 =?utf-8?B?SW9XbkxGTmI5Uzg0ZElydTJQSTh4WmpLVnBLYkVFdFBUTlNqQjB0aHRBd3VF?=
 =?utf-8?B?RVNtMm9mRVVjU0Jyc3ZwVFA5ZXk0K0VtOHhHVjNUcVVrOFVCMUFWTnVVL1Bh?=
 =?utf-8?B?N3hoNFpVc1g3c092L0QrUUV0eVhEUDU5aTZ1Y0ZkZStqeGxzOHYvNDBNKzBw?=
 =?utf-8?B?a2hiRUpJcnZ5RHgwbjE0dThDMU9aTFZhZmJYRDROUW1EeHg0NGV2bzYrNjF1?=
 =?utf-8?B?L0RlOE9YRERsUTJBbHBQYjV3VndCVGU3aGJsemIvS1l5Z3N2OU9xbDlDVGdK?=
 =?utf-8?B?YXllbnUxUFBHUWtoRWFzUFdidjhpSDdTQzAxcSt4cUUzRjJIV2JOYVhuS1dB?=
 =?utf-8?B?aVl6N1R1TVNXWnRhclR3TTRmSU5Zc2syK29JVUFRNmtjMjRhTDR2eGhWUXlh?=
 =?utf-8?B?SjZESjJCM2pFcFludGRlZlVONHI4c0VxY0pMWTI3WkZicFZjZ3A3Ry9xTTV1?=
 =?utf-8?B?UE5NTm1vL1ZhU2hETURoeURmUnVJTHppWUJTVVRWbFpLYXAwbFg5VWFVZ2hM?=
 =?utf-8?B?WHkwa0NoSXM3R205OUpEQldldmFXaTYxMWoxdXc2L3dxMG43d2NJY3RJT1oy?=
 =?utf-8?B?REx3NmNvU3R0Q3dodUJFZ2djREVBTkgra3dnTFdOWmJmVTJRT1lTNTVsMGNE?=
 =?utf-8?B?NHMwTUhaanlXZitEdVBtY09vMUtIbWpKVjlUSUQ1bndhMDFHUDJCZjU1dk9E?=
 =?utf-8?B?U082Vzh3TkZDdzAySXpNMUVZdUdzV2xWSm5CNkJXanl5Mmx0cXdwS2RQMnJ0?=
 =?utf-8?B?MW9DclNocFg4SUl0SVRsWnNNQmpJVjB2SDBxbHB4a1JySVZ3S09mcEp3K05l?=
 =?utf-8?B?VXA5bHRGUTlPcUpuUmdsU1NvR2pQeG1lcXU0b21jNjZZSTYxZUtQbFFkU2ox?=
 =?utf-8?B?bmJ1R3FLK0FVMXovTXNLdXVORUljQzlYekVwTng5bUVLckkxd0RsT1hzSVpa?=
 =?utf-8?B?a09LNno2cjh4am5nVG42NWE4eXBYNnRQamZ3YWpjdTBsS20wQ3phTGhqVmdx?=
 =?utf-8?B?cjFFaGdEd1B2NWNWTm5uc3JjcUVvUjR1d2NPRVBCaUx6bUlUQVFIRFc3OE9y?=
 =?utf-8?B?NW5UZURGQVR0VXZMdlE2MGpNUnVud1duOWRUc0QwRkNZbTY0Ri9lbGcvYWN3?=
 =?utf-8?B?N3NWelFaaXArTTl3VGZRVldmcXFEdVJPUzUwSXBsTGJrNTUvc1Rud2hBNldj?=
 =?utf-8?B?cEErTDY2ZE16VlBNQnRua1lXajZHaktZVENZTGI3dXlzNHFqY0FxYzZ6NGt5?=
 =?utf-8?B?ME83d1l0OVh1bnoyY2VvQlVWWDRaRWxTSExiYzRjQVlETnZoaFJBZTNOVUlj?=
 =?utf-8?B?d29XRk5SaENxMFIxa0JUTlNZQ1lFUWpvYnhKR09PMDBMVC9GQ0sxUG5wazMw?=
 =?utf-8?B?VllrNFlDWTZ6aWZRY09uZXRjUE5za3U2cjZxVE1yc0svU0djd0UraFhMckkr?=
 =?utf-8?B?b3VmUHBadDFKakE3Wk9wRjVhOUFvdXdpeVBXZFpTWXlGeWsrdzNMdmxCcUlS?=
 =?utf-8?B?a1k2bW9BaFpvQ2w1WVdYR01FbWlqalFZeEJRcEJOZGIvR3k0Ym90cnUwZXR0?=
 =?utf-8?B?bEl1Y3c2Z3lFc1lwM2t4SjkzYTV6dThsOVRpSzNCUTU4ZTlqWGVla3BEYnlC?=
 =?utf-8?B?eDNJZUZtNklyVWhXeHlhdjZoL0ZNZWthRGN0WkRmbVBTWXZtazF5V1BRSkto?=
 =?utf-8?B?cmhWSWtCeXczUG9PNU9sMjl4ZDViMlJlN3B4NjhzMXZscDNvY2RRdkQxNCtZ?=
 =?utf-8?B?NVFYQTVSWmlUOVdVRTVRNUVHNE83eG9QS2ZvRmJzc3p6a1Jucm00VEFWbXZI?=
 =?utf-8?B?WGhtV1Y0Nm90cVlFalRwZW1QUVhXUWtETE5xdm5yOGtURXQzcWszandxcWNs?=
 =?utf-8?B?aXBrOHNUbWtob3NXYzBiUHlBa3dWcFVZbEt6di9CalRGVC9EWlU0SDBlVmJi?=
 =?utf-8?Q?YNQE90?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:20:05.1205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bc1368-e908-4002-2812-08ddfa7a002c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4059
X-Proofpoint-ORIG-GUID: VtkRA6V57Kanfe_j4AjST6aPkFkBMBgT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDEzNSBTYWx0ZWRfXx6qMbWoDhfCb MxPI8JUtBAEbEOats4q2VUq5Zpbeaul7afHyZXSdioOizW3nrllz0jyrKqXGEp0qCghvwoiguQ9 GoxIj7pFajJ9It7SsNaugO8v0mA+55G8GIoxUAPNnhi+UaA6Byau1JZ0JOZFoU7uAxT3gjq0Jim
 s0JW/IuVeJ+PJ1CJQckIxZYeAhPjf/kxo06i7vJmuYur3y3eZPNsspXYz+QOQJSFV7PCpp8kEdo FPpY0el/ePESiRVjFfPaGsDLxSXFijgx+3OwdTR+cxNzTDNK6askpJDd01Xmo4A7hK4Bg8ZXFTE gRv3vWQoDnBgqocJ84al0H412sEXv0WaV9O3bGpn7GDk4zAoYeZ8kMAFEfMSLEeTrzIVrSBBTwL YlZudpij
X-Authority-Analysis: v=2.4 cv=IvYecK/g c=1 sm=1 tr=0 ts=68d25837 cx=c_pps a=+ohsn0u86qlID4FyhhUwTg==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=E3GHTLob2G1mBu3on-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VtkRA6V57Kanfe_j4AjST6aPkFkBMBgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509220135



On 9/18/25 17:34, Andrew Lunn wrote:
>>> Andrew has previously suggested that MAC drivers should ask the PHY
>>> whether WoL is supported, but this pre-supposes that PHY drivers are
>>> coded correctly to only report WoL capabilities if they are really
>>> capable of waking the system. As shown in your smsc PHY driver patch,
>>> this may not be the case.
>>
>> So how can we distinguish whether a PHY that implements WoL features
>> is actually able (wired) to wake up the system? By adding the
>> "wakeup-source" property to the PHY node?
>>
>> Therefore, only set the "can wakeup" capability when both the PHY
>> supports WoL and the property is present in the PHY node?
> 
> There are layering issue to solve, and backwards compatibility
> problems, but basically yes.
> 

Ack

> I would prefer to keep the phylib API simple. Call get_wol() and it
> returns an empty set if the PHY is definitely not capable of waking
> the system. Calling set_wol() returns -EOPNOTSUPP, or maybe -EINVAL,
> if it definitely cannot wake the system.
> 
> However, 'wakeup-source' on its own is not sufficient. It indicates
> the PHY definitely can wake the system. However, it being missing does
> not tell us it cannot wake the system, because old DT blobs never had
> it, but i assume some work, and some are broken.
> 
> We need the PHY driver involved as well. If the driver only supports
> WoL via interrupts, and phy_interrupt_is_valid() returns False, it
> cannot wake the system.
> 
> There other tests we can make, like device_can_wakeup(). In the end,
> we probably have some cases where we know it should work, some cases
> we know it will not work, and a middle ground, shrug our shoulders, it
> might work, try it and see.
> 
>> However, this does not solve the actual static pin function
>> configuration for pins that can, if correct alternate function is
>> selected, generate interrupts, in PHY drivers.
>>
>> It would be nice to be able to apply some kind of pinctrl to configure
>> the PHY pins over the MDIO bus thanks to some kind of pinctrl hogging.
> 
> I don't think it needs to be hogging. From what i remember of pinctrl,
> when a driver is probed, pinctrl-0 is activated. It is not limited to
> pins which the driver directly uses. So if LED2 is connected to a pin,
> pinctrl can at least select the needed function for that pin.
> 

Ok, I'll see where it takes me in a separate patch-set.
Thank you for the feedback and clarifications.

Gatien

> 	Andrew

