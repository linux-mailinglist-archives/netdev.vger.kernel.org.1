Return-Path: <netdev+bounces-219907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A948EB43AAD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6590F3B5441
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888D2DEA96;
	Thu,  4 Sep 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ArlC6+th";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="XmTdXMPn"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A87199FAB;
	Thu,  4 Sep 2025 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986547; cv=fail; b=b/Xng9CFsnsRcaV2SM4pcyd9vEwwwEZDbEPrQoYlvAlIMt0ahQhKBaQk0K5yJsZpi5bKB4bSUoZ0Lz0P7aHrVvuhrmaVg13TD2iI4zxjgmZ+Mu9E1hRvhGc5ncsaC7lAs4mqYZi9kjEpffLFU/hL+MhcgY8VcoEscAkzBZpBoOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986547; c=relaxed/simple;
	bh=vvjgKEz3gFHKWmyJfiiW62YgjMSIU8klK1jwOt6A9cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dlAvg2BwHaQFsC5Ep0NLGJkwXXU2HaQh3auxF7s/m8aVzNv/S3TLVK7Mc1vCmf92bZYpnHc927cK3gYSfKtJoP9DgqgyHYBfHAQZsZOH+ON1Pe0ajEzRVjSKGOtrX+uYcefxas+PVcMLsD+u+867NNV3vwcpBft5LyzQ2KljSRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ArlC6+th; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=XmTdXMPn; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584AIvNV024377;
	Thu, 4 Sep 2025 13:48:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	emGjkwW8uuRte2LHCeSdeXbyBXj819goaK5mrm9FJ14=; b=ArlC6+th5h8M7f9Y
	AVREEVZb2OQzWkzF/9z1ZVsxF/c/DLH4W1IqDQd14OMMKixh+PPmPWodd7b32QGi
	wXqDIwNZxh6RrwJz9j4E0kmoSBRdtW3Oau01suYo0s6w/Y7X2yGR2PtPxllngu6O
	30DibS2B1Q1G39PU6KkS+y74a0oCLFiUyGyNzvGPAgXvSCnlPuTYXpAogpmx3TUF
	eaVabl+edKZxIzH4npL3qegkZ3z6QO1QNKQXgwNKpxdqnSAvxX0eIQsJb5+8O4oq
	SlapfGor4LEP8sos23L8+7UjerDTBVfaFWAMpCs5SekEKXtZ9hDSNEYF3E1Gf8S3
	p4rU9A==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2ueqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 13:48:30 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3Dh+7OJ00TDvj/QpmCnpj+iI7qBnp2z9RZbbxAMtSG2600xt5dKiWTHy4YPn+7j3b08ygbG+j41wSo0NYpOy0ygnLx0ymGvUdWaBml+xZQVifDHg/fS9vezHN7oJOP/ZWYw+Xvonmu2DV/x85edpoRDYlr+iXqyZp9QkQGxC7kJ5k9+0PMVFVkdisaemppjsb384xO7bknCprMPy2YG1Dif6PRQwiZAc8ToDLOPW5XHpLqyKAm9DI87c1F9MzNPorogtfGigyUgWvrmJukSkONnRlbt4C2HVMgg2l1RH45YcCEZmZn6mIjJe2jYeosI/r4SZvzqeQcYkO6MJhyFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emGjkwW8uuRte2LHCeSdeXbyBXj819goaK5mrm9FJ14=;
 b=bzU/FSWaKYbBjQ9tbGVvSekTH4yNW5QfMZI7tjj8iH4Ndmc52H9c2XZUXZcNQY1UI8RAd9fyYVWcL5SVPL6sAZRgeht6HxRrAQLtI1tEOWbm8S5OFdos5ez0Z2ge1RwujVUVFbJlGqjfXrdb4U5mzSsw02eRz5JPWZt3l0vMppC4BcsJqAM+rHEvGky75iJ5ZFyoL4cNmEV5EDibYnDJN2x4UaSM1axcboTjoTTB1rw7kjZch4dtmQFSXA+qZbjG42w+95qNLAfA9DwqZIlpfhphEEGT4Gj/FxcNmElwVfrMyTAz7ARcIGVm8CUC2oRoS+0XwvOeGDms9ws36IIUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emGjkwW8uuRte2LHCeSdeXbyBXj819goaK5mrm9FJ14=;
 b=XmTdXMPn3oe3Zha0hB/I4Fwj0duG+Ekmg0Eev/cgB/tswz1Zl+5Ls73KxgLrTfYsRS38tOUJ8oDJCf950rIBWx9MkjVNwBSvGN9VLHaYCvXSSnyTOGWX/JpklDQU7ZvPZaI6ZKqkRCtv+u/rdCzzG72Z+REb6xnqgNKuwbFHdtA=
