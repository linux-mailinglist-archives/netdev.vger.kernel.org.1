Return-Path: <netdev+bounces-45739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A297DF4C9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32C281ABD
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF361B28C;
	Thu,  2 Nov 2023 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fMNYqOei"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252819BC2
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:19:29 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65C12D
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 07:19:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso12457785e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1698934762; x=1699539562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGCcsNJEZ1WAFmjraApH761w2N1/YB+/0qgHvh23Dhs=;
        b=fMNYqOei8PS2pvu2eYlZjbMGHwVJEXVunNqT/Egn7fyUpOf6dtAehD7F9/OfRl8AXd
         QE7jWt02P2wx0KZUdI19Us6dyX6CT6tlKKfFij3IbMW3Jo+nnmHctx5ozb3oRgBAvp42
         Wrk9bQnjcgJItQvjnI0zV9yc5rulqzfBbsbhrJQFyfBBE5nKyGdjTb/6y6bgzq5OcjJf
         bUQOw7ao6s78lF2mBrDjSvZgnH5x47IYXVRUVtReK5ykSGj1bnN+yYCIoNxQpSEK6N/p
         dG4bhkNkU5Bg30/OGLvXL1PNgsVsfiZq3iqCbXst42UFx1d7kBvOA54cNEuodIjsT9px
         dPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934762; x=1699539562;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGCcsNJEZ1WAFmjraApH761w2N1/YB+/0qgHvh23Dhs=;
        b=M7UE5r12wQms9zUW2QRqnopkvCuzbJxrvmOVD4fK1NPS7Hgf1RbspPdhIR49ziZSck
         nmHKTs5RKLCEwGBY6l59E4ZhGOWdvGQoEk8B2fM87UkiIzfBLull2jYSomHC/fVzHy0e
         W0pfAUhaezBKAtQrYK3415PE2MHT7Uly4+QB24amOfn5Ib2wtEFlTZfObpTgPONrU9J9
         9HWMoRnsOsx3CQr+r97js+2HJkmm6bSvmCk2jGqcbRTg6sw1+ceOA/2xFdYGCjKshFb+
         GjMJj0rf5oKCpYFElrf9p3K2rTznWzf3tcj51B8HyFicgi9MM4+wLdi5iBY1ZVLVgTkm
         aNTA==
X-Gm-Message-State: AOJu0Yxr16r9VtmO3zKMUbvrDVKBhYL8Kdsii08q1vRY/cIX8UAr80Ot
	MzK0Kqm1/omL0taGaL4WtIvFRg==
X-Google-Smtp-Source: AGHT+IFFHyc/HXDjKsNe5SPOkeKwkiAUxXYYUjZdqDGG02orb8ZoesxI9+2FNgBSVuNAjUFk/uy2/Q==
X-Received: by 2002:a05:600c:4f49:b0:405:3924:3cad with SMTP id m9-20020a05600c4f4900b0040539243cadmr10618987wmq.15.1698934762119;
        Thu, 02 Nov 2023 07:19:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:9ba7:9bce:3d04:2592? ([2a01:e0a:b41:c160:9ba7:9bce:3d04:2592])
        by smtp.gmail.com with ESMTPSA id o9-20020adfeac9000000b0032f7cc56509sm2552746wrn.98.2023.11.02.07.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:19:21 -0700 (PDT)
Message-ID: <fc356b9d-d7fc-4db8-b26c-8c786758d3e5@6wind.com>
Date: Thu, 2 Nov 2023 15:19:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net: ipmr_base: Check iif when returning a (*, G) MFC
Content-Language: en-US
To: Yang Sun <sunytt@google.com>, Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20231031015756.1843599-1-sunytt@google.com>
 <ZUNxcxMq8EW0cVUT@shredder>
 <CAF+qgb4gW8vBb8c2xDHfsXsm1-O2KCwXMCTUcT2mYqED51fHoQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <CAF+qgb4gW8vBb8c2xDHfsXsm1-O2KCwXMCTUcT2mYqED51fHoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/11/2023 à 12:48, Yang Sun a écrit :
>> Is this a regression (doesn't seem that way)? If not, the change should
>> be targeted at net-next which is closed right now:
> 
>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> I see.
> 
>>> - if (c->mfc_un.res.ttls[vifi] < 255)
>>> + if (c->mfc_parent == vifi && c->mfc_un.res.ttls[vifi] < 255)
> 
>> What happens if the route doesn't have an iif (-1)? It won't match
>> anymore?
> 
> Looks like the mfc_parent can't be -1? There is the check:
>     if (mfc->mf6cc_parent >= MAXMIFS)
>         return -ENFILE;
> before setting the parent:
>     c->_c.mfc_parent = mfc->mf6cc_parent;
> 
> I wrote this patch thinking (*, G) MFCs could be per iif, similar to the
> (S, G) MFCs, like we can add the following MFCs to forward packets from
> any address with group destination ff05::aa from if1 to if2, and forward
> packets from any address with group destination ff05::aa from if2 to
> both if1 and if3.
> 
> (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
> (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved
> 
> But reading Nicolas's initial commit message again, it seems to me that
> (*, G) has to be used together with (*, *) and there should be only one
> (*, G) entry per group address and include all relevant interfaces in
> the oifs? Like the following:
> 
> (::, ::)         Iif: if1 Oifs: if1 if2 if3   State: resolved
> (::, ff05::aa)   Iif: if1 Oifs: if1 if2 if3   State: resolved
> 
> Is this how the (*, *|G) MFCs are intended to be used? which means packets
> to ff05::aa are forwarded from any one of the interfaces to all the other
> interfaces? If this is the intended way it works then my patch would break
> things and should be rejected.
Yes, this was the intend. Only one (*, G) entry was expected (per G).

> 
> Is there a way to achieve the use case I described above? Like having
> different oifs for different iif?
Instead of being too strict, maybe you could try to return the 'best' entry.

#1 (::, ff05::aa)      Iif: if1 Oifs: if1 if2  State: resolved
#2 (::, ff05::aa)      Iif: if2 Oifs: if1 if2 if3  State: resolved

If a packet comes from if2, returns #2, but if a packet comes from if3, returns
the first matching entry, ie #1 here.


Regards,
Nicolas

