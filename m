Return-Path: <netdev+bounces-17664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E417529DD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D5C1C2143E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E831F182;
	Thu, 13 Jul 2023 17:30:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EC1F16E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:30:59 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA6110
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:30:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3c77e0154so781658b6e.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689269456; x=1691861456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMzstgkurxJurwJjqaKxcigGKT2VmfrJKL194SNg2g0=;
        b=LU8yatFbB/PfNlaAaEyeR5mkPqEbSyrfwCm/bbF8pZ8hkA7ou+Tj2Q39wgcIazcteb
         TwbtilnTFMA43cQALw+3BllEb66yfyPAu0j9B8HrRTVK2VsII+eezOCaVEhwvo8KdqkA
         hciiS/b1akk01l+LqmASIujN2aqynnCqmXyhPOnOTqQQ6f6p/U0rrhi3BZX5Jjq05s9G
         SpBeqzNLAaJvObY7vxwyOGfDe1JImjZz7hl/1sJlK/1pGRUE/o129abD+IMx/YJqwvuA
         uxGYs56C0DK9P5FD9MVKqBFELZNpUJBjoE+oHJXoVKtyBpHM98T0AJ9BBSXw6i9wBmuj
         Owlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269456; x=1691861456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMzstgkurxJurwJjqaKxcigGKT2VmfrJKL194SNg2g0=;
        b=OX47aTBX5hZppeX3xGTCzqWKsgcxq05PkxFz821NJFYCwG5z7i3+umk8WBmVpM0GM1
         buNgtWvSswYv8KApFwMbhoRdnBkywRv6ILZDa80anngLd8327Osd9G6QyrcCr7St2+Ce
         WySH4FECbwsryNjIhuMIcqKmSOOFdGTOeEqYsB9mC5qIUhaps4bdISILxI9EFFJQPIMy
         edn1RR/QbAu3qldqj8AQkDaqfS3ehtnHRuG5PXg1VEagOoYaYVeSKEInSm5EbSyH8Ryk
         rMlFBiQ/hme4m4CFSa0q92U0BnPBhFAe6MHos2dHOlQSiD/3hZjXpXggF6ohgre+Q3Cj
         7MvA==
X-Gm-Message-State: ABy/qLa8G0WSGAnxG7HRZzAzWT/tM5maacFmXjslCF0inbBcgOd2yMAZ
	53qDNYH57rtF1HOarTMrZWM2tg==
X-Google-Smtp-Source: APBJJlFIZOd4n6KDudVjEkjnN70zIUtvRs0vgnm836L9E00/rpXQh/Uz3/PdH+XNBwvVVPE2GMq2lw==
X-Received: by 2002:aca:ded4:0:b0:3a3:b39d:a8bf with SMTP id v203-20020acaded4000000b003a3b39da8bfmr1801092oig.45.1689269456450;
        Thu, 13 Jul 2023 10:30:56 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3ecf:3d37:de47:ff6b? ([2804:14d:5c5e:44fb:3ecf:3d37:de47:ff6b])
        by smtp.gmail.com with ESMTPSA id bd35-20020a056808222300b003a41484b23dsm3077149oib.46.2023.07.13.10.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 10:30:56 -0700 (PDT)
Message-ID: <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com>
Date: Thu, 13 Jul 2023 14:30:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: TC: selftests: current timeout (45s) is too low
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev <netdev@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Davide Caratti <dcaratti@redhat.com>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
 <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
 <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com>
 <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 10:59, Matthieu Baerts wrote:
