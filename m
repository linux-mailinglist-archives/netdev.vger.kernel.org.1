Return-Path: <netdev+bounces-257835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLHyIJm0iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:06:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B30109575
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7EE3011BE5
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240436D51F;
	Sun,  8 Feb 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KS169/TV"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F951E7C2E;
	Sun,  8 Feb 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566429; cv=fail; b=XPzLLJDCWqzT1d4cV0SltxvMaOFad3CCPcrIwDwE4ZLv6hwwd0deu3fUqy0jxgPdgtEEpFxglA2tjqiSgOVdJqTlITjivLdAPOMUAiMM4AgeFTvRqhNlVTXIR6y3PVGneLGeqZJOgbjoTK2Y5VpBZC/lT6NC/4IlDEYeJJMmgpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566429; c=relaxed/simple;
	bh=+EEcnpxlDII8Bm0gelNLQdcGhjFASheAKJhj8vYwNJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLII8WJE5uC5HV/wCMT0EziRdd2hHLSlrIotKtwoa0TSItT/rZW1ghPyY0OFOCoW3oJOUfkV+nkqdQykXJVPDtqSsH/JVIVTZgJTn0wZlV2lMv4lhC5lNldHVSTWuzjJLDTEZbrTgKIwoRAs7hg0IA7uMdwUZ1lsxyF8d2UYFC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KS169/TV reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNKhATH5R/8/Z7UtTVHN7NHG8M3iJiQ52UpW7dRcSS8l7hXUZvXW/kTjLiLQmwsHLaFm2fitMYh72nItgfE1lVqhlRZFk//wYYW6tjhatw2oPA+o7niNxOR5cEaE9KZGAmsQf0jqjrW5dyD9i8Mjjm2Yfe41ntaE/zpnCpE8HQevY8ibz73J82NdZxOtzcP1m7mPnWJMz2y64agAX6IS4yED3Yy+1XkzqRHsxx+AzYsVKUUgXYF6fMkOZ7eBFTWwwjMu4x2+9NcpB4sCi6Ts7BOZQZ8OSa2CMiFNgSyEnSQSvg6wdr0JRscC+sgZHQIu8wx7tp2YENmlVtP7mbhagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89h7RdakooT+R80kFHPN8X/Sqsr3bTlld5yqpVVXl2c=;
 b=ymevGREbV1z0iLKXUoIJgzHRyGoxbCjl1U2XjCwuCLEpKvOJNpOyccxgwuCNvcqk2e85znetBg11cW5rB8WhCnXbr5kxbUAhKRf6VWHdTTHfWD1BfvA/ckLY+A9+7LXtB93x03PhTjMTO4RAIQFt1kiJC74u0pTwEBJCk4JQlHPcCXRsDbVcORlMuvhSP1vsYFjyJh8mDmDF2AlcYx7IVOMScV/n6Qu4Ww4NgrVFg+SRQ5Hy7e8qDyrYwuCbRwOyJudYVQrQGTNdOUOJ8Oh8u3hL1pONBSZFiZYPe8AROGVGvE9o5qRqjyL/YgO5OdhUok963xe2NOlct/9yveNpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89h7RdakooT+R80kFHPN8X/Sqsr3bTlld5yqpVVXl2c=;
 b=KS169/TVlzxVDORl43EHekztSzBORC5x32EVmrXjm75wFpevMb9IRZya9JvLp3BNT+EXqvrF71iic/IXwR6fqSfvk57nEQWquNUAnW+CliUkhPgZHbCqImEPBTTUkSbQCz0jT9UTbbUkXz6iluiKCAtkYwa+FkF9CTid/Rc4CigwJSRg53WSlDQq+7noLFnAwiXeFxgqOBX0An/THYCRoauC2PlfDGoLks14jhIptk4cChzVXAd39ni0NNaWLXBod6FaGRr2qkVgvFgT5tDVLy1hofvKYuBDk8Vsyeg2pF2cGl2LIEAnVzgPmUWbapiZoLJa5E+iqHLad+9kIIjkQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:00:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:00:23 +0000
Date: Sun, 8 Feb 2026 18:00:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 01/14] net: bridge: mcast: export
 ip{4,6}_active state to netlink
