Return-Path: <netdev+bounces-288317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P74G2omB2oEsQIAu9opvQ
	(envelope-from <netdev+bounces-288317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F246D550E03
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B271300651E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCD480959;
	Fri, 15 May 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/UsnXo9"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332D2D3A69;
	Fri, 15 May 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852961; cv=fail; b=ZoslTi5AGKDEzPx89bXQGr//CN9V1jzJE1DYoV/1HHGYSqcmLTSFMnDm5+wh2PrKrHLDHR9vH6cHdCflLhgwVHie7kYlqtAEO7k/zlDUrc0d9Uc/dNqpNaF9T3L9RybeSK0zo1oUJnmSKP3KzPRg9m0fS9KAWpxsxIvPYl9Uc+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852961; c=relaxed/simple;
	bh=fZaxpRZtUKEsHsWf7galJBpvW5h0MWvuijiyLPhx+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q4beh2dZ51Go5oEXDAXJjiZO/9mnBWBBPOpbv1MJSu4QgJvMH6jFTDH6OOWD5yw5wp0U/lP6hidKYLcN0sgUhSC+hliGlD+Jr84ae8UuFeTyGMKXZWhKZh3Ks1vPl5ji6OqcNybtATy068AzJ2u/rQV47StQYj8bIztNE3pMKGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/UsnXo9; arc=fail smtp.client-ip=52.101.57.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzV8iDuEjpepa8QLI8wISAvKFQz31QnSbxO7t+OMC7v7BQtl8s2CdKOpHsp6XaDh7S+KYm90OTTjWaBSTN/2ncOzcYQ7mXsAYf+vImve3jVFP58/cYT9opCtw9u+xMrkM+0WCceSeX05p7JPRNzbmF/e8XHHiLviVc2ey/OUBOVoMM9XqRNaNEW62CxFkxxeIfGuYxshdyhQP1+aUOmPmXJWXLgHyGW0kPhK5DV8RM0JO5I277M7q154WiBOCbT+Mvf2zRLFaThYbnB3LANwBcbWO4u5heZu/NmIjDTU7zhiNNGckuMwljyAaFCkcjLmG5L0ZRMWnhMRGrOsK4ZQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ/LnkESQfnU4OQPtitaLoh16FMKzS9RVqt3yz4qOW8=;
 b=KDNTlwenEkVjrx+xDR2TMN3IW1+KKHXRXoKZWOXgclDiBwswqToWZ+/s9pTv1oCEUqJj7gv9NQHzamNloGwN/JR9rKWj9zBmjhf8Vx2YqY5UX4G3A8Zjts1aHOeV2bhsSwgZYOITVBpVODfG09oD4zTRydlKOs4NJX5W6cNqRQWXhKhdSUFdMxiyzuQzuueyAFNc/o4659plxdG7zw1KRPpYTv8Be7rmobpKKjO3yR/n50pkAAVv4TyhHKVkHNLIGpizSnU5cGTmfaykv4ro2OVxtkA6aWwBYzTKE0A3v5dPFcZ7ZA9Y3OPkm0j6BVP6uz8JzTBqDKUAbrpt/r1aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ/LnkESQfnU4OQPtitaLoh16FMKzS9RVqt3yz4qOW8=;
 b=J/UsnXo9sXwl5nQ3+ieS93i5sXx96qle4BbTiWwYR4iApBDsIZzyCS8O53NVn2TxtBwOZqH1PLmiQU6dVa0NRgwjkd/qzmhtQwBGhvgfbXV2VZxYsY/bDxRaKUrH0JGUPhooU59XUGMyQYGaESbB5xQDBf4TO4RITIiI5vU5+f8wEWmNj7U/BNzwVjKxgX6BwYIlJW/4eo6h6FWPAr1knBB1OWUePokKGbuT08CdqMYymZqowPyvUgNnzWi4Z1r6csSrYPy9XevuiT78Fv6KhbioucWycUnMTf3kj2KuyQIbzPBTcOF7fz32wHY7XCkrue38FTVVUPGLhhx1e+dEyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Fri, 15 May
 2026 13:49:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 13:49:16 +0000
Date: Fri, 15 May 2026 16:49:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, dsahern@kernel.org, davem@davemloft.net,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Re: [PATCH 1/2 net v4] ipv6: addrconf: fix temp address generation
 after prefix deprecation
Message-ID: <20260515134904.GA64208@shredder>
References: <20260511122645.6233-2-fmancera@suse.de>
 <3f371efe-1b1b-464c-af21-ccd66b6c5df6@suse.de>
 <20260513143533.GA415119@shredder>
 <2e046948-aa98-4159-b1c1-46368f034027@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e046948-aa98-4159-b1c1-46368f034027@suse.de>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a55c408-3242-47b3-ecbe-08deb288c0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|56012099003|4143699003|18002099003|11063799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BxMWn60Io6yhJEt99Tq/+6FKg1ar9+e1LQVhp69F2eqleTlpJspw5ZY/V5wV4eA3U+zoWxZRmMXOr61e4JcuQKqJChIpLt92KqQ800YgC4hpUGGV39uLLbO9R4bP8f+aozq8q6QFODz8QGaKOpDqtmcyjZNoo/3qMA6c6VT2CuRL7uFITJHeB6wHxqFrSzXUlXYPMDne5U4TCyJ0nvJ6kPNetEBqi/d+iesmV1pv5lr0STDlQpsxbz1nbvFk1R0WRI8BnCpo3NOjSuNZGw8k0qUR/tDatCshgo+4rTtmsNPZnPNkANyI3cLUvv/LLTMjqD04ebllaP28ORST4KKPFzeaE2gMr297Ti0jpPDqVwLBLqutkxULgY1jQ4vs76MIspIlwmrjl+ule++N+NsDfgPeBggg7N5+Frd5GGqD8s64snKBYLuvJ8p7M5xWlg2VWgFkW2kFW5Tah8dQt28H3f52G+SRHUFlrguwGg7ljF3Pd43s2Rs8nMsOemCSsg60MSUs8usQNfFco8wymyM6z9ZXMRS5PyX9MlW0dPs7340U/mXnVhU0p5A7Vu5C2bw72UMf1GINjZ/Ny1wgG2jqTOvDR7KvoYuoqbBymPVUGNPHp8gvzMhiFquca/Ysv4C/hOV5GuPGHWYvO/0RAiWD4UCGT4ib/ZH7gTNveGx+zC3J5dgjTsiyjgIvWda/3Rmh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(56012099003)(4143699003)(18002099003)(11063799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I36Fz8HYe4eEu7UNFnsfPYEqe3bCGutf294KyI+qTKk9TEbfwYA3S5J32zdX?=
 =?us-ascii?Q?ZjkJgYcCZ6BiCi7cApyBpesoq39pGDHQdmQLhGfRlHRy/sgCiC1qP16jsAZG?=
 =?us-ascii?Q?NXPy4mrPRt6ykwqqMfh0MBeZcYpnDG9KZcRMLJj5sFG3iXphA/drvfIXCtoK?=
 =?us-ascii?Q?rsQix6BpHAuvsdJWZdjNxTJAFNIf/fjGooElnkMISG/JKYfvKCNvO+zlglmz?=
 =?us-ascii?Q?w66u8Z1taft1Tnm7N5wj2iJCSo6ymjJeO6aW4haihHedROYal+JDHCTP+TMQ?=
 =?us-ascii?Q?U/lFXiLGJ5/j9O8rFZ7LE+qJHcMdvtv3gC3LHR2Pjqs317kFLJWO9vNhhDWb?=
 =?us-ascii?Q?/6vv6YZ6bVVu/eYswUpOykfQb62iLiJR1XlYIY0GwZm+EZB6elf2jDrs/c+V?=
 =?us-ascii?Q?BxQMeIRMp/qB5aCjjiVV4w9qKPZgw4AQC1W76W+YZzOOj4YBZo841A0q95x7?=
 =?us-ascii?Q?M/pAOKziufx6JEs6lJFBEb8+t+H8RLPVidjnRgePNbY/kwjKZbvtKOFELQnw?=
 =?us-ascii?Q?Jwfsx2gDvI0KJt/VchvGrJCGybJHY0SaMV0THhmXb6vepk/zu+6CE8cYHT/7?=
 =?us-ascii?Q?Aj4o80p2dmQXa7Ua5w+9dFtzkALVtHth6rnns0LlLUVXMW5pzhOzIvF7dQWs?=
 =?us-ascii?Q?qSlJvpPlG+nEwNKWka2RX3VbHugoIFoaHyDQVbbhhYphDRcDalVDiPRR58Un?=
 =?us-ascii?Q?+E8Piq/BQ5hoNAoNekUncKhKb/Il9sL9NukBwnxk4ltOl370CAlQteycJf7u?=
 =?us-ascii?Q?XW21x9XJ5zCwYqEXShfNUGE63b+tcTksjcNA4Y7U76qBsRjdWDRSdtqXn+wS?=
 =?us-ascii?Q?hHTGAXWQkyuHQjDtULU0elEa+HBwRPzJXyXBK69HEa+gwlrIc3LVva5OgVE7?=
 =?us-ascii?Q?7iDH/Dz/H/uk/sopqdKs1AbdHLSADjE0CAKLU0YZcH+bA9n7p0sJGrVlLoBU?=
 =?us-ascii?Q?jjUQUv+tgUWCWzjNJe5kNlpET+sXy804QrQ6u8yUonkiH7hTNu4UCZswECf8?=
 =?us-ascii?Q?xxonm2NuBJPnkt+INXKlJeT+LkjFxKjwvPBz0600hzIAVKJltP/dy8AX3wM5?=
 =?us-ascii?Q?9Iy/RV4BTWmd/VfkKSLihNy64DEJxpeLqU/gdEjqtblcnjo1sVHeqnXZ6Qr1?=
 =?us-ascii?Q?Vp1CvbBTWbw3Ry0siytrWwy37/9tQXI9B3IRkmIoPU1fDYLOidokKI/MolqD?=
 =?us-ascii?Q?a9WQLDNcVjs+HR1Rw4JEzaxZvOhZo7n1Lcr6Dn52BLE4bS4JrK3inrg8cTJX?=
 =?us-ascii?Q?+yk8wMxmX/NrxQLbRDWNtLc07C2uHKI5WO5evwb8EAN1eYsX/F4IXtB/jiBs?=
 =?us-ascii?Q?OgQ8lekJWjK6pVo3TP6iVXwfA8W7m3O8mz0KaGduxVWVKUmy3gGNRnNI7pDZ?=
 =?us-ascii?Q?6touMj2t+rLp6cPPq11qyn2YLEZgI2EH4YV2e/iy2KrBaDvK5H+Md9zoMBO8?=
 =?us-ascii?Q?sVrMQpJREdwyN7lSp1fIoh8W+i+PRHgYKbxAlCALsElBazYId2QVH7rUlC6k?=
 =?us-ascii?Q?brRbQ77CaHr4vb7MSpTvA9qiexvGeCoXa6mITkaWkw4uzgQZ8/QWL8Q2bJgc?=
 =?us-ascii?Q?xliT4bRrKSbpJLlS/ocMixuCiXf+LJTkOB1weL7azy4wpvL4wRPDWIwdSMNu?=
 =?us-ascii?Q?eqgBzqneyfvKU095JOf7JMVHRmBqGzhZ3B8jAN6ksD3RTkql6+7TB2yl0JBi?=
 =?us-ascii?Q?o2PNA7I9dTSH6bb3m/rA1YWS408htkRza/7js3IHQoBirpzxh2dN/8JWOqpb?=
 =?us-ascii?Q?rguReJzxLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a55c408-3242-47b3-ecbe-08deb288c0ba
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 13:49:16.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq5gaDBh41nFF+H9xp9iZ9fma4RzsNdVXs9gvfyEB1z+qYi2eOHBhGRZJ8GLMvTYssQyj0P4NRW50W/f6zFTiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
X-Rspamd-Queue-Id: F246D550E03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288317-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 06:00:13PM +0200, Fernando Fernandez Mancera wrote:
> Hi Ido, yes this looks good but I am afraid of using time_after(). Sure, a
> temporary address should never be older than 2 ~ 7 days. Yet, we allow
> configuring it up to 2147483647 (68~ years). And that might cause problems
> in 32-bit systems.
> 
> I think we either limit this configuration on sysctl directly or we need to
> support this nonsense.. another option would be to move inet6_ifaddr out of
> jiffies which is something that I recently added to my TODO list. But that
> is a bigger change I do not want to bundle with this one.
> 
> I noticed that ipv6_add_addr() do:
> 
> list_add(&ifa->tmp_list, &idev->tempaddr_list);
> 
> Doesn't it mean the first address that matches the base prefix is indeed the
> most recent one? I tried a bit and it seems we can use just the first match
> :)

It's very unlikely that jiffies is going to be a problem given that
these are temporary addresses. A lifetime of months / years defeats the
purpose...

I'm OK with relying on the list order, but lets add a comment in
ipv6_add_addr() just before the address is added to the list.

> In addition, I didn't check with Sashiko but it is likely going to complain
> about a race condition for a RA arriving right after we have spawned an
> address but it has not been added to the tempaddr list. Therefore we would
> have two addresses.. anyway, that race is quite unlikely. I also have
> planned work on that are to reduce the multiple race windows, currently
> there are plenty. I suggest to acknowledge such race condition for now and
> improve the code base for the reported scenario.

One possible solution is to encode the regeneration state in the
regeneration counter of temporary addresses. Currently it's essentially
a boolean. We can have:

0 - Pre-regeneration.
1 - Regeneration in progress.
2 - Regeneration done (might have failed).

And only reset the state if regeneration was already done.

> I propose this small change to your proposed diff, I acknowledge that it is
> a bit fragile tho (maybe a comment at ipv6_add_addr() is worth to avoid
> breaking this accidentally):

Yes, comments where we add to the list and where we derive the newest
address based on the order should make this clear.

