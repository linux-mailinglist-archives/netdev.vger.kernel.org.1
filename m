Return-Path: <netdev+bounces-261835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBuKBR2SoWmvuQQAu9opvQ
	(envelope-from <netdev+bounces-261835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:46:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFF1B753D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D7183010519
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1C53EFD19;
	Fri, 27 Feb 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Drq0U16b"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADF30C62B;
	Fri, 27 Feb 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196081; cv=fail; b=duR/IPBhfqYTidq7FOcKHtTH1zRtPY9W6/aYDeFdt62FmPtT84S9SKbyw7ELwiDsmM8/B0KWtm4zZcSAJENLrBENXyrap0Fc1nu2Ga+WlY/0Mk0r/MYP6ksrQZrEYE/82WiLuOG1MVlRdGtyIaBu1e1v/lWBia2bhBlaDEjyBMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196081; c=relaxed/simple;
	bh=MqfWJLbACmXGZGsK+kucHTNk2NsWIuripZh6n5B4Qwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xq9sYQWosIMvSCMVdxgKejxtxvOTD4b/logkv72iaOlQPofjXpdgPSSq0A9L/wouyhcVFjdjIDhMh8th/kf7UGkskpv02/j+5hwKuiNDe7hXpbSGYohof/PaJd3E0wkuPBgBOJ90HJjL1QegUNK2NBv00GG6MHdAEnKYcKkZED8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Drq0U16b; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJDgEZoBwBXvGSH3WwcwboBupkyyHrKJNCAeLKzNwxxNPuTQkjUntIF6VyL8MTOWj56mUzw8om5wfYpEE+ttcjG48wYfSaKcXCm99GdpHbmyJQP6DOLaUchqtiBy4rhrRDm/Vtc/w+vYKhIEPxOlO9mgnALghJiD788pW7/uXfK/Unpqeo/jxOZMdT4dcmy+HL+dhCZPNwROs/zvgWYBMHtfIIusGFhWqZRDeywZIuvUlGw0CENHhdBFR40n1bYHFVPI6OXUgQUblAuvhQu70E3KgRWzXexxNLdzhTX2+tafQQS0Un/8Q4DWKT80uB+CZCFjk+Wh8NDSnuOyrL16Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh+OrCCRfoLNK6cRvt1WYXe54iClKhe/O5E+Mh/d/is=;
 b=jTuvmOzlnqFpggpYCxHtrJDTKYBplZWVpdp+QsMFUe5SSqh2tvpIpGeJY5Zyf4pFjisg/5z91R4whO9OQ8XG1WcyB0gLc8EfDxGYIYjnjd4OqMY7TF6okJzu5LMk3A8vHNSRAzd9ll3GBdN6lzEPH402PfDjgJrgwG7yQVJC9WpgUkJXLP2XvhUFsfJgjGaXsKkP58xxM/ADdDeVBZa3CAHOz28EEGBMd+LPFep1GbNSym7OV66UWjKyKqkwMF4CYEM++UCNjOk3a1EsVuPXQMuO/cb5foizTGhpM6h6mESJ3DoQdOkaJQ4aEe3RDRq5zlp5wuD9WMXi6p2eJngVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kh+OrCCRfoLNK6cRvt1WYXe54iClKhe/O5E+Mh/d/is=;
 b=Drq0U16brt8YfIjbdeoVhs37lMvX2cbfvDABc4c4G/w8uuBJjymE/L/ONCccwaiW2J40BEOBOl+coQUHMAqvwIoXz/G5KcVmuubccOm8tVEB4Ts5JMfPirFmPg0X9jCpM9c5WIY8QKMnAzu+AAL2ej8ENeR276jsTBVySQjJ19UHIWSDjrBPhFLSlYYxgFYl52pW1RaeeHl5q/ZtnJ4gRwkyHvEDTpLX0XKLPhiQDSPo1X49c4Oa0UaY4CTNitwTmLVnWrUS9CIpuWxMRlW/SgC9Mo8h3f51spI3Xi1Qp/rG0aB4gzzWezcpoE0Nj5jOUQn63ciX++cDhqNipt5Smw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 12:40:42 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 12:40:42 +0000
Date: Fri, 27 Feb 2026 14:40:38 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
Subject: Re: [PATCH] dpaa2-switch: Fix interrupt storm after receiving bad
 if_id in IRQ handler
Message-ID: <y4dfxt6udovy6mev52lcoxb4m42dukighazitapqivp7jtievq@s4hrbeemzii3>
References: <20260227055812.1777915-1-linux@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227055812.1777915-1-linux@roeck-us.net>
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV1PR04MB10893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc87288-a3e4-413d-5713-08de75fd6baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	ZxCxxlkV5uW2xdo7FXYFaoBFbcaBF1B7sFdAfmtj8o4jRrKYhD3mD3kj9dXY5CJOkezK+54snSMBWYYOPerj6E9vUBKbZ3kWN3A+uDMiwO4/VM0FAdtr/bjxII+LPB3oQLiAplsi6DaTIzEkAshE5st1g5S3erpEzmpveMsDYV/UsuxcVyL33nDIHEtkAoJSrI5zv4UMKTv83BWkg3bakoov7tvJdISTX2Cn6G6I5+HhhQZeOU4kNzX0shnR9G8QEvpgvSY5ttejDGN4DLqB8Jl3lljaqOFlfeK2LZ/Iy5sAH09s2AFTBLIJD5WZBRYAmcnFwy1WQtKlZJOFWOksmi/K1Mjdm0jh3XVczlq0QHsY5MC/vWkLGYXblG/NEg6BXDSo6onZof4FL1vGmTuDPb26wfwMDrwt2G3IAb36IY4WH4QNhvfSaiU4N2imW6sk5VVSmdp9VC5x71axjEFVXJyfMHgSdQBt9DhW/kbuxRwaXE6Pfhw4SYxIJksTqXKt8IYQCjQCcqN8b+Nyn+csFbdABUAI31WGWtPcDIu9UZNz/ucaY9YYeQcnEHaSKkF4hCVnrCSCyc/VLw07K5t06f8QKUlLBCfM6+ikxMAhBQ80oCpTcvrCubwtRVYEj2EkF0RPsBiv+01sQoZcnsRWm/mw+PnqKuFZjyramV7VJFrMVJcRbfYLO8+GeXVOsfkgx++fjc9Qvh5clwzs3X83Iyj3ik91zA6TU6bFUwZGp6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0MdRtuMNB4Os7sHvDYhUEp6NflILvHzi2DZ06SJFM5N1faUiT382CMa7ffH?=
 =?us-ascii?Q?7GBqkFrgkBH6mOt68JOacm9OwTQ/1Z0sbl7KHip5Tv+P80qocvKPld8F2NjV?=
 =?us-ascii?Q?42Yw5t7XFwXRaM+8doEi58SpPC23OYXLy33aJi9ubs+3OrhKDvp5B0KVHKrZ?=
 =?us-ascii?Q?nxE1g+DFXE7JsuxiyiK/1C3qFpgPO40RNpUdIpJy9t/AzBaPv5GnZ6N9udOL?=
 =?us-ascii?Q?br5qWxGfMDG+Z6inbRRfHlWAoHdbxoLIP7oFfbJRwFKaHhNBIJXArbKXdu3o?=
 =?us-ascii?Q?MaRHavg+z7YNAakL54guhpFO1QxBrVZKgaRNgq/JNCZOk8+l5NzFrtcp0GfT?=
 =?us-ascii?Q?XpkngZ1rpWOu4+ELKY4++QV7Ayr89d4S6AV1WXooE1jJxyim/UyY/7Xy34be?=
 =?us-ascii?Q?n+kcJD439hX0RUe1gVjA/VJKlIMRbhbHLO+hB/phc9Ntqb9xy7t/bLaJxnyk?=
 =?us-ascii?Q?GawFd7Frmr32yyGWbyV9DnwnwCGE3LDNz+xprnmzaii91Eyk8NbpJFrW5e6o?=
 =?us-ascii?Q?HdNpWzrQE6yJccbGEoNChTgapzMjXDkiMBxKg9w8C02IH7yScYZxHZiWBQnJ?=
 =?us-ascii?Q?fFGKqjzMJLdBFhTyjDfYsBK3BZA+C7MwpAAIOrZZ1xKK+TLlZFLxB4EWTgWq?=
 =?us-ascii?Q?oPff/GoVTJRd21tIsdcRjXh5OBq4KQoZaldy7BfXWOJDNm2IXK5bJalOW/xs?=
 =?us-ascii?Q?HfQ/sIkBR9xQv4yAkqdXUHFU/y4nLH5hv6EJPykFGynfiNXnkuuu2shsQyHE?=
 =?us-ascii?Q?yusN0r3lMcc2MbLA4pks3Hx6h2hRqbenyE4cvhE8IMwnNgK7MIFIUllJ9KMZ?=
 =?us-ascii?Q?/tMKEGT26pNAzP+HW+apawHAAIjSZfKRbmfqHBwCpfsUQLKI8EhXkVs9bQ/w?=
 =?us-ascii?Q?FWPq9w/22oLkETks6WFZH0yRFVt2pZVzqCb0AdRqLT5Kd+K2WWuY/c96uSWt?=
 =?us-ascii?Q?p6JPqpp6xsUqRwmQt2I57F8s01a7UZ4TqO8Gh51RdE/vhbJ/7eDI3ynAxDj3?=
 =?us-ascii?Q?KRY81S5+XT9EAsu7beqFoRvnMr4cNzlehWeBON3DH2zHcxv6j4+tzJu+bvpv?=
 =?us-ascii?Q?cXCnB61Nnl6NAbkt7WhWzCH7lpPTODXRxyU8gWmcEiT/qUAVx+zaVrEE+5zG?=
 =?us-ascii?Q?4a0W1AzdQavU0yTE65KqvO6aN1QOBxMoYizt0TCiTepFCOv33Htbrb5f/moL?=
 =?us-ascii?Q?XDHIoEgeJU+nslK39/zifb7EIZA9YyTi5lpfLhuQ4HTz7IMK2UCIlHpaFFk3?=
 =?us-ascii?Q?b1gGL7IFiJaAAsouv1jWd677bF8Wa6TiqBP3EZ8y030MmQW0/fR9S6qoKajt?=
 =?us-ascii?Q?JT0yXfgpnbBMxQvqIGcMinCzkOWCK3eghb4Uu6jpKIGaNHyf1n6JOsMssqzv?=
 =?us-ascii?Q?KANYCnL1o1/9bPd9ABL6gZRcWQGXcMgEiCrQMcTULETHMCmfNJ0Zk6Kkp3Uj?=
 =?us-ascii?Q?fGu7dHU6V/7Gr4uIozQJwmXgaJoVqF4Cox9HedrWbSIneL0Vt895Lqje1K64?=
 =?us-ascii?Q?+1MrH/COmdETNXExFS1O46QmKj2p3NFgbjx3INiTWSrer5gqEFyi70C3gSgV?=
 =?us-ascii?Q?IgxeExETY4EqdzfBtBXRwmP/2Z2YepRx3b7Sd67InusO2h7+rHrmN6sk/Ovk?=
 =?us-ascii?Q?KiKR9/oLDTvK5wYv+Rdb3rvrNs5mxprr2aushQgHlqb1ZZG8VWZC6b2BuDwL?=
 =?us-ascii?Q?Y2/EdBg75kdKbbOcH81sbmD6lJGCPHrUNjh5aQCehNqEOVY7oYlzlcNE0IKV?=
 =?us-ascii?Q?e4aBjOtpiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc87288-a3e4-413d-5713-08de75fd6baa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:40:42.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK9uykybfwyN7Ux+5XMnuxe2RTlQwXnOSYexeJ0ByFBSu9ZVC+MfyEpuC3HJcnTrTDXFZDQ5rP3+rHu+LzsjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261835-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,nxp.com:email,nxp.com:dkim,roeck-us.net:email]
X-Rspamd-Queue-Id: 6BDFF1B753D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:58:12PM -0800, Guenter Roeck wrote:
> Commit 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ
> handler") introduces a range check for if_id to avoid an out-of-bounds
> access. If an out-of-bounds if_id is detected, the interrupt status is
> not cleared. This may result in an interrupt storm.
>
> Clear the interrupt status after detecting an out-of-bounds if_id to avoid
> the problem.
> 
> Found by an experimental AI code review agent at Google.
> 
> Fixes: 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ handler")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Junrui Luo <moonafterrain@outlook.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

