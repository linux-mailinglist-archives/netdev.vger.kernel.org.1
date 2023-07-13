Return-Path: <netdev+bounces-17598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260B175247D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37D1281DFE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25217AB5;
	Thu, 13 Jul 2023 13:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4415ADC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:59:34 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D31FF7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:59:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31434226a2eso947241f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689256769; x=1691848769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfWuI9qC9sSl5G8mUvdZleATnoptt0fLzhcLQ6QfpPU=;
        b=rQ2syeW//8GSAhxzDqbdhHqx+WnrmHR0kftOz3f2BZNJqXXREvpAL3RsD4osK69TJm
         znHrXPvOZ/W/bQ5DnUZrurhshsgZmcLE07Y1PGmigSD5vEGPMNLjpv9KvPOfUK798Th5
         zABPwy/fqGqWDlNQOxTB7Z51ovLsnwEJCWNDvJ1dAIw1mmAFAnY7ky67nE4CKv/V+d3G
         BUuWEtlLVLrfoOn+M85Yh0Eby6NYyRkuuaFCKDZbgEdeTNR771BqWGfO5k9NOhnCTv5p
         uD+GaxBh4/qquL6tXWxRr+GCZGCfhAON2m0ufVK1tdkyYpPPQBlAxHUxfzshx8UOLqJJ
         XENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256769; x=1691848769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfWuI9qC9sSl5G8mUvdZleATnoptt0fLzhcLQ6QfpPU=;
        b=gB4k/pJTP3XakumqkQVqWKGXFvxEQiLeiIF5bYTrujGulZlrhsOx7rjB1P1HaTuEqU
         7rL/jErhIpXhBe2PEihpM2ijlc6NEBKLLwQ2G1nLOhyx19bYQQGXR2yr6ORwmIxTlepU
         c1bDKYKt1WuJ8wLip1noXPkeEidcrHbktWCumsQa/VqqZfFT0Z9CjIXsvMg/TG3RhOzJ
         YzG7zNGZkN5EL1U2h51SfOwylZ59kQTMgwUjj2wHdKUrv7x0evXAO64r74UyxeV1aWGd
         C4Wf8sM/pnSKUeuMuBK9l22DdDJpblu/rN/umm45UH5SSgWtnLwKQL0W6126ACVrZaZr
         saKQ==
X-Gm-Message-State: ABy/qLYZ3Je6h1HvpVD3y0xRYe8oznWhhaxo5FrNbMk1FDSUZe2p9tDH
	V+pvCitKvwEZIAnImUQ2g4IUHA==
X-Google-Smtp-Source: APBJJlGKibgDaBJ+4uK71NwkTvmYFy/WHklfMbOwTW3d0GOW/rEZH1eBKfYN2QGjUZsoUcFpoELgyw==
X-Received: by 2002:adf:cd8a:0:b0:313:dfa3:4f7b with SMTP id q10-20020adfcd8a000000b00313dfa34f7bmr1781185wrj.20.1689256769071;
        Thu, 13 Jul 2023 06:59:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c2e6:680:ced7:5e59? ([2a02:578:8593:1200:c2e6:680:ced7:5e59])
        by smtp.gmail.com with ESMTPSA id c18-20020a7bc012000000b003fbd2a9e94asm7980965wmb.31.2023.07.13.06.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:59:28 -0700 (PDT)
Message-ID: <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
Date: Thu, 13 Jul 2023 15:59:27 +0200
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
 <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
 <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pedro,

