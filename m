Return-Path: <netdev+bounces-254719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIQqDH45e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:42:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F7AEF8D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBC15309B74B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B73138550F;
	Thu, 29 Jan 2026 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KRY/pbWb"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E321385505;
	Thu, 29 Jan 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682914; cv=fail; b=UXep8aX4AYhOOBUO9VIzvvjjAIF33vE33BLGxtHD+iuSKKX1D36b9/feFEvFT5q/fEpTQM89QpH7MCMbWu9sjxIxG3qOCSqWVFzP8l5poc/0lyk5G78DROHAZk4QqtZzabKNr5C6iotq69N7z2yNAi4vGeSfrSIXxhCtClzQOBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682914; c=relaxed/simple;
	bh=2fYvpnfGhZ3xJtPxsiSMKIfjWAdZBPdM8EyHIEGNdjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxfINnQfqw0hfC4lFJZoVQTWkISYTYrMkKR1Tq/1tXUTZ+uc/N29q4kYyDxes33h1Xouq6orBV2oyI+/W4q5+wPJTBBGJYSIrRuIKk9gqG0wBG5/yhtNuDBYf6xFtFYcFzKS44+UBPbpfTOjtkQ1nx3kiP7Y/qT2VCCnJ2pA43s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KRY/pbWb; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPanywFh4dTRUI/WZiwrowJ5a6LQ+3v8Yyaeh6iaqKW75BjfsZ39LHqSNgSHSVy4ZPEqlo9Nvz6bmMyAqvGapI9N5PReFgoeqZEvyyLS6OsVEvqo2HnTFmrj7Z1WVWMpWdV67bjK+XzDZynkjza7Ru6r3IUVBrPM2zJm5EQu5Ce4SkEsvjI75FA5xV3Z09t6AP4rxLYPxcDgZi+mwG+lE3KSo+DhBtbg5fICAmEM3RdI24R9MBEBWVAERoUeQ0d29wV1nc7cMvObfqcBMmjj1DR4HpjkAum6qBoxG0WYylwfPVhOpqh6NA6Xaz8IHsY2UOBFcVbyUKUNoy7wy9tGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=GttQGMALnbBB3yp1/XU82yZ7Pub1IXAVWX75g8CQU5T06lMw/6mHMPAcTE8JW6OlL+dyBXIy2InbR3w4gNLylC27ouKAG4Z/kdVA5DCync140Mpm/LsWTRLae1z9XSVkV3eGBajMoJ4PhELX1Jnx6Bp585oduhBuD9LXC6cNp+5cxqYF0rNAxrt7qTrR0loelzEfatuZlEve4+6FmYoMZzvFfAPZqJC5RjeyVJbQuvQ4WIDDNpv9teMHUSmEVOQdGQ9r4wykcVjq4Q9+nyJNduaL/jMyPk8iDqCmvtc9weEPcbDDMTZXbAE86fhk6fkPJOKGQTjCsXVoTUzK5hQ/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoqhIrOEfaQRkiKEERooRNNAQBBKgZdBSjTiobu9P2E=;
 b=KRY/pbWbBP7jXSfY0MEwjJUz/qWDhrAHin+qXaVu2gqkjgJhMRUiArmZLwqFPzMITwvfTcpt1DLEjaq5V+NAXVMd8RGXRrDzEsxZ9AGZ12sZE3SvLDqtGhyS7N+qT7xYP11yxznGRQbEwzFklLAnLMOGGSMedU7k+wTDa91Hy7sMOGtF94S60n7wycY/mvGzPxmvEvJHg5Pclk3Lik9NmjbeqbaDW0LcApDkzSdkkrZOyYJvyyVR8tsk4/8matP+rxfS4HzKCEgUMDEW5gJ+w8OdAkb2tLM1tDf7D9j5CNulLM1NdVrNlA/elUVbC+dOFefa3/m3RyhXcORxsIHn+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8008.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 10:35:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 01/15] net: fec: add fec_txq_trigger_xmit() helper
