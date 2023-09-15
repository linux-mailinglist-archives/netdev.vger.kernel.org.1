Return-Path: <netdev+bounces-34105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C07A21D4
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52C31C20C77
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30771094D;
	Fri, 15 Sep 2023 15:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6630CE1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:03:50 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61DD2700
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:03:48 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1d63d38c74fso941560fac.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694790228; x=1695395028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QuR5EL2rWJkRLavg2k1/tu2otrCw04kaMnRKDKgbJ+Q=;
        b=3fH6EJwOAl8laOE5A1RQebuMu3N0odAPSDjqRsodOixI6VpbHeuEVTcH0WDj8wNwAp
         TD0PIRJ2/hKfjQgt6XtQJWyr4nx4v7VYJ1ac4QhycafaYv0jyEFuBr8EmgbFsmVSIV6r
         A1DIVbXsajWJhFD3szoC8ukgwbiKcwQ29pnoDT2E/aqdoJFQmqQ2rGOARhCvlIDdex/k
         IxwSQEAFjsN+osYqQYHzCvKlOyh0QtSDWmoxJABU/uVGuERYlV8o+xUPsSD5lIlfe9rw
         Q/HJC5ht/RzTNGwRWltio1g46qEgzkSsPA/utS2DKIAemhtPIk4X6XUrIOZPLt9TGNIX
         NWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790228; x=1695395028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuR5EL2rWJkRLavg2k1/tu2otrCw04kaMnRKDKgbJ+Q=;
        b=oX7kL1Yj4lacgj/ELAeLtlQFTC0aouCbL8qM8TlK4pS8+M5/YbU2QXa5xSQa14ZPUy
         Nm2YSlkaulrx/n+mcL6/cEsVSw83Tv3rQ/TpAvIYcbZIxsRmHQCWeRqliiDH0z2QASnF
         H0V56ADm9fI67K1qMJavlMsX2/QBzeh+R54QKt1tJA5LK/T5lDeJAup8pYRYVWCMDOTM
         gTfayo0jNe1FGPZdvoZVH9jxWruJZ9IM/AcMsCZlHLTsmq+Hb3cV5XBIjck45dnTK1mZ
         z3gefOmifL5mpKjoYp7rjKslJnsEtZFL0ry57B7YbaaDE7KRIk75o4+7FabxwMNVGaTN
         o2MQ==
X-Gm-Message-State: AOJu0YzP/ZkdKDs/ObGUxYAYRpu/C05DPn8eCgajSixDJOPZZlj1dYL/
	uNhoiDqUJJe6fCc29gU32NVDKA==
X-Google-Smtp-Source: AGHT+IFGfCzPm3r8rRcHwusuzchiQs9XQ59VKX9HVlEn5tdcz3z+R1CXptn7YRKQNMU8yYqnjqjAUg==
X-Received: by 2002:a05:6870:c107:b0:1d6:5c40:11b5 with SMTP id f7-20020a056870c10700b001d65c4011b5mr1932975oad.48.1694790227791;
        Fri, 15 Sep 2023 08:03:47 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:d000:fc98:e3cb:dac1? ([2804:14d:5c5e:44fb:d000:fc98:e3cb:dac1])
        by smtp.gmail.com with ESMTPSA id h2-20020a056870d34200b001d4f6fd16b8sm1939883oag.49.2023.09.15.08.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:03:47 -0700 (PDT)
Message-ID: <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
Date: Fri, 15 Sep 2023 12:03:42 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to
 drop
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Ma Ke <make_ruc2021@163.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/09/2023 09:55, Eric Dumazet wrote:
> On Fri, Sep 15, 2023 at 12:42 PM Ma Ke <make_ruc2021@163.com> wrote:
>>
>> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
>> assume res.class contains a valid pointer.
>>
>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>> ---
>>   net/sched/sch_drr.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
>> index 19901e77cd3b..2b854cb6edf9 100644
>> --- a/net/sched/sch_drr.c
>> +++ b/net/sched/sch_drr.c
>> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>>          *qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>>          fl = rcu_dereference_bh(q->filter_list);
>>          result = tcf_classify(skb, NULL, fl, &res, false);
>> +       if (result == TC_ACT_SHOT)
>> +               return NULL;
>>          if (result >= 0) {
>>   #ifdef CONFIG_NET_CLS_ACT
>>                  switch (result) {
>> --
>> 2.37.2
>>
> 
>   I do not see a bug, TC_ACT_SHOT is handled in the switch (result) just fine
> at line 320 ?

Following the code path (with CONFIG_NET_CLS_ACT=n in mind), it looks 
like there are a couple of places which return TC_ACT_SHOT before 
calling any classifiers, which then would cause some qdiscs to look into 
a uninitialized 'struct tcf_result res'.
I could be misreading it... But if it's the problem the author is trying 
to fix, the obvious way to do it would be:
	struct tcf_result res = {};

