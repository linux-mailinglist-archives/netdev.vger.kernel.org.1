Return-Path: <netdev+bounces-28966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6278144A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BD61C216B1
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BA1BEF9;
	Fri, 18 Aug 2023 20:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08C1BEF6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:25:00 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1F3C3F;
	Fri, 18 Aug 2023 13:24:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so22208051fa.1;
        Fri, 18 Aug 2023 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692390296; x=1692995096;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TREPx2/TJaMZxACQ9fP6bDpOjANSKk0gWfm+5DLKSS4=;
        b=c2UDdOwmkbPEOnHmCaBkkBnk7Y9RmpMNtgyHSTqQEDnNDghYAtEs1VaV48K/FOPEsN
         Gx+7RIu7S5/rYdIZL0uR9pq5qoL6LlbdYNTX1BIiGHf7K+grm7shyDarn0cpHuApeY0P
         aj3b5jwNtmO6LzJv0cb9ix8Jgx1UAJn1j6XIaOoNdMugmsWH+2DgVj+x2etdh8SZnpv3
         ovQeRvYO5Jyh7MAi31hWUAwZx6zGzfKm5tLOOum8zThniilTcZqZFtSN7VyQL+DePZel
         aDovwbw74ykF0crw6X2eVXYuS5MZCqeNGs5JETCyAO72PK4R9hU8ZmDMphsKbQ6pzk8w
         tmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390296; x=1692995096;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TREPx2/TJaMZxACQ9fP6bDpOjANSKk0gWfm+5DLKSS4=;
        b=eYKluyqhHdptuNIyuV0lshDJF77tRvhbwwMZmFrdOcqUAkOeOLFD3VhBzWjMvEWiA+
         2Dh4DqPbQPdkhzZseS3wGxjmFEa2LKZ6rByJi+7pPfxghw3riehOner2Ppi0XfXiTr+u
         rDOLA+UE2rQ0EJMOnU76MkWWK/rzmHmQ2MFn2jBZLUGkKQYmfkTcFiB1M/pOn8tBPzqI
         AZtfaApNpZlPofjpup3B9CIuug/V7h50xGF2HaG2mRz07ymDuiH1gUsjDiUyRWdEQnH8
         duu6SM9A+6wlcNJQuprE1MDZq9ENB3vQvu+UpXIBlTQpvGi8V0TadCJn3uPzT6MYsk8n
         AMyw==
X-Gm-Message-State: AOJu0YzW6wlMB87NRT5a5FT5f+T5gX0tuv5kBpy/7Eof+vPRI0MgTJeG
	YyNMiJuKlrzkJciJdEZwKDY=
X-Google-Smtp-Source: AGHT+IEX9bTLO9f9YkAXDWWZa4KwDsZNy6X5IdDV2FmHrF5JwaYOCPlE4yDsy1WqAdB010UahTyhcA==
X-Received: by 2002:a2e:8007:0:b0:2b9:d28c:9c1c with SMTP id j7-20020a2e8007000000b002b9d28c9c1cmr210818ljg.26.1692390295899;
        Fri, 18 Aug 2023 13:24:55 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id m11-20020a2e97cb000000b002b9f642fbe6sm624894ljj.111.2023.08.18.13.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:24:55 -0700 (PDT)
Message-ID: <2a6f6a2e-532b-4c25-ba5b-86bb0022e58b@gmail.com>
Date: Fri, 18 Aug 2023 22:24:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-clk@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
 <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
 <CAMuHMdXPB+nSHUTPufiaRP0cxvk2_raEHavwTouaiWibdQtCTg@mail.gmail.com>
 <14effeaf-f22c-461b-b1d3-4396f50ad4e6@gmail.com>
In-Reply-To: <14effeaf-f22c-461b-b1d3-4396f50ad4e6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.08.2023 22:23, Rafał Miłecki wrote:
> On 14.08.2023 11:04, Geert Uytterhoeven wrote:
>> Hi Rafal,
>>
>> On Mon, Aug 7, 2023 at 1:11 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>>> On 4.08.2023 13:07, Rafał Miłecki wrote:
>>>> I triple checked that. Dropping a single unused function breaks kernel /
>>>> device stability on BCM53573!
>>>>
>>>> AFAIK the only thing below diff actually affects is location of symbols
>>>> (I actually verified that by comparing System.map before and after -
>>>> over 22'000 of relocated symbols).
>>>>
>>>> Can some unfortunate location of symbols cause those hangs/lockups?
>>>
>>> I performed another experiment. First I dropped mtd_check_of_node() to
>>> bring kernel back to the stable state.
>>>
>>> Then I started adding useless code to the mtdchar_unlocked_ioctl(). I
>>> ended up adding just enough to make sure all post-mtd symbols in
>>> System.map got the same offset as in case of backporting
>>> mtd_check_of_node().
>>>
>>> I started experiencing lockups/hangs again.
>>>
>>> I repeated the same test with adding dumb code to the brcm_nvram_probe()
>>> and verifying symbols offsets following brcm_nvram_probe one.
>>>
>>> I believe this confirms that this problem is about offset or alignment
>>> of some specific symbol(s). The remaining question is what symbols and
>>> how to fix or workaround that.
>>
>> I had similar experiences on other ARM platforms many years ago:
>> bisection lead to something completely bogus, and it turned out
>> adding a single line of innocent code made the system lock-up or crash
>> unexpectedly.  It was definitely related to alignment, as adding the
>> right extra amount of innocent code would fix the problem. Until some
>> later change changing alignment again...
>> I never found the real cause, but the problems went away over time.
>> I am not sure I did enable all required errata config options, so I
>> may have missed some...
> 
> I already experiented some weird performance variations on Broadcom's
> Northstar platform that was related to symbols layout & cache hit/miss
> ratio. For that reason I use -falign-functions=32 for that whole
> OpenWrt's "bcm53xx" target (it covers Northstar and BCM53573). So
> this aspect should be ruled out already in my case.

Relevant OpenWrt commit with some description and links: b54ef39e0b91 ("bcm53xx: use -falign-functions=32 for kernel compilation"):

https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=b54ef39e0b910a4b8eaca0497fe9b63e8392262a

