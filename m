Return-Path: <netdev+bounces-272226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP+DC3aSxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:09:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05033B429
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DCC303C001
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E973988FE;
	Thu, 26 Mar 2026 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kOfCS0l1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C133DED9;
	Thu, 26 Mar 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555613; cv=fail; b=N187ngT1cK7IgpAxtwUO03Bn04AuW1HV6X9dYQmodskyTftcJ1ZmDvr1V2veMPXbmipfYiDs7YsD5+48el/P6f6S6OGNJx564J2a/cHTA/3PwmPZLUnxLacOiMFgWaUr9Ymrs9RKE8SP6JUbb+aIKMVeEgBnh1/j7HU7qzMRIhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555613; c=relaxed/simple;
	bh=6cycWdRWMS6Nrb88y61f/6Tb6K+ZUB2MK1ESyDfggZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMke3JDwBnFPSmZ3eMKjxW9KhLMYgLPQegm+p70jgcI8vz9rlKgoyQ4/G7NcevseKadfyGZqKGBLUrYjhq/aQssVwYcpGbwU4Z9mz9TIQxUOrXuyeXjvTFteH/+bxIaYprtzSYQ8L4MGWNKZgk8sX/JGrxvp7umnkQAiTmvxYXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kOfCS0l1; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEWmyYJxioWVW+Nkzm6nEXNQOEsnkCGFsohq8tCeUF1un1+hJFrwnsRz4IvVx6gcHEhheVfedUUZTz5C0RI8rqFuaMBZ2nnZYWxSyQKVSUi7ytRRq7mx6vi1mt0tlUBL14pq3GBB0qG30FNww9/dvGRJfkAOOksK4eQPsAr+oQ5uwg17YFhqg3u9T4+w2ohni3DapiRwRpyHyBwOUpeOcBFhA9E2yXtzaYcnpc6vNUJTuj8l5V8oM129ulbGLPPQn8OuACD3pJqw0kso6pBV3SDGffzJa1MUKVcvWgAPCOgFfyaE7GlXRh2nCU5hidiG0bX+ptNUABxuDMtwFkLbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ6j2iTQSvAYHDxWujPLEhFrbptbIAE0K3DrF2OT1a8=;
 b=P45XLn0UN2pix/a0FLz2KEMCQMMMo7APq+7541egYqBJgs3vO0d/TnWYPg0yKEmIKwypEx/q5CXXawI/tBNh0G1Orcnqh5mvxANHHDveMR9ZeLp3FNkc1Dyxz+E8hNPUAtLjUlDL7lpCj1NxHJAEup2fBrN6FNq6V7qwU+nrblrHFTDDAh+WtNlewiHDGGnKbPkX9oaBaDxiGyDh8sHulPNeJp4gjUhKRqRj5LxrPp6LNn/tHE+5r3C7JzITuQ4Gw97IjLd3QwKILgzjij5tK9y5AOKhugGFdwCCnY90VtLZqqjCWIxJeVARonfizeQWTMrEZ2P+w46QnFo0/oPKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ6j2iTQSvAYHDxWujPLEhFrbptbIAE0K3DrF2OT1a8=;
 b=kOfCS0l1lN+0p7ItfMtaBRyw+2vMA/O01xugk8+xIeR0UCPv17apbt57HRQOn+58Jm8Zh7JjDu/Wsc2pioRKJJShJpXZFoPHIFma2nGnDpo0vfFlKsfdZQ4dxTL/WgqYSn9ErGZwPJiuIo/kaJVbDanjyLqELsyFp5ShfoRl+7LgniQeT4V1zsDk5PiTRAae0m9DQXOV+0j5RMTTg9R92hfWZPsCrY5nXZMa4WBy9gMXBXJ+D9gC2njrAulauGIzB8OQrVvOqHkIhJFhwxVIqKwGEag/O4cN7VzLczG2BC88HshYeM6Vp/SaOh3wWkQDnRH+RGnEI+85ep6bf9gCZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8298.eurprd04.prod.outlook.com (2603:10a6:10:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 20:06:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 20:06:49 +0000
Date: Thu, 26 Mar 2026 16:06:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
	chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk,
	andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Message-ID: <acWR0QwRSnupmCvI@lizhi-Precision-Tower-5810>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
 <20260326062917.3552334-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326062917.3552334-3-wei.fang@nxp.com>
X-ClientProxiedBy: SA9PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:806:27::30) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 339072cd-f8d9-4d2a-60a6-08de8b7336d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MfeF7QYuezMxxSatTQOo5EGGN+6uXb6zs+DRNDBLGXVirq7pzUaqsJeD56GQea2yW0qOpHFb/w2gZ15D1rkH1PcoUPsHtMfGZSokkfiV6q1XfFZRZoMx7am9EI3c4c1n/oBT+h20bohHdP0zxzQCLMlvnOVQAv91P6U10NgQ5Sihqk3b7DZMgi3fQd3BqTJvYYAhutMwMD2LcBZd4STyxgtB7seUoC1VZsOs/tyX/5aw5pop7qDZqxncDSykg+4+gapdtq29gc7JhRNAKRDpnm2JAao5xo13nUcjZKWvI16CycL9++RunBxWyLqVDyPNpTdm+ihyRs1dwLk2Nh6ZJ86nm49zzrx2VduewmssT92TwNVu4YXUY0lODvkweYx1hCU6RwNXIkSnGC0D0+z9Zrm/OYXokH/bSNqos1bqk9A2Ln9rY6zz1g8G5FxWgoIZryaCtutQVPjU/ww6jOL1O9P3RQZEX0wE4dZzWU0aYSSQGy4/6P0ffhWfCv7NYLPSzpZgvtoxPCGa1+6ykRRICHWPJXIwqnmU4XGeOPf9eTUn2c2hIalJJmlFCEPqNgohMZNO8DoJ9pHqcqYEU5q7ncQmNcpRbVagSPAuwnXIAfX88ogvBCBT+TMwCgrYj9tSD0XIJ/gkA/FawY3kHAV8h5IjF7zW+fxFoC78ZQFjH8JOJbGav9WfEGfrlV7lnfOYuDy284P67KBwWDUEzLtDsQJGRhFlXusrrY9k/An6Iq2mx+nj3z1KtUfXcdghm7e9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1D2bVDC53Mu03U8bbHYeNrMMzuoJrwr3ILpYepa27o8OJVJ+fkav8VLPkob?=
 =?us-ascii?Q?vTrOvKq4BV50BRk8HMBLgBIKp4GTdKVgO1qrXhdvXP42jDGty1lcmP515rTk?=
 =?us-ascii?Q?L6WExIxZN+mCBhaiIqODXiRcDdJSUyZ57aVVQRFgifX0X51EAphpFgDs5B3n?=
 =?us-ascii?Q?bDLAUtxSHXYMUiP3eARJ22gbkWbHQPsaVmvhD58aXmt8OZADKSyigK1l3x3+?=
 =?us-ascii?Q?1SFuZOABgYiPpPi54RHOv5O7R3/xSQCymO5sPu9gTxj4BsbYKemCGJsxiIpX?=
 =?us-ascii?Q?IfIgVixME4CMt2MzHnWz2YcFfjUGotpUvtu8PK6ljdC+HjrJYxyGShMq+dsR?=
 =?us-ascii?Q?OvKIwpz+R9ss65FQ59RoiNnH3gT5btKZ+vz2eQh9oi5GjuAjDvIi9Gx54K0o?=
 =?us-ascii?Q?FOjxm/8FDO9ero0Zk7x5ULDoXKFdw/DbBqoSR8dug0I/NU6vWGqhDk0ppNlz?=
 =?us-ascii?Q?55rVaLm/vTYbwL97olgT6baCkkp4zRbSzu1Pd1dCOZENCq5c0+YCrpfstVVi?=
 =?us-ascii?Q?/Jt+vPn1zDrgbvO62Ctzyv+KLYaKOGmw4iZ801DsH13ZbOWQhx+yiCN1Wo4g?=
 =?us-ascii?Q?dGyV2F/kKAYs/NMaOS0G/h8ghz+KnSj4tM+nixlkMt/uJUeDGS9wGvaKRe46?=
 =?us-ascii?Q?IIhN6uvNF3lJ74pLLDA/AeqaWHqkuPUNg6qMf2b4U/Smm4/yd3p1fQgqt208?=
 =?us-ascii?Q?NT+Cfrv1dREC116md7cBTTPRCIJJvJ6tDZQBBHoirgGja3n5aEd3fFWxHpZJ?=
 =?us-ascii?Q?oNaCpUA+/OC8cQu2iYMDiDPscxeQXs02AehsdUqOMGNQ+wHS81sDRb4BCjGH?=
 =?us-ascii?Q?3NA2vhj/xBLY7N3B2JOY0RKzr8o97KpBMyoXkPaQNBHCl9O0dK5QqVi4s1jd?=
 =?us-ascii?Q?B2EYoCdqEg3SLjnzNng2kZvy3VXPePTpjYkAz9rfcjunPhbj2wRHXeko9snJ?=
 =?us-ascii?Q?io2k76uWtRZkDaLtk9dv9kCshkILHQjwYnXMjedaMThdQX5JX6ieqFGWlhB5?=
 =?us-ascii?Q?d5iHjH+hd6AOsD7A/SjjqB5INakspE2FEnuNE/6q9ZJ3MpEmUBrnTiWwgNYF?=
 =?us-ascii?Q?b7NGXxKhEbdt21zHYE1mrcZPFEDEiMSOx1EnN/TnTzhHByqV99ulUjneVwo+?=
 =?us-ascii?Q?a3V3KVgwinPRA0qHQSO7EYj9d+Ww2sZ7QLsq9DYtq0MDLTUhxYZH8rdnKoEv?=
 =?us-ascii?Q?7IXLuJjHxXowXDdgD+KJ521pXLYguc5QTVWHBNUU8lptTW8cwrGPepEVxCUz?=
 =?us-ascii?Q?Vv/zhdI0B9Yka+yEycsU+XKmwjMydnOUzva68L660o/GHIDRnY3YIoyfRZZi?=
 =?us-ascii?Q?i1FdQs/sluXOBnSEZ+vumMCp9Gul9Vd6R4ZLA4TggeLvpjP28l3/pb94Vdti?=
 =?us-ascii?Q?M/FkOlwurDB+W+3AqGErH68G7BX77rKYOiW9Ld/4meURfp1oq17JGtqKeU/e?=
 =?us-ascii?Q?EHJUz7QE9xW2JK3c9diU/KhjFajZ7NESDIE3sayrKdLSx+driYloY9scTVCu?=
 =?us-ascii?Q?wf+rr5O2FKQ4wNSUybYsviVt4M5JW5bHSS2M5mSIX4pLzp5UK75FW3OYqpsd?=
 =?us-ascii?Q?R94635kYPFLUkiNXqIZEHz3TydoSYtbwv2nVDYM7RKTz8hSmRm/H4LpswN6Y?=
 =?us-ascii?Q?kJyA7dUdZt4UhXIh46BW4gxmZLQu0DP2nW9wc/xjdE9AmGmiVlnzzbeO8xE1?=
 =?us-ascii?Q?UKZHZrdwqFGyNp/ftDZIWD26ZpMdQPg28zJ0nQILR3ZkKDuqYh6TXKac+mSC?=
 =?us-ascii?Q?6nkwME64Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339072cd-f8d9-4d2a-60a6-08de8b7336d5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 20:06:49.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxXVujxC/wOqB/EH0mfmz66YrFm/mvVEuAp80GWaVanHaZnF7Q0U3gC6SV/2zVI/RdS15Vtd70cg/83r301BIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8298
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.ozlabs.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-272226-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.2:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,devicetree.org:url,0.0.0.3:email,nxp.com:dkim,nxp.com:email,0.0.0.1:email]
X-Rspamd-Queue-Id: AA05033B429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:29:05PM +0800, Wei Fang wrote:
> Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
> it supports advanced QoS with 8 traffic classes and 4 drop resilience
> levels, and a full range of  TSN standards capabilities. The switch CPU

