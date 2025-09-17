Return-Path: <netdev+bounces-224093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E8B80A13
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152271C266A1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052133AEBF;
	Wed, 17 Sep 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GpVnONjI"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD3332A44;
	Wed, 17 Sep 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123432; cv=fail; b=PYGseKX7vPLQLfaVjv/UOPRCNzzVjacM3Gic5KzPKEWLfjaT69BBYpCO+38p27WjZJG45uL4spOQNyJVp7PL56zSU/NG+NY780e8RXJ7S6oLhWNVFcS6QKB8CXUtiFEL1CbhENzmk65S1sBx412T/G5KNsG36207s9WwZFheEjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123432; c=relaxed/simple;
	bh=TmduI7XNFrbr44XKsm923BVSV3A1GB7YVgwfSbJYMss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HOoJrunPEzKDo1PzdecJ5Kw8hTo3Z5tI3N1Qm5u/qWzIkowiP/ArBnjcdyUr5HUV8KT5ZRLkM1DXBTbt0s29X2sSJeNSUr2ksMXQrsJQxU9tZDnFAbvMcF50dzcyR/0m0Uj3mnpcxeayxFfVhE50TciY5+YnBGMPSjnwXLoNTPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GpVnONjI; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDZbiU028991;
	Wed, 17 Sep 2025 17:36:46 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxcvesd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 17:36:46 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+f7Y/EJadS1IMfJdeUzw0p8Iz0X3+Vu0nJUa8ga65fAJ6jbfKrjRw3bHQCJXsuIEGr6H/CFH1HYIeVwxgBrdvETLscjk60VOS7Kw3/rrMQbw99ho947WPzlEtltm8J4wN0dZGYZ0QDiWbhZpo2ZEFTbJyxzKczcXw1uwWUK4WnVGp1UauoVvgMVLo/8Jm7Kj/zKSRQ9RfvCYdCuvG1NvEZ5c9GauCx/zkRVli3YB7UuNHdPaKtzNsnBNneNMVN4arx0RYH0grBDnnNmBqAxWDBAypSvCoUbE/b9+XGCkWavCS+LsCHR6p5UmxPyUf1nxccCq0OiBkUWEVqadAHNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtU72jjf+1mQ5pem8KJAm5ycrl2b8eG6nt0hFn61GdA=;
 b=uHyNctO1B4N2IBeg2A0RQJ6rq12kSKnMVEeQW7jR1/iALRM7tFJmHtOi/bhngMO9rHjVVoo57EgiRmSZIUkGlhoHQy5+PZcCKyOZiT0o8Xtt6hu4VGyWCRLTnMIguHctKSkNhA3/mAn/Yob7uXCca50FvcAH0qCskjqFKQNwBOivpGKRYXSsotKr6GxkWi304zB8ffMbtz4dPmmpfZDkM83LJm5a2FGvHBDY6EaIlhmWaJPTZKxLf9hL7OpyMs3Pfcr85Gv/md+s032n9GqXJnszRTAfI1xpff+dupD5qH9rixpTXv09RbWSJjESm2g835qRK5alWU4JK7QkIlxM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=google.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtU72jjf+1mQ5pem8KJAm5ycrl2b8eG6nt0hFn61GdA=;
 b=GpVnONjIDEwIKjdbQ+IsYPGMXT0pL/5M6di7w7NHp0IPg+J8Pk1m5uWID9XcFG0nH2PpHD7k108SnPd48Q9ibWdF9Ds1IgbzQAkp4h7N1s3r8iBFziHnL9/2pRLUmbmk4j78jOl8Lyzzz2hapPVam+JPUISxkRYRt8k+rplsQ1ghicaqsd0l1JYOyo6xjpWta0vRVsOGVEIjV3tS9N/JjxqLfp7jkobwCiNpx70KTyPfMRqEk9hhO9obixTbtiC8zd7DWoQ+32CDBwzVPGG7cPJrUhNwkGAcbUgGFc2dzZTfBShdPCooj4x8HcjUhZrHbTPzBJA5TJFGSbFVFSJ+1w==
