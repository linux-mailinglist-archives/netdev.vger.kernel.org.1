Return-Path: <netdev+bounces-286626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CmrKGe+AWpqjQEAu9opvQ
	(envelope-from <netdev+bounces-286626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3150CCAA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7420300D1E1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A8373BE7;
	Mon, 11 May 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T7jrCwsJ"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68860371043;
	Mon, 11 May 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499169; cv=fail; b=aFCQMmSPvgLF/k6mXnX7KJuIK9HXPqKMVd7yBw5C7OhgoJj7iI3MHAwp1v1JG+fHyprU3DR+Lj1aOJoY3VEr84wbTPSwvabD6ow5KQwY8jin/MNdD39RouVLgPkZoQyMeqxGoHIardYuU4ptvAU3u1oMkqVXaHNsYUytAe2/1Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499169; c=relaxed/simple;
	bh=lEf8rEiGeAqVk0iuia073ASfQTV2SxKL63p24OsFZ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FaLe9sbG/RaXU2aU80VTTObzapzZIc9wT+2aVp+JR2+Fva0JzkQ6yHSC8X4xzocFgWQPFdV+gMHuHpZYfHRiOibxGFNtC2E6k/6Xt38aDPtjoKQQ+5rrFWrBKaUu8HAyG2mDg7EPd6L8JvKfwKwMmCVPttkB5mQ3U8gsQYnfbhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T7jrCwsJ; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4++fKiWe9SnwpRGpkUbCNM0dtJkcrzaycTu+930vakKllZSyHHaHkU6VA4h/RVvS0KnSQqI9VCXS2z6N3jSdSdD7qJ6V4MoULhCOqxSdH3RhuaKLGaRGmJMGoXJosxFMHaufMJLRfvdTp8uC1GYg8NSjjHmExa4USVpZhjdUcfJpkkDjrZkUNqp9AuRWXYIiXbI5RUQ2bX4df1olJ3iknOPP6CBb+sCUsJrQaGb+EChEDu0QTmt6qBU+qjLF5kJhLFJEtJcsHxMzD+sRnU9VbTzoCAUWdx0a0ZawxCIw2nEPnCuuBVjlyfs85E8c/FzucZ5kX5OLI7I0Nkh2UGaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyaLz2kPHAEkLPRF6tJQt4OJ8plqB3I4UtI++TqpxZQ=;
 b=C4Ia0yjFaTjBIgDBJaivdhaFJ4Xx4UlkCzpLFoypVdae8UeWY011KSHPqcN4WwDed7vuudlsnpTCo6BdI7yDhyKn2HbHJv5gMSE63qgYLVj+IH5QwrNrCx9TbS+RHZLFawg0JGXK05hSBIibOXWkq69GPzUdB5B3h03NLKyrT+vGES4FtgAPWiYNa4to/3RcxwFF0ENobXWNqI10tJ37RO5apSpzKDBkKWXtiyRH4mtUnwHbU8IoVBUQj+4L15LEnoqoAN/Ht39hYcxVEcGk0V0UemtpXuzUndD/I0yY2eDsjis+nUzR3ZARMi7Wy0V2BJZ5w42ivNf6S3dknpjdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyaLz2kPHAEkLPRF6tJQt4OJ8plqB3I4UtI++TqpxZQ=;
 b=T7jrCwsJB7KjZk5AotrBkhHdVmICIaCJGrQq55qe8vTgl7wd1e/oYMyXpID/OaI7xY/a4odqLGmGHGRLRQ7CNVspLV9/MLFd5SYBh4iSsB75HR/ZyQx/1otiSxguPalCHJ6thX8Tw60qyPPgG6+lYXjup3C38mptYqocyYkcDlTEgzai1Ee4WtwgdOGxaNAaKKdB0BCLaTDFev58SBrBAJTTgU5RDIp2AyuODT3LThspCLSHgr1uA9IW+ozrzE1qcy+uklzER+y026eGsV1HrjurNbpF4eJKYEoWpSqPA/aK2XuDSzEsJ7g3KS0Y5j8Dl1/W71iETgsjvd6KQSqscQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by GV1PR04MB10727.eurprd04.prod.outlook.com
 (2603:10a6:150:210::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 11:32:42 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 11:32:42 +0000
Date: Mon, 11 May 2026 14:32:38 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] dpaa2-switch: add support for imprecise
 source port
Message-ID: <f34vljqz7p3pw2jhea57kgkarvk2w2aowampv3ayju3jxcih5d@ndxo3joglkgx>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
 <20260506151540.1242997-13-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506151540.1242997-13-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|GV1PR04MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e802e0a-610e-4669-5cdf-08deaf51037c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|11063799002|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Q3IW1z9cbcWG1ezDg09XiJt5PW1f9ri+QHwbOl9CENYaxdTVqIszmzQurtmRaX8DQcEKOfjZ6xobzhkyj/kZGxGZdFBPyYTD/WXuccsVvpwzEEo2TIYKDrOLC5EbENl/5PnWp9mEQ2OJhs0+bXuOxXvEkE2l0TU8pDRSdsspfUk7bd2NlIguFt05PmvKgvPUFlJfR8G4rfQWC2J5/YIAa2bRFHiWVluTYk9VU2Kzt9jbso/RZYQGEYqDdHSiEljQp/IJRMvr4dhq9tNgUn3QuBjrZiCE9YBeJJIThBhuj7w/V9MtLiJJWAWdC05L2PYveKBkfjlWr+XlFXKhgIYQ+1uBZ8JNyTwZFDK96R7dSTDRBEpxIPLXFxFhOPNlkfm5O0Ctz2XY5snyeO1dL89F51jtc5Eu+2mDDIMMWxOQ36JVVIqFkcm6KZjzR89GrWlCMryWTL8ylGbTEnNP+4ZxPIOtaW9hovokl7Q9luauhHIXntOGZuFJBrMrEsy1X+sBkocmvzkdeQhBfu0+dXYvqtL1MMcWOMgGBuyD2cS6cGMnCHjheAICN2/vAlZnHReDJTr53v8FUmLXmXC20fZChQhaR+FCKwV8nbXsKDZTjfpuQdMtDMDg5QSRt2P9uplLv7b4FXrf+Z4X8RCG4Y0Z4gh3zvkeQ6nH1plc7Ij0wbPh6c8jFOoy8F4FyQsg6ZrD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(11063799002)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmDoGpkPd8e73aCGygRNoh8ufikTkhlmjxOUFpltYmgcMwSoRKZU1GMAMRxr?=
 =?us-ascii?Q?0pqbTR7oAsVJJRrSQdA7SGUGsMXVDjJCSlX4aJHHYDgH6yujpfOQ2fw3vB8G?=
 =?us-ascii?Q?ZQATwc3jyay7Zdzvm6O+1Tlb0DIFxQjZ5t/BR8qEjsToZ+ouB7ZH9xMSRM7X?=
 =?us-ascii?Q?dKxgGJIx5L/EvRxaBPwUtN0xatJacKYr20BjRu4AB32YX8cqV3hQYmiaxAyX?=
 =?us-ascii?Q?ErWJKeOyDVu3XudXHj6GQADX/pMatIKWAJ0fyJ3rD5YMFUZ3XVmE0pGZaCln?=
 =?us-ascii?Q?hjgvwRBRm09LsIcfzEqTpUe+KITsmbQ0IhudJQdIv0tzF3/keoAKKba8iFur?=
 =?us-ascii?Q?gn8md8hR8HhJsuAOTOgxbDchm+Q8rI7bxPq+Wdts2VGGwtNieUqKR2KRbFbM?=
 =?us-ascii?Q?FNHM66r/DA+2yV2N8eNkPeeS9+81MmW2I6sgOx1N7AJxKw5XUAJROpkFEzpe?=
 =?us-ascii?Q?NyBJWynNPkvfNDZItIRQjRxu3ElaJQSpg1mOPQR7vJtXGuYIAauAZyheV1aE?=
 =?us-ascii?Q?uk+wVHhoWgHlioOuobPvSis0hkKDFqX6HmFbzv+tzvyRogN8O3Keu+xgNwmj?=
 =?us-ascii?Q?GFajXbn6+qVBMMIlQKMHew6yd7F5oY5yG62tqcAeVWksg4Q9nMGVIPKHsI/R?=
 =?us-ascii?Q?90JbuorusJT2FOx7uQQ5uiTdkLIh5ZNHxdcU7TFaFepWcoDxgv6lN0a8iVFR?=
 =?us-ascii?Q?sPL4y0mI5xIYPl/YF6mZux1rrAPOEhaw+vI6q6HcAxyl8cib4Ja38inskimO?=
 =?us-ascii?Q?1MoCRw4La/Tmsk1lcIEzoleOINOWpdGS8EqTGXsdV0Q9kILEqabIGHlbnUXq?=
 =?us-ascii?Q?T4ViOJHwg81gKts6DefXJyZGnSXvORBptDW2HCVtE8i2xlSKY3m6eBvFRxng?=
 =?us-ascii?Q?e6beZ60dXdeoeRZVk+skYfQLOMOtdpvZKMu27JWQ67e2KV6TygHwutBc0IeK?=
 =?us-ascii?Q?hpL0GGu/gQHur6hWYDFnzgDoOY06mGAaAxu7OTpubiTdZOujn+ALwvYeeP6h?=
 =?us-ascii?Q?3YY3cTdPxuRHy4mjv/TDySe2WMB2BIWXncGZNUp2w0q0lSO77smwLjUfDqqY?=
 =?us-ascii?Q?kh3x3sRmBVn8YkOcDL5P5YzVGXBxeMdP0vMX8bjj8PSZ6hi6Pn3ZZS9IylE7?=
 =?us-ascii?Q?O2CiPFyECUbvPRfgoVHzpW7CLCvblBQDU86jJr6dpJrW5Sm0Fn8szWnYkiFT?=
 =?us-ascii?Q?SQt9SPHzcdDUHvJjwgrKRw/NV8TvdI8OjkxYnjJ0foKnvLBpWXEvq5QJ1Pcd?=
 =?us-ascii?Q?IZm6c8EqTU3V7WxYKcw9rAan9fncCqxlz/lNk1YkAnkeCs7vOIDMWu5TxX9R?=
 =?us-ascii?Q?qCGWPvjwtAD3oju2/oHzM7LzAptNV9jGYGJRkhF0VWnxeCdkEbMfXEDb65oo?=
 =?us-ascii?Q?l1zclIlfO1eth6H/q5XVw7fX5QO0LkbnQ7Z9aOpio/fUiMcKVW7HPI1YWhOG?=
 =?us-ascii?Q?xftWsHojtaRNJQDGKkeGYv8EMLYk92qFr6n1NC2I6y0DZISi/WD2EpCd/ivi?=
 =?us-ascii?Q?pFYgwT3Dbr94du+kJGK2n075zgOagknU4v+H1bIn6GPd+dt1Qw+CJXy9zzah?=
 =?us-ascii?Q?nPU887xepzs3P6ils2f3Uc7PqavX8+JXPwO3odmxjtRtl2MpKqJPilEOxdMp?=
 =?us-ascii?Q?qG9RFIm04JrGRJKqxFuQdd2HcovDwbhM+sABn1FqDW/UN8TXM9+ZQIhYQLts?=
 =?us-ascii?Q?/GLLczYyPm7R7DfnAU8UmbRO4Jwz1tcNEqOeRODMfhy/hkb0d84Tmc5pK/SO?=
 =?us-ascii?Q?rAwvDZNueg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e802e0a-610e-4669-5cdf-08deaf51037c
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:32:42.0470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+dkbxvnuC4KwVj9NERBGO+8qxXOtu2MERc6hLA8k3bQwzMYQxfB3g31tpQr3dF7P1kCTi1/DJFW3GOinyn2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727
X-Rspamd-Queue-Id: 43D3150CCAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-286626-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 06:15:39PM +0300, Ioana Ciornei wrote:
> Switch ports configured as part of a LAG group are not able to provide
> a precise source port for all packets which reach the control interface.
> 
> The only frames which will have a precise source port are those that are
> explicitly trapped, for example STP and LCAP frames. For any other
> frames (for example, those which are flooded) we can only know the
> ingress LAG group.
> 
> Take into account the DPAA2_ETHSW_FLC_IMPRECISE_IF_ID bit and based on
> its value target the bond device or the specific source netdevice.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 10 ++++++++--
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.h |  3 +++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 59ed06ed7ef6..8353d2230c72 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3075,9 +3075,12 @@ static void dpaa2_switch_rx(struct dpaa2_switch_fq *fq,
>  	struct sk_buff *skb;
>  	u16 vlan_tci, vid;
>  	int if_id, err;
> +	u64 flc;
> +
> +	flc = dpaa2_fd_get_flc(fd);
>  
>  	/* get switch ingress interface ID */
> -	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
> +	if_id = DPAA2_ETHSW_FLC_IF_ID(flc);
>  
>  	if (if_id >= ethsw->sw_attr.num_ifs) {
>  		dev_err(ethsw->dev, "Frame received from unknown interface!\n");

Sashiko noted:

	This isn't a regression introduced by this commit, but does
	jumping to err_free_fd cause a kernel panic here?

	Since dpaa2_switch_free_fd() is a TX-specific cleanup function
	that expects the first 8 bytes of the DMA buffer to contain a
	valid skb pointer, will calling it on an RX buffer read
	uninitialized memory and crash when passed to dev_kfree_skb()?

Good point, instead of the dpaa2_switch_free_fd() call there should be a
simple free_pages(). On the other hand, I will not add the fix to this
patch set since it's already quite substantial.


