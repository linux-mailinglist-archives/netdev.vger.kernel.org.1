Return-Path: <netdev+bounces-225509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0AB94E6C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8523B190363E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB702F39A9;
	Tue, 23 Sep 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ulqu1Om4"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEB2EDD5D;
	Tue, 23 Sep 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614581; cv=fail; b=TIAnyUV8HA3xod0dvEY8kTfkIMhVflmnTx58YEBDD+LMbIYKrAo/Mjnnn2rtukcAYeBxSGnSkB3aA6FMPhL4xsm0/7oCdbDBjO4xUxaJT0j9rd295mV2g8/7smm53s6ND05DnMBqihaoUXfsmswChekCsylfcDbcn6v+aXt8+So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614581; c=relaxed/simple;
	bh=AB41ai6qmlYjYZz081gJG1+mGC200q30PS5/ofiaXO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jwjanOU3aZeIhgE8bKoPSiLekYeEZtyJkWpLvf/b4AnyI1XQpJSzIfwZHAUSuseXqMnKVZ/6sTP/lrkHa5oX79qkB3liBA3OBFosp5OC99Fg9/c5IEp4kMu5/UsvGEn2AwUnm6IxLQgXEI+E5WMNSUEsFyaopd0p6Mwq+QJCs7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ulqu1Om4; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7V509031169;
	Tue, 23 Sep 2025 10:02:15 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49a77m18tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 10:02:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXZ4PBcpF8CAzG9UcMXPsWQWYL1IJ0gL3Lzh3QpGG5OM9X+tZwVB9kx0AfztI62yQ1z6mFiqtYF1ZCXoNDlps82+qYG3Wd3pEfOd50RY+eUKygLyqiK8L04Nz69t3WazrAvNVbe/UIQbOjgdEHFL8nzrsvssYTAi0KDvyKSA74LXT16HMH8pDxZvaLYavgh+GdY5GeFTqNZa4LxQ5TYEGLDkPfL8sPqvA4PvinLmZfAG6LgJk9SS81TItsAQH+TlYhvIW/cHqFMF/TZdPThmWeNnhcXiAdsW1B6Y9I1hN8CnS3eXayt49Rh0IoZQqZISByGptLhR3xVMs59FJ+C0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzv9DGMEDu+jBS1qGJo+CT78FnyAeBdJNN0Ypgbtg1M=;
 b=Ucu5+wXNw4Y004oYWNn0ZxteqfLokYnEY9AiK6hSoVBsvSIpwuJWmqwk+FSpnOSINwox+AzbtJMDU/4aFeShZefcj/0hqvaIxOsblTFDR/5T4R5Vo8oRm1YE8UI+yXFFlO3BrBLoV7DK9pg4qStxMGkA36evXWaVLtRq1yWa9cKk4Dpm7lQFVWU4j9IOTUANc7Fc+A90Lv0O/u8Nz4pF2Amv1+T8XA2qbRgThcs8It/ezqOeHCBiGKG/nlWmTbViV5L6upluaZZ/DPhY/KI+piCTWN0JGkF0ufHzaelqu/b24CL1Yxf6PuC+e+dZi/NE5LZRxwBMD2i5HpNYAaMbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzv9DGMEDu+jBS1qGJo+CT78FnyAeBdJNN0Ypgbtg1M=;
 b=Ulqu1Om4dHjDiTB53xRrOLYwT8tHM3zwPc5DI459KHb3SiWQIhWSqSQGyo3L2+0d06cbiovNJgnUnyepSXXPgzfCQw6eF2z8aA8MjhthLJjnPpb1VVDPg/GgR4ImkyhHJf0l5MEI74LvDYIaO+lY2TEAfoKCTz8+ZlU9nX/VnmfhBjoQAp2Q6Tbx8Ee6y2tJUaUcMI3dxbOo6MhB1vufbSvMbNFOWBQOf6KoGDmYvIE2lV55WvNnc271N3BPaOge9SMJOQaIDkMCs3GJY7XJSE9JQ1JT1YNeT99pgMheeDJpOw2aJRFY8c9wqEiY2QynuqUPXCjSfvTf38sva3VSTg==
