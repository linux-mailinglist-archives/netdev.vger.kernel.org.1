Return-Path: <netdev+bounces-17697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3112752BE6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 23:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C8B1C21478
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7F200CB;
	Thu, 13 Jul 2023 21:11:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB461E536
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:11:11 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4C2D43
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:11:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so11024885e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689282666; x=1691874666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMcwAFTjOnyTS+kPT7yXnXht1Htba9oLhdBwkNZOrQ4=;
        b=HL8jQ3LyPgEPU16NjfsR2p8bRYNW/X0XlJ9VN5Gqjtw/4rabJpqSq4wYbOheeQlCy6
         Q/SwvwqCZ9okt5+8oWF72X4T9FAnKhGs5HWw8Tzimr1A+rzm5R/0xBMbTePbsa6BJgPw
         jLkT1JbHrRrHrgSr8tj7Nk3J7z62fKrTwhQ54nxiNDMoQC6yi+Z/Kr/33gVCigS3aCTI
         xlQezl+Nw0mur6GktElFlYzrvt9EE0mOPAsodCbP0CYntsbinuoviJodV3+iEa96IY37
         7SmKX6UesrH38NWFVmOOYOJQPiXeP+6+HP30nbSyY5E0QUCDVA1KJ/NpQM7TRU4cyO5x
         WapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689282666; x=1691874666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMcwAFTjOnyTS+kPT7yXnXht1Htba9oLhdBwkNZOrQ4=;
        b=bLrOWtAzCdi/aQyHFROYdHNcmvz+EIwj8CdCKmjYE63B+oUtvUIr4RFdFTk7DsXuau
         OIxBlsfjPItYyp8TNKRUImgqvIeyau8qgnTviRHms4Gq4o93lIogzsviKpa6ZjOGmPQr
         +R6RQyJMPls4J1LPWPwd3s4rqL1esEW9j8L7UJsaMi+f/zPSJ/+eMWPqbATi3qS9NZQ0
         7C11TPLtSg5/XUE/qgW7co/WXkAPnOBJzvA7FVng8hde7PC57eU7IO9N5sMCTXnNIZkU
         Iu+iSXYlPx7ygsUkiKF5QdLwg+OXZP2JD+H/pkEkb6zv3aoH0bOHYrc8g4pAT9arfLru
         xIlg==
X-Gm-Message-State: ABy/qLa2Ocg8Yidt48KUBmzwtIRzXTEY2K3kDIrbDlQ6vmTjKN8GEcsx
	x1S97fjPPxoTg2nV+9ANnVwh/vJxhbqe5TqeCpv8cugS
X-Google-Smtp-Source: APBJJlEsZI5b3rB95rgwRwJjbq6f1zRZykRdfsSjNc5zztMVV0dFxADNv0U8NwUiMpw5SA4EVg8DZw==
X-Received: by 2002:a7b:c7c5:0:b0:3fb:cf8e:c934 with SMTP id z5-20020a7bc7c5000000b003fbcf8ec934mr2399027wmk.27.1689282666056;
        Thu, 13 Jul 2023 14:11:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d855:a28a:e0c1:ddc1? ([2a02:578:8593:1200:d855:a28a:e0c1:ddc1])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c211200b003fbbe41fd78sm8755849wml.10.2023.07.13.14.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 14:11:05 -0700 (PDT)
Message-ID: <ccfa7c51-d328-4222-1921-631f10057349@tessares.net>
Date: Thu, 13 Jul 2023 23:11:04 +0200
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
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Cc: netdev <netdev@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Davide Caratti <dcaratti@redhat.com>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
 <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
 <0f762e7b-f392-9311-6afc-ed54bf73a980@mojatatu.com>
 <35329166-56a7-a57e-666e-6a5e6616ac4d@tessares.net>
 <593be21c-b559-8e9c-25ad-5f4291811411@mojatatu.com>
 <fdf52d83-6e58-3284-8c61-66cf218c7083@tessares.net>
 <3b7a96db-70a1-9907-6caf-e89e811d40f6@mojatatu.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3b7a96db-70a1-9907-6caf-e89e811d40f6@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pedro, LKFT team,

@LKFT team: there is question for you below.

On 13/07/2023 22:32, Pedro Tammela wrote:
> On 13/07/2023 16:59, Matthieu Baerts wrote:
>> On 13/07/2023 19:30, Pedro Tammela wrote:

(...)

>>> Could you also do one final test with the following?
>>> It will increase the total testing wall time but it's ~time~ we let the
>>> bull loose.
>>
>> Just did, it took just over 3 minutes (~3:05), see the log file in [1]
>> (test job in [2] and build job in [3]).
>>
>> Not much longer but 15 more tests failing :)
>> Also, 12 new tests have been skipped:
>>
>>> Tests using the DEV2 variable must define the name of a physical NIC
>>> with the -d option when running tdc.
>> But I guess that's normal when executing tdc.sh.
>>
> 
> Yep, some tests could require physical hardware, so it's ok to skip those.

OK

> As for some of the tests that failed / skipped, it might be because of
> an old iproute2.
> I see that's using bookworm as the rootfs, which has the 6.1 iproute2.
> Generally tdc should run with the matching iproute2 version although
> it's not really required but rather recommended.

Ah yes, it makes sense!

> We do have a 'dependsOn' directive to skip in case of mismatches, so
> perhaps it might be necessary to adjust some of these tests.

Yes, better to skip. Especially because the selftests are supposed to
support old tools and kernel versions:

  https://lore.kernel.org/stable/ZAHLYvOPEYghRcJ1@kroah.com/

> OTOH, is it possible to have a rootfs which runs the tests in tandem
> with iproute2-next?

I don't know :)
But I hope the LKFT team can help answering this question!

@LKFT team: is it possible to run the latest iproute2 version, even the
one from iproute2-next when validating linux-next?

> Thanks for chasing this! I will let the guys know and we will try to fix
> the test failures.

Thank you for your support!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

