Return-Path: <netdev+bounces-299528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8qCFKwkMGo9OwUAu9opvQ
	(envelope-from <netdev+bounces-299528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7206688303
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=genexis.eu header.s=selector1 header.b=q5MSLSD3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299528-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299528-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=genexis.eu;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 835BE30EA482
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CE40912F;
	Mon, 15 Jun 2026 16:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023128.outbound.protection.outlook.com [52.101.83.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91640628D;
	Mon, 15 Jun 2026 16:07:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539656; cv=fail; b=C53noFNPoONY0iD1cgljPWHNLo6uawbEPTHZpDXHc45ep7jKYBGsUaNhhVKC1WYt0fUZBHUqu+O4NqMPibWgNvIeNG8VUOFANUZJyXBr//gXYnY+1G9boIUfdkb7fBCNR6CKY02LkQyuD7cIs/7te9YJ01PTBSnH1HEIzbUNyac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539656; c=relaxed/simple;
	bh=l0J2exwWvAYmXaht2YUEI7CSGIdofcgyL2iOuTaGYlk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fgo1PEoerkdRnzML3CIng1AvyhFn9ydpWeWMaOkotgtEbXm3WFBEaVnPVzM3HYdX/xH6yZSkvEwE9UoWtRmGRHkR0Jkp4S9HTnHLvH45sx9s9ER2TWMLd25yEMf8suE07p1H6RJv0Ynl88zgUimziuPcqX/yRtRytKoghFoh61A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=q5MSLSD3; arc=fail smtp.client-ip=52.101.83.128
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEzYILUhvuTF2t2g6EV8gNYKAgA2d5S4tgS1bk3WcnPWEd0+jhezOjFTpEsc9btqFrP4TUCr8DmDZJ0V0VRBgYeBpvRsFUi35+p1EM5ev51CsA9cGbRxueOqEZfnDyHpX0Ei2EH8QySKfzFpULDkk/fxhuH7/wjKZUTKinaX2CIWW655LXAvnRCe1Wrfl+CEnWLxwIJixyOwXnnx8uexBzM4AJiwU9+CJS3bnx5aBwobQJb+heR7LmzetNHot8XflpQNDmMhSAOR3B8g2PAFTosiCZrJRoLPTl5l7zA0zTswvy+yZ/9JyO25QkkDZXDtgF3WjlNIhhse+KdVBSuGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjEKOVmSawLDjbusYExuhQVHSPU73cb5fl9gHKhGBHU=;
 b=WMMGOZ7QFvfdEHH6+fBOnsOREzN1IXkbFxwFd3z+2hMuO8LTZwOz+BoThYsjgEfu5v9P/fFwQf8VLvVX18A8xzPCNNIoucUkEwjXrzzRPGCc4bHgJA/XsUioj7JHobbUU3Zvouq+dNFcnHgvd7EdvG0UuAjvxv40gUfs+gjFLLGoij2DJseNHoNGogOc9vKr+VvqFGWispDxjzYFw9fnfnJRWcO5DE7gM9h4TuP/Kkp0ou/5a5qTtwAx7pYmpFmWGVUIqlj6AuwBWmbtkhsYiEkw/fzUMpP2OKPR6Okwtd2E1zebKmAzuLJovLJa1kVnVYEJUJ9lotzGqiYAViQqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjEKOVmSawLDjbusYExuhQVHSPU73cb5fl9gHKhGBHU=;
 b=q5MSLSD3DQQlEwLsH46+3AJ4LJJfcHJ3Tob8sfpCBYw1VwFeib1EhJRIrJO20o0Q50Afhd7qSFPPTL4CiKPeTe4HtJaNZ0rrOxxIdmRUhXPU9IW++2alY/sx8mR6xnxTM6wiD74+BDNfSSwiMMPkKMPhqMN0AIi2jmU6Lbkb5BRUXJ+grMSVWcYD2IJlBG9yR9KswUGX/ksCX474UYiq89Gg6naOYVfdKejQupAJJ42eVnD+Q7eEZgCJuHF2Q5PisI6ahTk2L833wxM5WqZsLyorTOmsYXHQgME4t0yY/bSGcRMMXxOP0dKNTqRUvJSmByXzmJAA88FK/wA1bZT6/A==
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by AM0PR08MB5410.eurprd08.prod.outlook.com (2603:10a6:208:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 16:07:29 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 16:07:29 +0000
Message-ID: <eac0714d-d8d3-4698-8983-91dd33fe79bf@genexis.eu>
Date: Mon, 15 Jun 2026 18:07:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 12/12] net: airoha: add phylink support
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-13-ansuelsmth@gmail.com>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260615122950.22281-13-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::10) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|AM0PR08MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e916e4f-11e8-45ba-843d-08decaf832ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|5023799004|4143699003|11063799006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	tI2UYShFz196dMcQhp3UcRTunzVB8dXsAf9pkLTqvFkqH7VvCgdNBuJG/Z5AAFE1CtnWDmV2BtneS/uMjbfgrM9oFXaOQP6hWra5I/6fpD9ZUH91L72ZKREtda5AJuPnKVA+sQl0p17eMuoARDlvvwKK6N9GpP/L8BPr2iYZlDCymjUeh+RTrHrLgeLXDG8pYwDElKL5jVzGuhR8SdRzuO4KI1+J3loNtz/hcrT4UxR6oCFbl1wPRlno0cpgdwrzOSaXJJwrFE91ZjqLfhK85hBanWG0+NJqq/adBxbB/wMWcHYfHKBwPj+jAWkCsCxpVfo21AYMSe3ohIOLhWLmfmZFQppjJFTGY7K65XgjbTaGdsPqZ5EDvleIGH20FCF1VFHmb7XgePJiRvps88dMfPNNau9y1OHBI3L8Q/Uv9FGfhxWLbdtZcRSLe+YaB6lm2NrnuOySFgWqsRUIWtHX1UQ6zato2o92zdwxNrbg1/ENHXn0Xn6XjKNDFhAzUdA5lICyKlPKK4H4/haAPk/6sLgbmFplBu6YRfukWFoRGrj+NKLBhBbf5/kedMHspnaNIv3cja9eroq8LtcPTjNmVCzY8/UwW/7rt+xvm58J1qMQaKMZxDsuRUVVz2WpxQ5JP2SiJQztoOwBCUp5avZ8rgFpLI5hy1Bl8fXdO2YxfF6HLFMv9WBW47pkA90vAIDFYcppZo8fPzLUDAqhYp59fDbp3fSidSibr5FzM2zeAeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(5023799004)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RNc2xqZ0RvVTlvYnpEN3VVRTgyMkpMSnRVMnJ5SWlQL2l3V25FVDBYd0RZ?=
 =?utf-8?B?Nmhtdlh0ak5NOUw4NUdpSUgxd0NlbGNvRzFBZ1NoV0dtUEZyZmw1NEpxVy9H?=
 =?utf-8?B?T0hGMDVrMjRwSCtJRE1UL1d3SXJDNWpjVStBSWNPdnFINmFMcVBiNWpBRmlX?=
 =?utf-8?B?VzJMSlcxWmMzV1h2NXZwUUVNbXpPUTRHek9qR0xzSStmeTJlTDVrdEFwSk1S?=
 =?utf-8?B?MlV5UmRIU2lzbHg4T2tNN2c2UW55cVFybEE5ekJLWVdGYkhVWWNrcXo5L0k5?=
 =?utf-8?B?czl0QkJJWVF3RnBFRkE5UHZ5MndGWXJ5ZlhmUGw5ZEFRVlp3NjlVL1lZVnF4?=
 =?utf-8?B?VkhQL1RvR1hrUXJodnJDRk1YczExdTRWTHZUaXhHWDg4elFIdzNycTlOWHov?=
 =?utf-8?B?OEhNRDNPWVlkWnp2TU1XQkI1T083UVFncjNGSlhoU2NFSnN3VndWcmYvNmt2?=
 =?utf-8?B?aWYwSmFzSzJoMGovajlMeVJWL1FIWDBkQ2dSUEVjdTF4WUcyOHZ2UkpDOHBI?=
 =?utf-8?B?VHFHVWpWdWprNWNUQ3Y1ZjMvdVRZbHZLMlZGZWkrRXJyUW9FR1FmOXN5KzZQ?=
 =?utf-8?B?M0I4VlNqMEI0TC9KMC96SzYrbUpLaGhURGxOcWpEOWplL014K3NzSHNocVcw?=
 =?utf-8?B?M2J6RXdNZzk5Zjl0SGxZVjdWbTNPakhQaGZmeXRFc1ZiK3hKcmJac1g4THZv?=
 =?utf-8?B?RkZxK2dRd1UyTm8zSzA2V0FjTUFuTTJoUG5IMnhWVDh4dnZmTXlPTzVOcTA3?=
 =?utf-8?B?dUVuQ3NvcEV5SzBBNitjMksrZ0Y1VUVYZmI2R1drUUpnTFV3VjFMVDFRN3Bm?=
 =?utf-8?B?dXUxTlpuRmlDMzRJNlBEMEN4RFZQWjJxdm44azNnWGpIeXRnNC9ZMllSUXpm?=
 =?utf-8?B?Z2dNVGdQTXZTRDVFd2xRcU5OY09CbGhNVFV0RHRxSGpQdWI3WTNoL3dsUURT?=
 =?utf-8?B?L0N0VlhpQnNhUVFvRlhpaFNPNndQazVRR0RiUjhaQnVaeTFibGw1YjB6VXZX?=
 =?utf-8?B?OGZLdjJqUi9IQ3lHd1h0cUViaE1SNUxveVM0enBlMjFMaGdEWHFma2VVWTE1?=
 =?utf-8?B?WHR2MEI0QnJ4NG91V1RQUzI3Z1k4VVZKT0d4Qit0ekRzMGkvUFdOeWNJUHhQ?=
 =?utf-8?B?R0JRejdQaWxCcHBtN3RUN3B1SVBrU05KVHdxaCs1WHpDMEJmYkQ1ZFN2djk3?=
 =?utf-8?B?eDNublJwKzhZbU8wOWxtQi8xamdpenRUbkdyb1BhR1IvbXcwNHBFMGY3T2tw?=
 =?utf-8?B?Q0dpZFhzbGYycXkyOW50c1hhUWlaUE5rVWRiNXFlSUxUd0RCL1I2bCtlUG4z?=
 =?utf-8?B?RStkSWI4YkZESzlNVldKQ2FxeVUxQ1U2TklVcko5bEdxQUZsRXZjQ2RjK054?=
 =?utf-8?B?VlNlbXNEV1cxQUdGYmtxM0IxaldVQk5oakhiT1NtWlZIL3ZtTkF2ZGY0RkhX?=
 =?utf-8?B?VllNZFgyd1M1WjVWNWMrc0JWclFNWCt0K0VzL09uMTdnT09OZ3kwVDhBS1dT?=
 =?utf-8?B?WmNhanFwUGR3YXhSNDIvTDhvamFzaml3d2pGRmp6YzVCaDZ2RmZoWEowZHpv?=
 =?utf-8?B?Z2plS09oY1U2OGliOFlYcmR1ZE1UODAreTB3VHFzVWRlZk04c0hzcEN2Z2RM?=
 =?utf-8?B?cWt4Z2xhYjUzMFE4cm0wRVRmU1YraTBsZ3Ztcm10TjVrVWExM0FyZGlMZW5E?=
 =?utf-8?B?Y2czLzJ3c2c5ZjFBOVM2OFREYURyRHBHZ1BTZnorMmFUc04vNFJDRlk1ZXVE?=
 =?utf-8?B?OXBxQXhqSnNaMUU0bUcyLzJUcE52clVNS2lhSEw1cldlRGx4SGVHK1lKUko1?=
 =?utf-8?B?SUR1RXcxaHRXMFdua3J6K1AvZWI3bjFtNGlUTXYzNmxWWW9YeEY4bEJzQVFD?=
 =?utf-8?B?VnFZTHQ2TVJ3K1EraTJhckpEZHk3YTVKNXJZSFJtUlVwNGhCTEN0QjZ3cFNm?=
 =?utf-8?B?cWtOR1JmRFZGVEp5d0pTUE9MQkZKdkJQYjBEbTdOK1NoZEhCaU1JM2xsMFgz?=
 =?utf-8?B?YXhxRWt2SWNGeE8xZjhBeUVkS0hldVc3RS9SNm1VTm5lWC96cHYrSXB3KzIv?=
 =?utf-8?B?TWFUd0RBK1p6K3kzTEE3QjdacEtNRmFneE04ck9zaFk3bXMrdnRHZTNGVWhO?=
 =?utf-8?B?Z3AwR1E2WHA2RlVTc0RKQnhZV0wxUi90NVNCUlhXUDRRTGx5L1FTeGtYR1JU?=
 =?utf-8?B?dVp5S1VySHhuczQzK1RyUHdSeXltVXRTdEJ0NzVEN2RjOGxrV1V2RzJIMTVa?=
 =?utf-8?B?UTFzdGw0eFhpd2xJZzdRekVSVHNkbWZmMWNJclVNWXdxUlNKY2RXSXdPUnBh?=
 =?utf-8?B?Q3gwTFBHNXcvbWtkeUwxL1BwaThzZ0VCa0RPNFBrT0pNMXZuWWhTemp4VnB2?=
 =?utf-8?Q?/OBC6WyN66+Y2yE0=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e916e4f-11e8-45ba-843d-08decaf832ab
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:07:29.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmE87s+ZB0nUkIrWO4/Z2jvi7Id0C/kV/j1xLavOK4S/dpnzIlXneUcvpvwSww3oXSYTOBUNrn9ISh4ZBJmYSj98shvadNHKmyKc6g2wDyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5410
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299528-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[genexis.eu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,genexis.eu:dkim,genexis.eu:mid,genexis.eu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7206688303

Hi.

On 15/06/2026 14:29, Christian Marangi wrote:
> Add phylink support for each GDM port. For GDM1 add the internal interface
> mode as the only supported mode. For GDM2/3/4 add the required
> configuration of the PCS to make the external PHY or attached SFP cage
> work.
>
> These needs to be defined in the GDM port node using the pcs-handle
> property.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/net/ethernet/airoha/Kconfig       |   1 +
>   drivers/net/ethernet/airoha/airoha_eth.c  | 161 +++++++++++++++++++++-
>   drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
>   drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
>   4 files changed, 176 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
> index ad3ce501e7a5..38dcc76e5998 100644
> --- a/drivers/net/ethernet/airoha/Kconfig
> +++ b/drivers/net/ethernet/airoha/Kconfig
> @@ -20,6 +20,7 @@ config NET_AIROHA
>   	depends on NET_DSA || !NET_DSA
>   	select NET_AIROHA_NPU
>   	select PAGE_POOL
> +	select PHYLINK
>   	help
>   	  This driver supports the gigabit ethernet MACs in the
>   	  Airoha SoC family.
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 5f1a118875fb..9a42fb991bd7 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -8,6 +8,7 @@
>   #include <linux/of_reserved_mem.h>
>   #include <linux/platform_device.h>
>   #include <linux/tcp.h>
> +#include <linux/pcs/pcs.h>
>   #include <linux/u64_stats_sync.h>
>   #include <net/dst_metadata.h>
>   #include <net/page_pool/helpers.h>
> @@ -1810,6 +1811,14 @@ static int airoha_dev_open(struct net_device *netdev)
>   	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
>   	struct airoha_qdma *qdma = dev->qdma;
>   
> +	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
> +	if (err) {
> +		netdev_err(netdev, "could not attach PHY: %d\n", err);
> +		return err;
> +	}
> +
> +	phylink_start(dev->phylink);
> +
>   	netif_tx_start_all_queues(netdev);
>   	err = airoha_set_vip_for_gdm_port(dev, true);
>   	if (err)
> @@ -1907,6 +1916,9 @@ static int airoha_dev_stop(struct net_device *netdev)
>   		}
>   	}
>   
> +	phylink_stop(dev->phylink);
> +	phylink_disconnect_phy(dev->phylink);
> +
>   	return 0;
>   }
>   
> @@ -3168,6 +3180,151 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>   	return false;
>   }
>   
> +/* Nothing to do in MAC, everything is handled in PCS */
> +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
> +						  phylink_config);
> +	struct airoha_gdm_port *port = dev->port;
> +	struct airoha_eth *eth = dev->eth;
> +	u32 frag_size_tx, frag_size_rx;
> +	u32 mask, val;
> +
> +	/* TX/RX frag is configured only for GDM4 */
> +	if (port->id != AIROHA_GDM4_IDX)
> +		return;
> +
> +	switch (speed) {
> +	case SPEED_10000:
> +	case SPEED_5000:
> +		frag_size_tx = 8;
> +		frag_size_rx = 8;
> +		break;
> +	case SPEED_2500:
> +		frag_size_tx = 2;
> +		frag_size_rx = 1;
> +		break;
> +	default:
> +		frag_size_tx = 1;
> +		frag_size_rx = 0;
> +	}
> +
> +	/* Configure TX/RX frag based on speed */
> +	if (dev->nbq == 1) {
> +		mask = GDMA4_SGMII1_TX_FRAG_SIZE_MASK;

Can the naming be consistently GDM4 without the A?

MvH

Benjamin Larsson


