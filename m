Return-Path: <netdev+bounces-270934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIwABWxRwmnNbgQAu9opvQ
	(envelope-from <netdev+bounces-270934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E33051E8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D873E31E970D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FA3D88F5;
	Tue, 24 Mar 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O72eFY7G"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0007390215;
	Tue, 24 Mar 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342093; cv=fail; b=NYGtfEiK7xPsqaDeNRx+9KGTWtcZAGeeJr/aYtQg0oJGDnUFQn6eDrUchvJTexJfJf9+YdGdmJkdOsMskebS3hNGXCVlZ7xznDnNLabTp7BoPDSG1JFuPNyaDfQCDyJbRtvJd7WrcOyGZqTrj0eAE1V6GoBKJ8Zkrd7xHV2WnOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342093; c=relaxed/simple;
	bh=Ii/4gK5XbWT9piGOVuPOInEmFNHHEgK+I6qR6QVq16Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nw0ae9pFytDfPltSRSs5aVgxnpfRS/yph6BMoeZrxDtvmJNkC38biaEZapgVrSCGJKQ4YNLC11aI8tsVusNSy+/YnsLnSbMyxnUGB6LpZnSpQdeZKNBPGmBCzGE9qAwvF6F+TvILVx+kNMh05NWImSan3ulHc2+n+f59PzTyf2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O72eFY7G; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLlNL9P+6ZBnxyq2FBLxf6I9Utb/meZ9jw/FdP7qK4M4TZAm916M+U669d4RqOLXU7OAokAeo0T6z5kr0yScw1u38OGRNwoeCVzbQClR0g5wI8sfeWzSFN40XUPdWItEpDXheyTon4ayj/qRV3UNHAjrWfTIyLfnplCJ8cPyIcY7AmiDNDH0Ni3I048MMJOkR3ue+xpQ1gEc5kNTLynZ9X/jh3xyiuwVEfb/1mE2JUKep0F2uK5VChtdszOqHiUATM5vegYYi6lHGgRZ2EbLy0gY0Qlgeg87nOh0dkiDEMAvd4weHUjiEqtfo+qXIiFkZTctdT2vvQ/PGaIxMAw9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii/4gK5XbWT9piGOVuPOInEmFNHHEgK+I6qR6QVq16Q=;
 b=afBpp2/7xAdxA9PV9weLszgOZ7i7O+cvfCVn855MmzTH8O19YlSNl5pghPbYpyI/2c5/wZvKfjM/qSm9SYFc+EQi2aYN9jc4H8jmod5h/XZgzFQGWoEHK0nK36H4OmNd8Zc2T1L3Wyd3wuTEbwRZGof1++VBywZ7wbgM+AH4jk16lmj+nbX9j+UeT/N3ta7YMd8c8VtuN+v6vIyiO8H9J0zI5kCrJqFVH+3lk0LmVMuqgk7RzDbxBsc1Ipw98OCts1VFFSEohbIk7VKkSAx7+MfgyQJEezljs1PQ/rcQDuKqA68Xm118gSdeszoKBvEiPuGfjDlilF1lxZ7s4zUCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii/4gK5XbWT9piGOVuPOInEmFNHHEgK+I6qR6QVq16Q=;
 b=O72eFY7G1wtZJOQBRGA0ixGRklBerRG+DSdM4ACju8oCgGYJ1vNphFfAX8xhRxcjbxbZWNKkICftddVVoX19BFrc387wtxwPmzpot5abmS7qLLsSOqWAIgKHk6q2xIFiW8Mvddp3tQJVdNMjNSwp0JKBx3Tokre2js/I1WnXKaUVv4TMTs/sVcWq7tdgaNjnwOVOfg3fOv4lUPZpP1qtXurBC2+ZYmO8jVXpXXO7YB53iJg+EfG7xCxsyp8hwtwLb6ewfNUeSFASrY6sAAb9u1hoeuzYG+qN2FLQnTulJtX5dufqC7lfYCe7ucEeYdhTt3M+b+u4anY+W9ZVQtbnXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:48:09 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 08:48:08 +0000
Date: Tue, 24 Mar 2026 10:47:59 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/11 net-next v4] ipv6: replace IS_BUILTIN(CONFIG_IPV6)
 with IS_ENABLED(CONFIG_IPV6)