Received: from AS9PR04CA0072.eurprd04.prod.outlook.com (2603:10a6:20b:48b::7)
 by AMBPR10MB9374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:36:44 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b:cafe::a7) by AS9PR04CA0072.outlook.office365.com
 (2603:10a6:20b:48b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 15:36:44 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:34:19 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:36:43 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 17 Sep 2025 17:36:38 +0200
Subject: [PATCH net-next v2 3/4] net: phy: smsc: fix and improve WoL
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250917-wol-smsc-phy-v2-3-105f5eb89b7f@foss.st.com>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
In-Reply-To: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
        Russell King <linux@armlinux.org.uk>,
        "Simon Horman" <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "Florian Fainelli" <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|AMBPR10MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: 269486cf-3dee-4cac-2a19-08ddf600017f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBtZDFCa1lIdmxVRWo5T3RtazU5WVZadUZoRTY5NjRNSlIyUTlsb3B2am5G?=
 =?utf-8?B?VzdSODFKTnlObk9QcVFCVmpZN2xndUNFUmdwSGNoOENXMExvVjhKVWJMMDZi?=
 =?utf-8?B?UXFqQzl4bnBQcUtRekROZkZkN1JxYW9ucDF2Z0pqakNOWkRQVFQwUW5IL0M4?=
 =?utf-8?B?Y1ZNbm5KbEZqWmZ5QjBwRHkwa2VabmpPM2Z4enFya2N4TGlPQWIzVUVVVUNE?=
 =?utf-8?B?MUdseVV2NXpPZldQRW5XVFBBbWFDL0ozV0F0Q1NGd1JiYnp5c3gvbFhkb05N?=
 =?utf-8?B?SGVZZFFqSFZjNGg5Y0dQNFhBZ3M4WFk5ajlyckpjSldsQzdac2t4a09IL3ha?=
 =?utf-8?B?MnNVeHprTUFCSXdDWWtMZ3VTU2laY0twdGRleGt0ak9pZkxzTm43bmoyU0ZO?=
 =?utf-8?B?alFUeVAvU0haaTZNKzRTaHlmdmQvNkVWTzFTbUJpd3I1c1dCWU4ySEwrZDZ4?=
 =?utf-8?B?QUZwbHgzSWZ1M2g2M3Y5MHNHZjRDblVBQmdGWHUzdm9hN0g1anFreXR2M0V5?=
 =?utf-8?B?V1dreDdaU2QyUUNaREIwVHZwejE0Ukp2TmpQQzVLMlBSMnFZN1JrOGRmWGdy?=
 =?utf-8?B?WDRHN01mNVRveXpSazlqM3hxeDBIMEN1MGhrWEM3ZGRIdVZab2JkRTAxdUJi?=
 =?utf-8?B?ZkpPa0IzRm5lMFVKQk1uYjRqeHhlaGtXaWY4RGhSWHhXNmhUbHBxdGZlMXgx?=
 =?utf-8?B?SFJoejJhYVY0R2hGWERuQjdtRTk1ZUdQYmlRRHpQOTc0bWJGb0RzSEhTdzFB?=
 =?utf-8?B?RTNjSG1oOElURnQ1bTVjVFVvaDZYbk4wc1RFVll0VnJXdHEwRVhnOUVyKzln?=
 =?utf-8?B?bTBuYmNHUVpXUEZveDFBaFV6Mjc5cVpuaDFUcWF1RllSRW9VN1NUMmJSS2JZ?=
 =?utf-8?B?QjljSXJ4WnpxeGJCSVMyNDk2R0pmVlpTaDU2R3dOcUNoN2xYZHF0OWpnTEVv?=
 =?utf-8?B?RStrb2dZNGVQWWJsNk5zRk4vd1p6S1MrMEk1ckZYUzRGdC9qRDFXZGxsYVhn?=
 =?utf-8?B?OVY5NENOK2JSOVpHeDMrYnRzeXlVVUdFVHM3aDd6OUhLNDBoalc3ejV1bm1N?=
 =?utf-8?B?Q2JyTWFUNmp6N01Uamx2R3FZTmpTMXh0Z1Y5R2xNNUVHK0RHcVM1RFNzN3hZ?=
 =?utf-8?B?MTRyK0pHSVRJS25VYjNIUnVISWM2eUZ4RGtNNHlYbE9BZUo5MGJtRVpiL0dy?=
 =?utf-8?B?c1dqcDhIUXMrTlg4OVR6OGhHbUMxR0lCanpRZW9pY3RweTRFNkt1K0tkNi8y?=
 =?utf-8?B?eTZwR3ZHOHNyRnlPRFR4YUVVS1ZVTTJ6WmUyYlhJNVp6dHVlRzByaWVxaUkv?=
 =?utf-8?B?TDM0ODFCRHB6N3NZVWhVVFpTclE0b1JrY1VSMlVuZnZqWHI3VVdhcERuOGdP?=
 =?utf-8?B?K1J4YjBTSGNsNGhIblFVMkluK1lYUVI2VUpua1lJYm1yZGU3eXk1ZWZwcklL?=
 =?utf-8?B?VEFZa0R4NTVDbWFPN01GV3JUNFRMeTJRRkEzTmQ4OVRhQkQ1T1dDV0tmMmI1?=
 =?utf-8?B?SExScUhQNlBhMUlFUGVDN1NjOHRYM3g5cFM3dS9Ld0g4cEQrbWI4NGUrQ1I2?=
 =?utf-8?B?R0d6QmpmbVoyV0dxNTc3T2R5STE5VitwbTVmc0tPQTNnaDhheGlVQ0VtWHNY?=
 =?utf-8?B?OGJlblJLMDZVbENvY3ZnY0Y2R1FjZ1k0RFBVRU9jOC9DQkNNNUFIMGlyVmlx?=
 =?utf-8?B?d2JmVEROVkNqRXFOSGlPbDlUWmJoUEpQdGVCSDEwRXFML2U4b1Y1eXdwcWdY?=
 =?utf-8?B?eVcwTHFnRDdGaStYUWEzSTIxaFBKWnV0MVI2U3Zvc2Y3YVNiRE5qbmJPU1Vq?=
 =?utf-8?B?cnRCRmQ0bXp4dHlFbUdsa2Z2VjdQM3RjQW9YV09teTg2ME9UdGpEMGVoaWpy?=
 =?utf-8?B?Z2R3eEptZ0w3YW1wUWhTVGIxNmhmU05IbG50bEZTb3ZPOXVibGtBRXAvWFJJ?=
 =?utf-8?B?Y2FnQ214Kzk0eEFHblpqVUxGL2RtNWM5Vm1DRzQ5SGh6Q3ZveGN2NXhZY1JZ?=
 =?utf-8?B?Q0wyQ3VSdllrMklXUEp0ZitJVm9NSHNJb25mM0IwWkwzcVlzQXJ6cDFVODVF?=
 =?utf-8?B?Y2hZOFVLNDBLUnpZV0I4QVJrUU9CZTJMQzFLdz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:36:44.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269486cf-3dee-4cac-2a19-08ddf600017f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9374
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1TWfTvU/eU+F 7K9q53SsVLdf33uXrOXepanwjRYxfENGgFz9kxtCRrqbU0AVcXlbYb54A5nXKno5I1jxryXkuze rvXpMHrfGEUCcJ2V6wMS6U3r5Mf0VfjLffjV4X6G48nfBX/pCZX0JIq2uzmAxtaM8+rG8hdiswh
 l8iPConC46JWZlj7/xRzNx46OzR4Vmsgkfd18jOa6WBnI0sqrcb6jCzl0DYi/TzGyy+hAMkdYSH nDRsBEG735mkSiSE5rmr3MDSxeltutFyma6dTiijfYy+rXO97zj1EgyeHeF6q/lGIEMNhlYxXI6 yFq9UNxDjACvAxdi50f9ErIOaM0QhPHgM70m3YMwcynMoEgg8eBUr9C0aGM5xOdIVxav7b07ED5 1fVMWkIj
X-Proofpoint-ORIG-GUID: 4t_XUpXG-SHpxisYYNOnFk_9OQmxKKD8
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=68cad58e cx=c_pps a=sfN2xSSYXAWEoTbWCh/xAg==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=tXpPc5ytXBtUH3IrnXwA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 4t_XUpXG-SHpxisYYNOnFk_9OQmxKKD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add suspend()/resume() callbacks that do not shut down the PHY if the
WoL is supported and handle the WoL status flags.

If the WoL is supported by the PHY, indicate that the PHY device can
be a source of wake up for the platform. When setting the WoL
configuration, enable this capability.

The suspend() callback now handle WoL event flags that would prevent
a system to wake up from a WoL event when in low-power mode. Because
the WoL prevents a call to the suspend() callback, add the
PHY_ALWAYS_CALL_SUSPEND flag to the LAN8742 PHYs.

Fixes: 8b305ee2a91c ("net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs")
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/phy/smsc.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/smscphy.h |  2 ++
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 48487149c22528631be5aca98ff4980f55b495d9..818cb21b833a530c7fa2384f605bbb2e93c5eb5f 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -537,14 +537,67 @@ static int lan874x_set_wol(struct phy_device *phydev,
 		}
 	}
 
