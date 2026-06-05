Return-Path: <netdev+bounces-295567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jddRJPErImrTTQEAu9opvQ
	(envelope-from <netdev+bounces-295567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:52:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82B6448A6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hpXda0OC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295567-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260923079320
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801393E6390;
	Fri,  5 Jun 2026 01:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15023AF647;
	Fri,  5 Jun 2026 01:45:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623935; cv=fail; b=i+NiFSqvRgt8hPw6guU3tKZFFQw5QW38DJBx2ttI2DJYHCKfzE+Tf0qU/hVuXh32irQdpiDIP1S1gwcxKK8mCuyMRfC5VNAQOhWUkn1GLBi9qETKHjLTrA2HKUhQ5XdnsmXx3ONmfUniGOwigu7Bfvj4Yw5RHV0WGp/dgJc2RBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623935; c=relaxed/simple;
	bh=bGIHe4oAVcj1yK6R/GrA5dn0UVIVyyA/VR2pa50sMHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/HwE0JHmTcT6zGIAc4LKRKFwZ9+KNxmLCWgEIBhguvWTIhbtnbf/0bqbodjnQlR07eM4scyCfpW4iKwhMjrhvJ8SbfqspZyBDOhgVPBXQ/Y38Ca9h301Rlkq6i4ZtZ7zyd5EX2hDV+HwqjARkNg1ErXazb9vPv99RmVfbWtq30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hpXda0OC; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCrgIroTH6xF2Yrs439xdmHPcQ7YCfeZvPWo5wM/YNZRtgurL/dLgYBEgt3L0YKeVIhlkqjh2BrmtUjl/JuyGuYDpXHvibA2NAYw2tFiFtSyTZWQLQzCnC3b3NVTzY78bw8g+4AJy7G6btfzfCXVfbKor92qjdtdjUpPcESbFHAxc7JN6c++8Im3q9zUf5+RTtE+f05COsfken1jTYNT10MsmbEs31RvLL5GBC8x9v0M3eVBBqI6lf46fCncTLNadafDp7hpNP7DMjFO0VSgBvhjzQ0R3SneI8G/K3TYiwHukuwevbuBD0r5e5r7/yM4oC1VujQRxoHn9TdQ5MW4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=OqyIVRIitB9Y8WOLp2pLhmhwcehU5S+4QlzNBHrw4Qc3V1T1i3OuMFfGOZ5k0AyEBiipT6vESAzOcO5w6oeO9u2YJcCXlyXLpQaNTS6tgRIG+hyrXb2Pf14A0r17JDNjOCcKn7JlOYrZ8CQsk2PbQD4IvVZfp8I5UYk5etFOb02EM2fAsTPSC7wTchlp/raxu65Rl+XC6aCkDP3pinbxg7LE8uL+3JyO9ypXwvbw3JZFeQ8ajJJ+UUcJXg4mp77m8lWZRPdsKvxqOp9X32I0n6mn8WlJjwR7lEUaT1MFgKsDGpy7LmOFcFaj0RBWRGwtwVen9arHB+OY8uEJxffJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YisiVg7fOCuNVM1Uh7g8hNGz/0665L6Rr78N0pXoPV0=;
 b=hpXda0OCv2jTW6sz/vDKJKpHUJJAUUl4vEaQnuwJ7/lMrSwJZ8DkknZ/4wCYStivNHzwO419La+3tpCkgV6KRXJlWT+jrTpVbzrkVtYWURSid1b0CMABIcRmp1+tlioQrQQRh+yrflODX4mWeJWyFZ+H8eTlOFcqr3CyFamPsXoGhkVnW6Bzpkj9NGgroAdkLRH1lyco9Z6RPDsj9bOLuQLZREmQwgOQCmNHWEEiIyyuzAZDboseuJOM37N0b9ZaSDejqBdUG/BXE6vJuRtHbn462HTcCtFuTTS7H0FJ9NJwKRaLdvPxXqgz2yPBFqO9lWfcuQ2kNTaxKiEElEdhNQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:20 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:20 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 3/9] net: enetc: add interfaces to manage egress treatment table
