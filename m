Return-Path: <netdev+bounces-22376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C571767373
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4070281C11
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05046156E8;
	Fri, 28 Jul 2023 17:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654B1118C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:33:59 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C735B8
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:33:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-346434c7793so2060395ab.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690565635; x=1691170435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aklSTLsAdsXkyztpg3+XAijGiHhtrBrXRWs6NCnGTzA=;
        b=QMjtYfC7c2iyLJqTyd1kyafeb3BFunFp/e0culOjRU9ewmtqiQ4hxbF1scOqd3i0Jj
         ZGKAYORniatq226NZVw52IdIFsPXH6D4AgOL4VxvR5HQA4k1CDjlYbf0k7yQ//pxSq+N
         oYHy/AKA2e9M48Te7g19hPAlbx9bQS/hl26ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565635; x=1691170435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aklSTLsAdsXkyztpg3+XAijGiHhtrBrXRWs6NCnGTzA=;
        b=InlZf70u/ar7tByXt3Ry02NYtYcXd1hBgVUvZXP4/VgViVjU4DN/3aKXejeZrl5DZ0
         s1XtUr9U73aSrfgy08TxTnymBo5cp11plSEEh9tqEn9JqjbO0IaL/0oEi2vwo1UMKF2r
         BC++MS54Ert1+S8W+4PZbMnUTGCtCOMmIDhOWderHxK1EIx4MEp7cgZNJN5z9wjLnfzT
         C5l7oCFjB+yr7cgMIkFTMS63/rrQaBQAO/PDgf/pC/rnZHn5YPw+VfTWb8x+3XRzP2qf
         chyT+QzHq922+n2iktDbVRDRbg8ERsymNL1sxsUhntvjKRQQ6oPXxM9ve+bLo0Xq+3KR
         HIzA==
X-Gm-Message-State: ABy/qLZtenGzTBfByj2v0aR0VBGH7MM2CdBd7vvvOoj8reOfV1gE3KTk
	7kK4vZyXZ2H/YLImOAZ5RMW4mg==
X-Google-Smtp-Source: APBJJlHQZypJRFj1SLtdNhEL/1iWRYCO08vs34N2nXnEbCuZzoUuWCVeMAHuS1Q2trNIRQjqmMRnjQ==
X-Received: by 2002:a92:d38d:0:b0:348:ec3f:fce1 with SMTP id o13-20020a92d38d000000b00348ec3ffce1mr247599ilo.0.1690565635234;
        Fri, 28 Jul 2023 10:33:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p11-20020a92da4b000000b00345d00dc3fdsm1322646ilq.78.2023.07.28.10.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:33:54 -0700 (PDT)
Message-ID: <e6d7a9ab-ca03-57dc-b023-fa2cbf35fd65@linuxfoundation.org>
Date: Fri, 28 Jul 2023 11:33:54 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Content-Language: en-US
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
 Netdev <netdev@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
 Shuah Khan <shuah@kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Liam Howlett <liam.howlett@oracle.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
 <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
 <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
 <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/27/23 19:38, Anjali Kulkarni wrote:
> 
> 
>> On Jul 27, 2023, at 5:43 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/27/23 11:34, Anjali Kulkarni wrote:
>>>> On Jul 25, 2023, at 9:48 AM, Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>>> On Jul 25, 2023, at 6:05 AM, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>>
>>>>> selftests: connector: proc_filter build failed with clang-16 due to below
>>>>> warnings / errors on Linux next-20230725.
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>
>>>>> clang --target=aarch64-linux-gnu -fintegrated-as
>>>>> -Werror=unknown-warning-option -Werror=ignored-optimization-argument
>>>>> -Werror=option-ignored -Werror=unused-command-line-argument
>>>>> --target=aarch64-linux-gnu -fintegrated-as -Wall proc_filter.c -o
>>>>> /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/connector/proc_filter
>>>>> proc_filter.c:42:12: error: invalid application of 'sizeof' to an
>>>>> incomplete type 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^~~~~~~~~~~~~~~
>>>>> proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^ ~~~~~~~~~~~~~~~~~~~
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:48:20: error: invalid application of 'sizeof' to an
>>>>> incomplete type 'struct proc_input'
>>>>> hdr->nlmsg_len = NL_MESSAGE_SIZE;
>>>>> ^~~~~~~~~~~~~~~
>>>>> proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^ ~~~~~~~~~~~~~~~~~~~
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:64:14: error: invalid application of 'sizeof' to an
>>>>> incomplete type 'struct proc_input'
>>>>> msg->len = sizeof(struct proc_input);
>>>>> ^ ~~~~~~~~~~~~~~~~~~~
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:65:35: error: incomplete definition of type 'struct proc_input'
>>>>> ((struct proc_input *)msg->data)->mcast_op =
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:66:31: error: incomplete definition of type 'struct proc_input'
>>>>> ((struct proc_input *)pinp)->mcast_op;
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:67:35: error: incomplete definition of type 'struct proc_input'
>>>>> ((struct proc_input *)msg->data)->event_type =
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:68:31: error: incomplete definition of type 'struct proc_input'
>>>>> ((struct proc_input *)pinp)->event_type;
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>>>> char buff[NL_MESSAGE_SIZE];
>>>>> ^
>>>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>>>> sizeof(struct proc_input))
>>>>> ^
>>>>> proc_filter.c:245:20: error: variable has incomplete type 'struct proc_input'
>>>>> struct proc_input input;
>>>>> ^
>>>>> proc_filter.c:245:9: note: forward declaration of 'struct proc_input'
>>>>> struct proc_input input;
>>>>> ^
>>>>> proc_filter.c:264:22: error: use of undeclared identifier
>>>>> 'PROC_EVENT_NONZERO_EXIT'
>>>>> input.event_type = PROC_EVENT_NONZERO_EXIT;
>>>>> ^
>>>>> 9 errors generated.
>>>>> make[4]: Leaving directory '/builds/linux/tools/testing/selftests/connector’
>>>>>
>>>>>
>>>> These are expected since you need to have the changes in kernel that were committed with this patch to be installed on the kernel on which this is being compiled/run on. That is what the test is for, and the check to make it run on previous kernels as well was made a runtime check. Do you expect this to compile on a kernel without the corresponding kernel changes that were committed with this patch?
>>>>
>>>> Anjali
>>> Gentle ping - could you answer above questions?
>>>>
>>
>> I am seeing the same on linux-next next-20230727
>>
>> PROC_EVENT_NONZERO_EXIT is defined and NL_MESSAGE_SIZE
>>
>> Anjali,
>>
>> What are the dependent commits and should they be in next?
>> Shouldn't this test patch go with the kernel patches it depends
>> on? Can you do some testing on next and let me know why this
>> test is failing to build?
> 
> All the commits went in together - however, the kernel changes that went in this patch need to be *installed on kernel on which this is being built*. Did you do that and then try?
> 

Building kernel and running "make headers" before building the test
is what is needed. That is what Naresh and I did.

How are you building this test?

I sent a 3 patch series with the fix to this problem and a couple of
others I found during testing.

Also please check the error messages - some of them are cryptic and
could use clarity.

Another thing is argument check - arg == 2 - does this test require
arguments? Note that without arguments the test runs - of that is
default it is fine. This test could use an usage information. Please
fix the above.

thanks,
-- Shuah




