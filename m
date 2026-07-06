Return-Path: <netdev+bounces-305127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dS3DDYrRS2pmawEAu9opvQ
	(envelope-from <netdev+bounces-305127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:02:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD960712F85
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VDgnwAxU;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305127-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305127-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E5F531C6CCF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7273AC0E4;
	Mon,  6 Jul 2026 15:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449B41B366
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:30:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351825; cv=fail; b=WqtnDCYkDiQZ/j8POvkilClbrPCretHw80Gd+VUZpDfyAGkrj9aCrDOkTLCQoZfsHkAwssE7s/RaHcikWWvqGOk2jPk4+D/FlCdxlnk122DqUbmvG73UZ0/JzrMBvsstbWc06XqlYl+vfxIFix2lAdDYgeEACJ62tz3O8BEWyQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351825; c=relaxed/simple;
	bh=TkszoP/A/zpjKOhCcf2a2ZZEcvoG8KPIjzJJe7uRo2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOsh3LgxwDsUgELUdkelc9X8LkJyEUm+wuW5wCovemA1MxzCHj/aOLOGc4ip8vafykyB29t78UL5JB3xrPmJE5E0WcTBx3LyOi1KOFOu9B4GeDgNpIx7dstv9mag3fbLHOP6dv0RftZZuWtZU+KaPE94bOvw0gNDmASPI26hg1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VDgnwAxU; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig6el/E+JYCV94YZPyvETUukKRvwkmmITBp/gXUszBHIOl41tFdtMWYuv0AJR8FUbEA4DYI9yi1Owqduo6nt89mIynTxEp56t28r5E4p9jfyFwT4x4X2ZKeLtjbtSBugfdCCo5U8UHk8/zXM5eHRBg4hvV2HgZg90f7NV2F8slciT2xhWTfJJF2jmnlQgj84hAxQjqtg+wr4wsMYyxuGqyIH8naJendje+IjvkJ1ur5I0yu2wOzrUj8Ai4R2U7MWI1sE4jDMSfPLw6wRrIY9yBMQcg7G9DBkIvF5kUzX0VzQiJnZfPbxQFze9Oux/oszJ/NCZjIlwDpZhhfj+6vUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yXZZeS0AVdb4iY/m3wBIL+8lNqeUqrjIJHTueFO5FY=;
 b=JpP6iQi/UuGsTfBdTQCp8ov5MMsBE9tI67bu2tGfPiJ/kOhWeHP/534u6GEAMgG+nm52tPYOwNl365biu9JWQMvXAk04IWOSAzlIKybObiQN38Cj69pHOba2XV01sfG0YbbVdAcaBLh6zZ5IJilUyFaB9IRsn72Yc7I+0RMnV++lm6j7zRA2JcmN4IrOn87WmzvJKqMnrC60cX+lmK9G+zYDEe1zPA+Eplj4jn649SQ2KCazn9lc9G4fwHy1GEGsJDln/sSUlEmcNaG9GQ3TjtbQJ/Z0sv7Rux+CSDoQgdfSHiL3+MFqNg4MUrsTsBpit1uD5UplJTFBeCzeQ9bRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yXZZeS0AVdb4iY/m3wBIL+8lNqeUqrjIJHTueFO5FY=;
 b=VDgnwAxUXP2GES4GUWrU/+Uh+MBpSgVQbJBQ4IVlHBoOQOc94yz0aJL8M/p+MtaW9g9b5twrxssW0wfdlXZF+ACmlsI1L7oD8/JJqGdDqx+c3BEZh2r7la3ud46BcAq9SkySv++PigLe5l+U3XHDmphgiqxdI8x+f0dyalq/xmu2+4dhP7yZJd4TqBgGYiokXgUPtcSAIPsf57GD2wYfmybv5gEg2OMa5+s6mRAVsgZdlUC/0YwPYpiIT68NavhinHn12UFOqRB1J0209OMPdcKZUwxfniH67h+3Lu5oc95D8rxgrAlmEGiu5I2ByIevIH4fQB08ivFhrkM51Zgh+g==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:30:17 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 15:30:17 +0000
Date: Mon, 6 Jul 2026 18:30:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 3/3] ipv4: igmp: Fix potential memory leaks in
 igmp_mod_timer() and igmp_stop_timer()
