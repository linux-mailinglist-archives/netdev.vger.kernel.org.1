Return-Path: <netdev+bounces-16577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203674DE24
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6257C1C20B76
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FE14AB4;
	Mon, 10 Jul 2023 19:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDD14AB3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 19:24:50 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177DAE3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:24:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b723aedd3dso3025306a34.3
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689017088; x=1691609088;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLaqU+6lSbLl09Z4J3m79USYYkdfACO5fwAntDD0u58=;
        b=3+4+Eb5Bp84JF1VX65XEEw/F+MMMP0EbCwnZi4cq7BfaaN/1f93pfl41HhcavYcGvl
         z3M3kK0BaInZVrMTISWY3nYU+nG1Q2RYkEs17xTttxicVLjv9gChtDTjhBB1IuQFAsXp
         ko1LJXKL4P1EAP+Pl3gb/wedEWm1z6Fqrc1cheO8GlOF3Ujp/YcWCSOFQ9t+mT15Y3Rh
         MnnfYzyvNeJZvVeOeuh/suE3cWXGvw6ctEUK+h2PLG+n7NQvIgK0Kiozxv7nMhnq61cD
         DEGvNCakiTFJaWZY/mK6kwRmoGb4n7E1o6E+V7LKDSO0afIlEVUhQZHWLIYDGp30UHL5
         9wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017088; x=1691609088;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLaqU+6lSbLl09Z4J3m79USYYkdfACO5fwAntDD0u58=;
        b=eSJwn9dOaBiVZgDgOow+YTKN9Wp/9wq+984GjU8c7HotOm+t+RJ8yIc1ktPZuWsKxI
         27A63JWmR7twYRbi2ov7e9PmGobqOpikW05zcC0Ms4CjkegHalZuKbyVdGGvEWD0Y3B7
         RVu18cTkDX+HK1DztsqeBYJyrVoMXTFS7PFIcfqxxgdHuF8pu4l0/JvMIjmh7qqwU2E3
         DXnkO3mBOeUwEcFIiPySlzM9mfkWODDa35Oe5uHsHDkc5p4+MH+w7N5UUCS0PwkDMZUm
         0kvrgP0UOXdLcY6wC5Y9QkY/x23MIFk1OE0Mx7LBY7E2brxUF0WOtTBzubFQnDb5TcX0
         jNvQ==
X-Gm-Message-State: ABy/qLbT4fwNFcUMBAZEUTdyiyEURK+WsdhB1evxjSTmahVR34PN2m5j
	NZJTWh9LgKrhUSwIfQv5A2bZ8dJxuU+YTjKTX5Q=
X-Google-Smtp-Source: APBJJlFkgcGGUOVX4UhgM71GWx2FfZqagbqAJjriZqKmq9SPNZJSav2aZyz+/4ajHqHwQ3TfwSx32g==
X-Received: by 2002:a05:6870:d1c4:b0:1b4:624a:e35 with SMTP id b4-20020a056870d1c400b001b4624a0e35mr6398597oac.11.1689017088271;
        Mon, 10 Jul 2023 12:24:48 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5? ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id e26-20020a9d63da000000b006b46b913767sm278731otl.24.2023.07.10.12.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 12:24:47 -0700 (PDT)
Message-ID: <6777febd-8f94-6f67-7eb3-7919c6125741@mojatatu.com>
Date: Mon, 10 Jul 2023 16:24:44 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v3 0/2] net: sched: Undo tcf_bind_filter in case of
 errors in set callbacks
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, pctammela@mojatatu.com, simon.horman@corigine.com,
 kernel@mojatatu.com
References: <20230709161350.347064-1-victor@mojatatu.com>
In-Reply-To: <20230709161350.347064-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please ignore this patchset, I'll send a V4 soon with the approach we
discussed at the monthly tc meetup

cheers,
Victor


On 09/07/2023 13:13, Victor Nogueira wrote:
> BPF and flower classifier are calling tcf_bind_filter in their set
> callbacks, but aren't undoing it by calling tcf_unbind_filter if their
> was an error after binding.
> 
> This patch set fixes this by calling tcf_unbind_filter in such cases.
> 
> v1 -> v2:
> * Remove blank line after fixes tag
> * Fix reverse xmas tree issues pointed out by Simon
> 
> v2 -> v3:
> * Inlined functions cls_bpf_set_parms and fl_set_parms to avoid adding
>    yet another parameter (and a return value at it) to them.
> * Removed similar fixes for u32 and matchall, which will be sent soon,
>    once we find a way to do the fixes without adding a return parameter
>    to their set_parms functions.
> 
> Victor Nogueira (2):
>    net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
>    net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails
> 
>   net/sched/cls_bpf.c    | 99 ++++++++++++++++++++----------------------
>   net/sched/cls_flower.c | 99 ++++++++++++++++++++----------------------
>   2 files changed, 94 insertions(+), 104 deletions(-)
> 

