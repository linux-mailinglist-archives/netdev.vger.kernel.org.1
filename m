Return-Path: <netdev+bounces-304799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q99THI2KSmobEgEAu9opvQ
	(envelope-from <netdev+bounces-304799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA32570A9CB
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PygpOjGV;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304799-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B10B3007E04
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CC286891;
	Sun,  5 Jul 2026 16:47:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72527603A;
	Sun,  5 Jul 2026 16:47:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270026; cv=fail; b=Qk4eFf2vm1RatyUPezjql4BziDD/EaNyCRkC5GQFSh+GtNKhPzWUUmNI6FrAyEqf+8EDdYFYqf5cSnEsD9Kc5WW3PeGTmZbRWvIkgp6zLGJoz6BYHk4+jdNpB23XUO62UPimxYFSQLReQ490lOBDt2Oz2HJoGQvFWXjB8vkkPA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270026; c=relaxed/simple;
	bh=WJTD0tJ0ciIrVwR/p9+jqPL8Tumi//875XjvHsDCVB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qRHh1l9u4tKuHY2CvYL3CaqyzSVoUDG0vO3XFqqurENspJRm8qk5RoXdreKwj+4lRHpi4/BPwNZN/4ZB+1AhnopbK5+A3mvk8vmFmlQMn9XDsQpGP6V9Oi7WLb99APLx41BlBVhy8mRUfERpqW3JKZBHM5qGbyj0vpn6YRPCur8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PygpOjGV; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaQEpH20NlrJh/nedDVRc3v7aXPiY9RHgGiTCCHfRiy70byjqpZYQYEnHRXKZ2UzEGhXREBWmkStrdJ1V7X5Gh1TWLzm3DBgXx0XLq6GXIcQpnW+h79MJtg8TUf/wMtMYpU2EFf4uTcFd+Gr9GZHIf5MGA5Is6lntpbr/5IPYW9fCHC0u+0brjPga8e9aTMftd9rRho7Cm9G3YwhJc78BVIM/jwUYVd/lcdFZ3KJsYU2H7QZnX//V84r9CSqncv9rI+ab/WOj3X6XapkeGi9HMnpBbxzT+vFH0eiXwk+YNJKw0ZGTvf8acJdhYgp0Mcb+p4A9KeOToGV/xo0A+oZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnFYm+cW7FGkLc64SN3hL0FnaW6Y8RGJtbp2bx/C1NY=;
 b=RgXWhVaXbAWaq71dsn+6yVN/HF8A8ARTkS0bYliv91hJglyk/BHZJbZwknn1w8afcJuZ0yKcYP7eV9AviHnBZ6j5Vpdmnfu+3ipyDVwT4sBqOzidzTjaodBrZRYjfyyNg7btlCxdDwUWerf9wiBSuPfvOlr+sJA8TxJ8nnNPtw0n77/GLtRDdPJsCmQbRT3Tc8l9ueBX8L1QKfXIDzR8fuhz1uJ3CH+JdSGgc87+efoI7lnvwTA7kBYRH4CF58/67fPzXV86oXf2H0MunoWN4JxDblEWOpG8u+TCKTDeKNb4Bnbqu8+LnnqMjrzsn5jmF9tCwLkJ0Dm3XyQjF06vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnFYm+cW7FGkLc64SN3hL0FnaW6Y8RGJtbp2bx/C1NY=;
 b=PygpOjGVxP5TyLCPC7ji/6JNC/JsjGWIGuWL2DgANDZbsy2UAlayMnCboYc6ll0BgLkfV+AG0tT7QIskYHdbxc00f4qOd8JyXIYnUh60NfQmA5zsgZr8wKMqiIdC2ghOdTJxQmNvX1Mn8TiQfda7F3YgRlbeOJQvV1VzM4aAFy0SiUGxIr1mAfbwTlKrOiB3I6YG2CO0stwIiNFqB+39lIT1eBwNtq8A9D1wpmtsWAQZSx1j5ItfVLrpZz+qJYtQw9HP5SmhHuATl2IXOc6RtzV+kfK8ORkRU4qswxcK3vdziQOwiLHdhRkFII9ZMcTCeA9Qx9W2hrPmRCTP9NiLmg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 16:46:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 16:46:59 +0000
Date: Sun, 5 Jul 2026 19:46:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: xuanqiang.luo@linux.dev
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev
 under RCU
Message-ID: <20260705164649.GA295849@shredder>
References: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: edbcad95-95e3-41ce-b617-08dedab507c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pVpSfKJl8gT8Rb1bIeGJZ687X5/+3aUp6NkNBqALQIOgRajK/4rD2XdRF8MeI9pwYXbo+D8X6FwqI4ScCjwAeoVZdY4z90siOeIN9RxdeIJEkd5yT56vUyAfQ7obJ4XsmTkIhfrbDk13Y7BCPDNsY0vcQVjrpE8+AGSlNw/QpV9e4Nl4sBdK/KQBeXI0kaAQBpy8ombRIgmRrxx4ty1uACkOPIhnV33FyeU39tDIUrgUm4ry5mukwcFeWhp+EKD/phhUrb5BS1f9VDlcMwFdMykpmMOAdNE32Kowce421LF7w5982osrB4prKFYyv4+BmYvqJU7IsZNXHa2Rg1g+Jugp7B7HclcGygtJheB8xeelHeNFYmuSH3VynVgkg2FoMzyfjtqGDUjavqfiu8yRfE6Bl49VakPe4EXoJsC/0fnRUOiEBBbmAYZ8rxBF1SbYQ0VT9sp0omNTl0EHt+mPCmxmwiMDe/QyBDj1upTesj8ZxQtQhhueH8E5G7AyoY8UBpRFytDc2FV6LjYWCxMAKJ6KQPh5tj5gwzKeSBiJsEtl71EsO33TCPNujD++TpBRJxrR9G7Mnlei3z0H93fCqQ2NWqQ34ATzrA3OGQFtUokJI+N2Ekk01DEPPc82/pO1lKfXK8WZddM3PHuLK0BLxGvoZYckulI/6TQA6rxTCG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTlTc2UxU0JUTnpVcFZUSlJMMjZFSmd2aVBFbHZQNEt4ejNCZFBWNTdBaHI1?=
 =?utf-8?B?dUd2R1hzOUFVRHhTcGZhd2p0ei8xWTZ1UCtzcXJFQjV1aWw5NHVJOHl5aUo5?=
 =?utf-8?B?d0ErTFNEWXBqWnNQRlV0QlgyL1BrMy8yNlY3ZklLanh1b2ZWMlRYSEdoU29a?=
 =?utf-8?B?QXk2NEY1WjgvSytMQ0xvUU1XZWppK256SmRqamR4VlFySCtJdzQvS3JoNGc4?=
 =?utf-8?B?VlZvN2dWYy9vT1orMUtGYU80bzNkVlFScndSajBxclR5K0ZHa3d0M1FaZ2s4?=
 =?utf-8?B?cmNaYzZMRW1OcndLbTdwT3pLSFR6bnFQWnFUd3lEdVJMNXQxczk1cCsxb1R1?=
 =?utf-8?B?WG4vSGNlWlEyVC9PVU9kajRqbFpBOXNEUmRKTmdPTWN1aGtuQWNwT05OSm5p?=
 =?utf-8?B?NmIzV0h2SDJtQ0hRZW1XTThZc2FXdmV6YS9LNGJsNFZ0VzdqZ1NRUzZDVXBq?=
 =?utf-8?B?MzJEMFJhZ2NNWGdHdGRvdmdqNXUvNVBBVTUrWG1GNHBIQ0k4UEVlSGFvYS8w?=
 =?utf-8?B?OER2V2s1VnQ4bThkNkhvOTA1U0gwOC80cThPU1RUVDlDbDFqdWhrODBlSHFv?=
 =?utf-8?B?YzY0L1NSems0SGVBakdsTHdNZlFEbERPZVlPd3dSNjAwdXpta2xydmhlbzh1?=
 =?utf-8?B?NWxwSWxENWFJVWluZThrbjBsM29yaUR0MC9PYy83TWg3NkxvM2JuTWthdzV5?=
 =?utf-8?B?U3R0cFVqYlFGa2NFdGluQ0MwcE1WalVBckliVWdLWVpXWFRqOU1MNXM3aHg1?=
 =?utf-8?B?d1JDV2FaQ1JQRFZoK2E0Tm1jZU1XN2o1c3BXWTZoMlZidUN6T1Z1dUFwM2ox?=
 =?utf-8?B?Rk5CV1pZRHJ0QWVqUThMclducXRCZ1VEdFJXRm1xSk1lKzhFYm1vNFBjbXd6?=
 =?utf-8?B?alpKcTZiRkN6cFkwbEtaUVcxd3JKZDRMYVd5Q25nS1hZR3kvNm1ObEJqL3Zm?=
 =?utf-8?B?cCtyZlZIbHpwTnhWekFNZzltT2JCWi8zWStkTUdPQW1odGsyQko1b1lTWFc4?=
 =?utf-8?B?d0VjOXY1cmdXT3g5d0Y4Z04wVGUxdDNVR3E0ZE1EK3k2OFRic1dZczBCTnZK?=
 =?utf-8?B?ajdvMnVUMzBSbGVVbkdOMzdzL2wrRkJOYUthdDFUR01mMHNNMStHS2psTElN?=
 =?utf-8?B?NGwwelRJcUNmK3lQVXdxcDdWc1gvakI1WEdJbjVRbGVMUkVwTFMrU0lPbytV?=
 =?utf-8?B?TFhndkpYYU4zRHhsSnEydStyZTN4SHdFelJabkJ3eVdUNHlheHVORnRwbDUx?=
 =?utf-8?B?U3J1K1BUcUlZR3VweVNxZWovSFAxMG5YZXg0c3FoOVM0N1hBNm96aFFtYTI5?=
 =?utf-8?B?M3NYNGVSRTFDOVBKWnI4N3FSNXhZMWd5V2xuOGluY0dvVG82Wit2eU9zWTQ0?=
 =?utf-8?B?eFVQWWNrMmJzd0k4SWZRQzAzRlNmQWZpWU51aUNiSzBrM2lJQUdYVnI2UlFJ?=
 =?utf-8?B?OGZRV0NlWWZ3Y3VjbVVuYzhiNVNkM0haQzF2cklLK00zQitrTW94V0xqaWpG?=
 =?utf-8?B?a3NDNlRjbE9KMEQ0MzByTXhRL2xNM0VES1FMMkRIYkVtQjkxSGJDdXl5Zkpy?=
 =?utf-8?B?TnhjL2lBbEtodDVYVVFwWHJxUWxGOWlOSmhOdVVsU2NMck80ck9OK2pPT3Jj?=
 =?utf-8?B?bkszdjAvVk1hSHQvdUdRU25XUG1ZYURLWC9Vby9YT3BqVkxIN0JVenlrTVNP?=
 =?utf-8?B?MG5iUVVBNDBSVzlURDhDdEEvUlp4azBhYjFIenMrOS95ZVFZVHRQWHo2bWsx?=
 =?utf-8?B?bzNEL0FnTXkvekhoQVJZeEVKSFdqcTVNb01oWWZCdUUvZFRDWkxKUXdGT2t3?=
 =?utf-8?B?VXRDa05pUEdNOVUzRTFkdlpReTFJOWI1NDJ0aHZYY2NUZWFlZ1FVT3l5aHlI?=
 =?utf-8?B?VzFwanVodjFnWVFOS1hrWXpGTDA5ZGl4TTAwcmVXdGY5UGtDYXNCY1NPb01Z?=
 =?utf-8?B?OWZNQjdJSTFwS1VCTGVYRzN5VUxnR3BXSGh1RWJFaWp4RGl5cSs1bk9nK2pU?=
 =?utf-8?B?bG0yK1Z6emM0cHp1VE9KMVVvTUtyU25QejdoOFFTWG1jZ0UyTFpjbXpzVUgy?=
 =?utf-8?B?cFVLQXlQdEVWaXdkZ0tGcE5XbW9Oc1NFZitqaGdSMmNoUlNIMTY3SXlTZWNj?=
 =?utf-8?B?bHU3RzBZclEyei9ac1cvREpVSHZFZk1iZi9KV1ZubVhlWTU5Z0RKUXRJaGo4?=
 =?utf-8?B?U3Y2WlRkQk1mcnMwSmhoZDd6T3FDaldoSWNiNkpIT2FaQWVRSmxKTkRFbDJM?=
 =?utf-8?B?VmFXMzltSEEvMllOTXg0N2J0dEFYYnNVazhULzRndlNmSkN5R29UcGxWUURl?=
 =?utf-8?Q?IYd0LsrGG1rc5P0EPQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbcad95-95e3-41ce-b617-08dedab507c9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 16:46:58.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 856jRVBwvDNhYXesaD0UE0v4DMA3VrUO+aR5GM4kvtZ9XUsvzJynAYoELCwL5VCU15f8LtYlPT/a4aYXMRtEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA32570A9CB

On Wed, Jul 01, 2026 at 11:24:34AM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rt_flush_dev() walks the per-CPU uncached route list and rewrites
> rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
> This lock does not exclude RCU readers, which may load rt->dst.dev
> multiple times within a single rcu_read_lock() region.
> 
> ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
> three times to obtain in_dev, the L3 master ifindex, and net.
> A concurrent device unregistration can repoint rt->dst.dev to
> blackhole_netdev between those reads, making the reader combine
> state from two different net_devices — for instance, an in_dev
> from the real device but a netns and peer lookup from the blackhole
> device.  ip_rt_get_source() has the same problem: it reads
> rt->dst.dev four times to obtain the output ifindex, the netns,
> and the source address, so a concurrent flush can cause the source
> selection to mix state from different devices.

Why only change ip_rt_send_redirect() and ip_rt_get_source() when the
patch is titled "ipv4: hold a consistent view of rt->dst.dev under RCU"?
What is the criterion?

> 
> Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
> of each affected RCU reader and use that snapshot throughout, so
> concurrent flushes cannot cause mid-function inconsistency.
> Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
> to match the readers.

The rt_flush_dev() change should be a separate change. Note that
dst_dev_put() was already converted to use rcu_assign_pointer().

> 
> Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")

Please remove the Fixes tag given you are targeting net-next.

> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> v2:
> - Use dst_dev_rcu() and dev_net_rcu() for the RCU readers.
> - Use rcu_assign_pointer() when publishing the uncached route device
>   replacement.
> - Slightly adjust the commit message wording because this issue was found
>   by inspection, not from an observed user-visible failure.
> 
> v1: https://lore.kernel.org/all/20260630094250.29386-1-xuanqiang.luo@linux.dev/
> 
>  net/ipv4/route.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3f3de5164d6e5..57f38467e6d0c 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -873,6 +873,7 @@ static void ipv4_negative_advice(struct sock *sk,
>  void ip_rt_send_redirect(struct sk_buff *skb)
>  {
>  	struct rtable *rt = skb_rtable(skb);
> +	struct net_device *dev;

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

Same in other places.

