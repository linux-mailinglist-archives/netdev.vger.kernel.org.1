Return-Path: <netdev+bounces-261015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHVvNTsXn2n3YwQAu9opvQ
	(envelope-from <netdev+bounces-261015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:37:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98A199C12
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98AB930048D2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE73B8BC9;
	Wed, 25 Feb 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVuvJO/o"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846C34EF05;
	Wed, 25 Feb 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033797; cv=fail; b=tLDHR0NPr5a4HcvC5kijxwCy7DjFZh+xB4bqvHA6yyCF5KuER/kCvy7msIOtKRXSUSJ74/af1rHCtjRaQVCWUduayEVShegKtaJQzxRyDQgf+mzNSlrdwX/TLUZ+kig5fJ1lxZAGD6IkvxPhwGpFdBNrGgW76mzJPztdoBYPa4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033797; c=relaxed/simple;
	bh=tiMFteqLW3ovZubxe4pPhwyZf1+d0Vj6IlxqVrZVXmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3580/pa6aExog1PELmAl4bjMl0ZrZC6cnJw1uCVyeHxwV+LTuwyRrOWr0POW5Mfz1FhM8rTHsI+pR40ieqs7xXg+e69jzWg+hceINboatChWoOvQALeUG7GXENTSg98+mDqJd31nC2ZIP4qu46G2aYdndwuo6VHXticqgUhJ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HVuvJO/o; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpQ8UaFOZVz+MC083n8fdrxpALqubQLGYroiwPvsle3mnIuJk2Vw2rY19q0Bb6rK4QVXMJvVpVNcI26elocblnSnU0B/H+zOWD87vQ7QX1/UvpPqCMbixzwbmFG8C/VDTC8Nf4Qh4HOcuEI7trc9sEMeZYWfxe67XwDNQx7fV86g2yyqv2H7x+vc6m7FF9Mv/si7zO1DxX4Xt7Q3GNldu1QcdzuEEOft1yRX7CZj9AKYfToAbSroqGp7Mep7AKMNukXeC3lcatkK4+jDdDMFJ3vLQWN8QGdwu1TAcrlq59yqaZYE3rSxFAZpkyW8Z9FuH+7MGsFIudde3Pz3vX8efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBlSuBMFmVyHxNbiomz2hSYybUXfR90cF3tlgi+Cfx4=;
 b=BpxZXXeB54Ex2LYLnyTDFx+n6d+ftupJtYC1hpngdH+4AVqIuNrT+hd8f85j0dmqHllEN9sENOCbRjCC0dXfF5LKWtj7JKnB/v+DXnUoWp04lr7gWUacRAdva80rcc31DFSegAg6yatDj8opkXgIyEY4S6uFoJ2pAbyfUO9w0ZgsXauWA+8ALqAbb5R16oQoTyoGIL3typW9zV4BKdXE+WmVaqyEY03Q90CJgn/jALTCBNH+DkYkAMTFILa1Zty7JnREAy2zRM/FRnmHA/u9YV8VCAvxjstN9MY9adznrtvUmedHiA/swmUjCy2G995+vmoDqPR2Qjnpnq+aHSxHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBlSuBMFmVyHxNbiomz2hSYybUXfR90cF3tlgi+Cfx4=;
 b=HVuvJO/o2bmM1LhWVzz7uSWfCqRXU4R61PUxXm8ojsuBRQogEZyjyfhy/BlRJp6V8xMT6zBEZdHax0r25lMQRKkti0vnyRWs99d4ytf3oJMSiPCS0n1vcr5GrXfzQi9W+ytXP+pTQL/EplidS9iwyAnMKr6aFXKqP7U8iUejqvJLiKTlu/f8WeTa5fiUTrgLqAFMyy55P6eSXp5310W99QGmcabdQWrO0wyC0/m/y9fiaLoKzGurR+3NqnrBOoPxuovUTvC6wxHraGYX/9TYdI9h/Irckdv+l1zbMqthoWP4ic1wnSPopHclJNP6vkZXnTvBQjJ4hDuPfCW1pcBVtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AMBPR04MB11718.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:36:32 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:36:32 +0000
Date: Wed, 25 Feb 2026 17:36:28 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Message-ID: <yytdvafmcpl5e2rleohomdzsad7vtfh5tqutk5sbeociaqbv5n@skebuhraj5ce>
References: <SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-ClientProxiedBy: AS4P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::17) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AMBPR04MB11718:EE_
X-MS-Office365-Filtering-Correlation-Id: a131bd6d-1959-4964-48a2-08de7483a6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	gQixzN7rY1iNuv7bI3iH6hXZIhHnRKUTxq0qXPckqq7mM7DPWemRuoBgireHpN1GNKgLk1OYnNzl2RTvSl2o2B1S9HVVnIWhXT8h3KHjctqvBTI1YTtxXmCwy9kEgEXr0qRa+RypyumlPqTHZB2RbrRjebiVnS9vIJPG5uul/7v3gVyy11uhi7WYT586VRd8qSABYbVB6U/o70y9t4w8URlHP5ZmMLvp/2FT3yEFa+CQ8MwL2CjW8o42g8U11qDJrf8zXET5qOVci/mVnzoTI0CJr6sY3rIdp77WyzQgDpOH7IMp5e9CN7ynJ7+OdAuRT8Y2CRk9ZASFgfFIUuP/h/IubW/SJd5714wGOe6oFXogRpRvymI54edmCwBdJL2d7e/btPEUWoK6yLP2HJP7Ila+CdYI8vd7o8Kw/GHiaF+JejZztMoWrmhR7iZpLY4fUeSvam04DOVvb1A9uPgnLWvDNZMWCR4nA7daK1pNuyYuZamsFm8sUiFU8w0XVBCDaex0KNWJVrgLSvRrpdvK3pfJyMbyA7bgJ8E+DtsCjmP9+Ugd1Qjxz3S8ACmlB/qMEatI6j1Q70FyJQn/D32iBTBM02KAY2cTFlMxQNP8nEsqrSWsyWlXzspZo5j6ERQabbWRYiN5BBsXVb8oGu9IV2MfzzIkpSJ8M6MfvLD8e0cGf23PW6Wxzs1eh+IOd9UoIbt3h1UfQ1uIvMW0n5AgcUe+5lqWdUAzYoHPff1DFyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQ+IZ/Kh5VdqVwZiaV69HDAITDLlm1EV1yZYqNWGmiLsyf2eiK7GfoT/681D?=
 =?us-ascii?Q?nbs56nxy4tFYbZjgIQjqVqsmXdvdKNGohprxhTWOiBSqnO9bkpiNcw/xtU+n?=
 =?us-ascii?Q?cv9a5D73S4MwEcW9V7vNzc5CbDeHfsyVnHsPVQBqwkt3GZj+CJhuilXXh62o?=
 =?us-ascii?Q?47IldKqtbTLf+sn8thFr9rlk82ce2M4TkKn5FbsAtPcoQUYwzOnJl1HiOqjW?=
 =?us-ascii?Q?Qu4B3o/N5D1i0FzksKDHTCCy5521hUjaaO/U9E68mnkZCJApblLx5mQEa/Tt?=
 =?us-ascii?Q?EiNSctUo23KNmPLooW1jKzPHtrQXONr3OyLnPKwXM8IYtL3UM1mxrqXjRiQX?=
 =?us-ascii?Q?1Sk4SbSXzEQ7VAhx11BQ5bdRYy41lRhQbrJX0f+uYGE1QAozeLtSJF9bkDnL?=
 =?us-ascii?Q?xo0ZpPSo6lN6krOKAvI6NYoAS3zrg+4ZojgiuDH1K71k0rXLCqBP/p9JpvLG?=
 =?us-ascii?Q?oEMK2SLcNqOA+Bv+NjY8lmIBkuQMhCWaS2etQI+x8vPlhNYdvG1DtzvugR4G?=
 =?us-ascii?Q?3T1Y482KDl9Y0RLDW7LK6LALaaVPf1j7Y3St0nbjb0A9N12kwnGkVHTO1rg4?=
 =?us-ascii?Q?kaP3rk6pJ2T9Og3RLWnp7TscM3xK3tTphXzhEiNr+zQ5SszFRScvd9sNOD+p?=
 =?us-ascii?Q?9TyZxOsH74OSL+zPmrjLI2qvh7/Mv8C/5ib8YuNuPcF4Mf9J2m7CaKOdavuc?=
 =?us-ascii?Q?UGwWM5RyDDybRzMNHQ4b7+eOjIph17AtTxYgwTeaws+zpFR+xUE5XS1Ul6gU?=
 =?us-ascii?Q?3Et7fJqxZSXndWQCmy3BOgCirHOMle4OcXaX9SY9etEu1hs0ohJSY9DxqkdB?=
 =?us-ascii?Q?3c0DbCwM9YWidzUMeGDoANd1Vl/anHtte+r363aOrR4dT6SRT8n60qWZFuDZ?=
 =?us-ascii?Q?2llhe0MPjaMpK9pUPg6aDxFN80CFwpPbt6FcBIKwp/cjRLzRNE2OnQ64qRQt?=
 =?us-ascii?Q?/9kd82DNupqCNWIM+qE8+wD5nRUpAYSix7ovKk6CH8thpbMMzagcu8FZnX2s?=
 =?us-ascii?Q?4YH8vfg4GaCDV9nrDu8VYdgmbxnOGgW4Clv0Xkh/G1yBX37OUML3cYold1fi?=
 =?us-ascii?Q?/YYV74LAjfrsgh0nYRIhlqFgXuxwGGzfTQbYgiA6hmwl1o7kLkSw2P4F8EOC?=
 =?us-ascii?Q?ZEnj6Om6rk4sYr7FbHhKgsN6d7zytmSqrg44xJhF89Sje9KNPrepAkCmm1ef?=
 =?us-ascii?Q?NvP7FCH01hvEpM0UI5jqBC2BVuzrz7Ma8vJz9VUetJfKnZ+0jjq2D8CD78VN?=
 =?us-ascii?Q?FE8bgr16MeFpISScIYWkOR1XSNEz9IbxPnCe1uwduChxUNZuq7VDKHOtKoFo?=
 =?us-ascii?Q?Mdp6Hgt8NvssNWPczvzMfGqDIracbbPChDDSc2LS2Izqoe+NNMUBCzcUtcAF?=
 =?us-ascii?Q?eSPvsgKTEpSnDZ/RTdD5q0wI96H+d78i/fvXbb7RPmfhJKR/Dtgdr2NemHXM?=
 =?us-ascii?Q?7fvU5mNkOg2f2upyFA2tqlqk1/54Uvifoq7wfp/gbHGOVrM7La5CXGuaUX5S?=
 =?us-ascii?Q?xDztrkZr44EWazQr8pV/eGAb5o/5tIiTtYkVqEP3c5/TCzvSQyVrGehylbWd?=
 =?us-ascii?Q?yFiomFZ9H/apMu/6AlUUOynAIRMkaZ+vsBqF0fFGcRci7vsaeEpdWewhrGkw?=
 =?us-ascii?Q?lLdWBe5VkA6CHp7coAVs6X3gmWn9NyZ8OC1adYUBJWRe/edsW9st/r3VI+yE?=
 =?us-ascii?Q?3rTsxSIcAJvMRyYh/OUOjUjyzcRh/iN7fJ0GFzjG96j9wim97hXDs/K2pb+B?=
 =?us-ascii?Q?CpjfjRKGoQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a131bd6d-1959-4964-48a2-08de7483a6f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:36:32.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDPWSmKFg3+xrd+8HWAzoBGJID0DNeZqgV67eaFhLmbvAr2Ptf48BrA16da1AaW1yh3VQW0S8lMRC6rleK9V0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261015-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 3C98A199C12
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:05:56PM +0800, Junrui Luo wrote:
> The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
> but never validates it against DPSW_MAX_IF (64). This value controls
> iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
> into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
> num_ifs >= 64, the loop can write past the array bounds.
> 
> Add a bound check for num_ifs in dpaa2_switch_init().
> 
> dpaa2_switch_fdb_get_flood_cfg() appends the control interface (port
> num_ifs) after all matched ports. When num_ifs == DPSW_MAX_IF and all
> ports match the flood filter, the loop fills all 64 slots and the control
> interface write overflows by one entry.
> 
> The check uses >= because num_ifs == DPSW_MAX_IF is also functionally
> broken.
> 
> build_if_id_bitmap() silently drops any ID >= 64:
>       if (id[i] < DPSW_MAX_IF)
>           bmap[id[i] / 64] |= ...
> 
> Fixes: 539dda3c5d19 ("staging: dpaa2-switch: properly setup switching domains")
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

