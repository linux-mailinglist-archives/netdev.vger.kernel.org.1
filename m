Return-Path: <netdev+bounces-296507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yELwCCisJmrFawIAu9opvQ
	(envelope-from <netdev+bounces-296507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:48:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE2655D86
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=AHMkTlpf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296507-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296507-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68A9F300BE84
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0135A36C9CC;
	Mon,  8 Jun 2026 11:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013060.outbound.protection.outlook.com [40.107.159.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF533AD82;
	Mon,  8 Jun 2026 11:45:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919106; cv=fail; b=So3e6TDqTGuNaaU24o0+mEVtFoDDZNJ0VZSUNVj0jLnile/NnSj2PJmiHKk1cWVwBCX1llaqAMBBBkln1t/j98K16WTlS+t8kIkH5YTPaz1qhV8vNSv4sqrx/1NvA4ZFJ2gayzed8utfYy+rRHYtTwdMySoQc9m2GHicw+sVGPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919106; c=relaxed/simple;
	bh=+DgBLvmZUrFNnAgVB+OQCy/Amtlib6HH0lnYMrlF6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ru1agGbiu+/JE154cybX1B2CW2Gm46xcNOQm21+nErBwlmTC9Xyh/a55fEXVV0JmxrGunsY6xD2dTr9gqWKAVFAjiBUDJVjk4GY8bkqtTUrio8mquonsNv+Pc+tzOCSRVgmtd4nslv3SysItziuqkdTb4iehLaKYe4m3+i4AFTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AHMkTlpf; arc=fail smtp.client-ip=40.107.159.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTShQIsrkwsADR3e091D8HuVTWkM8AtOdJsdohEEa2ZFmeH2UjNVv6weRasZXgA30GLTTPkZU384cfiN5UMWqUWUgKI7WRS6BMr/dhJZ5GNNccNVqsS5XvUwHp3ZBjaubpOThNrTGWadmle4KY74aTb6knlD0oMx7hDmR1XoYxLrCJNiwbC3jEiogH2bd5qQmo6t4dEkFtiM9eLyeYgkvA3MtXyYxKet6BQsSAXhTZTI49UuAv8NtUJKDMr4DIjYdUmvUmu8mr4Ect0uMqLa749YRD5E7yYz52n+Dj8NrWkh/35sxLhA8jIEYmr1bayWgpXPx8d0Mk1N8h04g4Ny5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY222DvKosBNIaMWLymrh/COULnTLklsN5yNq5q/Ln4=;
 b=tKDtj4XYC2wvBRXY2L537GA+fnWuyT/8DxqDDtUijk5k9bClrXPKWCCZzUQcVFStzBDSe6flYpVsfo8U/WFfrtnZpV1YaDefRyeG62QrS6cWpguqj2m83iHUqE8vaJXyUp8SeQ7yyj1azh11hyBNrd723btj+nPs3MfMk/KHO+Vccm36DV4Rc2pqSfq/8MNUaC5ZU+Sb1h1DapojwpFY95NLGIxdiMK4hH+Hslqldu1piNyAyZPQeK/teygoD6EzeW8easpnYoujPZMCZnkpErq5xOK085GrqzJf4g08EArFQ7vYgbwdI0Qv7anA/wuJAByy0TtsqOrLumsTordbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY222DvKosBNIaMWLymrh/COULnTLklsN5yNq5q/Ln4=;
 b=AHMkTlpfycdQSv2RyTjqnKhqNBsFo2Epk077dVmiDz2mfLOsZJSW1xk2CQe4pobQuzopYOAN9APDEGhSo0bI3o92Mn2LQ+eXA+Zhorlgnc4QIpMNGXTnTn9jROeamRgS3ArQ77XmCWsOzOnswFpy/Tlduk+7/JU/n1JbIdBY6owPh2ALeAXpFpFXouHLTjhFBgImx1cJoIPNYRgvqiHLPOOH3CrKm6XneYfQgKfB2C1UnnL6wYpEb8DcU4se9SN34+ImXmgK/rQZQWuaM3PFkmbwroPQ6y/HbwHfdFIzMWZ9wQ9AK4fpLbIIbEgcne0mGXlf30aQ6WqtYayMDsydSQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10255.eurprd04.prod.outlook.com
 (2603:10a6:800:23f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 11:45:00 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.010; Mon, 8 Jun 2026
 11:45:00 +0000
Date: Mon, 8 Jun 2026 14:44:56 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/12] dpaa2-switch: offload port objects on
 an upper bond device
Message-ID: <cj7xx3qvouwt2sntiubol5bd57nasfv4ggijdr22qtvspkhsno@wiaw6vlfo6pr>
References: <20260603143623.3712024-11-ioana.ciornei@nxp.com>
 <20260606021056.4124819-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606021056.4124819-1-kuba@kernel.org>
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10255:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc3733f-3a9b-4932-022e-08dec5535f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	M0Ye1XbPq1xJxYVWW0WyPJ7Nu/8ee1xU9MjWltzZmKgx+Qhuo0vecnvidsN87IDP37vzCuU5nQYy3TTCktjE2gJkc+qm1SLWyCCSerQIYm6oTJA7A49pZ9VmTDoWQlqYLBad0YhZ/UjUUmRp1hjpSI/zEeGddcreE4D9EnWfzhxN+WLKq7XzVPuxsQJ8hm44Mr3/RElJW5SlnBYiG6zf11XY8hoPTSM+dsn51XJCA8Pf/+a+h2xKcDMMfWMZVLkMe3MWQuw6lIptNRyzP7ftAjSvlH9uxw6EuqZYjlpnQa5AZgN93Yi18aUYAvUKlbzYqesWQdLXRndwObYIPLCDx66E/Z2TDBwHukcJ843m0akd2gYfjovQIO+bjyAaCGLUUZt2x3NVmmfFsZblNa1PObhQNS0V1unYsE3k1GaQs5vXEiW2l/sunNWVREm0wS2SM74s9pnszApYY6oFLJGv4UpiA0xSyBMifR/MitwsE7DYBKWHGaSqHi0U/Y+GKqpymW2W4DuvW0q3gmNPnd9yLRa3TvYrlVshbvR/g4m3I+iPnVn7B3lCFAgZgOdIPKIh3MaInVE6JpRdDX5S/kPJQaLVeCwQItpLE8ttHn4mwSqr00T1qoZ4ISzLOLlzWIxmYEr9agc2prFeKaRP2mO9mw9EM95eo6DudiBiHy1IGFeDbOb+tvijqhs2HAHEd/Ym
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwNmFgXWiYcMrzqNjgt7zWNC9myvhWcWWUhvaZFgFX5GF+fhsEQ3fmEd0sU7?=
 =?us-ascii?Q?rDNTqikdZbg5wSwBFxgl+HafimJLHdKffyWvIUTAc35XytC+0hT7apAIjmTB?=
 =?us-ascii?Q?iF7oVVrgXY7K9nI7xNmfutBa3JC8qR8UxkQlXqUB4JMetUOJGV023egV8fP8?=
 =?us-ascii?Q?EGAd/dIQXdWZICe4PRxN7Bz1kYKLu9kNCxqwb2B/7aPVAUdRXKw8pyRnqR1K?=
 =?us-ascii?Q?dabS3gbVJzLPu0au1doWxikCWPUcHJwzmq32yxZe7J5EqcmQ/FCaDd6MNWbK?=
 =?us-ascii?Q?HC9TRB4H4SuBFjNi3RLmdu3Jb2pwocDCXmKwdPDiV62Ym+uy8liQ7nniR7e3?=
 =?us-ascii?Q?udf4illbnqoV/li1ajJ+9mupKh+crym9z8+ctav4V3fZJ1cDssCFVqIkxsas?=
 =?us-ascii?Q?0n6rvliKHNM9TGcVgitRLUUDjOw+mfxqlX77HSx2e/BuLomQAkNW5KlEwuYj?=
 =?us-ascii?Q?FWZYjp7AUyNsfUap4vTReMCnUkdlY65TZ5xW+KpmSL6e00koDqmNekOSvqxh?=
 =?us-ascii?Q?BI4S6d22pVHk52okEXO2G/8RyJrAYyiD9MrHBj4tbivw5NQ8SvDljyIz9qSO?=
 =?us-ascii?Q?mPYB1EK+l0t2gia9cPfQejGSxKYA1sFskQEekTjbR5nlwGCXap1JfphejFHp?=
 =?us-ascii?Q?MmKT8XpqrTKMq3Vxd/A8yzO5BMZ5qU5nlx9um0O5LK280B6vaZc8GnZGFC2w?=
 =?us-ascii?Q?eYlrGbBqbbYO28zFbxO2uImFfrja77tLe7QzqBaHgiTGge2gFT9aEWotmBZ9?=
 =?us-ascii?Q?yMXu/Uz1nQKspD5kOlTeUO7kisKjL2nTCBcLNUjYyZA8yM1TST/uSkFd8cSh?=
 =?us-ascii?Q?Oa87fYdYdIqwrqS3cKTNMDG+ppMRJ6MAlqzI3XwhmCeUizRXdCwJVDBnFubl?=
 =?us-ascii?Q?eXFixG8Il2iThUCjfMBuieOeQAvDg/YSBsj+AlY8gXdyi1qwTR8g8GwhSxwn?=
 =?us-ascii?Q?8EJX/VBEMkhvpqfGbXYmnSe4rkWcXvUjJL64Xiu0r46Bv1grKMsFUsVbgrok?=
 =?us-ascii?Q?V0LLoVFff/L6ymbfUBpdNJkAEpHNf4PPHUmk4y6i24ZK9Iv7iwjHlUOnNb6c?=
 =?us-ascii?Q?dUD3i24ZvKLfd8rtckB4IRSdvA2FrvCe5PnnQFwqezq/xDJx6RJH4RhSGo+3?=
 =?us-ascii?Q?wH1OILTKviQu94LUqMQwx1YULCDU29BjKrATxTq8564k0P0VTHh5bifPqYxR?=
 =?us-ascii?Q?4VDur7OwPje6y+uabAV6aFIt2SNVvdoudrq2JHiQ8Z7cs4IvIMthU+G7ph55?=
 =?us-ascii?Q?1oy8MwCVgmpfHgqE4fyP/Ss2/T5sdEEEayzvYuM1LziKHiAE2MCE3ri5La5u?=
 =?us-ascii?Q?s/48C6dfeGTMI4KvAgI34G7AdxWrKC1YTkIUbCqOhCLfV1Ck310APy4cOGAe?=
 =?us-ascii?Q?FcoblhDZ9EZsrI2mOT9I9tiyWBn+wK9sTru0BERtVx9RU6Nd8L0q1vWuT8As?=
 =?us-ascii?Q?+2Wp+QYyq7T7ilwQ1XxG7ALBj2nt6gLsSxIoko+EA8nZpeYlPKM40tliEFkN?=
 =?us-ascii?Q?yVNGH3OaCIL6KBf0OsUz2zjzXxtAIiQCu6Gwotr0crS9TtMnNveexDHrUD4P?=
 =?us-ascii?Q?x6xL/VxUqd1aOh8QqFBtFd0e0BBvi0ZTvueMPrUiKl4AK7vqedBH4+914eFm?=
 =?us-ascii?Q?XeeIdaHxABLLbduv6JvHc8V2MWK4Mols1xp560zwS+pq729X5ZoWpBmnzk8J?=
 =?us-ascii?Q?vVg0yGYLC54XuMFgofNWRtxAjA8XVAXhnQBhoVM/RFxRVH9XO07DwDBgrkFr?=
 =?us-ascii?Q?uHdA81yyOQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc3733f-3a9b-4932-022e-08dec5535f41
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 11:45:00.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LeuafRTRpc3gafY4nTA5fd/y44OfpGkgxWI6H/nNQ5BMVSnHxptr6dLF1wB7zrOfP5Sq/B7QEDIugGCuwxJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10255
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296507-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:from_mime,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CAE2655D86

On Fri, Jun 05, 2026 at 07:10:56PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> dpaa2-switch: offload port objects on an upper bond device
> 
> This patch adds support for offloading port objects, VLANs and MDBs,
> added on upper bond devices. It introduces switchdev_handle_*() replication
> helpers for port objects and a refcount mechanism for handling MDBs in bond
> devices.
> 
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > index fadebf6a758d1..9aba5f348abc0 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> > @@ -2215,14 +2231,17 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
> >  				     const struct switchdev_obj_port_mdb *mdb)
> >  {
> >  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> > +	struct dpaa2_switch_lag *lag;
> >  	int err;
> >  
> >  	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
> >  		return -ENOENT;
> 
> [Severity: High]
> Does returning an error here abort the switchdev_handle_port_obj_del()
> replication loop for the remaining bond slaves?
> 
> This patch uses switchdev_handle_port_obj_del() to replicate object
> deletions across all slave devices. If a driver callback returns an error
> other than -EOPNOTSUPP on one of the slaves, the replication loop aborts,
> skipping all remaining slaves.
> 
> For example, dpaa2_switch_port_mdb_del() returns -ENOENT if the MAC is not
> found, and dpaa2_switch_port_vlans_del() propagates hardware deletion errors.
> 
> Will this leave the remaining slave ports with stale VLANs and MDBs fully
> active in software and hardware, causing silent data leaks and inconsistent
> state?

I don't see how I could fix this at driver level without a change in
switchdev_handle_port_obj_del() or the callback prototype for del_cb.

> 
> [ ... ]
> 
> > @@ -3128,37 +3154,23 @@ static int dpaa2_switch_port_event(struct notifier_block *nb,
> >  	}
> >  }
> >  
> > -static int dpaa2_switch_port_obj_event(unsigned long event,
> [ ... ]
> >  static int dpaa2_switch_port_blocking_event(struct notifier_block *nb,
> >  					    unsigned long event, void *ptr)
> >  {
> >  	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
> > +	int err;
> >  
> >  	switch (event) {
> >  	case SWITCHDEV_PORT_OBJ_ADD:
> > +		err = switchdev_handle_port_obj_add(dev, ptr,
> > +						    dpaa2_switch_port_dev_check,
> > +						    dpaa2_switch_port_obj_add);
> > +		return notifier_from_errno(err);
> 
> [Severity: High]
> Can this code leak memory and hardware MDBs when a slave leaves a bond?
> 
> When switchdev_handle_port_obj_add() replicates MDB additions across all
> bond slaves, it increments the a->refcount in lag->fdbs for each slave. 
> 
> If a slave leaves the bond (e.g., via ip link set eth1 nomaster), shouldn't
> dpaa2_switch_port_bond_leave() be updated to decrement the slave's share
> of the MDB refcounts?
> 
> Without this, when the bond is later removed from the bridge,
> SWITCHDEV_PORT_OBJ_DEL replicates only over the remaining slaves. The MDB
> refcounts will not reach zero because the decrements from the departed
> slaves are permanently lost. This would leak struct dpaa2_mac_addr memory
> and leave the hardware MDB permanently programmed on the LAG.

No, the concern is not valid. Please look at the
nbp_switchdev_unsync_objs() function called from
switchdev_bridge_port_unoffload() -> call_switchdev_blocking_notifiers()
-> br_switchdev_blocking_event() -> br_switchdev_port_unoffload().

