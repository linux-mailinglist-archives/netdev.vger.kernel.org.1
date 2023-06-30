Return-Path: <netdev+bounces-14736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9A07438A1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F02C1C2093C
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74B101EA;
	Fri, 30 Jun 2023 09:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D010781
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:47:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::71e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7EC1AE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 02:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmJPaijaU3L9uT9i3FBcGl3sh0XBlBPGkOuruZb8ewBWd74ksO2+KZwtGoHL0qszaFu7hUQxjzTNVn5NPeUtLoEDKhaZBFTft2wRav2DinbpNCrxlLp6fCnNzXaR8Pb8ncQvqXERKp/H4NuCPeKGcyXwe7ITrYplxMuoeLDryWf1zW2lmWUt/HXVOIv7UWMl93F85VV9mM2EukZqUclv38tZglNaPgDXH/jIAo2XTfJfwKP0h3yPBgNA/S4orE1T1U50xzp9viNTa5b6mcVWCwiT7F9ltH5ufh4rRmJQfiHvcsNi9T93p6Yot/kop1+V3WZX+Ky31UhlTj3bA8GjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+gdljk60Yp86AG3+NEy/RdXv8vfBeZDux26XAeVZ0Y=;
 b=O74HaWGOT4gWRul2mDSe6xG8dpr9aL1GLCNTh3nExHgGfRk6Fa6VmFElZDzmRt4ssGnhec1ShZNHoeiu203wnSdhPZhloDTV2JVsroU946RG9X/ZunAf+b8ImZ2ZA2yX7jscT/6ZDavM5wIkNDKpTmK9dkbVEUAeuqwD6C9ja/7+3PCK+j9TmNd05IjXpl/ymrgK8kzTq1HLDf97xZF6VW7JQ5Ajvzw6yWn7dJ8CRXEknW6IK40Jle6sPup9n9LhE7aOBrsjCEefMluayLXJhfVJ36cPsMnRlZySeDIteSE3tTehE06oicsrXeeRw3jzQHgKHzmtbil46B/vO3Pp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+gdljk60Yp86AG3+NEy/RdXv8vfBeZDux26XAeVZ0Y=;
 b=EKRm1avqHsbZKHLkGcLbqOSFeT6JRonaXrNmEOILEagzm2QYf6y/fEzEmLul1KT1fiJoSNJkGOTDF381FWfOYnOHIdv4d7qWf/vynChdXRht7MbzcwUuvW2ACmg8x/EISdww2csxhKZeMPtNB+8snZEhpKAvQJhQaGrMl7YHKws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL0PR13MB4548.namprd13.prod.outlook.com (2603:10b6:208:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:47:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:47:44 +0000
Date: Fri, 30 Jun 2023 11:47:04 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Eric Garver <eric@garver.life>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next 2/2] net: openvswitch: add drop action
Message-ID: <ZJ6j5anO1CTzO0j4@corigine.com>
References: <20230629203005.2137107-1-eric@garver.life>
 <20230629203005.2137107-3-eric@garver.life>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629203005.2137107-3-eric@garver.life>
