Return-Path: <netdev+bounces-303198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pz6TExXKQ2oPiAoAu9opvQ
	(envelope-from <netdev+bounces-303198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:52:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BA6E510E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:52:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=Mbudul2+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303198-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303198-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E83723098302
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390D369D4B;
	Tue, 30 Jun 2026 13:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345427442;
	Tue, 30 Jun 2026 13:51:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827486; cv=fail; b=MLXRfNt49l3iyRSupnP+IdDwWKTn7U4tNFVVJJCaTvT2m5b2e3siwuO+8kup2zOaYbe/PQJ5N+7205uzLg3EP1wCrWbFbPEcAxMb/cYq9kmwvqCCQZ3E81NPP8Rpr9Tw4YVzBi8G5Ym5ZaTG02brPgwqw9O0cPJZaNKo33mxvvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827486; c=relaxed/simple;
	bh=Bdmfl9n6Q25+r2HhbA/kVvuIDzQAPHSAD8DpaR2Amxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEgnYwuMtxe99v8IN67fLFF1y3yYwVCAf+zZk+xJxCfP5rikOASa0EJXLA5ujbx6qkCx31rGBXny+Th7n0SxmVTVeFdM4fM1kV/+jrpxvTVLYir/eAyVckUWWQY0lXNdsvs82q5wZO++UTlp5ScLNqHff6C2ZAd05rTjMj4Sud8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mbudul2+; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0ZzIqCElgsSBuv1h+feWU9zRyZnv3oObcTLcrZJK9pV+uRaL5y2289w3woLrY767O+d0zBYo1G5PeYDocTdBwigUXDhyrq/AdlLd3qbRQaJqSTqGoJTYsArkGQ4CKlgcJyb48Id8ayaUadyLwReLPri0LhvJWA4l7YUWMn1tguX7g5coP7itEKtYUlazqIzzkfzCOtpRFGjf+Z5u1+Y2q3rsCDBeo3uHvwXOrfjnXQazySI3tR+10pb7wEuZoOg0hG2RTa6PuguInjOOJZ4PwH2h6/X4rcXxzI58Na8psZoalsX5FlTLunh7FafyCg/zxcxxduiT3HpMiq/oCUmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhOSgiLKrnCr5JBU0mrpzAGP8ogOxT3h6i6N1pnP3Us=;
 b=NCGE2/NmBynpJEuOgwqcqWsIDznIxNuMOd/nc5Alrux1oSAEBRCp0unfINbkt/HHTsTlIyS9iCUhW/XLkvUy7hK4yG/X4X7ZkLGW5CLnI29nCq3ttf1AYx/MahYEU6T02nXxZmzBpjIZzE/fvg9VlzsKccNe5isHi8829hzAAWmRNo7dP75NsxK1OC1jpULZhZ2PQhuB6S9dwN6ps0k4jd79smc3zPYd59u5A4v6+tndSjNtQNWs3rdlI5DlrfRvVy3DmRMZOVYQHLz7jLopDxsHrk4R+i3gamIZLXBN20p4AOlGJ7CxfTt9WhhrIgSUAM/H3nSSCoJccoDWSqkTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhOSgiLKrnCr5JBU0mrpzAGP8ogOxT3h6i6N1pnP3Us=;
 b=Mbudul2+T3RGUyyKoeLoizYF3ECikWAO5Zv4iuAHxFIHx0zGkt53tbIO4cQ9LB7yrqJgPEJEDlItGyNGRCdau2brQ3gDns4LwhV+pG33sLEs4C+vMR/HHHANf3/ULLaJu5wrwcD5Ztapny4VquiUOB5hTkjxCDgr6aLHZNWUgMtvcMAZWWdvk8SzCYije1SOAnYKD1ejXGCeoj4ipO8xaR6ioYH+tgMn2HliKFZOKFOnGRekMzhzzCM71QaM8+i9iF5qppL5iCceMbCM93v3rAQs5rO8Sc/cKhLn/TjJeqrQuAqhmeoytIU1M5hig30gbfsOHGdK4ATNQmuNce/ghg==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM8PR04MB8020.eurprd04.prod.outlook.com
 (2603:10a6:20b:244::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:51:21 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:51:21 +0000
Date: Tue, 30 Jun 2026 16:51:17 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/13] dpaa2-switch: add
 dpaa2_switch_port_to_bridge_port() helper
Message-ID: <5sh6t2yhjxlorkmxxulvkpdxpup73dr6mozzpnwzffxmamwqoy@wt6g5kq47y5n>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
 <20260629112309.154328-7-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629112309.154328-7-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 25991d20-1fb6-41cf-98d9-08ded6aeaaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|1800799024|366016|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iMyiLTs68NQHKJlRTAznpEYS9I9VCPxwOkzshpECgzMSOLR6PczBCljCF3ReuEbdv02PrfaYYMksknokLQdyLaUUxYyJjkf94Ea6twpWDjncjJjP+3uyM/NnA3sWQ+Nr2QoPFH5IkHnzNO9WyhfyblHeOUaOFH+nQSAa6lxTL6l5f17KWEVaQy0nnj/ZgMqCcQPXrv3VHZ4y7A7C+H3rZtTAd8QiWFSsfarbO22WOvzdib3kVPrm97HZYxNBv2NkkDJ6LF2ZuD4aj49BpRakfOj03b8gtoANerTGJ6u+niicrEOQlCyJDNPvFr8OxCNYrdLBuwL/Fm8H+GWiwdNC0rSfVa3Hxo8GWVnZXaFr0oFMojwIELJkdpXA+KowXR1sw9hGTOPRiKPlEgGIHmdoHd/zOd6X93VsmH3hcS9vR8IMkGaTKPIf1iEbr/aJGKJ/ncoJxmvYfxp+2/VuLWBtQcNARPX4F7utojRxHFuHSjsjojeiLJLTSaaUmlRUEL/eytNXE0rN2K3GZ030TX/XuhWX66aRCdfbPBzEsZpNS60xfVC6KGX8Z6BkqtGABYPlCULxlmOZ8b35VbwhiRNXx6/rlXzMhJrT8efYzPfypNR30vGWjVWS02D4xMA01EwUHBefSAQXYQMS6seoqnynmScBAdYry4aOOgadtfREFtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKzn3n6d5NvmdroGjiGFESccaDrSTxGEJ5LquqyE0U+OKpfD844MhmKneH4J?=
 =?us-ascii?Q?90wcauHqZsobDhKoHAv0Oq9TDRzO9RYFObUGIGIrMsAhp2fXJ/MJa6memwzO?=
 =?us-ascii?Q?rJ1FqGdwdUXAlHEWRZOchg2R1yh51rccJuAHekzu6z6fEIHEW6crB0o/lKtI?=
 =?us-ascii?Q?XWjl0qzmJSRP/xr3L1b0MoK+L1IXhTQ6w582VofOXYWDeaJ/CNoc5Kespt7V?=
 =?us-ascii?Q?oC0AortVe+H+teOh3XJqmh475ginMdzbevqKUNMWFUBRpDpUS/rweF5tWNgf?=
 =?us-ascii?Q?HwVkB13Avgde79+D8VNQ4Dt5KDynuYMRuGt6hGeFL5mIGaauI6DyAad14MTE?=
 =?us-ascii?Q?O6ILug5FEBel9UzgRu2PieiujkFkiQcPYLpxhTzrbIW3D83WB6r2FZhA52L9?=
 =?us-ascii?Q?W0GkuCdfojxHTXsBFdBQRhsVEyYQuIxosoiBZJlBUcADpROFcNwUv/iedCDy?=
 =?us-ascii?Q?HmtDP5fxnwHoJ9k25kmxowJGFcT9hfT25n2Z9jCvbt/djoRcaarBqcJygHhv?=
 =?us-ascii?Q?LZtCP3LujQpK4f7D3lFbO29syCh2HKkQnpLEru4zkVp+p6PAGf8jgADe9vbO?=
 =?us-ascii?Q?R+ps2lLuyGv/Z4KjkP6Ry+wLzGG6VlX3M12LV25gTRruqkOhSyuQwxUn5+dC?=
 =?us-ascii?Q?kNtIXTel8txOxubmUnsyZF4EYnOrlEUfK3YoCSGAsCP9JvNjaKLYl7HsRl2e?=
 =?us-ascii?Q?LfRMHOlIvYPcMxtQdS32Hpe1NWI7TPXDzYu+AwTBorD2w8mDd2Oqt9Rj1mur?=
 =?us-ascii?Q?k9M3bH4zaMSBNo/W/9+obUfKwG8K+pA8oJDB1YHj6fpRROjSzYg8t6d3S4lX?=
 =?us-ascii?Q?RN6cfH/75PxvHcoqHkNPvIOfC+PLJuy71UDm5FR3mx0LST0rJagSmmjOeBtP?=
 =?us-ascii?Q?mX2xEQubRju7Bl1YateCe7Aae2rphiVyxi52GtAf1gueJdDjM9TAttLffGGt?=
 =?us-ascii?Q?JenKrGRLSvHtS31txlKQifglSKe8bWmtsQzHIo2Fh2N01+1DMgcys4U56CEq?=
 =?us-ascii?Q?s3MI6ps557kVYtf23AsOHJ0EdrzS+qXKVYlh2+iNqrH0ST7CPgYATPQ7RhsP?=
 =?us-ascii?Q?ww7nc4qFpgMjlJi83AKrKgCBRACwSt19qAApoTfyupMBq73T+bBSWMho2ck2?=
 =?us-ascii?Q?BOAlVOYBlvTEbT74kKzxJ8STqAGPC488cST0YYXXMhJY6ACptlBs78808i8E?=
 =?us-ascii?Q?asiRxsqjpKpWMadWj9tf2laal4+Q5T7PNjolk4i64Zo2lizZbbkl2L/Zs1F7?=
 =?us-ascii?Q?bjgdmqcv7nJhFPAciujSxXqZ6yLy/ObOicnZFiqF3dVhV8KzpElslPV6NTh0?=
 =?us-ascii?Q?mmVzhM+qDZL8NcZXqFK9yIeV7NJktHLpzvOM+XZ9L4lqCvWB4EmtVNx3UH7G?=
 =?us-ascii?Q?D5QnwZFBYg7GIFmlpoWDFTWCj3yHEufdR5GtS+ZyeLaC5VsNKJs7iPgSnovQ?=
 =?us-ascii?Q?mLLWm6oQ0KqaUlW89i3TEAyCR4vzEhFgOOU9lRI+yjUr9M0nVrO+Np9nr0UQ?=
 =?us-ascii?Q?J0Cv1KLYMLqWPs+Shq/2CRwuRVUm4kZaocLktAQeMJHgLSxZPZq/6PN5b7AS?=
 =?us-ascii?Q?b8TrZqW+bcNMPFvK1Q7H1GxmbZoGzOSkjGCgEV6F0F9taFuNwS0W9/4ZUuVe?=
 =?us-ascii?Q?Hfs6CwovybL6OY72O3TjgsL7OdqxrlQO//ID0584tnojVGzuTV0mWEUjyhcc?=
 =?us-ascii?Q?aSAE/zsGwmZkG62yp6cuNSQE3+jRSmrVjwUBsVyk8MEyUSvW0rodK7FjMAmE?=
 =?us-ascii?Q?ZT3fvjYkvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25991d20-1fb6-41cf-98d9-08ded6aeaaea
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:51:21.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGYJAQh+4IwSOtG9dixfs4tCX+wEAnck5w5+7/g5g9f8YbaaYM0/iBNR2BcKzxcKP4EyfyastavO5H8aiOn3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:from_mime,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B05BA6E510E

On Mon, Jun 29, 2026 at 02:23:02PM +0300, Ioana Ciornei wrote:
> In preparation for adding offloading support for upper bond devices we
> have to let the switchdev framework know if a specific bridge port is
> offloaded or not, even if that brport is an upper device.
> 
> For this to happen, create the dpaa2_switch_port_to_bridge_port function
> which will determine the bridge port corresponding to a particular DPAA2
> switch interface and use it in the switchdev_bridge_port_offload call.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - Split the patch so that the first part only adds the base function and
> its call sites and the logic aroung lag is added later in the patch
> which actually adds the support for LAG.
> - Moved the patch so that it's a preparatory patch
> 
> Changes in v3:
> - Access lag field through rtnl_dereference() so that we adapt to the
> __rcu change.
> - Check that the brport is non-NULL before calling
> switchdev_bridge_port_unoffload() on it.
> 
> Changes in v2:
> - none
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index d4975d08fa44..88d199befbd9 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -2017,6 +2017,15 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
>  	return notifier_from_errno(err);
>  }
>  
> +static struct net_device *
> +dpaa2_switch_port_to_bridge_port(struct ethsw_port_priv *port_priv)
> +{
> +	if (!port_priv->fdb->bridge_dev)
> +		return NULL;
> +
> +	return port_priv->netdev;
> +}
> +
>  static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  					 struct net_device *upper_dev,
>  					 struct netlink_ext_ack *extack)
> @@ -2024,6 +2033,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
>  	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
>  	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *brport_dev;
>  	bool learn_ena;
>  	int err;
>  
> @@ -2035,7 +2045,8 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
>  	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);

sashiko.dev notes:

	Does the removal of rtnl_lock() earlier in this patch series
	expose port_priv->fdb to a concurrent data race here?

	dpaa2_switch_event_work() reads port_priv->fdb without taking
	rtnl_lock or using READ_ONCE(), which can race with bridge
	join/leave operations that modify it via
	dpaa2_switch_port_set_fdb().

No, that is not correct and how was this avoided is explained in the
commit message from patch 2/13:

	To avoid this kind of concurency without a rtnl_lock, flush the
	event workqueue as the last step from the pre_bridge_leave so
	that any in-flight operations targeting the current FDB are
	finalized before the bridge layout (and the per port FDB
	assignment) changes.

Ioana

