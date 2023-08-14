Return-Path: <netdev+bounces-27404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE177BD5D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068B11C20A55
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC5C2EC;
	Mon, 14 Aug 2023 15:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB2C139
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:47:27 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B0910CE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:47:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so6080133a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692028045; x=1692632845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vbAaoUZfPCAA8/xUH6z2d80JXDAPxxq7t+heNvka5w=;
        b=DM9iiUmuKsRNIKkc0W/mFWAvqD5OCRMnSHuF7XTYVBGA4InHhroD9pFMOP5knBVeIf
         QO9L8auuBMBI/33aQDh2S8Lweas6Bod0Oad9akssMDqMkms6IOgp4GoXegPoq6m+uLB2
         +oRvuAOGzkRZnSCdve7C6xdP0Gx1stiKGhTRkSa66hRevaH+IWtx7JIPnV88OKC+RtrM
         QptIJccU3r6n1+FOUgkre69pXmkpMZbFde3eJyzDhOUiWpO0+WuJeqnz2IX538nQcxPU
         Kly2q14sdK/wVxMYob4wJiMscxsbCRCPgL/u/FuGUvGjsDDi1c0vHq61+7Kl2s4jS1Mg
         JKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692028045; x=1692632845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vbAaoUZfPCAA8/xUH6z2d80JXDAPxxq7t+heNvka5w=;
        b=QF4HSSHbPQtRB2Tj0x0UZniToHPoW9xcgFycVShNyszmFYjBJssgS3JzCEtNKhAWey
         ebAhqP8K+M+RsQ2+aZ7Klk+9z4bqfuqb5N90tw/3DBN2ELmlE3OwD6RPfoMCUsV8di6k
         fCWnmIwZ5p8OWxw5bVtEHntMEQ3Pk2XziAegUnPhhVg2secJyylep8iaMJUsoJND5avM
         rPkI282lx27ckerrPP/xwTS70stSyDfc5IaOgkrvcii/pkZA1wPQwbPXawZCdoNzdRSB
         VspNGUYBIrh4M406qgY3ae9q+xo+ThvEiXuKx0MpgtiznTzeBo7JAKRvjcPbpwcf+FBT
         lvBQ==
X-Gm-Message-State: AOJu0YwkVV785yul+XiXl8GTpI8k/OsztDd/udTROyOCqNMIucY8LO5T
	6Td9e2IZxxlbguTISKn8E/k=
X-Google-Smtp-Source: AGHT+IEe22q0ZReSVUv7kCGN5QNWV8FSRIlzT9+zAi5IYN/L9CEvFE+WxyO4XK7c+1kilq6MhByssQ==
X-Received: by 2002:aa7:c956:0:b0:523:b1b0:f69f with SMTP id h22-20020aa7c956000000b00523b1b0f69fmr8594471edt.32.1692028044671;
        Mon, 14 Aug 2023 08:47:24 -0700 (PDT)
Received: from skbuf ([188.26.184.136])
        by smtp.gmail.com with ESMTPSA id by6-20020a0564021b0600b00523d2a1626esm4175054edb.6.2023.08.14.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:47:24 -0700 (PDT)
Date: Mon, 14 Aug 2023 18:47:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230814154722.re3tu7tqr7al4obd@skbuf>
References: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
 <20230810151617.wv5xt5idbfu7wkyn@skbuf>
 <ZNd4AJlLLmszeOxg@shell.armlinux.org.uk>
 <20230814145948.u6ul5dgjpl5bnasp@skbuf>
 <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpEaMJjmDqhK1dW@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 04:12:40PM +0100, Russell King (Oracle) wrote:
> > > +		__set_bit(PHY_INTERFACE_MODE_RGMII, interfaces);
> > 
> > also, I guess that this should allow all 4 variants of RGMII.
> 
> I'm not sure - looking at what's available, the RTL8366 datasheet (not
> RB) says that there's pinstrapping for the RGMII delays. It also suggests
> that there may be a register that can be modified for this, but the driver
> doesn't appear to touch it - in fact, it does nothing with the interface
> mode. Moreover, the only in-kernel DT for this has:

> Whether that can be changed in the RB version of the device or not, I
> don't know, so whether it makes sense to allow the other RGMII modes,
> again, I don't know.
> 
> Annoyingly, gmac0 doesn't exist in this file, it's defined in
> gemini.dtsi, which this file references through a heirarchy of nodes
> (makes it very much less readable), but it points at:
> 

> So that also uses "rgmii".

... so one of them must be wrong..

> 
> I'm tempted not to allow the others as the driver doesn't make any
> adjustments, and we only apparently have the one user.

I believe you were of the opinion that the RGMII delays in the phy-mode
are from the perspective of the other end of the RGMII connection - i.e.
'rgmii-rxid' means that [ the other end, or the board serpentine traces ]
have set up a clock skew on our RX_CLK relative to our RXD[3:0].

In that interpretation, it doesn't matter whether we're doing anything
in the 4 different phy-modes for rgmii or not, and it's not illegal to
have any of those 4 properties. Only a PHY should modify RGMII delays
based purely upon a phy-mode, and we're not a PHY.

A MAC could adjust its RGMII delays based on rx-internal-delay-ps and
tx-internal-delay-ps, independently (to some extent) of what its
phy-mode is. The rtl8365mb_ext_config_rgmii() method of the related
rtl8365mb does just that.

