Return-Path: <netdev+bounces-224429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBFCB84A7B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3908B16AE93
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453D30217E;
	Thu, 18 Sep 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WaKeFONQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3718BBAE;
	Thu, 18 Sep 2025 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199638; cv=fail; b=sdobBvCfZp13kZH4JlLptARRw+a2kd0bgoqy6n/j8hanAxkKtBc2EKJo69XYPW+5OfweYOEtaqCrTe7HwSR12I6EiJ3kz3SGlyD2s3HLJBs5iE2YFnD2WeGjZH0UTAqd56lu2W4ugarDrnXryUsi1tjnUzciY1TcH2vg11xyj14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199638; c=relaxed/simple;
	bh=Vm0tCKHBQEil293Vp8/JEsCJqjrZQaS1OS1LQDdwyX8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=KuANDOZeJsRj5R8EG7o5eilI4cljHxKRDIZmWCjmZAbpA4g4ZpuLnNtpsSk8X71WbdAvzOlxEokkPO67rVbphNIj2KzmMoDaoeHHH+m05lQifbsOPt2UBPxOBXjSc/cHTRrFLAO4ZsfDr1UPNWFCxpaADHMN2qS5JFu+4Vcp85c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WaKeFONQ; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICYDK7014495;
	Thu, 18 Sep 2025 14:46:47 +0200
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxb0r35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 14:46:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H06+q9Lh6N9lzF0egAi0Y3rr8k59bF/Foz4uq1WH8raQy6/2j1Z+Y/pfEGOv9YZ+IoD7AgnaawaU3kNh3gRNPs0UEqm8cJcoFZ873srcWNlXF1xf229pU5nEfw0t4H4l3CUipAy0S8JT43dFXy26lhg5dFQhf3FDl1V8/EZgDdTXj8JfnFp2f2g63kL0Svywid6jwGxy/gQ1S7iplzSYa76TK3Q0TuwjIg2w0m/3LmPFZYgBPEe5V/wp/5GAnqCeTmotcu+gagTZV1bTbIO7HB3DdLUOIB76N/ltu4XG1472JSO1k6MiiMaO5b0r/nS1H/ra2D3EHPVZB+xdM2c+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4eGYGTD6uDDss6GS4vkQgleprCRjJV87KWZEjuUoDo=;
 b=h5y6Z3TuOnoyXk5b3Zw8wEjjW/WpFNveVXwr0TGLQUWl9/q271vzwq6u0Bl68bLpUMj17v0gt5T+5RDKIBZZ0tATr81Zm467rF6jI72xi/Ww0g+dS9QC8FVQHDhDZacEgvfP7B0zz5zyfGHZ/XOZhcJQZj0m+1ITBFsCPjDLK0+jAv/QQwn3xZXcVUmh2H9Rn/zu++iChlHKWwJOvOSr7Yeeuao7UL3/5LDtYFs/UFiUXYq0YeRP8Sl5TMFPiKQewBc04GqDFD/M7Lqt4peHSNyZ4HNtPUHPxlM0298supzdcjYGtREsU3ofkho469hPcKFsM1gIcl+v4bje3bN/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4eGYGTD6uDDss6GS4vkQgleprCRjJV87KWZEjuUoDo=;
 b=WaKeFONQdqG0+8J+LNKfxrFpdzYDIfFs8EycbscH1p9RvGEom+1Q/GMsNpqmOJSdy+Iz1Z5PZbY47yxJInKt6kv8w8RzK71F7es48cJis7CefFEVwjhPjLn8TEDWrV9v6sPbHzBjwxckypuo2gP3ab03WMY2IOv/nuSYRC8pkLGCOfVD3OQitZTLhjOiU9sME9WKZFjIKmS56tko0Rz+AKyarSQCU+eqW8/t3Dlry43MpEbqnLdxSMl6bL2RYx0bKmWlOBH8Pvg9EJdoKHEZeCz7xPbcYXMBhwUSNumhQmZlzC9DZq3I3DKVtIbcxOODBuYcabzJz7ZNLptG38y95w==
