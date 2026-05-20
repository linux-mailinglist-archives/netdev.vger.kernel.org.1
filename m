Return-Path: <netdev+bounces-289812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKjtDSlmDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0170589165
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A89A53024386
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93B36F415;
	Wed, 20 May 2026 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uD7YFUU+"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE21A682A;
	Wed, 20 May 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263012; cv=fail; b=jNXTGkFvm1XYFVmOmpn9ZgyRlzyRmX2atnvqer7PJM00JA3Azd34XRNXorF2cdJG5Ek8L+Btevt8MCSetkBVpnl2E6qgWABEwZUrcBwPiq5bHPjHAJZj7NKKwTGuuifVUQCVklPcCYjsbv5SWLNx25pQ43iJ0xbwIKOgVPnhYNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263012; c=relaxed/simple;
	bh=PJiCdyDTdo5GcmseAy9MbORVlQLkJN+PFCPvBfNZrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhQil3fbU6TCXXqg+nfNPS1F6puV0oBJ7M8SlbwxBrkPB+2rfgbzxL0B23EVZcQKxfmMbXmeYGgbXngrig5BA8qHnTXnZXAjzWKK8062JRdcRecpZL3S/By28mWflrF5+LRxhJ8KHDhZOQZn5NLy/QW2ZBYiCUSpzBsN2PNglIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uD7YFUU+; arc=fail smtp.client-ip=52.101.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH1yAlb/HBTgAU/Fdl0D8AUGE0qCY03ax0Ld5dM8Osz2AKVzN4phMv99AKRYiVsRkomFJDBZISNLLx7EO2GGFVBPCXK0ZJPlJ6Slx6lmx/kNORWMYN/fetsVJUPVGkgACReXxmtBKGN9YZTxPdgZ3kBHVQ9MIgDU1MXV76LyzZ6NRKB1+n7qrxvq2bYB+VS0dtMi80bgdIXYkDPPzFwlNz9VCNbz+rV1zt0acsT+QX5hRi51kkXK2t/HjRaT1r6UF4H9qDoAyZNQjbMbhaylfCMMAVxF0AHyRp4o4/AyzHp2flaDYxHTmSBEKkaY5I96TrKzBReCcC/3hdKz/PDQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlfcZIgwYXnYHNss2accoa6yyuymX/C1wazBp7qh+AI=;
 b=TYw4tChZomIQRD/MtgDQfzi1mbA9QtZyuAxWqGGwB8jtwe1mPBuY7usRx17tLmLxvnOwZu5pgFcvnpRkFvdBeZurKyP7dJ6+DJ9Wn1OSrZIRvamXCXvLglkP14EP3MCbZLQAF68MPbY1rnRUmPNT9iGWlwGTCBbYa+SnmcYGzQt3BOgaI5bkebdhhXIfBcc2+ClOZ+8t2rLLgf9Bl9hoMImTpz7t2SwHLk/Jm+BGZtBlkJV/QIdWyG2jZ7cUFK5oPPjGVe4KeFe9UROIlZqky/aqchgnJD0Ev8bodotT5prz6cFI8QbPhdzt/PAbEcXVZ10BT9d/zY4/br72LHKoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlfcZIgwYXnYHNss2accoa6yyuymX/C1wazBp7qh+AI=;
 b=uD7YFUU+T4KJtgcqxZVmZk3YVXR2WyvpR1aFxtnzEWsKO0ZOd20w4M1r7ZsuwCUANMdByoQsyj9so+BDoi8aDb+aKAfqKsAZnCLt0SwQ+rDlb3V7jc/RCjBnVy0n0mtR/jcs9BNfuCF+lRVG1qlY9tsQi39AdQTGddT8WfsbO2kqc6nwiTe0QwOBL6zFk1pKb/EssnFsiDLw57fgKjIdPPzBztVSBUeHZLNWhUZKmK3CxdzfEw2wnCssfmqGGUVo6XhBk3qr07XtO2s1A5+pklEN983zwaDH96nPAEkmWNjWCZ9ZXaolRQTmE0OE5AykAQsA1PaPN+t0yGJwkiyvrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 07:43:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:43:27 +0000
