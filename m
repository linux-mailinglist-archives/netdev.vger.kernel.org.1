Return-Path: <netdev+bounces-19894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8C75CB85
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026B11C216D7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F627F3F;
	Fri, 21 Jul 2023 15:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0927F05
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:22:00 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DF3A96
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:21:36 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-483e175352cso732883e0c.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689952888; x=1690557688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCexeoAq5WFou5O/MRG2hFsQoOlYTuihLodnFL02nHg=;
        b=RoI4XoW6aSQvP9Q8TIXeE+OOEjdFRCDb5vCkv39l0cVz+nN1XkGHe+kfutsTKJD3Yn
         K9EA33tFVnX6nMGiNfLaqLq6BPH9onR1FfYwtc61aWR58Y4ISItozVXJBpmwVx0WKbke
         kWA4KBDXbV2hUWcpwHyqaT/eOfar/9gB9G85I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952888; x=1690557688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCexeoAq5WFou5O/MRG2hFsQoOlYTuihLodnFL02nHg=;
        b=dJWG9HWj1mnptE8eEuajEkXZukQ9/IG90r4f27rCtNgrQ3O9kh5Ivs4Z03pQQJH1iK
         6T1RzgNY1xJDBNHwBzOg+2izUoWWd9qcM/ChjrsouajADzNd2CTWak7vevc9muSrScMQ
         XJ8dlHiOEE7x2K4o3c0rEq5olrWMIAUqj0v6pEQ1lEayCRboKfgpCbRw90UkUz8/MgDF
         7kjtDiZe7k3amPGpNizcrG7Wlyz2tlxU6EBeeX9bBGNSmhlw3rbGZBnyH5tjsryWm1ng
         to1qjK2LIbuMpa4E5oQHEuddnFO7cCHGlSGWlTZDqLPaoYvYqRpW3frAgguk+OVeKQpf
         lqmQ==
X-Gm-Message-State: ABy/qLYJfu+oQau5bewpkh/aPyh+DCwghyWFuueeCWFV8ljkOOZMWzps
	L4q7iwbK5xUTA1sRi5nFn8Ueuw==
X-Google-Smtp-Source: APBJJlFf1VC+mAzw0+PKkMHibS0p4yDHmiPMsps0CguK5DiWnKA7KpFGtyoPE7ky4Z9ArKM/pexs2Q==
X-Received: by 2002:a67:f244:0:b0:443:6792:38a with SMTP id y4-20020a67f244000000b004436792038amr208591vsm.34.1689952888401;
        Fri, 21 Jul 2023 08:21:28 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id k30-20020a0cb25e000000b0063cdcd5699csm517512qve.118.2023.07.21.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:21:27 -0700 (PDT)
Message-ID: <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
Date: Fri, 21 Jul 2023 11:21:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Content-Language: en-US
To: Alan Huang <mmpgouride@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, rcu@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, roman.gushchin@linux.dev
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 10:27, Alan Huang wrote:
> 
>> 2023年7月21日 20:54，Joel Fernandes <joel@joelfernandes.org> 写道：
>>
>>
>>
>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>>>
>>> ﻿
>>>> 2023年7月21日 03:22，Eric Dumazet <edumazet@google.com> 写道：
>>>>
>>>>> On Thu, Jul 20, 2023 at 8:54 PM Alan Huang <mmpgouride@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I noticed a commit c87a124a5d5e(“net: force a reload of first item in hlist_nulls_for_each_entry_rcu”)
>>>>> and a related discussion [1].
>>>>>
>>>>> After reading the whole discussion, it seems like that ptr->field was cached by gcc even with the deprecated
>>>>> ACCESS_ONCE(), so my question is:
>>>>>
>>>>>       Is that a compiler bug? If so, has this bug been fixed today, ten years later?
>>>>>
>>>>>       What about READ_ONCE(ptr->field)?
>>>>
>>>> Make sure sparse is happy.
>>>
>>> It caused a problem without barrier(), and the deprecated ACCESS_ONCE() didn’t help:
>>>
>>>    https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>
>>> So, my real question is: With READ_ONCE(ptr->field), are there still some unusual cases where gcc
>>> decides not to reload ptr->field?
>>
>> I am a bit doubtful there will be strong (any?) interest in replacing the barrier() with READ_ONCE() without any tangible reason, regardless of whether a gcc issue was fixed.
>>
>> But hey, if you want to float the idea…
> 
> We already had the READ_ONCE() in rcu_deference_raw().
> 
> The barrier() here makes me think we need write code like below:
> 	
> 	READ_ONCE(head->first);
> 	barrier();
> 	READ_ONCE(head->first);
> 
> With READ_ONCE (or the deprecated ACCESS_ONCE),
> I don’t think a compiler should cache the value of head->first.


Right, it shouldn't need to cache. To Eric's point it might be risky to remove 
the barrier() and someone needs to explain that issue first (or IMO there needs 
to be another tangible reason like performance etc). Anyway, FWIW I wrote a 
simple program and I am not seeing the head->first cached with the pattern you 
shared above:

#include <stdlib.h>

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define barrier() __asm__ __volatile__("": : :"memory")

typedef struct list_head {
     int first;
     struct list_head *next;
} list_head;

int main() {
     list_head *head = (list_head *)malloc(sizeof(list_head));
     head->first = 1;
     head->next = 0;

     READ_ONCE(head->first);
     barrier();
     READ_ONCE(head->first);

     free(head);
     return 0;
}

On ARM 32-bit, 64-bit and x86_64, with -Os and then another experiment with -O2 
on new gcc versions.


