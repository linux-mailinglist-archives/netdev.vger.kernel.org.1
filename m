Return-Path: <netdev+bounces-19986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C275D288
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1AF282431
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F621F94E;
	Fri, 21 Jul 2023 19:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626B200A6
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:00:37 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9A30CA
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:00:35 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b06da65bdbso1727865fac.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689966035; x=1690570835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XhtG4Y2kO5rS6l5vQHzM1NAJh8YwewgAgkX8X27UC0=;
        b=tzlgXv6yUXqTbbFJ+5klqBhXgP9TSnQMw/mLJOP/bS6QrFcG6egeuYQvvOv+xQp7gt
         SiUHqOMHx5NVdEy2Ft7uJfPR5YNYUqF7s8uP0fiJJyjHdHICXNUK3HWkU4zMQwT/mRl+
         sNLEa5rsMRiWyPZCm1UtvYW3tC2c/dgj5I/MwpN2XBWISnuVqgCu+j9ws3SAqZ+6ZFHc
         DVTGiImQnSKXcLZsToHemtwl+wXbdAmT0DvjqdxVEYyNcIf3qSckN93QCtqIDKtqcuSi
         xfuruAsCAnPNlTylGIrz8y71KLE9uzew0GUS8QzEVH3DMo9B4brYDT+DBbJVjONWE8AK
         6qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689966035; x=1690570835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XhtG4Y2kO5rS6l5vQHzM1NAJh8YwewgAgkX8X27UC0=;
        b=CR+eNLx1mAuQmtdnOO4TJd1hPvO2EpJCW33GO0rM3CbNEPSEC0eMaYvzARku0UhivN
         DS1g1ZLcckhqnlQgE6Y2Qt3SOuLOldEuWRmQnJE2QOdS70Q8B8qnCiif8JXf/1aypm05
         gQNhlfngst3Ac9Ydv7I+QMZvoNLixIkLi3wblWjO4nhxYinReb7eDHQ13mnuz1zxr3kj
         F5tMnAVzGamF1IBygxv9xbE4cUwrnsyoG3oDcd2uzwxY+fBo6a9csLp/8KkuqDJibz6e
         dcbAopetjvziFCwicB+QBrSfVpXmE6hw13aK6EiJ3GdUusqVtx8S6nkizbT4b62INaJq
         w+2Q==
X-Gm-Message-State: ABy/qLYRIr3npH84vWEdfxDrx/sgy8HxC+H8EvPuLw+fGNsmmZfmpX4u
	67UIMor0vOSA0m3yzaBUnEqTVw==
X-Google-Smtp-Source: APBJJlGF6JWo1AM6OZ+da9GwPrs4JI9ZBKp/vW80pvPdfv2aMdr2Xhpx7nNfvYGNSCVQcoKisPVffQ==
X-Received: by 2002:a05:6870:c884:b0:1ba:6180:ff47 with SMTP id er4-20020a056870c88400b001ba6180ff47mr3137797oab.21.1689966035105;
        Fri, 21 Jul 2023 12:00:35 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:2414:7bdd:b686:c769? ([2804:14d:5c5e:44fb:2414:7bdd:b686:c769])
        by smtp.gmail.com with ESMTPSA id u47-20020a4a8c32000000b00569c7121bf5sm263990ooj.4.2023.07.21.12.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:00:34 -0700 (PDT)
Message-ID: <9a51c82f-6884-4853-8e8a-3796c9051ca8@mojatatu.com>
Date: Fri, 21 Jul 2023 16:00:29 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net 0/3] net/sched Bind logic fixes for cls_fw, cls_u32
 and cls_route
Content-Language: en-US
To: valis <sec@valis.email>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, victor@mojatatu.com, ramdhan@starlabs.sg,
 billy@starlabs.sg
References: <20230721174856.3045-1-sec@valis.email>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230721174856.3045-1-sec@valis.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/07/2023 14:48, valis wrote:
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

For the series,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Tested-by: Pedro Tammela <pctammela@mojatatu.com>

