Return-Path: <netdev+bounces-36337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239D7AF43E
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E09112815BC
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23E4998B;
	Tue, 26 Sep 2023 19:41:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30941E2A
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 19:41:09 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392410DF
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:40:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50306b2920dso11524414e87.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695757240; x=1696362040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tY53UmBtlc+85GMSvAHJGK/MN3haZ8boSQ6nR3gXKQ0=;
        b=TbeaGVYo028bet9Igmipon7uy0VtE4Lv++DTzxXUVa30ogJjY8BjV9q13SsutVa11i
         cCP8W3TMHgKm8H5v664k+Vp05y1m+lBpLT3tjL74GFFRgc+Y1V4NhVovVHVH4OySBg9a
         sCTqfbeUA0bkf1O/ELqI6boRMpE73ttyw8oZLzqKSKOPjzOgOXE3hTiPGhEabDs3xUbQ
         oxOlpX/BDzNnrOLnaT1YHDIGxooh5+Pl6bp1+BL8NlgE3vfLf7H4N/TDuHuC7Fl8Z1IL
         nGFgOp6/dPNqvZFFHi4lI7EDJAlAoj+Jl827Wog1EIUA8ZmG+CFNwf8MX9BDI2NeiGyn
         1DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757240; x=1696362040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY53UmBtlc+85GMSvAHJGK/MN3haZ8boSQ6nR3gXKQ0=;
        b=s9ujGrxPOnO539+JNAfWpfMkFqHUI3f940bmnZ4jKG0/2V9VIoXEgWqDvDv8b96rha
         7wjr7n1qfcw2BwibB8sLEbls3k3awQwlqX8efFlrrUpQu30MKQsYUywWaL0U18cdG51K
         RDzTPpoBNaWiYs9Zhb4s/+oXgrDdE4H01G8GjLtRCXSmsZgsfhR6rZHn/2lK4rVvDJOT
         jrs0hbhcc7lGEIY01zncv/wFJiErGAdvgph7PSPYrNSGKRJmkl55rwe+JUU2/3FEXWYj
         aE/0pm1rE6tLm0RXugKkaHU9nVDQrhqs8u9g0zTAiH1qDYCPXNS2NmpqVx3G2nHsD1YV
         vbdg==
X-Gm-Message-State: AOJu0YxzFi8cpzH813a7Z+yZflnY9VlAbej2RWXQanmaphf3bS7O96IH
	UFFaV/J/Z6FE9rvBYXT4sBc=
X-Google-Smtp-Source: AGHT+IGKeG1h+97BmnW9ojajdmm6HnFjtkl8oGz/PaLxI7GlqXuM/xMePfdkSMfH5Dj0TgoO8MRnIw==
X-Received: by 2002:a05:6512:2813:b0:503:2879:567 with SMTP id cf19-20020a056512281300b0050328790567mr1585943lfb.28.1695757239233;
        Tue, 26 Sep 2023 12:40:39 -0700 (PDT)
Received: from mobilestation ([95.79.201.222])
        by smtp.gmail.com with ESMTPSA id b1-20020ac24101000000b005042a4cca48sm2299024lfi.12.2023.09.26.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:40:38 -0700 (PDT)
Date: Tue, 26 Sep 2023 22:40:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com, 
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <7f5whbjorcpe54jyb2wgtfh5frvbnzbqf34kmqsbf47qafgy7d@jizucumwetfp>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
 <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
 <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
 <ZRLuv77VSTXSZSc7@shell.armlinux.org.uk>
 <rbavthifczzgwxmgtb4hbv6hnqb57timfzvbizscdtxz62ookg@bgrwergjyulb>
 <ZRL9AoHpiUJRFJRc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRL9AoHpiUJRFJRc@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 04:47:14PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 26, 2023 at 06:27:45PM +0300, Serge Semin wrote:
