Return-Path: <netdev+bounces-224090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841CBB80A01
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B65D1C24FBF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E39335927;
	Wed, 17 Sep 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y8ON0pSH"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BB2E228D;
	Wed, 17 Sep 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123432; cv=fail; b=ugH5ROwfnxoV8PPaGPnUe3VYzTslXGWVpRgAib2DijNRJ0fb45jAx6qbtM2gdqFTcblgNmCy9HAD1SVIa3LLySWXSZrMWs9SAKWwbf7hkGXIoZ4VCLtsrDPddU6aa2kRGzyEQDY+arL78FHy9Fg9lAhSoj/6Msh/+eAuR7zuHHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123432; c=relaxed/simple;
	bh=AVUPMZ6P1ljp8J+91U7VqLZ1IcAWk7d9Y3uykiySBCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d+yOSz2a0isSbZRNr8UAIixc4xaju56PVHbKZK8p38SxYa/aqL3F2rB6yEx9I0zUYLbW7zPsOyMY0p048SL+rzSYlKu18MO0+phPU7xDdP2QNDwo0GhULuZYzaPwa8gv5CgEEpw1+f94VOOQ+W87CV0uAxlNUzqdiXHmxkAGQ5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y8ON0pSH; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HFS1Pv014203;
	Wed, 17 Sep 2025 17:36:47 +0200
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhmf5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 17:36:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR2T1Kz5dHBgPfgk7lpVz3FktGWmcknms7DUfgb8m3Bxss+5tg/KARKAmXFB2hswxHdLuEGGapNbsPCl7QW+RGkQjvKOY5EfpEStDs5MhOkP0+Kt3cVynO618ldpRrTCcQHCpybwgUvCX0cWTTFBK0YZ5vC4B/+Vc+iQeXSyGk7pDpkMFtlqiinhnzqGJ84TH/fXkhiUX4q6Ye51LY0sfkDJsZQmWuxWi3x4AMnHflcBiJPnTFDCNZS1ugCpeUwds1l2MOgYRZfCL6j/ifaaGljJC1jJ3ppopqo8sdIoHyQU745XFR3WU5rPSklhWVyU6GGUwBQ1fAyR1Dd2GtS9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VtqdaZwVHR8A9mFz92Ryj3JcVImENwPazufVvRFT0k=;
 b=OyYXkxbuoLb1q4lXC3fpV9SCb18mS5VXytpfACfi79Q9HLXi1D2KFG6e+Ai/Fdx5FHX2hl/HMF2k6Gw5wfP772fliDVvkJepSxL6Ypcw2McHZ2w0c9Id+u1im9eEQsOlrAGgrQs++n3eKcoq/uVcoKkjmTqsxpzaOu+QivGTDR96VYjquIChh72TnO2hceknUi6QTOw4emtHEoeA0rC6XEcrq16AbaTNt7xutOUHzqXO3erJkfeRo3XDt3BSusQOqHF5vtIJI00ybEw47AlP83f8tsvO2NYqGehsbLnQEonsvCHi1hCqi/0rVAM+30XwVGhVuGAjdKbn049gtLWQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=google.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VtqdaZwVHR8A9mFz92Ryj3JcVImENwPazufVvRFT0k=;
 b=Y8ON0pSHN4F0BC4zzzgIGEOMTLzseo/aYA1ZiqED5Dwz/mYTIt1mGYZQ2UB/3T5MOIO0Wz1+PJ5wWDstY651z12tiuziJrmks2kQoN7t5T3RhP6PbKi8KpXBUEuotqccZJ7NYpSxYo4j62fp5YVXqQoEADviqDQoLgIHWSHbxXxivdYQcwER4QpTvqZeOKO5L9U0jyqUCLysSixk6vnUErM8jv9fuN3VqFlark+2wmdJKtbdFfTD5MlcnQvJr2Jq3Yjx+mK58CcTxqm51/kw8RKjgg8V8i1u+Fa7DFPPNbvCyK7Wm5mv3IK82yxHIYTYAP0RWPVuwOM5eBN0AoS3zw==
