Return-Path: <netdev+bounces-17268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EE7750F55
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0391C21027
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE320F8C;
	Wed, 12 Jul 2023 17:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECD14F74
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:12:30 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE210B
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:12:28 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so607420eaf.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689181948; x=1691773948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKOQnEOLMmerIKlixWlGKMrdiR4Q+oOwWNf5K9+7qOc=;
        b=1q4NrfwgmqGvVN17EK0lf8H66ysk/x4AlfaOKc1hxHOzeQ6/oOU6HkZNYKTJDYtI4k
         T+cSm8QRUFICzn3s3ZWalDyAhmBCoY9y0pEbHOZ0pKeNGXEzZ/f/hJsqrjh6TH8ebDh4
         xT/qIRGdF3LkAwwQuOuuwzvjgw2cDrnwLXkwHnQkPkBkEThqnZWvmVnd7NzF+y+qQZ8K
         bmUtP1zBblrYQGxNiqDQb+y7L07I2JiCcNUH2frfl4uDHU3SnW1w19f+0E/YlxMr4v6e
         KcW0FEzEozNFG/7WQSAsRKKQeIeZZ4WrBtpPhReXM1hGkxACoC9qBJkDJ2aSxtEWASzI
         KZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181948; x=1691773948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKOQnEOLMmerIKlixWlGKMrdiR4Q+oOwWNf5K9+7qOc=;
        b=V0uq2Mk1O9Ed8C2Raq72fvwqt8yddG32KnRCK2S8NnukHtEsqg2Xvfh37W7/XPFmAe
         Ig8Sa0KwjxI9TJawTTm22i36NFcTOKNRQFW/MY6zqixYdO2Hd5IyhM1NfJqlYuZTNK7s
         zFRIhWhZg3e2/gi6+vpcWsK8MJDGmHACgNe9ALTmTjjNXU1GV1iAwkImwwdMfVapQcbD
         XE97ioTVd+stsMYLaXeTeeOiueWtsWbq+qfvGCynIt8cYqizdw8CSrvMpdHqQv0uw26p
         ThbpCsX39odY3c8Jn+E5OBm4SnIhhtV/zj5qmR9Qko5RuRLjlnPoMuLqLDlHK6UYUG/t
         hHbA==
X-Gm-Message-State: ABy/qLbMOBndYd+1n8fZ8uVfm1lMXN35FDrXNfJFnJnpX/ul8SBV1AAR
	g0wAlZxgDgIASN4XRE+QQiNqIg==
X-Google-Smtp-Source: APBJJlEsbMlBBgnMUHUTcxyrMm93ybSGvvJcK7fpkW3NqssCjI0XlPa/OPQ9xojqv7bCd9x9ElFlow==
X-Received: by 2002:a4a:d0aa:0:b0:560:c558:b6f9 with SMTP id t10-20020a4ad0aa000000b00560c558b6f9mr1936185oor.2.1689181947934;
        Wed, 12 Jul 2023 10:12:27 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:f14e:a0e2:ad5:7847? ([2804:14d:5c5e:44fb:f14e:a0e2:ad5:7847])
        by smtp.gmail.com with ESMTPSA id 66-20020a4a0945000000b0056082ad01desm2039706ooa.14.2023.07.12.10.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:12:27 -0700 (PDT)
Message-ID: <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com>
Date: Wed, 12 Jul 2023 14:12:23 -0300
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
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/07/2023 11:43, Matthieu Baerts wrote:
> Hi Pedro,
> 
> On 12/07/2023 15:43, Pedro Tammela wrote:
>> I have been involved in tdc for a while now, here are my comments.
> 
> Thank you for your reply!
> 
>> On 12/07/2023 06:47, Matthieu Baerts wrote:
>>> Hi Jamal, Cong, Jiri,
>>>
>>> When looking for something else [1] in LKFT reports [2], I noticed that
>>> the TC selftest ended with a timeout error:
>>>
>>>     not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
>>>
>>> The timeout has been introduced 3 years ago:
>>>
>>>     852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
>>> per test")
>>>
>>> Recently, a new option has been introduced to override the value when
>>> executing the code:
>>>
>>>     f6a01213e3f8 ("selftests: allow runners to override the timeout")
>>>
>>> But I guess it is still better to set a higher default value for TC
>>> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
>>> "settings" file in 'tc-testing' directory, e.g.
>>>
>>>     echo timeout=1200 > tools/testing/selftests/tc-testing/settings
>>>
>>> I'm sending this email instead of a patch because I don't know which
>>> value makes sense. I guess you know how long the tests can take in a
>>> (very) slow environment and you might want to avoid this timeout error.
>>
>> I believe a timeout between 5-10 to minutes should cover the entire suite
> 
> Thank you for your feedback.
> If we want to be on the safe side, I guess it is better to put 10
> minutes or even 15, no?

Sure, makes sense.
If someone complains we can lower it.

> 
>>> I also noticed most of the tests were skipped [2], probably because
>>> something is missing in the test environment? Do not hesitate to contact
>>> the lkft team [3], that's certainly easy to fix and it would increase
>>> the TC test coverage when they are validating all the different kernel
>>> versions :)
>>
>>  From the logs it seems like the kernel image is missing the 'ct' action.
>> Possibly also missing other actions/tc components, so it seems like a
>> kernel config issue.
> 
> According to [1], the kconfig is generated by merging these files:
> 
>    defconfig, systemd.config [2], tools/testing/selftests/kexec/config,
> tools/testing/selftests/net/config,
> tools/testing/selftests/net/mptcp/config,
> tools/testing/selftests/net/hsr/config,
> tools/testing/selftests/net/forwarding/config,
> tools/testing/selftests/tc-testing/config
> 
> You can see the final .config file in [3].
> 
> I can see "CONFIG_NET_ACT_CTINFO(=m)" but not "CONFIG_NET_ACT_CT" while
> they are both in tc-testing/config file. Maybe a conflict with another
> selftest config?
> 
> I don't see any mention of "NET_ACT_CT" in the build logs [4].

There's a requirement for NET_ACT_CT which is not set in the final 
config (CONFIG_NF_FLOW_TABLE).

Perhaps this could fix?
diff --git a/tools/testing/selftests/tc-testing/config 
b/tools/testing/selftests/tc-testing/config
index 6e73b09c20c8..d1ad29040c02 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
  CONFIG_NF_CONNTRACK_MARK=y
  CONFIG_NF_CONNTRACK_ZONES=y
  CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_FLOW_TABLE=m
  CONFIG_NF_NAT=m
  CONFIG_NETFILTER_XT_TARGET_LOG=m