Message-ID: <20260706153005.GC410724@shredder>
References: <20260705181756.963063-1-edumazet@google.com>
 <20260705181756.963063-4-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705181756.963063-4-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 80af3e91-f032-480a-e41a-08dedb737b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zx91ASKcb4vEfm7MZZtECfaS74gqA4qcpTj3LnKgK1OoVRElQtAiCq6V0TqwuSSjmIRPqZcx6MTCNinzHIm8L2jKQtDk2FPVE7EacUYSAoZ4ww+/ExRxMD0pWAeWrBeaOI28UPlvy5pxkisiGS0mmJytCgQP/5r5jqVGndNWL/5qSGISVp76MhST48IbJnXr2eREqaXf+oZPdQi3YopkJzlZypt3QUnqYr+Pvd0uQFFW3NH6FbXg8xTw8cYoYIR37wRtqJ5AvxPhHjO+vhwAa7KUENMYeoZ2EhYqWpqqMAPydwwX9kpvVQYlduB5jfUJaB4KKJa2NT37GPYfOmRGEZh46Fz1lVJqbIILtZqi8pJQcaGpA+uyy1KYrIjF+daQK1nONMS5C6LndY+eQHyVP4LoAHCZEyDMSFf2BEpj/Qi77HdD1fqJiCyz6kCNjuE7/wXl1PAS2bNlq11ooaczEAz+HgNiTAltVt1s0gnWehjjQXGFV3b9WdkajO3xLlRXEKLcneSPtldtrtLliU/ek98ESgFuXeQQXMhnMHCWUZxpDA+HbQLngKbgOXLt0hRaCKQ9VXF24uLVX+Sxm8aeqS/9WQzedphPBfODJN3AVloAIiK3VqGyPaFzjpO507OeiZVFR1aTdQkUW1jAdCBv0FFpvaL6WPRI3Su9lAQU3/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTtQ/jBt9b9LaLWcAtxAOR5rceGwTRHYT3NrBNerVZTCngnirVV/XUnvezEo?=
 =?us-ascii?Q?Y+23omGoD2LwF//alHmQzinkEYBDTg+q+CvWNYVhU4ClQgWyk1H2M5DhPUpJ?=
 =?us-ascii?Q?k7yrA0vEck1albPVBGV0OC6Gcg76p6z8LpKG2lAv+PK44Ja1rvnGteRkUtxW?=
 =?us-ascii?Q?YOTd5ltqJkyRtjnblYRF5wBydqLJq1clRkWhkdyChUZJKa4hPqKub1TZxFWp?=
 =?us-ascii?Q?ABG+M9EUHVhdI2QbykTGJ6XI5lk+SIBs22dDCivbyE5/yTMLNU6xE5+x+7CZ?=
 =?us-ascii?Q?F29ZaMQnOLo6JOImL27KVfr5MYkV8blgYusn61kP2BkWeAataONF/hDcTZdJ?=
 =?us-ascii?Q?f5mnoYARjodcjsXeuhzEqiDQI2D5mzY94sGSaZ7jzyc4bHLIvTbWaJJmFX0w?=
 =?us-ascii?Q?qnBlVAHCI3T332pC17+aFuFF5bD7JMgvCIpJ7UWwbkG6REFTo1abPT4ublOB?=
 =?us-ascii?Q?7N14YEWpU45jImdZErzBlVPjzJUePlWIXIseKEfZat0jC4cIYW0FHKh5440I?=
 =?us-ascii?Q?libZxOk5CHNKtlcQkiybp3zbylqAKpb+r1wBcgmc/v45sYd51tzAEXsH8QuR?=
 =?us-ascii?Q?rU95lA/tdXJH+WlTgR0RCBloKS3V7drSxjjR28WfdEjEZ6YFxF/YBUC3kKcS?=
 =?us-ascii?Q?pV3ctsrPvZWBnt5TDCDs97uq23n/UJQVfpLJabjsmO1/TO4n2MOAQofj3Ypc?=
 =?us-ascii?Q?CnTbskycv1imnPDJyZFVaVdr+8GUKBSrwfPFLRxqam67jfKd7sdbz3Sc6ahn?=
 =?us-ascii?Q?QDlzC4f5WV1/Osz/n/cClK0wLlnXS9URQ0OQ9avFoUq7c2KFAW/srs6NOIjz?=
 =?us-ascii?Q?HKFNUjA9aJsb9OpozPTtWDnbbEg7pLMM8Ow667KxYcDirlLjqWfXVD8Hw4JY?=
 =?us-ascii?Q?V/NFD+9BPnV4g6tZPca26jq8u8f9Z81B4Ed/i7Z54MNQMiOiAMW7LidymOvv?=
 =?us-ascii?Q?HR8AefJ2UWBKLNjLnWlcQYvcjig/2eqkj6N72QHkCnHY1dnYAeUAGJzkX/nc?=
 =?us-ascii?Q?zNRUdkPTyR6+wxlw/ALfvcDwiQ1qMBxlFjvAvCorqTI/a815jfvlp4NyOWG1?=
 =?us-ascii?Q?720c01yNDwAgUzKVEFbHlQxHP+s7+VpqatSVynnGLLpV5eJPfEO1QiTVAgh0?=
 =?us-ascii?Q?qp6VgF//cWCP8c2i8IjKQuVU8qUFg1Jsc88q75hisvVk2C0xZGbeMYSqdqbA?=
 =?us-ascii?Q?O9RpQNG0hM00LoutywBYPr8Pkoya+wYoX3ZtVanG6tdJ/oYpI1QgYUOG1vVn?=
 =?us-ascii?Q?fNpE/8UKRf3yrcgQmEwMeSzBaLgxjacyEMfbZ11/EYS5znty5vuyi94h170r?=
 =?us-ascii?Q?/et49G3hSaqBWUdldZ/d3/SERgSZJjyQfmXFKdxtRaA4F8FXbildeTw0WWqV?=
 =?us-ascii?Q?koLnMd/ijunISdhyLZbqiGKI8jD3tc7t9CmmTqt06SQjKJoRpEwPAMbUukl+?=
 =?us-ascii?Q?xSdVDueJXU4Tr7/DGz1eBYwCYrOitWHa8uujH42O4wOLBFLKIG/h8YzUEoP/?=
 =?us-ascii?Q?yqVXG9IM8i3tve/1YgMLfp8XlNsn5dR+4mQ5+z8xDx2sP3dwmTdKisw9GaBG?=
 =?us-ascii?Q?/EGrbQZ4cm3ZlAJ3ZAIb0fE40pGfQThFMl/3LNhyNstszB7nSSb83w+HlAEv?=
 =?us-ascii?Q?rKQuRQ3DAFhvKetbAKs2zGaP6kfTMklrQFpdnt/WQAL4+SkLs/Rd//gs59K6?=
 =?us-ascii?Q?HjYbvz5/7gGNajWDPiOiO2Qo7aOeyI8D/sYNNZYN3/NpiADda9b3dZ8RXeWt?=
 =?us-ascii?Q?vnGzGhZ9YQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80af3e91-f032-480a-e41a-08dedb737b6d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:30:17.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YAXFSZsE+VOnYbw7tasStnNN8akQ/Q8iwQLJkjdvoWMfjDUXH1QNGEnCTj/v485mWrGocQFggmf1BsXT/ZPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305127-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD960712F85

On Sun, Jul 05, 2026 at 06:17:56PM +0000, Eric Dumazet wrote:
> When a timer is deleted and not re-armed in igmp_mod_timer(), or stopped
> in igmp_stop_timer(), the code currently decrements the reference counter
> of the multicast list entry @im using refcount_dec(&im->refcnt).
> 
> However, both functions can be called from the RCU reader path:
> - igmp_mod_timer() via igmp_heard_query() -> for_each_pmc_rcu()
> - igmp_stop_timer() via igmp_rcv() -> igmp_heard_report()
> 
> If the group im was concurrently removed from the list by ip_mc_dec_group(),
> its reference count might have already been decremented to 1.
> 
> In this case, timer_delete() succeeds, and refcount_dec() decrements
> the refcount from 1 to 0. Since refcount_dec() does not free the object
> when it hits 0 (unlike ip_ma_put()), the im structure is leaked.
> 
> Fix this by using ip_ma_put(im) instead of refcount_dec(&im->refcnt),
> and deferring the put until after the spinlock is released.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