Message-ID: <20260208160013.GA154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-2-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-2-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fa8841-e3b9-460e-48d3-08de672b2ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1UsGHj0Wl45ImEvQy6XXiVK7PmwN2EkB4GTnelpxMSdk3zLctXWWbzk4vg?=
 =?iso-8859-1?Q?bnEukF+F12sbLo8p9DklYRdKCWj6g/SKuGmU8WtKxp8mqrh70laOk8Tr28?=
 =?iso-8859-1?Q?OMfcG13XFfGxBBYXw4iXZ1PLF5eyOBwgWoWNat/ava7Vjo6PB/p0DeN+Yr?=
 =?iso-8859-1?Q?6UwJFvDB+8yiQ2vPdyhMmA1ujsEjXi+3Aq7cPcM64+bf/TB3XVpUOx+8Xo?=
 =?iso-8859-1?Q?g4iry/NEX7Sjwm7sZnMZnE4owOxJuWT8oN76SHfFtGANNeL6AvruZ7phhu?=
 =?iso-8859-1?Q?EIdL3bJeWmo1vUFcTlWobpLTnsjOtZ8UccHL1CLSf17420ncUOa6fphCCU?=
 =?iso-8859-1?Q?HHUDWE2AgPDWCrwk3XPinnIcn8dxh47utRl4go0C/vXdoun2nkod4mlUmH?=
 =?iso-8859-1?Q?QyfOJoaWWV8WAd2nJA0TN4VyjzwtzP4k1ca5Jk2K6kYNKthbAHIxX+boZK?=
 =?iso-8859-1?Q?OM8466P5KoxoIWpDEt09q0emMXzZUOB/E5ubcgjopCjiLEKbhVed/BwesO?=
 =?iso-8859-1?Q?rOl3/k+lZDIjNya6AscOqFr5U9SId4oQqHL5rDGWBUp54SV8CSz0COLuxk?=
 =?iso-8859-1?Q?eaOapGshPlBs44U9y31GdAujp9Xc6kgwRypUrdja7qRbIPIqSA2O6RzPYJ?=
 =?iso-8859-1?Q?1yAGYpqd1QHvc0lbllAu09Q4zVFP1nyG6Gs4paaVUIdYHZSGeBQ0fm2qsj?=
 =?iso-8859-1?Q?Vn+9L3qRnmSOCfJbPohHFAlTsPwr1elQpLfzeU4T6CfRzPsAerI7Lhv4xM?=
 =?iso-8859-1?Q?exIuqaztzA1pTi/EONb3TNU8ZFnTj2bmqDTcTKLeCqal/iJ1AiJ17R+Mzg?=
 =?iso-8859-1?Q?sGz3vR9i/wufWeD8q8GaKYdsXCsNHhhIPlZiVDrWNRCAqiAL/8Zs14tyTq?=
 =?iso-8859-1?Q?6vPR8reSMR+0vBPQO5cviLjqgZb6l5ww6m1gVFd5dwfNF5M9QPS+bi9HIR?=
 =?iso-8859-1?Q?F4BRyaSXMG1rA4++5PoQfsGtOqxySlbeCftDODnB96sos8FLK1HWHnvFZV?=
 =?iso-8859-1?Q?jGYq4zAsZ1w4bfi7bystAegfmHuW3al521fXLeEkVv5MrkcmD2XW3bGu0V?=
 =?iso-8859-1?Q?4GV7tP+glLGNZoW1vvepNHKoYayNPwNOf5Mu5kwpBXN1bOW6fYJe9Dd+ia?=
 =?iso-8859-1?Q?5zs94CRMUyJ+yYXPUlCsyRgnea3LrmDruJtpOVKSSJhP9Wf+H/GQjJDhsl?=
 =?iso-8859-1?Q?uPxMgrL3yOV6CiMqTYjJFb5WvEjeBFQKbqZ7iL3S/ZcheZhRL/9eg4fC1a?=
 =?iso-8859-1?Q?Uc2tNu8yjTJNcC+DcYOG1O6rujhi1Tm4eDudY4e7UY3UYGHnKIchUJUeIb?=
 =?iso-8859-1?Q?NLK3F3LQLBjph2zaY+DFdpH8sEQ/O1obFCjE0sfZ9HD/OT8HjH3kXQ2oy/?=
 =?iso-8859-1?Q?u10cO4OtcmbeSBXbMCoJp8F7/EneMEkPCy1rDT61xw56PhLgsbdYYgqSlf?=
 =?iso-8859-1?Q?0kkrLvQn0RhSaf5LwWMvX5HcHBGrz/zPgVGyV55aZCBuci2mz0ccJ9wPE2?=
 =?iso-8859-1?Q?GAN5WMbCJsO5wCna96NVPSgAfGvnZnGzYt5DEwEZrEJAvLoGOTfKLYbf4m?=
 =?iso-8859-1?Q?KagrfmJGcWrDf8kxz+sJGRmdAP9naXsHLCYP4R21iJTTsWXrBXNjEyBjBS?=
 =?iso-8859-1?Q?PlvBA/vyNQKmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?tCOqmRYZwx9ZuIpA1gCZGwxwmGjvWC/Riej92sJbTNd46BAceIxQryrhgZ?=
 =?iso-8859-1?Q?rDH18xmvoIDugmX2MVkkbIaTB2ntGwRAHgG1b/5OUY/IMiSgxzuEgmYSn0?=
 =?iso-8859-1?Q?Qg6b9rc6hWu1f5RWeeOcdD921FsbDpDlbAF68fdrYhz8dY5fVtSOpNg5Q+?=
 =?iso-8859-1?Q?NT53kV4fAGy9V0t7+uJWuU5+wC66b6CfrRAcalNBY20UfJ05QQSkE10iA4?=
 =?iso-8859-1?Q?DjZdgS31cMCZ/v15ZL62861ihQXPO8KIBxp7qdcWRyhwpJ1PmdnqVMcF8c?=
 =?iso-8859-1?Q?fgc1sL5i9QvN33zvXIn6UOBILx3bkbZ2dMdlNnPH8i7UfknB6NhJJfGLPj?=
 =?iso-8859-1?Q?apEi4AmYs+UlhRHmDHJYRJbHbxhTn9rfekg7s5F7kmrFn24rcMZSH2QKe3?=
 =?iso-8859-1?Q?ZaSgsRfF01c5rzuB0ktZ3vN4SS1qfZbJ8h6gBTS/EJWTnE1ioWkUXxnQQX?=
 =?iso-8859-1?Q?8JzzGbccIIg/dg0KqmYtCk995+SaYu89hUUS1TPgqd1rktliwtZVPaXg7r?=
 =?iso-8859-1?Q?6LpRcZ62KeiM93ECoH2IL+IRt/apFBkEXAwJvPLEEQx5uvM8/zl803s+yC?=
 =?iso-8859-1?Q?gK8LcFPQttBfhJXWimkwpnkb43bfQ+7Vz2k4CxacRsgAlyLHMsvkvyLlxN?=
 =?iso-8859-1?Q?QBaqRDp6OUg7eeBZ+pLTf2OCnuXFtiA8gl4QHYX88KmBIYXux2SszDItVX?=
 =?iso-8859-1?Q?fEQYbNHmP802AEs4HY5nH4aKnKv0rW/av+VPyxG6qW+DoJ1snsyvUvQ/0D?=
 =?iso-8859-1?Q?F7X6NF/yMvvqf6jygvFLar9ZgqvTWAfLKTfxQPJ9Nv6BpbhYL2OvGsZIQD?=
 =?iso-8859-1?Q?3byNz09FcNXkIHt+KhF+VReQmXEC5OH3O9yFwX0g2PmNIRgDtsk4c9UkhL?=
 =?iso-8859-1?Q?2BL1ojnaDYl7ZJdUZdt9ZfV480ziqopnF/K72hjPTNjGkVwk2G/B/tTtqV?=
 =?iso-8859-1?Q?glfvVu4sK+J0Q7fV5tUIE6YF68dkj7uuCaYQWRyijrGoDt/CDuKWEFEOAh?=
 =?iso-8859-1?Q?QBttaZvQMUGTRKAPUhTWgJcCOAiQ92iPKXBmG6VbKdiG5DI3zdyjp3puDN?=
 =?iso-8859-1?Q?e9D80ttHYL7iyw2+7urpqmSQevotjhKUEQthhwjmXbRkCXk6hZL3FOSWPY?=
 =?iso-8859-1?Q?hixINPu13t3lziRf9sBoycGU6ZZIaOPPKRhWio9gOgKlHZAgjEUSUE1D0s?=
 =?iso-8859-1?Q?du+2O4Blzg3rSlIQm+Iik1oIJFXfZJwS/C/kEgC+2XWTLl/SjC4m8MpzkH?=
 =?iso-8859-1?Q?tUvTjDAbp4zrPktab6307th+WWyQBRaHg1nTrN7owfD5OlC+wKN8JzF0DH?=
 =?iso-8859-1?Q?ljsnaqv4Yr1SrkYSE0I25X5h3DtZgwbmvvbVCVQKtqDqnrPFstOT+04HPv?=
 =?iso-8859-1?Q?iemW7JK0GlnyPR4SEcg/uixvpozzlbBTDg+tNaFLFOFcyD8zpyWuYu847z?=
 =?iso-8859-1?Q?57h78FXqoOUy3dYXpNV2y13infCkNSMWipJefRrTEbFVGca4NggXqWTu6I?=
 =?iso-8859-1?Q?pRqcDDCGHS0Rw0a7T96QtueQ2F+FyuGlKJjIZFxmfKBk2dAdPrQ7M2C7wI?=
 =?iso-8859-1?Q?KMwiYh55/W1F/6N16IFd5Mtvk4X6WNI9EILMJxt3HawK9NMsREVF+nySYr?=
 =?iso-8859-1?Q?at9n30Ar+qnqYCJ4xCkKFI8didWUEoj/YP3SrZrWCLxqCTrFKwjKvkkDad?=
 =?iso-8859-1?Q?QHzUHZW1yIjYX14KVtPBZRnt7tOIJy/D6NDyhAui6cdCkVazkMZ4YBDrrk?=
 =?iso-8859-1?Q?EhjICUBJy58xQOD5N0ZIYG4wxklhjZIVxmnl8W9mbb3GYy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa8841-e3b9-460e-48d3-08de672b2ada
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:00:23.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCwfltD/ls9jVHSM4P4P6wEJKyirGkd0+ahsep8iH0M8Qyf+eGG/fWT8tJkK8opfZuwVF692UFDrkcZBRXSKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.971];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D3B30109575
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:07AM +0100, Linus Lüssing wrote:
> Export the new ip{4,6}_active variables to netlink, to be able to
> check from userspace that they are updated as intended.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

