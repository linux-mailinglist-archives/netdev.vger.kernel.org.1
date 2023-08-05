Return-Path: <netdev+bounces-24690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD6977121B
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 22:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79894281BAE
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412BAC8DF;
	Sat,  5 Aug 2023 20:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FF1FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 20:25:51 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF02D72
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 13:25:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso1376587e87.2
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691267142; x=1691871942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/suAOSQGI0i2N3TQ0S3FcTenWc2CSU80rhZyaL3wWQ=;
        b=vzJu69AXVlydBjMeUkuoOsvDJvYRRLiVtN3vpYzV7KWnnwNzVoZypW7GzRHN+hCQYS
         OBwgfHGkgBxeehtuNnIih7ti7zDd47ca/m63PBHw8wlLosA/Ok1kRG4El9Q43mPo8F1H
         o1lZZUphOMIBDfDpQeB6Mc6QMb7V5rCzWRCo7hpDF/gkSJkgH5ho+ff1CsDNlmuezW1I
         kpeA8VU6PZQuY5ktaYv50ioKuVBlWnmFp5e13CP58FPPkotFFbysNpclhKPLRaINQE79
         dbMymKfjz7W969iN6RuZcHq13fEcQQ3GCXfQSrbNnYLkoglQQzdbNW/6m5d57KXwmR+t
         Eysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691267142; x=1691871942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/suAOSQGI0i2N3TQ0S3FcTenWc2CSU80rhZyaL3wWQ=;
        b=Dm++t/z+5Did0153eLGxzz0bbA7K9A2IPWMyy0OMcO7N8tdPLNoSJ5WFzckwq4tVF5
         9zogurbH+PQY06IvqphZQJ1nSeuByIPyccyay2Rl51APLvkTnkbyi0+uummOzCnEtl3S
         EOekRMg+i71Y+Cj/5UcRkdvsXzAVPEsWBm1vtt5jV5erMfWwj7jWU6hULcDJuUiX8TUf
         1qbOS3xEDmpFEJHIgV2T5XC/tXUW1gNTQ0Tf/WcDamK7r/hfEt7lqDdpaVt7BnVMe6lv
         hkS+mWy9T9sCs0ucLv+9kl/U5Yvpf7wND40Tcc6lGSpV2jGMuGsuFMsVpUx45yOes+F6
         9juA==
X-Gm-Message-State: AOJu0Yy4FVdQ/jx+NrC1rReoQfR04ZgP6o+D/5co8C1k5Zz9D3VIY+bD
	1E5ebj3TenxUEHmF3IgpFa3QOTCORm93HtoSRlIC+w==
X-Google-Smtp-Source: AGHT+IG1fHQr26PowhIL+bVvPOeVUOf1J8ORZz4zxqcjR8Suj7CJa+qKReyYYbylTbh064RiNIq8iVo4LWxVZcGb9/Y=
X-Received: by 2002:a05:6512:32cb:b0:4f8:6dfd:faa0 with SMTP id
 f11-20020a05651232cb00b004f86dfdfaa0mr3894093lfg.2.1691267141788; Sat, 05 Aug
 2023 13:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713202123.231445-1-alex@shruggie.ro> <20230713202123.231445-2-alex@shruggie.ro>
 <20230714172444.GA4003281-robh@kernel.org> <CAH3L5Qoj+sue=QnR2Lp12x3Hz2t2BNnarZHJiqxL3Gtf6M=bsA@mail.gmail.com>
 <7fa2d457-4ae9-42f5-be73-80549aae558c@lunn.ch>
In-Reply-To: <7fa2d457-4ae9-42f5-be73-80549aae558c@lunn.ch>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Sat, 5 Aug 2023 23:25:31 +0300
Message-ID: <CAH3L5Qpd+6740SeQJh+1J8MjC1BjHE=EEReK9AOuJW_Ey3V4mA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 6:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > So, there's the adin.c PHY driver which has a similar functionality
> > with the adin_config_clk_out().
> > Something in the micrel.c PHY driver (with
> > micrel,rmii-reference-clock-select-25-mhz); hopefully I did not
> > misread the code about that one.
> > And the at803x.c PHY driver has a 'qca,clk-out-frequency' property too.
> >
> > Now with the mscc.c driver, there is a common-ality that could use a fr=
amework.
> >
> > @Rob are you suggesting something like registering a clock provider
> > (somewhere in the PHY framework) and let the PHY drivers use it?
> > Usually, these clock signals (once enabled on startup), don't get
> > turned off; but I've worked mostly on reference designs; somewhere
> > down the line some people get different requirements.
> > These clocks get connected back to the MAC (usually), and are usually
> > like a "fixed-clock" driver.
>
> They are not necessarily fixed clocks. The clock you are adding here
> has three frequencies. Two frequencies is common for PHY devices. So
> you need to use something more than clk-fixed-rate.c. Also, mostly
> PHYs allows the clock to be gated.
>
> > In our case, turning off the clock would be needed if the PHY
> > negotiates a non-gigabit link; i.e 100 or 10 Mbps; in that case, the
> > CLKOUT signal is not needed and it can be turned off.
>
> Who does not need it? The PHY, or the MAC? If it is the MAC, it should
> really be the MAC driver which uses the common clock API to turn it
> off. Just watch out for deadlocks with phydev->lock.

The MAC needs the clock in GMII mode, when going in gigabit mode.

>
> > Maybe start out with a hook in 'struct phy_driver'?
> > Like "int (*config_clk_out)(struct phy_device *dev);" or something?
> > And underneath, this delegates to the CLK framework?
>
> Yes, have phy_device.c implement that registration/unregister of the
> clock, deal with locking, and call into the PHY driver to actually
> manipulate the clock. You missed the requested frequency in the
> function prototype. I would also call it refclk. Three is sometimes
> confusion about the different clocks.

Ack.
Then something like:
int (*config_refclk)(struct phy_device *dev, uint32_t frequency);

>
> Traditionally, clk_enable() can be called in atomic context, but that
> is not allowed with phylib, it always assume thread context. I don't
> know if the clock framework has some helpers for that, but i also
> don't see there being a real need for MAC to enable the clock in
> atomic context.
>
>         Andrew

