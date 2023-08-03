Return-Path: <netdev+bounces-23883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08A76DF60
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562C7281F5E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A48F4D;
	Thu,  3 Aug 2023 04:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C8F43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:19:28 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6630C7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:19:25 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-584034c706dso4597647b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 21:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691036365; x=1691641165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0zzGnjt7Wu0ixDUqDg8TT9LrntJpZeFLXXImCbHI6c=;
        b=CJ58bjA+l5IW0vAJ3SqQTg6Ct8J5UZlbn8A+rgjm3ajHtvZAFmnLG6iIjDdj8zypJG
         2n9pfFgKfeSjm6QHpV3hV8pjblPNSjW4oTcbsn9FNnJt3jVzcj61WZDD80YDEeieBARV
         Je+mMKDVEEEDl5vtSanZxD4QB4pJziBLhqGArxm/Z14WxwFP5+C2skCOCqmzzfbVaWhq
         xuUf5NHudIWvSeyWqhyujehvdasoGJTCgJXELjPP6j02zSFGZzF8Kqr5FaQ8LPIYNujG
         kl3w3iVZj3Qzzc1T4Q4fKYCNtoUK4FIR9i3aKNucsVJnAgK7wFKvc3E+5HkahhXFD/cu
         uT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691036365; x=1691641165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0zzGnjt7Wu0ixDUqDg8TT9LrntJpZeFLXXImCbHI6c=;
        b=c8gQTRS8OMucFhXAhVhHT2daIQzm2mHUCsDyR3v3AHwECAnrvgbXeW3baQKcLI0oUI
         DenzhgjduIJgTfGkjHLGhKOZuAfwVh0ZFjo08Q/5IC/JqfWn2EGSyKNMCWLnLxzQ7Cua
         jRuI1s3B7AruVvhcRY5+JxGTuux09tuLXoviHSIzR0dlGZkTC1TFkD1VNe6XLw+iYP6n
         QNUkX1I2QixYB6XVGs+YVksG7Sk/lPtnKrN8lgas43mC1MRZaBaVu0qNXUOMIN5qVUNH
         jg3vKgrAoaDm3wr7ve1jQZllSzh5qoadDpH7Hz4kXnfrgZbEP3QMky4xsteV8uBAJ7zU
         HBag==
X-Gm-Message-State: ABy/qLY7wwprrm5dUS1e7aQsG9XgZmFV1xJvSBYFicby3ldmtmJiERsU
	1lUmiONKw+GVs8wyrkMtXIo=
X-Google-Smtp-Source: APBJJlHa+qwvSXeZyxuav/vy33IqMiDY5lhIFBSaJMrC3EDuhNQfvjk509Fy7hXzfBEClepFbe/oJA==
X-Received: by 2002:a81:4f4b:0:b0:573:2e7a:1733 with SMTP id d72-20020a814f4b000000b005732e7a1733mr17939862ywb.45.1691036364726;
        Wed, 02 Aug 2023 21:19:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:8ee8:bf27:b43f:7fec? ([2600:1700:6cf8:1240:8ee8:bf27:b43f:7fec])
        by smtp.gmail.com with ESMTPSA id b4-20020a0dc004000000b00582b239674esm5094293ywd.129.2023.08.02.21.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 21:19:24 -0700 (PDT)
Message-ID: <efe86f7b-ae82-e3cd-f160-3d9ee0bfa05c@gmail.com>
Date: Wed, 2 Aug 2023 21:19:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v5 1/2] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230802004303.567266-1-thinker.li@gmail.com>
 <20230802004303.567266-2-thinker.li@gmail.com>
 <e8ca99dd-416a-f1a0-c858-1d8889a83592@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e8ca99dd-416a-f1a0-c858-1d8889a83592@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/2/23 19:00, David Ahern wrote:
> On 8/1/23 6:43 PM, thinker.li@gmail.com wrote:
>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>> index bac768d36cc1..3059e439817a 100644
>> --- a/net/ipv6/ip6_fib.c
>> +++ b/net/ipv6/ip6_fib.c
>> @@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
>>   			list_add(&rt->nh_list, &rt->nh->f6i_list);
>>   		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
>>   		fib6_start_gc(info->nl_net, rt);
>> +
>> +		if (fib6_has_expires(rt))
>> +			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
> 
> This should go before the start_gc.
Agree