Received: from DU2PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:10:3b::12)
 by VI0PR10MB9128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 12:46:41 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::a5) by DU2PR04CA0007.outlook.office365.com
 (2603:10a6:10:3b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 12:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 12:46:40 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 14:44:15 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 14:46:38 +0200
Message-ID: <72ad4e2d-42fa-41c2-960d-c0e7ea80c6ff@foss.st.com>
Date: Thu, 18 Sep 2025 14:46:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
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
Content-Language: en-US
In-Reply-To: <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|VI0PR10MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: cad66d6f-c54e-459f-652b-08ddf6b16a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9XeWI5eE9tMjMxTTFpcUF0dWxXUDBLeDFTYUtVMUdRblRDZEZLMjFOS0Zi?=
 =?utf-8?B?RUg4N1RPSWFnZHZHaTdneVVlWXV6NzFROStGZ3pXZTdiMUZJbDg5T3Q2dzNv?=
 =?utf-8?B?VEY2NWdTTmY0T2ZlaDNKa2RjMjBSYy9way9FZkpDYkFNZnFtSGZNNEpmRjdJ?=
 =?utf-8?B?UFJCVm90bUczK096VHZuTXdsVllIV3V1WFU4ZU5SUFV0YitCMWVPTjUrY1dF?=
 =?utf-8?B?NkE5TkQ1dERoaGx2emlXS2NLQnRQOExQUWNDVHN5N0xKWHNqL0lrYmhlNUlI?=
 =?utf-8?B?QkNjNHQrT1luUGxhbnlRU1Y3Q3JYVndxS1hBOVdiN2lxU25OTjh2c3dURlRF?=
 =?utf-8?B?akRTbmZ4aWZ0VnJNQnA4d3crSDhka2s5Yjd5dlRUTXRlSTNyc2xidmpzM0Uy?=
 =?utf-8?B?WGVtbER5L1RhMnlHNGY2UDNmUUluaXl4cHR4UUFIN3N2bkt6ZFBoTGRrYWow?=
 =?utf-8?B?VHcwSitoa3FRYlVJZ2NVb1lUL1VDZ1hMVmNFTExQTmd0a2VxQXRCQ2tEeEtL?=
 =?utf-8?B?cGVHdTNvRmF4NkRodmZKeDJ0Qm9yLzdmRnZUVHZCTm9MRTF3UzFTd25MYitE?=
 =?utf-8?B?MmdEeklwVFREWEdpNnNFcDJCWFRvVlEyaWtwTVBkLzJFbEpkWDJha0RoUnph?=
 =?utf-8?B?OXZWUzMxa2lUUkI3ZFRQekF1Wkw1aGZ6SGN5SDc1c2dwd0lCR1YrL1VVSGx5?=
 =?utf-8?B?NDRpeForS3c3S01SWldZQ1ZQbWFodUlLYng3S0FzVkN6WWdacVFReDl1aDls?=
 =?utf-8?B?bGdkc25IVXhrMk9RK2g0OHc3RXR3bUY2YWtFa2JTQVRrdXhkcW9xQldRblVY?=
 =?utf-8?B?eGcrN24vZEhXc0xtVlJsNTB6K2ovNlZ2THY4NTdFclM0cWVOd2h4ZWJjQ3dm?=
 =?utf-8?B?cXFKMGl5MFI4cVRzTVpwNEhLTlVoZ3ZpWjVhd1drUHZObS9Zd3hSNjRNdjJz?=
 =?utf-8?B?ai9ZekRteDZ3NXBOREUxSjhRenk3bzJXZ283RU0wZ21tWm9FWWFhYmpIbzdN?=
 =?utf-8?B?cVIrN3ZwSldvdUw4SmhnYnI2UVFTNE93SGw2MEZiZGtSR2NDNjhGSW5iUzlP?=
 =?utf-8?B?ZXJDcGdZcGdEWDJkaDZyZnlHWWFXVjN2Vll2b3lIT2ljN2M2WTBWRVZ5eito?=
 =?utf-8?B?STltcStVakI2b2xxSWNhb2xZZzAxUkxBZ3RjcW1oTS9LajZxSC9ocUhZVnVM?=
 =?utf-8?B?U2puRDVOVUFiOFNXMXVmMmtIdHhMbmV4OUhNeldWTk5uZEVhY2FKbmp3WllQ?=
 =?utf-8?B?bkhSYmoyN3BFOGhtVVpEb1c1VzRwUGZkTlNwb3JwMEhyUG5qek5KQkNKVmMx?=
 =?utf-8?B?YldzZE0yUEVoelBHVXhIcGFKampZYzNRWk9GL0R3YmpVTTFkK0tGczlTSnBz?=
 =?utf-8?B?eVpLNzZwUERGWEJHeDEraDQ3ZGJnSHMxTS9OSzNDT3E5WUM2MCsxN1ZISjlS?=
 =?utf-8?B?aGtobnM4ZDFqZlNtb2pNaWFhVUZOUjJKSm1RQ2FUWVVHMTc4NWltTGtzTWdH?=
 =?utf-8?B?TnAxRjEyaWFhNzFoNTBKdWFMV2VuZTFLUVRCY0NlRjc3dG1ncFlKK1JjSmxY?=
 =?utf-8?B?ek0xMi9iRUdqdkgrZld1MXh5YzJqYytoUHZiSDdwQmdXaUtNWHdmN3piem9i?=
 =?utf-8?B?MS92RllYZ1RmQm1RTVgxZDFJTmVhbTh3Y0tZUUFQL0NkNkZiL1haeUcwTTFh?=
 =?utf-8?B?V05xWkxtUXBtUzE1SzRLRDYxUmN2RlBjOTcrbDVyMDNqM2hKamZVMDZnL3lR?=
 =?utf-8?B?TDhTd0ZVUm5IL2xqQjJHZ1crTXdMUDlyckhSUFJlL0RUUmxMWWt6VTl0TXM1?=
 =?utf-8?B?RHU5SVF1YVpWUmtnSk5BSk5xYWs1OXlwckFCY0lqMTBnTnFaRTBBVWtPa2Y3?=
 =?utf-8?B?cnBtMkEvdEcxR1RkYWZBTU00U3BwblNydkwwM1ZSSlJycXBHT0xyY21sQjV1?=
 =?utf-8?B?MnBwUXdiVzROTlU3NGUvb0R2RFNnOTJ6S29VTDRVREdscU9TWURDL29pcjdD?=
 =?utf-8?B?ZXNhS3h0UFdYWmtHRms0bzFRbGJnMXZwK3NlcXdtNStFa3lORVBIMzNudGxx?=
 =?utf-8?Q?gfTxee?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:46:40.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad66d6f-c54e-459f-652b-08ddf6b16a1d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9128
X-Authority-Analysis: v=2.4 cv=RPOzH5i+ c=1 sm=1 tr=0 ts=68cbff37 cx=c_pps a=g9/3GMKIs+LCGVgKrk4MiA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=0glZYLincierIbUUXmEA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: tyNQECcvvEfLc3QyviA30XUg7lIizoIE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwKAiRRZGddep 2qJKGCYEy622bjXORup6MQ3FOhMx7Rgz5tQna7CxfY1c0ESSHQ+F6Mn/MWa4ToKOniUNYK9+Kt/ ufZFVZ0aMi7IkMwcGCsBKUZSqT/rSLdB5amgyQg+nZ0oQ5yqa2107r0XLbE4Fha9Plw05Sa0Sge
 ZA9jLwOyd7Enj6U2lOKYV85n49RK6twUYCSivPraLudj9Tk62HI/w23z8Lg1531s5D/sbKGHkJe KmuQt26kjQwc/kmIeyaeHgT54yn7yIKyweLuk5KAfICWFoz4uRirteCSNXk8ry3+4xrJV15osH4 PR+9DyLfcOamn/QKfev9BJZBZv2LkusNJc/Fj3ZWNBEhLbxCWSjLOdVpgRPu4wgozESOzxb1K0M CQ9kelSX
X-Proofpoint-GUID: tyNQECcvvEfLc3QyviA30XUg7lIizoIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/25 18:31, Russell King (Oracle) wrote:
> On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
>> If the "st,phy-wol" property is present in the device tree node,
>> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
>> the PHY.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>>   	u32 speed;
>>   	const struct stm32_ops *ops;
>>   	struct device *dev;
>> +	bool phy_wol;
>>   };
>>   
>>   struct stm32_ops {
>> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>>   		}
>>   	}
>>   
>> +	dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
>> +
>>   	return err;
>>   }
>>   
>> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
>>   	plat_dat->bsp_priv = dwmac;
>>   	plat_dat->suspend = stm32_dwmac_suspend;
>>   	plat_dat->resume = stm32_dwmac_resume;
>> +	if (dwmac->phy_wol)
>> +		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
> 
> I would much rather we found a different approach, rather than adding
> custom per-driver DT properties to figure this out.
> 
> Andrew has previously suggested that MAC drivers should ask the PHY
> whether WoL is supported, but this pre-supposes that PHY drivers are
> coded correctly to only report WoL capabilities if they are really
> capable of waking the system. As shown in your smsc PHY driver patch,
> this may not be the case.

