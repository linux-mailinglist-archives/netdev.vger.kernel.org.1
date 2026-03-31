Return-Path: <netdev+bounces-273617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG5kIbbFy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:01:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5624369E17
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E82730C2245
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86A3E3C61;
	Tue, 31 Mar 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oD/Sj6G0"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23D3E3C55;
	Tue, 31 Mar 2026 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961317; cv=fail; b=THDV75JAUuhU3lHd5JKBFEGmxMykZcJI2C/lCNG3/ntOaVOiuAP1UqdBbV2+ypbtj/wVH/2ig8ZkWRVpKomnMmqpzxywdD5sMUUHzfTDpQZaFc2C7MwiqcUDqKLwa3Dt1pH9DjrGq8TUXZ33LrJ2xFctfMr5/9kZPvapGjz+T14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961317; c=relaxed/simple;
	bh=3ZeWLuewAJ4Ri88AoMkwZGkwYmKljbbz/QlY6RtcPVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKqrcjinfyhsgXM6NlRR6T83i1WxapQKRk0KlZqPeaPQ0PLxrEzB0ueorW1msdzX9h+SadeblaK7rJ/X5qzG7gqWf8QJPYWj+hLAElztq7RSqNTIwKeKzDTOH5CZZv57XF3Gu+BCEGY4iHATt9TBbHoXVIBLPxnpcw/I3jISZN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oD/Sj6G0; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttaU15f4cPBTVEY2hHu5lWSxMOj2dD75uWIOHtofmLaTfBZV6ONj4DVIMS7JuydsYBp5r3m49m//wbOvQ+Z8a8WSpWO0aywt8AJg4B3ZodYAsj1vwiXtuccLLWfb4Nxul9fFwHDeabjQKh19JdTMutwn7lB0nqGKS5AyRzIDhcQvbHQ6A7+wUpadeD5qxJoVn39U1UIgkoG3+f4MIci5/YhTOiOc6d2Kcji9IUNHqo+GFtBfFsJXr2dsQVBGSa0UlRidgwfuRua2iYBtINPZyGw1IqdXysZD1IUe9EhzlqjwrANYMUq8R4UJoPn/rDzq4pK+M0YWmA6SQ6MyBs9Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjj5TuAag1DlaQBzYVslnjgcxdLv+6G63hOCzIrMHyA=;
 b=K9iwJwcl0xdTf40/+tVy4+kS+kSIL6v1dwOEYpqqBGyYIIIwc4/U4PpfO5gdfsZ9GxF0myu4/zHgT/wsqDZecXfw6QQEiacq7OgEHDqidAJBZfF11OlYviNNwCnRh4Le4ouWy1CE7FfgSi58exxKS82hEIe3yQm27PxYX6TmtvguhJhJNlH1zqdGERUsDAYPACEff8W4z2SWBEfMqyKMEth+TnJnD2a6PFQpOH1plofxu5Ywya6qp2CtrnWpBrTTJD74AHimVjf69qnA/rHeobl/6chMRqLqoEX2nkgkHDo+TXK57iNzY/M/8N1jjRVn9N022GdHvn2LzaDH8vEdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjj5TuAag1DlaQBzYVslnjgcxdLv+6G63hOCzIrMHyA=;
 b=oD/Sj6G0SsDOhXVgDKTm5gqT9Mfx/KuXLgnNxf2fotwBpkuCt6o0oyy1WlQCZK+rhVM2VUvAJg4xUEdHVuLcQ1jj8gXctrBICvtSuhsPhOeR6i824aInBxtQxRKJy3Fia+yGph5Jt+yOAL1NRQh4BCVSlphAoPX7ngjebt1EzLnokUeCX/HB2VW+1gaP91LzpN0i+o9nuHPDC/VRhJZO5Or3APgdVEUAdNlrPFs6EINqRRMorcy6z3snl5Qpq2g/x1PmqzYNadRq/5Mh3flpTlJDJ9RcT+FPUgd4S0eMPADh/5B++ImRcxiWW/lmcpk1jHgyWzcKtZQ1NZsheBz5iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by DUZPR04MB9968.eurprd04.prod.outlook.com (2603:10a6:10:4d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:48:32 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 12:48:32 +0000
Date: Tue, 31 Mar 2026 15:48:27 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] dpaa2: avoid linking objects into multiple modules
Message-ID: <j73ffp2ah3g7nfro2xicgyjkct6sypupvajbx2e3f37wx3w7hm@x66szdujsegb>
References: <20260330140818.1081987-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330140818.1081987-1-arnd@kernel.org>
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|DUZPR04MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec05a51-4d32-49cd-4107-08de8f23d024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7I29kDMCoFzn9/CLKRFeQUjnxTwnanjmrd8LTau/bhMdVehW0jJN0pbChabd0L7fm9dryfi/PB0qfr6oZ5V+ScaFpWP1zxXba1m8r7Zur7ypmaFEhc/i24hkqhm9Dpdqz77JSRX6xinCkW+T84hKROTFuLo30FGxSe2x0i7HnlGsCuIrkBalXkbeBMRmxUNdSk8goKBDZVc3JrQbjeKS62X6gnXRYEHCHH94704Cin4v/4zjsngOm3OXrIIjHIgxuAyNP/9huI7ZeTJLQDRiM8aCw/1JUYZoQxGCzbU6PNkTubgR2iJisVKunK5ktld/9eezgFhjdEUHC5N50MhL9GvC2FX1TUrjdbv4Ph+U1y4JfXuUJRcYZ2tPTsEXki4E9ZA4KjQSa46pLOwPWkySa/toNKIYVldolC5yhJPZw5T4AjDZftXVmw2lYUlzCBCDwSll7hOJb9MtcJOnUYDJogfUThOHydm6rA03EWsEHnWffYwcKGj6yH6Z3HmHtWPO+MNlClqFbZSKQ1rpmrGe4Lw9OXicdELp2y1NbWg/QgO2M+IyTO2RIL9Jzktmfivoyzy6snsSnix0+FXrC22XkPGXChVloWea6TL18SebEwed/AvZYHmzudAIlSmoj+hfT+oAFdKH1olyoKLF7LQrP3DoOIMIbVK6JKFFHpSSBIgjlxRremWDfjNFGwl0aBCaIzT9Raca/UBm0M5ksrnAr3h4ZZT9Iks7QyHBx/pNW1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2y6a6OqSLzvAbuXh9gtmG2uovlKgPSpH8bMAPI6h9FD3JAROBl37JPe8Gvx8?=
 =?us-ascii?Q?OWbXm1vpDCkT7dZXxoOYY8SMRHxupLOp1zNHD6pGnRFXHLYiJThn3bywtjPw?=
 =?us-ascii?Q?y/QPoeAusva4CzNs7FbJu/K9ixF0A58ZEHjG5UUdtKdaqZYQ2Q4yz9jth90F?=
 =?us-ascii?Q?vU7XCnMd+fjcTBQ+NtpwJvrRhJxazAcAPyRA1A6jHkKi1nVV/qytTIUod27l?=
 =?us-ascii?Q?0LUJYgZTFmEeoRn4YTCfLKjOq33UK9+d7L7Ds6IitHmTBGaaCob9zs+0SOXp?=
 =?us-ascii?Q?YFVzZRlASE5bOa0JegQzCrlHupMVmS5ixPagTcGOUIsBn2MNvQs9sbQDpITA?=
 =?us-ascii?Q?nHlh5Vp2jCWuHmjAw9JRSrt1/N3xL1uJuq9MLoXfjnhYjoMyz/sWmHIbAM0g?=
 =?us-ascii?Q?/5NV/oXh8N1OwN2yXU5AlbyM3lPrWwz/fYPNy03RzIT24ccBJSTFIZh8L2YO?=
 =?us-ascii?Q?Ft7LCMSyrkQSOV3hRlTmI9/WyrHogW9QpH3Q6pMLoTRXgtuouDaHBZUgpO1E?=
 =?us-ascii?Q?+8SeRsgtFemhXL6BG+E2hJxDfYESiw8yz1TI8VuljLzGudhGUrn4E4LKv6qb?=
 =?us-ascii?Q?CND66JC+++PiZPpARJ06VEgMNyvZ0Y6BcGQIcgTIML1JCuQJptE8pFtEXkpm?=
 =?us-ascii?Q?GeAQeEHJc7TMlsQoWZQEHcdJ3qmAvqzQx7YohFHxH6EpJTbSFkluecYIIQ9Y?=
 =?us-ascii?Q?c81IG9gf3OB/KJ7EfRLWSjMYbu8H83MqHPyDq6eNjf1gY67Et3k0HDMV7SPw?=
 =?us-ascii?Q?eFJ1wEz8Poc077eP7T8/PV7YcLpthpaXJdEbDsUEsDghX7JVz1ktAV6E1uiH?=
 =?us-ascii?Q?/G7FHbVTuXy9X+cFk/K+nVWpWlv1piFBV28Pe54J3NN3u/38Z03hcvHYKeBi?=
 =?us-ascii?Q?d4Z63TP9tYJrQyQ19FgzD02bRiZiX7tuiClsUTzzuhdn62F+GmXS4JJzw60e?=
 =?us-ascii?Q?AVy55Vf63wilwaqxzH7DpfN9un/HuqXgbjPX1y1HZUwxPN8Vy/DgbmqyW41i?=
 =?us-ascii?Q?kxfy2dxtasS97bwFxpvf4L6dhcgBd05imEhBm7yNS9RNl9ZLBMUXmUF6qYj2?=
 =?us-ascii?Q?1Odi/K6NbFxgTrG2wjahyyNCKRoCV69XIWSjKTfaR+kcrFYMiZAL5XANtKSL?=
 =?us-ascii?Q?Yao5Yg/ATTqGYdlcWKym8SNHAKJUukxgpw8yXc+QpEiwEarZSCv27x9epL+W?=
 =?us-ascii?Q?SRPRnXcpYFrxi+Qlt0cGGxI8dEjPPaw/y7rYREqwZVJ27dZC1pT3wZK7zyh6?=
 =?us-ascii?Q?y4JV8fS8P61CT/gi95Et3qflnic+kEevcwC84JssVL847dCAiljO8eaMbtuE?=
 =?us-ascii?Q?LzaE7e1rok6HelwSPlYm9eY9Bz5HEiISJgtqQUcs+Svw8+sqA/Iz8a046uwd?=
 =?us-ascii?Q?Om+A0VL3DLAOJ9nrzVu/VjVis/3gbZBMHUc6ZtnTZSCuiPTMIS7rb6GheFuW?=
 =?us-ascii?Q?joR8a8+K18iNNiqOc3Lv0aUpfVnrVRn6qf0hYVptTK9y8osQUWPLHDH8c+K6?=
 =?us-ascii?Q?W5usBMHjez4/9I6WyQR6OKe77aXt+FvSlH0w8HXDBwbQ+28FZzUzimBZlPDT?=
 =?us-ascii?Q?dVu1EU8JsaYmVbYyzff6iWAdRy4wtVEM/V4HRlAORN6JQK3UKQYzriFL+ruC?=
 =?us-ascii?Q?AacJxq9DkoPqoTWa5Jl2zsB8JNv7/+/tHRIpgugVz7xg8SN6S6zXXusgvYmH?=
 =?us-ascii?Q?XT/aMyu8l3zmpwkVQE63fF2qyCN/7RD9I63OWwj7A+JxRLKtWpB3ThkiMIvJ?=
 =?us-ascii?Q?YZQtXa/QMQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec05a51-4d32-49cd-4107-08de8f23d024
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:48:31.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4ZIWZ8QaDK657enG1/v4GcPaUsk9ONjGxbp5knYOmddQq44fwOFTaMUil0vhPnFngVPpTy/u1/VPcxx6pYE8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9968
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273617-lists,netdev=lfdr.de];
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
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,arndb.de:email]
X-Rspamd-Queue-Id: B5624369E17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:07:29PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> 
> Change the way that dpaa2 is built by moving the two common files into a
> separate module with exported symbols instead.
> 
> To avoid a link failure when the switch driver is built-in, but the dpio driver
> is a loadable module, add the same dependency in there that exists for
> the ethernet driver.

This paragraph is no longer needed since the change was integrated
already.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With the paragraph above removed:

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

