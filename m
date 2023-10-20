Return-Path: <netdev+bounces-42911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E837D0978
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651EA2823A3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A8D2ED;
	Fri, 20 Oct 2023 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="YTUKyOrG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D1D2E9
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:24:38 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F593
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:24:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso9355155e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1697786675; x=1698391475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r8pT1s1kfw0GJwmKhQGn88Ip0iEpewkZfNcKow1l4UE=;
        b=YTUKyOrGAE1DvKgFBm89ifys9gdWKSAnG8pbHdrQHwm+AgVvLFGN5I6MGVHDr1sRnS
         Br1IPajYKtu6Lyul9onmgAYDRsxN8vDcDrzHmPU2WwY4KWMd6YcCviV8M/HvC4WA8u9n
         jkf/m2tS0FPA1edpTPDgWe8FiYskUWhb5Fdse2dCP8Y1OGi2ekXgTDnABzIBFdVyj2Js
         qYgwT0wmVmw6B0DJPebBaGhSVdUckjPJk+JdkjFSr4zU+JtjomW75uMi7126Kfmmph5f
         2ZDFIR212kMmy5EIAu1gYrxoWqzJuiHXDQJbOW6rq6S9rt1T/fLdNST6GGP/AdHOVm86
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786675; x=1698391475;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8pT1s1kfw0GJwmKhQGn88Ip0iEpewkZfNcKow1l4UE=;
        b=WfWELACBxMzh+rhK2AL+7L4sBWRI+QlVrFk1NmStNoh7anw8LICrdW3l4K3Zrw1C39
         6GbmMWRO9bzCA6gJn0q92MvI0oJmO+DdUtpzl678xn5BqfFK+WStUEjoiz9Onv3DtFud
         z8/PyTFc1p7HbeWlqKu/QbHCfQWA2Fz5AjqveO2HzW/PeeKsm/X+MLRnDp748547tfeP
         OzzS6P9fR4PNrM3bveOz1TyMReoDvOUsihC3gP3K+wE+68KDBj3KXsrTn4eUF79udyYB
         MKrpsmCzwCnaRsMHzJ9Lsb6PwNNSVP2kzFviRhgSwyifYahJb7P803JKrOOZ6IfXZK33
         F2YQ==
X-Gm-Message-State: AOJu0YzXDueYG/WF+8RMHdBsHSNEw2IxaWHpBuM2OqGHJo0Tp8cEKW1Z
	rWz0EkFARlwEWfcteSUUDemD6Q==
X-Google-Smtp-Source: AGHT+IHjLzkWkbS4gDN5abkloPHZhvpXu91Mtc7ljOj1ESpZgHcX2SyfWrz4Qwk+DYmnIhh8H10Erw==
X-Received: by 2002:a05:600c:46d1:b0:3fe:1fd9:bedf with SMTP id q17-20020a05600c46d100b003fe1fd9bedfmr847152wmo.11.1697786675604;
        Fri, 20 Oct 2023 00:24:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:4cb:3d1b:4444:11a6? ([2a01:e0a:b41:c160:4cb:3d1b:4444:11a6])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040775fd5bf9sm1508944wmq.0.2023.10.20.00.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:24:35 -0700 (PDT)
Message-ID: <62714d2c-8afc-4d9b-b8b2-85f9caf18eeb@6wind.com>
Date: Fri, 20 Oct 2023 09:24:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/3] netlink: add variable-length / auto integers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 johannes@sipsolutions.net, stephen@networkplumber.org, jiri@resnulli.us
References: <20231018213921.2694459-1-kuba@kernel.org>
 <20231018213921.2694459-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231018213921.2694459-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/10/2023 à 23:39, Jakub Kicinski a écrit :
> We currently push everyone to use padding to align 64b values
> in netlink. Un-padded nla_put_u64() doesn't even exist any more.
> 
> The story behind this possibly start with this thread:
> https://lore.kernel.org/netdev/20121204.130914.1457976839967676240.davem@davemloft.net/
> where DaveM was concerned about the alignment of a structure
> containing 64b stats. If user space tries to access such struct
> directly:
> 
> 	struct some_stats *stats = nla_data(attr);
> 	printf("A: %llu", stats->a);
> 
> lack of alignment may become problematic for some architectures.
> These days we most often put every single member in a separate
> attribute, meaning that the code above would use a helper like
> nla_get_u64(), which can deal with alignment internally.
> Even for arches which don't have good unaligned access - access
> aligned to 4B should be pretty efficient.
> Kernel and well known libraries deal with unaligned input already.
> 
> Padded 64b is quite space-inefficient (64b + pad means at worst 16B
> per attr vs 32b which takes 8B). It is also more typing:
> 
>     if (nla_put_u64_pad(rsp, NETDEV_A_SOMETHING_SOMETHING,
>                         value, NETDEV_A_SOMETHING_PAD))
> 
> Create a new attribute type which will use 32 bits at netlink
> level if value is small enough (probably most of the time?),
> and (4B-aligned) 64 bits otherwise. Kernel API is just:
> 
>     if (nla_put_uint(rsp, NETDEV_A_SOMETHING_SOMETHING, value))
> 
> Calling this new type "just" sint / uint with no specific size
> will hopefully also make people more comfortable with using it.
> Currently telling people "don't use u8, you may need the bits,
> and netlink will round up to 4B, anyway" is the #1 comment
> we give to newcomers.
> 
> In terms of netlink layout it looks like this:
> 
>          0       4       8       12      16
> 32b:     [nlattr][ u32  ]
> 64b:     [  pad ][nlattr][     u64      ]
> uint(32) [nlattr][ u32  ]
> uint(64) [nlattr][     u64      ]
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

