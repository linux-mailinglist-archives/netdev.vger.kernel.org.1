Return-Path: <netdev+bounces-26973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491D779B71
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323C41C20BA5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B63D3B1;
	Fri, 11 Aug 2023 23:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE4329D4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 23:38:33 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C97CE4B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:38:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-589c7801d1cso9452077b3.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691797112; x=1692401912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERO91AOJTm4dpuZZthyvSOM3LVUMg8SwwuzY9YLUk7Q=;
        b=Q2QIRhFCH8eIAYHsSOz6dLExQ4Mvo12UfvLoPAOcW/2VAYIS6F1QDtGGz1rJqfq4EK
         AafHwFhl9RNbeAmPBfwuCPBzu+XCcXtBO6EV8PLyvLlOFPVq3U/F+nQ0gVOqsqU2sHgz
         Cir2pH38XYq2NHrhV8wveWL2fYlXkbB20nizGv9Cb4pu990YK761yv8+NZxEoJ7YAxAL
         exhNK3lCK+WwhGCGHAH3eWfnEdO65KZFCLXFQ7gdTF7eZHlHfCpapPXpnEdrIQ24emZ2
         NrdGeJkfjBs1/DMgogU192oqq96MjooCsrWMtVyAXJBEREUgWGrMQmoXvl0Jm9OMxm1+
         Vgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797112; x=1692401912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERO91AOJTm4dpuZZthyvSOM3LVUMg8SwwuzY9YLUk7Q=;
        b=EsqJaB064uWQMTF1w9jOv7xSNvqrRJUnnCfN7VUESgX3ydCHVzqeXHGV85UMkj9ZNR
         AG6q33uRDgNsvbrUplPdjhYcomDiPcTOPqOO9HXNZ1ie1M50wDuzLcjjPHS+yg0xLWBd
         85xsyeOZt14dBRFNqknx04uxDvyCZY96kUiCuUGjozztWzwaHdoOITJeXuAGREZr7VF/
         7FVxyk3TPThXWB6t9aAHMSX4p9QNqL15YR/cGnWcyT1Vbb/8GD/Ue2BpVqtCnjn0u/y+
         Dozyltnfnv5+tAIrJAyIPhzlQd5NhfvKPFiE0kD6NUjryp0liruA4+d3lAdXdA9nyi8q
         pTpg==
X-Gm-Message-State: AOJu0YwHZ1CURxC16Ck6CYFdRXQzBIZ5v9Y2IwIGbXsZ/n2IRSPaTkzQ
	tP/wIV31noA6ulUObbl+9HkpG6EXx6k=
X-Google-Smtp-Source: AGHT+IE4u081GnfguJRrPx6DGgUksyfSOzWauCvli8CI528IPxEStuEhIkUfG9zbuvY+qs4sEabk+g==
X-Received: by 2002:a25:d715:0:b0:d11:a1f6:7719 with SMTP id o21-20020a25d715000000b00d11a1f67719mr3332066ybg.35.1691797111723;
        Fri, 11 Aug 2023 16:38:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id v14-20020a25fc0e000000b00d20d4ffbbdbsm1184740ybd.0.2023.08.11.16.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:38:31 -0700 (PDT)
Message-ID: <2fc5dbf5-dcbf-35b8-6cb3-cdda83f555ff@gmail.com>
Date: Fri, 11 Aug 2023 16:38:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v6 2/2] selftests: fib_tests: Add a test case for
 IPv6 garbage collection
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
 kernel-team@meta.com, yhs@meta.com
Cc: kuifeng@meta.com
References: <20230808180309.542341-1-thinker.li@gmail.com>
 <20230808180309.542341-3-thinker.li@gmail.com>
 <94192621-53c9-7f2c-ba99-306f9eb8533c@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <94192621-53c9-7f2c-ba99-306f9eb8533c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 08:10, David Ahern wrote:
> On 8/8/23 12:03 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Add 1000 IPv6 routes with expiration time (w/ and w/o additional 5000
>> permanet routes in the background.)  Wait for a few seconds to make sure
>> they are removed correctly.
>>
>> The expected output of the test looks like the following example.
>>
>>> Fib6 garbage collection test
>>>      TEST: ipv6 route garbage collection [ OK ]
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/net/fib_tests.sh | 72 +++++++++++++++++++++++-
>>   1 file changed, 69 insertions(+), 3 deletions(-)
>>
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 
Thank you for the review.

