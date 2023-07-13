Return-Path: <netdev+bounces-17692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C869752B47
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21545281F06
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D1200B9;
	Thu, 13 Jul 2023 19:59:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4D1ED53
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:59:11 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17362D4B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:59:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314313f127fso1259792f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689278348; x=1691870348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hf9EFrDukg/UctSblWVYGPFrQvoDqNmRl1qffi8QnfI=;
        b=E4ONS0nMC6r0npatR37rMk7v2k02drkzGMM9nYXSkhhAf7EqNvv96poBwSyBQNVegh
         73e+We3rSsHRcNUOc4TEZHONyEUDIstW96n0oaw5r2Dv2Ug01/7brWGBCtPAnThyktpG
         wwU9Ig05hTRUWw5N/5CKGOZo32eOgnEOBFCzvU5JrvKl9J0mHiPox6D2DT2DxyKmTFGJ
         j6RjzqN7/YqMxx5ne1mc7sbPyEMl7a8awGZaS+siDoJ/U7z5dhP4ZhO4Ec0w3Iukj4t7
         0YwCV98TemYDGIQD0Bch3D6bG8Y3nwirQuxNcljXGVas1kheFaTSvudoTZolpqBm2SiM
         dwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278348; x=1691870348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hf9EFrDukg/UctSblWVYGPFrQvoDqNmRl1qffi8QnfI=;
        b=c2FYKuLsFQHfhcVPHJ+85fDJcNvIuWJYCpN5UKUKw6E5EUMjfTeIYhDk4wwtyeFB5l
         dSaBpRW7/I/BpzQCJi9uKnTgs4kMUkd06neF5pUnQvrlrRDnDjxZ+Cx90CWOdPLKa73j
         00VTqlHDxrusSUily6/j8DwqGD+vcBTtMnL1pmYL0Ds5Rm2+pNUHZSrIprsQ3p5awCd1
         KEaN92FalqpLmAI5Uz1HFwHyd5DCAPtO0y6YAdltJGdC92zdkkX8LzU4qd44pACBiN/p
         KU/h8bFhpCp84/74WF8qgf7IY5m4E1lkRU+V0pxsOnDXb6THwBh6NeBqRqLyZXxp8lcM
         bRWg==
X-Gm-Message-State: ABy/qLY4UAF0clVzO8JYMBdGt7Zk4GlI9r54L09otcPPNMF6fm8CGCKP
	A8TI8DGqL94WHnHdmTGi40vGWw==
X-Google-Smtp-Source: APBJJlEtnR6yceyE2Iyf5t5Lms7Aig6d22/AdyN9Po/qn143FRpmRv3rDbgUV4D3wK83/NEFZNoQYw==
X-Received: by 2002:a05:6000:11c4:b0:314:248d:d9df with SMTP id i4-20020a05600011c400b00314248dd9dfmr2356201wrx.13.1689278347948;
        Thu, 13 Jul 2023 12:59:07 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d855:a28a:e0c1:ddc1? ([2a02:578:8593:1200:d855:a28a:e0c1:ddc1])
        by smtp.gmail.com with ESMTPSA id i17-20020adff311000000b003143853590csm8812187wro.104.2023.07.13.12.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:59:07 -0700 (PDT)
Message-ID: <fdf52d83-6e58-3284-8c61-66cf218c7083@tessares.net>
Date: Thu, 13 Jul 2023 21:59:06 +0200
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
 <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
 <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pedro,

On 13/07/2023 19:30, Pedro Tammela wrote:
> On 13/07/2023 10:59, Matthieu Baerts wrote:

(...)

>> We can see that all tests have been executed except one:
>>
>>> # ok 495 6bda - Add tunnel_key action with nofrag option # skipped -
>>> probe command: test skipped.
>>
>> Maybe something else missing?

Do you think this one can be due to a missing kconfig? This command is
failing:

  $TC actions add action tunnel_key help 2>&1 | grep -q nofrag

Or maybe that's normal, e.g. a feature no longer there?

>> Other than that, 6 tests have failed:

(...)

> Cool! So it seems we have some tests that bit rotted...

Who doesn't? :)

>> I can see that at least "CONFIG_NF_CONNTRACK_PROCFS" kconfig is needed
>> as well for the 373rd test (adding it seems helping: [5]).
>>
>> Not sure about the 5 others, I don't know what these tests are doing, I
>> came here by accident and I don't think I'm the most appropriated person
>> to fix that: do you know if someone can look at the 5 other errors? :)
> 
> We can take a look, thank you.

Thank you!

>> I can send patches to fix the timeout + the two missing kconfig if you
>> want.
> 
> Yes, please.

Sure, will do!

> Could you also do one final test with the following?
> It will increase the total testing wall time but it's ~time~ we let the
> bull loose.

Just did, it took just over 3 minutes (~3:05), see the log file in [1]
(test job in [2] and build job in [3]).

Not much longer but 15 more tests failing :)
Also, 12 new tests have been skipped:

> Tests using the DEV2 variable must define the name of a physical NIC with the -d option when running tdc.
But I guess that's normal when executing tdc.sh.

Cheers,
Matt

[1]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWzPV0rAEkfm82nptjEpjN1syj/logs?format=html
[2]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/tests/2SWzPV0rAEkfm82nptjEpjN1syj
[3]
https://tuxapi.tuxsuite.com/v1/groups/community/projects/matthieu.baerts/builds/2SWwyRVr1ZCKUNJ7wUqESGnRnjq
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

