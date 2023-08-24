Return-Path: <netdev+bounces-30259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FE7869E1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867111C20E00
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18081AD4C;
	Thu, 24 Aug 2023 08:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97A5699
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:21:20 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462E10FE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:21:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1f6f3884so842516466b.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692865278; x=1693470078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNET76Ud4BrnHISLCcfZfW0L376WLs2AdNAt4B/d3mM=;
        b=RcF3GhYjzqbRgy6dbRkfBeQPETRLI/Ea0BTfqkorM/kW3bmr5PercSjFXs9pM8K6LG
         sjj2ouXiKhtOMlvrEDLPASJ367BqYqyF76a+IlCYA+920bLLBBAzacIutz5g84Lt4jsL
         iSI9oePLUDe5WqpkUAZF2oiwwsMauofDVF6Yb0yvX6A8fnwwEbeZCmUSpGcKWmIYvg4V
         KUO/QeGWBYfIqqF6ZhBVKfGUA+11Wxt+SsC0BCfI4oqQf67VlfTUIskhI7gskUpRKhsB
         +mSIINZz6qL83GoSnZXkpqIplVietYdq7YQ4qCYXNZaHs6nPjQh/2SCnZI4V2FQBuq4c
         q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865278; x=1693470078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNET76Ud4BrnHISLCcfZfW0L376WLs2AdNAt4B/d3mM=;
        b=M79qIy3oeaIzZroprcGkLN6lRvosjLvzjwdYZGCmGemjbteobcrcSXiX+jlAgE1pHt
         oNrc7sy47dy4H7z4IPM+6whqv2awtDBcM5Pi1lGqxnA9HaHBHSyVBtYCuqIZgIutX+bF
         jbanU1dkmHASn3kCGT7mBYzpRh82C1Fa2lJWd33LOBl2Nt94UID+Kgm464OTdOkagOwD
         JbuP4T+u2ORXl2XELl0W/B+2TOxxQeBl7Ly4YfFbtq6uudPcT7P3JYjNoozWuOC/MoK7
         fPpmhIJO7+CEj/t0RdF0bR5qXRr/JQMEwUsRsxQSqOKF9y89HjBpknUHBBvXrCC06aQ9
         Z62A==
X-Gm-Message-State: AOJu0Yz0Rr7atm2prcyAm1oKmU4J9nj/gnb0pyaDpkzbNETRPRSCxoo1
	FOQ1P3kUKKjWK+a4au53APc=
X-Google-Smtp-Source: AGHT+IHKswW46T/wrp1CyGPQAJMPOpKtNmxL3yj8IYCC29RQeJH3X7KqOreV44bet93T4iBxPj3RyA==
X-Received: by 2002:a17:906:5392:b0:9a1:debe:6b9b with SMTP id g18-20020a170906539200b009a1debe6b9bmr3198856ejo.35.1692865277964;
        Thu, 24 Aug 2023 01:21:17 -0700 (PDT)
Received: from ?IPV6:2a02:3100:95e4:6600:5091:3e0c:bdec:d10a? (dynamic-2a02-3100-95e4-6600-5091-3e0c-bdec-d10a.310.pool.telefonica.de. [2a02:3100:95e4:6600:5091:3e0c:bdec:d10a])
        by smtp.googlemail.com with ESMTPSA id p20-20020a170906499400b0099bcdfff7cbsm10595825eju.160.2023.08.24.01.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:21:17 -0700 (PDT)
Message-ID: <22ef754e-1d6c-652e-c626-edc571530a3b@gmail.com>
Date: Thu, 24 Aug 2023 10:21:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: r8169 link up but no traffic, and watchdog error
To: =?UTF-8?Q?Martin_Kj=c3=a6r_J=c3=b8rgensen?= <me@lagy.org>
Cc: nic_swsd@realtek.com, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87fs489agk.fsf@lagy.org> <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
 <87bkew98ai.fsf@lagy.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <87bkew98ai.fsf@lagy.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24.08.2023 10:01, Martin Kjær Jørgensen wrote:
> 
> On Thu, Aug 24 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 18.08.2023 13:49, Martin Kjær Jørgensen wrote:
>>>
>>> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>>>
>>>> There were some fix in r8169 for power management changes recently.
>>>> Could you try the latest stable kernel? 6.4.9 ?
>>>>
>>>
>>> I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 SMP
>>> PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
>>> difference. I can trigger the same issue again, and get similar kernel error
>>> as before:
>>>
> 
> 
>> From the line above it's not clear which kernel version is used. Best test with a
>> self-compiled mainline kernel.
>>
> 
> It should be based on 6.4.11 , but I can try with a self-compiled version too.
> 
>>
>> Please test also with the different ASPM L1 states disabled, you can use the sysfs
>> attributes under /sys/class/net/enp3s0/device/link/ for this.
>>
> 
> I will try that.
> 
> 
>> Best bisect between last known good kernel and latest 6.4 version.
>>
> 
> I do not know of any working version. My machine/system have had this behavior
> ever since I've got it. At least for 9 months ...

You could compile and test the LTS versions 6.1 and 5.15.

