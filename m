Return-Path: <netdev+bounces-26972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7AD779B6F
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E5B281CB3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD53D3AE;
	Fri, 11 Aug 2023 23:38:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A4329D4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:38:14 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD982D78
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:37:52 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583d63ca1e9so27682967b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691797072; x=1692401872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kS4BCdiXQxk3QKRTryTAOXyP6uzOT3M9nTnk69RZEEM=;
        b=CKsamCvXTowAa0QUBKCBGXV8Mc+D4YUp9889uoWqDr1D31jR1peTf9ydmnQwXPI5tE
         lHKKFSGiOHr+7faSUJWmz3z80xQBKcCzuvPdGn6zA+FalZIJbq0idOq5QVnGhoM809VE
         3BPwsR7MjShP8tusNlYLWALEu2nmuW7P1ad9zdA3lcUIJYVohCdV5Mlx/3Me5ffuZqrt
         kd/ODweJ7MLM3dxTKEem9O6QB+LxuDYC5GSr4WUqOSf+6Ujc3U/L9HJ4FJixNplAWrdW
         j8l1Ye7JD6z/Tdyyxjy/CJhPTRFNVNNdzCJIDiJ3D52oyu7k/lWxOb/ZMMdt2C5b5qWQ
         Xhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797072; x=1692401872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kS4BCdiXQxk3QKRTryTAOXyP6uzOT3M9nTnk69RZEEM=;
        b=afiPByu1Z97XHqKSE4B10rMMbL+Rn8ypFi9SzW/DceR62MVrsbwWDvJtaLoukdy4fa
         3rpSJN8ySR/z9AIDuhONH3QfS1thLLcmURg1vERp4rRxQtRdVt3H5foIZPbP9TGTLOl0
         R4vBaBrOgmIyqo36vLXnsl+O78+m5BevwSO52k8IfNW8po/xBsbyg/6zhXl2AUCufbL6
         zsTT5aS+obVFYjzifVR59NuY/oj9WwW3C5OjdEgNncUZvE1WgnwgjiCCSSidrHWX16aw
         R8iumde+G0kRTxdMCDjaXarmvoRRgqP/8hVwnRisko+kzT0OOUov2N+ix7I5S+6kgJP3
         4aWQ==
X-Gm-Message-State: AOJu0Yw2Oi8DUM4cLLpUVQt6JFgIDF2bt4I26lb46df2MGBGmOv+M9Ay
	GZzziduaZ9U/D090VuaxI/w=
X-Google-Smtp-Source: AGHT+IGA2aPlQZt6Dj/durHp/9tqH1MfliTIzgN5IcL/C8aOOqy1bwXarcsQV5gFfbnfjNbAs98xOA==
X-Received: by 2002:a81:5e85:0:b0:583:76c2:6856 with SMTP id s127-20020a815e85000000b0058376c26856mr3708205ywb.24.1691797072171;
        Fri, 11 Aug 2023 16:37:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id x10-20020a0dd50a000000b0056d304e224dsm1296079ywd.90.2023.08.11.16.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:37:51 -0700 (PDT)
Message-ID: <81eec9d9-4e7d-fb67-505b-af244078cef3@gmail.com>
Date: Fri, 11 Aug 2023 16:37:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v6 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230808180309.542341-1-thinker.li@gmail.com>
 <20230808180309.542341-2-thinker.li@gmail.com>
 <c688e30b-8675-75e5-0874-e61398a565f5@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c688e30b-8675-75e5-0874-e61398a565f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 08:09, David Ahern wrote:
> On 8/8/23 12:03 PM, thinker.li@gmail.com wrote:
>> @@ -504,6 +500,49 @@ void fib6_gc_cleanup(void);
>>   
>>   int fib6_init(void);
>>   
>> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
>> + * NULL.
>> + */
>> +static inline void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	f6i->expires = expires;
>> +	if (tb6 && !fib6_has_expires(f6i))
>> +		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
>> +	f6i->fib6_flags |= RTF_EXPIRES;
>> +}
>> +
>> +/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
>> + * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
>> + * list of GC candidates until it is inserted into a table.
>> + */
>> +static inline void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
>> +{
>> +	spin_lock_bh(&f6i->fib6_table->tb6_lock);
>> +	fib6_set_expires_locked(f6i, expires);
>> +	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
>> +}
>> +
>> +static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
>> +{
>> +	struct fib6_table *tb6;
>> +
>> +	tb6 = f6i->fib6_table;
>> +	if (tb6 && fib6_has_expires(f6i))
>> +		hlist_del_init(&f6i->gc_link);
> 
> The tb6 check is not needed; if the fib6_info is on a gc list it should
> be removed here.

I will fix it.

> 
>> +	f6i->fib6_flags &= ~RTF_EXPIRES;
>> +	f6i->expires = 0;
>> +}
>> +
>> +static inline void fib6_clean_expires(struct fib6_info *f6i)
>> +{
>> +	spin_lock_bh(&f6i->fib6_table->tb6_lock);
>> +	fib6_clean_expires_locked(f6i);
>> +	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
>> +}
>> +
>>   struct ipv6_route_iter {
>>   	struct seq_net_private p;
>>   	struct fib6_walker w;
> 
> 
>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>> index bac768d36cc1..8e86b67fe5ef 100644
>> --- a/net/ipv6/ip6_fib.c
>> +++ b/net/ipv6/ip6_fib.c
>> @@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
>>   				    lockdep_is_held(&table->tb6_lock));
>>   		}
>>   	}
>> +
>> +	if (fib6_has_expires(rt)) {
>> +		hlist_del_init(&rt->gc_link);
>> +		rt->fib6_flags &= ~RTF_EXPIRES;
>> +	}
> 
> Use fib6_clean_expires_locked here.

Got it!

> 
> With those 2 changes:
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 
> 
> --
> pw-bot: cr

