Return-Path: <netdev+bounces-255519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AVaNN6BfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206AC42D8
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC16305C8D7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C838A9D0;
	Sat, 31 Jan 2026 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eUcCrqG5"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C638A9BD;
	Sat, 31 Jan 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898348; cv=fail; b=kl+OLnN2PxS3AHGj1Qcsn6X24jAJsriv9iH3AGaFJHX6yXVSZ3A3m6KJiqS+dHqRmoVflNBOkj7zWTNsWUH3tJ5loOxMKxhl8TvPfcTgunR1t6LJuXBNpZSD64WDi2lbdbLY1WGA7i29ztSP9zceJ9iaRH0Q3G2nCktvVDR0P0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898348; c=relaxed/simple;
	bh=3jBxuQwlN4etj99oEhN5czPFXQD85y88GTljTeMJrH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSpB07vK6vi5KU0gpfP0ddKBd0S0uefpmejpH4IL8O+w8bJBKxYC3aY68DgY6ClHLOtJD0iSYj5OYhkw8WR07I67JME1LZIVxLaDGkj7GPTUt+LMFihAu9/Bkp+3ylJzO0uiKuQlpW91KdVI7LsR9UTHpKx8/m5gfxMITkuj1fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eUcCrqG5; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcn6quF4sptgaakwumVoMnky8LSjNSYMmW5pk1drrMdTqVA02wDe8DPiM0/KHi4fgArVId6GCiz+Ufk60VJNq5NQq1JtQ+1hWA5NCU2j/DvnsZxk3+Z9cSG4gTZ8EYY9gtWSYU8TOVIfJXjuH5oqk3o+ZoV2WmZXvI5wtNxDPOemn1FHMbkebmLqrtHAVBPcZz2FAccN2IAbtzB0JSfK3GMhOtrXlL5vVmzw8z87uMUAukSnbjsDobyYgRGo0R7MEbd67cvP2Ma8pRjOGJ0f/NapE6SaxxxHkgOkN3enbJ+fJ04mnBDOx83hiNI7CMfB7gDGZ06v3NbNT8NVYEELcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxtYNkPwrFb6UEaHZOkTdemZo/8GR/gXcnrcBQdUvDA=;
 b=WiWZh1M3OafN2aONCfJwbHDjlYp9Au4hntZjLOiKKkBTgHDumDv+sDiqwaq6H82/YqDOXh2vxZ22yx0mtlyuMGNHY6GqdSS0URazcQUg/0AUBm78tpz+sRZsGFPToZpxE8Q5ZZKZgk+61TivnLILgQXYzkUkNYJ69zC1a8isgibBd8YWcYe9VSOCbo7giqxj9lix3ycteUFqFC/d8In9LyCgZefyYJE+Rst47XVzCFW59R5SnP+hiHB8SFKLUbJszA8wcod2S52UaCQBPCqqmTtMwMxnoVVhhAnSB9ThJ1yACsogbUJs/WFHnNs8yrUjB9wxDuw/O+9vObQ5JulMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxtYNkPwrFb6UEaHZOkTdemZo/8GR/gXcnrcBQdUvDA=;
 b=eUcCrqG5gCzMKtvNqNSEbcXybnVW/OBk2VNHtEauO9AUs/5Jd/fBSzkBT55c90ZaPQV8e9jXD0qQYKmFDcu332HtNtnF2UgXxlVcwC1irjisCsaN5fpFK266WSwBSDqfrA8GDFNAof2F/IyVvh32PW9cNzuACk/6vdGWS65hqVJ1cxnGp5CDdYnP7gdOp2tu3P+t6ZRC/8yf04xMYH4LtnpQIx7Wi5Rosb1DXUiunQhEmaEX0SifC+T3RhDCJ5VAPu7KBXy3Ele4wGy/i5p2ApH07ypLuyzt1MgEMfyQuXhcsklUY0n8dEL7z8APQs0FjuZIIoTeHv7HqI/FyH+AFA==
