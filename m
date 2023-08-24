Return-Path: <netdev+bounces-30331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0D786EBC
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667B328154C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31070FC14;
	Thu, 24 Aug 2023 12:09:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252ED24550
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 12:09:52 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D181BDD
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 05:09:39 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-44ac60aa8f7so2799898137.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692878979; x=1693483779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNnESqHY3zdmajCScO++ruRgHXEsu4da9yUlq5oo6Wk=;
        b=YIoSUsi2BIXyOTTUW1P/TGyViuALhj6lz641M7Ac2A7QEgtloG0AmNpGaaY8LDbsKI
         j372LjOlEkV2JWJxo4VpBtcB2L8WyAaHatnf/rEtM3MhOiO/D5jmcbkgD1urAe/bccjA
         k0Mhs9i6pu84gjIvP2QpGNJ1KS3Uv6xmde6VpUh7IXPo913dytN1lM9hd2NWUn5Aoms8
         ol6LrBXzi5wB4VqeM73+xFXkh1erl7ihJJ6AhzlsExKGBgnIMnYdzBqHc6R4Z3m3yOwS
         uCtLu0KIqH8ieDnua7yw+aoMTwlk7W3STZfzqHkVRSPEo/gzwsm+AqUNChpQXGwOPWSO
         JQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692878979; x=1693483779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNnESqHY3zdmajCScO++ruRgHXEsu4da9yUlq5oo6Wk=;
        b=YyGNhVKk5OhwvWiJvgPxFlBC2xBCdGl+6y6+TvlgyFA5Dr2oRBt0e8Cr+3rj7NgjaC
         /sOqIp1Y1oHS/wLl8VstPit2ptYEbrQV/gEXlvn9yrtxwPj0IBNI/KxPYbkokaVfZBuS
         yu3OZNwWXzntrdW5mGX6loYC7kXcACeu8K8brRj0yObxaYtG5CJ7hQBILui2QfHuWgiW
         J9XF/ojq6rbhbr4ujJRgBzxcW1BlUUpGeRRXerovwbYFeuFrSY9KFWfp21Mqw/wVS877
         KW9shZv6z07NprlqiRqOLnw0/NFj3KZOv/+5UA8sSMVyF00qbI0mArZbQzsbsH/HiIex
         LuXw==
X-Gm-Message-State: AOJu0YwxkpV1lZSdpsIxo8MpXzPhmYRhdiRCKvUJSQ4ipIvYYCOvv+AY
	u1hAX1eu86JJc1HulWh1eMdEx9hc9wYzw8wPTf+eWmeBD0encQ==
X-Google-Smtp-Source: AGHT+IF4hm4Mt4e40UFh0QZdoQf31Oebupsts1nQ7Q2XwV813l/GLKDWx+E0SWuw1Wl//qqXzx7PSjzCO9V35oS2kcA=
X-Received: by 2002:a67:de12:0:b0:44d:55a4:2279 with SMTP id
 q18-20020a67de12000000b0044d55a42279mr9569305vsk.6.1692878978710; Thu, 24 Aug
 2023 05:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABq1_viq9yMo9wZ2XkLg_45FaOcwL93qVhqFUZ9wTygKagnszg@mail.gmail.com>
 <366b2e82-8723-7757-1864-c9fef32dc8f8@gmail.com>
In-Reply-To: <366b2e82-8723-7757-1864-c9fef32dc8f8@gmail.com>
From: Klara Modin <klarasmodin@gmail.com>
Date: Thu, 24 Aug 2023 14:09:27 +0200
Message-ID: <CABq1_vgE_nzcGPUf0r76xrNchcKUXSHfHCZs4EsXedXCTu-nNg@mail.gmail.com>
Subject: Re: IPv6 TCP seems broken on 32bit x86 (bisected)
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	simon.horman@corigine.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Den tors 24 aug. 2023 kl 13:28 skrev Pavel Begunkov <asml.silence@gmail.com>:
>
> On 8/24/23 01:00, Klara Modin wrote:
> > Hi,
> >
> > I recently noticed that IPv6 stopped working properly on my 32 bit x86
> > machines with recent kernels. Bisecting leads to
> > "fe79bd65c819cc520aa66de65caae8e4cea29c5a net/tcp: refactor
> > tcp_inet6_sk()". Reverting this commit on top of
> > a5e505a99ca748583dbe558b691be1b26f05d678 fixes the issue.
> > 64 bit x86 seems unaffected.
>
> It should be same to what was discussed here
>
> https://lore.kernel.org/netdev/CANn89iLTn6vv9=PvAUccpRNNw6CKcXktixusDpqxqvo+UeLviQ@mail.gmail.com/T/#eb8dca9fc9491cc78fca691e64e601301ec036ce7
>
> Thanks to Eric it should be fixed upstream. Let me check if
> it's queued for stable kernels.

That does solve the issue, thanks!

>
>
> > One of the symptoms seems to be that the hop limit is sometimes set to
> > zero. Attached is tcpdump output from trying to ssh into the machine
> > from a different subnet.
> >
> > I also tried http which seems even weirder, the source address is cut
> > off or offsetted by 32 bits (results in
> > "a5c:1204:84c4:847e:950e:2b3d::", should be
> > "2001:678:a5c:1204:84c4:847e:950e:2b3d"). Trying to connect using
> > netcat sees the same result as with http.
> >
> > Tested on two machines running Gentoo, one with a locally compiled
> > kernel and the other compiled from a x86_64 host, both using gcc 13.2.
> > If I remember correctly I was using gcc 12.3.1 on the first machine
> > when I initially noticed the issue but didn't troubleshoot further at
> > the time.
> >
> > Please tell me if there's any other information you need.
> >
> > Regards,
> > Klara Modin
>
> --
> Pavel Begunkov

