Return-Path: <netdev+bounces-229897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA9BE1F36
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F9BE4E06D6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADA2E764D;
	Thu, 16 Oct 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lAVV6MhW"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645D27732
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600330; cv=fail; b=suhbXQVt65Wtozw8svjj0uR5rLFP4/9HbOg25m4rKy3RrY3sr3TI7FUZu8Bo/HjeYmSE0az9/S/0sfLeB/PgQqtmC5gkZftz9Fp4vqlT/K0LMVU+ELPLaZHiOQuUfdjLvYWemMOzMbtnvu2+mv4mlAty5c1/Wgl7r+rDew1cG78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600330; c=relaxed/simple;
	bh=KqAAsvlKmF3hCvc28RutRhoElIzWN4C6SQfe1mCZMxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=olFPIpvFiDYOtvqjYFsaHQ/jjDr8aTVb8gLohyvCN2ce2e8b08DHUYQf31kB7aq5fqnSlgx1IYkzIHA6WFLWG+5xdsTLUGtI64iAXaJWS+hQ2UKAAsFkfgG4Jc8txtWpIoFTSYUVEpzHgQjgWxH0FXsH5c47te1xp6SxPJ2WqzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lAVV6MhW; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7TS5c020050;
	Thu, 16 Oct 2025 09:38:11 +0200
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49r0t0ck8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 09:38:11 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nf8B0Bq+lKsGawNqI8INMQjCOP+o30qzvBnYZ3WfUmfRbuPX5cQkimwJgkzRi5MwvJ7JOONNCivlRJ0dYCsRQfbypJQNgfyBf7QA0daAWKmAPD+4G4J3jzzOc78AWgJnJzKu0qOCQjZVdfwIxnwFpPGO0p1rBiWs6Oc90UoAwBg0b+XkD1Q5YCFRhoLwOMQk3FQxmiYJw7m1p7Og02GruvZxlMpDi9uRjN63sRNU6N2cUKu71Q8+hQtPl3ju8/j5I1OsQ4L3bWRp2NXGQttcPZSVg0pvHPZwqX8FKvrT1OwL0ywykULhuTZzh1sBMsP6guwshZJiqy9uvFVcoLXOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMMyy+XoaQrQlDTbqBloCyFwYroj1rlajwoI3RhQJBo=;
 b=SX+hkF/zTQoHRSeCrHKCpEFp+hQTO57z/QxC7R8A5Lfq1ZUVZIel1kF4My3GASGi/e6Z5+1TlHkLlfzze7+TbajsivmyGartOPUwKedU8d7YdzyUg5iynyLfMGyggINPxNBubZ5DLYCpTbZM0toKlfHt9fhCkA2tcY6O4q3JDJtbVt0n9S4VxAy6rNDquM/3EKRJRoC0RhCShQSxGnXC7ckSXMhYBIBYTmy6kITIZ+rjWyHAuGJmH0xEYzjG5jL1v5wEASLiBrIYU02ynpkmqgKFiew9hZyh74KgZCOCcwUqGKf0C9LQwVl4OGoFsKum1OomWFzVo/2nC6Vp9PT6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.40) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMMyy+XoaQrQlDTbqBloCyFwYroj1rlajwoI3RhQJBo=;
 b=lAVV6MhWQ8IG3G1swZXwFWez3ezd+W5VjZ9xRxZBU7KofzZ25yV3FMpZr7zA1gIKvVTHS3vFSmIiJ1lirwTYFglebLWxB/yLygsfBU97J9Ctxz9srr2lQKBs4Fcl7U05xPzfDJ0AtnONQEdRWUDd9bXYsm0BTzgIrwGGeMqUTBiY6Lj9ST6S86AyaCIQKQ1jgu466uO78GT7W1k3+QTo+F7BJqZrd63Kf6Os1U+MBXFxZV6V7vyupus9cTZlJZSVNxYB47o/9KZPaCxfsL5x/pZmVPWU2Mf4I/l3tot290XeuEifzv2q+Ctw6UPCQPVRKbzFWm+cgKC/RZYoAgwkIw==
Received: from AS4P189CA0050.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::28)
 by DUZPR10MB8227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 07:38:09 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:659:cafe::27) by AS4P189CA0050.outlook.office365.com
 (2603:10a6:20b:659::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 07:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.40)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.40 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.40; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.40) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 07:38:08 +0000