Received: from DU2PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:10:232::35)
 by DU4PR10MB8880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 11:48:27 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::29) by DU2PR04CA0090.outlook.office365.com
 (2603:10a6:10:232::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 11:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Thu, 4 Sep 2025 11:48:26 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 13:41:12 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 13:48:25 +0200
Message-ID: <43cc641e-4c77-49a0-a18a-9707600de344@foss.st.com>
Date: Thu, 4 Sep 2025 13:48:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/3] net: stmmac: allow generation of flexible
 PPS relative to MAC time
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "John Stultz" <jstultz@google.com>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|DU4PR10MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b4d7ba-25e8-4f80-a511-08ddeba8f5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHMyY0ZtWXlBRjRkSDZkREtTM3l1am80YXlrS1J5KzRnbUZZcnc2YWdZalI5?=
 =?utf-8?B?NVErU1BKaHJVYmlGUS9hd0NyaGxjS053TkhaWXg5NjhtNkMwbkZpaGVlSDQz?=
 =?utf-8?B?bHBScjZDbzl5cVNkVk9uSk8xT0pmdEVNRlFTMmo5ektxa2hTdkxqUW1DeVpz?=
 =?utf-8?B?VmJWZGhLM3duNkRXTW9oY1MwSnNndE1iQTE1ZllIMFQwUmVSMXJlUWZKNHdq?=
 =?utf-8?B?WSt1MitDZlF4RWg5dGJvVzFmeHJjQ0RUb0JubnNSaXdxblFCTFlocS9JVnlI?=
 =?utf-8?B?KzZuS0ZSQVk2eWNETlBNMExTeTJSYXNOditldkFKbnlqMGErcG5KNjN6cEQ3?=
 =?utf-8?B?cytRQ1hPcTVBc3RlU2xNZ3p2cW5sQzRHeFNLYjgxcXFvSEVGbFQyZHhwMkpa?=
 =?utf-8?B?MVVqOFV1aTRGb0ZzUzEyRW02SWtaZXpJYUFlRGo2eWF3TFY5MllBUGpzSE5x?=
 =?utf-8?B?NGx3VGRidTJhK2lEendjQkdZU3dXT25CbDR6ejFJRWt1OFAzamdGalFCUEln?=
 =?utf-8?B?NnB4TmJ5SndXT050c0QxL0t6dnlHZDFvbVIvK05ZbTFEVGthSUJVMnhQeStP?=
 =?utf-8?B?eXFOeWQ1eGZ1QzNrQVZXWUpjSG9GVlRZc1FmbFBKbFFwbm15RGt6a2trRTBZ?=
 =?utf-8?B?aHVqZFFKSGx0WlhzelRtb05BakhwMGZEY2JoK0swOHk0VVpReWZoRDlEV25x?=
 =?utf-8?B?aEJGZm1IYWRHN1A1M1hvM3BRSm9oK0gzZzBPbEx5MDdRWVE1bFQ2RUpLK0gx?=
 =?utf-8?B?YXl4WHdXa0RMemFaanA2K2JNM3F1MHZZODlFeEZKTFJmM3F2NjVBU2RiV2wv?=
 =?utf-8?B?T2Q3VVhpcmFqVmI3NWdGVENYL0hId2RXR24xODJhekliWjJIa0JwL0FRcmlG?=
 =?utf-8?B?QjZ3d1ZiRTNRZnJwclVsazlvcFRLblNTWUVFY293alphNUJpWHJyR21hQ21u?=
 =?utf-8?B?SEVhKy9UUXV2TWIxOGFRd2R2bGQ4QkpCdGw1N1dWS09GVjEzRVY5R29wcjZB?=
 =?utf-8?B?ajdXcTlGdTBEMXVqeEpzdnVtWFo1djVVY1NjekMvbzN1Nk5XWDJxQ2dudmU5?=
 =?utf-8?B?NCtBa3A4c29wVE85Y0hLOFg1MUhPYWF1M3JSc0htZjhvbVk4a1pFcU1mYW40?=
 =?utf-8?B?VVBZWjF0czMwc1J0WjFmaVo2Yk96Vmo0MFFzS05uNjA1dkpSekxFZ2poUHZw?=
 =?utf-8?B?RFJ0cjZOcWg1UzU0eDZhUjlCTkJHdEM5VDJkVmI0T0xhVjZZbnVxelJFcHY2?=
 =?utf-8?B?MElCTWZnQld4YkJBWEl4azVhMC9UMHpGSzl4bHlrMjFyemlEa2gvaUJZMkUy?=
 =?utf-8?B?dTZOMnozenErVnYzRisrdU53MTJzTm5Vbi93N0RsVG1RSWVsUVhCZXlTWXFY?=
 =?utf-8?B?dXMyWlk0UVU2Nm0vRUJzYTk1N1VqTVpFY0pVMHNkMWRyOXBTeVdlVzE1cGRC?=
 =?utf-8?B?K1cwaCtIK3RkU2Y4eEdMb3ZrdUEvRyt3SEptamZaS3VyNnE3OXkzOUsxY0JR?=
 =?utf-8?B?S0FwT3ZwRXlGWUkyaGdjRWJXdUI2R1lJNTcxand3NE1CMUM5TVROQjNHbm5P?=
 =?utf-8?B?dWxFNEZSYm0xWXFQQnJBQnFzRk55aGFNY2M4dHU0Q29MWm9iOFFDdEc3dE4y?=
 =?utf-8?B?QVRnY2VjWGJXL2ZKNjduc1dSRVFxVVlqVU5IL0gxQ1BTYWs5KzNLNGtJSGQ3?=
 =?utf-8?B?cHVlejBMWGlJUjVIRytKaWw1TytBRzM2dWpaL091ZE9XV0hZVSs2bG0zdDht?=
 =?utf-8?B?VlRyMW5Pb0ZoSVNKQmJ2VytzUTBUR0hCcElVUjBSL2gydmNOemxmYWZmdFJZ?=
 =?utf-8?B?WXpKZnk1TDBsdTd5RzYyR2M5OVNrZGVNcUltSE84WG9Yd0U5UXFPbkNjb3hj?=
 =?utf-8?B?ZmlmRkR2YmNJRC90dS9nNnErRnFYb25oZVRsbW4vUXZ1TDMyUHNPNXdnQmIy?=
 =?utf-8?B?bTV4ZVhPZW9kWUpYblRlaHl2bC9SNlE0WlM1RDc3WFk1WVVjbXhCYi9Qd2E4?=
 =?utf-8?Q?pi32IuB7tbHF/q5DkjA9iGYFTgYbaE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:48:26.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b4d7ba-25e8-4f80-a511-08ddeba8f5f0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8880
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDI1MCBTYWx0ZWRfX4CJW87M3XX/8 4Tz3pZG+tJkBtVeRFi+RT1VatIoLUz3VBDd94U/geJ8nVTouXcMIubm8iAWRQpaWz2GLg+NPBNC NbOWFwJnTM4ENBDhhPvMkd0ubkPZoIk8OcRQNy+wewQcxkwq0/yvWxyshZY7IxMYVT4qJz6oXm3
 C8sltjyWvimy7Uhk4+nW90A2SDbNyrTsDB02r/onWiXtpVHynBU5lgWcYTWE0G2/tx7vRp58sVT 890bYagsv/nv/LmX09icC58ntLVNsTN3z8/mNOfdkwJjfyC1JVAhoBYjLTSDEIm++7MZAMyuySz mbDdOTmDJZI2HPhZhkgD0pCHJ97XKZ+ASarXAoS7HFDMBigTTcxsmQUjO369MGpNAGznVAYM4vF qcc6bv3d
