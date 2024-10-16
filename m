Return-Path: <netdev+bounces-136103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314419A051B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959281F2208E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF02204F93;
	Wed, 16 Oct 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="GOCxeILU"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9317D378
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069926; cv=fail; b=ti/RNCIdt+5i+A3068/KrKr6jW40/Nz/inEAhdQZMQfCWNdGMo9E+T0MDmnFEv5A+Yc7z4XLaeSOuP7S6RbNk5MLMf5Yb+Nw10ce6XtCq7fcmJmmFByqIrvSjbzvYoKbzrt92vsFhuccIzs1762bwLx82+JdaNr+f98BC+GQEfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069926; c=relaxed/simple;
	bh=KA/04dRAoEEwGFmd7YMFTBwJTDj4gu6RcoCUxRCkuTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uagNsxDPryIhGmdR26A43pqAMS2hAUGmvA3ePYoqKlxdcsqvbvhyaAALMgG5l+ST3RJ8ZVOtSUHb95DMlG4e0oeN/XTPMH1vzNXe4weDMWD669yhaP5r6wlMeqxMtHEUshlHE097kAmy3VMel/7KleAIalFxv3t29ii3k6GLCEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=GOCxeILU; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id DB328200058;
	Wed, 16 Oct 2024 09:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4E0BfGheKlwwMXAL1MeySyp+T/Am2BzJ8vDK+j7cOkvJJoz0LwAD2ZF3y0NhZm5yZZM/lPedWvE+BihdnHSruE2CQ8Pb5ofMAY8d2AOjjD7qKTFsHfmaZ+ZkA4GgSz8ZTREjkQ5WYsLtQpKqth7fmjIcIapuB+c2F/1hw+XZ72nnNKMXtVcrUwdVGD6MoyfuaMyE7wcrGJpYmJAwJL+Mdwft2VPD9VOv6K9Qn1xu8oT3/beEzeFzZ6B0gjlBNQ/FrwselioI23RaPFZki640pRGgd98myKE7d4Unj4ca3bqfbA+/MCsO1tubnYe0dFjBkPmDmmHFCNnsgenpHLp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtFblIxKxWJkvo8Pu5w26MNOVmkjXzePuQh51WjI2ak=;
 b=kQI2NiMIxrSyWDp6L6GmFNBI+xxNd4ZPhSivzlg1xhocITpgxDHUb3DEogUfrmWI/qto1YvuUOc3uWgVh0xhwn7yKytBHNYFJjLI3Ey8DrfoSGziL8zXHyuovjAu3RO+o/QdjHRQU4Y4GdjVpEsOA68jOwBzekvs6c2ZUXTqHFHd3Mu88LFKWgQYCH3TkpOM4Sri1D2dcSW3KPl1zeUCk4UNbNGD+DOT6b6JdVpRIlG0PMk1Fdv8OSs3LMtrONauc4KjQkaiJAhWksmr/VDL+oQCTAVy2knauKrFFexPd7BQHHPnoNj99ESYNyRaYc7C7mVfcKmAximgG1asp7W4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtFblIxKxWJkvo8Pu5w26MNOVmkjXzePuQh51WjI2ak=;
 b=GOCxeILUtAMKJDz9gPDbN/hFCeKeJm0f6F7b7tG/e7SbAZp8veQ5DVrKHLl/BO8csSXhCX3T6iXVsdeqDj4nbTXrTzlgeg6+oph4D8rKDarfq/scn7WLIwBpnALJ38T9opyUb14LyJvUAg3JetdjURWo+cganpTGGbwoEGAx3Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB7324.eurprd08.prod.outlook.com (2603:10a6:20b:443::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 09:11:59 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 09:11:59 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnaaman@drivenets.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v4 3/6] Convert neigh_* seq_file functions to use hlist
