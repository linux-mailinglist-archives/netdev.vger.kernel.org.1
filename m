Return-Path: <netdev+bounces-17695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B5752BB1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDDC1C21485
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3505A1F188;
	Thu, 13 Jul 2023 20:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F96120
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:32:14 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C84B2127
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:32:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a412653335so900268b6e.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689280331; x=1691872331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXz02u5TYNScRL2/9xFhtt2JCy4YzwDSPWx1W5uVMXU=;
        b=YjMuVsg293+INyd/P+FWezp68r8pfxjTcz6zci2iaPOo0Qd2Nhjlx75Oj0ry9EMnll
         RTzUscgAWocfok5+MbszhUSRCVYu1osVf6QtbWDSYzCQ3/dutA8ldSX7uKC2YfG7jC9k
         7zRu7vOXAy2pagFJG+iejm3GRY/pesPo036fUrnCKHDFbpujFLh3kRdYjlTdy7ExxBDL
         IzpgupGk/Mi0hBCWwNJiP26cyqu1I9l5qmYj7i29kOjqwsq3PVCncKS6WXDHq30qpu4+
         n+CW7GOkVcvBVksqXSGdoSXkW45qsD3Adjz0DnD/eHcjBvYAtUD2jhkDcOPmwQpWC20N
         23OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280331; x=1691872331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXz02u5TYNScRL2/9xFhtt2JCy4YzwDSPWx1W5uVMXU=;
        b=VtH3EphoQDg2GvggEPHeyoFVjp25Dtbo8fG/SPZTupksRGr5bIzGC99G9hS5gRouy7
         veA3hjIUGrIYxnSwrDFP8DU52hPbb6J1WLYVge4BMh74b65yqeV6Xg80GQn1LV9XcHfg
         ZXk8qLV8By7Cje5v0lYE74Y8x7yw2zM2lfxluiXSLeBdNMbCVpZ/0Pb8odWidjNPWn+4
         MWiNlmwXDV4CJAl0bi6wUyukUhra0vdO28AOG7W12S2MrhnslFjUHobZJeqs8kUNOf2A
         +aISwD+wkSUydFoZ2Ji4LfVljxBH7PDi9f1JMI51SUIPHsROSTY1dsmLavIgTioXj3Kz
         Eocw==
X-Gm-Message-State: ABy/qLZDrn3xRYyMLwP0ZkOEdpOUAUwZtlgliflFiVv9qxxgoTHka4gx
	XlkOC53sFdb7PvKxa69A+NEUpQ==
X-Google-Smtp-Source: APBJJlG5FBfR53wxAvNdIdbNWFL4Wbyz4JWCUNf5R1nxGbTfJtKK5b3hRchbPTqdRTu2HSkNEzRkMA==
X-Received: by 2002:a05:6808:1a01:b0:3a4:316c:8eeb with SMTP id bk1-20020a0568081a0100b003a4316c8eebmr3333601oib.40.1689280330832;
        Thu, 13 Jul 2023 13:32:10 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3ecf:3d37:de47:ff6b? ([2804:14d:5c5e:44fb:3ecf:3d37:de47:ff6b])
        by smtp.gmail.com with ESMTPSA id b21-20020aca2215000000b003a375c11aa5sm3265976oic.30.2023.07.13.13.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:32:10 -0700 (PDT)
Message-ID: <3b7a96db-70a1-9907-6caf-e89e811d40f6@mojatatu.com>
Date: Thu, 13 Jul 2023 17:32:06 -0300
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
 <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com>
 <fdf52d83-6e58-3284-8c61-66cf218c7083@tessares.net>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <fdf52d83-6e58-3284-8c61-66cf218c7083@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 16:59, Matthieu Baerts wrote:
> Hi Pedro,
> 
> On 13/07/2023 19:30, Pedro Tammela wrote:
>> On 13/07/2023 10:59, Matthieu Baerts wrote:
> 
> (...)
> 
>>> We can see that all tests have been executed except one:
>>>
>>>> # ok 495 6bda - Add tunnel_key action with nofrag option # skipped -
>>>> probe command: test skipped.
>>>
>>> Maybe something else missing?
> 
> Do you think this one can be due to a missing kconfig? This command is
> failing:
> 
>    $TC actions add action tunnel_key help 2>&1 | grep -q nofrag
> 
> Or maybe that's normal, e.g. a feature no longer there?

I know what's happening... more below

> 
>>> Other than that, 6 tests have failed:
> 
> (...)
> 
>> Cool! So it seems we have some tests that bit rotted...
> 
> Who doesn't? :)
> 
>>> I can see that at least "CONFIG_NF_CONNTRACK_PROCFS" kconfig is needed
>>> as well for the 373rd test (adding it seems helping: [5]).
>>>
>>> Not sure about the 5 others, I don't know what these tests are doing, I
>>> came here by accident and I don't think I'm the most appropriated person
>>> to fix that: do you know if someone can look at the 5 other errors? :)
>>
>> We can take a look, thank you.
> 
> Thank you!
> 
>>> I can send patches to fix the timeout + the two missing kconfig if you
>>> want.
>>
>> Yes, please.
> 
> Sure, will do!
> 
>> Could you also do one final test with the following?
>> It will increase the total testing wall time but it's ~time~ we let the
>> bull loose.
> 
> Just did, it took just over 3 minutes (~3:05), see the log file in [1]
> (test job in [2] and build job in [3]).
> 
> Not much longer but 15 more tests failing :)
> Also, 12 new tests have been skipped:
> 
>> Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
> But I guess that's normal when executing tdc.sh.
> 

Yep, some tests could require physical hardware, so it's ok to skip those.

As for some of the tests that failed / skipped, it might be because of 
an old iproute2.
I see that's using bookworm as the rootfs, which has the 6.1 iproute2.
Generally tdc should run with the matching iproute2 version although 
it's not really required but rather recommended.
We do have a 'dependsOn' directive to skip in case of mismatches, so 
perhaps it might be necessary to adjust some of these tests.

OTOH, is it possible to have a rootfs which runs the tests in tandem 
with iproute2-next?

Thanks for chasing this! I will let the guys know and we will try to fix 
the test failures.