> Hi Pedro,
> 
> On 12/07/2023 19:12, Pedro Tammela wrote:
>> On 12/07/2023 11:43, Matthieu Baerts wrote:
>>> Hi Pedro,
>>>
>>> On 12/07/2023 15:43, Pedro Tammela wrote:
>>>> I have been involved in tdc for a while now, here are my comments.
>>>
>>> Thank you for your reply!
>>>
>>>> On 12/07/2023 06:47, Matthieu Baerts wrote:
>>>>> Hi Jamal, Cong, Jiri,
>>>>>
>>>>> When looking for something else [1] in LKFT reports [2], I noticed that
>>>>> the TC selftest ended with a timeout error:
>>>>>
>>>>>      not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>>>>
>>>>> The timeout has been introduced 3 years ago:
>>>>>
>>>>>      852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
>>>>> per test")
>>>>>
>>>>> Recently, a new option has been introduced to override the value when
>>>>> executing the code:
>>>>>
>>>>>      f6a01213e3f8 ("selftests: allow runners to override the timeout")
>>>>>
>>>>> But I guess it is still better to set a higher default value for TC
>>>>> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
>>>>> "settings" file in 'tc-testing' directory, e.g.
>>>>>
>>>>>      echo timeout=1200 > tools/testing/selftests/tc-testing/settings
>>>>>
>>>>> I'm sending this email instead of a patch because I don't know which
>>>>> value makes sense. I guess you know how long the tests can take in a
>>>>> (very) slow environment and you might want to avoid this timeout error.
>>>>
>>>> I believe a timeout between 5-10 to minutes should cover the entire
>>>> suite
>>>
>>> Thank you for your feedback.
>>> If we want to be on the safe side, I guess it is better to put 10
>>> minutes or even 15, no?
>>
>> Sure, makes sense.
>> If someone complains we can lower it.
>>
>>>
>>>>> I also noticed most of the tests were skipped [2], probably because
>>>>> something is missing in the test environment? Do not hesitate to
>>>>> contact
>>>>> the lkft team [3], that's certainly easy to fix and it would increase
>>>>> the TC test coverage when they are validating all the different kernel
>>>>> versions :)
>>>>
>>>>   From the logs it seems like the kernel image is missing the 'ct'
>>>> action.
>>>> Possibly also missing other actions/tc components, so it seems like a
>>>> kernel config issue.
>>>
>>> According to [1], the kconfig is generated by merging these files:
>>>
>>>     defconfig, systemd.config [2], tools/testing/selftests/kexec/config,
>>> tools/testing/selftests/net/config,
>>> tools/testing/selftests/net/mptcp/config,
>>> tools/testing/selftests/net/hsr/config,
>>> tools/testing/selftests/net/forwarding/config,
>>> tools/testing/selftests/tc-testing/config
>>>
>>> You can see the final .config file in [3].
>>>
>>> I can see "CONFIG_NET_ACT_CTINFO(=m)" but not "CONFIG_NET_ACT_CT" while
>>> they are both in tc-testing/config file. Maybe a conflict with another
>>> selftest config?
>>>
>>> I don't see any mention of "NET_ACT_CT" in the build logs [4].
>>
>> There's a requirement for NET_ACT_CT which is not set in the final
>> config (CONFIG_NF_FLOW_TABLE).
>>
>> Perhaps this could fix?
>> diff --git a/tools/testing/selftests/tc-testing/config
>> b/tools/testing/selftests/tc-testing/config
>> index 6e73b09c20c8..d1ad29040c02 100644
>> --- a/tools/testing/selftests/tc-testing/config
>> +++ b/tools/testing/selftests/tc-testing/config
>> @@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
>>   CONFIG_NF_CONNTRACK_MARK=y
>>   CONFIG_NF_CONNTRACK_ZONES=y
>>   CONFIG_NF_CONNTRACK_LABELS=y
>> +CONFIG_NF_FLOW_TABLE=m
>>   CONFIG_NF_NAT=m
>>   CONFIG_NETFILTER_XT_TARGET_LOG=m
> 
> Yes it does!
> 
> I got access to the tuxsuite to reproduce the issues with the suggested
> fixes. The i386 build job is visible in [1] (kconfig in [2]) and the
> test job in [3] (logs in [4]).
> 
> [1]
> https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/builds/2SW6Vk3VYTGyW90OBecA3knJFIz
> [2]
> https://storage.tuxsuite.com/public/community/matthieu.baerts/builds/2SW6Vk3VYTGyW90OBecA3knJFIz/config
> [3]
> https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWB6sYne9afpOxqp3CNE5BxAn8
> [4]
> https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWB6sYne9afpOxqp3CNE5BxAn8/logs?format=html
> 
> 
> Note that the TC tests have been executed in less than 3 minutes. 15
> minutes seem more than enough then! (I don't know how "fast" is this
> environment).
> 
> We can see that all tests have been executed except one:
> 
>> # ok 495 6bda - Add tunnel_key action with nofrag option # skipped - probe command: test skipped.
> 
> Maybe something else missing?
> 
> Other than that, 6 tests have failed:
> 
> - Add skbedit action with valid mark and mask with invalid format
> 
>> # not ok 284 bc15 - Add skbedit action with valid mark and mask with invalid format
>> # 	Command exited with 0, expected 255
> 
> - Add ct action triggering DNAT tuple conflict:
> 
>> # not ok 373 3992 - Add ct action triggering DNAT tuple conflict
>> # 	Could not match regex pattern. Verify command output:
>> # cat: /proc/net/nf_conntrack: No such file or directory
> 
> - Add xt action with log-prefix
> 
>> # not ok 408 2029 - Add xt action with log-prefix
>> # 	Could not match regex pattern. Verify command output:
>> # total acts 1
>> #
>> # 	action order 0: tablename: mangle  hook: NF_IP_POST_ROUTING
>> # 	target  LOG level warn prefix \"PONG\"
>> # 	index 100 ref 1 bind 0
>> # 	not_in_hw
> 
> - Replace xt action log-prefix
> 
>> # not ok 409 3562 - Replace xt action log-prefix
>> # 	Could not match regex pattern. Verify command output:
>> # total acts 0
>> #
>> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
>> # 	target  LOG level warn prefix \"WIN\"
>> # 	index 1 ref 1 bind 0
>> # 	not_in_hw
> 
> - Delete xt action with invalid index
> 
>> # not ok 411 5169 - Delete xt action with invalid index
>> # 	Could not match regex pattern. Verify command output:
>> # total acts 0
>> #
>> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
>> # 	target  LOG level warn prefix \"PONG\"
>> # 	index 1000 ref 1 bind 0
>> # 	not_in_hw
> 
> - Add xt action with duplicate index
> 
>> # not ok 414 8437 - Add xt action with duplicate index
>> # 	Could not match regex pattern. Verify command output:
>> # total acts 0
>> #
>> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
>> # 	target  LOG level warn prefix \"PONG\"
>> # 	index 101 ref 1 bind 0
>> # 	not_in_hw
> 

Cool! So it seems we have some tests that bit rotted...

> I can see that at least "CONFIG_NF_CONNTRACK_PROCFS" kconfig is needed
> as well for the 373rd test (adding it seems helping: [5]).
> 
> Not sure about the 5 others, I don't know what these tests are doing, I
> came here by accident and I don't think I'm the most appropriated person
> to fix that: do you know if someone can look at the 5 other errors? :)

We can take a look, thank you.

> 
> I can send patches to fix the timeout + the two missing kconfig if you want.

Yes, please. Could you also do one final test with the following?
It will increase the total testing wall time but it's ~time~ we let the 
bull loose.

diff --git a/tools/testing/selftests/tc-testing/tdc.sh 
b/tools/testing/selftests/tc-testing/tdc.sh
index eb357bd7923c..ae6e19f7658d 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -5,3 +5,5 @@ modprobe netdevsim
  modprobe sch_teql
  ./tdc.py -c actions --nobuildebpf
  ./tdc.py -c qdisc
+./tdc.py -c filter
+./tdc.py -c infra



