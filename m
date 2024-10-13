Return-Path: <netdev+bounces-134922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2C99B919
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FF31C20A84
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551A84D0D;
	Sun, 13 Oct 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="PDfb1lUp"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237D4642D
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728816341; cv=fail; b=EwHJ9ENG0zCiNfIg4udzPkVwdT6DHVI/x3kn/MSHjMcEsYeVkLXtCVf5ZCnMKXRnU14fSxhITmfcX0nzZABBbwUltFdWRsWe7F71i7Ug7lv1paj3vDgNrw0yJd4DdXjQbS1mrvCbIvk9WBHPK3RZeLzsCjZB1d/IHHXYsUcKNvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728816341; c=relaxed/simple;
	bh=DsnINV4+IuVl3DIPP15/PPkiauUXhu7W8wacI0VGScY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtVP7Yw+TrhO5CbxrLrg9z9tg+qInRXxdq7Ypg3peM0WSXBrteD9CvEq4qWykvgzrSKbfuc5mwiGhkf14o9ATMPKHM+lLKh52tGBqcAYxY8UtmRZ6TCZFRkWbCpxtFe4cWDgJ6kOK/7Q1+hpH7scNTjILwkCOSbvrNXRFPiuE0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=PDfb1lUp; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0B3AA200055;
	Sun, 13 Oct 2024 10:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg2pnGlaVYhjeGZLFMVgaBrQ9driDRKr4tB4QA8S1X5IABZuw8ALiNzgF06w/e6PjMnmZRZ07BRDQdMJJaKa15ynoQH51wfN5p2QfVXHZe2Yc/T8ADUz9uZE/TGmmpSn7X1JiR1dnq6DlvhXmyk1BAr8zyvUyZXMtR0WNE1Beo4k7rwH347TJCzWExTrHFbob4ev846Vg+AKiiq8ll2QJDa2pO0xwyEnx1iyWjsAozoGuhso0yjChnpdTg28wQBVbHvucQnSzvZ9kJFnNl9paia+BZ0H4loHrSTugCKxUEeb9NPx4sBStgv5S/SHk9qXeSHPCy0WRD4HPqBkjCQVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQl+qiPRaIjK2Ng8vJfpYQivLbaiS75zG4FNhRUETDM=;
 b=BiQS5RtwRU0A0r5xZd3uRNMG4NUjceWBb0fQNH3Ho393xfrqm+/5CRvQnxwvozyT8KbhCanvgFhE/YlleK+n+IJ58iR1nhL0HzJ1t5Xx6koh1rSrg3dlTCGN1m2NSHQuveb1WftUvlA7SZTGabxmwXWYyAWh0enJuLqTrYp5dVtaUtDgeRwRdfdReo5zio5uo/d49KXQnLOy1rAEbIbw0ZQdYlVP5N0456SGMuSMbmdJRnWCR8UWQ6Ju5AipJkgkUJIP9HvX3N/fCKUi6wYQEtWXFRq1Y4j5nAw4tFrntMmVhUuTW7DolBy2pSxL20bPaps6EuiLYjRQY9IXDHOzaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQl+qiPRaIjK2Ng8vJfpYQivLbaiS75zG4FNhRUETDM=;
 b=PDfb1lUphneETOp5m51qKPWDQvWXqOKfM0EoJ22PLkHJaYt3J67nhiIxiD6ILtNt3f3Q8ckxaI0KqE9zAGN/bYj0ACLQDHDD+TicaJILMegDBj5v+gU1Wl8IPTRBbwkIta6moTsVbTVW7rkrOUOpTa063kUbMVQ8Ku7fCCQ2DVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 10:45:29 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 10:45:29 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/2] Convert neighbour-table to use hlist