Received: from AS4P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::19)
 by VI1PR10MB3648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 08:02:12 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::4c) by AS4P195CA0004.outlook.office365.com
 (2603:10a6:20b:5e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 08:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 08:02:11 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 09:54:51 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 23 Sep
 2025 10:02:10 +0200
Message-ID: <89d4f257-0326-4bc7-bf53-6a2175f139ec@foss.st.com>
Date: Tue, 23 Sep 2025 10:02:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: document st,phy-wol
 property
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
        Tristram Ha
	<Tristram.Ha@microchip.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-1-105f5eb89b7f@foss.st.com>
 <20250922170534.GA468503-robh@kernel.org>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250922170534.GA468503-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|VI1PR10MB3648:EE_
X-MS-Office365-Filtering-Correlation-Id: 045e7ae5-83c2-40ad-01df-08ddfa77806a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WklrZ1NHYzBObmgzWnZCY3lBTmlLQUU3YlBQU2FOcllTRWdGR1BPRUhicmdR?=
 =?utf-8?B?OHE0K0t6Y1F2UnoxNk8rTjBwSXpFeTY2QWpudml6ODhUTUJjV2QyT3BDM1BE?=
 =?utf-8?B?RVhzMytRYTlKeTNWR1FidkI2dmYzZnBHUHR2ZHBTZjR1ZC9KYVBzQXB3NlYy?=
 =?utf-8?B?S0toNU10cEpZcHIySXRXaTdOVzJML2h2YU5DMVhUU0xmQ3JFTjZQMnF6cUZ6?=
 =?utf-8?B?dll5T3lKaWtYRitHQmpGeFdSWVFDRE5ydm5SVUQ4WmNTTTQrNHNWV2dId1Y0?=
 =?utf-8?B?QXo5MERQTHB4SENzSzB0bG5WVkx0U0htR0pHbmU1VEdtTUl4dklzV29pcE9Y?=
 =?utf-8?B?VkQyMnJpWnBDS2VVamk5SGdhNUE2MlJRL1dSTnRGRXR3SjJQNzBrait1dzBx?=
 =?utf-8?B?a3B0d3dqbmRnMlAzS2ZyWEV1VDVOUE5YVmhyckVhTWZCcWhNdWk1Tm1YcjdW?=
 =?utf-8?B?bmJBbERCZkFreXhLL1A1WjJlQ1R5OUMrOVlQM0xURDl2YmhpUGRyTkVVYjFr?=
 =?utf-8?B?by9iTEhFdFpDU0NyN0hyUERrTVAwVktuaHdMSWVhSU5xUHJYSEtEM3o3SnNY?=
 =?utf-8?B?Z2tHWlpnQVRJY0RoSUtKUWs4TDJpQS9WZENaSG9SZ3hUNDRMZ2c5dVd1WTJl?=
 =?utf-8?B?RHg4ZlBNWW1xekRpTU4raERYbW5wN3VDUTZFWEpHSVhJNzdGMWVpT255cXZH?=
 =?utf-8?B?SW1LR1BwQURUbjFyT1VYV0ZpRUltd1g5TWNGNFlUY3BIdXB1S1FrUU8vWCtM?=
 =?utf-8?B?dkpJRkpHclQ5NTEyQjhzQTFzYlYyYzJydFJEMktzVTdVdU8rUjQxMThCQWVs?=
 =?utf-8?B?Q3NHVGxRVE9DUVlpTDY2QlJsdGdsRFpZYU44OGRxVmVFdldKZEF5R2V5R2RD?=
 =?utf-8?B?a0ZUdmRaeXZXN0dxVnFUK2xNQmhLc2ZrcDA5UFFsR3orQWp3a0dnNkJUZitF?=
 =?utf-8?B?YVBVRFUwNTNnN1plalMwTEZLbDNMeE1Sb3ZyQm1xbTJmR0dVSmRFdTlHeG4w?=
 =?utf-8?B?d2FUeSt2Rk5DQlpRazBudWEyQ2N3ZGl4aGdnYkR5SjdOU2xuWUFPc0w2aHcr?=
 =?utf-8?B?QldzTEd1Mk81TjhqL2V2OHFLMllQUjBMbmtEbk5TekxTUythNk5UUWxzL25r?=
 =?utf-8?B?VEF5V0tCd2dLYWFJRTBGWTFYcnRyYWRmNjZoVUNXTFRCeDJkSGtuS0w5VS9Q?=
 =?utf-8?B?K2J0L3Iybm05amI4bDk5S2pESko1U1N4a1BQQ2I5Tmp0NDBTWkNoQzFYbUtP?=
 =?utf-8?B?cGhSTmtJU2pockJGdUdSSEYvdkJkSDJWYjhLZ1QyZlZ3eVJqTHgzSmc1c1gx?=
 =?utf-8?B?YnlxVndvS0FkUC9lSUVaR3RWekVzUDJsV1cvNkhPWWhVaHZxb1lUVDF4RHJw?=
 =?utf-8?B?RHpybjh2ejZiWVhSZ3JUaEtqZTlBZ2VPNzQ0QWpla3NrRWlscUxZT0VFc3VK?=
 =?utf-8?B?Vm10SjNUcDNMNWZiK1JYR29XNlBXUlZSNW93Q0VSU1ZrSHVOMlRXb1pWQmJP?=
 =?utf-8?B?WU83eklXYVVVWm5mUXFnK2MvdUlVZUVOMzVJOXBvTlpnZ0RPa3kxNmp6OGJY?=
 =?utf-8?B?akdVOHMvaEN3YmVHZTQwVk0xWFdYdUpQYkVBOTV1TW5YZVpYSksrNk5oODhs?=
 =?utf-8?B?TFY0VEZRc2s3aWZjVVRSVDZWUXdDU3ZaOUdjWVBMalNqamdJcElFUVRWbWIz?=
 =?utf-8?B?ZzBDSG9tWHl5UUhWRUQ2VDJDUG5QZXNBM3ozUFBCVUlvZ0UvUU1IeWhqYkE2?=
 =?utf-8?B?ZSszUGdVQmFhVHNYTVNGNjlwQ0ZiemxiWmdITThpS2pubEw3T1dXWTJwdytP?=
 =?utf-8?B?d09WUUtMbFpMSUgyUWxGbGcrOWcxS29jQlBoaStQMnNDaHNiUXFiL055T21B?=
 =?utf-8?B?eEpxRFZ1YlIweXVBQUN5Mnhhckt6d3k3TGliL2RaRzRPeDBpVGdoOVBOMnZB?=
 =?utf-8?B?QjkwRHNCWWZkTDlMT2podU42TXVENWdIWlVKZ2ovSUtEdEloN0JYUmhJVXN2?=
 =?utf-8?B?dVJJc01LK0pHRXRIdE9tZllCU2VvQ0JDOUcyZ0k2SXV2ZGwwRTk5VzEzc0Y1?=
 =?utf-8?Q?hkdLIk?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:02:11.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045e7ae5-83c2-40ad-01df-08ddfa77806a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3648
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIxMDAwNSBTYWx0ZWRfX1vhMe+S+cybn kMDrnptjNkxRuld+nhv3nGbGdtOnn2Ph5pfAm1oKvNvpnNTMWip5aE7W7LDByCmViHKvACp4WzS 6JhpH0uQSbSwOARZ5JorAfip5m+q0t8h78Ds+0CK2LNRVhw3RAbQddzljATlgt6QQHQvHX3Tqmn
 yF4E5mJzdfjAS6osutRSEscBmIgeQD/CoC3dl00008l0JleYB6SISY/H9oLCb41++rnLxKhaCO0 fFatdtsITdUY9BzT5RIIa5Afu5Mvo0zItL9Rx8Z3ox7UOgfUQ7+m+7hgVQrKdVXK62cXlxbwUyp VbDRDBb1eumknCDW952GjTZTc04x/jTG0sskmtGPEDEHePRrHgPyxv3T94Qf5bijM7oU6gbVtCl WBZOmpJT
X-Authority-Analysis: v=2.4 cv=H6Tbw/Yi c=1 sm=1 tr=0 ts=68d25407 cx=c_pps a=nL4jJU91y3sJb0QYIFFgig==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=vbrMur1YKWe9jnbvzAwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LokiJYkjkAyMYYybHRYZE6mub4J-J5v2
X-Proofpoint-GUID: LokiJYkjkAyMYYybHRYZE6mub4J-J5v2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509210005



On 9/22/25 19:05, Rob Herring wrote:
> On Wed, Sep 17, 2025 at 05:36:36PM +0200, Gatien Chevallier wrote:
>> Add the  "st,phy-wol" to indicate the MAC to use the wakeup capability
>> of the PHY instead of the MAC.
> 
> Why is this ST specific? PHYs being wakeup capable or not is independent
> of ST. If you want to or can use wakeup from the PHY, shouldn't that be
> a property in the PHY?
> 
> Seems to me you would want to define what all components are wakeup
> capable and then let the kernel decide which component to use. I'd think
> the kernel would prefer the PHY as that's closest to the wire and
> probably lowest power.
> 
> That's my 2 cents spending all of 5 minutes thinking about it. I'll
> defer to Russell and Andrew...
> 
> Rob

Hi Rob,

I think we're all aligned on this now. The thing about this property
being added is really related to how the STMMAC driver was interacting
with the PHY drivers and how the PHY drivers communicate their WoL
capability. It has been done previously for the "mediatek,mac-wol"
property.

The complicated thing to handle is: Is the PHY capable of doing WoL
AND is the wiring actually present on the platform on the correct
pin.

I'll send a V3 taking into account the different discussions we had
with Andrew and Russell.

Best regards,
Gatien

