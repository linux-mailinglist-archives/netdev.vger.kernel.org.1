Return-Path: <netdev+bounces-22098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B377660DC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90F4282529
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4C15C1;
	Fri, 28 Jul 2023 00:44:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633037C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:44:02 +0000 (UTC)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65E35AD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:43:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-348de7bc865so963245ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690505032; x=1691109832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/aJ9ksmeVttXwGKwUVAJi8p79DGJB0zVa/mu7nUe/g=;
        b=arbI1nple3pEZAfWdlLMRZfRSr+OZ67LXd6z/b2gt4LbN37fvQgaP9XQwqxKJBSgE3
         hzhmxZkSnXVRLJHfKccq3tDsK03dmoanQxj8VlhBZneW6edBniqML4RUffXiwCxOQCWv
         HYKAv3b9AUgVD9Gh7ex2kWFPd43Y6a+PRp6AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690505032; x=1691109832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/aJ9ksmeVttXwGKwUVAJi8p79DGJB0zVa/mu7nUe/g=;
        b=YNRr8U8VRYJjqOEfLsxYR+kyaOJh98mhXb+VfZZy3w2F7ebCt0P9MKUGkn76YE/vzv
         yHjs2gJPlQItlGood9G/Kh8X2MpGXlCBVtkVPzWcrw0mALKDvkSqdUxyDjIVjc6meXdX
         txEad41bfwL+oYYkN1HOVnqycrQjR8mCG32RenLkmZ67yjcXcSCkR+GvOHQNexqGpVIs
         vqA9JgFwnEFAQfY0huy3Nezf/PupcdBGNdOb4BC0wpZWyfVLL3ErubmCb6YbXv9b5OxA
         akPSqOy7u1/nTR370SVLACJv9u0iNXEmAoJynhXTg3p+wEOy88VrwWCjyGKvcoeERBKM
         dCSA==
X-Gm-Message-State: ABy/qLaILSGLxa0xRDr1e6q0D8ePQnRin8bm2XQ0pGWrcng4niNm4EvO
	obVrlybTEwxD3Lr/XmDLqr2vBA==
X-Google-Smtp-Source: APBJJlHMMHqQCxm2X2zkZFYxUgIYIuXPx75dCbAYes3sMd2B8DNQk7mPNm5UaVFKmII9KL1Dl1Wq6w==
X-Received: by 2002:a05:6602:1694:b0:780:cb36:6f24 with SMTP id s20-20020a056602169400b00780cb366f24mr1268855iow.2.1690505032517;
        Thu, 27 Jul 2023 17:43:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g22-20020a056602249600b0077e3acd5ea1sm762425ioe.53.2023.07.27.17.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 17:43:52 -0700 (PDT)
Message-ID: <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
Date: Thu, 27 Jul 2023 18:43:51 -0600
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
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/27/23 11:34, Anjali Kulkarni wrote:
> 
> 
>> On Jul 25, 2023, at 9:48 AM, Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com> wrote:
>>
>>
>>
>>> On Jul 25, 2023, at 6:05 AM, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>
>>> selftests: connector: proc_filter build failed with clang-16 due to below
>>> warnings / errors on Linux next-20230725.
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> clang --target=aarch64-linux-gnu -fintegrated-as
>>> -Werror=unknown-warning-option -Werror=ignored-optimization-argument
>>> -Werror=option-ignored -Werror=unused-command-line-argument
>>> --target=aarch64-linux-gnu -fintegrated-as -Wall proc_filter.c -o
>>> /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/connector/proc_filter
>>> proc_filter.c:42:12: error: invalid application of 'sizeof' to an
>>> incomplete type 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^~~~~~~~~~~~~~~
>>> proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^ ~~~~~~~~~~~~~~~~~~~
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:48:20: error: invalid application of 'sizeof' to an
>>> incomplete type 'struct proc_input'
>>> hdr->nlmsg_len = NL_MESSAGE_SIZE;
>>> ^~~~~~~~~~~~~~~
>>> proc_filter.c:22:5: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^ ~~~~~~~~~~~~~~~~~~~
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:64:14: error: invalid application of 'sizeof' to an
>>> incomplete type 'struct proc_input'
>>> msg->len = sizeof(struct proc_input);
>>> ^ ~~~~~~~~~~~~~~~~~~~
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:65:35: error: incomplete definition of type 'struct proc_input'
>>> ((struct proc_input *)msg->data)->mcast_op =
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:66:31: error: incomplete definition of type 'struct proc_input'
>>> ((struct proc_input *)pinp)->mcast_op;
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:67:35: error: incomplete definition of type 'struct proc_input'
>>> ((struct proc_input *)msg->data)->event_type =
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:68:31: error: incomplete definition of type 'struct proc_input'
>>> ((struct proc_input *)pinp)->event_type;
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~^
>>> proc_filter.c:42:12: note: forward declaration of 'struct proc_input'
>>> char buff[NL_MESSAGE_SIZE];
>>> ^
>>> proc_filter.c:22:19: note: expanded from macro 'NL_MESSAGE_SIZE'
>>> sizeof(struct proc_input))
>>> ^
>>> proc_filter.c:245:20: error: variable has incomplete type 'struct proc_input'
>>> struct proc_input input;
>>> ^
>>> proc_filter.c:245:9: note: forward declaration of 'struct proc_input'
>>> struct proc_input input;
>>> ^
>>> proc_filter.c:264:22: error: use of undeclared identifier
>>> 'PROC_EVENT_NONZERO_EXIT'
>>> input.event_type = PROC_EVENT_NONZERO_EXIT;
>>> ^
>>> 9 errors generated.
>>> make[4]: Leaving directory '/builds/linux/tools/testing/selftests/connector’
>>>
>>>
>> These are expected since you need to have the changes in kernel that were committed with this patch to be installed on the kernel on which this is being compiled/run on. That is what the test is for, and the check to make it run on previous kernels as well was made a runtime check. Do you expect this to compile on a kernel without the corresponding kernel changes that were committed with this patch?
>>
>> Anjali
> 
> Gentle ping -  could you answer above questions?
>>

I am seeing the same on linux-next next-20230727

PROC_EVENT_NONZERO_EXIT is defined and NL_MESSAGE_SIZE

Anjali,

What are the dependent commits and should they be in next?
Shouldn't this test patch go with the kernel patches it depends
on? Can you do some testing on next and let me know why this
test is failing to build?

It is failing for me for sure.

There could be problem in the test Makefile that it isn't including
the right headers.

thanks,
-- Shuah

thanks,
-- Shuah


