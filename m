Return-Path: <netdev+bounces-55091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E435C809532
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9511F21035
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2FF840F4;
	Thu,  7 Dec 2023 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3jCoQzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D21709
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 14:19:14 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d74186170fso12179247b3.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987553; x=1702592353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZDrTBCi1WUCoZlsgsw77VcBIpBgpOe5X2Ytd0Bs+8=;
        b=j3jCoQzJztRvIqH2m9VHLfW1igOuFSU/jEYngKDSQUSF0z2x/3vr5aqoLZSDfZUpmr
         +HJ6cK7QGaWgzjuSRHGMY1SSQGvGE5uTmJjA33da7PLWKoW4ZRYJTWWQ55Gg6QsJrFI2
         hnFX893RxZSMtRzdp1ajGRugLPUYBbu5BEXqh1no8zekqattIwX60VV4F9uWSx2u7jiz
         vgKdqEdnLP5uZTpmeZzwB6NPRIlV1CjV5MtYSLLpQSp2GBBdPWmi+RtNq0x7Fbau9zGQ
         omV9beoBamWoYGtXvV9Gm25pEN5bDvT+Gb93lbrsBfr41xgJPz9f8+wH3d3WRaK1dsrI
         mwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987553; x=1702592353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvZDrTBCi1WUCoZlsgsw77VcBIpBgpOe5X2Ytd0Bs+8=;
        b=aJedrBH2kKPDbW8nmsSpfdonk64a5JhH1IaoxVmkfA+iX4K719MLVEDgFLrYpGlZIq
         uqOAjzPy8limBFIQ5C9xHaBlmOJNe5NxxqvU1C1FiAXfLDRHWTr8oAeDZ2Q02v3Tlke1
         OFyBEQMRADq/+BUvqzO+G+YyACryChX+EYh5ef4vrl+vKwy66wqM0ZbN6eRgKmdx98sV
         3XlVBQtgA98tSfs9GZ5rE2pap2KzKcDd04+adDPGaQOu1XxzFOLxQMwPvSjVW/+olOaD
         rCz5DCmpw3u8aqaJQ/hUlWAuUWGSfmtcWFGeZ8s7UF5aOErQtAMjzYniKcIQW2/ohFRv
         Op0A==
X-Gm-Message-State: AOJu0Yw7/uWXWniQBz1mAXW08lxcvxK8AO3JkvZBt8WNfEefhaOjD4jW
	xw35WEEoX5bdqEmfJEXkq20=
X-Google-Smtp-Source: AGHT+IHHN+UA9JhLl7FXDbLayjC39Zk6hJKQHM5dEd8JYfoOZuwilw1Y4LJp6OUKS7qWB+oelxD8JQ==
X-Received: by 2002:a0d:ec49:0:b0:5ca:6f39:91d1 with SMTP id r9-20020a0dec49000000b005ca6f3991d1mr3062975ywn.47.1701987553596;
        Thu, 07 Dec 2023 14:19:13 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id y4-20020a0def04000000b005a7daa09f43sm202390ywe.125.2023.12.07.14.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 14:19:13 -0800 (PST)
Message-ID: <2b89a3c1-59fe-4ba6-82de-6f01fbdcdb7f@gmail.com>
Date: Thu, 7 Dec 2023 14:19:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
To: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231207221627.746324-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Eric Dumazet, could you help to check if the patch works from your side
with syzbot? Thanks a lot!


On 12/7/23 14:16, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Check f6i->fib6_node before inserting a f6i (fib6_info) to tb6_gc_hlist.
> 
> Previously, it checks only if f6i->fib6_table is not NULL, however it is
> not enough. When a f6i is removed from a fib6_table, it's fib6_table is not
> going to be reset. fib6_node is always reset when a f6i is removed from a
> fib6_table and set when a f6i is added to a fib6_table. By checking
> fib6_node, adding a f6i t0 tb6_gc_hlist only if f6i is in the table will be
> enforced.
> 
> Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes.")
> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: dsahern@kernel.org
> ---
>   include/net/ip6_fib.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 95ed495c3a40..8477c9ff67ac 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -512,7 +512,10 @@ static inline void fib6_set_expires_locked(struct fib6_info *f6i,
>   
>   	tb6 = f6i->fib6_table;
>   	f6i->expires = expires;
> -	if (tb6 && !fib6_has_expires(f6i))
> +	if (tb6 &&
> +	    rcu_dereference_protected(f6i->fib6_node,
> +				      lockdep_is_held(&tb6->tb6_lock)) &&
> +	    !fib6_has_expires(f6i))
>   		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
>   	f6i->fib6_flags |= RTF_EXPIRES;
>   }