Nit: double space before TSN.

> port connects to an internal ENETC port, which is also a PCIe function
> of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
> of a back-to-back MAC, because the "pseudo MAC" provides the delineation
> between switch and ENETC, this translates to lower power (less logic and

what's means "this translates", do you means
"this help reduce power and latency."

> memory) and lower delay (as there is no serialization delay across this
> link).
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
>
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> new file mode 100644
> index 000000000000..e34a4e3504c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NETC Switch family
> +
> +description:

Nit use ">" for multi paragraph.

others look good

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +  The NETC presents itself as a multi-function PCIe Root Complex Integrated
> +  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
> +  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
> +  full range of TSN standards capabilities.
> +
> +  The CPU port of the switch connects to an internal ENETC. The switch and
> +  the internal ENETC are fully integrated into the NETC IP, a back-to-back
> +  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
> +  delineation between the switch and ENETC. This translates to lower power
> +  (less logic and memory) and lower delay (as there is no serialization
> +  delay across this link).
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,eef2
> +
> +  reg:
> +    maxItems: 1
> +
> +  dsa,member:
> +    description:
> +      The property indicates DSA cluster and switch index. For NETC switch,
> +      the valid range of the switch index is 1 ~ 7, the index is reflected
> +      in the switch tag as an indication of the switch ID where the frame
> +      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
> +      is hardwired to zero.
> +
> +$ref: dsa.yaml#
> +
> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    type: object
> +    additionalProperties: true
> +    patternProperties:
> +      "^(ethernet-)?port@[0-9a-f]$":
> +        type: object
> +
> +        $ref: dsa-port.yaml#
> +
> +        properties:
> +          clocks:
> +            items:
> +              - description: MAC transmit/receive reference clock.
> +
> +          clock-names:
> +            items:
> +              - const: ref
> +
> +          mdio:
> +            $ref: /schemas/net/mdio.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              Optional child node for switch port, otherwise use NETC EMDIO.
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - dsa,member
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ethernet-switch@0,2 {
> +            compatible = "pci1131,eef2";
> +            reg = <0x200 0 0 0 0>;
> +            dsa,member = <0 1>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_switch>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    phy-handle = <&ethphy0>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    phy-handle = <&ethphy1>;
> +                    phy-mode = "mii";
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    clocks = <&scmi_clk 103>;
> +                    clock-names = "ref";
> +                    phy-handle = <&ethphy2>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    ethernet = <&enetc3>;
> +                    phy-mode = "internal";
> +
> +                    fixed-link {
> +                        speed = <2500>;
> +                        full-duplex;
> +                        pause;
> +                    };
> +                };
> +            };
> +        };
> +    };
> --
> 2.34.1
>

