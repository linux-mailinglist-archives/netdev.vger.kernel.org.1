Return-Path: <netdev+bounces-297956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E78FLW9VKmo+ngMAu9opvQ
	(envelope-from <netdev+bounces-297956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E166F051
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=eJmbTjaW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24F8303CEB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335A635E1D5;
	Thu, 11 Jun 2026 06:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F758360ED0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:27:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159277; cv=fail; b=uLg0UkLsNt9OX+Ut+DSDpgQotphXTewgVM4RRJkwYWmK893DjA2IEEh9XYwP0alCp+8Osv3GUptLMpYdVgYdsymqdczgfLIHAKPeb/NYXrHYyMth9ic8h3TMT0/TIvs6F3ImvA/HApy9NpmLK+oes0F2vNj3FQkdcS5DUlcl5iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159277; c=relaxed/simple;
	bh=ja3u3WtJoJNHR49zyRyX1dhuN2T08C2QQK8ERL8ovTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=daJ6HjH3QekHx2GV0bfV/ZkEwx0/Vp5A2TCvaNMiccg4/JsYt7TghnCSE9VMsXZ8/fZ2Fuj1874k4ONO3uUEVX8a0BOi22K0dNEG9/KxZtZ+eR2N3VhqCtZhvvzRUwq3i7v73voSEBP83QoT1mracp/4f7fu9Y2eLdm1C91Rc00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJmbTjaW; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8fPBzhmBDJUBdBoL/0EKlo/R1aIuNWXP+nxcRcW07v/s4hCiFXpuJzCNkiu+tRa5YgZH/xPW4Q3N9/HFVNwIsbC+xcfgC+wnaHPWQXCy0Ed3WGXWLMs+8045mw7nbep2EdlO9uJlIZxw6ZzQhpGQ09+93oTotKrJzZi5v9Rrb+rEj1e/dvdJKTnoye5G1pfzNv/K3V2SLV4NO+TDR9WteK7vhE4upFBrcY/TI919QgK9LsB6Dd+cxY3QOxeCcczMwLW1kqya/ADQ9lwxuQQrAWN4qbUIxnuQZOsIAOF9nPrBV1GYyqufr8zMo+//lCvNkgjnX5Z+1UAQIgSCT/rLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSfmcuqij8IA5W6oKT/B1aKMlHN5PKcERwOcaOCHteU=;
 b=c1yGMA0t2YCZPQvafGs78DDbCMkDAVbBVX/UXFebxnnKtQRw3SrSMK+xHDvzFVKdgNbWvOfdeSrkmqHtZiUlhBMA0KuTPFJMKXlIX0uWas2MOMMJfWAlMy7o5vAmSVs6YIu96kZOz7mPlPfUBx15c9/oiwB6/kpWwN9ZQ/zMVxAegnlE1UksMPjKzWa15I/x8lAWL6DeSx1fwzH+8ahOluDu9piGidluPc1jYVnV2I6hCHqsgSEetqA3IX4XArfETmLcwrHMiuF1OxYAU0Q2uluB03uhq7SDupPe3Q1Gl6w9fvu4LIhy2Osc4LyuP3UDtUqawTY8J2mf14FPMf8ZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSfmcuqij8IA5W6oKT/B1aKMlHN5PKcERwOcaOCHteU=;
 b=eJmbTjaW851oKLTd/VD2yHsgC6lpS9gGuQSGxV6IQHtKYp530fDSM/3jNm29kchPOdjg62ho8Mm95A52AjGgA4jnruai+lKiqXjrPNzJQpUALsyfKG0U0USwObxAa2Oy0tRIbo9fpTzJmO+Np+40RhzIZwzMJOg/SvX66MoF+3BWBdLUtN+Sp8GoM3YpHDkKQPcTVp0MyQp/rX7QE95IOiPFpPlkYbUsJF0tI6OL1dnimTZC6j56QjBh9pJbfJe4WgpMgKkKYNaKsXyB0msqDY9dvNScO9ogDctA87xscQeG1SCcFQezWsVojal4/AqyxjAEHarQI3SCRGjnZc1gsg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 06:27:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 06:27:49 +0000
Date: Thu, 11 Jun 2026 09:27:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err()
 and ip6erspan_tunnel_xmit()
Message-ID: <20260611062739.GC836457@shredder>
References: <20260609091337.2672441-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609091337.2672441-1-edumazet@google.com>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a35315b-292a-4e1d-bd8f-08dec7828f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EqDfetqosXvP9eq9g3Cn65GFjYr3GBiGLccSdEgpLebQyr4XJmzGsx0nybiI5cWJNmVOeQm3UaeDm1HXtb8Fqu2L6NRniBtkzK88j3cXyv+jmyqPpMWaFAEB60nTGDenwPnBH4d2WWuTEkdIy2vsH8AxVWhr7DJ4sV2iT67Js4JmNV2TMMF8+3bikeYDbj6tnVGPt/6GHN5QCAgmhbHWhjf1B/n88Gux792mU/dWUnUL4gMXVM1hj+7nivIcj5pMSuU80FES1mnHA1QIt81bCGjObSnPUHbUHXo1MB3E/MyL2n+KZmKGS+CU5108Lz9VrwgsG6/XjqrgcrouAP/c9l8hjuyRCQWRmrANYfPFmytBHQiQZAeplLrRNWd53uNLj4MJ5gveA5xZmEc1Hslgk/WC3AZvQ3k+YKTssQj/QGjqBLuB9v7/NclLfVE02GOS/VFcI9IkXxDoZMDPxwZrOIx08mDgVg6PB8UzNpmpaUCxpoiKU4Pvdur+N/bbJowcxWuaC8/tok6vDMAFEtOnnL6AOcm+c23qD+oTR/jmK9sKwBcGy2tqeHjDlIXaxvrbAaDBA3f+WWoX5qepdHDDZG3IVnMlG0JXybznnMuMiX8b/ESFKSygUwo5PZ/gqED04/pi2K95Qp8xoRFwuwU74cd42BxG5vPiE8QPMGKTD0zRr/Z+OqDsiN9HBsK81Npj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cl56jPYY2+IbGU/1PpTb2RMS+/0nbuvAIIYrDhL94VRc8xbBxz2Va2meS9WE?=
 =?us-ascii?Q?MZw+2FlxrZH2H8XMA+owqUGKeY1Z0uTkS+k8+pWyUBgmt6ciPpSlPKmPy4N+?=
 =?us-ascii?Q?mYohhTdqZ+OTKVnA5WB9dwgluOx+IJH15mC7EZfnHmcSXuHVBw3V10l2vF+J?=
 =?us-ascii?Q?aPjbjcNcK0sqw2lggoovcyao2mralc6ertqkTQkVK45NtdKSP7O4Sbh+nfup?=
 =?us-ascii?Q?0UycFHYRgNcP4wnDvwbKTWWhKYoO3o1/vg3B+6cuQjjphpoPxLNHxTRcWjcG?=
 =?us-ascii?Q?jaPvFgc0g+sIaYsRKBm79TqWUW8o8q3S09lboF0V+M41gxZ5zRe9pxuXdn/n?=
 =?us-ascii?Q?eWfz1rJFON+MG6ixtPAgQuHAKW/KUuq6jxZC/ajKbVrQ3JyOBc890dlAbtrt?=
 =?us-ascii?Q?A4zIAfnZQ479SV3DfuRGPgy4ZaydQ38YmO6hqugvD8MdVrGtLnzIm2jHTimj?=
 =?us-ascii?Q?Qel4uL01ZFXN74lSFF40TI43cc++h8scoyo9ihIlek8fcRIOOpVJN+RpXMNb?=
 =?us-ascii?Q?+f7WUQ0fQ6ugkJTRE0NzJieCo8SzFwqOrH5Im4+pUJLbiZKELLijCehI4xj4?=
 =?us-ascii?Q?gHygrrEgOAudC7svIxGvb4Y6Ev1/FeUjrmpPzpEnHDaoa23Juzv1wNZgZt8q?=
 =?us-ascii?Q?KmQCrvtQaz4lyWMr3cDLUYwa5TBSiwokXUk1y7ZBx6uRtiiD47dnSIzagloA?=
 =?us-ascii?Q?dRciRtgqYpNbf7GVjSM4bE7RbjGbkUe0MLx1X0x2zY9Mne72egjOlz4gGOd8?=
 =?us-ascii?Q?FZAzALRNcvgEUamtmKvdk6CCPW8xnfWudpOlDZN9teKgLCnKuniUGHoO4HuY?=
 =?us-ascii?Q?ZzBR9tL95RqsovbOttdINBx9oZU+2/ClK0p6yFGdWkSds5Grsh7N3fPlm7ob?=
 =?us-ascii?Q?4bduQMI8cPwjflk/tM5zWenjAq+E30DopcMFc7rPbkSHXGRAY0PuTeUFcJcs?=
 =?us-ascii?Q?CZX3t0gOm6tnDyHMuTBcalyZ3CV3I83JYbjd+EPDEiKjoYtXFFkYk0535v9h?=
 =?us-ascii?Q?2nfa/y0xXYuBT2kWi7c+qK/1ZQyT144RXu6CgGXylmeiIo5G1PlyJ7IznjHt?=
 =?us-ascii?Q?xd1lMqBD2b3GW96c85re3C/ViK8jeTaIG9Wkn5oasw4nO/F+7u2S8cU1iBQB?=
 =?us-ascii?Q?OomcwPs53SQycvqgxCATtcvsY0I+ZsGEcKxGaTGGEZKo0Mlfckx0i1fSflVz?=
 =?us-ascii?Q?686Gs2fgiXdiGag1ObIN08Y5mfNRxscfedK6xexmP1kvxXCZ0VE0PSOZ9WQj?=
 =?us-ascii?Q?0nxPfzCsGsQ3ftxltErOUZzzDdVRVp1lCZQENlKiTi6wzbekSoHcb3VWp3Kb?=
 =?us-ascii?Q?aAynuMFKsXHmWKpoLRrKUU9NGtoxy45jnbIGBaGhUBo410ACM7tJ33gSgwZX?=
 =?us-ascii?Q?1r3SR+TIrAmOErh3FdhsYd1Z8F93fCd+8E7llEZjX34ATQgbDVm4j/jNOY7w?=
 =?us-ascii?Q?8K4LtranJCpzpsk3dXUnSRBUTUoRYdivEUCZ8FZ0mSac9h0whkDSMNc/2wYx?=
 =?us-ascii?Q?hnTnq2Ol+4+460v21Ge+FZNNeai9e1Z5P88v5ZsyMfT7C0ojtPnkijrxN/ay?=
 =?us-ascii?Q?YhrE5IDwfKMa9olq7SfvjukB+kZ+mO2RElZuE2MZX07veJuJAQP3PUAp3hpB?=
 =?us-ascii?Q?w72j2yY0MRXlmngB/nz6Uph/QVSzQke04wmI/Dlw3UyaMc+E9WkCQZktPzZG?=
 =?us-ascii?Q?vgNGTAugZn9j7YB3KpWPb+/8Li5j4nYDblCIEEbhR2LckNmI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a35315b-292a-4e1d-bd8f-08dec7828f4e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:27:49.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCA6TGPGgu24B2jqcsRtAK/+4s37wDZYTZRldNjPAl9ZjF7XckG7eD/PCEOOR75QLbfOmb7uNvX0mucxV8lAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297956-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shredder:mid,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 255E166F051

On Tue, Jun 09, 2026 at 09:13:37AM +0000, Eric Dumazet wrote:
> This is a minor performance / conceptual fix.
> 
> 1) ip6erspan_tunnel_xmit()
> 
>   ERSPAN tunnel can mirror both IPv4 and IPv6 traffic, skb
>   (the packet being mirrored) can be an IPv4 packet,
>   and thus dst can be an IPv4 destination entry
> 
>   Use dst_mtu() which contains generic logic for both families.
> 
> 2) ip4ip6_err()
> 
>   skb2 has been prepared as an IPv4 packet, and its destination
>   is an IPv4 route.
> 
>   dst6_mtu() is optimized for IPv6 destinations and uses INDIRECT_CALL_1
>   to call ip6_mtu() directly if the ops match.
> 
>   We should use dst4_mtu() instead.
> 
> Fixes: b40f0130a23b ("ipv6: use dst6_mtu() instead of dst_mtu()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

