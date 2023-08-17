Return-Path: <netdev+bounces-28563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F377FD68
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342E21C213E3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D0171DB;
	Thu, 17 Aug 2023 18:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5C14AA6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:01:36 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3518D19A1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:01:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso1006941fa.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692295292; x=1692900092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cou3dyLffzWYYQt/a0NITOi/SkByjV0K0gTVHwjkrIU=;
        b=hVWOlyP/bUnEqW/iWB3pUNyUMFoGjeen62eOIUqMtSNtLue1JbWDWnwbBLJCtv65hf
         tIH+vIfxUaafvpYYznGhckVQqZ/gK/Ja2atUuJJjCQSR758ydv8lk37FKD8e/UJhFXY0
         tSZ1uz0Yx7rv9wGwV0rQwjPqXamqNneGDeGGl1tHUUEHxyRYzEg3v/XLVOUa5u10f1Hb
         8gZqFhJulSuplctrYxpj9VOss3Cqm1baXiJxBxZzPCWHO++1ZsPebUMBaGLJ1426kRwh
         k8A9dAbpQny/DAv5CJFwEKQ0kZw4bAlFe3lWo1jGVDwBo25E9oqq99SFmNIBfGbZPGyV
         FBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295292; x=1692900092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cou3dyLffzWYYQt/a0NITOi/SkByjV0K0gTVHwjkrIU=;
        b=SYsG7Whu3/t2bICFQ/5L9b8lPg90QxMCLWforRN/9FMTWLwjdOHO/+SmgCaOfcSE3D
         dp6PuYqRKGk05sfuWM2AwLWV0glJ8clCzOm8OkWQWcsLEOH3zZboP7rCZzjGYQD0U3Cv
         ZUDESm6nddUY3LWjAijAR6r+M1FMXw9e2TNc4twqWTDWE4J0lUODzCPl5R9TgVpa3zbp
         rN1s4tlXONQiDRHJhnDrEG3B4ngBkLQ3yBK63Ez7/o27HE6YDtlNWflKv5s8pPaiIz9j
         iXXWpuWUjrxSlJAQqQL55YP7+9GT039Np1cfLjAnJTVNsEg3/r1j2b/WnpygH3zXGcN5
         wpDQ==
X-Gm-Message-State: AOJu0YzBH1m+ovY5Z7Y/Kz+HZYtpr1Qsb2k2ymUYvggSz6mzcmEhJknb
	2jAzUbEEOj66vWhSEGRm2B8=
X-Google-Smtp-Source: AGHT+IEV1D4vqbnZkB1CHMc137SfsiQtkVjaZOBu9qoLNC3G1NvT+tgDcD0su6BpHjvoupOxjx4h4Q==
X-Received: by 2002:a2e:995a:0:b0:2b9:e15f:e780 with SMTP id r26-20020a2e995a000000b002b9e15fe780mr73859ljj.26.1692295292134;
        Thu, 17 Aug 2023 11:01:32 -0700 (PDT)
Received: from skbuf ([188.25.231.206])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b0099de082442esm32640ejb.70.2023.08.17.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:01:31 -0700 (PDT)
Date: Thu, 17 Aug 2023 21:01:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Linus Walleij <linus.walleij@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230817180129.krlht3anaa752w46@skbuf>
References: <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
 <055be6c4-3c28-459d-bb52-5ac2ee24f1f1@lunn.ch>
 <ZNpWAsdS8tDv9qKp@shell.armlinux.org.uk>
 <8687110a-5ce8-474c-8c20-ca682a98a94c@lunn.ch>
 <ZNqklHxfH8sYaet7@shell.armlinux.org.uk>
 <ZNtPswQl8fvnlGyf@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNtPswQl8fvnlGyf@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On Tue, Aug 15, 2023 at 11:13:07AM +0100, Russell King (Oracle) wrote:
> There is one case that I have missed, and it's totally screwed by
> this behaviour where a Marvell DSA switch is connected to a Marvell
> PHY via a RGMII connection:
> 
>    DSA <---------------------------------> PHY
>     v					    v
> dt-dsa-node {				phy: dt-phy-node {
>   phy-handle = <&phy>;			  ...
>   phy-mode = "rgmii-foo";		};
> };
> 
> parses phy mode
> configures for RGMII mode
> configures RGMII delays associated
>  with phy-mode
> calls phy_attach(..., mode);
> phylib sets phy_dev->interface
> 					PHY driver looks at
> 					phydev->interface and
> 					configures delays
> 
> In this case, we have *both* ends configuring the RGMII delays and it
> will not work - because having the DSA MAC end configure the delays
> breaks the phylib model where the MAC *shouldn't* be configuring the
> delays.
> 
> So, should mv88e6xxx_mac_config() also be forcing all RGMII modes
> in state->interface to be PHY_INTERFACE_MODE_RGMII when passing
> that into mv88e6xxx_port_config_interface() if, and only if the
> port is a user port? Or maybe if and only if the port is actually
> connected to a real PHY?

I'd tend to believe that you're right, this would be broken (and not
just with Marvell RGMII PHYs).

I was under the impression that mv88e6xxx_mac_config() will only
configure the RGMII delays associated with phy-mode if the port is in
fixed-link mode.

But looking at the actual condition upon which mv88e6xxx_mac_config()
decides to call mv88e6xxx_port_config_interface(), that is:

	if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(chip, port))
		mv88e6xxx_port_config_interface()

and thus, an external PHY would return false for the first term of the
OR operation, but true for the second, and it would proceed to configure
the MAC-side RGMII delays, resulting in a double delay.

However, I am not fully confident in my analysis, since I don't have
mv88e6xxx hardware with an RGMII port to confirm.

It's interesting that we haven't seen reports?

