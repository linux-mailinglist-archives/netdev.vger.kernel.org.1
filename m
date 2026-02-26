Return-Path: <netdev+bounces-261344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDl4EshEoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:04:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3321A60D0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 706413066770
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E74D30FC31;
	Thu, 26 Feb 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N5RxilPv"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBF306B06;
	Thu, 26 Feb 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110996; cv=fail; b=Y6RdR/tJysxEdyhtym2wThhb8BDAqtE2HzLsE+cAuOOSB3r7xMRMq8Nw/KOdKW/UhwmxhGs/Yl51P6uajKbxILrvGAZHQrSNk38MeMArXauMHYJ5RgvAc1n7Fd7c/D51lBa3Sl7Z5V7b479mLQPNGBNwNgvL5Avc3zZzFkWdRH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110996; c=relaxed/simple;
	bh=Nvr549ArafnOmzSkmfas0GQ6uzrPdMGi3aHjiMLu25M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGYvG1K7J4RLueuq93I3gaS4OJ+Xti+gOzrxAZbWmEgRpeqZehxlviCm3m1r6CZcK5rfJxv+GhekBv8GLsKyXkg2w352w1nznEIO4g28a7GcmlJZd8b4+93FY9ysiUfx+GqjFp2XP5MaK6oGmd3gc0+PgZpTxR2ZRx2/IczNgjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N5RxilPv; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoaQCnFjJyZE3dKO4baRE53ecMb4CVJCAuHO5j3Gdx/KRTT8pUmx090P9P0+eNQg7YjUFef1nJ+xDmkJvA56gOl1fdYJR4tSRkaNDxTT+156zTr75rWB03llJXd/l6p2ttqh+e4/LdiRzQBIkjdOQZXnMKaarNfkud3PRJECAp6njNNH0a2aX/ENV7tCy3TxxzeEIgTRHSikKJcvXZNolY4BlYf2QlrrF14FijZzzvu7e27q1fn+aAVKQUykjd3ifvPtEppykX9C2cbyAZbb1RoFVecOajrKYl5PU+YkqAvlYaBSMMj0I9Gq5d2O8l3TF7Ciiu/ao3299RiihzZitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+muxIMvGd8J/2iu08mCSyjEOGIoMGT39f/O2krNbJEU=;
 b=MqBbqYx02fplGb/jnmeeYfgjUKUGG64v3ZJpIxnNg8ob6j8BfmamnJE3kLol9gOuffo9TJiiHkkLPA3GNYE+KtsP4tg2dWGH3gpHGtr7lrjawi0ioBUMyGIyBXWPMk/qft9uuU4mghSVS8+uoG2T7I7m4S7zY04DqFK7TBb1sLqEXNbuyIJ4n6rvqUOfbLauqohn/5E2oakW21olJx+gfR31mzsEaLmZZotezQGCucVRETGybGDRQG9aNftXmIrxQi1eO6K35o5jsi+242wg+Iyhw9n3tzY+LOx/dcA+8OO/DDk40+ELvqyYNBfar/gZaMdijnLEgF4tnyqyaoNtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+muxIMvGd8J/2iu08mCSyjEOGIoMGT39f/O2krNbJEU=;
 b=N5RxilPv0f3blxZiYb9BJMzDiHErXs1Ce5CPMPgCkMVpy5LiyR6dw0JNQOd5RH1RHx7HJGvwY1phvZqvvUjrmu/RgiJNF+n50Sn0HSdtVJU3lp5/K8iPeOSvS8JMmppbdL0SXJW1EH34k4JIYXVaz2NN5a4NoPKZWjku+SoJCJhdrGVXPgswu3vnnf7hhO6ws/P8KsbKbRjVbMdRxTUID/JGpKwiijMZWA0c4Yi8pemhLRLvu0vjcYi0KKed4SriPwC+0DHptc5bI3cCLoCj++zob2c1NgfQjPzq5i4kZiVRI+lX0gLR5cSF+OcnDb7bE5HF0+zq4nlZ+II52TPHAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by FRWPR04MB11224.eurprd04.prod.outlook.com (2603:10a6:d10:173::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:03:11 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 13:03:05 +0000
Date: Thu, 26 Feb 2026 15:03:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"maintainer:OCELOT ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: felix: use kmalloc_flex helper
Message-ID: <20260226130302.jr55botfesrxqddy@skbuf>
References: <20260225040323.69497-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225040323.69497-1-rosenp@gmail.com>
X-ClientProxiedBy: BE1P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::12) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|FRWPR04MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 843beb2a-4794-49cb-cec0-08de753761a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	bcCq9idUfNoaCvI7ZLX7htEO2jXMcCJEWC0qiN8aljfB+nHMu0ukprkCCQq7J0kzxzMDz76hblCC4RQmdK6RXvvNqwBflmmeRPrXASmeHazcWgR4e6KITYEnkTP94fvKFEdsafhWE4r5XoiChX9oz0bqVQCsVgD9jTCiqq16Ne6dsDYIzcQxnvygh6j6FkLvfOol0LIz650Yr4kA9zbGUy0rrfnRF0Quy91R1izxChG3hc2cdeKXkhEyIaHXMrpA8jrVRFdfBxTUsAVlnK6o++5ZIhtY1T0w2fyFXAmFAVRLt83hSO05K8pHzoL4aLJQOtQioYxdmR9Y7fq0SRBOWYjr73EjKPZammmwM07G+JUcRRCYtwSygVhOQTulBuPns5vUqxFksQQegIzDQxoYwRJmHLHoLZ8/cop9gpytWnMQ9w+czxj4f00IEwSvEEd60toUnq7xvw8CLknxaNJRXY5h/5fDB7Ue7OWbKLoR6awKjw1WYz4l4swHHm33KzOGykwzUyZwQUKkM5H1kDf/MTdGR0bwqU1xdZSAD7NxBqzUOf5gFIC0KvgMrcvCELVd0wlulVKLFNPLwuecCSdv+UXN9ktl+UFsQuJ5JxuBaAen0ncLxY9DVvEG4wDa3a60S3xCvO0Hx0hXra1RSB2G2YQLoWTyraNdUhVFBouAgJ0K9f6uT75bB6Etjc/SoIaRsABn4ToN65MbJDVm+B6ghXbseU+xMaRZmFKu7EHbl7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1OrlRrt0TY00ziJjP/QaPqZ3SwKxsv4qeTKPyxLgQjNoSqmSDFjXyLQbpFB?=
 =?us-ascii?Q?pHZQKlK+l7mePNdMnTKXsHoLFDPM6h0zN5ndkRt6UzI347MY/ytqfMOd5Qte?=
 =?us-ascii?Q?/ZkDCZMM1kmLPVHO05VfeJNathGEYfxRjQFJQ/P6gGdZN0rf8Lauz1xBglgH?=
 =?us-ascii?Q?rbRnwfY+aOKAjOdGrqxvGsPKgu+kFgJMb9h5B6aprzjd9FQxMP0rP6wyxXwb?=
 =?us-ascii?Q?hHAS+6NxMuZ+u5PWlxkHVypTxIGFmNwSJ4a8V9tqNBAYmhVq3KGyVzLy/zDJ?=
 =?us-ascii?Q?y+Yp7Fy4flyIIaOkpWld5M1kHOtMy9cdwfr4/1R1BcB5e4+Jz2m2XG1cnnZd?=
 =?us-ascii?Q?Rn+sevHfUsNpSylrgB9mMoTha1EduaefZLO0dik+d/Ui31aVuRMIMBsHzb4H?=
 =?us-ascii?Q?By1ElZMTABtk1qB86tskjJEHyuoOFyP9315Vqg35plDq9iGlFQ8L5Z429n9R?=
 =?us-ascii?Q?v7FOyYF3saclwnBjvvlRCO767cvB+VwDsUumAuVNi6wCnYKC7kdwkU5dHplb?=
 =?us-ascii?Q?3/VftTplictqoD6kV7HOX7KdXo4P8/Kb28ViCF5kfz0pOqNFn1fG1BVH1MRP?=
 =?us-ascii?Q?JskrlaZcnvy4dt7ilc4GbgUCKOJOlmyJKMyku5/PQTxm0R0DMdadx5KjllPp?=
 =?us-ascii?Q?4Twm+UaEnaOehUNYO/H5I8igb93oYggRs3td+8vqYiLBlYUjQ6T9VvcQMQPC?=
 =?us-ascii?Q?nLqAt+sLzkBqNINbb8wkI2iWtlQTV1OtLFQRXMl9Ee9krlxrg9s2WFC7jtqR?=
 =?us-ascii?Q?gw7+ZRWPWXO3qYP6ftT205QRiQUBuYzVkdG+rBaDS60EyjRwmr66s/9piXKi?=
 =?us-ascii?Q?Cw5f5LdJEugYaeygbsF6vpvIZm0cp1J6q0kT5A8KaZKFlir1PBxnmzgTw1CN?=
 =?us-ascii?Q?svSeA9b8KYEIUdSjLBoIczzZAmHCgQLArkLOzpjaBgRArN/1+QTJ52HKQ/qR?=
 =?us-ascii?Q?qtR5K0AyqabLreXkRdudNsACarRiORLbCQ8AHpDMpFgOcJnZvGJpGgZm52NC?=
 =?us-ascii?Q?qm98YB0wfDFbqGYU1hQxw/XtnrKL29vnCc/FVVQDQOcftC4k4ssDO3myTgEm?=
 =?us-ascii?Q?9qhRRWuEspYP9MBrd58Yzp+XDvieN175dLVHHRvGo9Nj/1HSVBWRZka1xMqP?=
 =?us-ascii?Q?NxwULNqt/ilRlt9T6x1UA9+vZoU2H6IqPQp6ebRCbnpeJbzSj9H/uP11bnoX?=
 =?us-ascii?Q?+z2+Srai6CfR8NuyT8v4XcLMPnBo7CUFFREuxjJyRGy4z7CSGAJiHvynCdzK?=
 =?us-ascii?Q?Kuklvepb8sBvfQlCq04glH7gGobiibeLeeOYGy1+YvtQJx39k1ajgMhv/apo?=
 =?us-ascii?Q?GxyfXPcHJk02Z80BJAvl8+C2k7oN16Ux/u2fjoGlyUUC9A1qofvAsmawBkT3?=
 =?us-ascii?Q?tNm4pMvXpzt1h2nJxzcP8uwQZU14MT6Sc4r2ZRq42vGFj9oiZ2xhgGfpiqvN?=
 =?us-ascii?Q?7gbw7if1/Cucs/CECSH0XJXIZj9zoOI5RiJXGZbRQxzS9pmhoNhrr7VpYTO1?=
 =?us-ascii?Q?UoJ6GAI/87ia51sLJAKJbN2wcTIX4VFUv9/fhCMYys/jC/aHO/Z7M+erOUnC?=
 =?us-ascii?Q?Azd7wk+6s7Jfm8gmMnytx9+ePftma/b/zGH8FqFYL8LhsTTb1N/IwEAG+kG1?=
 =?us-ascii?Q?ZntclwwQtWi1ThZvcjmQN9nnhNtl2mZ4OP8a8+HnRDtc/FAYmXMIVLzu6SAA?=
 =?us-ascii?Q?rhF+O8g9tRSiTokg24q0zDulhD7wRN0n+LNwJZzYkJ6Mqei2UYNr8T48xEJf?=
 =?us-ascii?Q?xQIg5l+OCv06lxEMUIgtAJccOn7WxZmB9qCE7MlnhEG30JbF4RREuN/HOKNO?=