Message-ID: <20260324084759.GA370919@shredder>
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260320185649.5411-4-fmancera@suse.de>
 <20260323201125.GA335123@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201125.GA335123@shredder>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: fce26af3-6b7a-43e7-0f17-08de898212bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4mwsFg3pwag9KfIQ+T3KVcM9r2Fwaq9hsZc/U4rgRPFxqu4BKa5C9NCR+XMLu4J93df6PwIaaYN1IXljbZ/KUxfK9x/Yqd0OeiPXoUhsvFK2ZlhVe1kMmXqqU+lRcP/1cRamiy2uq/Z3KuA6Ger0tqoelvVRDi7sTfA3IXmdHVTeFOY99kLBN4v6yp2+rs0VCB0+Ebxw/d6DIJ5b4iqAPMWXaKQsB8xLr1oecf2IfkdUhV0M3ar3TaslE+Aa/0z+j/IPq1abJ3LdL29K2M8nTz/hO/OMr79waqcP16aNPk4cjp5Irae+T+K98CqjDQWAegDgGJoZMzsk/IM61hkmYxJba5Wm3H+GX19UTHRYMBIzG4FmVEdMmhwnAGF9i8p2QUBr1N7nPalu9fhJNWv56YT1V5KjigJmSMWxV4HalkJGfijEZguVZhlY1kE4uW5ymdU2xm7oTw0m8dRQyZoMIJRmsxAbm9AtER6+IV+rVsi/8uKlHbAradGHiUfh1lWSqtNljxrHDd3H0CjJaYWrgg4bENHXiLxwstxpQ7qyyLkSyErnldXjWIhHFCITCobbPYO3hMb+ItMscia3DSkrNRhtB7gRMeYlAIP/hneiV6uhJeZUFcHnplnGyXKxJXNsrxgjjIeaKOqhzpMp+B49nKjOjgR+FEa0cFm0/qUBXz0kBXbhAoDYJGw7F0rwCX33tYlmEJcBHiRCIlhCw91tV6TAg03T3duKa5g2K7kbMTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LcMZfmx14WIJLwrTL8GnK3Bgnf/gaNyr8KOgj0iKNoLqp46OKC21Z7kiL0+?=
 =?us-ascii?Q?nnBxb5RqRSlVzMNLMrtnVUoDH/XJ/lf4c5jAZJDj9dxoFpA+xsWaayIub6JC?=
 =?us-ascii?Q?G1UFugovHugDpzQ9i+f+qRPbwyXIdYNxZR2ARWnOb2MWvlYzH5kkwsMHsr3Z?=
 =?us-ascii?Q?RkiXuatmPUugKcjOjeXObjljchGr+G5FQdJOJE0AF0UU2DHj3zF6NYDkrULF?=
 =?us-ascii?Q?tNA0evZsGCmpRP133kiGrwv9zoNoQ2SsrQHJpv7BTYXPcxxB6r+3n2zg1p5X?=
 =?us-ascii?Q?KdNQ3F4aVawxfbP6IZbfjhZW0IpUF9zWHDdziTnJSn27ZC9w5AUrrOfUBqKK?=
 =?us-ascii?Q?Dei5WDfTFOyg1OkvtyDco189aUMiUfwEFCucx6HqqGCwP/rawokzz2QLnx0t?=
 =?us-ascii?Q?VdbTsc9K503iW8aHn0WJcXUDEWQScRcf4OJewMliZPJxrSAbnQhcRoXNmgXM?=
 =?us-ascii?Q?KG5M0FahH99dozPYbPWzoG/cR8Be9OtNWN5Vl6K72w0dwdZpUmE8pGSS7kbB?=
 =?us-ascii?Q?IXgY1iDICZpIzQPXyDiVAUZti/dSwrCyzcFLPsbpJHLeWtOU8S4tgEOyNp63?=
 =?us-ascii?Q?YQz/RnSDldwfOGn/pyB/61aqubXuHZme53Ufcdt/Xu93g0eyYOCMjbIy1r55?=
 =?us-ascii?Q?7NwxOCpzatPCjyHbAUWoBsqpnC12lKzTwnQ91p1LQEAhGtMzXS/TvPQoF6SC?=
 =?us-ascii?Q?sQDEWaN8fjh670t9f2RntQTz7o4nlaHifm2Ac4NAa2UjxDUvRI0RD/sOpXt3?=
 =?us-ascii?Q?ZCUFNtkYhLcU7zoRVKFUi9ENADlxuQ3o/5FtAB4WtlhEmgcjKL+2yjyfObxF?=
 =?us-ascii?Q?bhXRgXvEJeQBzZhvJSHBizV/oaW5gIObn6S61tWWu57kBjP3DDEY0EZU1LZN?=
 =?us-ascii?Q?NmCJtkXB4zU1MCsRCOyNU4br47zBTqjG5Qmiqu4CzQhuuhIQ807Zq/eGPs4x?=
 =?us-ascii?Q?fPCDkN+j6j5crsB0daUrH7r6g3lfuQovG0nVMLV/UGg84Dnydais68VjG94U?=
 =?us-ascii?Q?YEiAwpbVI8AfQYG4CRShmZyaUtE/tvjwwLigvkqNmgFYzYkP12N+2zoHyXpe?=
 =?us-ascii?Q?0VmBLhBuvlvLbNOBKaPkRMmxdmtdPNYS+ri2b9Q2emP5KXLURNwdGMR19e9R?=
 =?us-ascii?Q?8H73rW97kq3d2GRQjGGdkAy1KIoiR1v3sWH5RjTQ1/4eR4nzFAY4Lgkmt6uS?=
 =?us-ascii?Q?eCKscuJVS8ty5Wy+MMlSEeYdEVm9ILPmHljoI/C/ov5Cve6aC+8Pwu29fMsL?=
 =?us-ascii?Q?PM/avYerEbVG1+zPmZKkHyyjrSXqfo5QfIkPWb/JkWwYIqOTGSNR7qkDFh+a?=
 =?us-ascii?Q?aCuYp3zLQcJIa4qUAgItRpRjlTWAW5xLbE+CDpitnuBa/bodTutYzSWtNVaG?=
 =?us-ascii?Q?kF7EUlEMmhKBRjQnc0vE183tTMCDNtkLppfdGMxczBKm5zyu0Oa9q2Oz1FF9?=
 =?us-ascii?Q?oF3IZUq7nDym3UsyUcdqS78LHjzWmXr4TW16Rkenvy/0m0+Ae+go0WaQvjSr?=
 =?us-ascii?Q?e4cn1IYRWAsyV+vHCc3rV7NCMEVtt4RGYmdQsK57mixQYAJ/7QPHLQagHz0g?=
 =?us-ascii?Q?hmxNJEJvgEUOTAVRY5ryhtnH0SoHbo4tPg1y1zm/3wBCZxnnCqZC4PMKwGD3?=
 =?us-ascii?Q?jIA0fszRx9e8pXKmq8PAd1FhJGmFPAg5gZfogegQuOcHOD8IKOkIYfTkPwMh?=
 =?us-ascii?Q?Hki1tcxUL8gyLro/nveW8uNzx669jPM+DaRvC2CnNdGnv8Dh1ZMwggS1qvtF?=
 =?us-ascii?Q?x0duIPleJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce26af3-6b7a-43e7-0f17-08de898212bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:48:08.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAq3tmpppCeiJ7k9OvOhKtBdCyZKwuAMAOpbPM/fh4ZDz8CULXfmno0PJ95rVr+jIS8oSC911TdtCMsO592c7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270934-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 909E33051E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 10:11:25PM +0200, Ido Schimmel wrote:
> I will try to go over the rest of the patches tomorrow morning.

LGTM other than the stuff I already commented on