X-ClientProxiedBy: AS4P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL0PR13MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a3962a-9a06-4133-a15c-08db794f0db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bEWs+EK2Q+6m+xLK7NZrjfTLhMG2WhFC5sxvchnNUO75QIVhZHAdBfFT4dvOwHrkcwc7VGqikDkMV2DHAxKOsONDyiFktUdZkTQ5ZGYR133DVys9DtmQXO8cVlV9lYxe75A30h/OmYc3qweBcNGYWTyEk+lV3fnoyIObWlS8WanL5ZgdM/ERNLweEi4sOvZRmHr+ff7+UQa+lh86aOi7RNnGP1XwbnAyYiepDHfZemBUyY7awD/7Z1O5bQTf5S03AOj2RwqTohcA0YfnHRVxZd+wnT+KWW90deNw8d5aUA9Uhb0rJoa8RczhroV6iEOE19gmsaQvv0ySIlNBpm/KfbDzz9NauutsB6spaO7xp8zTXOnm+DwO9iHJKzKBUD6Bu369sVaVSADNoBdafyz/ABFMM4bRMqMNFPOegMTPQ84m1mbTPM4Cde3nu0VjqITbWj4BtjMFp/tks9oXmnI4UeBe4XNjwyqSQzXIqkaUSjHW+ws8TuY+FCEp3LZ71tkt5w9OUUwa+UetTUr5+kTBHQxKihWb4s/jQypfxDztFDpDesAXqrUzZ63hIP4fuSlmUCkPnSvG41VQIISy5qzzqIVK+IpGKe2J6g5DGbsEKbE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39830400003)(376002)(366004)(136003)(346002)(451199021)(6506007)(5660300002)(44832011)(6916009)(66556008)(4326008)(316002)(66946007)(478600001)(36756003)(66476007)(8676002)(8936002)(2906002)(186003)(54906003)(966005)(41300700001)(6486002)(86362001)(6512007)(2616005)(6666004)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SrY4K9MnRiJv+H7g6Ftbax0rDSa/kCfonplGbD2uGznB01sttBaRoORUJKqM?=
 =?us-ascii?Q?3dBx13QSnOyddmQk5E3z8iJcIXFrIFJ7KUS/9SVGviuYCpm9hf80t9+5uJuN?=
 =?us-ascii?Q?CUT8PawkDI4Lm8WOpp8kngpAZq9gynoYwTG6G1E7PBq9CEbKrFLsIudmcUAi?=
 =?us-ascii?Q?oo7AhGxxUGD4vw97UNztKPShzasR00iTHBaBJ33muxDb1uEp4vQHA2So94Ga?=
 =?us-ascii?Q?ry45DB6N6vqie/8X2EAx7miq+MKvPJKFc5x9/vDArlIKiiNJelrmCoAZnvNo?=
 =?us-ascii?Q?dSfzmVgUh6q1vjo6ulYRcb+PoLjXfMShIy66adryjQZHgdBgFB4RznaZ3wxc?=
 =?us-ascii?Q?hnyeZslgdj5AtNaw2YrapqRgTZZT8r1rgp2AzoXcmWFgPG6Ek3++cKE/Mx8x?=
 =?us-ascii?Q?mF74zfbsLjdNRh4cFs4lRDVq1xpkpjxFV/9dl88mpzaPD5oPNEpWGmj0n+3U?=
 =?us-ascii?Q?tU3Dt4fGKNAYoGSrqsehOoHJ0Tgk2XZyFYt86MWjZPZ/WnEHv4sRsB69uYe5?=
 =?us-ascii?Q?452mcIiqmiOkA/5yG3v5qKci+E0HRVblSgCsp7jdpAeoePGliLLwesp+4A8n?=
 =?us-ascii?Q?PKT7cO+V/SlYce5aFhIiWVUv1ys7pN+fAmUVEss1u2UrPzsvWoy7W28V/rVL?=
 =?us-ascii?Q?hf71FH84cQLxKdKCHK53uWmMGVSc+2yh94EsYLQ5A2PoFW3ZeHrwmegzFHhj?=
 =?us-ascii?Q?RqjOBz0lWYyoYzRTwgPrOC1zxPDElsbnrpew5+pEGQSweysjiSSENP1Ejxkg?=
 =?us-ascii?Q?ozHrqktrRHyXWCk9YkpqWCehbGseYjkFRJmVYZjiPz80uPyUie14imwi7w5b?=
 =?us-ascii?Q?3Mj8YFgTsGyitv7JL8NAPAGIasjto+zfxq7QubpqM+ODdSf0ksFZdkNmfe3A?=
 =?us-ascii?Q?GzoRzco/rAu9NhiKLwQfBKT0Mljc/mAzKnXQTKjJKibLTFq+f1otPwWpsTFA?=
 =?us-ascii?Q?lGYjhRfCuUqrA1v8/BY0nesrlMlHLNsqDdwiy1yXWdP6KvWGwvtajBObpvjp?=
 =?us-ascii?Q?BSDCSAuu/lrwlBvguxUAcac5EjWjAB+Xr501ibd0ulNvHXu3LDG71rB53i1/?=
 =?us-ascii?Q?DDeD8S5dX5xm8DQFjJhAtjKH8TXkiGVEn2pJrq8fKpuOGU99x4grzDUeHUYk?=
 =?us-ascii?Q?rnD9wQ5mJe/Er+F1cdLu8Mo1qz729tD7rJFHhf0MdEqt+/VWWL+yJUjyj04X?=
 =?us-ascii?Q?J9FHlVlmOR1uMXxnKd1XPxnId+iBNhGKu8uxcj3nMwKmYeJ39ugRiUFAHWu2?=
 =?us-ascii?Q?pFDSZ+aDK26+DVhL7TnZFnwkZaHJX65F0LgRItB2ux7VyKV2J0TAwXaUEsVk?=
 =?us-ascii?Q?e+i6BYcEZjULMTta5wQcXMCAFmn5gZH8kDlvCfZ1yE0+2gNc8bCZCPhdfRcc?=
 =?us-ascii?Q?lOFN1f51wczLpRB64PQiNID9/RxmeQi3fvw/AdjeOLex/B0TUElZmKdqz8JW?=
 =?us-ascii?Q?4ga9HN0eKa3m8cQsek1eYLdL+U6BzWR/Dk8ZMaJHzn/5sCUpbSeC0NSuz1Q+?=
 =?us-ascii?Q?R4Ki0+vMpYgbNvKyxXhfPyfd0Aoob2YwD5sB2lguGwJImkhi7Ugxss7qnhNM?=
 =?us-ascii?Q?ZmcCkyOrlo7g+ns82cglw0ASM35Plp4+VJVANjpacolW7yZ5Fp4k5qL35zLN?=
 =?us-ascii?Q?F+B0Hjww7Tif0jTA2hKwwHseJN7bVwsvW9D8vbrgN3Vp5Fw0fVzrf4okO6R3?=
 =?us-ascii?Q?5kjzeA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a3962a-9a06-4133-a15c-08db794f0db8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:47:44.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svYm81LRcO/5aNpy3XOE7ocVPe1KzcHzbuVhXb8Xpoa+qguy6H7J2iLDZKeTfHdFfIO9wkvPMpVX+G4G1Sy2MC3Iw/YWK1QwGu1G4ezjfQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4548
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 04:30:05PM -0400, Eric Garver wrote:
> This adds an explicit drop action. This is used by OVS to drop packets
> for which it cannot determine what to do. An explicit action in the
> kernel allows passing the reason _why_ the packet is being dropped. We
> can then use perf tracing to match on the drop reason.
> 
> e.g. trace all OVS dropped skbs
> 
>  # perf trace -e skb:kfree_skb --filter="reason >= 0x30000"
>  [..]
>  106.023 ping/2465 skb:kfree_skb(skbaddr: 0xffffa0e8765f2000, \
>   location:0xffffffffc0d9b462, protocol: 2048, reason: 196610)
> 
> reason: 196610 --> 0x30002 (OVS_XLATE_RECURSION_TOO_DEEP)
> 
> Signed-off-by: Eric Garver <eric@garver.life>

