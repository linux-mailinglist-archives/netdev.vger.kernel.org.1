Return-Path: <netdev+bounces-294686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VYZRIlXqH2pssQAAu9opvQ
	(envelope-from <netdev+bounces-294686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:48:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56FC635DA4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:48:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=GOjzXIGi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294686-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294686-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CB3301CA5A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B969F409E16;
	Wed,  3 Jun 2026 08:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC340913C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 08:47:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476436; cv=fail; b=tXPZddt7vY/Dj9h6LPW77jAnYB2a/lRyTU9V1s29n4oc7G5yKIxnUmDLVRqcQyJ6ZOpLiFH0dzjGSwVmMRXulnRQtPXRQqFQNINwK1L8mfBpz/xTjAfASMQ0fvfq2eP8Rv3BDgmUxLMPY+e531dxeu+34efePhGjC8l2IXJ/Rz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476436; c=relaxed/simple;
	bh=OLxrtbPOqm8iKmal6RMGQlAt9Ux8XRHR0CwswTpYUTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJdeXWn2gT4yyKLEHEBAwxfihvA5PbekCbcKH6xNSOj3DEN5egDScJOZ0zdw3oR2BjeO+UyLNd2tBA3+9uM2zMM/T4aSp4SLhakYwLg7429wjOuPH14JBhW3HQJNXKob4tZjmSXVHMUW5sFG49PMuK+bKhXf0QtMTx0MkmPD3jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GOjzXIGi; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJGEWykjSvzgdhL0HvF41Mbi3vWIErxWWVnQbycRJuSDES5X9rMZPkX23tua7e57REoxKQUe6TAcY6vEkW7sCE7VWhGCkNDJTFvgxHWm3DATzkT5VLC2Z9nStLi07fELxdnqA7p0+QxzDgp6f8CT8lznZKwIw2Gegt7J54hm4l0gpqK8YTbfVFUCAwYGdYHfa4fzyoC/nF8257atabwMNrovCHJx5O1PdzrsWbR7X4xsrrWMzC5SFKINSQl58VJrinlU8D7uA0pBB0yRciVdsk1TydO4APZqkAHEBSNx8PyHgNMmZTPE9CjaDhEVLu4GF25jcXHg/jQDhBAAiM/gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MZ0n0K9oheJFYH6MXi37Uz+DV2NkeD9S7ZdEj1MVOE=;
 b=BUOK6sSMp/AhugiISAmtNw9Jwa+qU+uVbPQ/YNNh8P3eNcRzmIEA4szEb6T2hv0gQ1F2RghwSEmQAh8QC5G0EXOq595mqIScVLaxHOTw1F2yTRB5bSpG2/8FAkFVtRGDIycMDwtnNaILEGZ2okuMWeEVYg8OcSVSYuTnJTh6KqNhhxV6Ji8VJG5ETj7asoj8JKzQP3v/FJQTrq0ZwvZd+QBomfeoHwNhPB9BAoskxfi+L0u4qj5+EBQDhGWWDOaTwtG8Dc8G06/Lsz32bQJ1FvISzKYZJYxLJZNU+FtMHIs/r7TWpkpOtHBGo0Nk60Z1tfrOBrWw4OdKv4QA4vXltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MZ0n0K9oheJFYH6MXi37Uz+DV2NkeD9S7ZdEj1MVOE=;
 b=GOjzXIGiM0NjXKy7GKFPgsoFbZZQSTC2gQtkFuirnHTMu8ADfq7sRw6w++cVZPLenOp/vJ1ooXnSlDyHwN9R7nnQJSP/CzNchmWXFocRblzRqh+YpE6S5TRey2/n8NRJzXgXRvSMiUf7YsU3f/td0VgoZoGnfVqnywkKHvwYlVX/Rb3OuJGRfMX7UTkko/ud0t6TGcVvTe5x/XWyLwT6ewB5ZidUD2p2wvH3ZJ1/ErTw6rZpfwT14oY/eQG8k2tUUdQr6CProJxUNuJvT55EF+JvvbHS8JGkZOag3BVypyfXqjjsOssqQdAZ4FQwRs4qZ0hVa1P9zJbRx2Bi69/wAg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DSVPR12MB999149.namprd12.prod.outlook.com (2603:10b6:8:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:47:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:47:04 +0000
Date: Wed, 3 Jun 2026 11:46:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next] ipv6: exthdrs: recompute network header pointer
 once
Message-ID: <20260603084656.GA587321@shredder>
References: <20260602213033.12244-1-justin.iurman@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602213033.12244-1-justin.iurman@gmail.com>
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DSVPR12MB999149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1413578f-1ccf-4656-9e5d-08dec14cafca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	N7xzTcH4McNVfgN+zOQES/nDITDYKL0UlQjPvkw5MrCPpH2QCbzQn72S0zfMN/oqUWWtIc5aWbCcsrIqZvAKY+ISCywXTyUMewjEXiTN/XkCm/Cz3m6SE9EtsQeRiFBZ+HGCRU9tGGWVIcEUgBfU03XFO1fFyPocPLyYwMwByXTSbStGeV1Cze9/iqAgeMUeRUHfTEzXNPhz2WoTfi+lAkFRgBeDrq27MIlvVD/0MKiaInIfMby+cP7A7SgL7gEx13/SBdER23TMQlXupyxfEzmVYSnSVdVVBUpYZTkV+aPT9kCAVeEXYiGkVpRzVrILwkJO2B1vgmTZigicx/F9iaHBc/lJM7Uu8obqOkW2tJciYQVHQop4FxyFSka2ciFsYyu0e3VLDrUALmaHMsyCRQtzRUvG0HlyrkfRPYE86AS5aP6GmANtrF2t9RYQt7PH09KEP5XIocpXjpZ1v/Rkd7bUT4qQNsqVPyn1uf2yuobChN8/jeEJg0JVojYplUYquMTMThg1PO1HVLCprdj3GDa5gWcnPOUinjSGNU3KBt4ekP37HLkbtUDDoSpnYaJc88nUfopX09RQZuQX0scWvaZuJuOYAxegT8bjPXoi9sqsGgDcsM8XpfMA80w8nbe7rrJA6+UpTC5d+mJ/TVZTZKo17AiBqndCVd8dA+yHYfE8+dt5sytENZ52+GzP2wLE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zb+5fAH8D4Hh1uxsjILKvWhgHpOo5Em7NU1nyFYcua4fEBdjE5GEGSt5vj+R?=
 =?us-ascii?Q?/Stuq/2IIjdowGCieZf+h76nUJ9hVwUnRSFJXCAOXCHfInUtmXUjU5Pidcrl?=
 =?us-ascii?Q?QUyLMMfvGWwA8PNR1F0kKe6JKCJ96xULbTpucX0DyBPD7Hdk6jBR7mOLT4kr?=
 =?us-ascii?Q?c2y/Fz5RaLMK5FUrywy8JJRl2EtAieH5KaeWwqnPsC0D5bsMLhEpDHpip7Yk?=
 =?us-ascii?Q?/1y8srawrkJvZpnuSuQyLgAtMbD8aSE+qsvsS0Clp5P7iKWa5yJWcKtW9flS?=
 =?us-ascii?Q?w0AOvvhy0kEp1fu9TSucMTdgeQvDHGbQ4IspSOBqYrFcISvf0vserowPhXeU?=
 =?us-ascii?Q?/V2+WiqLyXjWPrMsPMtGSgNeuRCxfrm9EMSprfJwvmZizy9yvIzZM93Y7Nhz?=
 =?us-ascii?Q?aFyNlz8x+bCL96blSP8dQ6vXSDq15dcGzVmwX7HYFc8fCgyrEUthSjfsK9ut?=
 =?us-ascii?Q?MC6Z62CTsvRURTi52Bc9UPqae98mqNZSqibTnZBxCDcRbLdHh2h3RFXnH+CD?=
 =?us-ascii?Q?YCvAQDLRzH+jcnQtZL0i0nvlKHM7BrymqkFcMGAGmVsOMbxN68eIk6fjcULm?=
 =?us-ascii?Q?s9Obfm/JWq63aD3qCimgRj8/Vnynjn9ZWNP9YfMFpAcU7aJPopdcZUgmKMAn?=
 =?us-ascii?Q?AGTupxlB/Bp6Vs86cpeD/Dv1PG8+uaIwMsZfVyLqIZshQnk8i7gOq5PAOrQq?=
 =?us-ascii?Q?Dyjzj1+DuGgx4Zn9gyDLwKZJLF3Qk8DjAdRfq4b4aC2pIPMmaEzHOsWeQKID?=
 =?us-ascii?Q?VKIPa7oyCwRH1DHt2THqdlwUjxd4EH0V3Nz98z3E4e69BkUIi84XvrJduTza?=
 =?us-ascii?Q?g20qPSq3137ItJtJMgL7TeTxzGsIWQ0fXsNi5uIUtKl76OkPBaUvmwqFeNlT?=
 =?us-ascii?Q?0kVYGaDsNm5D+tlpH31KRPqIAc//sksZKEuKZYMTBCu8pppS+D18R5kkfHG/?=
 =?us-ascii?Q?LJ7o+knw9t8W3EA6tI4x6CvpA8UNvPzG0Qz3Nt4okcEhjholkjXHcSqTWKaA?=
 =?us-ascii?Q?PY3Pq8vY+f2Rrr5eMPV4vgnmwLwmS3d/tXWR6xyXYmgYxDcGC+H+cNw8UO1O?=
 =?us-ascii?Q?BPyPOX5OR5Hh828YzFHqY9ce3tq9H/2lQZjcNKfBA5P6mzEZ4caSM2Hd8Zg8?=
 =?us-ascii?Q?LLkb4VTxIRplhAETEqdHeaRNqoq/EYFdKoA2nfqFSt8ENozH+8rvTc9DGndN?=
 =?us-ascii?Q?sU+251sxRKeubUhA5AdX/iJMTDRbueLMOG8rnH8SgRgw41NThz+YEZqV4R41?=
 =?us-ascii?Q?gzoH/vO1SfyjUeK5AVYciZkgg0fEX8WoplgmvGZE7XqbqsJD1imvtNsG5zLU?=
 =?us-ascii?Q?TAoYzS75c3Pv/YMDwxKdQ6qbj/OF+TjFOFq6y6XXKjx/OeAHPa1Myua27qzf?=
 =?us-ascii?Q?tTFWbivwM4mZd6fuSaOwGU98cztHpAO//raJA+mdxYTHEduVnDvMQaL/eS09?=
 =?us-ascii?Q?fjCBM94r/gN1CV1A5mYS8CNm2wrqg3dvodAWHuC6VUXvQhisrOWxi4G82km6?=
 =?us-ascii?Q?pJk1raCyJYINJFMNAw/oxEA3zfwejCbtHra1P9h1C6KyCiJrGIhAgrFeZWQc?=
 =?us-ascii?Q?u52PSUc8YNsnwhsqmdMKgDeMM2PgK/AhIg8iq1BGRvwURcUFEyS4AwacyE+g?=
 =?us-ascii?Q?aMPLzThW1w1YCsCyJ/K04szcUHbHWh7gy8bYbH5yI15N6KOp8s/PgXwTzeHL?=
 =?us-ascii?Q?8tCf7o+RSIDln3kWfIWGKqvdYkRNWtlLySlhzFFOoa5mOlpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1413578f-1ccf-4656-9e5d-08dec14cafca
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:47:04.5105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQtDv6voKGNQjlzLlVq74I7cspTMLBMXlU5pcoiufew0CZpm2ROqPYoR4lhw8E9mzvq1HKxgyUoc397ev4Kyzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294686-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:justin.iurman@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D56FC635DA4

On Tue, Jun 02, 2026 at 11:30:33PM +0200, Justin Iurman wrote:
> In ip6_parse_tlv(), recompute the network header pointer once regardless
> of the option processed (Hbh or Dest), as missing recomputation for
> specific options has caused issues in the past.
> 
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

