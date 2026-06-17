Return-Path: <netdev+bounces-300057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JqBeO+1LMmo9yQUAu9opvQ
	(envelope-from <netdev+bounces-300057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00A6972B0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:25:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OJ09ze59;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7923033D23
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B093BB670;
	Wed, 17 Jun 2026 07:25:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553B3BBFC4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:25:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681129; cv=fail; b=OgkRacGMhJwi5+/wfCIkmD/F7ZLGX04P4MwB3erFR4JMiII1vcDCRgwFjMxFrkvpWx/IpYiHi4GCSpqMnVFNG3v0IcHj2vIhkj/hIM6EsMEqtgyugv/rJAPu1UFK6yg7fCdR1If8lgEecdhbpZjFTwXUGPHqPRLxwxUnk4EqAT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681129; c=relaxed/simple;
	bh=WpFdYiU2rlpTF4rjv6G+wfF0tFrHO+m4ugG9mXlqHZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YdXSpVMpSNOI7I61m2J94SW7x/WH/OMQjxr8wVRkjXrLjI4wDmXnHyDLGsl6dcSnD8tKdIaqC5u5i5g8bHQO8L/mMU3vOUKlJ0VPGkoHO/N450bcLxXhAvTwjbT6qanpFt1z/2BpYjckJqgTaeGj/wPrrbnJZpzMip0XVXGCz6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJ09ze59; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbdsQ6U41ZUzvfEN70wrDViTPx3OHicVbJJppU6d6QTTFv1W22Log8yGSza6HCV+7GGIhrAgh3OemDCJ1lGXZjoC9ONIiCQXyAGQ6iMa8Uyhr+n7jq4P80jRn4AZUT5+WIxTqNNgF3UCo9k8tbkAKZFNvzfDoHJD56QPaJorS77UeULGiHfIFYg1mY3V84XAoa/4xDcI3jNrl65ibK++1wnNhOQ/MPZqVF/MI2XsByEEzSfZppAoMPpdORmhDRgBBT4kSwrrSraWdQ6vPY/qEJdNTBkv3WcGd9bzhGdvdZMP92ZER2s3IwsT3GyH5qpshRWr88mTLJ91Z1qXTUXBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT9wkPkyY740T1cDvOXr5ON5vo3BCvHxdMK41SorBZw=;
 b=NiPJAwv3HeKpQOl3pwo/oYgJeolMu7r74efA9wBOqN6T+KC8lxPbxUAUWb1eJim0F5vxpAMuUI93NfdHi6dVES/Hy/M7bmpdYqlSVB5GSNeZKoUcbpzF9IyNliPS21T+qbn7rMNjfP17TSr/esO7gDDh90hqL1onHv/OetvDNAyG2vNToCFq9lmlWFntmFE2h4UW7JVjd+hd5ez3dz/VB+cUHq4WY/NsjAond1lxO9bljx43hkFaCln+aTjKe0WinUSwXCSe/cMbAFZnxfvkzv1o75hEyWCAxeaKOYLnd2psd4mHXpUAiCQ+xkzUW0GcVyfpznoOZFPsQJcOfsxDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT9wkPkyY740T1cDvOXr5ON5vo3BCvHxdMK41SorBZw=;
 b=OJ09ze5945UXRpHahkwdOL31moLpXmKSniIr/oXfTjzcjlA4THg25xrhGTWszmKDbl/1w7HSY9qZOQJKnwVm75Ndo4cc9qncJ/hQ77Wp7Ij+JrKKTF5pp132QK7SYH727ZC+1a6vXS7ubqW6sCpnxC5Rwb/u1+VSXPlDKeEKKuBDGwES5JD4RcZj+ehCFny5gGl5L8kXcHNVgdV3wzvl4y1s+Y6cSCfeNqm8OocFIM8PA8LIgt6rVql3jAomkpux9KAn6+7JDO6axsQNHGVOLIzI/uQhBKyr1SPoihzICN14CP1ncLwOIfXVZp6szikxsmd31vaoA6R6Az47/9LrEg==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 07:25:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 07:25:24 +0000
Date: Wed, 17 Jun 2026 10:25:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>
Subject: Re: [TEST] vlan-bridge-binding-sh flaky
Message-ID: <20260617072514.GA972552@shredder>
References: <20260616092733.3a31be4d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616092733.3a31be4d@kernel.org>
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ef96e9-f97c-4569-47f3-08decc419879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lw72QatD3P1WGwMajDfE31nHeuVlbqKk5cOqstwZnDmhwYl5wfMfT45KsKZPAymBmkR12rI4kopS52ojl2Xgk2d2y/+r0CgVhykifd5dXwtzceIDHuYwqBAnUnP44gkWR9y+lLGIcV8lam08ehD68Ds9gmn1Kz/w5mvLoDQaCs86UF48Nvo4oacuG9ZrVR6gcFsUWZx6KGtpru28+9uYcFXYp4pm8CE5WUmofOZMM5eLb8XjUkdDNUqSBk9uqhMyAQuFJ7VYv4PRxkhz6SWwZSgUMFd8kPCR+0NH5tQEVjIZBdDwS+Neh9zKyN5YTGsiRvnxa0tPWuPZamjBvbNt81Xb0gmo2B8bLx5jcCRoarEvgo/+2M5HqjbG8QAieGTiUSt/liEYYA98FQ9+RZXwhNC6edpkudvCv54DQghEQcQAphf9/M8RMmZAygGHBpLMOt+Xt0YvBCHlAvCxHnGXXryQf30CP5EJ7kaR3VIcciMPnHVTzZMKjzMBlZwYR7oCNXfD5J+4CyhYZ5lskYiGPqOXVWFNa8LKYDradnXrs8TMUsd0cJA561qhj3+gqEEpgmp4ZPNb3nEIADaFRqsBfwB4vF5MRtCTey3cvuZwGHqmZNHurlCrYhd9wT0rm1X2awMHK8abphaaJglC9yE9vepkNDqNCjZJPZYhd33m0l+ydNZKHtWQ9kjoK+Bf270V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fPnP12DfemjQ6iZyTm5cgXWIIll/fV9YZLz1dylqczUW2ronAt4ufYPlQX6?=
 =?us-ascii?Q?WkR2U+0XtQhy3wWxUZpy70kb4PSQeljyELN7dCVQSiKuSQLVslaiDSMgjqVa?=
 =?us-ascii?Q?LsXqURvqD48i5dpIt0zEOXoVd8t43ECE3TilrDIWFIGNXBbRuDrB+2YfkIXy?=
 =?us-ascii?Q?XF0TtXfXK/upKERYgjqr8lxjGC5uMPP32dPCK7dWC1RgAmbJfuWZZGM7KO/m?=
 =?us-ascii?Q?KCtPkEcbDnqMytfQeQStXb2SjYeIzY3YUrq+yybuqtbJRX2h35ZFhmzr5hwH?=
 =?us-ascii?Q?JHkzmd3AFF2BmwZpxkevNIngAkLzWnUXx92d7xpzZ9Xbi/mDfJR0knGzTm6V?=
 =?us-ascii?Q?lOwJDnNX+pxo/QHejIcvmoDTlhsJ1TgMPXLD4WzmT4zo4ruKAZZhjZIox2j3?=
 =?us-ascii?Q?70dyC1L8xycWTwtvR3B8Amq6QpP6S6bKk9/st6DYZ/qG4iu+C1V8xgGvOz5j?=
 =?us-ascii?Q?PDvdDBuckJDVI/qHFUVjQRtFLVdh+hGg3GLw9V9u35Dbl+8tr104pbP6IJdx?=
 =?us-ascii?Q?2AxciNgGIE4fIHBYE43oxFX/1vXQ+MAimQBrjMRO0NwTTr0N6mpMf8cwJveT?=
 =?us-ascii?Q?g3YPt1/flG6/LDGKTFn4+k7PA1bKLP8PgtPZhta9UOQFJad9DwxjpipAYzOB?=
 =?us-ascii?Q?bpUqxB2R49KU3fYqDUp96eEBytcX1Nb0M6lwF+5IbXXRMyfra3Xlf4LTldKd?=
 =?us-ascii?Q?Gmt24rp+6+/fgPcgNNDK1iXw6e0B3Y+IaWA0W5BLTkuGx5gs5OU9mFMQrAby?=
 =?us-ascii?Q?hvPRVrHoqgoMTAADvblYheeIuMRF62+CzESSqXoMkPLatx+Ftqh88UE0j9pV?=
 =?us-ascii?Q?VvKKg0GZ14096Yi/5oxwo6jR/0XtDNiQ+3OCaeult4eZ0uPNzc4qrSjR3JlL?=
 =?us-ascii?Q?6//r8Jns1/h4WKQxE1AjCyKNgVwqDQEI/kbwpvtDWGtEu42Fm/taMrv0+Q83?=
 =?us-ascii?Q?wD3jn1D2BALgDAKpjbkUBgYPBXT3kJmihH0POGjYPyV3fKTfdN15J0GZfH7A?=
 =?us-ascii?Q?E8sedqa54otSVAuOUZyu9vB0y+AbLhZK3hb6PCpDcfw0q4fJk+6uYcGDif/j?=
 =?us-ascii?Q?hsx1Px01RYmIF2z4odepGEsCmZnyI7j7bQZzYl70WvoPtB6shki/3zLpieqX?=
 =?us-ascii?Q?wguIdt6a+G/wN8tdEIkIzNmfMQvIFFm4QEgKB6+TkW5CYuwqomdmaBEBDfQm?=
 =?us-ascii?Q?436IDwXsyNpuzn4bgayNM/EY2qfIFuS7O3RXggfpZ2kgI1IQuHbsm4kwoIjW?=
 =?us-ascii?Q?HzpRj/7tUJHVhEmOl5V3DEOMbpefMLWwNQdRJUBBnphGGbPQ8HaJnQSd1q24?=
 =?us-ascii?Q?xRlnk6kGVFwCx/WMIOMp5cwp0+PoNW6Vb9W//78sBvEsbhreB7D7Razoywaq?=
 =?us-ascii?Q?fBfMBHqYGvhJ9ywGPUYR+LmcN9Bxl6DSDvTJ2J/6zmx6rd+RkUpttUWIYUQf?=
 =?us-ascii?Q?FSDn0emJS3sba/3MJiQihzH0l3No1+tt/7AEQFIwYnLF3XUcofO1I/V02LgQ?=
 =?us-ascii?Q?SA00Fke00NmLKhupVvZQjvAKwn1jgG8bpCu4XsY01zWYr0fWMcj+f5YaLCfA?=
 =?us-ascii?Q?cJ67F48DvHNRUazB5yY3xjDD9wbGGnEEOXL+/FslFsA8C5BBhR+tWT9HmXLk?=
 =?us-ascii?Q?7tFjclBoNkXJm1MKktr++29VmMsSggS1a0xieXlv1eK08reiwkCdCETJFrpB?=
 =?us-ascii?Q?lTnBIlxtUe9wE8OE8Z0EGMF7Zv2rNchDnt0jImErNJMtoJOd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ef96e9-f97c-4569-47f3-08decc419879
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:25:23.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMdC7nHstEP4BnGngyCREmFlx1g86Aqpp/VsXsCcsvOZmZ9TXh0eMZ3qNbRvfIi/GKjrjHAuaE08WDSNNLt1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300057-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:petrm@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B00A6972B0

On Tue, Jun 16, 2026 at 09:27:33AM -0700, Jakub Kicinski wrote:
> Hi Ido!
> 
> tools/testing/selftests/net/vlan_bridge_binding.sh got flaky recently.
> 
> https://netdev.bots.linux.dev/contest.html?test=vlan-bridge-binding-sh
> 
> Is it due to Eric's change or something else? Used to be pretty solid.
> First lake a week ago and 8 more since, before that for 3 weeks there
> were 0 flakes.

The failure reason is the same across all the test runs: Observing an UP
operational state instead of DOWN. I believe that's because link watch
can delay carrier loss events by up to 1 second and that's the timeout
the test is using.

I increased the timeout to 2 seconds and didn't observe a failure in
over 100 iterations. Previously it failed after 48 iterations.

I will send a patch.

