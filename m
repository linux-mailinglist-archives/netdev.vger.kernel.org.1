Return-Path: <netdev+bounces-44070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C07D5FC6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230A01C20CBB
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F532D61B;
	Wed, 25 Oct 2023 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="ik66P1W+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14138185F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:12:13 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2094.outbound.protection.outlook.com [40.107.6.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB8410DB
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLQYKKiqYpBbpP4xaJOIin9Y53wOsBEXZeufqSy/ywQqUm64jxAPknIohZmkRcoIE0HLz2zN+K6qNluLtPRqhoHnosnvRi6m//CNQnfeWWhWDQ21m262hTR8aBgHcha1wq/XnaP/vIrvj8o3tHx9wtXczA6LrL8I5PsUr0Zl3YdjUkH9FkG/0aYtLZ5Hx6QlidCrr0d5M/v4GkAgB6lQSHWxZxJVBisqKmpoUZsNWLHuag/BI3XMq+CsdKibG/QbYuUfanc+OW9QoKSk2wvhchM1KQMBWYyXG6B33UHq0bjg3U2GWebTyHW4XkyRmdai1oBOrBV4CDB/HSZxN7o34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+MhQ0O7JrMuC3IGh1TFBMUtrRZvuIEuuKNkuzWu0F8=;
 b=CyJ3XHPRWpt1jPJZIDKdek4Gb7z9rY7IaKnhyrhqlRhsisW+A/Nid71hs4mPCPuhsZgyXwiYrOCU+7qyyW7dTpIVx3aINBp16xm78gg6csbsJdKCzIgZ+QyZvVxAd4Nmbspq00cvhzRe+JPTCUGkOoAn9virl2QFjvZCvgIFUqhOhNK9Ssn7Q9RtKXGKYehU9SV8pagFV2E06mofyhy+vXNzOFneKIngFjqOl7pFFtaXQ1MQ/T2gqqkI9/xxjZUwwSn5E6PL9LN6zoAf5yxAWN6ZaaDSIA/3WkP1VjkQiJmahv00NuSadExL5N6uYwWz1li/Dc4GEh7RqXC/nw/+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+MhQ0O7JrMuC3IGh1TFBMUtrRZvuIEuuKNkuzWu0F8=;
 b=ik66P1W+4LdMf84X+h/4pCCLKe3pGn9cWnSxQLaot491uMPmRjOT3Ut6dJA9xyjS346zZYa/IaWWAx3JB3Bc8ZW/WzSs16g6BAqsICu9UsdF1j/1YMVh+IXvcmWjKHd7xTVS0S6rNRViwMFSOJ8x0kD6nIcJ8Bju9g+uIHh2ZV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voleatech.de;
