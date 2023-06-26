Return-Path: <netdev+bounces-13934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF1E73E133
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40D91C208A5
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76BA938;
	Mon, 26 Jun 2023 13:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D08F6A
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:56:21 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016010E9
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:56:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa8692a006so24879245e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687787773; x=1690379773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvwNRNrF8mI3P6llYM5gd3K4KnP8OJjmIVJOWMH6Qwk=;
        b=udTCrsmRCn5UUJQwqNUZMWZGz0xksESGqOF3Q0FF4x2DROSdW0N27AXj4wxaYq7CIk
         UMKkgKy0SW7FIudsGAGzQvOIQgsKGjBAkI9KjgoMBtyldJkSU82QOO2d2X1ERca36FKz
         atL0SafhyuOcgOwf86/SmJDu9dy/NtvGrLJMUViOmiBSuL9HSzw1YpiFKZRp4BlvmJyO
         c6kxkXVG50R2xhXYHTvhUoZ9c3rMC6uFPgLMq/llDL+T7I4mt9WfM1qZy+qKHLGOtq9+
         YZnTrUOauH81tdJ536nibfiQTns/LrMVykgtuwv1aRO/iELPkvMcQ0gm5678QcXH3iq2
         Onrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787773; x=1690379773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvwNRNrF8mI3P6llYM5gd3K4KnP8OJjmIVJOWMH6Qwk=;
        b=WPIWEK0kV2hatF7HrAr97SI4kNLQQZ/V/BMxx3tEuHwbPxpd6I7DPlg8ATOqkUZUbB
         51PzmPjVuc5osVu+0XmwVTV2RvWUyMrK8ikZmL219Nzfh6/egCo8gZOTkEVCfYCFZCvU
         glg3ol5dCMKs9ImqVs0LjaRRIv473j+7dyndMufunGdQvf6DwuCXbHW3NvYHcn7y1v9r
         Avo7TmBuRmDBd3HJgJqSoF1501G+K5yLKnVRsw7ZMoEndQoLX2w4IuLgCFmwvfWVxQRN
         G2LmASw0evexN28nsZT4SDopGPLhXT60FfSu9Bk4+QYK37iymjFgxSSknr1kfmhW0OR0
         2LBg==
X-Gm-Message-State: AC+VfDyaNElQ0Ja52jjTcp6kE0bGHdoquC27Gbp1teNkbySsn6IgNmTz
	gejuUfJaT/kamjxaUC7ag2zeVA==
X-Google-Smtp-Source: ACHHUZ77dDFzSYL/4C41Q5EjhUboMu666xiajF8k2wkBMpzw4Zj+zteK2QyE8a3CbzCPcE6wR0A3uA==
X-Received: by 2002:a7b:ca55:0:b0:3fa:7515:544 with SMTP id m21-20020a7bca55000000b003fa75150544mr9208279wml.34.1687787773275;
        Mon, 26 Jun 2023 06:56:13 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f8fac0ad4bsm7735241wml.17.2023.06.26.06.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:56:12 -0700 (PDT)
Message-ID: <2cb3b411-9010-a44b-ebee-1914e7fd7b9c@tessares.net>
Date: Mon, 26 Jun 2023 15:56:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] tools: Fix MSG_SPLICE_PAGES build error in trace
 tools
Content-Language: en-GB
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5791ec06-7174-9ae5-4fe4-6969ed110165@tessares.net>
 <3065880.1687785614@warthog.procyon.org.uk>
 <3067876.1687787456@warthog.procyon.org.uk>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3067876.1687787456@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/06/2023 15:50, David Howells wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> 
>> So another issue. When checking the differences between the two files, I
>> see there are still also other modifications to import, e.g. it looks
>> like you also added MSG_INTERNAL_SENDMSG_FLAGS macro in socket.h. Do you
>> plan to fix that too?
> 
> That's just a list of other flags that we need to prevent userspace passing
> in - it's not a flag in its own right.

I agree. This file is not even used by C files, only by scripts parsing
it if I'm not mistaken.

But if there are differences with include/linux/socket.h, the warning I
mentioned will be visible when compiling Perf.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

