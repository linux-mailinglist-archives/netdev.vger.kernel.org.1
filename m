Return-Path: <netdev+bounces-287627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLNIAlWZBGqwLwIAu9opvQ
	(envelope-from <netdev+bounces-287627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:31:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA45362FB
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03A4E3050F54
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78A449EBB;
	Wed, 13 May 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIzUvjJP"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52640DFA0;
	Wed, 13 May 2026 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682955; cv=fail; b=jXP2w/aZb7Jm4KAWFl+4anIawwZNPyhid4gB9HMFzrQ+q9BomAp7xoihcqHwlVUs9O+nIjVSu+LFz8BJC3x5B4jm9k8XSynSh0AYEEjiQPTjuTfnpnaNtzIltzSAoxwi+ZA4hOvTyx8JlDZm8B1uGmdd3M/TSgF2SNNCFzrmkWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682955; c=relaxed/simple;
	bh=ztEbsduVqZEEGr6zH4YwLq/vjVJ8+O6oE/2wPdT2XBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjhtNdrVS/AdvK5H5yBYB6BqB450D35IMvIyHTt/eBJX1l/yvoXtRmEvNzZoPzkVeqHMAyJEqURQL2LyE7ZATqJFCS9Tp1S4CdcMpT3QaH75gg+VSyFbu29KDEoPOC1w9fyTlRrPKfO6wYNYdwhjjIXZghncIkUrscfPLbAMcPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIzUvjJP; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K02Capw3yXiolIHvhE+bfZxFVrgNvhKA1lSuobPPZooHcy++NY/KFG4LUAoBsVGEFbd+NX8Q4WTCyYFFP3R5IEWcLovDwVETvrnh1/nKGClbyzYn9iwQnGaE7nK4MCVRLBoNqqSUfbR2acEJAXAVElDFUU5UHGdM98MYFR+4vwC7JEz3EnaTNywtan5CN3Aza9/CamcIX5QhO9KyyPWkTQNsZOc49cPtwVHrrCZRnaRea3tXq4EqFibhYM4YqXHxAwkIXxs6Mg/JXjR1sjGvitlKBgWxSv3XKG8gxWorZLpkaiDEXFnuuqIhgAKOGINDE2ZsgkGvVF1QOvQ+0M+j2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHI3ANWP2a9dmnTsued5rYwfLrSFSwZmKTpmoCK64XM=;
 b=oWLCOHPRNW2CZsPBL7pxqTyqqscGbFzHNMehHg0UKqCEoLzRTH3W5q6af4kulULuzTe29m3MXTMz+oRu6RqkW/1Mg3Rh4AX3xRIO0Mp651ViMiGUXGFnfipFZdhGosIp9QE4Prn8anPv6aWKdNGCORPSt34VPH8u1BRSEMJ+venYHF5Pl0EI2a9OF9WDoSOc3VtFiaZMb51OipNcwam/tXnxVCcYYnTThLqafiD/04QEPBbOdye2u788bOpFlatqfxoVHrij7jBqGg0S0gMEKHOfPS4XfyTHH54Y2f7ixKuuFGyING87TXICMZ+3y8pFFK3ytas4ewjHbcWqQeHcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHI3ANWP2a9dmnTsued5rYwfLrSFSwZmKTpmoCK64XM=;
 b=jIzUvjJPtV1t9zoEglGA9WPzoP+u+WjPpoORvYccTIXo7tnOazcer2KeiKozlTZ5jrIzwu/RL/2/wTSXGsFcc61t6+khbGjI2IGJd6jUZXqLU2PoLUjnsW+0zpQK//7i7ljqYVdeqBAFvjS99/kYdyiTSZwDjrUotcNynOWYrh0eWGGD0GeDudnQInR5WJNZlWX7ZlyKQtw1GtTw8ApjRne1rpR2SSNRQptuBRkTHOxxD53v0s6vFyVv0uQnMaEDOkWqij/q0DqyTz5rDz6fzisi7fXMhpLHY8ma9sKw8vA11wyY1SoPtwiplSo21sHPrYGs9JQ32FrUd9+Vi6CiJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:35:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:35:43 +0000
Date: Wed, 13 May 2026 17:35:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, dsahern@kernel.org, davem@davemloft.net,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
Message-ID: <20260513143533.GA415119@shredder>
References: <20260511122645.6233-2-fmancera@suse.de>
 <3f371efe-1b1b-464c-af21-ccd66b6c5df6@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f371efe-1b1b-464c-af21-ccd66b6c5df6@suse.de>
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a548e3-700a-4e33-2786-08deb0fce9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	qw82pIBRedPj2vLADKlpoBSLJji8ElJfG+tPgjCIU4HWscz4Fxxfv6nbHvLKDZauMnrLg994LkaiMN0vpwWTyWLTfkzVmYBv+a/OGX9TXU+jx+6uspNkIdRr7phKwBYXqiIR9H2iMdZGjnCjH4QRLeAVp0bpa5ElOKXo6o5r/JmX+9zSbCNsNkCcTymp1fJxsOdRya6OPbBHtSV74wH/vCVM2Waef9/krt1IAdopbBPiQ/1d7kL9FVREtbADgbOh2Ic25Fue3YvX6jdKcr4h81f2XBbZB5qmPGGb+fjovp7j/1rwaMPI9LEnBtSDf0qV7sIBcH0ocXcmOafG7m7gK0IExKT6erdoQ3JgtHHkqR6sQSOGuK0N3c/f3nl1UKdWVqKEW0qDiM1rIns3Ip5QVNTc+Jt7GoOuOqfsGf2B2PmJXfbvSz9ueOnrn//9pZGikSykP6RhtvniOGCMs79yDFXC7cP6ONTo3qXor+ZH/QARmuvkG8a5CUp0LMVM40d/HREtz7OHwf6Phwf2q9G8QDpnPCuSnUyNPY9qc+eG+NkdkyaUWxQcyDMZ7mra98faqp3virWMj6PaaLfkL3NWEFQWwSMxY6Azzlig2V2hC+/uZxA5G7F6BQxWW7Qa6wEzC9sYln0L/61BmDfJ+0q7w9V4mU99GVnzJ/VT7A9IChhlfrD8bhbGvj1c1lLkNYzm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWvvf/1df3q4Jn0CtYDj7f33ZpN9MYPbMWPErDhPdoxeIVURgvl84ggouYT8?=
 =?us-ascii?Q?PUApicE48/xOBIs6+BhZ5pwwxlPN14CSR4b4bM2+UMhEISN22fNanQKcGFx3?=
 =?us-ascii?Q?PbBOGQGZ+iUt1WaoPpJyoKr/GKwV7Ja8IrAqOS94rtn6seIovthTCik9IPzG?=
 =?us-ascii?Q?FJgbVhYFQLEsDWtTZ+CpGx9eRHzfHX+IWjUnpQJxwPcA1LNkl3hz8OJqEmR2?=
 =?us-ascii?Q?16BjOYvsjr3X6yZxAWlPmovJTHdp9lbVn3outDIzFvPNfj8KPYeotMpaNhKd?=
 =?us-ascii?Q?4qshg2DYCsOPU/iKbnf877aYrWYPSGjW+RFaCY4Vg4D5T8xFhvAFX++QE2iw?=
 =?us-ascii?Q?S9DkXW2qhX1gHNgSaq1GqRgbA51286uO8bzgiIoNZNdbx3gClyze2YswOJLT?=
 =?us-ascii?Q?G7Vq62wHGGVkHvn5adhJYFwl1U6FFy7NWxXv2uBtxK390IDvNnBlYGjtp52a?=
 =?us-ascii?Q?j7J/9iMtxEZNpVTCzQ0N2AsgNKLgPFF+vtBQSgRFtSs30DxytkGC94opRenS?=
 =?us-ascii?Q?v7tQ8pi0jnZ//Upuu8Mw9FJIvEVV3AGevVf0D5p68Tu91mzOLFfh5JCgc9fS?=
 =?us-ascii?Q?UiTkKXhUjKoGPeG79NWTlbS22c3bIY5ybN2oUc/9o3R+b0K4Jbvbsf8iXL7c?=
 =?us-ascii?Q?nvOwEy6N80Mq0Ra7hT11SKttwkqkOCDj42iHAms7HxTWysWhzTUDjbFN/idc?=
 =?us-ascii?Q?Vk0zMBlxNTxygSAq00O77RXZJrbA1VE7HyVdIfB/Tj56hbzVyzqfGyMUhyAV?=
 =?us-ascii?Q?SWlS9Mm6mpjDrHqrY8d5igQ6fRkSdq1A84l1sa+NDyX2Qg0izIiMQ3PRp5Uz?=
 =?us-ascii?Q?sTxT9v3HEawsPaHetGLb5q6+IjqHJ1CHcO+pEJBeKNwlG9haabY2XLyVtWur?=
 =?us-ascii?Q?cGOYpJfV8jiggxvRiu7vXtt/avikimMc19RegiIVCbevaZs8j6HiSzli/qtI?=
 =?us-ascii?Q?f9uMEdQZh6jtGf0AA9Y0HEqfGdQ7r0HX0n9XhMxaPmpjhWjHbKbZsMn1oXB4?=
 =?us-ascii?Q?UB8zXwC2INfmso2CNE1vhmfkqrYOPxwJKmMAD99VICMpDeOWtR5VJtck6sMB?=
 =?us-ascii?Q?sKu4vv2XHwLWxEAzkvXhfEEnQUG7NxA2LT5n0I3H8Rn/JO385NTe7yklcQ7+?=
 =?us-ascii?Q?g2LP/8dwYF/w+eAgyAf5uVHrJpgX48TXCJQxcU+K86q9VSdh3SnqtDECCLdG?=
 =?us-ascii?Q?p8fiE0J5VoXMygjj+mZnc7bXQ01dAnG6rOk65GHQdge3rqMAHPc1ke4+O0Y5?=
 =?us-ascii?Q?h7KCK3F2j21llQRO4txq0ChQFwcx6lUr+G4uLxcutKFx1sFE4kucNh9IiGP3?=
 =?us-ascii?Q?HaxCY2mH5Qe5nYHfUu+46QfcFX1UDFowk8ReOfnlNkxfJ/zpYYh9Bqn43Z1v?=
 =?us-ascii?Q?6dQC7XidAR6idkrSlK3YaQ6LYNubOY0LNpPX5TLRPuWZ+L4JSNE+YLllsz2/?=
 =?us-ascii?Q?pHTslqLDo7tSF+/ka0sxJ3eOaPfXnWVzZJyH87tlrJdVKJOokjB8WsVmiBup?=
 =?us-ascii?Q?hYaooruqYWGbjTw7HXimpeeUnzHuY1ohgzT7oaSDXULLfcjIbi68Q8uqhaWD?=
 =?us-ascii?Q?u0xDvbmMfKBa7rYhlPY++tccmolTAWcMKRNtnQQDkPsW+QQZGKa7qfacivFL?=
 =?us-ascii?Q?QeBHs//MTDmdVbpRXLHEZYty7lxhWnQFuZkAv+mgz1SDhRl2tja2RMScGGjZ?=
 =?us-ascii?Q?R3u31AFEr/1QRXuYzVTfGZ+5VhtlnTbauNG2SXoa7QtoWPtT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a548e3-700a-4e33-2786-08deb0fce9a4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:35:43.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euSV5+pFRXOZEJJkBLWssdVYvvzOGDn+GLdog4U/ahmBuj35m0Rh/zZFzDosofQeMY8HO5s+BKy0emAehXwAVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Rspamd-Queue-Id: 56BA45362FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:24:27PM +0200, Fernando Fernandez Mancera wrote:
> Sashiko feedback [1] is right about the DoS, that is a router that sends
> multiple 0-lft RA until it exhausts all spawn attempts, leaving temporary
> addresses disabled on the system.
> 
> About the leaked address, I do not think the feedback is right. If an ifp
> does not have any ift, it means something went wrong most likely. Either
> this address was removed manually (any RA would restore it, even with
> previous implementation) or for some reason that prefix didn't get an RA but
> we didn't try to generate one and we MUST do it.
> 
> I think we can cover it by avoiding to attempt create a new temporary
> address for a 0-lft RA, it makes sense to me. Something like this:
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 18a6f2de30ce..6c511e9c1bf5 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2654,7 +2654,7 @@ static void manage_tempaddrs(struct inet6_dev *idev,
>  	 * We don't want that to result in creating a new temporary ip address.
>  	 */
>  	if ((list_empty(&idev->tempaddr_list) || all_regen) &&
> -	    (valid_lft || prefered_lft))
> +	    (valid_lft && prefered_lft))
>  		create = true;
> 
>  	if (create && READ_ONCE(idev->cnf.use_tempaddr) > 0) {
> 
> Any thoughts?

This still leaves the case of RAs that alternate between prefered_lft >
0 and prefered_lft == 0. It will cause the kernel to create an unbounded
amount of temporary addresses.

I think that a better fix would be to reset the regeneration counter of
the newest temporary address whenever the associated public address
becomes preferred. Something like [1].

If the newest temporary address has yet to spawn a new address, then its
regeneration counter is 0 and nothing changes. However, if it was
incremented and no new address was created, then this patch will reset
its regeneration counter to reflect that. Before expiring,
addrconf_verify_rtnl() will notice that this address has yet to spawn a
new address and call ipv6_create_tempaddr().

The case of constant RAs with prefered_lft == 0 is not an issue because
we only reset the regeneration counter when prefered_lft > 0.

Alternating RAs are also not an issue because we don't call
ipv6_create_tempaddr() immediately and instead let
addrconf_verify_rtnl() handle it when the address is about to expire.

[1]
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..d550524f4266 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2595,8 +2595,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
                             __u32 valid_lft, __u32 prefered_lft,
                             bool create, unsigned long now)
 {
+       struct inet6_ifaddr *ift, *newest_ift = NULL;
+       u32 orig_prefered_lft = prefered_lft;
        u32 flags;
-       struct inet6_ifaddr *ift;
 
        read_lock_bh(&idev->lock);
        /* update all temporary addresses in the list */
@@ -2606,6 +2607,9 @@ static void manage_tempaddrs(struct inet6_dev *idev,
                if (ifp != ift->ifpub)
                        continue;
 
+               if (!newest_ift || time_after(ift->cstamp, newest_ift->cstamp))
+                       newest_ift = ift;
+
                /* RFC 4941 section 3.3:
                 * If a received option will extend the lifetime of a public
                 * address, the lifetimes of temporary addresses should
@@ -2643,6 +2647,12 @@ static void manage_tempaddrs(struct inet6_dev *idev,
                        ipv6_ifa_notify(0, ift);
        }
 
+       if (newest_ift && orig_prefered_lft > 0) {
+               spin_lock(&newest_ift->lock);
+               newest_ift->regen_count = 0;
+               spin_unlock(&newest_ift->lock);
+       }
+
        /* Also create a temporary address if it's enabled but no temporary
         * address currently exists.
         * However, we get called with valid_lft == 0, prefered_lft == 0, create == false