Date: Wed, 16 Oct 2024 09:11:52 +0000
Message-ID: <20241016091152.3504685-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015232529.67605-1-kuniyu@amazon.com>
References: <20241015232529.67605-1-kuniyu@amazon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::20) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: a209263d-7b77-4993-3007-08dcedc2970c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9g6PInxHkXABpzqCNphG62V8EK8IpiPEKz/9K4PHAzjyDBtzy9+UCx4yzF9?=
 =?us-ascii?Q?QrZkkfHELUkT0MR8r9TpM4ivoQCgWOTiCgMXcHjUGXlOV8hF7KZh6CcYIms4?=
 =?us-ascii?Q?JoZFVsu8b+oL1/ARKXguAGd+bn3O2lNtJs/Wvzog2ab97heVbox4iAGkBTwT?=
 =?us-ascii?Q?z1YxnEmWUzscpfP/Ug5AYxeTObPm21ZHe0+70pdfeF0JB6DW6/8pTzIA/Qbp?=
 =?us-ascii?Q?VFaZx+8Dh4hST7940D3A21pPvwHufZhvf0Q2d+V63Li6fX4OuY6Pdr0YiSeN?=
 =?us-ascii?Q?Zmnf6mZ2wpJReX3Xp9t8KuEES63tuMjFHQs9lrzxBTdzsdeDOFq/39So7tVe?=
 =?us-ascii?Q?11z/jwN59L5wfAuRywFUDR8Hf8JTyf+VZzjPdCovEMAivtJwFHu5+t3RF+5I?=
 =?us-ascii?Q?K4y75pefD5xNq9nYb5DVgL+zecdcKHvtxS9dbqnNjfjpUJGROgLvLOcNB7Kk?=
 =?us-ascii?Q?Oxs8o77195fAhulWPrjzApW/G5clrPvJjXLg0yvHznuwCpBacIVyIf4iQKhv?=
 =?us-ascii?Q?16uB8KtnnB96wn+IRpotqV+bIlFWRjIlla553NmfrzIPzdqF+i3eODIGBOuu?=
 =?us-ascii?Q?mhYZ/HbHJNKFWLlLZsqSyiXywYTyleUm+25701FJVMxiD80kig7gOyCZfg5/?=
 =?us-ascii?Q?csVViWatClefrqz159IqkBLK2Qr00jB2Ct9H+c0F3mVRRAcU9XuuxicpIF9X?=
 =?us-ascii?Q?+CGHvtAPtBJD5CY/6+zB6uOiBHUBDarFXPcZi9BwKBuyy/+Db1Ktkix2IBJu?=
 =?us-ascii?Q?dqYN0AV9cbMxX91vN43lKFnmJiT3rzhsgfkLUEG93JLd5NiXJn7bciZkptQ+?=
 =?us-ascii?Q?xlRI9P64/70xOGFVn30hviuw7gr2Z1VJ6S1X59xNcDn7THHaic5WYygBKgbZ?=
 =?us-ascii?Q?2ePrbetD+Lc9eZrWP+uv58wL7FcY3ih48D9SRSBekP1Afh8PVE5fduKeFa+G?=
 =?us-ascii?Q?cynZBttfSJ5gb38HecWPVic6qlI+06AA2tWpWAvDGZGVjS2FcKr/Nn3N6tHG?=
 =?us-ascii?Q?1Q/YTxetoiA7n546o6QA3OakZqi4ltiFoHKwEchutEE0S6egJqnhKamMXDcU?=
 =?us-ascii?Q?aelTSs1x+SlWDnyooDmRDcTkEoWuAmpcEZ7TrP9mw83LQFukWeupFTnB8p01?=
 =?us-ascii?Q?fuPLD29//lg0ORHIrFG22yJRAuq6388TIo6Kl+g/riazNTvLkhmQ4nUOsHvC?=
 =?us-ascii?Q?4tNCy39NM8VXB/Ri0Lv+XqeSf7h7VqxnI3atCE788aa/Z0QXeTvyK91X+7IP?=
 =?us-ascii?Q?VyEeDy3BuEbO9FPA5HDjMyWdDTR8P7Zj77GSamTD9NTL80Bezp2wyhtw8C56?=
 =?us-ascii?Q?cAde7qbWsZpYzs7cDVpOSU8i8l3+ACwjqkILewkvPd9vJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A/rUlI31oCuO0xUcW8WAV6jQ+DG8zUcC6ZCTXpoyD59VQKxapnoMHAJ4kwx4?=
 =?us-ascii?Q?cSwrOA+cLFA36s6vS2gHy8yV8ppM+mCQTtaEjndqk37gd48wS6LPQctbZztR?=
 =?us-ascii?Q?YgL8SVbyAx4ORlQsoBspp51P73DMe/mI11+K9pA1MxWoTA2dGGZMQ7quScYY?=
 =?us-ascii?Q?WYHvKKxP3spHvNnYZhdmXMF3E/6Skh2YhZZ9vInOvc01cWKKxa1z0ovYOexl?=
 =?us-ascii?Q?Dul0F3z61af70sV+wSF74jDv0vaDcwqTZezo7oiCwfdwyAbW/ss5FOOz9p/o?=
 =?us-ascii?Q?+w9IcD47EvUXLh9680Fjf4kDIWkFCgvDN9BjL7haE+UllSCAdJNse2xWh6x+?=
 =?us-ascii?Q?ftDtexEgOEeApZYkq6OHhR7Md2Urs1dWc+8FBzXOMTDb6R71+AVF10Zv6fF+?=
 =?us-ascii?Q?tKQV2/fX754xfnmtRg3QmNxmXTiI3OZ0qCcVvp1AYqPQxc1B0aoLdjKl+wxQ?=
 =?us-ascii?Q?7l4BZKwSNu1p7OUpueRXA4QzzHPGpi3ml6andQ/4iv8OSerS/1ws8Yyg18HO?=
 =?us-ascii?Q?ncMrttQs+qEjkH9j4nbdUUXl+xR+RTqnGzbBU9KDVDRuPoPJ4Uu6xxjUg0Rx?=
 =?us-ascii?Q?eUKjA3fq6BvKIKPF8uK4dKwoPmjG+Qq2UPIo5UNHu3zHs7X6YUBENStSNZTl?=
 =?us-ascii?Q?nPHLEDF4cSJdr7ALddank7MRk7JjFL9noFuqSzrIQ3WV/5kt0v5QLgbfZpri?=
 =?us-ascii?Q?C8gCye3h7uthL5wdzvvornTPXUELepDCzjbLcxTWVUC1GLQZVGr84iXOOuzJ?=
 =?us-ascii?Q?2ZxZ+GGxtbM4KqWGiSM4LDR/pKaWHByljI7AzWE1yc0wSu/cSfCFwtx9Kf2K?=
 =?us-ascii?Q?QKwdWZyIlWlX7hcrq1DjQ7lV6Qb968YUcBjMsS0LsOn8GUMBNdUbF76DULe/?=
 =?us-ascii?Q?634/h9CnoNeyGpnFO6H1MmPm7x/mm9sRZsiwESE+/bsBg0aAjSCXnZHjKXd+?=
 =?us-ascii?Q?1pZBq5ACPR8120g8J/kii/MFPQogCrWZO6SBAGGCY6rLI3kIm2BPkZ1JkNWV?=
 =?us-ascii?Q?fjcIkW9BNwg4e2jJyUgjN3zarOVzBYi17jEoITBeQ8xkC0BHplV4m/kFiqdN?=
 =?us-ascii?Q?hYlgEwyqB8UR8ziT5BHLVWeqLytNTtkB2XMMnPbngBwyuLQJBSUdvsV76v9s?=
 =?us-ascii?Q?KapiNyOP1I2JG0hsyQQOo/d1ciOsl0q2wCwnvsLOLPKLrWtul/0lAmtkv+2u?=
 =?us-ascii?Q?8DalcxHVe5IDhoAJkJspnA3cHrt+xqxFYX8/vM6GZR+Thid13sXPwTYQ6TZU?=
 =?us-ascii?Q?jFs3XWIl1M542jGCJpoMMlh5o8ptnKHgO22ihIDfi7ji2c2ryJrElww85RZz?=
 =?us-ascii?Q?8R5D/ySlLtlWILhLPVTblq2r39p8z1TlC0aAVnrm/YMG+GauH++nw51kotzR?=
 =?us-ascii?Q?2ZE1qCT3aAuhZwc/6K8N6PQP4SzALCfBgdab+zjy9ju0LWa2/6hBS3dAIgRa?=
 =?us-ascii?Q?kjN05qJ8UcblmBcNDg7h06KKUoqvkKB4kozC3DKYkUaWpAhEjoHmSmAh9Iu4?=
 =?us-ascii?Q?FfGh9LuLGLilE/m0Hw327bAvUEeJAtw0pECFGuKrplzVwFtCOe7bjt2vZHk5?=
 =?us-ascii?Q?tOCg/vqqoJogQbWO9zN2AqDpgtqRaO/BUwsvAr3TQqlT037p7o7N2rItKC/h?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AQ6lt5kWEk2e+iuXmrQII/DvJSdeg2vjlohl8ACM5nfh5Pkq0CDjkyu16AYWidKGO0VNLbUYKF9Sxvd9d/r9YS5cvr50kwNLTcD/HXR8vpZ4eXalcqLuq0E+889h1vqtSX/o6/Iq1dg6ytDTXe9P054q90b5x+bYjCcMnWwuIFlk9kSf3JUluQSs+1dqsZkrmt152CUU2cVBMQ3agcdPkXW5T8thxd9oZ/CwHrz4qm30QhStwLlKqjyfGXV8Sq2wkvp0iz4Uz1SOQ0L1h6EKU95zmylUmLWQCzPsY7NAOGHgKfg/NC8Z5lSRQ3i/XPjwPPgIKQdgZtNSEGgKIrJ1CeqMAFqY819uYBd4Dyq0UjpUgdSmF6BAyYvc7wHza0+0RSo5L/j/VQ0Y66PA1X/XHhYiGtXlKP17ZQZVkBlM3Rf2SBvlD2s82J24lREScMaVe1QqhxQ4W8V8Mel6VT04qGxYH/O++HEsxWCjOBRPT7j+8D1kOIXKtq12T61bs7BrkMkPV8sItj8cPe3tvw9Ov6ZvFX0WMRfu8EKnkW9d6fvY8AihBuvabtwK99jstfxL8A3Fz0um2h+WjjyMiRG5HhRtXiqJLgFoHKOYYpjRuabcmCZrI4aPEXs3AS1SFU09
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a209263d-7b77-4993-3007-08dcedc2970c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 09:11:59.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMkT1skG18/8JbsP4zAIr01Ijl2Yysd4nq5CyBfhFBUHCtc4DuDSbYomBJitLroBvqPOkIeLlDVpBjHiEZkr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7324
X-MDID: 1729069923-JJ1j_tJOFsOo
X-MDID-O:
 eu1;ams;1729069923;JJ1j_tJOFsOo;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

> > -		if (++state->bucket >= (1 << nht->hash_shift))
> > -			break;
> 
> Let's keep this,
> 
> 
> > +		while (!n && ++state->bucket < (1 << nht->hash_shift))
> > +			n = neigh_first_rcu(&nht->hash_heads[state->bucket]);
> >  
> > -		n = rcu_dereference(nht->hash_buckets[state->bucket]);
> 
> and simply fetch neigh_first_entry().
> 
> Then, we can let the next loop handle the termination condition
> and keep the code simple.

Unfortunately `hlist_for_each_entry_continue_rcu` dereferences `n`
first thing using `hlist_next_rcu`, before checking for NULL:

    #define hlist_for_each_entry_continue_rcu(pos, member)			\
    	for (pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu( \
    			&(pos)->member)), typeof(*(pos)), member);	\
    	     pos;							\
    	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(	\
    			&(pos)->member)), typeof(*(pos)), member))

If I'm using it, I have to add a null-check after calling `neigh_first_entry`.

Another alternative is to use `hlist_for_each_entry_from_rcu`,
but it'll require calling `next` one time before the loop.

Is this preferable?