X-Proofpoint-GUID: L7K5ZcXLi0zKvybupprnlVvqhUgaDpac
X-Proofpoint-ORIG-GUID: L7K5ZcXLi0zKvybupprnlVvqhUgaDpac
X-Authority-Analysis: v=2.4 cv=bchrUPPB c=1 sm=1 tr=0 ts=68b97c8e cx=c_pps a=l6Btcvq5nnSnB4iwbML6oA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=j2rUa52JnNMlxABqLIwA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300250

Hi Gatien

On 9/1/25 11:16, Gatien Chevallier wrote:
> When doing some testing on stm32mp2x platforms(MACv5), I noticed that
> the command previously used with a MACv4 for genering a PPS signal:
> echo "0 0 0 1 1" > /sys/class/ptp/ptp0/period
> did not work.
> 
> This is because the arguments passed through this command must contain
> the start time at which the PPS should be generated, relative to the
> MAC system time. For some reason, a time set in the past seems to work
> with a MACv4.
> 
> Because passing such an argument is tedious, consider that any time
> set in the past is an offset regarding the MAC system time. This way,
> this does not impact existing scripts and the past time use case is
> handled. Edit: But maybe that's not important and we can just change
> the default behavior to this.
> 
> Example to generate a flexible PPS signal that has a 1s period 3s
> relative to when the command was entered:
> 
> echo "0 3 0 1 1" > /sys/class/ptp/ptp0/period
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> Changes in v4:
> - Export timespec64_add_safe() symbol.
> - Link to v3: https://lore.kernel.org/r/20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com
> 
> Changes in v3:
> - Fix warning on braces for the switch case.
> - Link to v2: https://lore.kernel.org/r/20250729-relative_flex_pps-v2-0-3e5f03525c45@foss.st.com
> 
> Changes in v2:
> - Drop STMMAC_RELATIVE_FLEX_PPS config switch
> - Add PTP reference clock in stm32mp13x SoCs
> - Link to v1: https://lore.kernel.org/r/20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com
> 
> ---
> Gatien Chevallier (3):
>        time: export timespec64_add_safe() symbol
>        drivers: net: stmmac: handle start time set in the past for flexible PPS
>        ARM: dts: stm32: add missing PTP reference clocks on stm32mp13x SoCs
> 
>   arch/arm/boot/dts/st/stm32mp131.dtsi             |  2 ++
>   arch/arm/boot/dts/st/stm32mp133.dtsi             |  2 ++
>   drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 34 +++++++++++++++++++++++-
>   kernel/time/time.c                               |  1 +
>   4 files changed, 38 insertions(+), 1 deletion(-)
> ---
> base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
> change-id: 20250723-relative_flex_pps-faa2fbcaf835
> 
> Best regards,

DT patch applied on stm32-next.

Thanks!
Alex

