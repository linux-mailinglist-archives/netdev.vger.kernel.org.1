Return-Path: <netdev+bounces-17158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4063F7509D7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EB22819C0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9D2AB5A;
	Wed, 12 Jul 2023 13:43:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268B2AB54
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:43:42 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C98E77
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:43:40 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b0156a1c49so5627597fac.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689169420; x=1691761420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8LxYLB+qeM2DIxJxB75hYDwUwbOID2optHHPDBcsHo=;
        b=XltMWHCojrsqoGEpOJOklgiEWOgeavh55G8xZIL9bkvxZASawKPITqJtXfeX4RXNFa
         KL3QeppTpFKxEtT3lf9M6QPRo6F0bdehQSTFVoXIOaQZcLsiEY1e8rgF2U9Sz95UyfGY
         usYfKYRBwR6R4NzcYaunrHPuhVtV4z+BBazuai+ekg6gw27ZRZJwec2PPlviQh5b1fDG
         UprpGeFk7HJsXcpDfAaIl4bpj1AiydHCK9KzkGxElBvi1koS98wqnvrGMMKsrhgXM17K
         YqrSs9do8y961Xanxhu77E5VV2FEYUcV5VvDfjFCRwpMJGRpAjASuFlZh1JlsYoUCxuz
         Bxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169420; x=1691761420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8LxYLB+qeM2DIxJxB75hYDwUwbOID2optHHPDBcsHo=;
        b=Y0/Taxyb9D6KM/Fz7rPH9N1yFzyNjB3MN8iKX3qAhU1fwfQCd6dkPAhzvphcLNUULE
         XEI6AUx87eJFWM6Ja5vXy9G79P7spbiQ2CYpPGv6M6DCVz8fvSal1peMwt2ToLQXtPVC
         Pmv8Wy42XgkHelSiVdm6dQTZOvOyyLIp30qjMO64XXz5tXxCa6mY522Bq9pXbPInxZdW
         FvGM3MzDNX9K0sne5SWoTAPrFV4easK8stLLz+4Yp4mh0nMF9WK59Sd9SdCxUeLT8y+a
         nFGDjSA+JGZBZ6CUMS6xTsT960lY1+bi8FkrQqEoBv/YQpGKPreh0SNNqC9tbmQXIzUU
         e/rg==
X-Gm-Message-State: ABy/qLbsprSU5hpZOBtjdU/VbYTof+90cKjbEq1ygCgd52M1d6+2krR0
	ItxGko7a+jOY/5rO4U9Ui6moaw==
X-Google-Smtp-Source: APBJJlFKxXEeWdRtHd5TbP9cQQ3y3la0FyuffHtRZ4/YQ703GWo7/qoYXdEm/39EOWsEfcMlfmNFQQ==
X-Received: by 2002:a05:6870:1fc9:b0:1ad:e92:62e1 with SMTP id gp9-20020a0568701fc900b001ad0e9262e1mr18820560oac.54.1689169420001;
        Wed, 12 Jul 2023 06:43:40 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:f14e:a0e2:ad5:7847? ([2804:14d:5c5e:44fb:f14e:a0e2:ad5:7847])
        by smtp.gmail.com with ESMTPSA id du9-20020a0568703a0900b001b3d67934e9sm1991686oab.26.2023.07.12.06.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:43:39 -0700 (PDT)
Message-ID: <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
Date: Wed, 12 Jul 2023 10:43:35 -0300
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
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Matthieu,

I have been involved in tdc for a while now, here are my comments.

On 12/07/2023 06:47, Matthieu Baerts wrote:
> Hi Jamal, Cong, Jiri,
> 
> When looking for something else [1] in LKFT reports [2], I noticed that
> the TC selftest ended with a timeout error:
> 
>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> 
> The timeout has been introduced 3 years ago:
> 
>    852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout
> per test")
> 
> Recently, a new option has been introduced to override the value when
> executing the code:
> 
>    f6a01213e3f8 ("selftests: allow runners to override the timeout")
> 
> But I guess it is still better to set a higher default value for TC
> tests. This is easy to fix by simply adding "timeout=<seconds>" in a
> "settings" file in 'tc-testing' directory, e.g.
> 
>    echo timeout=1200 > tools/testing/selftests/tc-testing/settings
> 
> I'm sending this email instead of a patch because I don't know which
> value makes sense. I guess you know how long the tests can take in a
> (very) slow environment and you might want to avoid this timeout error.

I believe a timeout between 5-10 to minutes should cover the entire suite
> 
> I also noticed most of the tests were skipped [2], probably because
> something is missing in the test environment? Do not hesitate to contact
> the lkft team [3], that's certainly easy to fix and it would increase
> the TC test coverage when they are validating all the different kernel
> versions :)

 From the logs it seems like the kernel image is missing the 'ct' 
action. Possibly also missing other actions/tc components, so it seems 
like a kernel config issue.

Interestingly enough the `tdc.sh` script doesn't test the filter and 
infrastructure categories. Perhaps it would be better to let it run the 
entire suite instead of just a few tests. It could probably break some 
other automated testing out there but it will be worth it, specially 
since we have been adding some regression tests lately.

I do know RedHat runs tdc, so let's ask their opinion.
+Davide WDYT?

> 
> Cheers,
> Matt
> 
> [1] The impact of https://github.com/Linaro/test-definitions/pull/446
> [2]
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/test/tc-testing_tdc_sh/log
> [3] lkft@linaro.org


