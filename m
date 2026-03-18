Return-Path: <netdev+bounces-268980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKyGKraIumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:12:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404552BA971
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D843030A72AA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92D3CF03A;
	Wed, 18 Mar 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="efo3cM7H"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE633F8DC;
	Wed, 18 Mar 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831898; cv=fail; b=BW7qmN1dLO52sfa1O7X7xGz9g6c3KieeAUYCAJdsu4ra3IdrRRKxAQmVS5ZQRWCpov3uyoFJCGTntxVGb6e8xkp6Xwo6PUQLI+7GNIPVRe+leudUVTaSP5eTErmpECE+Mt42dUBPO4XvjBIThIdS5JtHNfqrP92kNIgL2K0yYKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831898; c=relaxed/simple;
	bh=PdxsmXzmMkevmjCAW5hC3Vfmz3C4Si4qX6NPgGTUa98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NTr6Q2QT1oaSjLbxIG/4RCH3Eb2d3y/KcnsflV3+Cs641XEOdvOGsqkW2QI04CrmkHQ4NTuFbyxNTgWwmZmBPT1MYaQi1d5Gg2FZTlMYX2vmIk+9bb/C6vED6dq+DHK/u0JIi3Gni5KmhWrRNIUpKCBEwVX2bxuvY931fVBu1d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=efo3cM7H; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myvwRqKnQRmQwFsBnB3eKmrb4irsoklB82zBTthexurZc9ZHFCpjDuSs689suL6Cm6NKznfoA+pO1XJ4dM7rbkrb0xTlcYDqUjG3erTT/n+gWN8Znvldqit1rkeFgnevTBlKb+rSfdZhdFZiSF/JQjejmzy5Pwabd37hlV2vt3EwuHJc/j3rwZWSRDZCL71FWbUsoFIczM9YfVrssYArKmv+lxZZgAYXkCmD5DDn3YD1N47MGwZJWgy3ipJpWdKIXepJ5VcZe4lhP+64MM6y4uyyvh08n3k4SwpuB56qMdBP+zdgKqfrB06JDQzB9RLJRMBpPjRb0089ULqwYAAZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHrAxbpaxMoSFD7g6GUsK+nwr8tzHoHu8X7bERMODAo=;
 b=G29IYuYG0ho1SA116b4HlDuQwyIWjSh47/UGRb480Dqw/nI5sYag3Jm22cnToN4GqVXLArHZPc1rZI+A4/POZROv0RtWWnu5663e4Kfh9GRgAA3KBf6wgEGK7vYYxirQbsgTzNmZhOb1aF99OZEVRPr3MBm2r7MyVL10/Sl/966DimXWLLJzWNTRe+y5EXiZl9ym8ABt26+j+R0IQWc6mYN5AOvbC3KrwoepmNtiHYo8oUD2jV2NqWMDDDC7f/8OWnyGR+edPiUqCM+crpsADwyze5wAvGeYmW9ZPANqxaEVxVDkLKCHsGCcCIZsLtbn1oJFfYVEYi8dKVkHYAdIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHrAxbpaxMoSFD7g6GUsK+nwr8tzHoHu8X7bERMODAo=;
 b=efo3cM7HWfb/JN0+jZTsXKPQAxy+GpFwRZvPG8tw5E2uZrHEzK2SryFnKyJ7x73QV256HvFvsemHZQQP9HCJ/Lt0aDCJfmz6JuDnHNUnI/cUn4iS4Xjep7Q2nVwuKuUXCDEyDotvcLvSk7KFPLQHYUDRWongCnfbT/MU5SwpW8dvI3WEcc5gTl1qCwLCGHVERDUMCewV0QSvT/05taMk3Np89sHK2gLDN4n6A0+kvCcm7nw98h6nT4cAscObDJ8Fi4GejokVfT3KZaghFm+pzT9teNDW43B0edxocjlU6aX7FMHD+T59qc2mir4c2JEVO54NoRiVgH+8GyR3a4QXGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PA2PR04MB10472.eurprd04.prod.outlook.com (2603:10a6:102:414::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 11:04:49 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:04:52 +0000
Date: Wed, 18 Mar 2026 13:04:48 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: dpaa2-mac: retrieve MAC statistics
 in one firmware command
Message-ID: <git4zo46tirm7gckaw2uknpeacorzmykrpg2sjpsp6pyvsxzav@i3jvorjvzwt3>
References: <20260318101005.2088897-1-ioana.ciornei@nxp.com>
 <20260318101005.2088897-3-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318101005.2088897-3-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AM9P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::30) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PA2PR04MB10472:EE_