Received: from AS4P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::11)
 by GV2PR07MB11270.eurprd07.prod.outlook.com (2603:10a6:150:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:39 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b) by AS4P190CA0018.outlook.office365.com
 (2603:10a6:20b:5d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Sat,
 31 Jan 2026 22:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 745CF23993;
	Sun,  1 Feb 2026 00:25:37 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v13 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Sat, 31 Jan 2026 23:25:04 +0100
Message-Id: <20260131222515.8485-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|GV2PR07MB11270:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a63b8f-8597-46f7-a275-08de6117a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjR6aEE5L05IL0JPTE5KNnVTUHJGN0RVam40dDVzd1RXYTh5T1JyV1FjTzRJ?=
 =?utf-8?B?UkVlMFB0Rm1sZExhY3MzOFpmQXE4dVh2eFhPRGxPY3ZFa0hJek13NXlqOUFU?=
 =?utf-8?B?WVNMcmUwalNzMHB4K0Z1aWx3U1Y2NGhrZmJPaXlPMUdWajNJNXR1RWt5RDdu?=
 =?utf-8?B?SkFNbTJhZk9Xd3RWSzVwVy9EUUhRT09mWCtoNmxUajMyeEFZVWlFUkxhNUx4?=
 =?utf-8?B?enBteUFGNlRHK0dwNUpwdzNRUnIySzBTbkYxSW40NzJYYVFIV2RXSDJBeklW?=
 =?utf-8?B?d003c1JoM3hKV2RqL01EdUYyazQ1aW5YV0Z3bjJqTjhpMTZIa2JYbUJ2NTdZ?=
 =?utf-8?B?ZXA1M1lGU2tSNzlLd0VsUkJxQUxyMjVDdXlwR29GWVBuRVlmU29Qb1R1czJV?=
 =?utf-8?B?ckUzbHFJRnM0RjQ1bWFYR2NhbEVIcDVrd1NoWHVkYmcxaUFTZVROdzlBdVBi?=
 =?utf-8?B?UnJ5c1k0VHhINGRPMzFmWDFZZnEvdFFselJIOUNhbnJZU0lpdEYwbXJFQWtn?=
 =?utf-8?B?SVhKQ1hBWitJZWQyWVA1T1NaeXpxNUFnWHhlcm9xeGhieVptUDNLSUxqMnBK?=
 =?utf-8?B?a01RTGtqWVB5TGFtSHVSMU1nc3VpZFBEeDZPZzNFMGhHSEhRUzVPNjNtaE10?=
 =?utf-8?B?cFZFL29mbE9oaG1Pdmg1bmlVMy9aSjB6NE1uMHFoTW1rWVlnQ1FRd2s2YVRQ?=
 =?utf-8?B?aSttZmFic3Zvc2VYMU9PdkU3RjQ3TFZDeG80cjBiQlNSUU5lU09CMjlLSXNP?=
 =?utf-8?B?N0hWK2RrZmNHOHFpZCsrd0IvZWlPY0RIU1VPUmlaN3g5bzlBR3FvQlVBU0w2?=
 =?utf-8?B?ZlVWTnBoalhRZWdGNmthNXBhdGQ2LzNsb0tucng3N1V0elM1SjRSd200WTNT?=
 =?utf-8?B?L2dUcThqc2dhL2RKNlc4Q0pjZW9EeHh3eiszR3VmcEVON2NOZG02UUhRQ0w4?=
 =?utf-8?B?VHlJYTN1cWtBcXhQa0xzSkpvNitDeFFPN29NS0hjaWNHbHFPOXNMMU5LSmV2?=
 =?utf-8?B?d2pDeGJYQkR0V09SRnp4U25DSnoya0VoeDErT291OGtldml5ZFJ5YmRpYUxx?=
 =?utf-8?B?bDQ0RnAvQ3E4ekZrVEdJUHNlZlRoSVhnQVNtbTJKQ0FvekRhTFloM0FESU15?=
 =?utf-8?B?cXNhVmtIZ0Fub3VxcEswNUx4bGNjM1ZRZ2pwNTFmSUt0WnpmU3hDMzMyQkNn?=
 =?utf-8?B?ZmxTY0pCRzlvUERFWm5GVmo1VVF0RFFFSGozQlg2SXdrQXZDKy8wSDc4bU0x?=
 =?utf-8?B?eFd4Nmp5RDlKRWNIMGpJdTJRZHFqNldxSjg5UDhCTHRPWWRTRkNkb1MxQldL?=
 =?utf-8?B?aFlXVUdpK0VFS242aitjRmU1OTJ5bjBSdmU1b3dkb1R6QXFMR0dlK1pIeXZ0?=
 =?utf-8?B?K284cXpKZVVtNGJyMzgwRXZuSFozUTZOc1kzNlg1N0I1clVBZ2orNnQwZ0VZ?=
 =?utf-8?B?eTd2UmJCeWhqUGVZODVBdHJvUThWMVRmb2V6RDhvSmhhdldONFppMUVXTDJj?=
 =?utf-8?B?eXAyMnlleGRVeUtiZ1lZVmI2OHM0ZHFmR3hJbEFreFpMdUQ2V2dVMVVIay92?=
 =?utf-8?B?OXYwdHBrcEZ2VFd6R01uZnNSdGtBVzJNSFdRU1hjL3NxbzNDL0VvY1B2THRT?=
 =?utf-8?B?cmE1aGEyOGlqVG9WbXhOeDZsTVN6RTNLTEw2bHZodDhYOFVnYUJIYWptMzBK?=
 =?utf-8?B?aWZCVGNOeHdSRVJaeTBhb1VxaWw3WEhFS1F3dXZ6NXRBd084SGd5aTcxM2tw?=
 =?utf-8?B?NzJLZ0xqd0M5eEY0cVRxNmRGUFZWN0d1RXJoOWlPeVBWbUtBNVpCQk9pb21E?=
 =?utf-8?B?K1dSc0JtTml4Qy94Vy9keWI1L1RtanR6WitpUzRHbXJka2srbzlSdmxEZFJi?=
 =?utf-8?B?QW10NjhXNnJLcHRYSG8xNEhBVTdWWVV5K3FkREtLcDRXc1BmYWtOVFJXWFFs?=
 =?utf-8?B?RXBneHNEUURLdWdDRjFNOCtYTHFzdTlwZnlMbk5pTzRZRHJ1YkVwSzc2d29V?=
 =?utf-8?B?OXlXNjJhUWdPeTVFcjdCTi9yNDFDcFhFT2ZWUUE4Z29sM3BYTU85cThoUmpN?=
 =?utf-8?B?YmhVRXNoZnMybXVrKzlyaVdnbzhyWTFXcUloTzFjWUNvNWhxdXF4TEI3bFh6?=
 =?utf-8?B?NmUrajJyc2NUYnpKNVpiSTZWNkhFODN2N1BwRUJoRU8yV0E5V3RaNXJDaEll?=
 =?utf-8?B?VDBKQVl2eHJJK2JtRjBmUGE1MVQwUFBhV2dva0ZDVWJ1V2ZZUnFMQ1kvTlVL?=
 =?utf-8?Q?jjaWE5LlI7r0Bya2DgBrptqCHiaEmsaFhBBsjAUA1g=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zGT60QyBYEohkHSaf3VxhVkELBeUdwddBLzLbkKxm5zX4OavL0DFVJMoaqbZlxlM9LO98XsdnAPjY6EeXHyB2Yz/bO/bkBGl4G1ngFtzAH/ghO+67z4ejFrW/jB4F6FD61YtO6ULz26PntXUvxHI5GENRjlCNGoFv+jihiGsHd12QMTU77vhhfjX4axxkW62QAwenHtg7f1jJ8V+PGj3Hy4r65Hm9ERhxjCe0/G899AuEUmdpgaq4RLvUQdxJCmwXp6Nfo2tFryxQuBE211qE7wqXbfZGsbj33lkDAblpJnFQvfqujH7nYtz5sLQsd6tb0+egQJyswCPLYRvYGDDV60rmgZsG0Mu3HYu5GBhcGJpo1VLZIj4YmCLGiQYvtazgft2F5hI8Nas7bk4olghtQOf+4MOXzX6j+8dJnqqtuxvxIEckSGpFkwudHEs3Xq1
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:39.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a63b8f-8597-46f7-a275-08de6117a9a0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11270
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,nokia.com:email];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3206AC42D8
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two flags for congestion control (CC) module are added in this patch
related to AccECN negotiation. First, a new flag (TCP_CONG_NEEDS_ACCECN)
defines that the CC expects to negotiate AccECN functionality using the
ECE, CWR and AE flags in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This
patch enables CC to control whether ECT(0) or ECT(1) should be used on
a per-segment basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the
expected ECT value in the IP header by the CA when not-yet initialized
for the connection.

The detailed AccECN negotiaotn can be found in IETF RFC9768.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f1cf9e6730c8..90a89a5b256b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1204,7 +1204,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1345,6 +1350,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 38852e04229a..e823a3b1ad3b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7495,7 +7495,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


