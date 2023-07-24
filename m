Return-Path: <netdev+bounces-20509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F8375FCE4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8652813C4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62046DF66;
	Mon, 24 Jul 2023 17:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F561FC4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:06:05 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F8E54
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:06:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bb14c05d77so3033328a34.2
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690218360; x=1690823160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZrU8qOiVD9ijpfNALvW7OuP22qZH9zy6KJ3XqFV1yU=;
        b=Y6rr+Moj1vqKZeffZ/hTAujcTGw1wzMYR524UqDhBsmdRwDlti5W8nOH+AaDHykoXg
         b/fcO7fc6VsuV0IpxsrFaB/IgTmRqRAlTzvZyVTO7qAzV+tTcDvFDbMD7ad/PPeR96dj
         B+Sav0mbYjNe1TM0KzH6K82AJp+FDgWSTSBnuI5RTZcQJYDpfn4GXrD2/Be52hbrl+b0
         RcTjAyGfogYvPzPMgcSsmYcXc6CwUB6vGLRaVtECSeVjwjKAdOpFkvVuD3SraSrQdyAq
         qETqraNJcpsK32Snu+gHLtCjeAx/jk0e+MEdl1AtThb/QuDdFRXxUs17KxkY7DctX7cR
         fPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218360; x=1690823160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZrU8qOiVD9ijpfNALvW7OuP22qZH9zy6KJ3XqFV1yU=;
        b=K9X3neSVOvwRhIWk5gQt6udgN31MxkGHuJHWYK6dmMO5ZmpquwnA6eTCCwp44/z5fi
         Wow2QW5X+/eS0oS2M3zSyzYWBaVLTE3mq3p41IKrL1ToPr8G9loqlTSIAMC5tQt/9U8l
         3T68XScgy24tIRICj1Udw1UIbkVotvFEHNQvaoVKfH7FBk/eki1oG+cFLfmzTUDCrq5W
         jS1JMCNsiVfnJC6r1xcEKkP1DfGVqmVnKjJWNn+rTpSu+KDZFv9+7DdFONbz2uDXkJ9Y
         LFTLknXs4opb65BCtiznvcBXTOTlf+Tf5ngFWGT2u9XYnPWH62NPoNICgr6OLmU3e/GH
         F8cQ==
X-Gm-Message-State: ABy/qLayvrG3OjDrD5YaFJn+kyiO/0H5LwDyHs7RthIn3hhFtb7Iz61X
	pZeQGr1icUwKfH/w7f07JEbbynmgbzBmZoABPaw=
X-Google-Smtp-Source: APBJJlEHVYMFTS0m8hL7fh87zFxvNkWGWwMYtN8keQSy7WSR/+3sDOc9HaFBi/jEETIc1lUoQGWiyw==
X-Received: by 2002:a9d:7d8e:0:b0:6b2:ac44:bf8e with SMTP id j14-20020a9d7d8e000000b006b2ac44bf8emr8520185otn.8.1690218360094;
        Mon, 24 Jul 2023 10:06:00 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:2311:69f0:a397:7b56? ([2804:14d:5c5e:44fb:2311:69f0:a397:7b56])
        by smtp.gmail.com with ESMTPSA id c23-20020a9d67d7000000b006b94fb2762asm4145645otn.23.2023.07.24.10.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:05:59 -0700 (PDT)
Message-ID: <af86baa5-be74-9d62-7208-df8e12728572@mojatatu.com>
Date: Mon, 24 Jul 2023 14:05:55 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/5] net/sched: wrap open coded Qdics class
 filter counter
Content-Language: en-US
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us
References: <20230721191332.1424997-1-pctammela@mojatatu.com>
 <20230721191332.1424997-2-pctammela@mojatatu.com>
 <ZL1tF6QB2jhy1cjw@pop-os.localdomain>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <ZL1tF6QB2jhy1cjw@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/07/2023 15:10, Cong Wang wrote:
> On Fri, Jul 21, 2023 at 04:13:28PM -0300, Pedro Tammela wrote:
>> The 'filter_cnt' counter is used to control a Qdisc class lifetime.
>> Each filter referecing this class by its id will eventually
>> increment/decrement this counter in their respective
>> 'add/update/delete' routines.
>> As these operations are always serialized under rtnl lock, we don't
>> need an atomic type like 'refcount_t'.
>>
>> It also means that we lose the overflow/underflow checks already
>> present in refcount_t, which are valuable to hunt down bugs
>> where the unsigned counter wraps around as it aids automated tools
>> like syzkaller to scream in such situations.
>>
>> Wrap the open coded increment/decrement into helper functions and
>> add overflow checks to the operations.
> 
> So what's the concern of using refcount_t here? Since we have RTNL lock,
> I don't think performance is a concern.
> 
> I'd prefer to reuse the overflow/underflow with refcount_t than
> open-coding new ones.

I see.
There's a need for another minor adaption as well.
As the 'filter_cnt' starts from 0, it can do 0->1 transitions, which the 
refcount API warns.
So in a refcount_t 'filter_cnt' we would need to initialize it to 1.

I think it's confusing for a variable that represents a count of filters 
have 1 as a nil value.

> 
> 
>> diff --git a/include/net/tc_class.h b/include/net/tc_class.h
>> new file mode 100644
>> index 000000000000..2ab4aa2dba30
>> --- /dev/null
>> +++ b/include/net/tc_class.h
> 
> Why not put these helpers togethre with other qdisc class helpers in
> include/net/sch_generic.h?

OK

> 
> Thanks.


