Return-Path: <netdev+bounces-282823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI5vF8hF82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B664A291A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEE6300D14C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F793FD15C;
	Thu, 30 Apr 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZpuPCI4H"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F43FA5EB;
	Thu, 30 Apr 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550631; cv=fail; b=WEksbG6oYX5f980/Pu7DIjdAgfW0yxijqNw9r+h9zd+dtpv0VlkrMX4x+NWTz8GbtCxTOY+PsEXF9MMgh87SAzatpGJ5VfBSurUoJmmwOAM1uKQKLCn2ZLO90UKu8VMnjCz6CQCd74XxU4Hbmb1k9YD0oSzlRMWBPDte49JWkPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550631; c=relaxed/simple;
	bh=ZN7o+jk6QQTLMJGLdgBr+6uDxHD6URuIgAOKEKgUMY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQstuU4hLryothfEZ7Bspm1tniFx3KGJnJaWcMUxSVUidPoofy3YB5r4heGXX1iDteCXKzL/IahlDypvXbnL2GD+/EO2v636uGowLqGMKtUYd6U26kAN/Sop2RWb62WLIEPfDaZg+Ja0nr8nzuGTg5DQTckDm1PC6nbuRW0Aumo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZpuPCI4H; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP0lKK9S9I9ZDvop06M5/SXC2RqS9CvuSm06qbYugxLFm4Vx+/MjbuGsYTGbpYY5Me75ejuz1H2H6zSk8bwGA7jxbZlvyo9Ux+fxCUqezPoFmZ+3M0a66ZCHVka+citHH6GC2hJBs9yGDHuwLw1CvK2QLOZsjstyl6OYKoDuT/qUqbGqaI2kkMz0ctVMnewa16wgAHNZq8Ps6NQw1XWR9AoePoA+enj8QXr2r16wHjB2l832Pa4tNF6mkk+xrsFdWxVFwPwVOSy63n3ulU6Txf0A4yk75zIJRu9oVMOR3I7TRlA1ju5rWsCBL+Hyff9rW2qpxE987pntJ3EnWvSjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlc8EVN2ihBTFihj4tHSpYlhQE3kmNv5RZwMbLOrZmI=;
 b=AFmGVokgqPlWwzhQGNdNGcu8oh9zpjf28kDsdWs0pTsiDtjVYNYRHM39+3rHB6Q/A2ZPOYHN1w7uqLNronDbo+XViU0ZcywluM0b3PeYiq6zop3rPDRpBOgOjSpfcRrspCB7AywAULSeXswU02L+Y06pivLg+bKM8gs7CTLZaz7CUDHXfW+e4+IWOChWqKWW2gtii6IdZovGnBbD+mqz/Kpucdd/0ZhXl7hjUFEaujEIm9CJqpbQLJZJzUK0bXdEEcOgMIAQGhi/v8eVEgIzq6Oy6sm1lPjHZTKzAYVUMz/CBdOY0zltdk9aFX7kVGdFvL+i53J0x1n068OemIFKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlc8EVN2ihBTFihj4tHSpYlhQE3kmNv5RZwMbLOrZmI=;
 b=ZpuPCI4HrmaweqYU3Bm5aXXKnvlU+BQlrzW2bHNG+lc1W2RUFVxUzXZEjYEVhMuwvrAbNyr9PpDW6hVdwF1s6SopQentDiMoyuj7Ml4N7QSR/a/qzOvrQXk53y5AexDTw7defInDSOPa0LjdYPX7zwLGq7LHRNSNbRWsp9IBCm04I0Yml5xKosPVo3dbeTknSKlmO0LADCtOc25LAjKvrjzMhmBZkIkAh5rETCQTToMH2XwG4hqHxeeibLrRk5P7zrrI1keYnOE/EaODAb5pu9Jf+IyHcNJYye+8StRgnFTq4uzPhDcqTi8gN/h5f0Ti0T11bm1m3f2FnUdFWmpZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7301.eurprd04.prod.outlook.com (2603:10a6:10:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Thu, 30 Apr
 2026 12:03:45 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 12:03:45 +0000
Date: Thu, 30 Apr 2026 15:03:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <20260430120341.4sqmblbt2hqoklsb@skbuf>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
 <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
 <20260430111924.nvwohy4nexzyiyyl@skbuf>
 <75e338eb-afd2-4e2e-9b93-e9fc36871854@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e338eb-afd2-4e2e-9b93-e9fc36871854@solid-run.com>
X-ClientProxiedBy: VI6PEPF00000214.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8cc) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c81926-ca37-4a23-2ab7-08dea6b08798
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 1OjmGui8XWfMGf19dTsH3eufH6JscFu+rltXjUC9xIY+MuVmksLzPjAVlAau54gPsbXRsz4sUsEW/sdpjfwzVN7oPCcL3zzgNPEB+KF/t8/FUSTXZUbljHFWtVEmjEt0rHQl/s3LSrygCEPjCr2ibVK0/rFU9Zn03krW9COGoyubM7+sqA3SbmmzELcnB83Au90eMVIr7vQce/rwPGi+LKMVjJPz4ZzwFuGH/ZCn3MSJn/NtkJokxiU1Ua6snYsHI8D3eIuK6jW6BAhFkBRpstaa2PFa4fEM7D+m+jbJ/xMHD8D9gHxGeMxLllLLWf0CMUId0EjTweMFwB9x/fzxbJCwtkglvCw8RCOWIuoiRjK6RSGn+L74GDWQ72NEGu+svU66xceqV3EHeVeXsyA/xYB65EvX6PEwS2C9hz+mvYciYzdMHdv1RBTJOzfN/PSXEXUGYVjSEk/2iCdlbAbnTfDQFDDs7n0SRrYTdYqgcLDGjy1lQISY/0MYAvbz1kzE3yaTYb7BmYEhQWCy6Q8FyGAgkIBF+1CI84Fs+HhjdBdW/DTUIf/L/NfTkJhqDclzqK4cGNk7Ay71JZoDWZST+hV8AKMuS7aTpdq1g8ZFv3XWkurBvKHMqkkPlPhnGz4EZbUomkg8AxYO/KFhSY2iwZvLw4OfzgNyBvCq1TCpmearbXNqV4PFcrMIjKMCQcv027lGWIVQJeNoCZMzYc5VXIkmigs7GVv4Tloir8zxbcA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JJOfnXpW7HwTdUJ/4z5j3n3tYzg+1771RPHgXzYJlfwflKkb74gZcBWn3BN4?=
 =?us-ascii?Q?wsuLJOmH0H3cdhX+zX8TgQoJEbjltfJqMLyRs3BK3qfN1X+Bz25iIw13tY4s?=
 =?us-ascii?Q?Zm/XItZc0B8soZjyqd89So4xu9aQiEGnkEgLC9cwfFOR+1Hrfa6IsaikKnSr?=
 =?us-ascii?Q?BKIHJYxbWtKyfzoLA/qkQJg5OqmTO21WlrPVoLitRBKsx7xAPxvtheCXfc7f?=
 =?us-ascii?Q?sqFwoJ/iQgjIJtWBq+MApSlvp/8uyv57bcWEFhe6++JrBSVunT86xxW5N2j/?=
 =?us-ascii?Q?4ZwDttMoubF1TXeFwsDd9cSft9SrI/UynaBHMUcYN+XtOZ9kPeyArx+azJ9B?=
 =?us-ascii?Q?rMKgMVxLkGhvUMq64TLXYPR2PKqvLOi7Wt7r/RZ6JIz0o6ErO4feViTzva5F?=
 =?us-ascii?Q?Vf2rdW1/QQUWqehsyAXxwHPsX+kZ3qgqw1f/f6LdjqYXHLtqhI8ilhJpns10?=
 =?us-ascii?Q?/PqaGbYpl9DaSdS9n1loIDXQtRhVYxLPL25N6aO78N0mgrB+nVeJOx0pgPs8?=
 =?us-ascii?Q?OmzAihpOaWVuYK2MrRj4RkkuIU3kCNe91JTJkzBkL050V7dnskUl0NIMMf1N?=
 =?us-ascii?Q?tzURimcIAXrCzVUPSuXSgScjPw6vn/w8k9tuK8z34t+Vv3i/q0O83XH5UP4f?=
 =?us-ascii?Q?o7xAfKmYVXXk1Zj7ub3P0i7LYlldrOnB2uBqU/FoVk9vrBw8kLMl48n9yqbi?=
 =?us-ascii?Q?z4z3GyF4sfhwta+YxV/IgecQNjIwA5OqA/EatjLm21yaE/HXyRwTihSzWZdp?=
 =?us-ascii?Q?+HvUtsAV19Iiv+cNGNO7zi4FbuPF7V9cPRvszJfemzeJUQLdwq8zn4loMQTG?=
 =?us-ascii?Q?Qs6XQzkiL4gxFQhFByXEAAO11zjM/a6+gLyWqbPYs/rIDp9w3cIQiPWHXN49?=
 =?us-ascii?Q?KPoPrAVm0wDF69FYGfKfU5WzV5bu7FJYChKFP5ibEaKlR5Tzb34InJ4kkzRD?=
 =?us-ascii?Q?rGDc26C8d3SN1Y9GkB9HnkcNoKDi3e9CUR75xVRe+rskaqJx/h6wWoZV9xXH?=
 =?us-ascii?Q?pSAfC4NeABsrfD5Dlo8Gq4TK597Af1l11pC7Y27caCHLU3erWAumgFqDQ9OV?=
 =?us-ascii?Q?V7taTjkz8TWc1CBHbqP6SCIYt563dRka53AhneSAU2EHjJQ09fa4XPX8Ksym?=
 =?us-ascii?Q?y2DWUdvJtEb63G6ugFbJLGV1fQy9QfZOx3hXGBux2by4LkbQfEnu1z/Qrgx5?=
 =?us-ascii?Q?7t8/HXhrQ1Rx6WepzW8Id4ylLF5dxxqnIH+e46NXVcXgyT74p30Pv7XtC4pu?=
 =?us-ascii?Q?2BYeo5DZ71P9mW+MqWNgCa2DpmXopaNvlJJKIBFlOpemO5NuKtf6yeNg4sHG?=
 =?us-ascii?Q?2r04UZ9z/TFB9cf6eqMnmLD1q+l6e0Nw20hapkHRHY6yRirROMAG4jnxgnCs?=
 =?us-ascii?Q?5vUoPzePmyECqULGHjG7oOL6GLTh04PDoPeovo6ifxUweP7M9exHyAuA46vt?=
 =?us-ascii?Q?UgoI6pi+2Wk/uoUaSe7I+jTgV0tE7gqmWMJ+D41pJeCBvfBN6cmXnAWzDGVj?=
 =?us-ascii?Q?T9MHsP3fUOTyhNPvRPJKi3Pxxlwfr3S4uNamuAawDZUgTQxEiNPbqiwV5z58?=
 =?us-ascii?Q?QXUbhpdBj4vF/qWUdlFSXKOh3U2Bej3aPUweAF1Xl22+TpHmPjzio5TksAyV?=
 =?us-ascii?Q?QZOnIa5OMznyyRzW1FeyfIt8e3pJxxFP3ouJI1+x9kAvzkViAknBXlpCflya?=
 =?us-ascii?Q?X9lF5lfiOD3A2BJaMG7pUcgFdhrYQBg+ZWQKWbTbhB79/sZia1/92TanHuBn?=
 =?us-ascii?Q?w+mCUw1gDl67jVNYCNl7cx+P8CxQi9JnV2jlhB16576RFJ8nZ8MztqIe8SdD?=
