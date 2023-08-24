Return-Path: <netdev+bounces-30316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94B786DCF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574D51C20E31
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB4DF58;
	Thu, 24 Aug 2023 11:28:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7424550
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:28:09 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331FE59
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:28:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so897131866b.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876486; x=1693481286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEAjupxxZJVfCg2YeNJwkekWjycTxqIuUH2gwvfYDd4=;
        b=VtxZILY+TYyfGuj0AKpgOtHQ5v+fbeBRsGHhfzyvG1LbZ42jvPutfRRarCBQo/DV7p
         PGkRrcgmbwfD8HJNhNJuhVSw29Wi+/Ouv3kdMAZ0GBtarh6BEahaF1GqG6nBUGPVKPUe
         knXs/+tUM8zI+CThIaZi7KFuJja+Lvop9+DP7YqigvIxJpIKrnAK1MKaaDGHJPqgu+HG
         tLwG+X/2ZUVRS/VSr7hxEi+dHb91WNuKjeh7WKVYMxJAt2EZfnzKmbqcICrQyys28k1I
         UtvkL4Cookt6GxEZVxD75oDe0qu3Rm0j4Zp3pSJdbLvtduxPLODOtBwmochW1Y+WWJpu
         k3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876486; x=1693481286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEAjupxxZJVfCg2YeNJwkekWjycTxqIuUH2gwvfYDd4=;
        b=AUiwZJ6h5O5S0dg7ftKHeb8Gysbi4eRwKu/4GBVZa0Rf3/pqGDmSBVZOZ4U4aOpBSi
         x8uk7jvQZ3qTag6THdVLlSQktKUdH9d7L18EZjdrU1wzFqNBKbqcNkvj4IuEao6oUPJa
         dsuEB/cPNf797EkdFfTLfOZPe3ijVtXGBCvEip9lm8JIUwzFd2Z5MNHgjiix/pv5XdOc
         VwMJsCOCZCU7NxIxcf79nQFQGYoLV8J9dIDR5bQa3mnhyDMryKDTNwlc0UPpYVsYbQFD
         E1HwNGTqT62L4UZNNi0vh5NmOd8oFBw2DEFnipL8LZzeOpisI+Hx32m/U0d3DF44zafX
         tsZQ==
X-Gm-Message-State: AOJu0YyZ23Xm12A8OQASN1Daq3SbXdUgHiaeJ8XZ2Ng63fvPqLLvhlPM
	TMk054a9Fz9/Zx5e9L0qLU4iS8UaR+I=
X-Google-Smtp-Source: AGHT+IEdfgan/UQXF7ejSdV7Q8URtpN+CTnLoq7WZTvKbvkceF2X3Fpz4LFCCjA3WWl1tLE/I0yGsg==
X-Received: by 2002:a17:906:8448:b0:9a2:23cd:f05a with SMTP id e8-20020a170906844800b009a223cdf05amr649713ejy.76.1692876485582;
        Thu, 24 Aug 2023 04:28:05 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.140.69])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b009a19701e7b5sm6367771ejb.96.2023.08.24.04.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:28:05 -0700 (PDT)
Message-ID: <366b2e82-8723-7757-1864-c9fef32dc8f8@gmail.com>
Date: Thu, 24 Aug 2023 12:25:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPv6 TCP seems broken on 32bit x86 (bisected)
Content-Language: en-US
To: Klara Modin <klarasmodin@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, simon.horman@corigine.com
References: <CABq1_viq9yMo9wZ2XkLg_45FaOcwL93qVhqFUZ9wTygKagnszg@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CABq1_viq9yMo9wZ2XkLg_45FaOcwL93qVhqFUZ9wTygKagnszg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/24/23 01:00, Klara Modin wrote:
> Hi,
> 
> I recently noticed that IPv6 stopped working properly on my 32 bit x86
> machines with recent kernels. Bisecting leads to
> "fe79bd65c819cc520aa66de65caae8e4cea29c5a net/tcp: refactor
> tcp_inet6_sk()". Reverting this commit on top of
> a5e505a99ca748583dbe558b691be1b26f05d678 fixes the issue.
> 64 bit x86 seems unaffected.

It should be same to what was discussed here

https://lore.kernel.org/netdev/CANn89iLTn6vv9=PvAUccpRNNw6CKcXktixusDpqxqvo+UeLviQ@mail.gmail.com/T/#eb8dca9fc9491cc78fca691e64e601301ec036ce7

Thanks to Eric it should be fixed upstream. Let me check if
it's queued for stable kernels.


> One of the symptoms seems to be that the hop limit is sometimes set to
> zero. Attached is tcpdump output from trying to ssh into the machine
> from a different subnet.
> 
> I also tried http which seems even weirder, the source address is cut
> off or offsetted by 32 bits (results in
> "a5c:1204:84c4:847e:950e:2b3d::", should be
> "2001:678:a5c:1204:84c4:847e:950e:2b3d"). Trying to connect using
> netcat sees the same result as with http.
> 
> Tested on two machines running Gentoo, one with a locally compiled
> kernel and the other compiled from a x86_64 host, both using gcc 13.2.
> If I remember correctly I was using gcc 12.3.1 on the first machine
> when I initially noticed the issue but didn't troubleshoot further at
> the time.
> 
> Please tell me if there's any other information you need.
> 
> Regards,
> Klara Modin

-- 
Pavel Begunkov