Received: from PAXPR05MB8863.eurprd05.prod.outlook.com (2603:10a6:102:21a::23)
 by PAWPR05MB10358.eurprd05.prod.outlook.com (2603:10a6:102:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 02:12:08 +0000
Received: from PAXPR05MB8863.eurprd05.prod.outlook.com
 ([fe80::17:a953:6de9:4a6a]) by PAXPR05MB8863.eurprd05.prod.outlook.com
 ([fe80::17:a953:6de9:4a6a%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 02:12:08 +0000
Date: Wed, 25 Oct 2023 04:12:05 +0200
From: Sven Auhagen <sven.auhagen@voleatech.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, 
	brouer@redhat.com, lorenzo@kernel.org, Paulo.DaSilva@kyberna.com, 
	ilias.apalodimas@linaro.org, mcroce@microsoft.com
Subject: Re: [PATCH v3 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <fusfdpsgmo5cc55mokt2wasdx6flbgczho7yntj7fmiwchenft@luglcjwvedsq>
References: <be2yyb4ksuzj2d4yhvfzj43fswdtqmcqxv5dplmi6qy7vr4don@ksativ2xr33e>
 <20231015172710.GA223096@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015172710.GA223096@unreal>
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To PAXPR05MB8863.eurprd05.prod.outlook.com
 (2603:10a6:102:21a::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR05MB8863:EE_|PAWPR05MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 0720499d-484f-49b1-37af-08dbd4ffca96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cOUSi+SWSsch1NGCopqINDRSp9RvrhTJi35dUMx0xd4I3V5Bdx+sdiu2zOhyWDUorKj5h9xWt3VJmzsrnYaRc68xN+1nZU9zHs5EJb3SUrT/c5sFB1OrGTQ6SW5uOWaYYjXs4iL2wr0AuwGt/fPAc5JiCyQhbzrncxN8h06iv4op2DeMD6HLMmshC1d8YYZZJQ8aoBKbaIEhcxa3SbtwgyEFwjKeaH8oOp34alKOlWRc98HvMiAL727fdZMCSMCN9OMfl2eybfow3E6L7JLz/94WPQeD1VvRIVjKLQxVMgdLP0Ma+8t8gCJgqXaMD0K1ySSG8SIH7NnB3ky/MrHnBOlt75QqIz2lZ60KBEG45KVIGBcBFmEJqg+VjutAlmc/PVQMfqgIdmw5vAf8NVu2QNzTDVodkLc1uTjFj4MnW5nv6WgxXEb5tYxNQq6sDJ2Nzn3ASWoheu5qnUZ24pKwZE3Ttj5uRARKhIZb+R5Bf85ijAUKr/g/x5IHdqXD7dx/APSKO4qnFzCEZnwDCs5teplXk67SHhaJtWHyHFL3wr1tjjsXKq7ZK6/h6vcYl5kAKMYIK2zve8jzmyv+VF+9lY8eZ6AinuAnDNQEkBunl9wpTt5Yxi2teJVpnQAVOfob
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR05MB8863.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(396003)(136003)(39830400003)(451199024)(64100799003)(186009)(1800799009)(66556008)(66476007)(316002)(6916009)(66946007)(33716001)(9686003)(86362001)(6512007)(38100700002)(478600001)(6486002)(6506007)(6666004)(5660300002)(41300700001)(44832011)(2906002)(26005)(8676002)(8936002)(4326008)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTa02BaC0dDaDistaGD9Xt9ph2AEu2FIMkaPJVTJjctHpYJJV3eEIoJsRJeR?=
 =?us-ascii?Q?2a3aaY0Y9aeYP4zWcplhW9Ffpjm74v77PDMgut2J/9iFCKWTizfsruB/Dyx3?=
 =?us-ascii?Q?b+V19UiXUiSiNXVIh37qOO7Tscnw0LXjNWvHxp/aS98pXOywdHCCRlOUg/xO?=
 =?us-ascii?Q?6aitHuyqVBYEa1JiBXIhTOi3KGFij8wzg6jEPGPDwhh8yG3koRTWLOgaRSPZ?=
 =?us-ascii?Q?4lIbHqtedgCvGUmSpocMlrpSxazChqmYfOnbgTQqsGGGgTVCS5ZRIerXUEn0?=
 =?us-ascii?Q?VpYS6Lu4bl7Om8pKjgNAL+2siVlewCY/Iwzru/aGqv5GUYqZ2J4U/5G8Zb5G?=
 =?us-ascii?Q?VP7Ob1pIONOzl/zT9J15QVr0WIzt0NAIvYPgGxH4Ch5a1W3VjRMAtlK2kG9g?=
 =?us-ascii?Q?PeB6+clf9EIdE5rfaYcbzqz99NMR3Adjug4qNBQXK2YlYcIeZlVAHxt2Vr8G?=
 =?us-ascii?Q?y18I/uXP40Ev6HsZZQ1n4VB8EM9e97MhBud7hyMZkbRSa4SzTPuGk4O4AcUJ?=
 =?us-ascii?Q?6O4grj87//pxPNC2m1oglC3HcJm6e6a6ga+qDjWsQ/eIG6CBA4Jhp2Cmz4jH?=
 =?us-ascii?Q?e1EZtUFfOOhRQwUO4dXxXsc8397wqF4qVF4fTLicbHraZVay+j/DCt54GJBm?=
 =?us-ascii?Q?pR3fxtJgIVx0KVzPaIpE/cX23V99UuJrX+VJIHkEXMVxTbnvIAAkGaq/mKGW?=
 =?us-ascii?Q?yJibQl7MPLYgEMzOqJ6Tv2u+aq45jiWJ12c8Jr4hK0eWMF1PnkYYde8W3G8y?=
 =?us-ascii?Q?D1uJRMTimu1uk+HSSl72IFNOlab/OcfBMsTYD62ctQUWqn5AFRmIzZhxbk9p?=
 =?us-ascii?Q?cx3KgeyBC49GfWq8RO6NJI03EpXQhZpm+sZjUTWxoQaK6Be7NXNBkSHlLhI1?=
 =?us-ascii?Q?ZkXc7tgbGrsEcgPODuC4MPRTgyngx2XC/+tG3h2NKttaaOZphfv5KOKFN1N2?=
 =?us-ascii?Q?NXzMkYfXzIiEvPjYUz7iAhIQLqyZiLwdIR7XwwtEiPaUsnN2pQs0Pq5BSoj/?=
 =?us-ascii?Q?2jDyRJlHOsj9G0k7rcfD1v85UGJS13AI6olfnyHFCv9JpQiGdjV5HOUCnCxt?=
 =?us-ascii?Q?yZJ3w7y5UA8h7wVKgqN65Ukp3EmvVfNr3Z+Mz51ssSBgAfPpLai06fv25naT?=
 =?us-ascii?Q?7STrGE9vNjRIrLeJG2553sNLi1bR58f8+qK1Gd3+ABoCJRgHZ5xF7GgBci8K?=
 =?us-ascii?Q?wd2BMyOospfuAEMCYnR7MdXw3M9sjPJvKYMt8/urs4k9D5nX3duS7QkzyI1R?=
 =?us-ascii?Q?dBaR6t+gPMnEl3tg5vzXswAIc8TAKE9HVDGhXaR6g6BNwXEyg93I/Q+Evj8+?=
 =?us-ascii?Q?QNNIvT13gL1gizy5XjVRIwhybZ+9Sbo2mp19urmVZ83JYMmb4KgGLGfuk0iZ?=
 =?us-ascii?Q?qOxZMiaVtbpWqau3YyAYJS6mWf7AhYP2kpz1jyeORJFXH+C49coM3SJxnyKf?=
 =?us-ascii?Q?UFSwRNI7Jxwb0KkjoZVFpprExkHC4RZJtPMoxPfqY80zaM3eyw8jQwY0kuNk?=
 =?us-ascii?Q?zAQ325UhyZwl42yrTRNjhbT8q2ZQHIXwtDx/0KUTX3mYT93SjIN73f16L6be?=
 =?us-ascii?Q?/8zaoWKxONeFy7WumPZV4QzKwAWk7JL7+XYZF0YNIX99UJ6566auYBPlhxeH?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0720499d-484f-49b1-37af-08dbd4ffca96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR05MB8863.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:12:08.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIqSeriu9zEeBP9XGFtBMqf3abfRpjjhpTO/K1KAYD9/B+MpAXut4iiWlklIEhdtf0g91Ovu74OBYsvTsNQ/C8nTPIwEDO8zFOxyglagHrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB10358

On Sun, Oct 15, 2023 at 08:27:10PM +0300, Leon Romanovsky wrote:
> On Sun, Oct 15, 2023 at 02:37:27PM +0200, Sven Auhagen wrote:
> > If the page_pool variable is null while passing it to
> > the page_pool_get_stats function we receive a kernel error.
> > 
> > Check if the page_pool variable is at least valid.
> > 
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
> > ---
> >  net/core/page_pool.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 2396c99bedea..4c5dca6b4a16 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -65,6 +65,9 @@ bool page_pool_get_stats(struct page_pool *pool,
> >  	if (!stats)
> >  		return false;
> >  
> > +	if (!pool)
> > +		return false;
> > +
> 
> I would argue that both pool and stats shouldn't be NULL and must be
> checked by caller. This API call named get-stats-from-pool.
> 
> Thanks

I can do it either way, I only need to know which version to send.
Can someone let me know how to proceed with the patch?

Best
Sven

> 
> >  	/* The caller is responsible to initialize stats. */
> >  	stats->alloc_stats.fast += pool->alloc_stats.fast;
> >  	stats->alloc_stats.slow += pool->alloc_stats.slow;
> > -- 
> > 2.42.0
> > 
> > 