X-MS-Exchange-AntiSpam-MessageData-1: gs8SELRefNKuysDld3L0ZGkOCkJrh0uIKWY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c81926-ca37-4a23-2ab7-08dea6b08798
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:03:45.4104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kizvDOoPwJmE6a9TfzhGU1OHdOxFynVhLAifTrcNlhlvG5RM5THgN2bXyAdtZqJ9OlAI2de/Z84syyfysZOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7301
X-Rspamd-Queue-Id: 80B664A291A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	TAGGED_FROM(0.00)[bounces-282823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]

On Thu, Apr 30, 2026 at 11:48:45AM +0000, Josua Mayer wrote:
> > Also, can you use udev for user
> > interface naming?
> Possibly .... I am aware of systemd (udev) based default behaviour
> for network interface aliases (eth0, eth1, ...).
> 
> However I have not seen it for dsa switch ports.

In /etc/udev/rules.d/10-network.rules:

ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p0", NAME="lan0"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p1", NAME="lan1"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p2", NAME="lan2"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p3", NAME="lan3"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p4", NAME="lan4"
ACTION=="add", SUBSYSTEM=="net", KERNELS=="spi2.0", DRIVERS=="sja1105", ATTR{phys_port_name}=="p5", NAME="lan5"

> 
> It has been common practice for switch ports to be named lan[0-9]+,
> and I'd prefer to keep it that way here too.
> Predictable names are important for users in particular when interfaces
> are of different types and at different connectors.
> 
> Re. the T1 ports names I didn't know whether to use "lan" or "trx".
> For those if "lan" is preferred, I can change them.

No objection to your naming choice. Just want to point out that we
encourage DSA users to use the same naming infrastructure as any other
net device. The device tree labels mostly come from deeply embedded
environments where a full udev implementation is missing (like OpenWrt).
If you don't have that excuse, you can try to leave the labels in the
device tree out and set up predictable names through an udev rule.