...

> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -32,6 +32,7 @@
>  #include "vport.h"
>  #include "flow_netlink.h"
>  #include "openvswitch_trace.h"
> +#include "drop.h"
>  
>  struct deferred_action {
>  	struct sk_buff *skb;
> @@ -1477,6 +1478,18 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  				return dec_ttl_exception_handler(dp, skb,
>  								 key, a);
>  			break;
> +
> +		case OVS_ACTION_ATTR_DROP:
> +			u32 reason = nla_get_u32(a);
> +
> +			reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
> +					SKB_DROP_REASON_SUBSYS_SHIFT;
> +
> +			if (reason == OVS_XLATE_OK)
> +				break;
> +
> +			kfree_skb_reason(skb, reason);
> +			return 0;
>  		}

Hi Eric,

thanks for your patches. This is an interesting new feature.

unfortunately clang-16 doesn't seem to like this very much.
I think that it is due to the declaration of reason not
being enclosed in a block - { }.

  net/openvswitch/actions.c:1483:4: error: expected expression
                          u32 reason = nla_get_u32(a);
                          ^
  net/openvswitch/actions.c:1485:4: error: use of undeclared identifier 'reason'
                          reason |= SKB_DROP_REASON_SUBSYS_OPENVSWITCH <<
                          ^
  net/openvswitch/actions.c:1488:8: error: use of undeclared identifier 'reason'
                          if (reason == OVS_XLATE_OK)
                              ^
  net/openvswitch/actions.c:1491:26: error: use of undeclared identifier 'reason'
                          kfree_skb_reason(skb, reason);
                                                ^
  4 errors generated.


net-next is currently closed.
So please provide a v2 once it reposts, after 10th July.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: changes-requested