-	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
-			   val_wucsr);
+	/* Enable wakeup on PHY device if at least one WoL feature is configured */
+	device_set_wakeup_enable(&phydev->mdio.dev, !!(val_wucsr & MII_LAN874X_PHY_WOL_MASK));
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR, val_wucsr);
 	if (rc < 0)
 		return rc;
 
 	return 0;
 }
 
+static int smsc_phy_suspend(struct phy_device *phydev)
+{
+	int rc;
+
+	if (!device_may_wakeup(&phydev->mdio.dev))
+		return 0;
+
+	if (!phydev->wol_enabled)
+		return genphy_suspend(phydev);
+
+	/* Handle pending WoL events */
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0) {
+		phy_error(phydev);
+		return -EINVAL;
+	}
+
+	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
+		return 0;
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   rc | MII_LAN874X_PHY_WOL_STATUS_MASK);
+	if (rc < 0) {
+		phy_error(phydev);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int smsc_phy_resume(struct phy_device *phydev)
+{
+	int rc;
+
+	if (!phydev->wol_enabled)
+		return genphy_resume(phydev);
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return rc;
+
+	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
+		return 0;
+
+	phydev_dbg(phydev, "Woke up from LAN event.\n");
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   rc | MII_LAN874X_PHY_WOL_STATUS_MASK);
+
+	return rc;
+}
+
 static int smsc_get_sset_count(struct phy_device *phydev)
 {
 	return ARRAY_SIZE(smsc_hw_stats);
@@ -673,6 +726,9 @@ int smsc_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	if (phydev->drv->set_wol)
+		device_set_wakeup_capable(&phydev->mdio.dev, true);
+
 	/* Make clk optional to keep DTB backward compatibility. */
 	refclk = devm_clk_get_optional_enabled_with_rate(dev, NULL,
 							 50 * 1000 * 1000);
@@ -851,7 +907,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "Microchip LAN8742",
 
 	/* PHY_BASIC_FEATURES */
-	.flags		= PHY_RST_AFTER_CLK_EN,
+	.flags		= PHY_RST_AFTER_CLK_EN | PHY_ALWAYS_CALL_SUSPEND,
 
 	.probe		= smsc_phy_probe,
 
@@ -876,8 +932,8 @@ static struct phy_driver smsc_phy_driver[] = {
 	.set_wol	= lan874x_set_wol,
 	.get_wol	= lan874x_get_wol,
 
-	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
+	.suspend	= smsc_phy_suspend,
+	.resume		= smsc_phy_resume,
 } };
 
 module_phy_driver(smsc_phy_driver);
diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
index 1a6a851d2cf80d225bada7adeb79969e625964bd..cdf266960032609241afc8316da23f1c4834bfee 100644
--- a/include/linux/smscphy.h
+++ b/include/linux/smscphy.h
@@ -65,6 +65,8 @@ int smsc_phy_probe(struct phy_device *phydev);
 #define MII_LAN874X_PHY_WOL_WUEN		BIT(2)
 #define MII_LAN874X_PHY_WOL_MPEN		BIT(1)
 #define MII_LAN874X_PHY_WOL_BCSTEN		BIT(0)
+#define MII_LAN874X_PHY_WOL_MASK		GENMASK(4, 0)
+#define MII_LAN874X_PHY_WOL_STATUS_MASK		GENMASK(7, 4)
 
 #define MII_LAN874X_PHY_WOL_FILTER_EN		BIT(15)
 #define MII_LAN874X_PHY_WOL_FILTER_MCASTTEN	BIT(9)

-- 
2.35.3


