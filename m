Return-Path: <netdev+bounces-295386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3HxeO2jGIWpLNQEAu9opvQ
	(envelope-from <netdev+bounces-295386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E36429D3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 20:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qRV7r2vy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295386-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295386-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2096E3012E59
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A03093B8;
	Thu,  4 Jun 2026 18:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9A3502A6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:39:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598372; cv=fail; b=TyEuMiMAljYX09iZczzPRqd9/dcF9xS3O6F02fKD6sCDkLCYZtXqWCR8Wh/Hvan/QBeJGCdKHKijGWttfSvLwOp55tq+PAeX3ICUyZ70cdSpUt3MalI/51CQe+FuY8DlU2bMT0f+Gw3/pkrCMavNsYj8ZxvwPRorIAVBKNYvbRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598372; c=relaxed/simple;
	bh=8auyhZTyn+I8528vPJFGWVVwZhh7gW5aEwd/mJY1DdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvDdst1DO9r+F0tfX4Uwm9lcoTNrkL+6U66dAgkz18CtNXIEPfz9ttFMRg0JjELBbPmNoKRD2RZg1NGIlFyRAMkMopBca3GeAy/2FYIrZcUamDA4t8iouhv4LwURySYQcBiq6f2M8UoPyVLSAbAQpuNgesWqtPs4YGix1KfqASM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRV7r2vy; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHvhuzCh9RQ5sLmHebqnYZedvs/P2FUXqsiPSGiNXgvFUTLBsFhnnT2t009B6SqljSGr9xgrE4fUJEc8fYDmhteVTYecnry9ouQiWndEUKxgJlGxI/ugzGKJpJX3to2xXBHyRhZBk9ACU3tQipa+Q3vjMtWjuTi2dI13vWDsqgxaJzlxcKkPQb7DLz7gl96ypsVFuwEFCwVskx8O6NWLX2Fmn+vZvUfjvZj2QSvyI/vEJr/u9tr/0OISwhWw+YsW/QbyDrKEhDFW5wGUx0mldwSMuNbVqeTtQxiUfqI36+MCH0h4oyMdzKQb234m+vETBvJecpPegfVuLkDeteNxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NxyZ6oXnr077W40FTua6OroSvt4PMjwANvEssyZ/48=;
 b=vox/wtMQ7QwqL5ucLESTiYlxc9Wsb3vlV+Cy9A9RwXuSLOgI/2Xig8Bpiflp3Z0vL2cgO2f47vSxlz+83hrdbbAVTvmTbwDcF6N9jCvC9TkhSy2PEgSz2zHveagPuetlyHEJ5tRZA6eUrlsMcVvTjFAM2wOrIjM82CHzUwPdXxHrQYAYSVrNYClSIkb3Xgb1Eu3qxPLx5mzkMx1ncNGfLnVC8aE6pnuZMH2ao6o1fUIshg/rjB40ESnqKsnrDe66ZKys/5VcxJ5qg4N9T5Pftioc3Rf4AIdiYNBJgr7iZQZI2wAYVAazF1F/zBC7ExcmulMQBh1gy4569Qo7ZoqTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NxyZ6oXnr077W40FTua6OroSvt4PMjwANvEssyZ/48=;
 b=qRV7r2vycGtyFmyGfPHEgY7bPWD6PSI4PpAYB0kSTGQXf6YVJj0tUakgH44RTJr0Z92lxQiCfBNaH3gHxV+1VxuUEXGw7T7eMHADVa3+Lt7PSGqjC2Rp6rxMYFyXJRRtCPyLpU+ePusd/5YAjRiuFv6W47AkaprCgvl+Ifr4ByY7I/nkY1y7WyR1VOHC4DLsNKytm624qyh4Gioe5kmoEidfrlXWagrwTIPxgFZz/Vjj20jimaS43p/yGZ6pTyg8T7Vae2EQ1XSH31URLCIql6DVjFGENQgugi+Y0AINB0KDtBAKoQaIk9p3KcNFiS2adYCuJ+Zvp3Sncro5Rh5Nnw==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:39:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:39:21 +0000
Date: Thu, 4 Jun 2026 21:39:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org, yuhuang@redhat.com, justin.iurman@gmail.com,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	Chris Adams <linux@cmadams.net>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Andrew Lunn <andrew@lunn.ch>, ihuguet@redhat.com,
	regressions@lists.linux.dev
Subject: Re: IPv6 address insertion order (was Re: [PATCH net v2] Revert
 "ipv6: preserve insertion order for same-scope addresses")
Message-ID: <20260604183909.GA877115@shredder>
References: <20260529112357.5079-1-fmancera@suse.de>
 <20260529134045.56330243@elisabeth>
 <ah57wxGjL7JBORR1@zatzit>
 <20260602132118.GA508395@shredder>
 <ah-SvHdPRrYXX6lx@zatzit>
 <20260603074717.GA569921@shredder>
 <20260603174538.5454bb93@elisabeth>
 <aiDUMHKi2Sn1_dYD@zatzit>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiDUMHKi2Sn1_dYD@zatzit>
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d877ce-cd1a-4000-f6b3-08dec268978e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|6133799003|22082099003|56012099006|5023799004|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lTzdPeIsxCV9HKJVU3lsynhq0RkZPliDetdxGDHEOiOMoOT0kmMZJTdxp/FHsPjDav8yBkcLIOBIpHGCyom4rJlYk4XcP2Z/CG06MFvbQjyz9tLCrVMR9EKIZ4wpGldhFTuMjWjQidGXzdTSJiLaadQsgxm/IYBjFnwl84bdUb1P6KtVk/UV23UsxzGo+X2kjA5LEBV6wMkSYdKHob1uD9F1xEfa/IBx6HpRzCuhZvr2UJO3uen/ezCHEqUUudj3hf3GNsrfj6bAdOZPoVstPEQ6qGGOAIoAhJDl0LE1/mA4AcwTHFMypO303EISjgZ5NNzzDQ8cuJeKsSArkV2KUkHrAVK+hw4FpEYwAYw7wYzbvmnp/kv8BJUxD810/tEhQo2MlC3EIezbvyjVvSymF1h8nP0lKOEs4/nITnfTDKqK3Vjnta5tD5DR5h6/9SHzu6K5+6byZnkyJSWynlvYJMCg9DggMq8ovBxR8M4oX1kvjiuzAJj+CQ0hbjd05fDk45MLkPCsexUwk6qNWILyuKT4SBFD3leOFYDTgJtNKqNVH7PBzgNeeCajUaZ8ton6+2gIB65vlAVyW9gyerVTXExLGMNWOtvVHn0Uiuh4+zwLakQDaDsPdA6pgPFAAtgWl1X4bldy0AWd+BhNZYX5EuBw3CDqi5N0KzZ6gtzgCG3vFxeTgOra5Sd4xhnpFXBx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDYSa31tyrR+hSeb+vK8h1uJz/TxlgWyPklE3Pr9EFDdCYpWs5wNT+VBgDtH?=
 =?us-ascii?Q?LBasmPEJSjVqbPA4iLkhSN8JxE6U7Ewg6XWbD50/Jb8WXQdBpQ/85PS01vRJ?=
 =?us-ascii?Q?zwp5TwW6qDhmQh1yGn1GyekrzrkkbW8/g/xMduMnZ/l493UVuZhG1oZq/OK5?=
 =?us-ascii?Q?9hfIExphHX71R5Allq07kkMZt0N+DoW7mN4F+Pf/9jmDJZE+7cjFXFFUmsHO?=
 =?us-ascii?Q?NNMuFzRVzrNqVdag/z3k7Bq7ARxe9fvuBM6XKItIME3xnizXU2Udxq1j9PAm?=
 =?us-ascii?Q?nul9DM0IiRdhMf8018U3bbzhg9Hu7wbwixA5MwF175ANRM+dnLi7WJqFECDv?=
 =?us-ascii?Q?rlM4QhHVXpEGz2AeJCEv15ZHcD2oNcMVupDzxSMSI7+sauABtS5CWcXyKh0B?=
 =?us-ascii?Q?CZQKcmCBAWvwAMO8QLiqY/u7QpaD5QrqhOJUgQ6kg72TOTcAf2Wx55lFnxSn?=
 =?us-ascii?Q?cSasXtk1HCLMPbuVPnlOUjyLMzwlAAxdlQ9xIamzJ7U9Hl0Zt76v8H88Irai?=
 =?us-ascii?Q?gDBKR3MLMDGpk3bc8Y8odaBenb2gu4yW1Cztjow0E3AN6ba0uJ2TqiBCK3FP?=
 =?us-ascii?Q?+WaB8Qq0EMCf6tVIadq+//IrFLdkD1YzqtFf0XOoT0v1GTrUNjNC+XVWQTUS?=
 =?us-ascii?Q?EolFOBeE1OjEYdOMcRIsgD0Ap2NP6Qx/mGEiRdXQhvlRBkryrwMmPrLMEWcG?=
 =?us-ascii?Q?+Y3VfmBeE4zYt2qJlgCnuYDw1+vjxJJnx49QmZ1QWq0b7KDFo2RulcTOFX9D?=
 =?us-ascii?Q?opVa7hzdn9O+fHGtTgFNAEglmnAz6+0u86zs+GJIIbNYcygpo0bybPOHKc0b?=
 =?us-ascii?Q?8BHAaKb+ByOyz6mx0XuGCXJjyw1pqXWqkkl8g3mGHKHCimLkUQgTXtvb5luD?=
 =?us-ascii?Q?sBtKMBFwOwjhWZlUAGBaDRbWFzQCbjrTrmLDqhgaLJSLcOT2yg9wX9zsz88P?=
 =?us-ascii?Q?au1k5+18886uyx8/1XOxeq68HYgWtXbMvuXUNRa36oOxaicn5xjDf1wXgQK9?=
 =?us-ascii?Q?l3SNSOaHXWQ1jqktgLuLVa6Hc5Dn/rOjvn+S0VjyQU9R+WkX6I5ocAIiYnK0?=
 =?us-ascii?Q?5exq9yK8v4jHPo8Y25oZ25OQobYR+7e8K8VYXPGnx5b9O9GmNxyknen6koaW?=
 =?us-ascii?Q?oc9Y1n6bGaMC37Gx5hSdVJpL0OIT4EMJ2uLxQCTK7ImTQL9OeYnRbFjTBVSr?=
 =?us-ascii?Q?rWRuheomR6Yt6vvIi4Wyrw/bmkJbVtcN6P7Bvazhw7MJ5Ds3b01MuTfIRmYG?=
 =?us-ascii?Q?rxdvYu1RKDfLkXv5hwKasSxKzvhNxgqEIF0GW90FyvPo+rc0wNU9jhVniQCO?=
 =?us-ascii?Q?HYOPV8lT4xUb3wqepibl3JbhTuhYmtHay8c5zoDs3o9qbFOZWmL/2jbHeXrg?=
 =?us-ascii?Q?/tx69JFRO+n968fGrbcI1vzZ1EkkduJSoKC5+TPNK5jTLR5Sff3GvXJEy2T4?=
 =?us-ascii?Q?Kxdb6phs0v7glstWNmTXLDdrVmu3meKznwO5lYkysX4PYhF5oVZvDha5Z99E?=
 =?us-ascii?Q?Q919/PdljxwY+eyJyuYv1C/n3TbOZR8MxybL5Kbj/QXNdL0mBJBDbJgFf886?=
 =?us-ascii?Q?BU7Deee8U8sWDk7WCOmC+CHIzxLyatoTXs6VadwWIPVNYoQJyoU0Sy4xF2MH?=
 =?us-ascii?Q?9iEvpg8x+nRgh4hIowK1OqaB5cN/dYvzEkWAs5G9IlZGgAhKpOtmAoZnpOOF?=
 =?us-ascii?Q?ffNIovWxg1R2/uFMxnyOwEQ/9yfAGKO2Ryez0SEtiA5FU5jXQWUHkgWM/GyG?=
 =?us-ascii?Q?7nlRuXFvug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d877ce-cd1a-4000-f6b3-08dec268978e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:39:20.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAj2ttu8/z4SODsNLu9+c1XP4+f1hpjjJnmjmKKExTQcStrNZroF1N1Ln3vWgkw6yj4zLGY+a1dzHQKcgXSxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295386-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@gibson.dropbear.id.au,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:linux@cmadams.net,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:ihuguet@redhat.com,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,cmadams.net,leemhuis.info,lunn.ch,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC7E36429D3

On Thu, Jun 04, 2026 at 11:26:08AM +1000, David Gibson wrote:
> So, I second Stefano's arguments for the most part, as well as
> re-iterating that being broken by this change would require the
> intersection of two unlikely conditions (misusing NLM_F_APPEND *and*
> expecting the "wrong" order).
> 
> That said, Ido, if you're still not convinced I can do this as an
> attribute.  It's more hassle, but I can make it work.

I appreciate the survey that Stefano and you conducted, but there is
still a non-zero chance of causing regressions by suddenly giving
NLM_F_APPEND a meaning in RTM_NEWADDR. We already tried the
"change-and-see-what-happens" methodology once with this feature and it
backfired, so it's going to be quite painful if we miss again.

As I see it, we have three options:

1. Use NLM_F_APPEND. Relatively easy change in both the kernel and user
space, but at the risk of reintroducing regressions.

2. Add a new attribute (e.g., IFA_INSERT_MODE with DEFAULT/APPEND
options). Less risky than #1, at the cost of a bit more code in both the
kernel and user space.

3. Do nothing. As I understand it, any production software (as opposed
to a test script) that cares about the in-scope order will have to
maintain a fallback anyway (e.g., iterating over IPv6 addresses in
reverse). Therefore, the changes in #1 and #2 are not strictly
necessary, yet they are uAPI that the kernel will have to maintain
forever.

Given the above, my preference would be #3 -> #2 -> #1. The first two
options expose the same capability to user space, so #1 doesn't buy us
anything over #2, except a bit less code, but we risk introducing a
regression.

Between #2 and #3, production software can't drop the fallback even if
we implement #2, yet #2 requires us to maintain uAPI forever. I think we
should accept that the divergence between IPv4 and IPv6 is not ideal,
but at least it's predictable and dependable (Fernando is working on a
ksft and documentation).

That being said, you can send an RFC for #1 and see what others think
since at this point it's unclear who is still following the thread.

Thanks