So how can we distinguish whether a PHY that implements WoL features
is actually able (wired) to wake up the system? By adding the
"wakeup-source" property to the PHY node?

Therefore, only set the "can wakeup" capability when both the PHY
supports WoL and the property is present in the PHY node?

However, this does not solve the actual static pin function
configuration for pins that can, if correct alternate function is
selected, generate interrupts, in PHY drivers.

It would be nice to be able to apply some kind of pinctrl to configure
the PHY pins over the MDIO bus thanks to some kind of pinctrl hogging.
This suggests modifying relevant PHY drivers and documentation to be
able to handle an optional pinctrl.

Disregarding syntax issues, could be something like:

phy0_eth1: ethernet-phy@0 {
	compatible = "ethernet-phy-id0007.c131";
	reg = <0>;
	reset-gpios = <&mcp23017 9 GPIO_ACTIVE_LOW>;
	wakeup-source;
	pinctrl-0 = <&phy_pin_npme_hog &phy_pin_nint_hog>;

	phy_pin_npme_hog: nPME {
		pins = "LED2/nINT/nPME/nINTSEL";
		function = "nPME";
	};

	phy_pin_nint_hog: nINT {
		pins = "LED1/nINT/nPME/nINTSEL";
		function = "nINT";
	};
};

What do you think of that?