X-MS-Office365-Filtering-Correlation-Id: 850bdc3b-440a-45b3-8b26-08de84de2dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KtpTxbvTTSlYMEhp97Vhj4CSYIgxeP4ExJbD3XYv+nNDOj/g4umC6k6FX5stlr2rZRVMGXZAAeLPu965M46+4Q83HnY1Hqm/X2+doX3Kts8ccrm/fDVqAJ56yG57hsKKkn7cUX5jwfTpsv14LxNm50iPC+BX8xIxkfov1y1oTlwGAY74KnG748ExH9PvkM89Y1Ff+cegbl6SOH8g213qwJF6OglkIvVFFO2TjqJuhvbw5IjjVWQPJopkbzz6d3Ce9kkapnoG3aT3FtHIwU+rBEwUHZGySKlERiEAv4/XQe/E30pYYM/ePUq12m8+Uq40VLZVtDeM44uQAhTiOL12LOL5x268WrnLKvorHFHMg4fbWf+OrnbuGAEwf4o9jIZc4jJziOeo2Du02alWfMI2II9VhIw9ANCCGjxw6mEsFWgXnh0YJTheZxHGqZQtWwOYKiS0vRCbOKisbsXfWiYXEm8gNDj1ov5p1LaMiY2j3Jqi0YgGjrYG014gZlaAxsnFrNqEErMSA4nW818ZY1Ip4835MrscUF6ZRlDBr7UkWl1vHWWYCv2+mPXTSfzp1D0aZTgy0vSvfNVMpFt1jCvCsHrKaQgbhAGqU5PGmHyNN7LpdW51BOZd0EawuKZQIR3CW+Uf20qOuSaKH2mAJYL6C/Y5nTCqNgdee/7Yg7zJahj4Q8Sor0bIuYJCJqaACkO7f4i/FfqxOgSlGLHRyT5pNMMsb5w1gVb8nZmPKeUQnDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JaXoII9/3S8OxMI6dqjsmvZHOAMEvx1fM7OR1bubpo3hAaOFvJ7rfV8uused?=
 =?us-ascii?Q?DCdvLcuEhKvmx09TzJfppJ/lOZlVwsVJxHunsrWfhMQZYDcTH3ZUosEHDODB?=
 =?us-ascii?Q?A7feGdxUBBsJMHEzWoVg0rmXT2+8n4wvpWfCZMr1vBvNsuUv9vjNawb756/2?=
 =?us-ascii?Q?ilcUsLHcpyXnAaIS1lxtCJrM/F2/kELW7vMkB3Yl+mKH8XEVQmgOAYcmVerc?=
 =?us-ascii?Q?jn92OyJo4XnrbRpNjyaRadfZvHthrXDYdoeEg3tdPdp9OUdw6YeShgA5gNHG?=
 =?us-ascii?Q?NuYFpqJ8s4MLq6E1uqmX2+aFqT3SWh/0cnPT835oBd5vOqrjIvx2TMdt9h2X?=
 =?us-ascii?Q?cyN7PjWi0tdWVnfk2dJlnNP086uFNxX6W8IVxtFviDWOz+lTotN2nFUM8SLS?=
 =?us-ascii?Q?q2lu93RtG3vYh6YVMKbDbHDip5AApQ7ABMEx64v+V9HzXKbbK2arphiftVEl?=
 =?us-ascii?Q?EON7re7tPhvYQC7s7bPUq22izmpBUZH/SIebKKiY4RaKSbOcz1ij2WnJs36o?=
 =?us-ascii?Q?1uHMgDisiY2HmMUPOFGUegAmuic6OBPpfrEc5rANyu4kb8wQ/754QooUOq8G?=
 =?us-ascii?Q?J6BajB/a+KuP3Vec3dBeerl9St24pQOG9cwZO6SgWgP1hDDFvQdV92pkhIHh?=
 =?us-ascii?Q?Bo39KZoA2e36AqQvhaWWJe0OQBOCqS0QfTVcLvOgXOp5YPnaEo9tA2Xo+iOt?=
 =?us-ascii?Q?9ehbxp7CKK6u50/QPuquPBwUJ3181pKEgYg/WONKdRF9XU9eC9pJvckhKG1M?=
 =?us-ascii?Q?nsGcY46ZZtLtjIQ9R122GpynKKBGDofmPNU5qM8ReUBh1Rz2sK5U3J5qhjnV?=
 =?us-ascii?Q?FfGOMKlNQroQyllBT777hYr+PYpKDx70rdUgpq9RnK7JCox0VGJoXHBOQHMF?=
 =?us-ascii?Q?U5PSQl25mtAS9nIoqRJxLao9Gk+9ljnVtEc+Cc6f+JDE5ZZktJWZ8hEv75DW?=
 =?us-ascii?Q?0FqPNd9pX0/j4FoAqacJs0LKluG5Db/zL7xXZpJUougZ/biropfZmyLgm+KD?=
 =?us-ascii?Q?Z808bcTir5EWvDefP7WvaYJRkl5gNsE7/ufIG/Tp7Cn3IbWifpYecmbjXAfU?=
 =?us-ascii?Q?3+n9hNt6/uzi+f1Nw3kZ76I4Q9awFluY5+qMMpWTcolC8Owu+IdCHikrI+j3?=
 =?us-ascii?Q?34UlAVbS06qAutVq1h1iqG6mmVqRzUl2iHPBS0r9T6zq+bT6Y+R25w467zun?=
 =?us-ascii?Q?Ta980JEJpnXXV+TvOxgz7tNngqsNytoNTvgHmH5RN35P/hqjH6CdEhepMmKJ?=
 =?us-ascii?Q?o9paGvV1rXG7VFpuSNwkVVwnud2OSq9tFen8AL4Dkea8gVzi+geT40pvNEyq?=
 =?us-ascii?Q?G+l8exPMBf+E4hkmO/x4dsc6tJvPIKkPBJOhjI3SQ3U2L11UefqzAId0w64z?=
 =?us-ascii?Q?caJTkKbDlYrW031zpXvX3voC/YniDQHUtgDejx0h8QgbwQtz2GMRbCCmSg9d?=
 =?us-ascii?Q?x024W4eWA4UFc7nyT/dL+yYgO3wHbq8It9yD+4grIH2jIFVgNpZrfvAhVV8Y?=
 =?us-ascii?Q?XhnzMYMWWPKwVWYrLor7WyoKO2VxrdjTBPWPjbfhTYgRQlkw0irA1ZTRy7su?=
 =?us-ascii?Q?ozK8mVu1i7moNdAU8KFVeTt3TKJu/twg+GNOiT1Xf700L3dMYj9+3kZl4bYS?=
 =?us-ascii?Q?ACUbqxJOgRAVUx3Aur7HUOXyI8JaHS1STpzmkqVzau8asrp/0GVEINyD+yyY?=
 =?us-ascii?Q?3qou83DMALwtxTjLEOZIFHQFETVTyxexKHH7JykEcHv1YsO8j3h4pobTm6JV?=
 =?us-ascii?Q?wAqggii84Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850bdc3b-440a-45b3-8b26-08de84de2dc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:04:52.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k90pIZz+RTPD4JZt48C3e6uQ0Eak5GSmHp6QQcLk3OipwhNTwtpQWRXCjcp9gnziQz5c10trny8ZWcEuiZ9ZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10472
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268980-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 404552BA971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:10:04PM +0200, Ioana Ciornei wrote:
> The latest MC firmware version added a new command to retrieve all DPMAC
> counters in a single firmware call. Use this new command, when possible,
> in dpaa2-mac as well.
> 
> In order to use the dpmac_get_statistics() API, two DMA memory areas are
> used: one to transmit what counters the driver is requesting and one to
> receive the values of those counters. These memory areas are allocated
> and DMA mapped at probe time so that we don't waste time at runtime.
> 
> And since we are planning to add rmon, eth-ctrl and other standard
> statistics using the same infrastructure, make the setup and cleanup
> processes as generic as possibile through the dpaa2_mac_setup_stats()
> and dpaa2_mac_clear_stats() functions.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

