Return-Path: <netdev+bounces-264880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CKdIOQGq2kMZgEAu9opvQ
	(envelope-from <netdev+bounces-264880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:55:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67FD225860
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD18131CEC46
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B03A6400;
	Fri,  6 Mar 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eE83mali"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CB248873;
	Fri,  6 Mar 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815760; cv=fail; b=ud27Tq7ao2fKWx2gTTpZBkVNiRufQBZlvNokEKXOrrq0YvePGlJPb0n/33k6a3I1R1r7N6DeML2bPURb2C+U2WKGEwloRwU4/4DXCUDzYQp7bdQCsr19toJBDeUVd5UkihzfIcQje4IUpvkSx79GEQ/OPyX5Tted/FpjNFaHCJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815760; c=relaxed/simple;
	bh=k9PPMkC1DqhVaFQSdO1EznT2IH9/BPMLjTIwYWwRQ6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWvBKi2N6Uii7wOflbiyDr5koxQKK0OvoFdEGh4YmVFzDTAWzLTVUS9myF/m7iN0ZHGyCliLGwaoHjXKgv27+fH1/4KTjl1IWqAy9p//hqKpwTbig02ADJpeRvePHfXVZ5cODT9HRiJS6nBVz/lzUZq9K3A/VOgZilDttRrFP9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eE83mali; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3JoDn8/Br5AVFZULAqH0AnUoFGnwScB5pKfjv63K/ebbyVJ46I2t6XIABkeW0gSgHbIr7Cb40ZvXxDJA0zzQ71Y0IlLkCFRCcWb/ozBK5QEq3LTjMq43EzoFtzdaTwKuZ1GtCK2FYQJHPbsdZzinlTcjYroC+Pils9a/2LArK8QpIDDUygC+aR/gDeuYeTW5xRPQ2V60WAdbQbbU+WRnzejYJY8oz3l5KoHdxqV2eTEti2mnDGHo0DP4HMM3RP/RrspbbyG4lIqRi3wCKFLxm/ZhNrd9B2UlfWxIR8zRCQZRwmRtIaG80fzV5qTUqWKeTq2XlZUL4cJz/nv+4Hh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyMQ1RlYIyEW5DlrtqQBrsIcYha29pNEMX0tt6IfVJ0=;
 b=pMjbekWeTXvM7bLnivBDbSlCFJ6/7m8SCz7fqmReICpsArCADNgVGuLWa1K2+9ezwbCovGY5gStQIAqbzjqHocaGQXBP2N/IsmvD9tnTUNz6Ks+ZlycPnWJaQ+0CuLK2H7YhgDA6C7je5pn60xiqt3m6FfrTzCZyCodKjBA0eOiY3AWjruOAae59pFgFnLr7PjNtbTSJaoFnYNjq/tQ+Tmmd6CwcRELsOt7DQMnnEb8GpQDg3ce123VZR6B0NWeGEfQSIGS9M6fR5VxqTvmYd542RLdk3FRlYZLqDOfSxNzSRyqXhefTaWovGREuYFNW4ZnY8RwBTyr0Ph7L67lE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyMQ1RlYIyEW5DlrtqQBrsIcYha29pNEMX0tt6IfVJ0=;
 b=eE83maliS8nM8xNwpp8k86SyCgoMN1g9mvNHJy9aZEiE9QP6zu0ryGwtcMPcJqx4yPYxbnFQB3NTQKBx/JQvwT6915UB9hc+IhH/hz2JBtB6SpwdtjrnUvE6xPXNBE3bYiZQRPdj576eM007s4s/rMpIENvjGIafZBMX4gTC7L6M/sxH2zJxIM85dz3v8t0Wyd7beHcLUiGb9Wm9EJmc8IQBY8WpzYYklIB4ZZECNPgLBPrqQHAYbj7nB2UbPvg0i1e6Q1rNa2SvkO8qJmgP61Nk6gVroLaP9Zh1ClDICjqnv1HCkYan9UM7rFW3YaEJvSvTXXVahiaLOp8jS49AuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7773.eurprd04.prod.outlook.com (2603:10a6:102:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:49:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Fri, 6 Mar 2026
 16:49:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com
Cc: Frank Li <frank.li@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Fri,  6 Mar 2026 11:48:53 -0500
Message-ID: <20260306164856.292071-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306054002.2208360-1-wei.fang@nxp.com>
References: <20260306054002.2208360-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 700e7d01-8fae-4de2-3343-08de7ba04c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	LizucsieSiLBZOdRxElqykWZwfg24W8f22ifmiII4Y/DSyj1D4+zNRBRMsfjhawLTotS3Grw6vRNOG+PMEjcPd4x3Teoaogltp/1ndgPBQaryOLznTDsKv7ADdGOYezWdTz+5Yyq7PdtU1epaeO2hZS7NYLa5QLoyn3QnKgKXbKboamRM2DnmXBr/LZjVi0qMBmwA/lJDCptwi6j9sFnDWGLehrFLeTPHFaeXJtPZQdpun6soaUF3hiAWivlLW4MoVqeb+QW7YXCnseOeLxZuy9aJxZGWw2nSNf2HOEjkr7ldJBqGk66rd5lIBSOzpro1sz6K+bA633e6pX2ZMr64x59ZQF1SGlXMbsIHSMkeE8GDYwUL0g0nTlC8olXEvLCDLLg8UcsBhsavMQg4NMp5A53tvu8s7f6VvIMHW0sJEcb8xIGblDHR1gqbdqWuHMQz1HpSQwQS6sxEs3y0mk44V0mKH8td2eBPF55YJ8xNfoNCTdDY9jailBVYz6y+Z59zg65kZV4khUGS/Rm347SO3tnh+W3LrrD2/uWi0zlwnhcv8h1cTwPjooUY85OUs7EjqIzb//dQNdE/p719Qhwo/Ah+5nz0V1GtPb6pueazysPU7BYSoPy7T+Z6tTRqUSIMo/71SYQM0xGNcS2V9T2O0RkZ3HKAyMFvgOwycjezzwCQOwLl1fPSAhC0j7eAPcN8xgJCCUycjz2ZcQ0sijH5uEw+j02diwP39dvO7WbM9ASDl4eWt/Yl8tEkBDQfjrxopnlb7+0QtmFR4IxqFzSQmK9d8mCzkuNs1N+zckfM1JCgTwqfv56cYRWnUGd0Qhd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkRC+OArn/C3M6WhnRCSedMG6FD8i5y1ExcR3n1Am19W8LH6fumw7SAyRalE?=
 =?us-ascii?Q?3JmwUjirv1eIoLZZtUNVh/Tx/rURit7ah6AxkZ5wQSxtN6Z3e7tSv1jIppty?=
 =?us-ascii?Q?QXwHzCcRiuaM3udDgefmxj9exrf3PHZbMbi7gRupb/X4Afji1/gEkBslmpFA?=
 =?us-ascii?Q?EOICgznnH0g6OOOpBsBKOXDIQMh/uf8MBGc0asQfMsy2BfAsJNfWQE8aXd9b?=
 =?us-ascii?Q?9Ix+9JERPZRpzqWiyc4OYDvJftYN6Fb3QZDAYSk0Ab+afLpc5z3CtUbBtmMh?=
 =?us-ascii?Q?6gphPZ9b3r0KPGissxdlONfqI7ARSrrVz2WNP0MkuGZKyJQKyhbP3lY8OL3/?=
 =?us-ascii?Q?mSQhB+DUAoyGkG+A9Iug5nMh7tuMt4bCRWBbclMkEKtSBI6XPpURGLPyhVix?=
 =?us-ascii?Q?pycDEBhDx7cn27sjo3lwmjEWlWQZfKInP8cXs8iG5FX/G7O8VxUkg61OR6en?=
 =?us-ascii?Q?qxehpt7KD1fGJk9i378E985Vf/vmy1VXgdQGZBiJPvX9q46e7HV2BQsg9s2y?=
 =?us-ascii?Q?eLFRtPXnqSy+pWIAoiycTtQsUVEvFDKnNpltJaIDWZU6XqGQxuLhDaSQLubL?=
 =?us-ascii?Q?CUyIkV3qZknzz14uK5WZoudYjNQamlnNy10/cv58leg+r3ofdiiR87R5LB7R?=
 =?us-ascii?Q?hhMXgo1QEqGFxPL5qAKVI9IOSEEhRMoDvZqp8g2c+y55akTMCN38EitHeeCt?=
 =?us-ascii?Q?zu86Pv8pOYt0H5EBvhhBwtKYYC7xkJXWnGhnBxrOSMEgTC04qBkqO7cHbWfp?=
 =?us-ascii?Q?BipDp5HbOgQZ4IecgMYIcrRiXbQNWZapJ+4DMs1SBiCjU4CJdkSQ8mYmpqWN?=
 =?us-ascii?Q?6yJa0WnTjHUZPa+KoCHIxu9mEseG6DC60aDhH9x1O2t5RhIYUjWolmQQgSNr?=
 =?us-ascii?Q?awR6ouX2XNdTN16N00aUXz/MLGfpI8/CpM0kBqEC82xmHZiQtJ+vJZ+B/yxv?=
 =?us-ascii?Q?ZW2w+wiAibX/b4w9wLa+ObM0yhU+cef05RSCV1G/QrkKtHBBDT2HnRCtfdI4?=
 =?us-ascii?Q?55KrTQnc0sXBP/tESUCcksKbo8aZjuclcLiKudHbmdNtVvbR/2G8pm1blEe0?=
 =?us-ascii?Q?enr0uyDfyx4V7pUzDbKVrOnrofY0Hegn727L2ohf1sMCmwPFLJCXmf/aKtIU?=
 =?us-ascii?Q?tdlsx0Q9I7DJg7o/a+r7mkYLmLvM+MNz1IkdDoNuL4QOEwVzLNgebxrmJz2o?=
 =?us-ascii?Q?bQqXCUv1xUGh88WRRLCvyVQw7oI4k+OI5wdZ1x0bNwn/ptMOCx2UkMW/U4HC?=
 =?us-ascii?Q?j4xlL23NumnQTw23K/K+J7hzPkZWZb/tC9onjY/nzGvh8qLVkk/uVU7Parmj?=
 =?us-ascii?Q?U3KSSTX+w7abCtBTngxbkIAIvp1wVqnQnAWE2mPdzAxS/mPD4fbNwa7x1YDQ?=
 =?us-ascii?Q?4UZvlCJjhxK7GI6yliLwJPJvFf0bNfcJtF+6qcDep+h+8f1HbFNrtKrExUp4?=
 =?us-ascii?Q?mr6uVgawpnSmErqioToGxvLVhktkkd5sF975OTQnmfkIrqduob/QU5UoTuMa?=
 =?us-ascii?Q?F22jk9hJxLvoiSNHTE3+kNJBPv8k15ZyUOIWr5OKSPJsU+U/dROAHNdNFl+2?=
 =?us-ascii?Q?mpl7pVMTIGF0Fm2VJYxtwwE/UIrFTA42x2V8uJikgGTdO+47LN2pZUdbxONs?=
 =?us-ascii?Q?lcoMLejwDk5RqqqmxbjNVNPQf9LAHDg7tAGb4NKGkGpVIc1oU7st9J4s+CSt?=
 =?us-ascii?Q?jSgoe0XFvX/bcIB1SYoHD3kCocpOm/ApfSMtaDcnDiuB5uYF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700e7d01-8fae-4de2-3343-08de7ba04c9f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:49:14.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdB2/V7KqzFVCuF1ao0GXdKCEXj/NKA8otZE1RHcjixJAPL0wEd3aotuJzqB/Cd/c9+xxNDzagANNwZHPqe7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7773
X-Rspamd-Queue-Id: D67FD225860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264880-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index 3ed0f7a02767..1ce6551e186c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -134,6 +134,12 @@
>
>  /* Port operational register */
>  #define ENETC4_POR			0x4100
> +#define  POR_TXDIS			BIT(0)
> +#define  POR_RXDIS			BIT(1)
> +
> +/* Port status register */
> +#define ENETC4_PSR			0x4100
> +#define  PSR_RX_BUSY			BIT(1)

AI: ENETC4_PSR and ENETC4_POR both defined as 0x4100. Likely a typo; check
the hardware spec for the correct offset of ENETC4_PSR.

> +	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
> +		 PM_IEVENT_RX_EMPTY)) {
> +		if (timeout >= 100) {
> +			dev_warn(&si->pdev->dev,
> +				 "MAC %d RX is not empty\n", mac);
> +			break;
> +		};

AI: Stray semicolon after closing brace; remove it.

Frank

