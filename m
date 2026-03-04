Return-Path: <netdev+bounces-263736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEDjDaQJqGkEngAAu9opvQ
	(envelope-from <netdev+bounces-263736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CF1FE5AA
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45ED631987B0
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E313A1D0A;
	Wed,  4 Mar 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xshw/y3U"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880B39F19A;
	Wed,  4 Mar 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619825; cv=fail; b=YXO+OhjVJ29bE09SFdzcGeChTrScmpIKTdNYjGuLrcv+X+ijUh56JdEPW7xCT7lK3pLbeOfRAUqnZSvEdn7jlFtMhmy80Wd9cwPVuRec+VGmXL6r8mltXyZxg3+rVEl4WWrYyfCyNje10bwAqU7kb5pg1hZVJOwdur6p4b9Yti4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619825; c=relaxed/simple;
	bh=4gK/2la8nOCeY/t+zh/tO+1O7xBFecc3Ar/3lkB0rNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hj+x3isVzQXo/e3dzCVCZ5wTBsmGfBLhvuLBLxwDLYqmqMfKw9uO7xUg6fdzEfEFj99BYDU3f4iHVdrBXJjvFGrewica+HA9V5FMEAbqo5dFgV7S4dnsluQWL9JEEcW4cJQcxWb4qxUlEleCDwuQPUeheEsZCwjOVTFm5HoTKOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xshw/y3U; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obgbS4Efrmm+MKW7Uf1c2xOex8hKVOlAwP1Twu1kDrOKzDTqA0q4AGuOJors71pzyB6Mcmg3YZ6aTvsO8/hjfpmMlDFIbsm7utX1uXrQil4E6E+iaLiC1C/EB3ZSAlLC1eHeJdMkkeOc+pZw7PQhxh4/h+TOPGMCgDzZeag2zL41X7rQ5L+gCz6eHwDWFE9ZvRGwaxPvS+OzzEj9c/VXCqAHuhQvlBaCAIp3Mk9OMzIZkk7EdBVKwVcp13jta+MzOZW5id9EfKjHd/NoEDVRwCABqnL/r4B6WCoIqamBEGMRqm7+2rkuWSIufLjQwP2lKmpUQw181+zP6FACGTbPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gK/2la8nOCeY/t+zh/tO+1O7xBFecc3Ar/3lkB0rNo=;
 b=dTFRs3D5FUSPSWD20lqjn+pcMdCrwjwCezibmKogoDGVuETcHlKYClUWMu54PxSiOz89Unj81iXlAV0QJzHUnYH5ZO69yBnDYe0MnsKSVOGQXWqlqxmSk72lHV8FtxlOryEkGJVkD4T5PNubwAIYUv8NkmI8WFXzd3Nk/WuF3o3M2odkdow5eIat4f3mzCyS7932aFm84kDi55SYqfC+tdrCEQwb2IiaDwzJhHYjFUTUyaI9MtLEAaqKwILTUh70A1QV3uD3Xj2wJOam/qALHY1HhN7DHzluwbYOWBruvY7blhoQJewO2oDgqpJWj5Mf5ZGpb3ixpHbk8MArIKhrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gK/2la8nOCeY/t+zh/tO+1O7xBFecc3Ar/3lkB0rNo=;
 b=Xshw/y3UsT/QQN4xoCamR6UAXyEHLOo0YCnRUO4yNqyGxCsETX0Ye3E9Y9P3slYLUdLQICERGJpXvRLxritLQfOv8LaJ9Al8NPnRnmPf7//8xwCZGfLt1AcBwo51V+RAWX7c08RjWPPfrxNcMstt8WB0ip5jp9ujpOC4Hk/0f1UL3+ISBNPoaRDyypada+iHqSXF2hu2rJgpmsKOCmeWS8IgLC49WCx/3iGhpicfnkizfuy8iBNVQzEBUEniGvk9lSlVRTEpo+L046VNrf6x0KJq6jXZzIkZYjQI9oDJiDG3Kx9BE4qSpQbLvX03wOGu/tewiDbRcKgz4LVdms67Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GVXPR04MB10182.eurprd04.prod.outlook.com (2603:10a6:150:1c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:23:37 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 10:23:36 +0000
Date: Wed, 4 Mar 2026 12:23:33 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dpaa2-switch: Add depend on FSL_DPAA2_ETH to
 FSL_DPAA2_SWITCH
Message-ID: <gjtjhvka6azuahiga6o5a4dgg2gm7dae3io5fbvjjmbovgxrfr@pqgfhzon6tbb>
References: <20260303013814.338989-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303013814.338989-1-caixinchen1@huawei.com>
X-ClientProxiedBy: AS4P192CA0018.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::7) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GVXPR04MB10182:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fbc28a-eeca-41f8-fc0d-08de79d818a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	rDrYip8gNVfKE8DDlnGMhvF96kUBRPug0IJ/79ITI3Rzf2FVwDdz+eABkBS3RYWYVGU6buR8oaPQII6U0wEw7pSUlAW+wvmMszGj2qgKEEBIngHetK4Ajl6EX+y1rbHOhp9SdZ0Iv1n0SZgNy94hfE7Yqbmqc3ZJILEHLcBY3/lBrZqYhf3eQJc0WN2kvyCqpkXunrLFD9IzUjuWF7c0fX3uuIJZnB6ub2r+l7qmWZVNhmAqgzpvCgx0IVGv9+gKpP3JrBgDJq+bgqOGVEC65rCYLTl3oNBxsRaD4Ah1h4ufCQ4E0MPAGfeHqTIIB6mSrdH7y//euQcXQPBIbN9cNMIH2jqT0IV1yGRDon/hd/y9oSbnBzv83nY9YSJ5toeIyxAU/PyTpExSAyfpYb1dNmrA4m57Ru83S/Dr/wwOXaUivpKVlqq5ccnTJhCYtfFgXsUv9dvQhRymG+7VpjX7URhQz1B6pBoPru2uKdfVCdKIRbeq0WDNT9vBOAbx0fVgtXTkyU7qtr7S7vDowAYs5mT1jxp+5DcX3ZPyrTzBNzM5MUXpuLjS6mg7McmBt8YCvxifgnmfloVKB5LOdtiVlUbDeT2Y+awY4uAOxz7zReey6Gs0j3HdvzKlfGDsbV/WDFG/T/0rraWJF6L8nv28/4rWFmemBV4p3oroJ7gurkTtoer4AHHx9E90dtTSz291L2l8GnbU+3O/Fuua7CMQm5N6ecykU5Zziq4yyr22860=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwILPSFoVNmb3Wtwq6LlorG4ZLS2V4V1lYeA6Nd6CszFfcfpVQeZTqB5Kpcd?=
 =?us-ascii?Q?JRUyhpcYfydXHtGVBB1nL/xIAlEpDmlX0DPrVFDve8ZXZvKSUGWbWNOSO2kz?=
 =?us-ascii?Q?enbKwmBvMyuEr9k88c0VC0MvEzvq1YQCQ/cAx/RohcX4WEx6RS5Rgm0QUgQW?=
 =?us-ascii?Q?WcQU3K1Bln80vpaYfiCdMBrw0iOiuavfzPWTGSfm7gz7VsvtiMeOG+UII03o?=
 =?us-ascii?Q?e3UsJUCQyVMOjybgUFUYUQWefEZBapTMUApnsY0l7R+jERpShhwrToKIXCvp?=
 =?us-ascii?Q?SrvxStEQXNhvZQFAmZD/NczQ5BPuxe1UATZsGd+91bGyJ7hgW7lI8EK1SNNm?=
 =?us-ascii?Q?OVMU803rgsy5CyWy4TDOhS8PMThbH1hMiiHC2KHxFvWXEdcko52+Nrl8C6Y0?=
 =?us-ascii?Q?rEqbgYU69Q2MNv7BvPq/+O6+dGLKlwskvB+7V+I+SwVTytjbofdquEWkotJM?=
 =?us-ascii?Q?50vvfUJrr73nBum4lDg67Rn+NFdyY6VogAkUohGhKNEf84mKNh579CcbIQ5t?=
 =?us-ascii?Q?nhVM81FPRmfBh+q/Fg1lILLjgpFELXPrChhz002el5xepX8GmsnGRaRxSEip?=
 =?us-ascii?Q?SgIqk5ttVNBHBfYxL3AAaBfkHF6eGVbrNoRUuMrb1GHLRzNq70u+bz9pCzD/?=
 =?us-ascii?Q?hKc6DWNxGbsPNdhinZaAadDnsgLB45XjGQmyE6oT6T6Z8F95LW8SWZ06xL/E?=
 =?us-ascii?Q?XiK5rHp1mPkL7/OzeuMatzePPii1IMk7+3Tfsv6iZkmTa+T99oZ8y+T66x5F?=
 =?us-ascii?Q?wVx8IEI+DXX/wrj9lrzdxf58GtAiCPHvUPMvVA0aRPJ2LxytKNdtvHLEqWDq?=
 =?us-ascii?Q?y3svIYsGMlheBtuu85PTSkfT+5xf9O3aDwG/19PlEy0c/n4HMHqVZNHpra2B?=
 =?us-ascii?Q?BgASM3rbu2x1fNxAYSSeGFah6GQQtzHZz1i+A9sCqfxWKhkJK0zIt2/xxTh4?=
 =?us-ascii?Q?as+J+Wg49JRd6PebMKSDD8ndTW5ctE0tuNTiKXmXAoNfewWsg+yMdSnjcKk3?=
 =?us-ascii?Q?nVnIxDB2k8VeaV+/uHZJthjTzfoTI67jjTdGexGU2eMor+UcbqkqAm5U81ZR?=
 =?us-ascii?Q?FmR2r5QjW1MwAcRECs7uqgswAJ8i3eJ4cDI90xMpUUV/kvQy02I+kBenAZsu?=
 =?us-ascii?Q?BL/D4MYwU7ye6EZj3SAZz8OgM+brQm9gHFKIDncZ7eeBpV9VIfD/hRPkZfla?=
 =?us-ascii?Q?f6z9/he4FsuFllg/KIyx/MWOxX09URJ5dI/QPIeNNsSvkk6VaZayJwjkz41I?=
 =?us-ascii?Q?Rlg/5AkMrOJN/hywSCDxuwIZhOqUPEwCf3xMlxRS+qw250i/c5q/FaxYaW5d?=
 =?us-ascii?Q?+j4VgX+z+07L0J223NQJP/6krVsRpVoxod0XzEojCoLEHnDPC7ZkAT54jstl?=
 =?us-ascii?Q?2aw184df0TwJjCep6uda/iojpKopZa9nZigxWSFhZRpyUqdVJYWgXiQ5jXvG?=
 =?us-ascii?Q?+ATrdddtsAv0jAjUexPRnV+R4CnSpy/N3VS1NlEBUjk03NYy6i6HYPWJsYU8?=
 =?us-ascii?Q?lzxkLpGcKNz4kLEF9KO2zeG0943Dt388F4XZi8YLd5eZ3gCIzRYYtwd9rEi0?=
 =?us-ascii?Q?Xz4worYgea4shs+f9dkjEoLhAtCXnFAlUdE0dkcCmjQ5OrmXqyuv0bs1DuI9?=
 =?us-ascii?Q?cwHaFOiGEiG9iQeJ9kAKzk0bfe8qfReRsq+u2pToJB2SLazf74W6/Vmj9/ux?=
 =?us-ascii?Q?Z21Gy0PSrkICTRB2mIikA7QYqSmaEz4CP5MvTI6CHIAfXyo+c6FF9E3iFncD?=
 =?us-ascii?Q?7oQshjdejQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fbc28a-eeca-41f8-fc0d-08de79d818a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:23:36.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdA0yaGZhFaH2kGNx7aKQEireTh3Di2PMCJtlI0XsAHHnkQQa2N8b04l0c0yWtyfnEmirskoxFijc9iL5VLWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10182
X-Rspamd-Queue-Id: 8B7CF1FE5AA
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
	TAGGED_FROM(0.00)[bounces-263736-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:38:14AM +0000, Cai Xinchen wrote:
> When CONFIG_FSL_DPAA2_ETH=n, dpaa2 cannot be compiled. Thus Add
> depend on FSL_DPAA2_ETH to FSL_DPAA2_SWITCH in Kconfig

There is no code dependency between the dpaa2-switch driver and the
dpaa2-eth one, just a compile time one dictated by how
freescale/Makefile includes the dpaa2/ folder.

How about we always include the folder and let dpaa2/Makefile handle
what objects to include depending on the individual Kconfig options?
Something like the diff below:

--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -22,6 +22,5 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
 obj-$(CONFIG_FSL_FMAN) += fman/
 obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/

-obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
-
+obj-y += dpaa2/
 obj-y += enetc/

And I just realised that commit 84cba72956fd ("dpaa2-switch: integrate
the MAC endpoint support") included dpaa2-mac.o in the driver switch
objects but didn't amend the Kconfig to specify that PCS_LYNX, PHYLINK
and FSL_XGMAC_MDIO should be selected. Could you please also fix that as
a separate patch? Otherwise, I can take care of it.

Thanks!

