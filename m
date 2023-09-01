Return-Path: <netdev+bounces-31738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC178FDBA
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4621C20CC0
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609EBA57;
	Fri,  1 Sep 2023 12:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51AA94B
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 12:49:26 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA61725;
	Fri,  1 Sep 2023 05:48:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-986d8332f50so237004866b.0;
        Fri, 01 Sep 2023 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693572521; x=1694177321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5bzuukzep2EFlINwyV0mtHmBBzRYX9Wyigjzt2ikDQ=;
        b=Og7EXI98AjYOQKEZoRdO9VRQQDvoNfC5SirPPUh54UcOH8yH+8lLUmBaE7NnxOpw5L
         jo2n6/gt2oLHHOc1pmrHbjtBwcoYth2JmmAAIcl+0pkYiiq4kB5qvngdDBU4b5AsRc3g
         ZLa1PWk+afX7FwgO9q3F51i+E0RGEWxRFI9IVf/PjY55iSg07LwNNJDnA0eVb/q7aMyU
         yO/ejMvl0Zo2LS85b9uWTZork6tEBRlTrr2rDMOZWcA+uILDjP0DeQhxcNb5p6lrNNPF
         gN5nn1le2Ri48xcKVH4ncnWaN0ThorRaaUcyPdfqDAWASjvKbdcUWwOu5oCIaGBdY0RZ
         4sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572521; x=1694177321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5bzuukzep2EFlINwyV0mtHmBBzRYX9Wyigjzt2ikDQ=;
        b=YebR9dwLa+ogXJ6M//cHm/kZ3EuzqKx1l/xdiKYWWmVolsVFhzB119Kel6DJzR+1O7
         HpOHmtM+E8JQRnZszxpAaIL3QcmRXzO0DFWTOIuPImiA2kQzXh7Wa0cmYse+EoN08IPN
         2IOF3853g5JhiF3PpM3qNUfEPm0QcYbtxzyi5jgwhVbUJLebURff38kdSNcaMb2o8jym
         7QuAt1CEoQowIlzqGk7SHbQFdk209cMIIsM0VS9SIyeey3HtvvYjOSYpNSolOYRPd4Aa
         xHM1d6mVJ5c1vN/pJKCCZ+njSPzQw1SQqHHR+yTmHaQCdMPxcwk94xs6Qu84CfeEBCWE
         APLg==
X-Gm-Message-State: AOJu0YzqZt+L9SWro+opgcI+jKziXixQn4YZ9Fal34l0NaARl2djqNru
	45/6PQUDcdxiFjR2Dzk6Btw=
X-Google-Smtp-Source: AGHT+IEo10S1a4arg5ZoZ04rB3wvIuz+XnFrF9t9V3kas8AIcCHUPn7c3ke/iGmqfItRD9TLNkHqtA==
X-Received: by 2002:a17:907:272a:b0:9a1:e1cf:6c6c with SMTP id d10-20020a170907272a00b009a1e1cf6c6cmr1688869ejl.30.1693572520645;
        Fri, 01 Sep 2023 05:48:40 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72e7:e700:f12a:7a78:6447:9c5c? (dynamic-2a01-0c22-72e7-e700-f12a-7a78-6447-9c5c.c22.pool.telefonica.de. [2a01:c22:72e7:e700:f12a:7a78:6447:9c5c])
        by smtp.googlemail.com with ESMTPSA id f25-20020a170906495900b0099bc038eb2bsm1921512ejt.58.2023.09.01.05.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:48:40 -0700 (PDT)
Message-ID: <5caf123b-f626-fb68-476a-5b5cf9a7f31d@gmail.com>
Date: Fri, 1 Sep 2023 14:48:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
Content-Language: en-US
To: Patrick Thompson <ptf@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 nic_swsd@realtek.com, Chun-Hao Lin <hau@realtek.com>
References: <20230606140041.3244713-1-ptf@google.com>
 <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
 <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com>
 <20230606142907.456eec7e@kernel.org>
 <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAJs+hrEO6nqRHPj4kUWRm3UsBiSOU128a4pLEp8p4pokP7MmEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01.09.2023 14:28, Patrick Thompson wrote:
> Hello,
> 
> I was wondering if this should be extended to all RTL_GIGA_MAC_VERs
> greater than 35 as well.
> 
I *think* the mc filtering issue with version 35 is different from the
one you're seeing. So not every chip version may be affected.
As there's no public errata information let's wait for a statement
from Realtek.

> Realtek responded to me but I was slow to get them packet captures
> that they needed. I am hoping to restart things and get back to this
> over the finish line if it's a valid patch.
> 
> I will add the appropriate tags and annotations once I hear back.
> 
> On Tue, Jun 6, 2023 at 5:29 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
>>> Thanks for the report and the patch. I just asked a contact in Realtek
>>> whether more chip versions may be affected. Then the patch should be
>>> extended accordingly. Let's wait few days for a response.
>>>
>>> I think we should make this a fix. Add the following as Fixes tag
>>> and annotate the patch as "net" (see netdev FAQ).
>>>
>>> 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>>
>> Perhaps it's best if you repost with the Fixes tag included once
>> Realtek responded.