Received: from EQNDAG1NODE4.st.com (10.75.129.133) by smtpO365.st.com
 (10.250.44.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:38:13 +0200
Received: from [10.48.87.185] (10.48.87.185) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 16 Oct
 2025 09:37:44 +0200
Message-ID: <62ca6a0b-7c68-4345-8887-ca3ed6d2663c@foss.st.com>
Date: Thu, 16 Oct 2025 09:37:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH net-next 5/5] net: stmmac: rename
 stmmac_phy_setup() to include phylink
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945d-0000000Ameh-3Bs7@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <E1v945d-0000000Ameh-3Bs7@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|DUZPR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: cca9583e-aec7-4ce2-72f3-08de0c86f36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHhLL0Q2bUZBS3dNYWcyN0tUclFucWx0SThuVWNYcE1mMWo5TUJDYUw3WnlF?=
 =?utf-8?B?VnpxeS90ZEZEWml4cUJVbnhRSVpyWnBuOWs5c1hFeTN3dlJMOU9yS0lLdnRi?=
 =?utf-8?B?YzZ5UGZzeUtvbk1ubmtJUG00dE9TUlRQK0xwa21QNGlvcTV5TXVBZDFEVk1a?=
 =?utf-8?B?L2pObWFmYWJTQmlWTHA1WWNTZHZDczhKSncrSDJTQ3JvNWFXa0toMElkcm5F?=
 =?utf-8?B?ZHF6ZjBpMnJ4dlhReUFFRmJzY0VkbHEwa1czbFR6azBKUmxmaTJ6NzA4Y0ND?=
 =?utf-8?B?Skt3YW85Z3JyNjg1amRueTdzaE9YR2dpQWJSdThPUkRSeWJQQVE4THZQenI4?=
 =?utf-8?B?Rm9BZG50dmNEUGlKVEIycW4rdTVjVlQvZk1tN1BrMDBaUkw1OHdzTkc5djBM?=
 =?utf-8?B?UGRLb1lXaFdQb1NwT0JDaWR0RjcyRmVUcEIxYUFUYXRwUUNRQy91bFBBWS9t?=
 =?utf-8?B?S2I0T0dNOXBXV3pOL3hUcWYzQnF2Z2hYYkRTb3pROFU0VDBPd3V0OVJUcmU4?=
 =?utf-8?B?NG9NTHo2YUl5VHJJSUFPNURkaHZ6TFRDKzZXSGg3S3l3c0RCSU5yVlc3TG84?=
 =?utf-8?B?NFJEMUpFWVd1TXpSczVzNlZPc2Y1L1lCVWtTU1plWU9reU42NitEaStzOUc0?=
 =?utf-8?B?OUtBTXkrN1VGbnpzQjNDU3dVcXJOdi94djhCTVpFK0diVEVEbkhsek9ic3FG?=
 =?utf-8?B?ZnFsbHNIRURjUHU5VjY0ek4vWTljL2t6RnVUNGJUWlh3YjlycjhDdHh5YUQ2?=
 =?utf-8?B?bXV6WlJYak90SCtPUm1SQk9sdkxsM04wSGRYRXVINEdyNER1UWJkV1F0T0ls?=
 =?utf-8?B?eEU2YVRyblNIaHJWUlp4NlZqSVlMS2JCajlWTGJrUFV6UytRSGJIUFZKbDRX?=
 =?utf-8?B?di9US21ZVUhjaVpkNjJBZXZ5WGVjUnRlWTRCSmJQdTdnanRhRmJtbVVMMWFH?=
 =?utf-8?B?clhPdmFVT0l3S2lnNmdzRW5PNFBtRS9wTXEyU3VzUzNzYTlPTWZ2NWNSajBi?=
 =?utf-8?B?Zm5JSDJFeDdobEg0L1Z5RWRvS1lxbUlFRi9idStxTzJnT25TTVJydWQ5bHRZ?=
 =?utf-8?B?cFpZRThsczdHS1ZiZVF1eVBoWlVMVWtZOFVRSFZTaml5RXZmRHRyTUVEWklU?=
 =?utf-8?B?WmxFTGtqVHU3eUxoc1Z4NGQ3REVhY1ZYYTFPQmREL0ttd0E0NXREdTYzYjZs?=
 =?utf-8?B?MFJ3UzNBRlU5aklVSzFMYk1vdENiRmZnZlJ0bzVobnlFYitJNFhQNWd1SnJO?=
 =?utf-8?B?RWxtRUFrL05NWWUvQkQ4QVYzc2VVNG1PZVZndjhyQ1ptRy9kMEVTRi80Z21J?=
 =?utf-8?B?U0pKL0Y2VVZZRzV2SHdQMkIrK0hDU0dQV1hUVUNUdHVmWUVjN0tic3MvcUpl?=
 =?utf-8?B?aHU4ejFDRFJqS3ZHQjVzZEZERnlXby9HcnVIMjVRaEZ4K3YwRFhLZ09VMk5j?=
 =?utf-8?B?OSs3QW1JdEZITW5FZmVLRUN5bjZJM29oZEowRkFiajdrT2E4SjdqMm94Y3VX?=
 =?utf-8?B?OExxTU4zY3lLL1VLclNVcXRUdVk1L1FscC9lUkJ3cnphclFQd3NpejgvTmw4?=
 =?utf-8?B?RmNqQWF3aEJkUGg0QW1DRlk4QlRQdkF3T3IzL1Q5RDlKQlM3N2FhWHo2RE8r?=
 =?utf-8?B?T3IrbWRZTGJaaitSc296czN5c29yd2loR0dhWitTUHhCZjBBbGMyN2gwYUdW?=
 =?utf-8?B?ZGNwWDBLSzVxdHJKSjR0NFlxbVhLVFFoaWVBbnhUZWx0VE00RnVYOUJVUEdy?=
 =?utf-8?B?d2FpMEh3R2hHUDlzRjRhSnZ3cmxQRzg1SlJaaXBPWnlVZjA5SDViU1R0OVJj?=
 =?utf-8?B?VlFFUDBTSytjV0VlYjNQay9NaEdUNTBEdnpJenNaNUhjNkVjRVNEd0NwQ015?=
 =?utf-8?B?cTVJRkw0U2ZHZUxzdWpvMXZMMEVQSFIvTm1KSnJyRUZkVDg0eFZnYkpYSWgz?=
 =?utf-8?B?YmI4dUwxd0diOHUzQU5janBCTHJ1N0FwbnFyYXBacklObUlwc3BoZXRMWjdM?=
 =?utf-8?B?L1Y4TmpKZGJGM1RKd0VBR3EwT3J1eDRLeVRSRGF6a0JtRWJaRFd3Rjg3cHoy?=
 =?utf-8?B?MCtvTjZrSEw4UUhDRHhYQm9LSTVlWGlNWXVEOU1tbVJwMXBPeWF2bVQ5UVNR?=
 =?utf-8?Q?eZmg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.40;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 07:38:08.1063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca9583e-aec7-4ce2-72f3-08de0c86f36b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.40];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8227