Otherwise, the idea below looks promising to me.

> 
> Given that we have historically had PHY drivers reporting WoL
> capabilities without being able to wake the system, we can't
> implement Andrew's suggestion easily.
> 
> The only approach I can think that would allow us to transition is
> to add:
> 
> static inline bool phy_can_wakeup(struct phy_device *phy_dev)
> {
> 	return device_can_wakeup(&phy_dev->mdio.dev);
> }
> 
> to include/linux/phy.h, and a corresponding wrapper for phylink.
> This can then be used to determine whether to attempt to use PHY-based
> Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
> PMT-based WoL if supported at the MAC.
> 
> So, maybe something like:
> 
> static u32 stmmac_wol_support(struct stmmac_priv *priv)
> {
> 	u32 support = 0;
> 
> 	if (priv->plat->pmt && device_can_wakeup(priv->device)) {
> 		support = WAKE_UCAST;
> 		if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
> 			support |= WAKE_MAGIC;
> 	}
> 
> 	return support;
> }
> 
> static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> {
> 	struct stmmac_priv *priv = netdev_priv(dev);
> 	int err;
> 
> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
> 	if (phylink_can_wakeup(priv->phylink) ||
> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
> 		err = phylink_ethtool_get_wol(priv->phylink, wol);
> 		if (err != 0 && err != -EOPNOTSUPP)
> 			return;
> 	}
> 
> 	wol->supported |= stmmac_wol_support(priv);
> 
> 	/* A read of priv->wolopts is single-copy atomic. Locking
> 	 * doesn't add any benefit.
> 	 */
> 	wol->wolopts |= priv->wolopts;
> }
> 
> static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> {
> 	struct stmmac_priv *priv = netdev_priv(dev);
> 	u32 support, wolopts;
> 	int err;
> 
> 	wolopts = wol->wolopts;
> 
> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
> 	if (phylink_can_wakeup(priv->phylink) ||
> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
> 		struct ethtool_wolinfo w;
> 
> 		err = phylink_ethtool_set_wol(priv->phylink, wol);
> 		if (err != -EOPNOTSUPP)
> 			return err;
> 
> 		/* Remove the WoL modes that the PHY is handling */
> 		if (!phylink_ethtool_get_wol(priv->phylink, &w))
> 			wolopts &= ~w.wolopts;
> 	}
> 
> 	support = stmmac_wol_support(priv);
> 
> 	mutex_lock(&priv->lock);
> 	priv->wolopts = wolopts & support;
> 	device_set_wakeup_enable(priv->device, !!priv->wolopts);
> 	mutex_unlock(&priv->lock);
> 
> 	return 0;
> }
> 
> ... and now I'm wondering whether this complexity is something that
> phylink should handle internally, presenting a mac_set_wol() method
> to configure the MAC-side WoL settings. What makes it difficult to
> just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
> that could be a "force_phy_wol" flag in struct phylink_config as
> a transitionary measure... so long as PHY drivers get fixed.
> 

