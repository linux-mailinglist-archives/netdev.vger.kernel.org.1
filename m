Return-Path: <netdev+bounces-22552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECD5767F92
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C727D2823C5
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E7B168B0;
	Sat, 29 Jul 2023 13:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661E20F8
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 13:45:01 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07924217
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 06:44:33 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bb5c259b44so2231794fac.1
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690638244; x=1691243044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qyWrGa4dskqHkk/LxmFD4gnokbtU3MvvCFjcIAgkLM=;
        b=5o8iUBXl5z8lB8NylIgoeDGbRihcpFADX9T9KKgm3ioTGPVUTk9NLB6Moc/3pTqCbQ
         dd5NMGpgY+WOYfk/Q/EHMTkR/VBNS263gjseF/ksFcXFKmp2gC4kZUtBE+CqKdmFWiVN
         ZMjE1jQM8+S4wBwDEj/+NMr2UvvHkS+X9CrO5gpg4ZYMkidYyYvefLJN90z4gNw2Wgr/
         vh1LlSwJ4WA0vhH3eaZ0IpR5O/U7Y81c9FWj2i0hZvPWSsFPy+U99TmHLT6HJlGyK6WR
         22l5FO854qP/Rn9jOkexwCZXCS/SLBmxQH6a24tj7OurcNCHYyjDp843nNPS/o/CnsFO
         Q7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638244; x=1691243044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qyWrGa4dskqHkk/LxmFD4gnokbtU3MvvCFjcIAgkLM=;
        b=dEq64LK69vcOlzSQH5Pj7DbWGGrC5illThM8Dxes2QHLFJ2P14yT60FJiUIbNetshN
         3vrPtvUm9V8v1pLpl3UiyA7286ssV393w8lEy7/drrk3FClpm1FgPZMGkpOyhEiGjkoX
         8uZD/niW6WPqylnd1mM6Zx9hdHl9QOkhE76+HJrAFiNeUzIRW1vEim4tunhJyjBz3wjm
         UVDKGd371Sykh5amDEsWLatP8tJ/lVsM2i8Um5gUq3YN7fLW5GJJiwxNwd+r6Q43bfzF
         x8LPNtP1HL1fFlnwqnpRWOP2nyhpuWVricSquLkhZ6SxSMiZjPTkOeoAKhbr1fKPLoaU
         XQZQ==
X-Gm-Message-State: ABy/qLaowwWL3+oGQFt/pJNY4CsSezvDnw+vr+7l2PPFJZgpixnkBNkr
	PrSyQrLDlOSPhrPsDlxA8WiSMA==
X-Google-Smtp-Source: APBJJlFIlFtvPvFOXHmiDmR79+Ylsmpc+/ltCmS5++n/CcRia/hnmGcdW8qn7IjEFly8oluSd/FvwQ==
X-Received: by 2002:a05:6870:fb8f:b0:1b3:f1f7:999e with SMTP id kv15-20020a056870fb8f00b001b3f1f7999emr6309253oab.45.1690638244578;
        Sat, 29 Jul 2023 06:44:04 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:6d75:166e:2197:2c44:331b? ([2804:7f1:e2c1:6d75:166e:2197:2c44:331b])
        by smtp.gmail.com with ESMTPSA id q5-20020a056830018500b006b94a14b52asm2549039ota.9.2023.07.29.06.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:44:04 -0700 (PDT)
Message-ID: <193d6cdf-d6c9-f9be-c36a-b2a7551d5fb6@mojatatu.com>
Date: Sat, 29 Jul 2023 10:44:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net v2 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 sec@valis.email, ramdhan@starlabs.sg, billy@starlabs.sg
References: <20230729123202.72406-1-jhs@mojatatu.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/07/2023 09:31, Jamal Hadi Salim wrote:
> From: valis <sec@valis.email>
> 
> Three classifiers (cls_fw, cls_u32 and cls_route) always copy
> tcf_result struct into the new instance of the filter on update.
> 
> This causes a problem when updating a filter bound to a class,
> as tcf_unbind_filter() is always called on the old instance in the
> success path, decreasing filter_cnt of the still referenced class
> and allowing it to be deleted, leading to a use-after-free.
> 
> This patch set fixes this issue in all affected classifiers by no longer
> copying the tcf_result struct from the old filter.
> 
> v1 -> v2:
>     - Resubmission and SOB by Jamal
> 
> valis (3):
>    net/sched: cls_u32: No longer copy tcf_result on update to avoid
>      use-after-free
>    net/sched: cls_fw: No longer copy tcf_result on update to avoid
>      use-after-free
>    net/sched: cls_route: No longer copy tcf_result on update to avoid
>      use-after-free
> 
>   net/sched/cls_fw.c    | 1 -
>   net/sched/cls_route.c | 1 -
>   net/sched/cls_u32.c   | 1 -
>   3 files changed, 3 deletions(-)

For the series,

Reviewed-by: Victor Nogueira <victor@mojatatu.com>


