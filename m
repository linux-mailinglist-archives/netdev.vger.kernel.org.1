Return-Path: <netdev+bounces-19985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8375D265
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 20:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C021C2173A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0C1ED41;
	Fri, 21 Jul 2023 18:59:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BE200A6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 18:59:06 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90830D4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:59:04 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-55e1ae72dceso1474870eaf.3
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689965944; x=1690570744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TqtGRqPzEClXiGoZuDKD2HGaQA0OCMScbfC2N+jNqg=;
        b=3k8oQD3BRe50/tV1gw9uKPNWB4hQ+s/vG8gD9kHSu7qJgAkfq+E9nxDXlon2uY1A96
         oIl63S8btvR2N07ijyunpTXC/A+Wfq+kNo8FScr5WU7JxJ0Ws9wq4UiwbX42DBmgcjte
         tQSLpZ0OGTwul6Yc5fWnfJwLtg9raUAX00fj/Zfo4dERAKY1Fw3ODMvgziJJx8JJIMmr
         /X5doUfCbb1RVf/MqblpIkMca46vAS9ioLuyYHzSonxne0Te6N6gn1p/53l7LMfL/QIE
         GwzCdN+YD760KZQztK1aTsRf9l5a43Yr1h6L0qE7nD0l67E+WLHqsbvh0QQ0xrv85zJt
         uYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965944; x=1690570744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TqtGRqPzEClXiGoZuDKD2HGaQA0OCMScbfC2N+jNqg=;
        b=IwWsN/1mletpZ5/jPkqTDJfE7HBWAHyZeEoGssHVGJv+3o7SpvyCQmVOkvTfWzOCbe
         bsz0Lucx4g3bmFiWHMELu2P7n4wcCa7YQTP30nLivNLr0rO0aPIzadq6GHkfuYZ8su8o
         tOin+v93TFEe67DcQFlVtCvdbdU7//jOPUWuaKGzzh6OdmdXfDgnF/UBOkY6Pn2sFpa3
         fZ56eKkAiIKYftl68HNmqhivkBjONxHOJcHWZsCjd58B9EmDgOs4QV2/0ADBIb5OXwPB
         w4RQTJz/9iRFbeuSwVq5Kg1LW6cLbIjni9Hw1dQX3Q7xFbEmpdUKrz7Ld6GEvlPDLmr5
         Marw==
X-Gm-Message-State: ABy/qLb9FKpcklIGavhUVpvuQSkQxSsOKONaQj9OX9fAF4xZw4edI9yF
	bu/vRskSZnP7JV1dLBWhK2pL3g==
X-Google-Smtp-Source: APBJJlF+mswcQA1pGbAnjnFmGJDQiLi4xgKlPvhD5IHwafBXrPM+otSO3K14cZQSyiviiaL9L8HiJw==
X-Received: by 2002:a05:6808:10c2:b0:398:5d57:3d08 with SMTP id s2-20020a05680810c200b003985d573d08mr4139031ois.37.1689965943852;
        Fri, 21 Jul 2023 11:59:03 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:2414:7bdd:b686:c769? ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id q11-20020a056808200b00b0039ee0778048sm1716872oiw.37.2023.07.21.11.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 11:59:03 -0700 (PDT)
Message-ID: <39d1a433-d44f-1a90-e943-8e9f046bdf80@mojatatu.com>
Date: Fri, 21 Jul 2023 15:58:58 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 1/3] net/sched: cls_u32: No longer copy tcf_result on
 update to avoid use-after-free
To: M A Ramdhan <ramdhan@starlabs.sg>, valis <sec@valis.email>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, victor@mojatatu.com, billy@starlabs.sg
References: <20230721174856.3045-1-sec@valis.email>
 <20230721174856.3045-2-sec@valis.email>
 <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CACSEBQQdOJAX1yqDMLb_yQMpU2yoUShhS_pCSDndWepxfw3Rsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/07/2023 15:04, M A Ramdhan wrote:
> On Sat, Jul 22, 2023 at 12:51 AM valis <sec@valis.email> wrote:
>>
>> When u32_change() is called on an existing filter, the whole
>> tcf_result struct is always copied into the new instance of the filter.
>>
>> This causes a problem when updating a filter bound to a class,
>> as tcf_unbind_filter() is always called on the old instance in the
>> success path, decreasing filter_cnt of the still referenced class
>> and allowing it to be deleted, leading to a use-after-free.
>>
>> Fix this by no longer copying the tcf_result struct from the old filter.
>>
>> Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear atomic to readers")
>> Reported-by: valis <sec@valis.email>
>> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
>> Signed-off-by: valis <sec@valis.email>
>> Cc: stable@vger.kernel.org
>> ---
>>   net/sched/cls_u32.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
>> index 5abf31e432ca..19aa60d1eea7 100644
>> --- a/net/sched/cls_u32.c
>> +++ b/net/sched/cls_u32.c
>> @@ -826,7 +826,6 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
>>
>>          new->ifindex = n->ifindex;
>>          new->fshift = n->fshift;
>> -       new->res = n->res;
>>          new->flags = n->flags;
>>          RCU_INIT_POINTER(new->ht_down, ht);
>>
>> --
>> 2.30.2
>>
> Hi,
> 
> We also thought it's also the correct fixes,
> but we're not sure because it will always remove the already bound
> qdisc class when we change the filter, even tho we never specify
> the new TCA_U32_CLASSID in the new filter.

The user should always explicitly tell the classid. Some other 
classifiers are already behaving like this, these were just wrong.

> 
> I also look at the implementation of cls_tcindex and cls_rsvp which still copy
> the old tcf_result, but don't call the tcf_unbind_filter when changing
> the filter.

Both were deprecated and removed as they were beyond saving.

> 
> If it's the intended behaviour, then I'm good with this patch.
> 
> Thanks & Regards,
> M A Ramdhan


