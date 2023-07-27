Return-Path: <netdev+bounces-21908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D997653BE
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACA12822E1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FE168DD;
	Thu, 27 Jul 2023 12:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC71642E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:25:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::70d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F913C22
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZc5MJHZglOPXgpmFdCtMx75A1uvA6vWYIvjsvGvxu+f46WfDg525t2H/8CRAN6+L5hKRYHzdC0A/X0Zru0Rq5jEy4BBQQE6SsPWfTdFknD3WQI6eUfiAE6iaWGaCeqoPwrlI5xqRRoMVThNB64PgYWnJhpYgiT06ox5OrNDncz4EHYqXMhaVXQbbZrhL8bLKXw6hQYdtQsncIcmbnx2Z0DbhRnE3nIFibpoLVv4+bCMy21+U9GV8gSKt/69CyaFQkJHBtbsBo3qylfX/Z9YD18yQf4FguB3CnQsUTJSiaSnbf/bSjo+uOoJlhH8rnR87hD68B/W9H8jNRvg4G+4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn1bt5tfWnfXh4za1delTHX3nWEHWqUV4ThlXektJ0c=;
 b=Fb8b1qVLXbBKshT06U2RncJsE6eIAWoLeo7Jjvt59WehJVICurDzejfmmURvZHseY26noQdmW8CaIdue2nztF0MJtLz4vXDKAhkeA9zmFRvQTDU7nDg+FS13gAePHLA9NnmTCVCLkZ8+UGeWF4oyzuDhcm+zGRM9e/Ak4OqJNvH9EnFeAgiTAQ8f7uUOOJYZbPGuMsCkNvjdgCCm63SyIh9WdHqOxlCY1DnmbzbCmo5l+4SJaWKOwNUPNgcVeBJq2hg+7k2O2JxivrxqOBflqtlf94J61QSQBlNdgTwf4+/kXqSvEdL4dZ20UtjhYSlRN/m/ou3g0UhjDZv7HpIAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn1bt5tfWnfXh4za1delTHX3nWEHWqUV4ThlXektJ0c=;
 b=oMxguPahd1boeLTHQK+Wb34q/IcfALZjatX8WZxtuM5mhUs3x9lB8bodxsoPPEBIgnBo21SDIgkXJYGczXxMHfJtQOXbVl7AkEozucSDVoF3A6cIMo+t6cDolGXQ+hkmAU9+94sxOqM+vGSl9OP2bii4Di435JMPihY9YKaks6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5174.namprd13.prod.outlook.com (2603:10b6:8:1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 12:23:55 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:23:55 +0000
Date: Thu, 27 Jul 2023 14:23:49 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Patrick Rohr <prohr@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA
 lifetimes
Message-ID: <ZMJh1RS+EaGsmgZJ@corigine.com>
References: <20230726230701.919212-1-prohr@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726230701.919212-1-prohr@google.com>
X-ClientProxiedBy: AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: e799168c-f504-4a8b-c1a1-08db8e9c584f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcp2V0LsFZiSOdrOremwdFgDA3nU/0I5MsUww5DOjtDvv4zZVMLHe/0RhR9nLxMVlvWSojcRPA+6SiDJ/Z5rYRKNaGTVeivtGLTOp0fHtg1ilH3p7hq3tYiIr3VJnV+/fedQ51svYeFzSeoUEsPsR+PJWShQ8lshc2Q79WUA1SinrSmT5R3e5t81U9yX1kIB8+RSqfqozUX+Q65jDbeuk/Ro+PPjgC/CY+IRrCg6ueP5dPwCpL9TCAYjQ+R1//dvlIMSApqbKTk1GrtXayMKK7LUcsQGdO96u2Kn+M3xjQA5RuJ6A1HhVdrSx62/EqBd8r4HM+Le+DMKMI4T5Ssjx6XkRTkh9Wmp6Pfr0KjiHY73hzClpeoV1CdJUga0cu3FSF8mG0698xj52XmPzgrm4dahcdmrADH1tKkWZfADs+FP8ZFNGCI4P4zyH7KtdLsvjJmpXMlJBIoWGr2yQr9E9vuK8nPEi/jcUraFxW598nWh2YshVtn7y0PFYLW20bC4yxMJla0XcDXY/neOFY16NtkUajsRiGH/dRNW05zgziYFmJIp3YI7idiNX+ahyAk6+fWBGw2lAXwtkqD0Ts4GS7czV6WWvg5Y+cf7vMy8SYZBYEPxX5O0m5U8o5U8uhCmeEyF9OUAfOO8IpYdjupmAjmRFIjdoaUJeIdXREZZyTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39840400004)(136003)(366004)(346002)(451199021)(6486002)(6666004)(6512007)(86362001)(2616005)(36756003)(186003)(83380400001)(66574015)(6506007)(38100700002)(2906002)(6916009)(4326008)(66946007)(66476007)(66556008)(316002)(41300700001)(5660300002)(44832011)(8676002)(8936002)(478600001)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk9VQkF6SW9STU01UENOZU4xS3lGMGFQUXlXcGR5RE1Cc0wwY0p6K3FoVWEw?=
 =?utf-8?B?NWkzM3QxL2szUnNZRC9pbm51Q080d1N4YWdhdlFPTFV4TmFDblMvOWpndC95?=
 =?utf-8?B?NmNkaE52bmFoNWlBY00reVpmU1NJejFYSjdvMTVpYjVrb3lxVEFRVzEreW1k?=
 =?utf-8?B?bXpkT255OFNZbGpFMk9jL2o4aHlIdHJWSGhqSE1IOXRxR3ZWNlNwMUtOYkRm?=
 =?utf-8?B?eXN1SElHRlBsZ1cyMUxBdW45dVh4RDVGMXJ2NjFpaTVYVnBLcllzTlYvcjNG?=
 =?utf-8?B?K29JUkFISVFBVmF0bU10VzZDUzlPaDZtUTlmRksvODdsM2orUktkZ3JqL2ZS?=
 =?utf-8?B?MzdQcWk5Y3lOdDJyVHd1WmYreitnTlYwaS9TMVpENzZKMjBxMHVKcERaZ1R1?=
 =?utf-8?B?dGFid2lDaW91UEx3UzlMNDFEVklkemNKYlpOQjliR0pwOHlUVmpLUGFlVndz?=
 =?utf-8?B?QVdka2RNT1d5aFBlbWFndHNrSzQ1U2RaQ2o4RjNpb1dRZlgxUUM0UnhvYm1R?=
 =?utf-8?B?VUpDN2wxMEVXcGVyWml2SGZBeUx3ZktaQVFma3hCYmx2ak5aNTFSZVdvMHhV?=
 =?utf-8?B?N3F1N0FMVmpzc1pmZi9UaUpvWnpTR1daaVAvTm1HbnJzd1dUWkRVYVJQQXI1?=
 =?utf-8?B?RzdSZGJUR1NRREZneDNWSXJCK2s5SWxWRmpkVmtUaW8vR1Z3VFhxb0xkOGZl?=
 =?utf-8?B?RXltWER1UmRXMFdwMGdzWTY2dlYzRUxsTXBBUUpxWndlLzlqckdvWWNQeXdC?=
 =?utf-8?B?RStHTFJaRmpCQzdwNDFuN0VHUC9McGxGY3VYY1BVUFV3NGN2QkFiRjlDeExi?=
 =?utf-8?B?aVNlRGhtSUU3YWcwcHUrT1VNR2FvbjBYWXJDQk9uWm8zYUw1UDZlUjFPeHBL?=
 =?utf-8?B?VFE4b2ZJNWJFREVSYWpuUnNscEN2SzAvWHp2eWduTW9LNk4va1RZTTdZU05O?=
 =?utf-8?B?RFFYU3JJVlBZTGZ4RnhWNkh1amxzY1VkdFhRVVR6OTdLZDlDOE1JczZwQS8z?=
 =?utf-8?B?SkFEaUQzR21oeXp0UklNZGhKYk02OXZrc250TGJtREo5WFNocW9uYmd0Vkkv?=
 =?utf-8?B?MTVIcEZGcVpZRkJObHNLSnNweTdXUFNNTjFlWE5NZGZXOUpvaVQyTUh6c29K?=
 =?utf-8?B?bWE0OXFIejhRVVZIbUNCaVpHZG10aDZNZFZsd0l1QUJHTUtZd1A4YnI4R3VS?=
 =?utf-8?B?QUNCYkZXTnlvZHRBTkt5UW9Ea1JyQ1FGTWw2WHprbEozOHVaTXlPNFJxeUN3?=
 =?utf-8?B?T21hejV1QlJXYVhXdXFSMEcrUFZ4NmZMY0dyaGFDckFxVFgzbFB2TnNWWWpL?=
 =?utf-8?B?N2VMRmhWYTJZcWxocldDWURPRkJQdXdtZTIwU1B1UDE3czdPT3ZwTW9YbFIx?=
 =?utf-8?B?eVUwRi8wQk5YajN5VjkvNUcxUk40c3R6L0VqOFB2dG01Wit1ZFJiVlorcWht?=
 =?utf-8?B?Wm1RT0JEbnVNU3k2N0lGN1lLRGFOK0o1NThWcWgwZ2dmd0tLZ1NvcU50MllO?=
 =?utf-8?B?ZjhxS3kwSTJRSkhQSEpOaGRBMGZ0UUluWHVmbDFmd0NsMUQ5QmpVdjdJdWxT?=
 =?utf-8?B?YUs0eERCejdILzJmRG0xWWVyT3AxNm0vTGVtRlY0dzFNYUZuUSs4NGtsb3Ar?=
 =?utf-8?B?K3haVXZ3UFJ3RE5IMVYyMER0R0w5eVFGUkQ0cHpVWkpHSFNwSXpCSVdJQ3lq?=
 =?utf-8?B?WVVRMDZDQjRLSUgwZmVIZ2RKZWRvK1hsL0lIaXV1M1h4dmlEaThyY0lLUEZX?=
 =?utf-8?B?SlZhS2t1YWpwZHBuUWhxdGFHUHI2N25NRDBHczZxNUtvZ3FTNUliZjJ2SW45?=
 =?utf-8?B?Z0pLZ1UzWE1tTzVQWmZTbDU4T2pzMENFMGptUFZzUEJidG5YTzl2SDdZZ085?=
 =?utf-8?B?TjNJb2lET2VXZDJ4WCtMTE1CTThka3VYeTRZc3UraW04VWNmSXZaRzZCckJR?=
 =?utf-8?B?ODZDbU5rcDErK2Q5T3lZQisrY3h5Zm9NQ3RVNW56bnY1YktpZjlhRU4xS2dY?=
 =?utf-8?B?S3pqQU5JZGtjdG9EM1I5TjgydVB2eVl1K1VzRlYvVDU5b05wZ2lCdHRJTExQ?=
 =?utf-8?B?YlFXUlNJWFE3Ni9mYUVNZGQ0ZDA5dVluMDdDUjBUNCtmQ2dOVFpqUXZCMTZV?=
 =?utf-8?B?ZmVjTUNha1JSVit5Skk1eERVSUI4OTlwWVp6MWVzbkk3RmhGbVRhalhmY01i?=
 =?utf-8?B?UnBrWkJLVnloUUJGMlY1NUgrdW9qaHNhR2JvZTlTcEI4a051OVFOenVhTzNR?=
 =?utf-8?B?UGRvK1dZMGU1VkpSeTJYcWlqQmt3PT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e799168c-f504-4a8b-c1a1-08db8e9c584f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:23:55.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO8fmX/teT/rE/LFjSsNKpVGmdhdhDVTNx2RhZEEUbQ8rIFDMqxAxN8JKdTU9OkQ7XcWtmh0nLUCGG2Hnz23XC7pRrNBL6YV+CgTx6qOH0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5174
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:07:01PM -0700, Patrick Rohr wrote:
> accept_ra_min_rtr_lft only considered the lifetime of the default route
> and discarded entire RAs accordingly.
> 
> This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
> applies the value to individual RA sections; in particular, router
> lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
> lifetimes are lower than the configured value, the specific RA section
> is ignored.
> 
> In order for the sysctl to be useful to Android, it should really apply
> to all lifetimes in the RA, since that is what determines the minimum
> frequency at which RAs must be processed by the kernel. Android uses
> hardware offloads to drop RAs for a fraction of the minimum of all
> lifetimes present in the RA (some networks have very frequent RAs (5s)
> with high lifetimes (2h)). Despite this, we have encountered networks
> that set the router lifetime to 30s which results in very frequent CPU
> wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
> WiFi firmware) entirely on such networks, it seems better to ignore the
> misconfigured routers while still processing RAs from other IPv6 routers
> on the same network (i.e. to support IoT applications).
> 
> The previous implementation dropped the entire RA based on router
> lifetime. This turned out to be hard to expand to the other lifetimes
> present in the RA in a consistent manner; dropping the entire RA based
> on RIO/PIO lifetimes would essentially require parsing the whole thing
> twice.
> 
> Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  Documentation/networking/ip-sysctl.rst |  8 ++++----
>  include/linux/ipv6.h                   |  2 +-
>  include/uapi/linux/ipv6.h              |  2 +-
>  net/ipv6/addrconf.c                    | 14 ++++++++-----
>  net/ipv6/ndisc.c                       | 27 +++++++++++---------------
>  5 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 37603ad6126b..a66054d0763a 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2288,11 +2288,11 @@ accept_ra_min_hop_limit - INTEGER
>  
>  	Default: 1
>  
> -accept_ra_min_rtr_lft - INTEGER
> -	Minimum acceptable router lifetime in Router Advertisement.
> +accept_ra_min_lft - INTEGER
> +	Minimum acceptable lifetime value in Router Advertisement.

Hi Patrick, all,

I am concerned about UAPI-breakage aspects of changing the name of a sysctl.
Can we discuss that?

