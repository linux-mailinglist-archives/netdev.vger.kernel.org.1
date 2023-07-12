Return-Path: <netdev+bounces-17171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA9750B45
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C461C21147
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760727736;
	Wed, 12 Jul 2023 14:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69931F199
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:45:57 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF762BB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:45:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9741caaf9d4so815091966b.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689173154; x=1691765154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRDieu641p4IUf1stMnNllECM0gfcLeHmhaeQbMBntI=;
        b=LeXFm5ukWyg0ZzTCTRzsDeO/5x6A+3t0P5zjFv0cxo5yqRRufpEbhf0de5YDKv/gcz
         m8Lo++p3yeIdkPs+AxFmPp9Ln6KzbvbjYTVjup5xBDfJh15H1scaVqI1lhxrDXKxx7bp
         NZWot+lHV+w6QjYCkhYgXCEoEQ1Pab9ciZlxhRUqRq2wqRwPvCGGjpIJaNHLq46yMajV
         r0MKd3ql7gZPYKQ/aAGVjD225krD5FjElER/E17ytvZBJjn2g3x3fIaj8Mdr+piEZLiX
         aHDiwO78ZHc9h+Q1K51Dp3PFOdIyjexM8AZlXB7lESBjYBL6GvE5LoA0dd59H9/m59U1
         zBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173154; x=1691765154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRDieu641p4IUf1stMnNllECM0gfcLeHmhaeQbMBntI=;
        b=XwNdRX8WlYfrcx8nFLSyZF44y7FwAA5Tig1gKsPaSxFyW0MAIl59rPPvyonYGykXtz
         0KPtLCg+STi4of/52Zh/NwpofdBhVEVuaGqSh2IXZEdSRzjYMAR2q+F14PesMDRTusuK
         EDyTFim3DvDEiIUxJiJodkyBXkNhlJU4RqUvmt+t7OPa7R3XqnAozGgYxjBddqFaiQq+
         y1gxWG33Mc3VH3336nSORg9OhwxgBY6+b4XYlx+iw6jHyqAI7zCezgEy1GK9Ot+wPAlc
         +F+NIY5yKMASVESGdwxPJTw9cYl3X+AKyWG8lWOQg7j0fOHXn9bcu/F7tPa1WwFCFT5F
         8k7A==
X-Gm-Message-State: ABy/qLbL5h7Zkx95f5PGr7CHk5gVBGbcB5k9pYFo7rqSVZ7A1UgaXBYt
	+n7jwdYrsplnF/g01t29kZgxlw==
X-Google-Smtp-Source: APBJJlG9rA7+fficfCzsrkAwo1ShjlWEUrCBU8P80VR8iEokwRt76ueQdJULZtyt996CBbksUqoR1w==
X-Received: by 2002:a17:906:73d8:b0:993:d117:e3b9 with SMTP id n24-20020a17090673d800b00993d117e3b9mr18336546ejl.20.1689173154161;
        Wed, 12 Jul 2023 07:45:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef4b:f9b8:e94a:ea27? ([2a02:578:8593:1200:ef4b:f9b8:e94a:ea27])
        by smtp.gmail.com with ESMTPSA id um10-20020a170906cf8a00b0098e78ff1a87sm2646582ejb.120.2023.07.12.07.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:45:53 -0700 (PDT)
Message-ID: <d369fe0f-d632-270d-7036-6021d9ae787a@tessares.net>
Date: Wed, 12 Jul 2023 16:45:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: TC: selftests: current timeout (45s) is too low
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>,
 Pedro Tammela <pctammela@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev <netdev@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
 <CAKa-r6sg3QRm3btoWTj7SzBSi29WUpT0et7dgdTmvbNE=74J3Q@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKa-r6sg3QRm3btoWTj7SzBSi29WUpT0et7dgdTmvbNE=74J3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Davide,

On 12/07/2023 16:02, Davide Caratti wrote:
> hello!
> 
> On Wed, Jul 12, 2023 at 3:43 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> Hi Matthieu,
>>
>> I have been involved in tdc for a while now, here are my comments.
>>
>> On 12/07/2023 06:47, Matthieu Baerts wrote:
>>> Hi Jamal, Cong, Jiri,
>>>
>>> When looking for something else [1] in LKFT reports [2], I noticed that
>>> the TC selftest ended with a timeout error:
>>>
>>>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>>
>>> The timeout has been introduced 3 years ago:
>>>
>>>    852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
>>> per test")
>>>
>>> Recently, a new option has been introduced to override the value when
>>> executing the code:
>>>
>>>    f6a01213e3f8 ("selftests: allow runners to override the timeout")
>>>
>>> But I guess it is still better to set a higher default value for TC
>>> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
>>> "settings" file in 'tc-testing' directory, e.g.
>>>
>>>    echo timeout=1200 > tools/testing/selftests/tc-testing/settings
> 
> finding a good default is not easy, because some kernel (e.g. those
> built with debug options) are very slow .
Thank you for your feedback!

I agree it is not be easy. From what I see, lkft doesn't run the
selftests with a debug kconfig. I guess we can assume these tests are
either ran in a slow environment or with a debug kconfig but not both,
otherwise the timeout would be too high -- at least that's what we did
with MPTCP :)

Is 15 minute a good value to start with?

> Maybe we can leverage also on the other value in tdc_config.py [1] -
> or at least ensure that the setting in 'setting' is consistent.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d37e56df23f9e
I don't know the TC test env but it looks like it is a timeout that is
used in case of issues. I guess this timeout should in theory never be
fired except in case of big problem, no?
If we use it and if there are 543 tests -- according to the logs -- the
global timeout would be just under 1h50 :)
This timeout in the worst case scenario when nothing is working, I guess
it makes sense to have this kselftest timeout below that.

> 
> [...]
> 
>>> I also noticed most of the tests were skipped [2], probably because
>>> something is missing in the test environment? Do not hesitate to contact
>>> the lkft team [3], that's certainly easy to fix and it would increase
>>> the TC test coverage when they are validating all the different kernel
>>> versions :)
>>
>>  From the logs it seems like the kernel image is missing the 'ct'
>> action. Possibly also missing other actions/tc components, so it seems
>> like a kernel config issue.
> 
> when I run tdc I use to do:
> 
> #  yes | make kselftest-merge
> 
> so that the kconfigs are not forgot :)

It looks like it is more than what lkft is using (see my reply to
Pedro). Maybe a conflict with just the ones lkft is using then?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