X-Proofpoint-GUID: 9w-VX4do0kX2PKJazWZNa2ngB7ecog28
X-Proofpoint-ORIG-GUID: 9w-VX4do0kX2PKJazWZNa2ngB7ecog28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDEzMyBTYWx0ZWRfX/6ozllRguuLn
 9oBopHOntk1lQOfbeQpvZZFeU0kidya902zehI35Wubiq0He01jYMxvIzD4Ji8lyN8SJAjyHi/i
 ADhs6IfJa/+b463XnMI6WbmHIfPNGeLNJJeAfF8f40nk4sz5iaZQUjU3LJ1wjVmApsCpaxsKf8e
 XlYmaAgD4EnLc4tPv3uvjxX5J3jsNOHhRCEwsI6bcCJifxuz6oyeFA1wKmCUb9OPSR483p2oTWE
 fiyAJwlJxo/Xdm2aZK8vXa8UhJ5djRqn9d1z5C15W9a3uuc5vR7pjyp2u2CaiTeAlpxZBzb/H+e
 e7g1pZ5wtlCuPwaZoK9lNTioXUO2tvmIDyH8I+hM3lxzUqA83ViEqblVWua1Cf2DIF7cDbRMklX
 nSOQR9BNrT+44B03oix3eIymzMA1ug==
X-Authority-Analysis: v=2.4 cv=dY6NHHXe c=1 sm=1 tr=0 ts=68f0a0e3 cx=c_pps
 a=USthxGBMnoyjuKxaiL7kkA==:117 a=HHWmdgNZ66UcX3Fjl3KRHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=8b9GpE9nAAAA:8
 a=Q4v7M_saCEqmHJ7S9YQA:9 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110133



On 10/15/25 18:11, Russell King (Oracle) wrote:
> stmmac_phy_setup() does not set up any PHY, but does setup phylink.
> Rename this function to stmmac_phylink_setup() to reflect more what
> it is doing.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 500cfd19e6b5..c9fa965c8566 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1185,7 +1185,7 @@ static int stmmac_init_phy(struct net_device *dev)
>   	return 0;
>   }
>   
> -static int stmmac_phy_setup(struct stmmac_priv *priv)
> +static int stmmac_phylink_setup(struct stmmac_priv *priv)
>   {
>   	struct stmmac_mdio_bus_data *mdio_bus_data;
>   	struct phylink_config *config;
> @@ -7642,7 +7642,7 @@ int stmmac_dvr_probe(struct device *device,
>   	if (ret)
>   		goto error_pcs_setup;
>   
> -	ret = stmmac_phy_setup(priv);
> +	ret = stmmac_phylink_setup(priv);
>   	if (ret) {
>   		netdev_err(ndev, "failed to setup phy (%d)\n", ret);
>   		goto error_phy_setup;


