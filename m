Return-Path: <netdev+bounces-25445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB6774033
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5781281494
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189213FEE;
	Tue,  8 Aug 2023 17:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823A1B7C3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:00:17 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F89713C42F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:59:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31771a876b5so4439042f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513964; x=1692118764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhEqjQrPXRTh/6hUY9Sp+WGRHv8Oum6SCOIHBnhXB/Y=;
        b=dQBV8JjVtsHunWnhwQwQ91C3Tfs2wChX4ucnVofJEE6gccsXGm8xoEvOfSe4+95BG8
         KgxLHuWctBEIlW0QOlYIt7jZ94AR74T/kq7pnvrKsNY+b+lMe51gvIkkUlUmIisLgYSG
         NorLtSbNgBaHk1D2XNIyy5/ZKzTaWPgvfsRCm0njNxHUQyaR4PuorsbDAex+35iWUYHz
         GVDpRD5C7Cps2txoZXoKICBhT8R6XUr+z1MPHpCkluQrqktMj9UpQkl0NfCK1dbtN5Qz
         L1JZDS0SxShAYTDnCxSq7I6lnhgVOqPi2B8+4Npt9UUMENke50FO2HBfzclwu0Y08Jnn
         vaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513964; x=1692118764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhEqjQrPXRTh/6hUY9Sp+WGRHv8Oum6SCOIHBnhXB/Y=;
        b=UiM+NGxlsRBXcLVV30YvXbMD9P0lCdOL2oyGtMqlA/a+UXFIFQSH9xGQdqHLHdC7wh
         iKbaHqV1LDnE2ZHyqmCJGHG6OX66nzSC7aiBpFHE2BMxdDRkLyf4UDN8v7VtRwhsp26F
         GTF1lW1RBh4wKarayjXk8nXe0xz5p8FX43ux958nmTW7ObcPjJhCaVPJrY/Hua7rBdWx
         FprlD7VpHhliUmnfhs/ptVEUvxIBTj8i6hUOz3c6heQog995qIuKA0EKkYJmZDctCrau
         AWuxdhTZlTi1hi0tN2YvQ3up4PwpUJEeG816YQS9iGIFfzkNQ6obURnTfEjX2FuMjhwk
         MSVQ==
X-Gm-Message-State: AOJu0YxhsYhfaciRPWtvA9VONKe6BvaovdWJM7/CtBjW32ray7IZkcVK
	K56V947FQVU3Mz/1H/p6ozRm3zDd4ePP/D8W
X-Google-Smtp-Source: AGHT+IEwN+9FaI3mvSgAcrRvfG1Ksgyu5mEwuhMLJmDCODYgidG2mYE1qjzJbsbKIwJh3zzfhaZMMw==
X-Received: by 2002:a05:6512:68d:b0:4f6:1779:b1c1 with SMTP id t13-20020a056512068d00b004f61779b1c1mr9820470lfe.48.1691498344375;
        Tue, 08 Aug 2023 05:39:04 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id bo17-20020a0564020b3100b0051e0cb4692esm6587374edb.17.2023.08.08.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:39:04 -0700 (PDT)
Date: Tue, 8 Aug 2023 15:39:01 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230808123901.3jrqsx7pe357hwkh@skbuf>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 01:30:16PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 08, 2023 at 03:06:52PM +0300, Vladimir Oltean wrote:
> > Hi Russell,
> > 
> > On Tue, Aug 08, 2023 at 12:12:16PM +0100, Russell King (Oracle) wrote:
> > > If we successfully parsed an interface mode with a legacy switch
> > > driver, populate that mode into phylink's supported interfaces rather
> > > than defaulting to the internal and gmii interfaces.
> > > 
> > > This hasn't caused an issue so far, because when the interface doesn't
> > > match a supported one, phylink_validate() doesn't clear the supported
> > > mask, but instead returns -EINVAL. phylink_parse_fixedlink() doesn't
> > > check this return value, and merely relies on the supported ethtool
> > > link modes mask being cleared. Therefore, the fixed link settings end
> > > up being allowed despite validation failing.
> > > 
> > > Before this causes a problem, arrange for DSA to more accurately
> > > populate phylink's supported interfaces mask so validation can
> > > correctly succeed.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > 
> > How did you notice this? Is there any unconverted DSA switch which has a
> > phy-mode which isn't PHY_INTERFACE_MODE_INTERNAL or PHY_INTERFACE_MODE_NA?
> 
> By looking at some of the legacy drivers, finding their DT compatibles
> and then grepping the dts files.
> 
> For example, vitesse,vsc73* compatibles show up here:
> 
> arch/arm/boot/dts/gemini/gemini-sq201.dts
> 
> and generally, the ports are listed as:
> 
>                                 port@0 {
>                                         reg = <0>;
>                                         label = "lan1";
>                                 };
> 
> except for the CPU port which has:
> 
>                                 vsc: port@6 {
>                                         reg = <6>;
>                                         label = "cpu";
>                                         ethernet = <&gmac1>;
>                                         phy-mode = "rgmii";
>                                         fixed-link {
>                                                 speed = <1000>;
>                                                 full-duplex;
>                                                 pause;
>                                         };
>                                 };
> 
> Since the vitesse DSA driver doesn't populate .phylink_get_caps, it
> would have been failing as you discovered with dsa_loop before the
> previous patch.
> 
> Fixing this by setting GMII and INTERNAL worked around the additional
> check that was using that failure and will work fine for the LAN
> ports as listed above.
> 
> However, that CPU port uses "rgmii" which doesn't match the GMII and
> INTERNAL bits in the supported mask.
> 
> Since phylink_validate() does this:
> 
>         const unsigned long *interfaces = pl->config->supported_interfaces;
> 
> 	if (state->interface == PHY_INTERFACE_MODE_NA)
> 
> ... it isn't, so we move on...
> 
>         if (!test_bit(state->interface, interfaces))
>                 return -EINVAL;
> 
> This will trigger and phylink_validate() in phylink_parse_fixedlink()
> will return -EINVAL without touching the passed supported mask.
> 
> phylink_parse_fixedlink() does:
> 
>         bitmap_fill(pl->supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
>         linkmode_copy(pl->link_config.advertising, pl->supported);
>         phylink_validate(pl, MLO_AN_FIXED, pl->supported, &pl->link_config);
> 
> and then we have:
> 
>         s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
>                                pl->supported, true);
> 
> ...
>         if (s) {
> 		... success ...
>         } else {
>                 phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
>                              pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
>                              pl->link_config.speed);
>         }
> 
> So, since phylink_validate() with an apparently unsupported interface
> exits early with -EINVAL, pl->supported ends up with all bits set,
> and phy_lookup_setting() allows any speed.
> 
> If someone decides to fix that phylink_validate() error checking, then
> this will then lead to a warning/failure.
> 
> I want to avoid that happening - fixing that latent bug before it
> becomes a problem.

Aha, ok, thanks for explaining.

