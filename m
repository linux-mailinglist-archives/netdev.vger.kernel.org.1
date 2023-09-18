Return-Path: <netdev+bounces-34630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C27A4E62
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61FE282C6E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619BD23743;
	Mon, 18 Sep 2023 16:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE422EF8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:13:32 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9A86A5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:13:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso583228766b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695053584; x=1695658384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoZIS2ta7djVP6b3AtOMINy7XCraTcPQgToLwnyfu7c=;
        b=g9NlPlmkDctQBcP28me/zJ4aBpsdKYSp0cy9v2i68v4eotrycacXkWHB0CJXXL9j6B
         JBo6Bi7RpEI2pz7TRz2f4LtNfXnGPln5DgiprXP6e7JlSX1hgLwBocD0ysp0BcY6MfSW
         szyyrgXq2R1oT+9IbUYIa1DmlXw+SZGdoYPv3AYWX9EHlhqZZTFW7qqZQE9bbJES5BN7
         61CSJRDJ2QT/YuKKnXh79zHCgwOnya7cD4sPnN7oy60u60ezDclA/XqsbpYaFKbY25or
         nejr5ZCD+WmMe7DfL1UuOTWYVIT2N++pA7xIY/YfaPBVcoDUVBiIhle9bg1basFMUzLl
         F8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053584; x=1695658384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoZIS2ta7djVP6b3AtOMINy7XCraTcPQgToLwnyfu7c=;
        b=i+/2UeRysFQIE/k7rVcRtDZ5wskZJuCrOz1xoCJiBv1+EEKAp6LJrGGHQQEXlJEU+G
         T6IYFR7dX3B/17xDhq8aPkLF32RDOyPU4XIv/aSbWkxdDkslYtGTdoLhwZqOdPgXoMkF
         iAOGh1aAbIoOelo6aY9N6KjSFvm0Muwf6c89JM+3NQlX328J6+GwZw5u+f5grlxsOL8F
         zJ5oWG6Ntc+/M6P6KSHrH4i0H3biDDUVF4RxqJP615gisxFZ8wFOGqtFUahs1wYnThRX
         NxT/W5ztj6oYKdMWVE4VtsgFicPaQPcf8tB6M7zJdKDiWMM/ylKdP43fK08AhoN5dVfh
         xEhg==
X-Gm-Message-State: AOJu0YzH4Lkn9R9VrUtPCyXk5grr2SnEFgch5VM35Q1w5RF/WzbGwR9N
	CZ4uuMvHgEpfh0dSvX8MRabr3Z4LcWJlEBbEdG6PCg==
X-Google-Smtp-Source: AGHT+IGg41WhdVNH1oPjWj5jfj7NnpDOOGaWoatI/mj7CKEs31tK/0n3uwOHjfuDXKvXaagSc3q8XA==
X-Received: by 2002:adf:e40d:0:b0:317:61af:d64a with SMTP id g13-20020adfe40d000000b0031761afd64amr7909033wrm.3.1695043250363;
        Mon, 18 Sep 2023 06:20:50 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0031c5b380291sm12770861wrz.110.2023.09.18.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:20:50 -0700 (PDT)
Message-ID: <fb51f3ed-a8aa-42f1-b649-eb684235323a@tessares.net>
Date: Mon, 18 Sep 2023 15:20:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/17] bpf: Prevent KASAN false positive with
 bpf_throw
Content-Language: en-GB, fr-BE
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>,
 David Vernet <void@manifault.com>, Puranjay Mohan <puranjay12@gmail.com>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230912233214.1518551-1-memxor@gmail.com>
 <20230912233214.1518551-11-memxor@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230912233214.1518551-11-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kumar,

(+ netdev in Cc as this patch is now in net-next tree as well ; same for
mptcp-next)


On 13/09/2023 01:32, Kumar Kartikeya Dwivedi wrote:
> The KASAN stack instrumentation when CONFIG_KASAN_STACK is true poisons
> the stack of a function when it is entered and unpoisons it when
> leaving. However, in the case of bpf_throw, we will never return as we
> switch our stack frame to the BPF exception callback. Later, this
> discrepancy will lead to confusing KASAN splats when kernel resumes
> execution on return from the BPF program.
> 
> Fix this by unpoisoning everything below the stack pointer of the BPF
> program, which should cover the range that would not be unpoisoned. An
> example splat is below:

Thank you for your patch!

(...)

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 78e8f4de6750..2c8e1ee97b71 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -22,6 +22,7 @@
>  #include <linux/security.h>
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
> +#include <linux/kasan.h>
>  
>  #include "../../lib/kstrtox.h"
>  
> @@ -2483,6 +2484,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  		WARN_ON_ONCE(!ctx.aux->exception_boundary);
>  	WARN_ON_ONCE(!ctx.bp);
>  	WARN_ON_ONCE(!ctx.cnt);
> +	/* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
> +	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
> +	 * which skips compiler generated instrumentation to do the same.
> +	 */
> +	kasan_unpoison_task_stack_below((void *)ctx.sp);

Our CI validating MPTCP tree has just reported the following error when
building the kernel for a 32-bit architecture:

  kernel/bpf/helpers.c: In function 'bpf_throw':
  kernel/bpf/helpers.c:2491:41: error: cast to pointer from integer of
different size [-Werror=int-to-pointer-cast]
   2491 |         kasan_unpoison_task_stack_below((void *)ctx.sp);
        |                                         ^
  cc1: all warnings being treated as errors

Source:
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6221288400/job/16882945173


It looks like this issue has been introduced by your patch. Are you
already looking at a fix?

>  	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
>  }
>  

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

