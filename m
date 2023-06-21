Return-Path: <netdev+bounces-12572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A72738257
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C471C20B7E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B5134A2;
	Wed, 21 Jun 2023 11:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46811CBF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 11:37:08 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168410FE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 04:37:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7812932e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1687347422; x=1689939422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfhZJ8uc4y6fUhhrEhziQJjHiyG8Yoiyo0YLr+Igvh8=;
        b=iC+bgVStPL+2/WQX2fRJFUl2ITAhLMXPrP6dSUtEN7ck4b8xl2H1pUi9DEZl3QyCjv
         xtr1d9WDXhTcwr4ZnCry1IryzMc8yosRMSGb3mpGvE5kGjyMA7nwB9ZknDBeQQdv47t8
         gr6fqiEEvvKu0wl2/6C2394Ny7Wvs2kKTIEQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347422; x=1689939422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfhZJ8uc4y6fUhhrEhziQJjHiyG8Yoiyo0YLr+Igvh8=;
        b=AZeLAy/J32XhG95vfXyv2fpCwSHYy0aIhLnCe2qgjvp8RRBfLD5GXDb5hsKwyY5xn7
         buNrda28U/cTV82rN6OF4WYFWRu9Prlh7QGJPVBlnXHgAQdjPhRCvAcRZSI8+pnQOoCg
         MZbs1/P3FHwXUD9N+Fv1TAGN16NvrUjA5OOmfB6PGq3e0eT/ZsGg0X1NKr2+UcGsdP7X
         sUembcqznDRttHdPaF6SBOstAv8OmSKcK0x8Y0wWjVIj/EB7PkBAYUvuxuMLXkdmsuUd
         FfWfb+sDwuHx6LrSBmOFEVL0dTuATaFM4Paqfj31KImukvtA4WQUUVUoNGjtLGaQb7Lx
         /MAA==
X-Gm-Message-State: AC+VfDz7Stq1lbeUbp93pyObE/gPeUssYLiK1w9v/mw6h0RnhwcXxNxV
	/wNugbt4rExmxhhFTCyOlET4SA==
X-Google-Smtp-Source: ACHHUZ4LUyIdSuGTGR+nqFbQC9nDfvyQyyXxLEbsQD2bcvUuI81UIoKv781MXrsynNLrR8kaS4CP0w==
X-Received: by 2002:a05:6512:3d90:b0:4f8:58ae:8ea8 with SMTP id k16-20020a0565123d9000b004f858ae8ea8mr8300205lfv.58.1687347422043;
        Wed, 21 Jun 2023 04:37:02 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q4-20020ac24a64000000b004f6284b3064sm763297lfp.140.2023.06.21.04.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:37:01 -0700 (PDT)
Message-ID: <c30235e8-a7bd-dac4-a42c-ed673991e4ab@rasmusvillemoes.dk>
Date: Wed, 21 Jun 2023 13:37:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 3/3] net: dsa: microchip: fix writes to phy
 registers >= 0x10
Content-Language: en-US, da
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
 <20230620113855.733526-4-linux@rasmusvillemoes.dk>
 <88474092-70cb-40fc-9c01-1fc8527d5bcb@lunn.ch>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <88474092-70cb-40fc-9c01-1fc8527d5bcb@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/06/2023 21.28, Andrew Lunn wrote:
> On Tue, Jun 20, 2023 at 01:38:54PM +0200, Rasmus Villemoes wrote:
>> According to the errata sheets for ksz9477 and ksz9567, writes to the
>> PHY registers 0x10-0x1f (i.e. those located at addresses 0xN120 to
>> 0xN13f) must be done as a 32 bit write to the 4-byte aligned address
>> containing the register, hence requires a RMW in order not to change
>> the adjacent PHY register.
> 
> ASIC engineers do see to come up with novel ways to break things.
> 
> I assume you have not seen real problems with this, which is why it is
> not for net and a Fixes: tag?

Well, not real problems yet, no. The back story is that I want/need to
implement support for "single LED mode" on the ksz9567, because our
board has two separate simple LEDs for link/activity, and not some
multi-color LED that can indicate speed/link/activity. So that means
writing a 1 to bit 4 of MMD reg 2/0, but due to an errata, _also_
writing a 1 to bit 9 of phy register 0x1e, and when one wants to do
that, this errata applies.

Rasmus