Received: from AS4P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::16)
 by PAWPR10MB7224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 15:36:43 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::62) by AS4P189CA0013.outlook.office365.com
 (2603:10a6:20b:5d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 15:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 15:36:42 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:34:18 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 17:36:42 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 17 Sep 2025 17:36:36 +0200
Subject: [PATCH net-next v2 1/4] dt-bindings: net: document st,phy-wol
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250917-wol-smsc-phy-v2-1-105f5eb89b7f@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|PAWPR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9789a12e-38ac-474f-5399-08ddf60000b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXJCU0ZzM1M2NFNmdTdNNWpqeFFsRUx5TGtON0FXYkpMTmpzNStwWi83eHNB?=
 =?utf-8?B?T2tCbyswZFNjR1hpT0NER2srQ3U2UWk5YUo3ZTloeFkzRlB5bGRqZ2Z2TlZa?=
 =?utf-8?B?Zm5IQVBldlo5T2NDTnhoQ1ZtQzhoQVRIK01wYUtIUHJZYTQ2YldBWGowUjlI?=
 =?utf-8?B?eW1XNkhHR3FGWHBsWVVyQkRGM1hHK3kyOHJjWW54Y1IybFNodXFwaitUT1Fo?=
 =?utf-8?B?YjY4UzB4NWxBYkMwNVlDVElFVzYrLzg1cHNIOHJqbFFmRnFxdmpkRXZ3YXBl?=
 =?utf-8?B?V0M3aUQvOStsZkIvbXZzZVJxZVJudnRqb1l5bWkvMjM3NFp4dHBKSGF1RDBS?=
 =?utf-8?B?bjNtRW4vSnpTOVd5dHgvQTFWMnZpWDhzY3J2VFR4NGFnV2xqQlEydFdYVmll?=
 =?utf-8?B?dXdLS0Z5eE83cTYzVmNnY0E2ZHhqazZDRnlxOUwrekRoOVNiTmFWWU9nVWhP?=
 =?utf-8?B?dThSOTBvcld2VXhtd01nVEM5RnJHZkVaZVoySEZLY1ZhTFRZeDFMMFVFK2Rk?=
 =?utf-8?B?Rm0vTytyWXhlUGVYNFVlVVpodElzam5RUHluUm9FUHpRUU5OWGNjeTJPZldo?=
 =?utf-8?B?SXJMOStWY0hxdkd2bG5lSHZpSzdRZ2FiZ3oyaVVMTER6SHp2RXJLMXp6SHl4?=
 =?utf-8?B?TXZwcWNzZWUzdjIrM3JFOTg4TUxEUzQ0b0p6d0IwcjJ0VU9nZGpJTEdaMXho?=
 =?utf-8?B?ZitMSE1yUnU3bFdOSUdyYkVGSENGL2poNHBPUTZSbER4dDkzdzhGWGdxMnB5?=
 =?utf-8?B?S0RVQzAyREtSRTJ6bmtmc0M0VFU4aTh2VFg4Z3FmMGoxUmRYRWtic3Z3dzA2?=
 =?utf-8?B?bDJ2L2RrTWV6UlpxNUtmVlg1NUdZQlhRMHd0cU14VngyR0J0VUdpR3BIREUv?=
 =?utf-8?B?amJHR0E0eXRBQmtMcTVhSVE0SGxxcTZaYXpNT28rYmdQSm1EdjNUY1dQRVJr?=
 =?utf-8?B?STcrUmo5MzJ1bWtVcjNBSk1ZOTl1cEVxcHpYa2E1ZGR3TWlidnRMVjFNUE1t?=
 =?utf-8?B?VWF2YWlBSUZ1WkhtUWs3ekpISE1jOW9teW5jSGU1MFF6Zi9Fempmd0ZLb3Fz?=
 =?utf-8?B?N2Q3bDZlQjF0a0ZpdFY5N0VIcUV4N2tJRmlIeHFzSTNLdGZOWHh3aWNucERW?=
 =?utf-8?B?T09DVDhsYUY5ZEVISmRSUHpqYndkTUxqOE8wcm9mbHdkRUpVR01zMlpBQlNa?=
 =?utf-8?B?NDFOdzlCR3pwZGJPV0hkM1hMSG13a2h0UGJXTExac3R1eW9uenpzZkxmM2Nk?=
 =?utf-8?B?UVdoLysrVld2UjR2azN6Vmg4RzJEUGZoeUN3L3Y5Y3BRMmk3VTJGSW5aT3Br?=
 =?utf-8?B?YnNpbnJydUJFOXBkbDZzc3ZLKzNiL0RpMEpvRVJuaS9KR1lOaVFuaWxSSGMx?=
 =?utf-8?B?R21RUG9DallLaVN3UlFSVEtIMDl3cGI4ank5ai9jUE1hMHJoU05NWmtjWUta?=
 =?utf-8?B?TVRmVDZ3QUZOYjdMWjZDS1d2ZDZFMXZpd2wxVjlCSDhJN1JTQ2FxNTN0SVQ4?=
 =?utf-8?B?T0lSNHg3Nml4dCtrTGREY0lXQ01Za1NkM04zQndxMVEzOUU2MS9YR2tSUlRI?=
 =?utf-8?B?OC9tS0lmZWVYdWhINFdGRWVFSndlWm5xeGpqNm00ek1TUFFLdThCZk4vdmZs?=
 =?utf-8?B?S2o4TjhSS2VGUVZwTlBaeVR1TVZYaHIwVHlFNU9MdW5QRHNWTG80dTZTUGNV?=
 =?utf-8?B?d2VNUjFvZ3JCVnpTQmY0VkN5aTZTTW5NZnNjS204K3Nmc3BXa2xsTGY1bGdn?=
 =?utf-8?B?clQ5QU1ZUG10R0VsQmYrRG5KWERKSmZWaER0TEVkRDBIYkRCLytvMmdtWkpX?=
 =?utf-8?B?aG56a0l6eS93ODNQYWgxSDlZYzB2K0NaOFhvSXl6OGt1eWtnYWE1Sld4YnhB?=
 =?utf-8?B?ZmFOMG5yaHRUeGZiRk9VcGUrYm5yakhlK08ydk0vZHpZK3QwMWhKbFhPVFNB?=
 =?utf-8?B?NHRqNUREZDFyMCtVYW9pT3kwVDZRQkpJTC90bk8zV0xwRDlnZ2hjTDU1SlYx?=
 =?utf-8?B?NUxwYTk3YWV5NjNlSXovem1WM2tiRWVLN1E2YitjVk5BdFBQVjNEZXQxcE95?=
 =?utf-8?B?MndNeFFXNEpYL0o2WDFlcnQvMzZzRmN2MVZJUT09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:36:42.7807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9789a12e-38ac-474f-5399-08ddf60000b4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7224
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68cad58f cx=c_pps a=EgRXHHxucc3bA2piCTy23A==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=Rv3HoT1R5MKggpfMdocA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7GNhssQjZRUf /7QqpwbUlJpcMBSR6lLvh+JdtPysephmA3xu8jeYPuiiXlCCC86Hw1yaTnMSltWXjm49ZIJ6xTi n05B1vZlp0HsR3CH/Qwr7xRqz+3SE84ZRVTwa8fSFBd0ITiz1z8KL6kAOYEQ2Dk5mcYCtQ2X+nS
 kEfSjuIvU+bEWh4MT/73ZX+LBk8RxW7Yo3NHK/nBFNpIYkUktTbjaMSs/nArNnqHtNt2Rhb5Q5T HF5VxA58DOpO3PRvsJD1X97DoGsuRm+d/s+mepDLdn6TBZphe0JdIF14gd/tL6Qsc3XebgRgcoq lyYM2RGSTHCn0N2YT3RGhCfwLUxg3wGFiA7yfF02S1YsSIx2Hi0O5FRSysya/ZvqkucrRMLck+x r0rgmPS8
X-Proofpoint-ORIG-GUID: O3yOP_57OCZqP9kL-f_Om--earhS7hov
X-Proofpoint-GUID: O3yOP_57OCZqP9kL-f_Om--earhS7hov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add the  "st,phy-wol" to indicate the MAC to use the wakeup capability
of the PHY instead of the MAC.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 987254900d0da7aab81237f20b1540ad8a17bd21..985bd4c320b3e07fd1cd0aa398d6cce0b55a4e4d 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -121,6 +121,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  st,phy-wol:
+    description:
+      set this property to use the wakeup capability from the PHY, if supported, instead of the
+      MAC.
+    type: boolean
+
 required:
   - compatible
   - clocks

-- 
2.35.3


