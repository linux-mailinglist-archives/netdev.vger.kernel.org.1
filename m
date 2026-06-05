Return-Path: <netdev+bounces-295566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0plXNMErImrPTQEAu9opvQ
	(envelope-from <netdev+bounces-295566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:52:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B290644893
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:52:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=e5QK89Rj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295566-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295566-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04899305898D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04D3C3C14;
	Fri,  5 Jun 2026 01:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A123D47B8;
	Fri,  5 Jun 2026 01:45:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623927; cv=fail; b=IsjaiPv/DEYbAX3OZVvJuDjepqqcIBLKuVW44WNmqvGw6/vlUA9sluGWOR/Dcf4wmbygIkdnAOttotAFcuq3/Y8OEb/2/wVbP25Q4+jGgbnSLI7MrkrJFg5T3VocfppD36Bg1URaV/l8QoLLQEADcIgUhYhesraaiGUDUdj4tCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623927; c=relaxed/simple;
	bh=FJ7SZoVCx9d9I0zIa/Q+B01uWE8qTwid4Yf/YkuG3Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hswenCvR7+sMPIMWethKH7dr/M1ooxF8cQ0OjxPY/laMcxyLeiiEBmEsC8BjOmmJ5GMW6nc0UYkDksxsW4NDL4e9Ez1uSlwvJxZqNJHp9yoTxC71KpNRE+aZVB8UwwzWZa+JI5MOiEcV2ClMrQlJUnOXevN2ys5qg2C0QDTaKNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e5QK89Rj; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xavoAbtd6BUvtwKH4o+geA52G/v7LNnfi90K5hsi/4J0V01TmbTEIOBElFkANmlPE/7x0PlF9rH9MoHMmK26OqV2WLYfwE1wGvyk/4ZQRJQOHIXkJlco6JXnArVEAtPxFTue2lrshTvT7hAeF22YdCJdwFrpfQmiZQI7IUmi1p5L+0MNoWonwmcIYkgfhEL/U0FwlOMBdgnHZrr2adKgHFoCrPgZg/VjLssG9sT2MTqCy38ATGHxeqXkMthYI5ZW9ir4f0M07w/PQxWrSM2+O5s0UL+ESr7hCpPWoAhKER5TSz0rh07wTvc7FGgU4slnJt4m9N1DT7PKrrrem9Ywtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=ZQVHsFykqVOsyDFHSz3QsTjAhtcoL3PkUHp1HNr3nA0s8Bkv8eYGK2ROUgjltqUpH7jxIj4SLK/LZOAh2i1TT0HvALHDroqZa11JfjxgbDaQHSe6zAwvEih7qOo6X2Kgcm86SHVtCd7WkIPKJ2q6yowuhe9CWGwkOjJoE5inS4dc39/TxHkYFSX8kL87dCJVCglrV/xiFCnONf3hbPiZ07fv4kjsdGUhuIdbeejloMoSqBUKSdbyZmfXI4ZJLAUnlEIGhRJxiDfCf5g8vNsWn5RNEWMayOLLJuZ085dlw3AMSYh+seUr0VP/L9HStXOR00YwJFkDaYrGu8mA4pjrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=e5QK89RjyHitveu5gLCtW79ZG2JUSAwGhCuXK1q8f03yxFH6Ch4xaMEqbc7KHMYtccX1jOT5R94IIqJkkK9o/vJekZ1fEnYM1/wTQWXZ7ofNiDu978OcCwu4jLeJCxgIsEmkdGYyxPV0jYg2dJFwAa/X6U3g/oHZ+VPBuJ3pnRrWScOu0VNbcSV5U2F/qTSP9/PGR1zGAsYWHuudKPL2XwRNtdhel5YyRQEyLHuVYRjyT5n9DR+MWb3hVQI0I7+EQ8HhgBfgsOec0Vciqe8vIv0gbxIa9KrZ5lhC9KNIMWrkz7SR6MVbaPkn6HPR5UgkoeZNtKdeHJNmSUBU+Xtf6g==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:14 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:14 +0000
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
Subject: [PATCH v3 net-next 2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
Date: Fri,  5 Jun 2026 09:48:01 +0800
Message-Id: <20260605014808.686024-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: b797c61e-33d2-4415-ffff-08dec2a41688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oZcgnAXSacSNYUInnGxleRYNrokj3+wc8nSfWTGCejPjjktLUkYtnauoK9EyvECCQc7rk8V8emufaPIKW4nIbbHY8IcFhTjBtDmMqLtDkqPOU5bbJX6HREWNHppLLwDOSoReRtURtQ56VjABuZ3VrXuH15WR0aMchf/sCRGR4fMN7sbCCcIofwSinjEmdxha8KFQuheruVvcjXOJmOEVkrR1+bYxzmUGvYpBea5lfQUMBTXkHZQ4jkkrwjv/tJMmmiwDcGfMeiP88FVR/ek9vqVjLAQO7xMz45iuY/eUCPKoFDjFf0qMbVczf2YWan6WLvkU05M2UEO1J0aDqrG6u+NxhBxNW19zcG4yNZ4Y6c3b5sf0YTQDYML75irUTRyMNRGShFjkG/OOJcZOdu7pIWs8UqITcsO3v+n6FSekEUF5dsKVAZg6GBiAiX73LFkmbIojK4XkE6FHCjbLOF0Yjqa2rlHKQYqikXU3EpwaoDP/q+R5xhOOwGsrTwbuRz0iZs/2FQlcKulq2Cb8fwFOXq8Vp6zphd/ejQNrNjvROx3EynOYklZP5qYRtNloXOU916UTZIPbaMuY6PojheHp/gFOgaVPYcLtY4S9h/pfAOPnNAJwastDHXQ09bW3AO8JpP8Mr6+32oD86KFMdt5EHKwKcnFFNHQl18v9mVoMtrzrxKi1qDG5atoiMhNOE0YswEObP1SO4OeSi3kivL8m1I10gSmhwaw6EI4pgfhYER4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJic4KGu08c/TKzU6u7QlRO4qZmYyQaExzgrJhZX8NMQMJv/FGwxUywEXlhV?=
 =?us-ascii?Q?0aW9MX2EpV1x8aXQww7e07esHVVrF3g7h0jvXA52LmTz8amobrLn1cYhWr1y?=
 =?us-ascii?Q?CpJ94tEN+nZOJERtSWjV7o4klamcBUw/5hjnjr5s/dc0WNU94sVd+CS7UHez?=
 =?us-ascii?Q?EHDAD/9HtxfPanzpF5Of8CwO0ILF6kIU/RMaT3q/+taU2N7leALRJMrhmEvl?=
 =?us-ascii?Q?3efU0jWPk3YLe3IrFytvm/hhNqsg4TOEnNAxN1+R0Xy74Lhf7ORThw/a7djm?=
 =?us-ascii?Q?KtjAZXz4VFkzr4Kd5JxrJrRsCVVvaDj/Pwlvu7QVzGeBrTma49Ov2XE2eEJj?=
 =?us-ascii?Q?Q5smhgEHZnkC1YtWz1y1FDXmV0gImRwHj8qzlxT+74q89hlqcW9LoZrgiPFi?=
 =?us-ascii?Q?56FuqEIb28UqflDMrPj9I4nESl006xmyPBKTn/L8UvuXOaOh8fXdLOIRASPX?=
 =?us-ascii?Q?Cz7pnRHTaVAvIRP7peOcm/s3i8eW/4YjZ3qznW/GFzBOPDM7bEr6Tmj+niCf?=
 =?us-ascii?Q?u93ZtSgrCAMAII1Pr3o4mHbdmBp+gErhfwufxNVUm5jYpFzzS7OIoL6XLoky?=
 =?us-ascii?Q?8PC4ynvySUTuu3lkOZpZD5ufezHXwtgvZoPhAfUgUFhh8O+0UH8/JZmh7oZI?=
 =?us-ascii?Q?myV0w9YXteNSaEUzFE0A9C210vqpbQ+r+osEi8R8EfOlF4OUV0DixDgIyHnO?=
 =?us-ascii?Q?53Vy5uUZ+RT7L7tDnioUImT+kJ3GOlD6na0ygjVYb7J3C7SI9DH0Bf1PLLd1?=
 =?us-ascii?Q?8ZB7+VM/yosUpBCgU/7zNb9SGDq669wNZcLNC4MZonzbILJczrQOsAv9X1cI?=
 =?us-ascii?Q?OKq6g/FoQ5yy7At1Ekk9v3PB5Q0XVJxzlH+Hyt7HJXk0xxwtEcQEWvv4pFci?=
 =?us-ascii?Q?j68d9rHn8DrM1g8PlAD0mT6vhjkjzikPCBMBs3jnvzqyfeKwZWdj914Jy/EF?=
 =?us-ascii?Q?VVFNHmjFLhXyPRKkLK7quhI0wGgNzkbrkZcl2pJbNknygkTQV6HdiZpwu83l?=
 =?us-ascii?Q?h+5sdgmau+8AJpwaAn5GnOrmvkNANn5rNRANSQMXlP6jk6kEni792fU0+zJn?=
 =?us-ascii?Q?I46JhOwvOMGUnuPfklRgBMZ75Pu+jweb5mp77uezwp6CQtM44HIVP3HEdilf?=
 =?us-ascii?Q?GnEsXaKENv2OP59DBmRsEJr4lytSapYghgjffo6pL+a639uhOvUsLrAHJALL?=
 =?us-ascii?Q?49G4Bm23rDKfRloWhZL8psCiGltouvadbPDBaSU0fBbozBdGi7EBB5ZZsH+h?=
 =?us-ascii?Q?5uLEp5gm+nx+UKqCt+/5H3WedzOD3iD/rq1kl9se/dTKmyCGr4umwje+HsqB?=
 =?us-ascii?Q?6DpSXSOV9XPL2ypcu3lh6fshY8yNci+glpBwr/FXVDE1stcqLfw27MdantzD?=
 =?us-ascii?Q?tTLncDlCsx/LmRADLYXz9NZFsj4pfHzYLOwA6ZoIh1e8D/kFax2d15jVjONA?=
 =?us-ascii?Q?ujBm6KlhNhw8ZDyOOioCKroBodM5SuiXLGtVnT8QEafhz+Z3SgGyyP+npiGc?=
 =?us-ascii?Q?8DyHSsxG6S8rDrkzsKSYoN50DLcNEGtr/uZxLnd+F9mDFXfy7TZEGvjpJeYn?=
 =?us-ascii?Q?4Ju1nHF6g1Yz//Gkyxd1hInO5xpBRKPMqZVJO29xp/c9cntA6ufCfizy9o/j?=
 =?us-ascii?Q?lF3ttDhI9MvyxBmxfSfK0m0qz2bjM6Vk2yUSMce0Prnpv6ptQ7+ukR6dEX03?=
 =?us-ascii?Q?w8LZIr1XIaTgZCnNvNgLSS/+x+d9dpECz5974jR9HeBaLqUO3lBCBpL9suN2?=
 =?us-ascii?Q?HIcQVT+9k89QZFkiJag3PccO9zcnIMkvayAEIa5vAmVN3Xafm+EH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b797c61e-33d2-4415-ffff-08dec2a41688
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:14.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq0ppowUnt5ITqwKey5GrxCxjdwA/s70ICSE5L0sH0b3wEsqDZw8rUAJdVXqX9tRURHNeo0Y9yrfnnwdqv7PBiqjWG/UZx6a5h6Pm0ZC3LksCi3s+YKqEKk9UsyK5XW9
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
	TAGGED_FROM(0.00)[bounces-295566-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2B290644893

From: Wei Fang <wei.fang@nxp.com>

Add two interfaces to manage entries in the VLAN filter table:

ntmp_vft_update_entry(): Update the configuration element data of the
specified VLAN filter entry based on the given VLAN ID. It uses the
exact key access method to locate the entry.

ntmp_vft_delete_entry(): Delete the VLAN filter entry corresponding to
the specified VLAN ID. It also uses the exact key access method to
identify the target entry.

In addition, introduce struct vft_req_qd to describe the request data
buffer format for Query and Delete actions of the VLAN filter table,
which contains a common request data header and a VLAN access key.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 103 ++++++++++++++++--
 .../ethernet/freescale/enetc/ntmp_private.h   |   6 +
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index bda26fe93b8d..4e60bbc38cfa 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -956,15 +956,17 @@ int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
 EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
 
 /**
- * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * ntmp_vft_set_entry - add an entry into the VLAN filter table or update
+ * the configuration element data of the specified VLAN filter entry
  * @user: target ntmp_user struct
  * @vid: VLAN ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
  * @cfge: configuration element data
  *
  * Return: 0 on success, otherwise a negative error code
  */
-int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
-		       const struct vft_cfge_data *cfge)
+static int ntmp_vft_set_entry(struct ntmp_user *user, u16 vid, int cmd,
+			      const struct vft_cfge_data *cfge)
 {
 	struct netc_swcbd swcbd;
 	struct vft_req_ua *req;
@@ -973,34 +975,121 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	u32 len;
 	int err;
 
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
 	swcbd.size = sizeof(*req);
 	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	/* Request data */
-	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
-		      NTMP_GEN_UA_CFGEU);
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, NTMP_GEN_UA_CFGEU);
 	req->ak.exact.vid = cpu_to_le16(vid);
 	req->cfge = *cfge;
 
 	/* Request header */
 	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
 	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
-			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+			      cmd, NTMP_AM_EXACT_KEY);
 
 	ntmp_select_and_lock_cbdr(user, &cbdr);
 	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_ADD, cfge);
 	if (err)
 		dev_err(user->dev,
 			"Failed to add %s entry, vid: %u, err: %pe\n",
 			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
 
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
+/**
+ * ntmp_vft_update_entry - update the configuration element data of the
+ * specified VLAN filter entry
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_update_entry);
+
+/**
+ * ntmp_vft_delete_entry - delete the VLAN filter entry based on the
+ * specified VLAN ID
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_qd *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, 0);
+	req->ak.exact.vid = cpu_to_le16(vid);
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
 	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index ad532b059ba8..9d30f128849a 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -211,6 +211,12 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* VLAN Filter Table Request Data Buffer Format of Query and Delete actions */
+struct vft_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 5db078e1caa0..36a9089526ad 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -268,6 +268,9 @@ int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
 int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge);
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


