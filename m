Return-Path: <netdev+bounces-267136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B4uEHfismmWQgAAu9opvQ
	(envelope-from <netdev+bounces-267136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:57:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D98275075
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CC53241741
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268C3D523C;
	Thu, 12 Mar 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcuPGq0F"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF093BD65E;
	Thu, 12 Mar 2026 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330728; cv=fail; b=E6oX72vKUvFZ2ostMdEYfYSzkOjVJ7beSsO3EavM3Wzn/fvqQLwBhF5oxU8H8VND30DzVpjx438p6vIdzC+yCMHItLBYABN68kDKsrDj7Tq7iHMPbTBSO8SOGXGykFPe4hTCKGmJdtabaXQ70w0HkJ6h3ubLaiGGNebdBRtnmlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330728; c=relaxed/simple;
	bh=d3ikSh5mA0O1Ao2raChWDGXqAe+6MnP7eBROdJ5hcZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rMOIbKW6SMaKDwrcY0lY+42RP1uOwIsiTngNXBLfAydt22TAnSSdlcJ+XGSqVCBl3+hCpc+m5nJAsfAIzewpGVAwzBvmF8Fhn51H9tb4WV/EtolIqgNw9fJibhXLzWp2PODfWoN0sMWAlIKkD8Hk/RuNtS2oLbaHizBUs9zt1LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YcuPGq0F; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySRU3nOyqDARDpFjP0FMpkqeuO2tqD0eX2gO82lB0ROTcWT7r9yBKe0PN3WfmfWXXFSlbu7PfWBZ6US3VzZCIbH/pl/TEYev0iXFz5BgNJB2nazSk6dnGIhJhscBgyu9wj8G82rNBv5JuNsU6Os/YS44Q1UGKPVXB99EzWm//Ci7yvCUe4WmLEIAJ3yCnwtL6Cr3u+YA6N+tO0G+yNpr0uwBgON9lxhQziGDmDdNOIcsAVJyePSBwkleyqL3aFJifs6/xn4NIpgYNK823jFxQMBMs5MVWdtEEReCfBhuuNeMckShD2ESq7Hm7Qm+HX4+x20PpTAj8Zc0ZT8J7R03nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXbgvRbCBRGliD3aBtoPo29wsc3PgFZ40oHApaXDWSM=;
 b=Ibmg4SzaNEiXS39jqh25t0yoEvbjVoNwjzMhjqtwUbs9aK/ESdWwU41sDkJCZUng0fUUuQVqD280CiFVjedikEKvE/ejhkbPAWWgVOS+pywFn3B48EV1wH5AtBd60waTHmqDjfP+d3h1u/1dULV4Pb+H4o/D9TWv/LSXeZyvwEMoTiR7cJxF/M6XM9GiHMfVU+nsAsqZT/qUS/UmQvna8gBvZxZq8jWU9McKDZtSzFAcfgsXRgC27Uq8D1p4VVojytJflM28OFyFwEkr1nU9iCzx9X1fmgCK0hDTYSVHytP5kVdyiAZkofNG21ZKUpXXLlaOXoZdBz2/mddYhcgHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXbgvRbCBRGliD3aBtoPo29wsc3PgFZ40oHApaXDWSM=;
 b=YcuPGq0F4NnzTFgjjZMyynl8gBAcmAKW4x4kGyFb8MGIz+tgFATDvmb4577GGS0r5OLI3Uhna/9bRxjSBl8Nibn7reLkRmgeSv/uI1mFzD+YgXlw9FfBizk4MXBOTVYfUHj3lFiP+3Jm0ujPc6EPvNkfXt7SyG8VVdwSfNNo2Jgu2ZTYAMPJUvLPV+rHqb4CGwvKvtJi3FIauIgFUL/eklicgsdD+Cr315WRVqrp1jkN6jr6a6DKsPN82nT92En5HVfWL05d20CgV/7vozD2T4fUtBjz6cvVMRHqBgXkLRhNtTNutLMXjKpZey/mpEvhnZmdJvj4csPMpzUnSsNByQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV2PR04MB12163.eurprd04.prod.outlook.com (2603:10a6:150:2ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 15:52:02 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 15:52:00 +0000
Date: Thu, 12 Mar 2026 17:51:57 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] selftests: drivers: bash support for
 remote traffic generators
Message-ID: <ypu7gl6hqks45xsnypa4l2363boaje24totpdu6vzeplcxaecl@h7bk4hwdoypi>
References: <20260312141740.295353-1-ioana.ciornei@nxp.com>
 <20260312081923.01b0537d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312081923.01b0537d@kernel.org>
X-ClientProxiedBy: AM8P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::25) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV2PR04MB12163:EE_
X-MS-Office365-Filtering-Correlation-Id: 63812bd3-c9c0-4fb5-1a7d-08de804f4bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0kuk2zseP9Je8EROwwsDxF85B42ZZtHMkioYVu9IrwadsOek5F/pBvcMCir59c2ItW7sd2DNE4+Ec3AALFwsgKIH95Kxdu8En+n7isXxyc8yhdGksDf/6hY0jPFX8fdbiUHaYRGdr2aH5P3LQO4hbwvMSXQ++sxg9mNw1teQuSomAx2P9LZVm8PNytOwAFAcOFhxawLsq0Tl0kSxnJP1x1PbkH9HHp5y7at4Vvg+Z7ivFCkjjmTLxAmyOq6dpsNERZWNvwcLfGM+eZI0hZZe0etpLwqCISawmx+piEOOs+zuCTCRcJ0XSbfOv8qqzDzHUJE7ZmzDsCs01oj3vVmm2BWCfVO7NgoFCSC5b0MYvj33EoGxt/LRZSpLuUK6cGn4f+tmIpdYeH+EXBbCsNm+xYKhS0HKbdFaLraBtIem3j9DWvzSKUMxKWvEO0SgN95bPBHqc2Huin0I8ZdJutvylb+7IT8aUsY9dOt0rSoSzNNOVGEdzlNySVCf4xuOQoInLiNpa81mFP5S5AlSrou+6MYXLrhkgMJCSl6RVcCGlayi0hdiu4+QY4ii1E0+80EDiyFdPBRjlOy1KrDzG84V3LcRr+w6MMs1su6IrjYX6oiRX92Cgt9RS4kwcX5+B4PGBQIgpdtOyjy5w6HwQ0nuLk/nP8X5TJRJ5wVbWBdmQ95haxk8JwNYPUqgDdB/2R6u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E78MpDPqmF0or9Ku2lu1G4qE6wwNFWb9YSuNGj659ZKwI6E2kiQv9czpZvYS?=
 =?us-ascii?Q?v32MsXtEhDgHhY9p9KSYctevCIp9wX6GFvFfFt+b+PaxvIb9j+JqJ7TGMu4T?=
 =?us-ascii?Q?tu3F2PHuGPncLdJ0fJqKmW6n1yEsJDF6t7HhdGtnbc1T8YBp6mgLunVpfd3v?=
 =?us-ascii?Q?YJ2o5dUWIcxznon+vi79H2O/RNC4/3j/UmHtCeTf6h/9c7XqD0rEK4G5ef/H?=
 =?us-ascii?Q?Q22E5H/XYciNHBj2QEdn/n6yw5k/bqrkhxyoqawMI79YERdK4cK4f9EMENjl?=
 =?us-ascii?Q?x/C8Nwk+cY9KyVH+CyhoS2kM1Scbdfv5M2d8a4QoyZryF9QXWXDsW70GQ+LY?=
 =?us-ascii?Q?TEpVI2at0F3WtcI8IXO8TzX75V3uSeOc/VGYEGlOCF1nPIrBgWzDS4706+yh?=
 =?us-ascii?Q?qhgvNbGUKjbCHZLle/gi3VfQLeCFjvXnHi/oZVHjiBRQPdowFo6+vr5ULgZl?=
 =?us-ascii?Q?OyYwvndtDomIspgm1taRqG2z7WxViJ13uQHOkUFXd9d3n3A0uVX3oYR/LJgl?=
 =?us-ascii?Q?hp5y8IE+g8cX9bA7ji6YZHLcR7xX9/DEhn/o5qae3mmBcVqsrrodKXuyrVeO?=
 =?us-ascii?Q?V7m0wnpiko2n6vc8IUa3tCVeyUa3IDdUjRZ2bY0zyWBGaCCtB2r7YkFZKw6G?=
 =?us-ascii?Q?vitUSeVHxhHGj4m2/BJXXNwEFq20wdKGpsNbj/x7hfCq6Bezxa7EPwbq8uKF?=
 =?us-ascii?Q?Hsstc5Dta3WL8TMmxZFjSPDehkMougy6PIPUT1R9NGodIjc1g6Z4X2s7T77c?=
 =?us-ascii?Q?MDMOgy0vUiUDmF1ZE1BlJfvhlEjm8tftJFpAzm8CghIFtxc9n7HTLuo3YwI1?=
 =?us-ascii?Q?UMFxl1NCyWv+WY9QPi9atDMGGbE7A/Oo0i11dHq+1fYvWc9nxJimhzNjSpsJ?=
 =?us-ascii?Q?KtsHcdVYLHYSCzy7Hn1VkK3wFiPuklGrZ4arSxNjlnUlHM/YqCLGaNhMgsXS?=
 =?us-ascii?Q?OaC9bZdv63uV6LFqQMaRiVXpvijlwtKw8uaVPtrWZ73g0hiS0OH48JoEdpFW?=
 =?us-ascii?Q?CrQhEBseVoru3MOFkiIyQMC6srQtFrfyf3YUAcVR6L0PGOaMDXmL1N8btiVP?=
 =?us-ascii?Q?t73TrrLPkLA9fb8voa49kYrr0julnkvCUHKRihIDgbBB7n4CUHoIauhIQVMe?=
 =?us-ascii?Q?2jHJxE3TKKmblPn0tubtBHT9y3/Z7nVjTj3JNbXxwqFhGqXRyaNmZ/zANFaw?=
 =?us-ascii?Q?Hczcw0+uJHKwge0ObjearEU0oPQuB+lTEM+RVHbBXglWafudB8H/hJPcgFJj?=
 =?us-ascii?Q?TEwPNKeLbWcEwcY9griZOddvYM7mI2iqPDo2fvesIsq6G3T2GSQRf8gKoN9j?=
 =?us-ascii?Q?5s0Bxxm3EdoXzJHhgGcwWBSMsR5Q1tbaZKy9b6Y7nPRmNfczkJLcCXasca//?=
 =?us-ascii?Q?maqhlOV27rGEfyQ5y6HJCwFs0X+xIg+BkroTUS8K6yAZHOAYO8xnm/GhwZGK?=
 =?us-ascii?Q?4Q3BasEE6g4PQNzWVscYHO2Ynr36hgrLUDMLPHuukNl31jUWdiPPY1Ywcz0V?=
 =?us-ascii?Q?wlWsc0TPZ55utNJeFFQ7M874O+OpuRI1qTkHxhq7NjJBAZOZaKMFcWB/mAv4?=
 =?us-ascii?Q?6ndDvpiw+Hku87TuIgeK6XwaCsCYAIYr4PaVyVb88GDOz8Id9eIl4V2dw/dC?=
 =?us-ascii?Q?byJo4OnZaRBXDQ7EEpjW+g8idQc4/jpchGDaBDf2NxbCBPu0sXj7OL36VdWz?=
 =?us-ascii?Q?/hKQ9JTTifV9NuaGdepiOXAq9K44yf58uWizqOeoK+kdyCkvx1DaMElyw325?=
 =?us-ascii?Q?oL9qHLG4Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63812bd3-c9c0-4fb5-1a7d-08de804f4bb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 15:52:00.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 623yVlCqQ0rLHutbZWKFhxrN8oq3RQK/NlbuqsFTlvb3/BuBdQLjaVzkuuXW5kIZMea3jUDUTaZgC/T9laAm9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12163
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
	TAGGED_FROM(0.00)[bounces-267136-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,linux.dev:url]
X-Rspamd-Queue-Id: 87D98275075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:19:23AM -0700, Jakub Kicinski wrote:
> On Thu, 12 Mar 2026 16:17:31 +0200 Ioana Ciornei wrote:
> > This patch set aims to add the necessary support so that bash written
> > selftests are also able to easily run with a remote traffic generator
> > system, either be it in another netns or one accessible through ssh.
> 
> I think this breaks a lot of tests:
> https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--15-00&pw-n=0&pass=0

I used and set the TARGET variable in net/lib.sh even though it was
previously defined by drivers/net/lib/sh/lib_netcons.sh.
Will change the name of the variable.

Ioana

