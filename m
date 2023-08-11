Return-Path: <netdev+bounces-26917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDDD77971D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355B92819BC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC411723;
	Fri, 11 Aug 2023 18:31:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9F8468
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 18:31:22 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666430DC
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:31:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f8614ce5so2071784b3a.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691778681; x=1692383481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMZCsaveLMfFAtttMkdGSoAimZYn5sVg6ReoRxOYixY=;
        b=rKtqxnxQU7yKkc3TbGGugoik1jynwZ4GawFAu4EVb+aA2Gt844BeJKmFiXaapkauAB
         TY8ID3JN33X19i1nxZ0Yo7sLXKRMdsaEaqb1vxQMDeELPV16u4IryCErfya258CcNQUu
         umnVr9pCKBOxMo/23ieXHb0GDKpOtL7mCXXTt0HYeL1SoRpCc826a2wFgg8trMIL6gsB
         uZAdaG+6OuXxAHUgp4rvf2bnncgGpWncdDC+R1hmF/T1i2bXHxTZoXACzAnV2e+vC0Tg
         9muRSTnKu+XjAXuiGssR7ipiDQHNy/+30T3hCHJ94ul/kkf0VJmgSVfA+uOh8FLb3oCg
         NVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691778681; x=1692383481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMZCsaveLMfFAtttMkdGSoAimZYn5sVg6ReoRxOYixY=;
        b=ljehP6T5U7NiczfYzObKg9us/YBXDXdkgqNyx0Z1KlTOWKJHnkqSA9P7YY44pGyAcJ
         T9ZuL1fZLUVI9chsU/EMWcQ9w06xW5FwejQJP+IFB1mK8Ql8gqg4HzGecmoiPr+Qa8Nt
         t76USRRI05OZzErmIm5EDN8Gg8MVOnni44oKdn020ZQ9l0f/pZJX/ulGflIoZTAjjDNa
         goWU79z/QcKyMmZnte0Ls7+pYJ34b8FXFAGJpcn39DSUCbxk4eHM4Knc2L0Rri8xpYkP
         hI31G3Oxxo2+4bu9tAzOEEQMauos91oD3JvbnULsRi7YYeTTCCYXqmjJcbYMgAaR7ycY
         CG6g==
X-Gm-Message-State: AOJu0YxuBHKtg7BvtpBaiFTAUod4DrUIe1X2bZ10RUj3MWQdGFW6cVgs
	9C3Vl9qx/6XA7/vMENiq510=
X-Google-Smtp-Source: AGHT+IExDeLJIUO7p4O28MUacWMcPOUO0dgt2Oj7NY2plu3qk7uP1kEwDAhx+696hZRMF16jckZ26Q==
X-Received: by 2002:a17:90a:6886:b0:268:5c2f:f0c7 with SMTP id a6-20020a17090a688600b002685c2ff0c7mr2318840pjd.5.1691778681359;
        Fri, 11 Aug 2023 11:31:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ip2-20020a17090b314200b0026930a0419bsm8424966pjb.0.2023.08.11.11.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:31:20 -0700 (PDT)
Message-ID: <61793f58-4ad3-c885-39a4-99a8dd2e36ff@gmail.com>
Date: Fri, 11 Aug 2023 11:30:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: phy: fix IRQ-based wake-on-lan over hibernate /
 power off
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Andre Edich <andre.edich@microchip.com>, Antoine Tenart
 <atenart@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 "David S. Miller" <davem@davemloft.net>,
 Divya Koppera <Divya.Koppera@microchip.com>,
 Eric Dumazet <edumazet@google.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mathias Kresin <dev@kresin.me>, Maxim Kochetkov <fido_max@inbox.ru>,
 Michael Walle <michael@walle.cc>, Neil Armstrong <narmstrong@baylibre.com>,
 Nisar Sayed <Nisar.Sayed@microchip.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Willy Liu <willy.liu@realtek.com>, Yuiko Oshino
 <yuiko.oshino@microchip.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 netdev@vger.kernel.org
References: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qUPLi-003XN6-Dr@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 03:26, Russell King (Oracle) wrote:
> Uwe reports:
> "Most PHYs signal WoL using an interrupt. So disabling interrupts [at
> shutdown] breaks WoL at least on PHYs covered by the marvell driver."
> 
> Discussing with Ioana, the problem which was trying to be solved was:
> "The board in question is a LS1021ATSN which has two AR8031 PHYs that
> share an interrupt line. In case only one of the PHYs is probed and
> there are pending interrupts on the PHY#2 an IRQ storm will happen
> since there is no entity to clear the interrupt from PHY#2's registers.
> PHY#1's driver will get stuck in .handle_interrupt() indefinitely."
> 
> Further confirmation that "the two AR8031 PHYs are on the same MDIO
> bus."
> 
> With WoL using interrupts to wake the system, in such a case, the
> system will begin booting with an asserted interrupt. Thus, we need to
> cope with an interrupt asserted during boot.
> 
> Solve this instead by disabling interrupts during PHY probe. This will
> ensure in Ioana's situation that both PHYs of the same type sharing an
> interrupt line on a common MDIO bus will have their interrupt outputs
> disabled when the driver probes the device, but before we hook in any
> interrupt handlers - thus avoiding the interrupt storm.
> 
> A better fix would be for platform firmware to disable the interrupting
> devices at source during boot, before control is handed to the kernel.
> 
> Fixes: e2f016cf7751 ("net: phy: add a shutdown procedure")
> Link: 20230804071757.383971-1-u.kleine-koenig@pengutronix.de
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