On 12/07/2023 19:12, Pedro Tammela wrote:
> On 12/07/2023 11:43, Matthieu Baerts wrote:
>> Hi Pedro,
>>
>> On 12/07/2023 15:43, Pedro Tammela wrote:
>>> I have been involved in tdc for a while now, here are my comments.
>>
>> Thank you for your reply!
>>
>>> On 12/07/2023 06:47, Matthieu Baerts wrote:
>>>> Hi Jamal, Cong, Jiri,
>>>>
>>>> When looking for something else [1] in LKFT reports [2], I noticed that
>>>> the TC selftest ended with a timeout error:
>>>>
>>>>     not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>>>
>>>> The timeout has been introduced 3 years ago:
>>>>
>>>>     852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
>>>> per test")
>>>>
>>>> Recently, a new option has been introduced to override the value when
>>>> executing the code:
>>>>
>>>>     f6a01213e3f8 ("selftests: allow runners to override the timeout")
>>>>
>>>> But I guess it is still better to set a higher default value for TC
>>>> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
>>>> "settings" file in 'tc-testing' directory, e.g.
>>>>
>>>>     echo timeout=1200 > tools/testing/selftests/tc-testing/settings
>>>>
>>>> I'm sending this email instead of a patch because I don't know which
>>>> value makes sense. I guess you know how long the tests can take in a
>>>> (very) slow environment and you might want to avoid this timeout error.
>>>
>>> I believe a timeout between 5-10 to minutes should cover the entire
>>> suite
>>
>> Thank you for your feedback.
>> If we want to be on the safe side, I guess it is better to put 10
>> minutes or even 15, no?
> 
> Sure, makes sense.
> If someone complains we can lower it.
> 
>>
>>>> I also noticed most of the tests were skipped [2], probably because
>>>> something is missing in the test environment? Do not hesitate to
>>>> contact
>>>> the lkft team [3], that's certainly easy to fix and it would increase
>>>> the TC test coverage when they are validating all the different kernel
>>>> versions :)
>>>
>>>  From the logs it seems like the kernel image is missing the 'ct'
>>> action.
>>> Possibly also missing other actions/tc components, so it seems like a
>>> kernel config issue.
>>
>> According to [1], the kconfig is generated by merging these files:
>>
>>    defconfig, systemd.config [2], tools/testing/selftests/kexec/config,
>> tools/testing/selftests/net/config,
>> tools/testing/selftests/net/mptcp/config,
>> tools/testing/selftests/net/hsr/config,
>> tools/testing/selftests/net/forwarding/config,
>> tools/testing/selftests/tc-testing/config
>>
>> You can see the final .config file in [3].
>>
>> I can see "CONFIG_NET_ACT_CTINFO(=m)" but not "CONFIG_NET_ACT_CT" while
>> they are both in tc-testing/config file. Maybe a conflict with another
>> selftest config?
>>
>> I don't see any mention of "NET_ACT_CT" in the build logs [4].
> 
> There's a requirement for NET_ACT_CT which is not set in the final
> config (CONFIG_NF_FLOW_TABLE).
> 
> Perhaps this could fix?
> diff --git a/tools/testing/selftests/tc-testing/config
> b/tools/testing/selftests/tc-testing/config
> index 6e73b09c20c8..d1ad29040c02 100644
> --- a/tools/testing/selftests/tc-testing/config
> +++ b/tools/testing/selftests/tc-testing/config
> @@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
>  CONFIG_NF_CONNTRACK_MARK=y
>  CONFIG_NF_CONNTRACK_ZONES=y
>  CONFIG_NF_CONNTRACK_LABELS=y
> +CONFIG_NF_FLOW_TABLE=m
>  CONFIG_NF_NAT=m
>  CONFIG_NETFILTER_XT_TARGET_LOG=m

Yes it does!

I got access to the tuxsuite to reproduce the issues with the suggested
fixes. The i386 build job is visible in [1] (kconfig in [2]) and the
test job in [3] (logs in [4]).

[1]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/builds/2SW6Vk3VYTGyW90OBecA3knJFIz
[2]
https://storage.tuxsuite.com/public/community/matthieu.baerts/builds/2SW6Vk3VYTGyW90OBecA3knJFIz/config
[3]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWB6sYne9afpOxqp3CNE5BxAn8
[4]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWB6sYne9afpOxqp3CNE5BxAn8/logs?format=html


Note that the TC tests have been executed in less than 3 minutes. 15
minutes seem more than enough then! (I don't know how "fast" is this
environment).

We can see that all tests have been executed except one:

> # ok 495 6bda - Add tunnel_key action with nofrag option # skipped - probe command: test skipped.

Maybe something else missing?

Other than that, 6 tests have failed:

- Add skbedit action with valid mark and mask with invalid format

> # not ok 284 bc15 - Add skbedit action with valid mark and mask with invalid format
> # 	Command exited with 0, expected 255

- Add ct action triggering DNAT tuple conflict:

> # not ok 373 3992 - Add ct action triggering DNAT tuple conflict
> # 	Could not match regex pattern. Verify command output:
> # cat: /proc/net/nf_conntrack: No such file or directory

- Add xt action with log-prefix

> # not ok 408 2029 - Add xt action with log-prefix
> # 	Could not match regex pattern. Verify command output:
> # total acts 1
> # 
> # 	action order 0: tablename: mangle  hook: NF_IP_POST_ROUTING
> # 	target  LOG level warn prefix \"PONG\"
> # 	index 100 ref 1 bind 0
> # 	not_in_hw

- Replace xt action log-prefix

> # not ok 409 3562 - Replace xt action log-prefix
> # 	Could not match regex pattern. Verify command output:
> # total acts 0
> # 
> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
> # 	target  LOG level warn prefix \"WIN\"
> # 	index 1 ref 1 bind 0
> # 	not_in_hw

- Delete xt action with invalid index

> # not ok 411 5169 - Delete xt action with invalid index
> # 	Could not match regex pattern. Verify command output:
> # total acts 0
> # 
> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
> # 	target  LOG level warn prefix \"PONG\"
> # 	index 1000 ref 1 bind 0
> # 	not_in_hw

- Add xt action with duplicate index

> # not ok 414 8437 - Add xt action with duplicate index
> # 	Could not match regex pattern. Verify command output:
> # total acts 0
> # 
> # 	action order 1: tablename: mangle  hook: NF_IP_POST_ROUTING
> # 	target  LOG level warn prefix \"PONG\"
> # 	index 101 ref 1 bind 0
> # 	not_in_hw

I can see that at least "CONFIG_NF_CONNTRACK_PROCFS" kconfig is needed
as well for the 373rd test (adding it seems helping: [5]).

Not sure about the 5 others, I don't know what these tests are doing, I
came here by accident and I don't think I'm the most appropriated person
to fix that: do you know if someone can look at the 5 other errors? :)

I can send patches to fix the timeout + the two missing kconfig if you want.

Cheers,
Matt

[5]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWHb7PJfqkUX1m8rLu3GXbsHE0/logs?format=html
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