Date: Sun, 13 Oct 2024 10:45:21 +0000
Message-ID: <20241013104521.3844432-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011011617.16984-1-kuniyu@amazon.com>
References: <20241011011617.16984-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 1decd8f3-e347-4d02-12a8-08dceb742742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWqFhLgUQ15prewDSUs/gr/Uz3vwL3jnFyuswsYfnF47IMf7UBeevdq7usk9?=
 =?us-ascii?Q?ukedBOCK/7jT5RTQKneDVxaXToWgLpkHuS/t/m+zszZSx9oQTPndMTU4ulak?=
 =?us-ascii?Q?hEEgqd3Lv71DH/8BQIOPj+m0xbROtd4QNBV6l6MRJJSfYg4p90dRvDkNVQrN?=
 =?us-ascii?Q?+GfV369heWbbA/Wg/GzczPuKl4v+/Id5jrZ4HY9JGCfEoJkAZ34uVyYTMvFQ?=
 =?us-ascii?Q?POQ68jfvOIWWlDYNUt+Fe7XuWfe/jn+DGYgrlJ9bUuWtp/X4ILHneOBgt+N5?=
 =?us-ascii?Q?ftpoEGtOxi0aDZo4RBqkLobrKqYwMrECaDxBRzosG1qE72D+0pMHnEnjZfcg?=
 =?us-ascii?Q?iCfuAmQ0JmCFFfw3HqWnWy9WD8oDyF7qYHh/jum4IkByOfZRnDLTWjDQ3/lz?=
 =?us-ascii?Q?gGszA1aVVTx4qrlFUJ47uI7HJkI9tYRB3I5xw2NTOgjZPoX5WPcXYCpMhlHa?=
 =?us-ascii?Q?kB3bXz9zVSY6WiiO0A7A7huQ0SLE1NRL5W0C3UflYL9BpYoIZvNRFl/55A+L?=
 =?us-ascii?Q?3L5NhR3YUWPInRk5jt3Enp8HKeAXwOfhm5Sniq/2hlZOM7OMQz1b6pT+1/Gv?=
 =?us-ascii?Q?yIM2mj3rE1LCKANAm/IvflcnIH6+kpaxV7P5F3TT+HzrXRwa3uvQrMJQX1OY?=
 =?us-ascii?Q?6BHp6ld2mUkPt0T94YPFXDilCUD7s5dW+m7dlY9zR8ohjcxcGn9sdSZfbvNU?=
 =?us-ascii?Q?pwfT+swZBWvN/wXLQdbqaL2XtSxJCLStBnczLUOZqa91NHUR1kF/0xxWGW//?=
 =?us-ascii?Q?qEVeTwdlP3gnPZc2bYABKCXb5GB/2VMv8LZ0GZfPdyaGGT/1bMQ12018s2T/?=
 =?us-ascii?Q?RjMVyRxObzCYm3Rq6ulXFrDIv9MMiEisMg7JN57czBLgh0PfAEoTb+7DdyP/?=
 =?us-ascii?Q?5pFHd9GCwIrc3jbe9L362Td7VAm6fRy6P5yPiOlNlMS/7NXa0CqxzuDM4Osb?=
 =?us-ascii?Q?O8gp1p0A8HPnMAc8/tgK7FLORstZoWMLW2CTHGupAOJ3DWDVV9r0HzBRdZNR?=
 =?us-ascii?Q?6njHizltCzKS/CKFdf8GjZBT5Zep9CdcCQaKNfZGVTEi1p8GdzKG37TyUchn?=
 =?us-ascii?Q?ttuvtXPNiUPM2lxggJM1ip2aCAkpksWOT3XikbOmMWamg1rBEGvKexvpu1vS?=
 =?us-ascii?Q?tsbolprsbTWW91v53o+ZZ14vt68lKCy+9VZl+hsu+hVSb9SbaR3wcMsro1Iu?=
 =?us-ascii?Q?ospfbJMmfZZy7LMnf6wnJKZq2O7uAJapLYrMPIMMJHqM/NI7nzB1ASNO09e9?=
 =?us-ascii?Q?mtfub0gYYKN2N4EAIhjm7vRgp8eTolBnEAd83N1S6PKl5+gQ4+/LSBLSJm5r?=
 =?us-ascii?Q?8dgXhv/wnT2mkpfIJkdysvRMDDVUHVOr8m3r1gE8RKLVNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oM6h0oZXRbwsBMv8z1Qj+DzKPY20nyNMr3nYwygC9haN3xgUn3zeN+FsufiE?=
 =?us-ascii?Q?5+Jjkvni2WQATNKnTWrsX7NT3CAaD5kGIAWZyEW2fLbyq9Oym2iKnowmjxPD?=
 =?us-ascii?Q?maDe82gQxyVX39Jdvuh18ZWeMxGVmHP0pYZLy2uzfJltrJL5UflSDHStxf6U?=
 =?us-ascii?Q?SGn1b5I9lIghvMmen4E4IUEjH0RryHT82i/7xMV9tyi1dcKqcdZ/aXCN02qq?=
 =?us-ascii?Q?IEZLPW5YHD7YqoCzKs4qB0g6UFb9p/od0X8FtuDLDy6bVvZ9RzhougE5VBra?=
 =?us-ascii?Q?RZ7fSHnEna0mppPP9+E5jP4ocUIKZoblx2YLWMN+Yn+7HmBKgY/Ue7xLrCsO?=
 =?us-ascii?Q?/mFGM2ZOKVHf//1w54D7mjk3K+CRHA7lWA+edFVBfUw16bPNKXeLvwSZW5Kr?=
 =?us-ascii?Q?vwNLOSHBhOBA3pDWU5nEtN9nsU53mpFi2iiZhympINYCvkP0YtzC2Cx1MwS/?=
 =?us-ascii?Q?LJ1umJSDmGz9GWKeO2l78vhrBiQl5yqgzhbgYgDfhMRnKnEEd3IyjbcYF0Yb?=
 =?us-ascii?Q?4I/LKsRnxTtRi6lU9xyT510lCaorwMEVrvXTGM//61j37uu33whseTc89RS4?=
 =?us-ascii?Q?w9GSjLTZnEhg3TYTCWSepNHWNmZr71qujWuDiDHrV3MAHaeU9MpeXO1wOTWl?=
 =?us-ascii?Q?BGnJfVAQhbzVg6Q2OplZbrFp/8PtfGDe6NRWZCCmI2mrKS54cjtD6O/civ9W?=
 =?us-ascii?Q?Fw/nHTTK+EwCrJnVHuLlHTz+bVJEXMYMdXYNrqCCnoiGSehSzoVqMVqU5uTx?=
 =?us-ascii?Q?YQB0FTMhrtDtlAoez8HGLW3z4KmL/2H2LHF/leiNRreLv6wbA9KnXqk+eYXx?=
 =?us-ascii?Q?Pd2iChEwI47XIzi3BMsi+guh2YnsKJEvvxiR0pDdOEFZ/kh2QRj45ls2QTPf?=
 =?us-ascii?Q?KNrI0MIPw4zCrlREJyiyoxmo+FyTq+SPJ/Y9hxepTkdwPnY8R2LJ09kDzw3c?=
 =?us-ascii?Q?wK0s0kabdNblYnRDQtmsoH5Ctr2w6fxZiXKXx+GZQc95Ull2mIKYlrzSdKp/?=
 =?us-ascii?Q?udHKg078n34waTp3HgO8CrcHRDMEfWNjBgP5ORTqqAusV+4KIJp9vZwZFDVx?=
 =?us-ascii?Q?aTzh0GB/sOSWfvaSvM7SHbpwbv8DduI2o98FEbT5ci48iNtxhyfuJzFXnBR5?=
 =?us-ascii?Q?+CIUygDBlyiRbcTTIVjczn0xSd6kol7ZqEkuNqlXUq+DhWNsxAGLDllWdSkZ?=
 =?us-ascii?Q?71RM1Sk4aGp/9gU4eIF24TeSjy2Ps9H2pEBF91agqYd4Wa64DlsnjofkiNeR?=
 =?us-ascii?Q?Q/NWqbz69xRoG9GBrSThUCSZvWsE+nykKZK6yB1V+UxpL0/pbceZF54gc1RZ?=
 =?us-ascii?Q?aqSg6t3Uy+cemN1UpSlnMH3MzIvqWQpkLFjTjiJTvxFv9AmKEToN6fiB858y?=
 =?us-ascii?Q?+dUxHWj3uLLAz3ZbcXBBtXj1FfXL+Z2V1xvQdJ/gNwOeYqpI/5uyKr9BCoLH?=
 =?us-ascii?Q?w8wjzhlWL9ASpQYZS+eOUG7SUcw47Gb6q60DJLR0jnkr6yfds4kaMI3VLAW/?=
 =?us-ascii?Q?PZ68ffpco6DaV4F1yqZMo9F+yxECq9eiNtS50rpFUoNAavlMZchiXeBnqxwm?=
 =?us-ascii?Q?SWO8NS5PUiHNKNJ3Lwpa/Ku24K76TCoXohv+UeFN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UmsAvLXjGjtW1pzBAMLZ7CKMUNZ46pYA4xnG3zEUxfQJil4S6aeh5tby0U5PF3lzItVA1st72Wg/rJRc+4O7YjOeibG8HKryxfNphHCtW6owP3IAuwoUrIAK/fj2uu/xzWRtKEHZ8UeQa+o7Y5QH1nCTvhHBYE/lC3vmqBUK93CrrArlpEfs7xJUZ88atsjh5K2jLxUOAGv4avvk9aHKAKUzr6sge3cNlCgOZUDLs2rMGl54wTskzoq9KkK+Yhm6gLGK2VIsndVjCgBY6DJ6ld489VnFMhjSVqmOt54HeJLyk4ET3OmqOQ1jHJU/KIXeVqoQJMjvY56KeJ1YQ17HEIDn6/X9zCGuoIFeXZhUZrYpxt4yFLhxPhbP2IcGKVC379tr4o8BJm0RvSPsFpA1no75Hk0b698jUaw+7IPgqzyH+hB12u7VUxVvjmaCLp+Fcv5x1zD8Z11B9J6WtMUaMDYPOnrckkXspaKmLQnHIkW+HXQZWLyhRsCWSBdt/NfzbBeOZjDehgdJnBZ8T7NPXsjZwrWaGybdqV2cGwWTaoHuzY3RDVBF3DKJavLJuwywA7TXw8JUxxmzx42LFse1a2mv2KM9eaPwpDDYJDyqImYmdAy6oj/jvSjqejR3mef1
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1decd8f3-e347-4d02-12a8-08dceb742742
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 10:45:28.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhvHp3JPhggP5/e174FhkGifLWvonXP7BRJYIGzx4jA8KIyLuvoMEbpmPRKa91O5CAaTMvCNiBbdcc0nTOwEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
X-MDID: 1728816331-3Ihn2w9Zuvcr
X-MDID-O:
 eu1;ams;1728816331;3Ihn2w9Zuvcr;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

> The current neigh_for_each() is only used in spectrum_router.c
> and can be moved to mlxsw_sp_neigh_rif_made_sync_each() with
> the new macro used.

Oh, I completely missed that it exists, sorry.

> Let's split this patch for ease of review.
> 
>   1. Add hlist_node and link/unlink by hlist_add() / hlist_del()
>   2. Define neigh_for_each() macro and move the current
>      neigh_for_each() to mlxsw_sp_neigh_rif_made_sync_each()
>   3. Rewrite the seq_file part with macro
>   4. Convert the rest of while()/for() with macro
>   5. Remove ->next

Just making sure, you mean that in (1.) I should add hlist_node *alongside*
the current `struct neighbour __rcu *next`, and only remove this duplication in
(5.)?