Date: Wed, 20 May 2026 10:43:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: route: Unregister netdevice notifier on BPF
 init failure
Message-ID: <20260520074316.GA552366@shredder>
References: <20260520030329.1061183-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520030329.1061183-1-dbgh9129@gmail.com>
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: a9640ff8-8c53-48d0-3b58-08deb6437ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	inO7M0cSo9iAU0VFckgHb06/ZHIATeDGUQucWDk8CX/rBynyhRGPW9zNh86s86lPBJ9EZtSKj3J3AIEMblhhjccZj+bHsFE9ZX4bNFBgQ+UXx+CB+jCHicEXxwYL5g5Ig6u4CdNjQ35DBNARpXW/Xiony1tgUxsk8+mwpmRHLNmWFClrlGdncgWAnO5dGtQ8Z+z0GRRrw1yDYzEKR2xXC9sx9K5j1A+xR53oc01YTCmr15HroRLIUOtMylO67XWASo/RR8tHeWFqJKVa9bkZE8JrbPyTfdWg0P7MnoAJ8w+ktwGklZGMJ2Yy65NMT+/xrCXTuBYrZ9WepZXym2nggQf7Oo605kQEMAq0BayF/iNsTjZhvVVVhmar8Elghu3rRDKJCMuNy4kEap44fWFHV7fWfWYD/nbM13fx8RXmMQvtCuFnJ4ezjWRyvv7f5LfDESHOPA/ySwNPajC4JfjZcXmL6EE0KYToJlpsA+8Io3Koyh8dFm92EIsCKgIGoH2pajV+A2N3FEQyFRcbQ64/fy3Aly7oFeSb3GrccA1BX97wwQ3x0dQ97g/zrEtvXfI3u5P54Xc8ShYNKPXbvbkv8LOY1Kr2mVCUkLfDo59jfDyw+HF4h3yVCXM0e7gisqf/yp8QhULUbNJniL53kU0wdtwufSjckXRsTOW0ovPidhWbZiePT2qRQInD7Es5ig24
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHQWJJ/E9LFgs3OHy+u1aJdoU6V7LdIWYwBVNUYlFm9GfXP5gFPHVLK2sjts?=
 =?us-ascii?Q?+sEkRDaQSHY9rHjbAZescJC1gz1Y5vGSOj9OuxoW+JL4sxl8CxumWZoFB85X?=
 =?us-ascii?Q?utuPiOZDn7wzTP+ZHtqYmXDIKuJtBm/4LfIpNFSKVgc7M9uxnRvyEhix1Pxs?=
 =?us-ascii?Q?XasrZ6xwsHAVmQDn5D+PrC8cgf7Cz6pVy+xZr07F9rdbEMmyqkkQJ6Go4BVr?=
 =?us-ascii?Q?Ae3Zl68aw9utEZxS3M9dcAPWW+FFG62t60B17vmvHn59WSnVAycXS8CzzbjY?=
 =?us-ascii?Q?hPJvDc5MZloNcwJDgV7GLd2C9y9QRxWWwRRUpjDF5dKl9KmnyuByjBQzh8ZS?=
 =?us-ascii?Q?TGvQizCTxkY49J2g8ByarATgHdh2YOE62YGgICei3wHVfqt/Ba3H5rWjkuzc?=
 =?us-ascii?Q?zu6cqoNX9yK5Q2QIvWrpx11nHoQlIQP8P6/gq7rIhWkYAb9oTD8lXXlnLjnt?=
 =?us-ascii?Q?BSobAK2BeZr9wJ4X41juqEvaiC4HMykG8mRaYJ6DJXEMtLA3xwvwYF1dkfIK?=
 =?us-ascii?Q?Lf65AHXC3579bPJE0yrX7jDyWEEescglflDj7SwiFXApwGf+U1pbK0bGkhOp?=
 =?us-ascii?Q?gOjK4kdO8vB42IhPHk/ZWsE9ml9z9Aipp1VRQyC9BgF6Ts9fR5/WVxKSV7iE?=
 =?us-ascii?Q?qJx4FptHt4j6Jew6MWJuO/0i4lEwOeFYvWHQy93530Ej77/Xv6V6umFhWkXD?=
 =?us-ascii?Q?+7z/MZFnLMwptN6x6uNJ5GKtmYAYrmGZea/NlVhIa4rRWdGyxnUTqqUahhQG?=
 =?us-ascii?Q?S/TKueEUNpBwY1D2v8RsFwsdcbchuEcZ3a8D2oggboFDRBh9whuwJDK21NXU?=
 =?us-ascii?Q?8RhjfTEINtZ/MfzEIPjtAX7BI9v49r/0qekBVbcS8GkMs8hrWNACIV1OlY4J?=
 =?us-ascii?Q?trOIRAu/vOBikqhKzgi51L81Nba9kvZ5Emz1iv8asLtIjSma2zpQjTOhYXWW?=
 =?us-ascii?Q?EQjbG4roI0DQx4AXeDCCMXMJaCKEuCN3M7p5Vh+dyzZDrssDJbhF7lRTwGA1?=
 =?us-ascii?Q?uCP4jfIqNs7a/LA4qzrdDO22C0p6K2ZWtjoLkoKP8kc9bAysPogeIsWSKMCu?=
 =?us-ascii?Q?TPjhR1K4s5OGQaUBPSpj6r133fd/DfMNCm7wg73ieFXc2HekYgKpsxujwtiI?=
 =?us-ascii?Q?yqFdzOPJi6L0hVAM8Xgx8luT6jbkVmxdl/Bmd9rDCJYRthPz9XNiliXFsz6P?=
 =?us-ascii?Q?443dBntIdfP/L69VHzr6rEwI0InJb8Mh5ob2vU0VpDG+sCPc+VS43JM2zztj?=
 =?us-ascii?Q?f6RfZ7cWWPaNTGVnPQQ7U2Iu8+CmEXsKpg8xVkTwgFCJ4LIO2A/dJ9BjT1JP?=
 =?us-ascii?Q?NgzB1aH0vh/dYohbbj5ZbW2/Dnnk6NET1smiJ1h1o5hCZLoBgBsbivVSXoW+?=
 =?us-ascii?Q?Eiegy9UqquEmqrV1uzlYTPQMldbPcp1JvEqCL8dldoOA0y/hRHtomTauuLr2?=
 =?us-ascii?Q?AMsyQXpZok33QtptB9KGGb65gIiZkwPN41glSQqHWNAb/UnojhzG/hRZ7kXW?=
 =?us-ascii?Q?wG+qnONdkM9l1DG0R6PNb/TBsBsjP/IDt1EEkx6nqKdGZczCD1TLFIqft+R9?=
 =?us-ascii?Q?9UDvRL0YBE/p8wAsYryifk1fIpyg8dYy7Fh+GIPZPpmsmx8gd7903AkTsFX/?=
 =?us-ascii?Q?tsZfciASPA8fhbQ8r3zXzA4O6CN9mwySjx5moFyIHHxx9nsepKQeMJEatKFT?=
 =?us-ascii?Q?nk++uZ4EM+r3vxT0sYWsYk2TfSP/JPqhFzA/j0qf/qUacC+P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9640ff8-8c53-48d0-3b58-08deb6437ab4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:43:27.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFms7QTvJbH0LRhv+6Hh+cOgZaw07P5zm3V/Qqrtvl9eJkYS8i1qcmZZZ4OSfk+HX5JfUtTmFCEPOi5YG38i3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: D0170589165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject prefix should be [PATCH net v3]. See:

https://docs.kernel.org/process/maintainer-netdev.html

On Tue, May 19, 2026 at 11:03:28PM -0400, Yuho Choi wrote:
> ip6_route_init() registers ip6_route_dev_notifier before registering the
> IPv6 route BPF iterator target. If bpf_iter_register() fails after the
> notifier has been registered, the error path currently jumps to
> out_register_late_subsys and unwinds the RTNL handlers and pernet route
> state without removing the notifier from the netdevice notifier chain.
> 
> This leaves ip6_route_dev_notify() callable after the IPv6 route state it
> uses has been torn down. Add a separate unwind label for the BPF iterator
> failure path and unregister the netdevice notifier before continuing with
> the existing cleanup.
> 
> Fixes: 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targets")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

