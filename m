Return-Path: <netdev+bounces-44495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3F7D84D0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11041C20EE2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02814279;
	Thu, 26 Oct 2023 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471872EAF5
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:33:33 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FD01AA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:33:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 557E320826;
	Thu, 26 Oct 2023 16:33:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CdoS2Nqey8b; Thu, 26 Oct 2023 16:33:28 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D48A220520;
	Thu, 26 Oct 2023 16:33:28 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id D205C80004A;
	Thu, 26 Oct 2023 16:33:28 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 26 Oct 2023 16:33:28 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 16:33:28 +0200
Date: Thu, 26 Oct 2023 16:33:22 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: Antony Antony <antony@phenome.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next v3 0/3] xfrm: policy: replace session decode
 with flow dissector
Message-ID: <ZTp4dDaWejic16eT@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20231004161002.10843-1-fw@strlen.de>
 <ZSUCdEwwb/+scrH7@gauss3.secunet.de>
 <ZTpXmUH_GQ0FVD7a@Antony2201.local>
 <20231026125748.GA22233@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026125748.GA22233@breakpoint.cc>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Oct 26, 2023 at 14:57:48 +0200, Florian Westphal wrote:
> Antony Antony <antony@phenome.org> wrote:
> > > > Florian Westphal (3):
> > > >   xfrm: pass struct net to xfrm_decode_session wrappers
> > > >   xfrm: move mark and oif flowi decode into common code
> > > >   xfrm: policy: replace session decode with flow dissector
> > > 
> > > Series applied, thanks a lot Florian!
> > > 
> > 
> > Hi Steffen,
> > 
> > I would like to report a potential bug that I've encountered while working
> 
> s/potential//
> 
> Does this patch make things work for you again?  Thanks!
> 
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 6aea8b2f45e0..e8c406eba11b 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -3400,11 +3400,18 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
>  		fl4->fl4_dport = flkeys->ports.dst;
>  	}
>  
> +	switch (flkeys->basic.ip_proto) {
> +	case IPPROTO_GRE:
> +		fl4->fl4_gre_key = flkeys->gre.keyid;
> +		break;
> +	case IPPROTO_ICMP:
> +		fl4->fl4_icmp_type = flkeys->icmp.type;
> +		fl4->fl4_icmp_code = flkeys->icmp.code;
> +		break;
> +	}
> +
>  	fl4->flowi4_proto = flkeys->basic.ip_proto;
>  	fl4->flowi4_tos = flkeys->ip.tos;
> -	fl4->fl4_icmp_type = flkeys->icmp.type;
> -	fl4->fl4_icmp_type = flkeys->icmp.code;
> -	fl4->fl4_gre_key = flkeys->gre.keyid;
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -3427,10 +3434,17 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
>  		fl6->fl6_dport = flkeys->ports.dst;
>  	}
>  
> +	switch (flkeys->basic.ip_proto) {
> +	case IPPROTO_GRE:
> +		fl6->fl6_gre_key = flkeys->gre.keyid;
> +		break;
> +	case IPPROTO_ICMP:
> +		fl6->fl6_icmp_type = flkeys->icmp.type;
> +		fl6->fl6_icmp_code = flkeys->icmp.code;
> +		break;
> +	}
> +
>  	fl6->flowi6_proto = flkeys->basic.ip_proto;
> -	fl6->fl6_icmp_type = flkeys->icmp.type;
> -	fl6->fl6_icmp_type = flkeys->icmp.code;
> -	fl6->fl6_gre_key = flkeys->gre.keyid;
>  }
>  #endif
>  

Tested-by: Antony Antony <antony.antony@secunet.com>

Thanks,
-antony


