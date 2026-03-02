Return-Path: <netdev+bounces-262613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILeEMMpvpWlXAgYAu9opvQ
	(envelope-from <netdev+bounces-262613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:08:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3381D735B
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB6F83004DB2
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BF35AC16;
	Mon,  2 Mar 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxvr5OBz"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D3355F56
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449733; cv=fail; b=WK9i9BeaiMnH/cNMRGeosPJNBkwcOpgg0QHlmGfbY3PPEcqOYqRh5bfMv+yuJC+rB301PGrVBmrdV061LO5zy9rWYp2FGV1ziJT3lxnFkXkIv72iEcfHp3bKB9bpN9J5P4EGZ7sZOnbO7M8ZaL2ecz8H1pjEyny8JJ7zsRRg3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449733; c=relaxed/simple;
	bh=uEZRksU1h0TTz3dozw6wOyjg0wt4yyhqlkJgygo/3o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCL8WzAxSnvzKD6UjJnLnXy/gBKUnJtM9WNRvDqvwXrHrcfYgnCN4coh6yzR6CYDBfqCRNbIQdc3HKau/mLiHKv4XHNOt7aUQwEZwJhKd1MoGJoh4pjJSvK+jjTop/qap6Qlld8JenDaSS7cZVSG391tKOHeKE2WjcfbAhYkSzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxvr5OBz; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCvdeh93bteu5NqRvVP8w1T7OOy2ckeVhOe1Nhm7CUVJbRT8U0Ko6gPfWxsQK8yI7wNyC+DdwRHnv1U8PeuKccgGE3nHLZZAGjUOsrE6foI88aYmr6eQ1jWB0R5x4BcErE/hZZn+5elMDH2PAY9JfELXEQOrirmT/LUTuIiCoZilR1XI2Sksmqu1XNbGba5Q4/tcc68/vrJuc4ZyPxImE3m2shad2XjwpoahU7WfEZ1aGbF10kpU2zju650LA8aBt7aVD7mPVBDLFtBdaex8pLoZe3svRn8MyzlTFYp9zS5Bhou5bG1JIRcXAQ/vk1dC6nt8mcqG8QFzeQH1c3610Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klAPqytZy51XvibB410Yfz/MaeqU0MWMb8nw0lVxg+o=;
 b=opgdL3xHwBePCYgBct5EDFkpW1BvUr8t5ArcnTA76sPbIQeRfXdvFkCc5JcSOYar/Jpg2ysr70mQCWqTMka63wIA7s+Wj8q6Oq1mM4XrRnQj38YDXllJ3gIcccyPq9VpeFrLNHbTy62VHYJRLrcT+oYm/1YfJjde2f/ylzPFh9uEvJ3AjOU6TBYoa0G5sxQ48bL0NMXngqBBC730o9kXrPKMRsh8xDT43xbS4GUI7dplHQ1Gn5L+N1XeESw0pknEEh5doFarM8eVlZ/sAR8XBi3jTsEIPOg6QLD8RRmwopPHc0ZAmFR5X14nL9NyHukjA7npK0aZzVk+0H3VtvyVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klAPqytZy51XvibB410Yfz/MaeqU0MWMb8nw0lVxg+o=;
 b=qxvr5OBzlMiQge8YWFk+wLURx6F1Exww1nDeZsdIXRmyUAYQNjgygxHWLtYTSL34bleIPTgSjakjEy7GmQ+rN/DJvKdl12bIHGrK+4zxnJF75Hw1mRwkl5UIfil/+Z1Sl35IZKobx9tsdg3JlefkWUQexpbMHh9yjiM1SxzduZi52t1JtYM4KVZvhIGImVLUIcX8gB5VyOLhvn+c0bfj5AFCNU/6XXud6ByJJi4D2EIZEaYWxgA5sFn+rqd2D0Nwzb1M6o+RBASDp1qphsbFt04bbguMEZJvGnRpuYp7nothk/pV63xDmCJR3Oy4NKYxAkl7kkXJx3/mmcLoVVejzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 11:08:48 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 11:08:48 +0000
Date: Mon, 2 Mar 2026 13:08:38 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, roopa@cumulusnetworks.com, horms@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	razor@blackwall.org
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6
 is disabled
Message-ID: <20260302110838.GA875420@shredder>
References: <20260226234059.19402-1-fmancera@suse.de>
 <20260228123057.14050980@kernel.org>
 <a09581fb-a3ad-4c0b-aa60-f16a75779756@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09581fb-a3ad-4c0b-aa60-f16a75779756@suse.de>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 01597252-3263-400e-9ff5-08de784c13ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	q2wjj0fwjHMYr8w/vduF08xJk/y5dQYLry6b59LBBF/T8HQr25UZzcO1HJ4hwlu/yj9UEnLFe/a3Oz69q+3ygMvSf93KhBACN/YED2pyZ/Ep574wSPjfKzaM6Onf0os9tXhU9I92lTit1t30uGyvLLdwsMbRiYtnJRcUCNXUi/flimL5Zef3NtEtGxLxo0TV/2Q+WNv02XrqUMGAmNzJzPTWpWWs/v1bTF9suyeWM3v9Q0j/Op4Gq+1V/aOqz4kFGrqY5tdwHvbHS2mVsiwHLCfjkj0IQokDlGGOeRlDvBp0W81wBazcBOwh77EgihsSvhN+i6PyUwP4YWIRxngutNDwV6zhsf8N7kSLPQKYLkoufiXMaav68hQRfnj5njl4mg99eL9z+aNwPnVMGNuIynZhaXM5gTLlsL1+8u1NcJnkKDzceMhZOS7Cs/sFarv2eI0/u76bekL4kwGlIEB8BASB0OprQhyN5O9dg/tAVj0wRDs4ktok3Vs9QeXeihVQH3cOj8wbYCoLiO8EQSpD7mD2XZYg0soJ+TF5nqA9CzOidOBKFb/zbM7BRv6Eaa8KO3dtou47z4+kNL51tmIDQnSd0a+QVBkJHYICm8nfZFfvaXRKSlg7vo6CANZXK0qHWvliggxgND+MKWWU5GCkbjW1DT0h1QyjkdkfxR6PL7F01zY8cyb5A14vjtGGIf81AfI568Tu1PSTirJp+tHaYPn1CzEiGtGC5skidTbEULk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXDHYZlH6q7kzlkOTu6relGc13/USnijSzXBwgx6H5UmKUOhGsrYyM6Ih3WV?=
 =?us-ascii?Q?cF+Vlv1ea4HI+Kl9EYBGUSIU0S4cBErzyTQoMDuP9hTgwMtpxO5PPJ8u7IKj?=
 =?us-ascii?Q?xE2gO5WJjx7C9WicNDuxeuetZPkyEYIiCGPoBH1G09TQYfJYj4y5ZpHPw30Q?=
 =?us-ascii?Q?DAYRaPl/SMIMahrMPL+iyJ767J1xQkIUFEt7K1rbBKeMp12dLWtvhpWLskcP?=
 =?us-ascii?Q?hp7UPSD8rNNgrNzBG8l2IGXYyerpvNw+foEvdsCsq8W9+3oMXpRytXH8TcWY?=
 =?us-ascii?Q?XkbNSgT30WOpnZHzvlLOgh788G63H3M9Hnw/nRnB6pwwAlWym9XdCnC0fv9p?=
 =?us-ascii?Q?0m9QqNssPFb17hw0pCytvlqhwEp1+8HWsXS+UxjBxMAp3yIpb3x6veSppmuE?=
 =?us-ascii?Q?TfaCcqIbcEQaRFZxAOD+INL5MPvFOAmMJ6uZRUaJcWk/DC4zlPSe7rBMXwJt?=
 =?us-ascii?Q?mmi+9vG34ARReBP1ynpaYJfFir43cvpoEMdxPnwyCGA9fMgqwbs2kx3am9uq?=
 =?us-ascii?Q?eF+8xEkufdbnvAgNNR08wBlPOTWlz7yB3tq0I7ev8XLDE9S3QO5tEfui2z1O?=
 =?us-ascii?Q?+vYgGoWOL/kOGQztrjxB/lYq89oE++BsHDW4BZ3hcOvBVTyBgGAQZNujabZE?=
 =?us-ascii?Q?UYeqO9Gg0DEexCxz7Zf2Wj/sPA7+kmYSLK3DbN0T3bw/ASlslOYB7xv46Bm6?=
 =?us-ascii?Q?QbmIxA1PMG8qhny/gbMWrw+YJ65LH1ZfMpBsIbJhv+RFpv+yMQS1PBD7qAA9?=
 =?us-ascii?Q?tGAcLcMiL2IRwOzd6S4ao7j0c3gqhTlSKz72Wswhf2SpskZ0/6YrXmkToacg?=
 =?us-ascii?Q?BiK/aVozwWA7a/y/KdTTWDZEH/Mrq6e1L9p3V9lwc2FmfMth1/i3uJ1xtcCb?=
 =?us-ascii?Q?kruu2Sh0RFy137BImGvYyZM7Q43bqOx6r9Vj0BkQVkY8Jc5Msn8Z1KA5aKYa?=
 =?us-ascii?Q?YdLMW+rsWHqiokfd2ilCDbrxhPlH2N9UzElCeGd8UGvghetrnuxmcYkWd9jd?=
 =?us-ascii?Q?/C06h7nS4qyJV+dWYP0XzlH5rhzz/9y5JibllZJTE1YaQh7HJgw/quTKrhEc?=
 =?us-ascii?Q?Ax1BwAY6Zai+2mhyIIRUCyMcWnlaG2Rm5/gvR7jyusauRCLBXszzE0amfq1h?=
 =?us-ascii?Q?+OrejH/rYqG/emnTwbCg9nobnpyVVDZP1tEYUycE6YolrYaXw5uc2e1PhXP4?=
 =?us-ascii?Q?IrkQrYTRly0PPolvvi2WLMwWgaotkqAo3E/CTTuCYchAnORv6FV5yufoWnx9?=
 =?us-ascii?Q?+n79/hiGuvn0Uj5m7DJVrrM4xGos5OGaUWW6gQypIZtLYaBpfxN8qX58zKow?=
 =?us-ascii?Q?DU8ju58Ewko3P019K+HEfODoV79mmAonUfLnjxNuqRklzoLrCVxz20SP6XqS?=
 =?us-ascii?Q?qfJb7od6cJWMHhsmKRNrt/egzIzqem4F5Ej+W5ubJk7BtvDwWZes54yo5H/H?=
 =?us-ascii?Q?noZDSnUG3K8Apsl0iReh0/akR/PLK7jXWKknLNwrLcIFpnsnkD8CzqGxG3Ag?=
 =?us-ascii?Q?D7aZkkFc6HTj3/f4KSGoW9UseDFXx2W1LPyH64OUQVk2oZq+KwHSQ7jMSCVD?=
 =?us-ascii?Q?Nlv/mOPJYZx3fHDi7rT6F60vaPmV039SkMNab+hJEFvF2/XjFvAdJqcCJbWd?=
 =?us-ascii?Q?0ARfBXzd9DxHUNw0UBNwcRQr66scG+j9xLvn2XhiZMLs8AonuseqHAxs0EOO?=
 =?us-ascii?Q?MhAYGQy7mAZIS+nYsfW56YguLg8RpHL5VXDnaC1kE+gfCg5ET5SdQIWjR/pP?=
 =?us-ascii?Q?El0kOy/PvQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01597252-3263-400e-9ff5-08de784c13ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 11:08:48.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckj9/0njdHgA8kMf90uwSyz6D2zfFKjjB9sb01qbaIub66omX71fzNlpXAAstekLY7ocVaQgqqe6WU69955U8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262613-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: CA3381D735B
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 07:27:56PM +0100, Fernando Fernandez Mancera wrote:
> On 2/28/26 9:30 PM, Jakub Kicinski wrote:
> > On Fri, 27 Feb 2026 00:40:59 +0100 Fernando Fernandez Mancera wrote:
> > > Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
> > > call. If ipv6_stub->nd_tbl is NULL, return immediately.
> > 
> > The problem should probably be fixed by replacing IS_ENABLED(IPV6) in
> > the callers with ipv6_mod_enabled(), rather than randomly sprinkling
> > null checks?
> > 
> 
> I agree about using ipv6__mod_enabled() instead of the NULL check. Thanks
> for that recommendation, although I do not agree with replacing
> IS_ENABLED(IPV6) because here there is some ND message suppression that can
> be applied and at the end bridge should not be look to L3 unless necessary.
> 
> E.g NUD is still being suppressed even if ipv6 is disabled on boot.
> 
> What do you think? Thanks.

I agree with Jakub and I believe it makes sense to not do any NS/NA
suppression when IPv6 is disabled. You are right that some messages can
be suppressed when IPv6 is disabled, but:

1. We are planning to send a patch to prevent the unconditional
suppression of ARP probes (DAD NS). Pending testing.

2. There are some cases where GARP (unsolicited NA) should not be
suppressed (see RFC 9161) and we plan to add a knob to control that.

3. It's unlikely that anyone is actually relying on this behavior.
Blamed commit is from 2017 and we only got a report now.

4. Suppression that can be done without the IPv6 module being loaded can
probably be achieved using stateless egress filters.