> > On Tue, Sep 26, 2023 at 03:46:23PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Sep 26, 2023 at 03:09:47PM +0300, Serge Semin wrote:
> > > > Hi Russell
> > > > 
> > > > > Since you have access to the hardware manual, what does it say about
> > > > > clause 37 auto-negotiation when operating in 2500base-X mode?
> > > > 
> > > > Here are the parts which mention 37 & SGMII AN in the 2.5G context:
> > > > 
> > > > 1. "Clause 37 (& SGMII) auto-negotiation is supported in 2.5G mode if
> > > >     the link partner is also operating in the equivalent 2.5G mode."
> > > > 
> > > > 2. "During the Clause 37/SGMII as the auto-negotiation link timer
> > > >     operates with a faster clock in the 2.5G mode, the timeout duration
> > > >     reduces by a factor of 2.5. To restore the standard specified timeout
> > > >     period, the respective registers must be re-programmed."
> > > > 
> > > > I guess the entire 2.5G-thing understanding could be generalized by
> > > > the next sentence from the HW manual: "The 2.5G mode of operation is
> > > > functionally the same as 1000BASE-X/KX mode, except that the
> > > > clock-rate is 2.5 times the original rate. In this mode, the
> > > > Serdes/PHY operates at a serial baud-rate of 3.125 Gbps and DWC_xpcs
> > > > data-path and the GMII interface to MAC operates at 312.5 MHz (instead
> > > > of 125 MHz)." Thus here is another info regarding AN in that context:
> > > > 
> > > > 3. "The DWC_xpcs operates either in 10/100/1000Mbps rate or
> > > > 25/250/2500Mbps rates respectively with SGMII auto-negotiation. The
> > > > DWC_xpcs cannot support switching or negotiation between 1G and 2.5G
> > > > rates using auto-negotiation."
> > > 
> > > Thanks for the clarification.
> > > 
> > > So this hardware, just like Marvell hardware, operates 2500BASE-X merely
> > > by up-clocking, and all the features that were available at 1000BASE-X
> > > are also available at 2500BASE-X, including the in-band signalling.
> > > 
> > > Therefore, I think rather than disabling AN outright, the
> > > PHYLINK_PCS_NEG_* mode passed in should be checked to determine whether
> > > inband should be used or not.
> > 
> > Just an additional note which might be relevant in the context of the
> > DW XPCS 1G/2.5G C37 AN. The C37 auto-negotiation feature will be
> > unavailable for 1000BASE-X and thus for 2500BASE-X if the IP-core is
> > synthesized with no support of one. It is determined by the CL37_AN
> > IP-core synthesize parameter state:
> > 
> > Enable SGMII Clause 37 | Description: Configures DWC_xpcs to support the
> > Auto-Negotiation       |              Clause 37 auto-negotiation
> >                        |
> >                        | Dependencies: This option is available in the
> >                        |   following configurations:
> >                        |   - SUPPORT_1G = Enabled
> >                        |   - MAIN_MODE = Backplane Ethernet PCS and
> >                        |     BACKPLANE_ETH_CONFIG = KX_Only or KX4_KX
> >                        |     or KR_KX or KR_KX4_KX mode
> >                        |
> >                        | Default Value: Enabled for configurations with
> >                        |   MAIN_MODE = 1000BASEX-Only PCS and Disabled
> >                        |   for all other configurations
> >                        |
> >                        | HDL Parameter Name: CL37_AN
> > 
> > So depending on the particular (vendor-specific) device configuration
> > the C37 AN might still unavailable even though the device supports the
> > 1000BASE-X and 2500BASE-X interfaces.
> 

> Thanks. I guess there's no way to read the CL37_AN setting from
> software?

I can't be 100% sure because my HW doesn't support neither
1000Base-X/SGMII nor C37 AN to test out what is described further, but
AFAICS from the HW manual it can be done by either on the next ways:

1. There is Vendor-Specific 1 MMD #30 (0x1e) which controls other MMDs
present in the device configuration. It exposes a register 0x0009 "SR
Control MMD Control Register" which aside with some stuff can be used
to switch on/off device MMDs including the MII MMD mapped to the
Vendor-Specific 2 MMD #31 (0x1f). Field 2 in that CSR is called
MII_MMD_EN and is available as RW only if "CL37_AN = Enabled"
otherwise it's RO and is supposed to contain the default value 0
(which is the case for my device).
Although further, in the MII MMD Standard Registers (SR) description,
HW-manual says that "The MII registers are present in 1000BASEX-Only
PCS configurations or configurations with 1G Support (1000BASE-X
support) and Clause 37 auto-negotiation support." It sounds vague and
from some point of view contradicting to what is said in the
MII_MMD_EN field description - whether C37 AN availability is required
to have the MII registers available.

2. If option 1 turns to be not working to detect the C37 AN
availability I guess it can be done by means of the 0x0001 CSR "SR MII
MMD Status Register" exposed in the MII MMD #31 (0x1f). It has AN_ABL
bit 3 "Auto-negotiation Ability". The bit description says that it's
RO and indicates: "1: The DWC_xpcs is able to perform
auto-negotiation." and "0: The DWC_xpcs is not able to perform
auto-negotiation." But it also says that "The DWC_xpcs always returns
this bit as 1.", which most likely implicitly confirms the option 1
described before. So in case if MII MMD #31 is available that flag
will be always 1, otherwise if MII MMD #31 is fully unavailable that
flag will return 0 despite to what is said in its description.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

