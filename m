Return-Path: <netdev+bounces-22556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D376801E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD617282328
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A01643C;
	Sat, 29 Jul 2023 14:43:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97413D60
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 14:43:12 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3928A8
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 07:42:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3b7fafd61so2401285b6e.2
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690641774; x=1691246574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr1QJLPecn2SjxOV8mdymmpr/NJWO8o8w84tB5GduTM=;
        b=jGz4/MLqsTcgz/M3JKvhwptKxqg/KcNBvedBPLSqO/MIS787PTA2pN0lFjq4jIixiq
         A2Lz6FpE8tdcw3ieJiYe4mV9NCbJeTv7jCn2AWBC5UvaK85/z0lK4YWjpYEFSQrUocAH
         oq7/LyLeULFWUvurttpbiNf8t11o9UPTpjmjdyYha7OK9kjl1lAEE3PrRcUrVz35lmb9
         T/SkPhTagECcLeibehikilj4LM1W69iOm9YzIdFGQuxOpbcUZ5BdSE+4ovX4WdJ1PNAp
         4LGnOPKWu5He+PF5FG1Cy2b3+ZxCZtakcEmZNUGjdvyXt/n2Qyml4Xy32qhhhB+FP7LE
         4wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690641774; x=1691246574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr1QJLPecn2SjxOV8mdymmpr/NJWO8o8w84tB5GduTM=;
        b=R/sG0yYlVDzxMhVl62ATyr8TCN6zY6plmHbCn89A2hOw+D7NQHZlrqv1zQ8PQsVBqE
         wHb5I9Aed1zxlz6iQw5t2tb2jISuKqPqB+IaqJjL0ykrbfzTT5sNkZ5zHlQdZy1gyMOG
         cANHUCVJh++oyC48Vekr2XI3yNh0PYLu/4A2BxC5kHkMAkQB8E0nOVbQ9IDYXlNXHl4t
         2juWrtzY26HiUYtjrU875uiOYxqsp8RUWElpm9dNcbkPy4TqZgcnC66LWQjSJDRbPfTT
         bzSYqkQNPkkclV41Zb1r6xZW2e/2fGZVC4WHDoP0uigDX1ePkF575vOgfT+hQnWnKMxE
         gVbw==
X-Gm-Message-State: ABy/qLaValSzlPYDzz5kOdkrYdWIpRY3ltkpz7K1Bq/nAH48GUB0jYjB
	CE5Wluz+s1+/v5uogESaFXmMcA==
X-Google-Smtp-Source: APBJJlHs45OuRFQhfuflj2u5wLuYSwsL/9zoW92lrtSytf+bZA9KnJ0GTKYc8MUfRW8zGe2so+vLXw==
X-Received: by 2002:a05:6808:140b:b0:3a4:3074:1fa9 with SMTP id w11-20020a056808140b00b003a430741fa9mr7286178oiv.34.1690641773993;
        Sat, 29 Jul 2023 07:42:53 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:437e:a800:f5ee:3cf2? ([2804:14d:5c5e:44fb:437e:a800:f5ee:3cf2])
        by smtp.gmail.com with ESMTPSA id bk37-20020a0568081a2500b003a3fd014ccasm1289715oib.9.2023.07.29.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 07:42:53 -0700 (PDT)
Message-ID: <2d5ed496-3afb-34d0-007e-31c9eac4e849@mojatatu.com>
Date: Sat, 29 Jul 2023 11:42:49 -0300
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
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230729123202.72406-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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
> 
> --
> 2.34.1

For the series,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Tested-by: Pedro Tammela <pctammela@mojatatu.com>

