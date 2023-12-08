Return-Path: <netdev+bounces-55137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9580985C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AB4B20CFF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAED382;
	Fri,  8 Dec 2023 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Boww4KdH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1980D59
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 17:04:01 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-db632fef2dcso1715982276.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 17:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701997441; x=1702602241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfrVzIawfOOMc9Jsjs6ZujvbaaB234VtH06eeSOrf9c=;
        b=Boww4KdHQDFgJjsyb0435lZFLi1hxpKxaxYuIQFr/R6BSlNu2aql6zS2tTe2wvv7WE
         n4UMM193MdtvNbTWBXRLSoBPmgEPoG73m1qKAQC/Kd2wENRv1oZwftzqBf11Zv0G98sS
         zyNmuBQT5BNPuItqoNZ9e5HJNe3T+0KVlvX9UYefwvhJnTlNT5LOgvaPt8CBzQwXku1B
         FZy7FOpCot3qAu1mgz6mavWn6ms7Grg48SMh61bJqNL85Cwieq30v4MshWBBdHa1P9jb
         mh/0kaRIA1olBSejDA89BngtXyozRON57dI/OfTFAHGP0jX32FLpfpTd0Utjs9BtPp9R
         5s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997441; x=1702602241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfrVzIawfOOMc9Jsjs6ZujvbaaB234VtH06eeSOrf9c=;
        b=ADPcjjTaBfXOTz5W1HOSVnwVJwrAt3mPBAfixRhdp4VjRNTWTfA/2BNFKVJ1sIfOFk
         sxXhca1uv2dttPhYssTdvf6mLQp42XWtl974qOywkyXeTstd2RutopwktvzMfuGAqGnT
         rbS9pRZ0k61ls8xMqFwA9lFNvHnuuLaAIiTHUmvuUS3yosjSS4XIQUOvgeULpbvsWwrv
         Xl/dxQtGMcnEIgb1xCQg2PuQnskgmDPaFuhP/1GOrAOGJlo4uc1RCReU3uvM4O2ANsf4
         Xne3yqBW+cn5Lm+dRlvXlwG156KXDSWFMFDOGzjlvNffQJY+wUAtOUF2VJ3pt0VoCTyG
         m2zg==
X-Gm-Message-State: AOJu0YzskGR5Ctpf4WiPsQhRjF5nui2sW3sNrsll6YQk6fHOICDbAzc4
	DqID1F5CzcRE6OSGiGrezhE=
X-Google-Smtp-Source: AGHT+IFrMhwk75o/YDtrmrA+dOOJL7rKGyTRrJs6zJ70bUyZ5a+xzjAb0adxBMCQL7V1VYOGNNOSGA==
X-Received: by 2002:a05:6902:343:b0:db7:dacf:59ee with SMTP id e3-20020a056902034300b00db7dacf59eemr2766618ybs.98.1701997440861;
        Thu, 07 Dec 2023 17:04:00 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id a12-20020a25938c000000b00d9ac1f0e23csm273463ybm.56.2023.12.07.17.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 17:04:00 -0800 (PST)
Message-ID: <fae47538-b8f8-4b26-86d3-e34aa770b10f@gmail.com>
Date: Thu, 7 Dec 2023 17:03:59 -0800
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

The following is the result from syzbot for my branch with this patch.

--------------
Hello,

syzbot has tested the proposed patch and the reproducer did not trigger 
any issue:

Reported-and-tested-by: 
syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com

Tested on:

commit:         ac408ca0 net/ipv6: insert the fib6 gc_link of a fib6_i..
git tree:       https://github.com/ThinkerYzu/linux.git 
fix-fib6_set_expires_locked
console output: https://syzkaller.appspot.com/x/log.txt?x=14a55d1ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for 
Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
--------------

How often can syzbot reproduce the issue described in [1]?


[1] 
https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/

