Return-Path: <netdev+bounces-294647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7N8SN9/bH2ojrQAAu9opvQ
	(envelope-from <netdev+bounces-294647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF86355BE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:46:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=nhi4aLMN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294647-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294647-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C9A330EE23C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53A41C309;
	Wed,  3 Jun 2026 07:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7D40F8DA;
	Wed,  3 Jun 2026 07:29:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471789; cv=fail; b=XsE+kYmnUvrKYKgLqtDegzF98+CgvwvG4AyjIcGsZCdrkjjuaiepMU7qlKh4Sh5mosgVOuF4OjQVUJMc5n+Pbz5j+UvS1sjrnUUifPXmELrNqBY1kgiwQMW4KUPTcz0WqDjcnkliDfku8q2XKWy0QQfqMp2qa9Yq8Tuf6VWsZ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471789; c=relaxed/simple;
	bh=aPn/8lSIhemSZzwOo8z8Etet9Med20jwY+CbdBMFOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqAmx+EU6tmtHZ/5+JYUO5FSx1KxxPXjuppxQi2AogoDbpNyt6T6Oq1uIasuQfNR6fvt8XBt1vrbpDvX9w1TK87hWUbZzS26iovpoXdIVnKyAi+89UsDYae6IvfJUHjhr5L6uTqPLhB/tKni5s0mOYOOVnAZr1jvm6ph+1du98I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nhi4aLMN; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHIjzkzFQ/r0i5K5gphFJczq/AlaLUz8NG4DlrMpZu5FAbuVVsHDjlGN7t0fy0NsFfwsets1uwdaiTftf6ljNvXRPBQQWeat468mI5A4v/6o4rkqF22jCmM/jyFO5rYIJEPR7q103EPcxGxw79MOnvl9U+ASY0tdFYfURm9Uw0WV0dO5v9/6fj8ezlAufPtNWsja080pOfv85RgeMI4yfhrhmBlgspDcseMrKViSLiIMI6mdlTyARAJoFY4ZorULY5GWbPmh+K2DosG1mEdiROv//Hxh27p+nvw/xsp16PfAPvadpyqRzkOg/zKhIbN+FoD28go6Q8AbTlt/GfIXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=S54KYvyLpNgfTjGXZNZ37P5Xs+fNxvDlO7IPF7YT6Fi4jB1UAW24c0VuuvEhBvgZa+bD2W/WLYriAzy7iqyzImxruae5lmVg3nJkpw+7KLJjt3Aey1YfLZHEWIelj3zsucLwnHgmGR+x6PtImVsA92ZmhMa6RJOk/daDqXqYuQTJYq6w0r3WzoEEfMSSLQoMrDhzD3+qMOVNtwTmxjV5RlTK0Yz7toOuWk6Eppqy7Te3aVrpj1IxI6I7cJb/IYTuSXRN9wi11Um2wOyd2tveTxE6pXkIyeInf99ac4u29pl/BIRLYOH1k7gofZ852XxbAFVgsFdT+Hq15Cmx6HqkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNSBByl0f5m3bkbjfxqX4mfNAWXpKVD66R9cmM81gMY=;
 b=nhi4aLMNtvyxp09hQINgkVT7NmqAfgoDd9Pt2aYlGNjKeh1pqO3lp0JDupSL5d7Y2vzGwKoZnirtFxYRv078w/0vomV0+f70VyhC947euppJ1DCb+Fmh8d8kUrvg6dLwISedABeHxcCQOg+EsdRQKH4lBpyOLkCzFPMyKJFp/F8jQFjn4LFgrppWRUv12CAx2wdvB3SQQEzw+UQe3ItSt/LHV6E2fknSLR8b9qzB7YZB6l7yxhKnHkyAJu6slRJPDQ2By6aUEVKKcVKWXC1+JJP0eIURRayRZnmSbYD7LGJOb9tr3DVSVf5VzKK0d0jTpxGombNKhBL+yqxDSHwCZQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5813.namprd03.prod.outlook.com (2603:10b6:510:35::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:29:28 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:29:28 +0000
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
Subject: [PATCH 2/4] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Wed,  3 Jun 2026 00:29:23 -0700
Message-ID: <20260603072925.27890-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb0d433-8817-414a-2cb4-08dec141d8a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|6133799003|11063799006|3023799007|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	agMXTYSYs7+w2TA+kTI5ppqX6EHnvNXV3FFYo/omnlMGFBcF3W/u/zDXU06QTBQYPy/MB9GIUmVvQHZuo6/vQmXyShREKHv6s3iLs1N6NpT1eb8DZibYd2u600USIAcxKGYcyOCl3nJ0GAtJSgAVPZlydHrYuduVhak/IXJhdNbPVpbkU6ms+JqqrLTK6YbF1lSpeH6CQHKX5VpBjdujAJJUai4zrGei1XHgVl8WU/ImZGFfYzj7pQBaJNcC9icLbdK6Kh8P8V7L0xC/IdDkfLV3y8CsAUM+cWCkB/vYZ54c31IbalrQe2RgAaB6USLWKsSNZcGewW9n+L0ejeaPV+oyN9/RLkd2EoA/g63vhzKLa4fvbtAygUQIpTWGNYH+sWSOMcxUMJBBQq/Pr4fPfDx7na7JP2hzjBEyrNCwprvQBA/ncBqW92MRpH/RSnA+VUH0FKS/e62Qh2txOqnTOaRhwPXYeA8K+/hN8TDzMvkm9AXdX+sWVIQ8ugRrQP2H0r1f2fTR/Fj4GkXzSnnEeVeKaVqNslrWGjgCdMQ93sHD01Il0kmx2NeDwzztcN0z2491W1jkqJqy+T+Dni4ed1sHkNawYLlq6wv5UxpYKjEHZv2X9RsmB8TRtRnfMHlUvSQW3FeHOBOjnu3HTkZn+r1FrJLqQgU+/BcNAWFRYJqzx3zQlBFJWq/YXA3sjpmF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmRcla7U1oX8QyIuTMHMOHVDYlnfRT3oAdTp17klLT3d6CSIVzpXtSc3rVy1?=
 =?us-ascii?Q?jEEITRhmX79w4vYwzwSEI6ROf9ltstndbtc8sHF77vIrlP0uYn/SeC0SINKq?=
 =?us-ascii?Q?HD/JZWgo9CukgwRa15o2hyfAPkpcIZCaMQleTqX9xTXUMCYyxwvCCXl/D+CO?=
 =?us-ascii?Q?zwHA3NARCRrxIhsTuRzAl+08WPafUbFm0f2cRdBOxHPHel7Ecb9iaPVUAo5u?=
 =?us-ascii?Q?J/Dunp+1mhvA2srA2zNtdRrVOwkofiQSuauLEJo8v8IVANkCNu7uwjVEtFCp?=
 =?us-ascii?Q?IzVvVxMByxi93+HrPv+fQXQ4TDNMluyDkjzpgp1cLDHoX9arlfCNjidl1PO7?=
 =?us-ascii?Q?h06W3SJCWwpQoTdJkLkQavndUQkswUZY6r0sBj3Aqye4ife/V7zpUwnCQGU2?=
 =?us-ascii?Q?ZdOez0eIy3yAykMXXlOIWNB/BI0WIsWQ1e8jWrcjTD4DuPUx/gMfBohaq99T?=
 =?us-ascii?Q?NvkfAc4B+YUWImJnp9mIO//zIZl1sTYNGOKSWGu24U1Ih8IZQPX8EuuLUYSd?=
 =?us-ascii?Q?iob7/IwM+3aTzCN8WXJKFMr5rd22SFRsy5wzSgl4z08t//d9jtUjsctIMKHZ?=
 =?us-ascii?Q?tr4Mct4zjEMdgZ2I2ANUEwXNBOGYjddtHizRlybJQMM8Vfw+Va9w4M8bU5H9?=
 =?us-ascii?Q?Grzj7GuQ60fjp273fRnVnslnpQEa52rnL4EWNXnlpUU9mnMl7xSAKQMt2q8H?=
 =?us-ascii?Q?ulLCtYHtaYGbeZe3/qIYgMaeUb4hg1YW3fj90TUwoiwzCrV3O4uqbO5+AJIO?=
 =?us-ascii?Q?L8AjDr21gSJY6iDfhtqKNA0NcDgGglgccXe3ktvKemOAZA+2Ov9gL93Aqcet?=
 =?us-ascii?Q?oye7ncDtRNPrCoNdvdC6L/o6hYJh2TG0iyin9OoHNfQs+65/9aWXRhFUK1u4?=
 =?us-ascii?Q?kRdM569uVHKiGhMvtqAQEFdyF/MBdD5qXjX5EMmpumxuHTUJVA3bDOnZL6Ta?=
 =?us-ascii?Q?ljzbnRaMLUw7B3P3jfhGNX8UQMOHO2u8P9uyZopb9wnz/wTRVmGdhuxY7Xl5?=
 =?us-ascii?Q?TPsEUi8M8ukFfENzwFoeVmE2fskAHyRy/QCaun3oiKUDQ+PH5FKbGo8GSfsQ?=
 =?us-ascii?Q?x/iaAv/MOT7M5okStCcvNYxRo8z2d/dx2tZYI0mDtGU/1Idrtv58ISJ/0O7u?=
 =?us-ascii?Q?POevEV8Jcv+UkBPeuYSY8nWmxNy+uLWtbQvEQusH0+8HM/GLcEBpbjTa5xfj?=
 =?us-ascii?Q?NJ+1I2qBg8u74gNpVR+BzjIPdjqxcVSJ04grj8AZ5ZMtzjC7+gqoGzpTQi7h?=
 =?us-ascii?Q?4VyoHVwTgfw2k5tJ2UFkCYerX1jW3JHGTR3UIL4rFQV+JTvez2SpeYziEq54?=
 =?us-ascii?Q?nApod5R2/n+kqQUc/wg+c7HwXur1lhP8kB6Fm5Tqmj95FMYaF0Pqaf5KBj4N?=
 =?us-ascii?Q?fLI0ynf0NBgpNs5H8qnVWTdHjRmcWuDX1N9zC2Prudi1dN1ICBUYhm4inNLG?=
 =?us-ascii?Q?zyt1lhQT2qx/5ogqPjWVUGuC8crXDZLNCFstSOf7vMnnz6KSmq5VEKVKnheS?=
 =?us-ascii?Q?A846VbMIC8B9wPfh4WGFH+sX7Yjd+YEsRa8487ErTpJvnBYtuaXwv8jH44Qi?=
 =?us-ascii?Q?SXXQ8ay3XMca4mW3bMUpRWzTkA3L4CDGpMROoUwfXmyVRYbiML6DYvfnfrAP?=
 =?us-ascii?Q?CYzA0bFxcquy9ULvbIs0y1jXpyb8FSFU6STADJDab4mm0C5kwpJNCNsy+lBL?=
 =?us-ascii?Q?ILaxsH8ZZwOWZ7mRB2mm02UoIHoDR5RpI23c+acbofsTNIklQ997n0EvO9x9?=
 =?us-ascii?Q?bwmgMPNQZ+6hyy227driG/n94rHWiCufFDItLfeFXdyicExdcUo0MsDYzFQg?=
X-MS-Exchange-AntiSpam-MessageData-1: IAtLTpD1KcV0+w==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb0d433-8817-414a-2cb4-08dec141d8a3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:29:28.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiLDV+Q9s3N/+ndr6y3Uau5E7JskJHnhSG4E3voi3RHx83oJQir9ZuIjCg44yblqoERSnQVFzSrz7kpxk6gjU2Tel6Cr838HjtU+Bb/Ib/FZmjaLyQef4U5vX/WsU5TSPqggo1+gT2e9agrjTr4ufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5813
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294647-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CFF86355BE

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