X-MS-Exchange-AntiSpam-MessageData-1: zLDJrAeoHC7Vo0NT1qgkpms8tfuEbftKP9Y=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843beb2a-4794-49cb-cec0-08de753761a7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:03:05.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu0fqBetEjYPgag6qgrtwqGJ8GW1cxIXLznPq4umnp7YsrkvIq/6LmbzfNBkTN7C8iAYUMtwgAtPDhjNfI4rJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261344-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF3321A60D0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 08:03:23PM -0800, Rosen Penev wrote:
> A little simpler than using a separate size variable.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
> index 8387dd208adb..cb132679fd99 100644
> --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> @@ -2254,7 +2254,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>  	struct felix_stream_gate *sgi;
>  	struct ocelot_psfp_list *psfp;
>  	struct ocelot_policer pol;
> -	int ret, i, size;
> +	int ret, i;

Please don't break reverse Christmas tree variable ordering.
And put "PATCH v2 net-next" in the git subject prefix.

>  	u64 rate, burst;
>  	u32 index;
>  
> @@ -2271,8 +2271,7 @@ static int vsc9959_psfp_filter_add(struct ocelot *ocelot, int port,
>  	flow_action_for_each(i, a, &f->rule->action) {
>  		switch (a->id) {
>  		case FLOW_ACTION_GATE:
> -			size = struct_size(sgi, entries, a->gate.num_entries);
> -			sgi = kzalloc(size, GFP_KERNEL);
> +			sgi = kzalloc_flex(*sgi, entries, a->gate.num_entries, GFP_KERNEL);
>  			if (!sgi) {
>  				ret = -ENOMEM;
>  				goto err;
> -- 
> 2.53.0
>

