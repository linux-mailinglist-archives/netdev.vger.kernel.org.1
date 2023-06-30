Return-Path: <netdev+bounces-14779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9C743CB3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3D22810B1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1552154B9;
	Fri, 30 Jun 2023 13:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3A154A6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:25:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549703A99
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 06:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1hUkLODu+FTjRC7i6D3EWqftsEXHXiymAlXv5Un4P8c4RsFtLSjhLFrr+EWJ+u281U6PYqA+VcunK4KybaqS22MOHaranUg2uMhfGTmYWkejqj0p+Tr34sF/TBDdQxyFyALAauOB+mVt75AxZdkYW1w0aYkgs1bWQhJRYTYEmj+sJhL20zSYWD5gLjR0IDiL26zRRZLwfCKTXqXXc7KLqRxA7MfTwvguXtmOwzCnyio6jkAsU8YFAZgXHT90cBHlT0vU/lFIEmnnmxyOyClbu4K8oBIDnJXoQZVrFI2PqiY96xma8kbE6CdHskqN9srodUkh7gTiqrowbGEsgHV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaysalhDT36sCg9ZHcReSdS6hjVriciAPOvnEwPDhbM=;
 b=ZaTQjEYJn2TYUSplkRzSjD+OpTWZ3fDdpufkmT2z7q94+/pPtr609RUzSp6kwA1ojUm2EU0UIgLWxvcivqF9Z0YpoudICF18cH5Cl8+xSqc1hZjWnuW9e9hIgVU4PzlR8O/v0RB2sryMZ+wwYI1Zh78CjQbf9jv3ndePGZBiRCjcM5UvxGnZC7zHgsjKwwNq/3RcKYSZBtn3zyFi0tWs3ly+p8kq/mo2Y6tu024qyD1W6NDfgdedxobx3bKXmogGjUMiEo3cdCtSEFIT1j4RoVM1rpfowEc+s6nq1lBErrcjG/yimfZotHDo62YZMAGu58Fq6MSOjw6uFN5IPvFYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaysalhDT36sCg9ZHcReSdS6hjVriciAPOvnEwPDhbM=;
 b=lePA4ZgTtG4ZABMEcz1VIhWfFeAh+zkqRc2/VPcG9Y1Z4dN2l7NSOMQAVuhbXbh4fSV1H1//tZ7B2+8G/gJhOHbtG8+29J3ZdRJplz/da90X7bhQkWTSMyTHawHpkU7CLjY5OuOmg9fqz8yvdQAzhY16+0i7AYmDo8S2RM4l5+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB6100.namprd13.prod.outlook.com (2603:10b6:806:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 13:25:36 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:25:36 +0000
Date: Fri, 30 Jun 2023 15:25:30 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Eric Garver <eric@garver.life>, netdev@vger.kernel.org,
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: add drop action
Message-ID: <ZJ7Xygm/k1dPH9YN@corigine.com>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life>
 <ZJ6j5anO1CTzO0j4@corigine.com>
 <ZJ7Kxlrh3iRLKIib@egarver-thinkpadt14sgen1.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ7Kxlrh3iRLKIib@egarver-thinkpadt14sgen1.remote.csb>