Date: Fri,  5 Jun 2026 09:48:02 +0800
Message-Id: <20260605014808.686024-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc04f2c-94e4-42ea-ab84-08dec2a41a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	j7NW2bpk9624Q0vXsjJTX/+ehj0KVqtDKtWMBpbP00dAr2BHh8K1TdEU8O+i6Xc9r5FS4P/wJAryznF6FxD6KrMiSgi9vHytQdjRm/Qy2eAvjVkbtfk/OZnWEX0NZZBR+K3WIGH/7YvLgJIEx4VHrkB6TdIpqbM/1UY3KXQkoCLcv3yJ4MiQXXfNe1op42LqWh+x+UHQhzU0cGtO/U5rEmfIGv/VcErVxdwIWIRQkugPSgWD3AL2TaZtWJApehRijUn965dfSdoGPZdr5uA7ak/TOYb2jDoO65vW4CXh7eIUgTraog5gnLbZKzIjBjdW2/MAEQrFyjzB5cUg7zrutWrf1VxZ9rhx7y2TJ1oUeimEc/GcPEdh/aVf14zzsZOOHKj0fvqhx4FRKfaBVf/wKwVkgl1oaBlWcyVRvkps2AjEb03gLp0w/fFgJBkoZd2FGLvEvv3lI5C82qDUwqTAhdFy9gvNMuQdwSdp6DNOZbWLsyQqdXgg4Eog4c3Vd1+izNBBv/6emvfuzD7qlGTL0l8DX6opdV2DgjDjbwf4iNyQUDv2rLP+M/Avmw8TVnA6mDM3ZiYYdrFwms0kZ+IwoO0a5Zu8My0ycJowQRDp26B1rbLzW+OspNeFZQ0IR6r3BqA91QVAueiBuQBarkBhAIl+OgWhjHk9rAX03jhvpUqq5KGGYouOlpC2fhmy+uktQubsjtZF77ZoXeAg2AKXBZamalyow9c8PksTDDC7HVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9t9pipWazoRLEaTy8QrQyH01760hnOio6I8BY0okWADB6QpKortU4Ez8S1n?=
 =?us-ascii?Q?euojNIEJxVmfB7gwHDINrxlZZgpjFd4BUjxyh83D6l+BhF1FQCU6nes18bE3?=
 =?us-ascii?Q?/BJpeCZayhgSeTPSz69pWqPOfN72L49iTHgfs5zlRcMwxj5o/KioYJ2L01k/?=
 =?us-ascii?Q?Ho3cDALQVcBO79XL4j90hTTIYx5n8dT2t92EnyCoQ2hlIQ0VsYtIuq++7Vk7?=
 =?us-ascii?Q?pfzEPGy6jkvN02vdZaIKbr9Oir1W4AOCPqBlHo2byevWDeE1aPMW6GeZVaJ6?=
 =?us-ascii?Q?TprjUgNTur0HcXkTyOY/AxgLSvgbOJ/p78YVLiBvOZJgmYfgfxx5Tsgi7aWP?=
 =?us-ascii?Q?hIkj3GnQ4+TLKHZn2U9iR7E9VFHsjwidNh4R0lwFdm5tLto4x06OZJ9ghdoJ?=
 =?us-ascii?Q?htEMUsc7Vk8k9ZogGf9CdNx1/kvPi9X6B/ROaZM5tZH+VceMv8ZujsxgBFDH?=
 =?us-ascii?Q?nXzofpr8uafxkkuSvpSbeS2Ro1DJd3+WqLWyQd+1ONFEsTeKA41WU5XheSh6?=
 =?us-ascii?Q?EIwmgPSh0figEzJWgS6GVqiFfOindJ5NubV5SFE1l63popXA9PTui+tY8pO/?=
 =?us-ascii?Q?l4nnCPLjniFUYey5n2OOLxBEMaa1hXCpXvDPzF6z7uM8twpHOfFB1ZpYAeza?=
 =?us-ascii?Q?zPp6SWBtZXL4ifvgzFD9lV9BY/tL1X9CGLrq89/I5tnDdOd+pMwBhNFab+UQ?=
 =?us-ascii?Q?Y7nqdAO392tQ3Z4kTrPi/YVvp0nuRAbdhd2Cleve3XDPwYDg/wgw8Z7mW+mX?=
 =?us-ascii?Q?aqX6ppdTDCOqG7padprcNnYKb3WinXFzAnnxpi53A+sgkwRCbl3QH2IGKaQj?=
 =?us-ascii?Q?9R6qfrqPjkcMuThgg4+IDWhxNQ69DI/JkjgaadazybDbNIw22GW+y7oClHmn?=
 =?us-ascii?Q?oG3DeUDMpKqO5QqgYKhHyZ/1AXctJSNq4OYUihKm4HJW6sNznom0cYpX/MhS?=
 =?us-ascii?Q?1ZScFxD+UTHSXLL4FzS2bc4all2kK+6i3LqtIP8S8tin2NKzuS7KSo4Ikch2?=
 =?us-ascii?Q?hJJUqs8OiKFFZ8bteRb7fWdVaxw/+PZ6An+D8V2qs7wMsPeLKYPVIk+gUCnd?=
 =?us-ascii?Q?8NWWzaw11EujnJQGMHFDQmmaz4/DpuWP1IsIy8rM0hY4DXicIY7qmEDm+xtU?=
 =?us-ascii?Q?gt1IWYgvSgaY6jIhHhG4onLYT/Mg/nLJ/xURJGhGXXrPfl0xQvFpEd5HDmDT?=
 =?us-ascii?Q?0sQAza7qvax+6t/7X9JM51KULOySkdjW4lfqeu6nl+v19qCSVe0OQ4wMaKYH?=
 =?us-ascii?Q?DSEJ0mtKo15QX5oTBHb7cppQ43hHZuZJLpBwei2Dxfdv+9TNNfksnWXX7FFI?=
 =?us-ascii?Q?YdUAGKK5NQllbGs1nUJtUj6ufU5t3jnIKYPceUEe7b3jbedPn0SRdVqqXwTf?=
 =?us-ascii?Q?ZLFlr2xI+T5BINdh5nLedcBgOGkBlB6DEOR9cznprMVMCL7MkN27Fi/gmbvb?=
 =?us-ascii?Q?kWGAEWmYAfMznlCYnulDOOWEOVQoB5qP5VlAUfrr0nXiSgJOZbzKk4qxUr/8?=
 =?us-ascii?Q?rwAllS1ZkDp6BcDrt/E0y0xRAfk2sDXT/i8fCx2cojmH9xlI52iM/FcbFqHo?=
 =?us-ascii?Q?mVd68RghvZQ4WTtWnR3TX5X4JIruz1FJTdob5Hk5nXRRO8UUyuOr+d++BmWr?=
 =?us-ascii?Q?zr/si4fj/dzA2iA3KK4FaTN6Q2I3yzsbfJRLOB1HEkGVP9CejE9pqf5ArbKj?=
 =?us-ascii?Q?WC4colJioVI4ktM6/KXw1TVp7DwDXLThhKNKfvzmtJaU8xwC1VQOKt2jqtxf?=
 =?us-ascii?Q?oeyvG8jqnybH9rEHofcX9Ss7T0uCtEOTt4Nf28UcP1N5BwCry9hp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc04f2c-94e4-42ea-ab84-08dec2a41a37
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:20.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA57LpQfBLFMzo5jvutJkBj428wLeeCM4KwmjWdqQMlgnK1RpEqN4AOKyNn2ff+7VxcVamUrKUph5jJM6REN00SmPpcdljDwBs4QeIi0tu/jFxvuyZmr2BLDCNFvFWrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295567-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,oss.nxp.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D82B6448A6

