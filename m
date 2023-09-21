Return-Path: <netdev+bounces-35455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCF7A98EE
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD61F21220
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694BB42BE1;
	Thu, 21 Sep 2023 17:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7E3F4DE
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:22:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF651F6D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695316622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VV2Jy8D27AGJ4H33dSAMhZHagSoBEeiHRjtR8tNkxkM=;
	b=foRgbW71HUA+e1Lwmoi5VWCLIwAVUxH7ZRK2BkoT5pTpSVz6ap0uYAuWW4EaSG35wi0zbZ
	Dvm5ZceJm+yDaHyv6YXPg1ikcZA+xYDkvNQIwwjnKV+CJRsDXIR+b4b7vXED1yy2QSH2B7
	JAPSFXO7Huglfmo/Uux2xZBFIrfoWaQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-XdHzkNBxMi2vydvSVzrxLQ-1; Thu, 21 Sep 2023 03:46:19 -0400
X-MC-Unique: XdHzkNBxMi2vydvSVzrxLQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae5f4ebe7eso12408866b.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 00:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695282378; x=1695887178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV2Jy8D27AGJ4H33dSAMhZHagSoBEeiHRjtR8tNkxkM=;
        b=a+sqNOXvi0Z2bOocTOtKe8ALucE3UIcYVUcO+H9xGdqCiKvz0tBpm+Tjuuus922hg5
         OlYpAN0J8Nf4t0zt3CVUMGbHBM5fHJU7GJWhuAdmbh33AHAmwubNZM/AEbKn8AijBz77
         Re0q4E+sgvW7UyAXVT+ML1gMogG8vyUH6slzfNx5LnRklx1rEZqbnCDBy7Yh10fYOQwe
         Kh0K/sF3dngud7ZIzioIRyWNVxKaT0cRw8oe7Is7Kw/rWX1Dj/r6JUzGj9LtxNiPtHY8
         2o5XRHkFE6JDwX+ozg3Dp2iFtoBaIO/yZFhX0zrAfmRDq6Z4H5fgqGMxgFkMhKGQSDrw
         y7Ow==
X-Gm-Message-State: AOJu0YxLXNUQXKGspmWu/ptCCg5x1WN/D+Cs1eMDghVCKncL25hMlH2z
	ICL/EdowOVDKU8z02BPflLbA9oOEcim7AIwKVxByDZZAOzmjkpKKBZ22ks3MlfONF7GLWsjmcLJ
	DP5mOMGzPK1NIi34bMFG8O2Ip
X-Received: by 2002:a17:906:519a:b0:9ae:420e:739e with SMTP id y26-20020a170906519a00b009ae420e739emr3922305ejk.5.1695282378248;
        Thu, 21 Sep 2023 00:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtGL/wMfHTsnMSw6+AJDkImYBbLG4TE1upxol53ylfpmYd2SErx8iHjPWhBnCkgf1pTfeeJA==
X-Received: by 2002:a17:906:519a:b0:9ae:420e:739e with SMTP id y26-20020a170906519a00b009ae420e739emr3922279ejk.5.1695282377846;
        Thu, 21 Sep 2023 00:46:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id l15-20020a1709067d4f00b009920a690cd9sm637133ejp.59.2023.09.21.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:46:17 -0700 (PDT)
Message-ID: <ba51c689c1954219c2cea904dc71eb1f0a721c29.camel@redhat.com>
Subject: Re: [PATCH v2] net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS
 increment after fragment check
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Guo <heng.guo@windriver.com>, davem@davemloft.net,
 sahern@kernel.org,  edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, filip.pudak@windriver.com
Date: Thu, 21 Sep 2023 09:46:16 +0200
In-Reply-To: <20230919093803.56034-2-heng.guo@windriver.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
	 <20230919093803.56034-1-heng.guo@windriver.com>
	 <20230919093803.56034-2-heng.guo@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 17:38 +0800, Heng Guo wrote:
> diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
> index 66fac1216d46..acba24fc000f 100644
> --- a/net/ipv4/ip_forward.c
> +++ b/net/ipv4/ip_forward.c
> @@ -66,8 +66,6 @@ static int ip_forward_finish(struct net *net, struct so=
ck *sk, struct sk_buff *s
>  {
>  	struct ip_options *opt	=3D &(IPCB(skb)->opt);
> =20
> -	__IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);
> -
>  #ifdef CONFIG_NET_SWITCHDEV
>  	if (skb->offload_l3_fwd_mark) {
>  		consume_skb(skb);
> @@ -130,6 +128,8 @@ int ip_forward(struct sk_buff *skb)
>  	if (opt->is_strictroute && rt->rt_uses_gateway)
>  		goto sr_failed;
> =20
> +        __IP_INC_STATS(net, IPSTATS_MIB_OUTFORWDATAGRAMS);

The above is white-space damaged - uses spaces instead of tab.

Please fix it.

Also IMHO this is net-next material, please specify accordingly the
target tree into the subj line.

Thanks,

Paolo


