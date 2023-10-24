Return-Path: <netdev+bounces-44026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0B7D5DE8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DA5B20E30
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DC2D63C;
	Tue, 24 Oct 2023 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLYV4UdT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576D2D634
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:06:18 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7D10A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:06:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9bca1d96cso34799595ad.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698185176; x=1698789976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCovsdWa3UQLcpG/2wQFoxNwigJu+76XMupZXNtRCMo=;
        b=BLYV4UdTx/FRNlQc+MKJAFE1Wj6AVPdkYHiPe4RXmEnoQRIOj0GceaE4A8jSnKCXBh
         ckwTWxwXxuCXzSna4THPHl3Pn/TLGYjsdoXC2IuNXLjw4IYItPivTAPbXdXbxS6JeiSx
         +QCvUNiRZuTUeUvFKHWyc5WoyYwubxbwENF+x9IO98qN+EoYLI1melc/MTEhv4cSRKMq
         7uOsShuAcE4qXaXWnhDsOfCIA4B6Gz/1AHqiL+Lh0Od/VFSpKp0MZyJneCg9wMHYlMb6
         ZOYXW6RSgSnBWSNJx9PzA5E9lUrX6x3DpGo95vWvdCXszMuKOtQp52OyPxcQrJazxJGE
         sIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698185176; x=1698789976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCovsdWa3UQLcpG/2wQFoxNwigJu+76XMupZXNtRCMo=;
        b=eHQsuV5pITYj/rDE4hIb9tZfRIM4KHM52XBTS3dhbVlajOIi6OIf8RAKFKnRyS7qNF
         wXJrUnrChVE2cdKL83Hh0LNGn5XT0m/bLXyCQmrB6+Qyt1DqddRzhOYoiXy7juiFXQLT
         dJA+5UUzEIMYh4CIS1EmPZnlhXWYU447M26kMH1ddaEmogt48k/vNozNQE6LU4cZ2YHk
         KgcmBu/BavUwMI2l7tygXsxA79c8uSy6iOgSW80apnErfh04wTZMbRtv678/NFLRNRfO
         9T0OlyWc1lJueML26mQwo0322E+vPKoyY5wXGfEuqiJJ1TJ4Wk/PGUPFBmvaP0DqJJ9F
         pFbQ==
X-Gm-Message-State: AOJu0Yz7TV5HoVhTvwoweL+3CvkuUTO6svRdAfycqNI7e6MF1uDkqz14
	i/r4lTIKPctolcUaxfFwbn8=
X-Google-Smtp-Source: AGHT+IGXUITj4oe/gASgC0RJNPljH0pxlNedKIqmISTpdrp74VHYR7EjLwd2hm+a9hpxsg/cZ4vJ0g==
X-Received: by 2002:a17:90b:3d8c:b0:27d:c92:e897 with SMTP id pq12-20020a17090b3d8c00b0027d0c92e897mr12170458pjb.37.1698185176561;
        Tue, 24 Oct 2023 15:06:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j11-20020a17090aeb0b00b00262ca945cecsm9127685pjz.54.2023.10.24.15.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 15:06:16 -0700 (PDT)
Message-ID: <368746a2-4637-4b2d-af39-888d87ae5c46@gmail.com>
Date: Tue, 24 Oct 2023 15:06:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: dsa: realtek: support reset controller
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 andrew@lunn.ch, vivien.didelot@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzk+dt@kernel.org, arinc.unal@arinc9.com
References: <20231024205805.19314-1-luizluca@gmail.com>
 <809d24bf-2c1b-469c-a906-c0b4298e56a0@gmail.com>
 <CAJq09z4=QZOZ7mvmrPrs4Ne+TCyMZ5k276Kz8Ud+ty9qAmW2WA@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAJq09z4=QZOZ7mvmrPrs4Ne+TCyMZ5k276Kz8Ud+ty9qAmW2WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 15:02, Luiz Angelo Daros de Luca wrote:
>> Empty stubs are provided when CONFIG_RESET_CONTROLLER is disabled
> 
> Nice! I'll drop the "#ifdef"s.
> 
>> if you switch to using devm_reset_control_get() then you will get a NULL
>> reset_control reference which will be a no-op for all of those operations.
> 
> I'm already using devm_reset_control_get(). Maybe you copied the wrong
> name? Did you mean devm_reset_control_get_optional()?
> It is, indeed, what I needed. Thanks.

Yes I copy/pasted what I had just been searching for and instead 
intended to mention that devm_reset_control_get_optional() would do what 
you need. Thanks!
-- 
Florian


