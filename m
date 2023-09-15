Return-Path: <netdev+bounces-34201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9657A2ACB
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 00:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D87281C62
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15061B292;
	Fri, 15 Sep 2023 22:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463A1B277
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 22:58:26 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE09FAF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:58:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3aca1543608so1759036b6e.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694818703; x=1695423503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WHC5fOtD0kGcTh6VRyI5qWBD4SEzsqeup1TPivNbvs=;
        b=OdjkJiyFMrXalMwrXFau6hKQVB52qNz8EVi7lqutJseRpsRVgx718mLPbjfFbtNWO8
         oJowf/xE2+a4Zu148KBUGpT6wvPY98UgCSWWguqq1A8f2q6IKmfG7YKNWjrGeHqWyDB1
         WDovKENnv+5nkUxFYuN83PLo5dYrUI3aHWxmllrDzfBsKkryVukMpi7IHTAE4MFtdz9O
         Tm6/uoPYld4V1aAc2/VFLe6ko+jrj8BrrpN2V8HyB/vsJJ3ya5Lluf3DZZDW9tqq1kKp
         g8JnvCaf7jPPz27uklAq8U87Oa1EEYM7sRma4Olak5LRJBmBCKANh8huPqfYXrLTzd0W
         5C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818703; x=1695423503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WHC5fOtD0kGcTh6VRyI5qWBD4SEzsqeup1TPivNbvs=;
        b=ZKnL1xUshuJfZ5EGSaAG7wabB1yiKriGwITByOb7C+ui4240M3xsberLu7SUvXqUO2
         WRBxe6fKbUM6gpyjpDvb2ev9rcJ1tytmdJeDLjorgP+EGi9Nv1TagkwpR9FvN05iNnnQ
         fceTO9mBr3B2U2Ij1LgZch7e3jQ4JWb/B/J9R2QR0+GM40+uLdbEIe+6G1rRvtZiskqw
         CmUcjY1NV8nRQet9U3cipKhjY9Rmtf2A5DGvE0q8NqzpPMkk8qAR1woYJ3gdb/J4mMzg
         t7rwAKzEo2GvnE+4jJmFi/piPIUicQCEVOtIir55CVGP28X4doPweIYhp3/tHEeZL3n4
         Y3JA==
X-Gm-Message-State: AOJu0YxKBvN2Q92QiHFrD9oEoHwkX8U/4sKqgrW/L+hhwJFFhbGcROgr
	dN1kKoYiRzkZpI6hIUGKE6fEng==
X-Google-Smtp-Source: AGHT+IEuqrYQMqef82/PipZbhtXVCMFgEyXx7i3f2X9kjkSxUC9q1/Eud8UjS7MXweE4dh5yn2uVXg==
X-Received: by 2002:a05:6808:aa8:b0:3a7:4f89:5b6d with SMTP id r8-20020a0568080aa800b003a74f895b6dmr2995025oij.58.1694818702982;
        Fri, 15 Sep 2023 15:58:22 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c2:58f9:c053:39fb:8dc4:3de5? ([2804:7f1:e2c2:58f9:c053:39fb:8dc4:3de5])
        by smtp.gmail.com with ESMTPSA id c21-20020aca1c15000000b003a9a28f6ec7sm1994473oic.52.2023.09.15.15.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 15:58:22 -0700 (PDT)
Message-ID: <4deec0bc-1eee-4853-8683-767a278f9e0a@mojatatu.com>
Date: Fri, 15 Sep 2023 19:58:18 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to
 drop
To: Jamal Hadi Salim <jhs@mojatatu.com>, Eric Dumazet <edumazet@google.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, Ma Ke <make_ruc2021@163.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com>
 <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
 <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
 <CAM0EoMmzCBewv4hfWQrNb+gaO_+aR7jnMbsQScN+FEchTdWXmw@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMmzCBewv4hfWQrNb+gaO_+aR7jnMbsQScN+FEchTdWXmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 15/09/2023 19:55, Jamal Hadi Salim wrote:
> On Fri, Sep 15, 2023 at 11:06 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Sep 15, 2023 at 5:03 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>>
>>> On 15/09/2023 09:55, Eric Dumazet wrote:
>>>> On Fri, Sep 15, 2023 at 12:42 PM Ma Ke <make_ruc2021@163.com> wrote:
>>>>>
>>>>> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
>>>>> assume res.class contains a valid pointer.
>>>>>
>>>>> Signed-off-by: Ma Ke <make_ruc2021@163.com>
>>>>> ---
>>>>>    net/sched/sch_drr.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
>>>>> index 19901e77cd3b..2b854cb6edf9 100644
>>>>> --- a/net/sched/sch_drr.c
>>>>> +++ b/net/sched/sch_drr.c
>>>>> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>>>>>           *qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>>>>>           fl = rcu_dereference_bh(q->filter_list);
>>>>>           result = tcf_classify(skb, NULL, fl, &res, false);
>>>>> +       if (result == TC_ACT_SHOT)
>>>>> +               return NULL;
>>>>>           if (result >= 0) {
>>>>>    #ifdef CONFIG_NET_CLS_ACT
>>>>>                   switch (result) {
>>>>> --
>>>>> 2.37.2
>>>>>
>>>>
>>>>    I do not see a bug, TC_ACT_SHOT is handled in the switch (result) just fine
>>>> at line 320 ?
>>>
>>> Following the code path (with CONFIG_NET_CLS_ACT=n in mind), it looks
>>> like there are a couple of places which return TC_ACT_SHOT before
>>> calling any classifiers, which then would cause some qdiscs to look into
>>> a uninitialized 'struct tcf_result res'.
>>> I could be misreading it... But if it's the problem the author is trying
>>> to fix, the obvious way to do it would be:
>>>          struct tcf_result res = {};
>>
>> CONFIG_NET_CLS_ACT=n, how come TC_ACT_SHOT could be used ?
>>
>> Can we get rid of CONFIG_NET_CLS_ACT, this seems obfuscation to me at
>> this point.
> 
> The problem is the verdict vs return code are intermixed - not saying
> this was fixing anything useful.
> We discussed this in the past after/during commit
> caa4b35b4317d5147b3ab0fbdc9c075c7d2e9c12
> Victor worked on a patch to resolve that. Victor, maybe revive that
> patch and post as RFC?

Okk, will review, rebase on top of net-next and post.

cheers,
Victor