X-ClientProxiedBy: AM9P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: d32fb51b-29ec-4509-47a8-08db796d7d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zuM8oPzPwMi0fGPu7E/imkZyWKuqKRYx/86ViIetglWC4+tm10+9pns69VxSzsWd5p+Y8wHim2/FAMrTh8ixxOGFestq3RhzGEPCaeg7PD7zhc6tA+QRxMguVKK3+ojqkzBtvymRXY6S5UK+xaZ1blo05cIovBnM86wULznRcW9Npnv3chwi2m+1tC6HdtdVwarZ6fI4pxtNkGXUkBdRV2YqG6ZtaCcnT8ooyiTuw+TfX33x+5zsEC8rsNDuSNH94/e9Rq7lGIHBy4ml+pAU58rCXPmDhiVgUu6JoArg5+fRF/Drx/zp+/EKFMsFxa9zBJrhXXbwVWRgOuX0Q9Z9Luvz1xiErAFi8C/OueTcGRtbLSskyXmd/pNxCBLxnBvR6mcaAY3jqTYxPMGgpyy0syiNGCbSaiqagzecRmGksSBGxi5chp+xp/04zyHD+73mymI0RtZo/k2ZHpqscUTDThclcKzyQTIpVf57fWb0nvuPy/blYda8KfrsNQKXRuV6WfjN0J6OfeZj55h2+EXLzgb9pOWO/vrBp1jF97gDA+Vb1G6fUcC4uXUzPvjt3F9yL6V67ctLqAKn4/zaTfJxMwZc9jxmIzFYZOBanfcoVtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(451199021)(41300700001)(186003)(6512007)(36756003)(66556008)(66476007)(66946007)(86362001)(8676002)(5660300002)(38100700002)(316002)(44832011)(8936002)(6666004)(6506007)(2906002)(6486002)(83380400001)(2616005)(478600001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qU6l2eT3SKsvmslDtZGRgRDMEOutihwGu2MGWRMaYBwM4MfwlpyvaH8typ9C?=
 =?us-ascii?Q?58vbwS+cUnWDNBD5SQcUijmoX0bbUf3bAzuOIIn+GChsX5yhBA5OKmY+tqds?=
 =?us-ascii?Q?GfNTcMKl1POfn8xDwsGBHxHKycUn3msiPnC9fwtHfzJSmoGWdIxsaQF8kH0u?=
 =?us-ascii?Q?Qq/nlSW9AJzsH7+Plt5m0jFuEP8GZxX23q+/+ViUNNRFYR7AofZGfYM/nMkB?=
 =?us-ascii?Q?+0x5nwttFQv/V/4YfsIGETmLK6v35w3fIMkDEj8xi2tLQlUPAgMOdcsrvCOi?=
 =?us-ascii?Q?Kk9cox25aaIDQEnCEpbtXEV9gh1X2sIV4jyY98s3asyWqUZ2aF1oPWCrwt8g?=
 =?us-ascii?Q?cwOsntx8yeAR10izkGjQw6DoL37MO+Lq+RuSfFp8ndciqKl1vo9AraPnvHg3?=
 =?us-ascii?Q?rXVn6DwXgzcu2uEI93z+nlRhQlns+/gZpvC+SvHwBl6KWEyVoGGwE4aF7nF8?=
 =?us-ascii?Q?3QN3JzOFuzGN1ytk8ogK91ASs1FrjU2OtfTtrLx5tH97meEtidhhS7S4eMm7?=
 =?us-ascii?Q?8N7uEFJiZedARPV6jVptoCFofwTqXybltRJR2wmOI85mNznMm9WFGLB+h+pe?=
 =?us-ascii?Q?A5RnOcpRVFroU87mxVqaglTbplkBMagaKBR5yKCMfw4oiewKMGkCLXyKI8mj?=
 =?us-ascii?Q?r5oCXPIS91r+/U92sXs9pZXjSnXLD1LcRTb6ZaIaxz6GxYsHLHaEVs6U8PVw?=
 =?us-ascii?Q?MnLhgQYKfZyntvpeik17QjtqnsvtnjTKqHgErxlBAMMoRExbz7VGctpVxccM?=
 =?us-ascii?Q?mRKAv5rQ/DPlFhkVGXgMdDLr+2XgPn1jUbmM8yf1kTnmgSFjv2S6UB7k0kiT?=
 =?us-ascii?Q?WHkWNO+XWng0fb0TwSWwYVGoHi94z24AfZ8huZhbsEkwYI8zGyGVcVQllMri?=
 =?us-ascii?Q?g1dNhH5YLWhZPQ+9aJv/wOQ88kk52IkZE7DLaAtNThOTDF2eylYn9UJwCNE0?=
 =?us-ascii?Q?jEmNl/RvENq6IjYATeawESTVgsPdm5mnZcST6oQkgx7M71AE+t9J08OSdTCG?=
 =?us-ascii?Q?kcaTaeGdFLtnNLpSUY4QI3XhL0yeEXf5WNszv9AnVtoQjjUdAvUotzBiS8jE?=
 =?us-ascii?Q?UYxMnefqgCb2rYgXk9AeWnoLGyfSPHdIBwMxfvAXJmxMO/+iN9zdFt1D+gIo?=
 =?us-ascii?Q?kkk7+UPE69EPSCJ6a1j+kU0j2wlmGCk62QvbErhMYz2YQ/hNauLYVp5LQ+st?=
 =?us-ascii?Q?890lWERHMSVjWuD/DJaO6v7Pxzd9voinISVV3z9P+zOlfAtAWmrK6TEBMPE2?=
 =?us-ascii?Q?w2RWtUl+XD9YCxdKTZPphSq2p7cYNCb1BS10uBWqCwUU4t9ldMfC6d3X64Gu?=
 =?us-ascii?Q?nZ4y9T4J7ZRjEsF1C3b7SdBNO1wZl1KADDHRfFjXbr45W7EPNRmo7CyZY/29?=
 =?us-ascii?Q?IObWrO7BVf0iA5YlGuSuCHFVyOCroS/DKpK8yaNUAV/Tm03wzzVEFxAniQsX?=
 =?us-ascii?Q?vh+OGX6RklHQUYVRulIBi3kVUJ0j6UBAIGQQE63pJgHAIoat/G2e67xTFExZ?=
 =?us-ascii?Q?ngfR/kVc0zcMwUgOhfBq+a46XvjbdfiumiiG8cI0Dd9o8ejxxBKMDRiNNBxK?=
 =?us-ascii?Q?zORdfOKF3dZsAtkzY4ZU1u70hvYOthAKa7lcPpgXJqbpv7feIPyPtxWdqaas?=
 =?us-ascii?Q?oeYt1AKZs/RZr8+A5VQQmdiwd5Y1v1saHZITQ2U77X5z8gefAcAuEk6hK6KT?=
 =?us-ascii?Q?WQ3aZQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32fb51b-29ec-4509-47a8-08db796d7d5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:25:36.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TD/xbxfGRn9WsD5qYGa+IcDdEYLPKN55yPz8L8KgJsZmIlyKe5gWWLOscmfw8maB5JmsPuN4XS/PT/Ht5/JVpcMgRWnToyKKV1+lepmaT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 08:29:58AM -0400, Eric Garver wrote:
> On Fri, Jun 30, 2023 at 11:47:04AM +0200, Simon Horman wrote:
> > On Thu, Jun 29, 2023 at 04:30:05PM -0400, Eric Garver wrote:
> > > This adds an explicit drop action. This is used by OVS to drop packets
> > > for which it cannot determine what to do. An explicit action in the
> > > kernel allows passing the reason _why_ the packet is being dropped. We
> > > can then use perf tracing to match on the drop reason.
> > > 
> > > e.g. trace all OVS dropped skbs
> > > 
> > >  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
> > >  [..]
> > >  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
> > >   location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
> > > 
> > > reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)
> > > 
> > > Signed-off-by: Eric Garver <eric@garver.life>
> > 
> > ...
> > 
> > > --- a/net/openvswitch/actions.c
> > > +++ b/net/openvswitch/actions.c
> > > @@ -32,6 +32,7 @@
> > >  #include "vport.h"
> > >  #include "flow_netlink.h"
> > >  #include "openvswitch_trace.h"
> > > +#include "drop.h"
> > >  
> > >  struct deferred_action {
> > >  	struct sk_buff *skb;
> > > @@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
> > >  				return dec_ttl_exception_handler(dp, skb,
> > >  								 key, a);
> > >  			break;
> > > +
> > > +		case OVS_ACTION_ATTR_DROP:
> > > +			u32 reason = nla_get_u32(a);
> > > +
> > > +			reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
> > > +					SKB_DROP_REASON_SUBSYS_SHIFT;
> > > +
> > > +			if (reason == OVS_XLATE_OK)
> > > +				break;
> > > +
> > > +			kfree_skb_reason(skb, reason);
> > > +			return 0;
> > >  		}
> > 
> > Hi Eric,
> > 
> > thanks for your patches. This is an interesting new feature.
> > 
> > unfortunately clang-16 doesn't seem to like this very much.
> > I think that it is due to the declaration of reason not
> > being enclosed in a block - { }.
> > 
> >   net/openvswitch/actions.c:1483:4: error: expected expression
> >                           u32 reason = nla_get_u32(a);
> >                           ^
> >   net/openvswitch/actions.c:1485:4: error: use of undeclared identifier 'reason'
> >                           reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
> >                           ^
> >   net/openvswitch/actions.c:1488:8: error: use of undeclared identifier 'reason'
> >                           if (reason == OVS_XLATE_OK)
> >                               ^
> >   net/openvswitch/actions.c:1491:26: error: use of undeclared identifier 'reason'
> >                           kfree_skb_reason(skb, reason);
> >                                                 ^
> >   4 errors generated.
> > 
> > 
> > net-next is currently closed.
> > So please provide a v2 once it reposts, after 10th July.
> 
> oof. My bad. I'll fix the clang issue and post v2 in a couple weeks.

Thanks Eric,

much appreciated.