Date: Thu, 29 Jan 2026 18:34:33 +0800
Message-Id: <20260129103447.1893129-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: da2e29f6-3644-494e-3901-08de5f2212a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3T6G/SwkrvazZCrj/Icz5tC/wq9nAbW38aSCG/6RiLjIWVfG3pBY1sQcO//+?=
 =?us-ascii?Q?VcObqdP5rB5ngETI/5KoTqraqarFd9dGFjMF/uRBbt1g1ALijfe629gm7xgr?=
 =?us-ascii?Q?QvCJSqomhcrlUDxw2f+nlA9oKiViJc+SwmmpQwYl87/2TYHBkm+oXs8n6nEI?=
 =?us-ascii?Q?YcrcT/qz6w2yhao3ZKirEcuEP1Ry49CAAzlDJB7Lt68GZoY6S2NafL/Edp3t?=
 =?us-ascii?Q?uOtmh/009GxNl6KfJRHKw+rxncJgpr7MQabFKyRPwcAomfW4HSKlmaSZt4yo?=
 =?us-ascii?Q?6iTAdczIRlyB6g+DnxO+iagBSOCxOt5JjbMvt97K5dYHw2F91F++cSO61Bq9?=
 =?us-ascii?Q?q+8t0fjA/KO+9O1CsaUn7c2i2y/H//2WHpn+EbTjCbF6BtVb+S5xQKAmEZiL?=
 =?us-ascii?Q?63MVf06Ekbl7yiipCIg+VhJnoYzouiW7km8LqyMtsO3+w7FGOpqwKAM6wlkW?=
 =?us-ascii?Q?IlhNAIOsONPA1mrK66HFcUh/NmrZR3r0gsUYrTGA2WM0QMq3/j+mUdPZLWUl?=
 =?us-ascii?Q?Mwg4PtFt/o2hFmwU+r2C5zenE6vMWeQg1ujw1O4BVjKYKSsKxzbQbRjdetB1?=
 =?us-ascii?Q?3Sy2Ok6MKQt5mk6wdZZ095wSocudmIBp1J14ARYGtoVJsGxlr6Xx3Wn91nKz?=
 =?us-ascii?Q?O5JDHaaOgVtPF1eTZ63YqEvWN6DMLu1THcWCk1sqWIdLbKZFcTYspAbVnocA?=
 =?us-ascii?Q?4aL4Wawi2+t3/XhVIK9jzfjuWCKrQ3dqidpZCtLwYicckdb9UvHQ90zPUZDf?=
 =?us-ascii?Q?Jpu1A3J33t3HFCBJUmQpvR5QfNYYzrxxaiCPfnIbsFeCr18QvMg/30MGpLL5?=
 =?us-ascii?Q?Pb9PWGXM2xfF8glOaEpPjU5xUwR//N4bGE5ArjMihnFXO0VKeb8zncSE5eM+?=
 =?us-ascii?Q?L3fKTQpgZ880XhoBTaoivfCUHaTRbdsHe2VTJs/Rhrelr68G9Fa1r3p0qbvM?=
 =?us-ascii?Q?tn6HJsdyRCaDTfzT3zMZJ7cMkZxJPObrgHJRVznSbmTJD1Qu4ek/GsjRq1Lo?=
 =?us-ascii?Q?8/oy10BfKAJzDLEJ4tyNl1v/xTlh0cehB9gK+CkcS/os/IhKlaQ4K58O1F5m?=
 =?us-ascii?Q?Xx7Qr3Uwf2mmwT9LgS4q9nBE0AARsOQT2SZDnKI2qU5/ccVqpYTTmNK3kf+0?=
 =?us-ascii?Q?geSNRphnDDZJiC6d8ARHuesamXjEuaczo9Qds1Zr9cZVB+xP4gRnrTwbtbQA?=
 =?us-ascii?Q?ySG6Nt0PvhRhoZUC8CsEgmNkdb6OVqbZ2hy075CrgF1UjisDcFlgA3pSdU1H?=
 =?us-ascii?Q?8d+ea7Bl1IeLXkS1gc6HCSceo5TWd0n4ct2ohpkidrXSJ6mZZ1oTRWY0Y3RF?=
 =?us-ascii?Q?0CTBgX6fSKY7uoezuIZC1dNjnqzBVSZNpZeTl1ygXbxYK0BcOEPKEnURo5lV?=
 =?us-ascii?Q?we8khNjLpzcq3bNG2vd8TAHKIuOjcddh5Hk6UofNiuQRDFZ15SaJ0xYhFFEx?=
 =?us-ascii?Q?mG4CyE09leYVoAz7ba+XkdKWEx2ZwT/LrhlgMyT+Xr+gxQkExRpAEvyJ9rxO?=
 =?us-ascii?Q?Q4i9wY7G07m616MyW8jxEe5ZCFckv6OCbIw5jEqHh6quKsQWcHiHw7ubNEQx?=
 =?us-ascii?Q?P4ZkeHswro79Gu1nP94HofZYneghrpsWlJxqf+6/URPxCTh3lSvL4xhief3K?=
 =?us-ascii?Q?q62SzuNk+r3Rzv+PV828YtCUZSzoLtdT9rMPIPQng/hY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2jFj/Y4hzmTZZSEo1a1tlYWi20fy6LZI5jfLnToOAU8ERn83uune4ObtFjR6?=
 =?us-ascii?Q?A9QtvM93nwW9AFoNEHsdY28Hw0emJcRTsmFYUAocG0eAU12Iv2CIEiFGY+Vn?=
 =?us-ascii?Q?UGxH40X2/J57TsGE7w6EcI6p9UvVBGWxY+zhIANzWrTD5ys6fXHHoQBRkDSQ?=
 =?us-ascii?Q?BcKGtCgaTM1RXbg8YtVZVMlK8E4GqXwEg4MM5OtlWhT8ME83MANkOiKpXYly?=
 =?us-ascii?Q?iNzgjESmY/W4aVN2gemxRQIy5V7zDxl5hX8IBHtyndB2Oa/2IzHDBaF1Zn6w?=
 =?us-ascii?Q?Prfo+wrEvGnHuPm104vm5/Qt5roqbRyMNqEnSJixopuvi1XYyN/h6TuaLuPd?=
 =?us-ascii?Q?ZwWpn1WSAHTnBTqlVeYEBbOGJL/i1GM7UtIayQXHgyRm98HgzH1y0joYBYKJ?=
 =?us-ascii?Q?UAcKZD0oMpdAuq1qfWVK53usTHqAw9BRxebPsJRt/EpaLstdma/9+KUqCG95?=
 =?us-ascii?Q?yq7VuYREny5CDgqc7mL+wgOxGo0GB57mYT8wCtSyIwUq8CqBEVH8HHtniR4L?=
 =?us-ascii?Q?It0SS+0+Iknyu3s8E+HLQYFo/M11SG93JcrUdcH5UhyajCPYxncqXqbb1XJ2?=
 =?us-ascii?Q?+YVPxDQ+AUTroRvYOrEOwDnBmigKIUskm3IKlqOTHr/VTP0ikProhO/J0vdu?=
 =?us-ascii?Q?xrTwgWgijInTWGtPQsQJ3lAwRNEo6K4oDZzg2DkCwEiJ46eMfWY1oZvpqUef?=
 =?us-ascii?Q?kK+8fN7rmKVHarRzj56b8+u1c/gcC4l03GwpVRaogcl9ULqXwoMsS13q240N?=
 =?us-ascii?Q?PjSxNfcuwW4mBmQO8T4T2y4rB/hPQxQwknX6wKEunw9KAY1dxbzEE6lxm/lo?=
 =?us-ascii?Q?YtsiQhCDaYQbJdoVoE/TKA3PBrLCJqXPoVkpDZufairLSW2U00sxUKm6G64m?=
 =?us-ascii?Q?gwbXluxVYihzegCZOw+2Namld8WY9OwuD1LdH2L0RkEcux6xiOzN/rnyzrIo?=
 =?us-ascii?Q?imxUQZt24EAtyEFae4M3+OvwYIgtmQLsGHkELnchppEEdF89iodcPSW80Cs8?=
 =?us-ascii?Q?004a2HK8gELCeOGSrmj/z1UMSqHCu35LXucFumdMDsD/g/TRkEV1iQlwCovB?=
 =?us-ascii?Q?UeNQo58PfVMQsNYjAZ1USCWm0FwKsWSKCZibXCY2HY+tC6gLgWDXcwhblNUX?=
 =?us-ascii?Q?t2Nhn/XsM+MGEkAQEMnVH53BLjNCAuEKAKaDXIO3ZikgBDE9N2s9ufHuEB2l?=
 =?us-ascii?Q?JCiEHEWT37oqIEEn6FmtlHElQxX8Vh2vJhakw6Pj3I9HY2h6ps6M0jd/gW5N?=
 =?us-ascii?Q?TgbE+gwQPbQKnncmXLXref62uuKtvzbONf/xr6Th0mZGyrT6VtjT4lnKDOjs?=
 =?us-ascii?Q?iT39Y98moqBrecFXILXy4zBKJkzyee26e/GA34kLVwZXsK2+JgHUUIDbDcz6?=
 =?us-ascii?Q?5/XLzEDLCYqm5QLyJpH0xk2uc5O/R8sVk3/QDeNzY47qQZ08MYYddW+XHzJw?=
 =?us-ascii?Q?CDK/3diIeptRiHbomblQZYOFy64J+J62f5M9bvGU7BjbxQ2UUwN52zgNJYID?=
 =?us-ascii?Q?uB30PzCCpxy7IJ+s67QWju/DzScx/jLOqcYW8YYTjcHh5YgGBi8kbYgK1yxB?=
 =?us-ascii?Q?r4NMgeG/NX1JQPpRgnWa93YYuwgeVJwR3TO6BPaQQJXVUBm39w/+xtKvVKTc?=
 =?us-ascii?Q?OiurDaFzRrZBBy+oc5rdS3xNXLjGatY9Rk8ybLKNIjGgs/JAvDnjbDiBGrkT?=
 =?us-ascii?Q?J/1hZueKw3FPcxOrz07lfzd0AyOHI5RAn+diRmMqNgGHqG1oG6k8VJ9ilxsI?=
 =?us-ascii?Q?gTTfGxttJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2e29f6-3644-494e-3901-08de5f2212a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:08.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lSmlvtuXF5Q5sYBp8rzmnHlsqEEKKrIyOiO+wP3D/s7lIqXH5xvZsseq2KUgM+/LlLCw7TeKAYs1RjJgP5vWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8008
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254719-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E1F7AEF8D
X-Rspamd-Action: no action

Currently, the workaround for FEC_QUIRK_ERR007885 has three call sites,
so add the helper fec_txq_trigger_xmit() to make the code more concise
and reusable.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 32 ++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a1405c928525..ce433af02ad2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -508,6 +508,17 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 	return err;
 }
 
+static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
+				 struct fec_enet_priv_tx_q *txq)
+{
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
+}
+
 static struct bufdesc *
 fec_enet_txq_submit_frag_skb(struct fec_enet_priv_tx_q *txq,
 			     struct sk_buff *skb,
@@ -717,12 +728,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
@@ -913,12 +919,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 
@@ -3936,12 +3937,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	fec_txq_trigger_xmit(fep, txq);
 
 	return 0;
 }
-- 
2.34.1