(...)

> +static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac,
> +				  struct dpaa2_mac_stats *stats,
> +				  size_t num_stats,
> +				  const struct dpmac_counter *counters)
> +{
> +	struct device *dev = mac->net_dev->dev.parent;
> +	size_t size_idx, size_values;
> +	__le32 *cnt_idx;
> +
> +	size_idx = num_stats * sizeof(__le32);
> +	stats->idx_dma_mem = dma_alloc_noncoherent(dev, size_idx,
> +						   &stats->idx_iova,
> +						   DMA_TO_DEVICE,
> +						   GFP_KERNEL);
> +	if (!stats->idx_dma_mem)
> +		goto out;
> +
> +	size_values = num_stats * sizeof(__le64);
> +	stats->values_dma_mem = dma_alloc_noncoherent(dev, size_values,
> +						      &stats->values_iova,
> +						      DMA_FROM_DEVICE,
> +						      GFP_KERNEL);
> +	if (!stats->values_dma_mem)
> +		goto err_alloc_values;
> +
> +	cnt_idx = stats->idx_dma_mem;
> +	for (size_t i = 0; i < num_stats; i++)
> +		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
> +
> +	dma_sync_single_for_cpu(dev, stats->idx_iova,
> +				num_stats * sizeof(__le32),
> +				DMA_TO_DEVICE);

This should have been dma_sync_single_for_device().  Sorry, I missed
this before submitting it.



