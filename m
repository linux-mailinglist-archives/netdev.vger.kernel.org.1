Return-Path: <netdev+bounces-23285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6C576B78C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B61C20FCC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB0275B6;
	Tue,  1 Aug 2023 14:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1EF25149
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:29:45 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E926A4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:29:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca5d6dcedso1734775a34.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690900181; x=1691504981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1euAPks1vg0oEAmLyS5oaWoBXH4G+kGiCW6/jXjfAs=;
        b=AuZDmSj+yMaVsNsyBW6UnFUyEsF95BSz5s39373EEQv6NyU0JsKSo1Ig7OoqlweMGe
         2mjEfDsaoXpzWF1sfzkL/WaHHzY3DQx0I9+55ZsUg86az0us8gTcx1vFQeoUOUKNz8fN
         24bEZhyX9+vgjkMH9iac4NAWMpd6b/vTOOC8C39Yk3hYNbvjAbavnnXTz+GHOUqWC+ej
         61DHU8OIZdm83tZIlWJG1QkJIHAj5RlSwNhiOKiFvh1muJFG9uw578oyaR2u72RgI16M
         /gkOcd59Ig1nlnxGopRnSwNXr21Dj3VWCIHEYkuBblreXcWecnRc7erMxlDcXbTuVrZ2
         zN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900181; x=1691504981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1euAPks1vg0oEAmLyS5oaWoBXH4G+kGiCW6/jXjfAs=;
        b=TXf3kAn9L3nSMYbeJ/eDyqrlHL/cXGSJQuU/4VNBtMYVoBXalh0pdMmkLqdfKYKUkD
         kaOPiiiePx1tfc0JW14KRXKUswzvLRL5n1+LxSsZNlZmr+Ec7IoCQshA5PsKlVBHpsnj
         OKmm9jU3qcSOojRPFwA3jf7v/N0gMJjXYo9amaflwBVh+2kygF/fkig/WXlm7/I3TIbL
         6H66Us8PFflouF/3VosynLEooT21HQwYEBfmk/4tLDd3A/7joMx7sS5peF9HLjUs5aNb
         PUxsgxY0sMd73ofu/5HVvrsHTEwgDm4G/99EnDtjVnh33EGsmpumsYjfUCdrMBOIAwtD
         4b8g==
X-Gm-Message-State: ABy/qLYHljFS+JLbVhPY2u6t97lscx7yCPBqFGXI39rt2nqV41o26UED
	o6/x757zxnJLHb0tuKNA/0CWGQ==
X-Google-Smtp-Source: APBJJlGqKFPdpPvk+AL4iqAUcSPl6lhdZ1+Bmo03cg74qADDxCz4DBRowf1ZhqGL+m+HDhS/aOFqdA==
X-Received: by 2002:a05:6870:2198:b0:1bb:fdb7:d979 with SMTP id l24-20020a056870219800b001bbfdb7d979mr13577020oae.11.1690900180967;
        Tue, 01 Aug 2023 07:29:40 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:e1c9:4184:a096:da4? ([2804:14d:5c5e:44fb:e1c9:4184:a096:da4])
        by smtp.gmail.com with ESMTPSA id a18-20020a05687103d200b001b047298a44sm5527659oag.52.2023.08.01.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:29:40 -0700 (PDT)
Message-ID: <43d29fb9-6fcc-4b4d-f25c-fa7fbfccf2fe@mojatatu.com>
Date: Tue, 1 Aug 2023 11:29:36 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 0/2] selftests/tc-testing: initial steps for
 parallel tdc
Content-Language: en-US
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us
References: <20230728154059.1866057-1-pctammela@mojatatu.com>
 <ZMkWaHsVnNOo8xjc@dcaratti.users.ipa.redhat.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <ZMkWaHsVnNOo8xjc@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 11:27, Davide Caratti wrote:
> On Fri, Jul 28, 2023 at 12:40:57PM -0300, Pedro Tammela wrote:
>> As the number of tdc tests is growing, so is our completion wall time.
>> One of the ideas to improve this is to run tests in parallel, as they
>> are self contained. Even though they will serialize over the rtnl lock,
>> we expect it to give a nice boost.
>>
>> A first step is to make each test independent of each other by
>> localizing its resource usage. Today tdc shares everything, including
>> veth / dummy interfaces and netns. In patch 1 we make all of these
>> resources unique per test.
>>
>> Patch 2 updates the tests to the new model, which also simplified some
>> definitions and made them more concise and clearer.
> 
> hello,
> 
> tests are ok!  A couple of (minor) items:
> 
> - the patched code introduces a dependency for python (must be > 3.8).
>    That's ok, but maybe we should put this in clear in the commit message
>    of patch 1/2.

OK! I didn't even notice that.
I will add a runtime check as well.

> - TEQL test passes, but the code doesn't look functional for namespaces:
>    maybe we can keep teql test not requiring nsPlugin?

Sure!

> 
> other than this, looks good to me, thanks!
> 
> Reviewed-and-tested-by: Davide Caratti <dcaratti@redhat.com>
> 

Thank you

