Return-Path: <netdev+bounces-295733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ixN/C76RImpQaQEAu9opvQ
	(envelope-from <netdev+bounces-295733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:07:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB18646B1E
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=jpqhNFKs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295733-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85725306CA0B
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EC4BC02D;
	Fri,  5 Jun 2026 09:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436174BC00E;
	Fri,  5 Jun 2026 09:01:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650083; cv=fail; b=ShmG3OUEEfPKM499idHzAKteQM8N75jar/F6ZDkQEOmxo2ckEWb71Ym7jWcoO1Uv6IR4NRLxpu3AJkgpuY9iDmgORmfUL46Wmj78pucqfEZRLw0w6exHoE2KPI9XVMnKCRwlPYQ52PlfhSFhX8+uWYjUFLPXd9T51CgGZj5f6pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650083; c=relaxed/simple;
	bh=aPn/8lSIhemSZzwOo8z8Etet9Med20jwY+CbdBMFOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCd3gsFdtdT8//cf2yUiLGzJsanCWTtRop6Z8O3cLfMF6B4bz/GX/I8LXME4YBqsU76pv4mA9v6c7fBjdsQJmM98jy2iWuLju+TS2zaZk8WUSVTsWHfSzASBIg5C5cTtM4XvXvW9AUNXSK/UpeT+jDnMnsEDUEp5JYTYe4P6H3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jpqhNFKs; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0R7KMoTBrAXKhKkOHVEWw3Oa/x03mW1qbxnLvVVoVx0tnuKmg442u3xLmgoQ2+nABUmC3b1v0pe7QqDA+ggTAx5JOm2Q7RcAq/5QJaPtoqQt4HLxKhBrWJ1LnAk62+xbwfHs/Nv9yITtYx7BYeHIm9RVt9wrtRusmcwhqbIv/SJOrIFWD8kl+ZrtNDypLM1t8nB3vawvDu/47OGgEeyMOd7iSOO7r6IMwdKFhs+YU6WV1xcLLl+QqTz/eS0ZfY/FfqE3RXm2P1vvZF75gmkzcG95W7l6oeXjV/VjTXYB+h5hdH78MG9GvcxT4k+xLYaGAXIiB8lIqWtj6fgkh3Bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=tk9B8abogXpbw7tajAIPbAuLn2W6o9XpZ3Ad3o6Qgas6NcXQ8yPVvyYNCYPMDuAUROVfsvbFErnXHcdeZxg3RGoJ+/aOgEobC5FQaXshsgZ6SE9Aa7Rbw+jtFox5GPFInD4MiDGVk7eXqmBvhjutcc1s6c4MkagfZz8SpVbaivPyN+FJFnkCHWHGBmYm6jZbz0vn3uXN/SKw7i8rpUEx/CgVcnINmhc/JxlChlAerS5u1gpFPNyJbNFWYg/Fj1oDWwrs1fsDZ/fekeJ1tWZCdoNRVQCoJOmpuwWiLPftN3sqFsjeEhV3Gdc/LxCrRdHE/9UVv5YsXSNcvG7WgdGeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=jpqhNFKsmIRej2o3EFgrpykGOhd9SWUoO0g0Qo71Ugt9dGrIyx6fubGdqsHaO5czk5fBp+evC6uJlBllLJjmStkGlUvh3bW1uLmjGAAcR6gcLqonzr8IirJbQ+/wARYmWPWonJ4EOo4Wecn+56RyzajuujPnMS/x31vIwiWnWzmCNaN8rJuOpjrGyD9YMc5rQwJubdwx266VyNWX+Fr5+d6JYEo9tVZrB5mphRdY4XhTkTmZwX/CgF3xeigF3QBMjmbLJMc90icJYaUdMUpoPCXDQpWyE7XDzlQJIl2EXmgF2HRjHRd8RYAbIm6o4b5Vafwg2lsG5c0J1L9Y7PSrmA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS4PR03MB8472.namprd03.prod.outlook.com (2603:10b6:8:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 09:01:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:01:18 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Fri,  5 Jun 2026 02:01:13 -0700
Message-ID: <20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS4PR03MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dcb526-7ef3-4a37-29c8-08dec2e10116
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|6133799003|55112099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	8YMa+0mXOkU2a27JmmYaoTYJQNiLmhwiIY6w+ZvtHu8clE6wiWn2RyLRK3e7lNLgPvxnYiMMLQn9zpU6HaFb5YY4l2IvUdjlH293hq6+PjgRj4uOqleCUvhnH3yCL6nly44I0ApZGOUbzS16py5O1IhW1Lm2C64s/B/FwbAaZeqo1A84pVba5WaNzsVIPquQqNFgfPMf9U3WfeMIk72lCIDBWEynQM3yuuu5ABIxBMuFzw6czdeKGyqWAYlYSp526hvooGG0XZrBggvZ1VTiwC1S0ujwL9JAQ0jscADlwax8mRzXCgs2lR1uMyANhqbHUE9Q85B+kyadujJlnPdaXEa5JPjZFmT8t54RTqgB4k1RENivZ/NjZ6jFXY5GZbs9r02geekIVpK7ZU8TdwxkSfQp6JgTB9iSpJjLnXD+jhTtbQ4KvI5efN95zGLBhBKlHoNPu/ZDz4tP7u+CuTNrel27g3df4unl0U5RyFAiQC8d0wABFN49vZwXxJa8DUWxrMCf3g3Wr16zjLRN5j25ctu4blEw4CNOfoVM/RAvyWylKfu+1sX531ZS2yMxYqv8N+CmlgteyQCKuwRjIV5ICWzqdhBn11DK2UIyNtej760AHR1RJMjJQ4cfLe26zS+I69fbHPa6Njp8BExVr7nI7D8yP42N540OZO3gk+4DIfbRtZ2LgoImYgIhCLfrs5Tv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(55112099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fpn9rvQT5HRYFzwNlOkvxKEnZXSu7CaVw1cePAXBjnyvF8Ne2T9/3NwsuEPI?=
 =?us-ascii?Q?tNEhHHBzAZroO4pzQCMLQ7/sM9g3IxcRMswidUuK0gv02deO7ZV8T0lqcaZb?=
 =?us-ascii?Q?ePVewcaNq9ERV0hlRwRiMkH+ZjrcaOn038vhsFalq4dVZbcpsV2CZVv4/e1A?=
 =?us-ascii?Q?AR8wvJxYOhA6CoEBgSuXbEx5As259aYRTeYHNsvTABV3tgUY655KeCjnmcpw?=
 =?us-ascii?Q?PThkVDFrVo8pzGg7602GBnhcpcRzSok9DgOSjrCbqguz4ymb9G2tUKFhdu+I?=
 =?us-ascii?Q?Z6xA9t4PhOSyaUjEOAHOLzK3jafhp31dJkBYDF/dQbxrObOpsL+QV0nc7sN2?=
 =?us-ascii?Q?gTPbwtRZikzmn15Bncd9tWwQBgrlR7g/dmiIKthAdoVnrJqAzCambGMmRq97?=
 =?us-ascii?Q?AwGKHFVfiEJahaoEwknvHlsEKlezVhnsrWQXLFDXvL6uCvP9hhy3/CSOc8kJ?=
 =?us-ascii?Q?gwQnz5VB8NsJW2BfqwyYj6apmbcWMCmlRLQfT/RIhvYhg5V9VcRJe2NwDgA6?=
 =?us-ascii?Q?WyDPV390MZX43MPWcn+eUP7U2mXvB3T+lO972qps+nvHn3DA1KouXUqceGzL?=
 =?us-ascii?Q?uocFyQtuNvFHKvyNL8iq5LVLIsBqnc4dkJijW/W+LTGFBDFQmaeaxY97qaEQ?=
 =?us-ascii?Q?kNdnxOV3H8A2ucwKFqANIU3zKF5DCJuONbM6yKRzkNLBuRwc6iL4PCpuoGkl?=
 =?us-ascii?Q?TyAddlmN/SJE3qmh4d6zA/6yu5lpS6icBMT35ZevX1FTH6gllwem4d/EF990?=
 =?us-ascii?Q?cXQNJ3PChX0zmkQzwOgbITgePmbXH7yfnjUrFU5ohvPH7Oowmfi2RKDykBDz?=
 =?us-ascii?Q?go6Zr/fbXAxCoZSjg4BuVV1ChJzgV8nyUbWqwwuu4VjTNogYbluzleVDyTWY?=
 =?us-ascii?Q?pDZaj34jggQlg6omN5sXtkQ18bvfq/SV+jv96XYXW7qrxiM9TL0ijOl1QQ6E?=
 =?us-ascii?Q?LSwCi2gWnwOLjqqWdlsEMZ9yIuHriM4F7KKrnq74cVeoX4axCzv7n7mfVNMf?=
 =?us-ascii?Q?drpSK8rGVrZq0j9KOqQouIk4OzAIotNlcZ2MVDfwx9XnvhT1cJpJ0T9SS7H8?=
 =?us-ascii?Q?vmg5oxdHkf7LUydx+uMvEVc1e9frs0HkgLjNHnaSe1SJfkm6MyvA+CnkKq+F?=
 =?us-ascii?Q?2/BwrzEmzoI64UYTYxXfwh09O1HjUwzs+/7DZUiZHUZ4iKgIVkOkZvRxqdWr?=
 =?us-ascii?Q?XYT/cIq2Dmka1zOJDWGwv6ZB45KAAxiFjTleT4vQyTlqM+hVyYLSZcOYX5hD?=
 =?us-ascii?Q?6rVU6lVeX6XHUyL8B4nnTN9GcyrLv/voZR7ACdK6PUjpv8BjZ1sl1RmCBDeD?=
 =?us-ascii?Q?EITZY2fXL2ifzasjmaqH4Jz8PEegyVa62m7hTBzNriKfqQyyx27WFx3P04bi?=
 =?us-ascii?Q?bE1Wc9YL0rtT87v6IsXknn3zKoYmmaSk9OGcgcM8x3kqkaDMFPXZl4+Zqq88?=
 =?us-ascii?Q?eMqKwYtiTIEdFwtrvvQrIQuSm/Vn7i2IFxrNjD4i1j3KYRv6DI7Tz01nVW3g?=
 =?us-ascii?Q?fIbs3Azhxsohdp8vOXzLeRMhZgTR3F6wgiiVNmKSx5poD80pNU465D1kpJIK?=
 =?us-ascii?Q?D8vZzMb7dDj3Qh+0oT/QE63hk5Qd6XEuFPQj0nfyQ4Ox9mGlH0znm5fDF8O1?=
 =?us-ascii?Q?B+SxzKFku0LsMtwc9JyrPG0LDKfEGRs4j7Gv3mjBfxfUGUES2VxOhMcHDUEU?=
 =?us-ascii?Q?8/IPViKbmcqG8ubUPQM9Svf1li6D05POA94yet4YjUOwZTbYlulSJ5LPq5Ko?=
 =?us-ascii?Q?XcQ/7L7R5YypvQ8G17qgMvZW54AKezyYPjoZswRaeehNOVX+otRx29Ym9+x3?=
X-MS-Exchange-AntiSpam-MessageData-1: o/ctdFpmyQrXMQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dcb526-7ef3-4a37-29c8-08dec2e10116
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:01:17.6647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mF38YkZh7+aqOBiX2S/hPG2eZnGeMiCS5jCoqTVawf2Qc/JuwsoWc3ZlGJ/mtCYYBJgPw9QU18XwpSqw5hM448X1SVPdMgyxOQRbaEGtNSwwshyw/gEl7DgClWMcy1C7Ec5mrrhTb+0CIRp82C/AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8472
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295733-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFB18646B1E

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The basic flow parser in tc_add_basic_flow() does not validate match
keys before proceeding. Unsupported offload configurations such as
partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
proto are silently accepted instead of returning -EOPNOTSUPP.

Add validation to return -EOPNOTSUPP early for:
- No network or transport proto present in the key
- Partial protocol mask (only full mask supported)
- Network proto is not IPv4
- Transport proto is not TCP or UDP

Also propagate -EOPNOTSUPP from the basic flow parser in tc_add_flow()
to fail early rather than continue with subsequent parsers.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..869f84756ca5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -446,6 +446,7 @@ static int tc_parse_flow_actions(struct stmmac_priv *priv,
 }
 
 #define ETHER_TYPE_FULL_MASK	cpu_to_be16(~0)
+#define IP_PROTO_FULL_MASK	0xFF
 
 static int tc_add_basic_flow(struct stmmac_priv *priv,
 			     struct flow_cls_offload *cls,
@@ -461,6 +462,25 @@ static int tc_add_basic_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_basic(rule, &match);
 
+	/* Both network proto and transport proto not present in the key */
+	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto))
+		return -EOPNOTSUPP;
+
+	/* If the proto is present in the key and is not full mask */
+	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
+	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK))
+		return -EOPNOTSUPP;
+
+	/* Network proto is present in the key and is not IPv4 */
+	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP))
+		return -EOPNOTSUPP;
+
+	/* Transport proto is present in the key and is not TCP or UDP */
+	if (match.mask->ip_proto &&
+	    match.key->ip_proto != IPPROTO_TCP &&
+	    match.key->ip_proto != IPPROTO_UDP)
+		return -EOPNOTSUPP;
+
 	entry->ip_proto = match.key->ip_proto;
 	return 0;
 }
@@ -598,6 +618,12 @@ static int tc_add_flow(struct stmmac_priv *priv,
 		ret = tc_flow_parsers[i].fn(priv, cls, entry);
 		if (!ret)
 			entry->in_use = true;
+		else if (ret == -EOPNOTSUPP)
+			/* The basic flow parser will return EOPNOTSUPP, if a
+			 * requested offload not fully supported by the hw. And
+			 * in that case fail early.
+			 */
+			break;
 	}
 
 	if (!entry->in_use)
-- 
2.43.7