From: Wei Fang <wei.fang@nxp.com>

Each entry in the egress treatment table contains the egress packet
processing actions to be applied to a grouping or scope of packets
exiting on a particular egress port of the switch. A scope of packets,
for example, could be the packets exiting a particular VLAN, matching
a particular 802.1Q bridge forwarding entry or belonging to a stream
identified at ingress. The egress treatment table is implemented as a
linear array of entries accessed using an index (0,1, 2, ..., n) that
uniquely identifies an entry within the array.

The egress treatment table only supports access vid entry ID, which is
assigned by the software. It supports Add, Update, Delete and Query
operations. Note that only Query operation is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 106 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |   8 ++
 include/linux/fsl/ntmp.h                      |  23 ++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 4e60bbc38cfa..9249f78219ed 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -24,6 +24,7 @@
 #define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_ETT_ID			33
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -284,6 +285,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_ETT_ID:
+		return "Egress Treatment Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1091,6 +1094,109 @@ int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
+/**
+ * ntmp_ett_set_entry - add a new entry to the egress treatment table or
+ * update the configuration element data of the specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+static int ntmp_ett_set_entry(struct ntmp_user *user, u32 entry_id,
+			      int cmd, const struct ett_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct ett_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.ett_ver, 0,
+			  NTMP_GEN_UA_CFGEU, entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ETT_ID, cmd, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_ett_add_entry - add a new entry to the egress treatment table
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_ADD, cfge);
+	if (err)
+		dev_err(user->dev, "Failed to add %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_add_entry);
+
+/**
+ * ntmp_ett_update_entry - update the configuration element data of the
+ * specified entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_ett_set_entry(user, entry_id, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ETT_ID), entry_id, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_update_entry);
+
+/**
+ * ntmp_ett_delete_entry - delete the specified egress treatment table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return ntmp_delete_entry_by_id(user, NTMP_ETT_ID, user->tbl.ett_ver,
+				       entry_id, NTMP_EID_REQ_LEN, 0);
+}
+EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 9d30f128849a..531ea7ddd145 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -217,6 +217,14 @@ struct vft_req_qd {
 	union vft_access_key ak;
 };
 
+/* Egress Treatment Table Request Data Buffer Format of Update and Add
+ * actions
+ */
+struct ett_req_ua {
+	struct ntmp_req_by_eid rbe;
+	struct ett_cfge_data cfge;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 36a9089526ad..0c951e1c763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -36,6 +36,7 @@ struct netc_tbl_vers {
 	u8 vft_ver;
 	u8 bpt_ver;
 	u8 ipft_ver;
+	u8 ett_ver;
 };
 
 struct netc_swcbd {
@@ -214,6 +215,23 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct ett_cfge_data {
+	__le16 efm_cfg;
+#define ETT_EFM_MODE		GENMASK(1, 0)
+#define ETT_ESQA		GENMASK(5, 4)
+#define ETT_ECA			GENMASK(8, 6)
+#define ETT_ECA_INC		1
+#define ETT_EFM_LEN_CHANGE	GENMASK(15, 9)
+#define ETT_FRM_LEN_DEL_VLAN	0x7c
+#define ETT_FRM_LEN_DEL_RTAG	0x7a
+#define ETT_FRM_LEN_DEL_VLAN_RTAG	0x76
+	__le16 efm_data_len;
+#define ETT_EFM_DATA_LEN	GENMASK(10, 0)
+	__le32 efm_eid;
+	__le32 ec_eid;
+	__le32 esqa_tgt_eid;
+};
+
 struct bpt_bpse_data {
 	__le32 amount_used;
 	__le32 amount_used_hwm;
@@ -271,6 +289,11 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
 			  const struct vft_cfge_data *cfge);
 int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
+int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
+		       const struct ett_cfge_data *cfge);
+int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct ett_cfge_data *cfge);
+int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


