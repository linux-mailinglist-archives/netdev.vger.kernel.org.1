Return-Path: <netdev+bounces-17170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA18750B35
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181252819EF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6197F27726;
	Wed, 12 Jul 2023 14:43:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0CEACB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:43:14 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E64DBB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:43:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e5672d580so5231425a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689172991; x=1691764991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zwe4PWRdwr29yhu3VQjogGVWqtrG3b8mEa1jwO9nY5A=;
        b=n0l/80mjSnGHxbwmKO43YWE7KndGYzg7mE0S7dpKyXlWtbM/X6ysE0kmVTITcovV3D
         2aekAgrGD+8jFQsmgZ5dkHvWOMGJgBS7SQQu4q/idt2YpCg6CeeUSbYA2mSjBbDn+++w
         Gjb6IBbcxsRP6lmvDUYOSqKKBvSaNzh0CaJZXgPM0EC/gF1Nyo7m9aqfxD9GyMPLny+E
         mt0L8fWlLkxaNziAIGMW71cpKI8auv1h0kv/a4ai9gKgNeBc56H2x4JI47RFGU7rS5Eo
         RSSY8yFu/9VS1Ky4wB1azdfCUYd79Vps8FqCv3fyL40uoCY7/8unefHASN87nTL6TL9a
         kD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689172991; x=1691764991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwe4PWRdwr29yhu3VQjogGVWqtrG3b8mEa1jwO9nY5A=;
        b=UWQKfegABiSXvE+GDIsYwCG/wz+RX34ijKt+m1hJoqasb+dUNK+xiVaAybR8NXe77S
         BusUE7IRqjyI4ojz4SgUOU4NxEMlrZI9/IfoJx+/CwOnAJ/zI3zqdBTE68ULSf7luTDX
         j9Zcbue4I+nRT2SO6ZmRYM692fTrfyVUGVlrBJ/TDILG/W09EMbess7Jn5aWqZRnyGQ1
         q93KqTzU3+enYc7M5yn4yaESjmiGqMb1JJeV7HE57zANekCh7uxGbFoBvkun4FSdSsAw
         p9QBHo94gkcL2oe2qN/Qdz+//QBYCZZw9LQK5zXfztE/XUc7RD3IZ9UuCQiKFiq/VkjS
         OSJQ==
X-Gm-Message-State: ABy/qLZVOS+P12VaQ+ntvUnXEhqMqUmTwIaxZlBvh+ObTOp5tC24d32r
	toPmA75YurluveQZug2O6cLBDQ==
X-Google-Smtp-Source: APBJJlH9PeWSqDuRqpviG69SgVnfutdCUs82uCojfS+uCK4nlwq7ugo0PnqEQz6XG+mZeiZBjB87oA==
X-Received: by 2002:aa7:d6ce:0:b0:51e:1a47:3e3a with SMTP id x14-20020aa7d6ce000000b0051e1a473e3amr18414436edr.18.1689172990833;
        Wed, 12 Jul 2023 07:43:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef4b:f9b8:e94a:ea27? ([2a02:578:8593:1200:ef4b:f9b8:e94a:ea27])
        by smtp.gmail.com with ESMTPSA id a19-20020a50ff13000000b0051bed498851sm2865439edu.54.2023.07.12.07.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:43:10 -0700 (PDT)
Message-ID: <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
Date: Wed, 12 Jul 2023 16:43:09 +0200
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
To: Pedro Tammela <pctammela@mojatatu.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev <netdev@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Davide Caratti <dcaratti@redhat.com>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pedro,

On 12/07/2023 15:43, Pedro Tammela wrote:
> I have been involved in tdc for a while now, here are my comments.

Thank you for your reply!

> On 12/07/2023 06:47, Matthieu Baerts wrote:
>> Hi Jamal, Cong, Jiri,
>>
>> When looking for something else [1] in LKFT reports [2], I noticed that
>> the TC selftest ended with a timeout error:
>>
>>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>
>> The timeout has been introduced 3 years ago:
>>
>>    852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
>> per test")
>>
>> Recently, a new option has been introduced to override the value when
>> executing the code:
>>
>>    f6a01213e3f8 ("selftests: allow runners to override the timeout")
>>
>> But I guess it is still better to set a higher default value for TC
>> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
>> "settings" file in 'tc-testing' directory, e.g.
>>
>>    echo timeout=1200 > tools/testing/selftests/tc-testing/settings
>>
>> I'm sending this email instead of a patch because I don't know which
>> value makes sense. I guess you know how long the tests can take in a
>> (very) slow environment and you might want to avoid this timeout error.
> 
> I believe a timeout between 5-10 to minutes should cover the entire suite

Thank you for your feedback.
If we want to be on the safe side, I guess it is better to put 10
minutes or even 15, no?

>> I also noticed most of the tests were skipped [2], probably because
>> something is missing in the test environment? Do not hesitate to contact
>> the lkft team [3], that's certainly easy to fix and it would increase
>> the TC test coverage when they are validating all the different kernel
>> versions :)
> 
> From the logs it seems like the kernel image is missing the 'ct' action.
> Possibly also missing other actions/tc components, so it seems like a
> kernel config issue.

According to [1], the kconfig is generated by merging these files:

  defconfig, systemd.config [2], tools/testing/selftests/kexec/config,
tools/testing/selftests/net/config,
tools/testing/selftests/net/mptcp/config,
tools/testing/selftests/net/hsr/config,
tools/testing/selftests/net/forwarding/config,
tools/testing/selftests/tc-testing/config

You can see the final .config file in [3].

I can see "CONFIG_NET_ACT_CTINFO(=m)" but not "CONFIG_NET_ACT_CT" while
they are both in tc-testing/config file. Maybe a conflict with another
selftest config?

I don't see any mention of "NET_ACT_CT" in the build logs [4].

Cheers,
Matt

[1]
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2SPJN70f1LBiWmZIxl0WNcOmjwN
[2]
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
[3]
https://storage.tuxsuite.com/public/linaro/lkft/builds/2SPJN70f1LBiWmZIxl0WNcOmjwN/config
[4]
https://storage.tuxsuite.com/public/linaro/lkft/builds/2SPJN70f1LBiWmZIxl0WNcOmjwN/build-debug.log
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

