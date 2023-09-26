Return-Path: <netdev+bounces-36314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2B7AEFA9
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5392D1C20401
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CC30CF0;
	Tue, 26 Sep 2023 15:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3077479
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 15:27:53 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E667126
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:27:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bfea381255so153474771fa.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695742070; x=1696346870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMpGs/dLuRD4zVILOfJj2TzXTagNsvVw9RKJSCXm0Ro=;
        b=UFWyd7TFERBbIv9S9gZ8BJXQaEPHbX+tyHFe26BM1NmRYE0ovCN+uffC9fvAjuX2OW
         oVwuHIF9qw8OWznPL7rlWx1X8HX4yrUTwRZEqRRy17q9Xtnzme31KgJ8PDgVZrWq2ySQ
         4NXBxzzj5SZxaMFu3TndduLk/JSgbAc+cBBWsWG292O1E/wxs9AC7uyXxyUpltiBbZcv
         pjZhX/celPwpIVVw+IvGOrb5tMqRc93eJWQfE67QYOKeZozZ+9AN2G0+HpCeov8F6tJf
         BxqlXAllPXC342JinKuBQLbqCpPNg6T8FZnW/QQa76Ht1UUpO8f1NxnCMDDi7Fs3BFl1
         1cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695742070; x=1696346870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMpGs/dLuRD4zVILOfJj2TzXTagNsvVw9RKJSCXm0Ro=;
        b=ET1hdbkgrIOEwSAFjFMSL2Km2uaxTzpdiiiaKquojmo6CKvsga2KD+sbYHkqHW9clN
         tIrBYe1Jix2j6qxCTF8gL1BnJacmAUYO6mwFcf70Hak0/Z1eUkQdQBwLce0oyiJCuspi
         v28QS3N++NPyGQdeierzlt1iEe9FFB5UyqJcQxKaTeR6/ZA4Z2Al3ERr9wiAKeE7OluZ
         UedrvdfFrID67PjMswwNkmj7F6Y7DikTl+9uruFUaMTpiyhoNWE7wRNo2AAXHMG6hytZ
         GcdU/CWKw7HtYLkyP3T77AODaTtaryABZvDXGfVaNH9ziUX4i+lTPFXEvrshPo5ujY1A
         M4zQ==
X-Gm-Message-State: AOJu0Yyc+MkF/Wy+nSAZ8U1KfsA5nQMk1DdPXY09xbgapzXL5zJZIW6d
	F6sT3Y2/LLrH2B5Pgfn9j3FcaTJ+EWrgjw==
X-Google-Smtp-Source: AGHT+IFwcBqwqC/IROy76v0sgwz3IIiai7lTcONwPoF4czUALPLu+SX8X4do686u7iwCnE4S7bdTlQ==
X-Received: by 2002:a05:6512:239f:b0:502:a0e9:8820 with SMTP id c31-20020a056512239f00b00502a0e98820mr10175267lfv.47.1695742069349;
        Tue, 26 Sep 2023 08:27:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651238cf00b005009b4d5c14sm2207796lft.265.2023.09.26.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:27:48 -0700 (PDT)
Date: Tue, 26 Sep 2023 18:27:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com, 
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <rbavthifczzgwxmgtb4hbv6hnqb57timfzvbizscdtxz62ookg@bgrwergjyulb>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
 <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
 <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
 <ZRLuv77VSTXSZSc7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLuv77VSTXSZSc7@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 03:46:23PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 26, 2023 at 03:09:47PM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > On Tue, Sep 26, 2023 at 12:45:47PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Sep 26, 2023 at 02:39:21PM +0300, Serge Semin wrote:
> > > > Hi Raju
> > > > 
> > > > On Mon, Sep 25, 2023 at 01:21:42PM +0530, Raju Lakkaraju wrote:
> > > > > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > > > > Update the port mode and autonegotiation
> > > > > 
> > > > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > > > > ---
> > > > >  drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
> > > > >  drivers/net/pcs/pcs-xpcs.h |  4 ++++
> > > > >  2 files changed, 35 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > > > index 4dbc21f604f2..4f89dcedf0fc 100644
> > > > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > > > @@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > > > > +				    struct phylink_link_state *state)
> > > > > +{
> > > > > +	int sts, lpa;
> > > > > +
> > > > > +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > > > 
> > > > > +	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
> > > > > +	if (sts < 0 || lpa < 0) {
> > > > > +		state->link = false;
> > > > > +		return sts;
> > > > > +	}
> > > > 
> > > > The HW manual says: "The host uses this page to know the link
> > > > partner's ability when the base page is received through Clause 37
> > > > auto-negotiation." Seeing xpcs_config_2500basex() disables
> > > > auto-negotiation and lpa value is unused anyway why do you even need
> > > > to read the LP_BABL register?
> > > 
> > 
> > > Since you have access to the hardware manual, what does it say about
> > > clause 37 auto-negotiation when operating in 2500base-X mode?
> > 
> > Here are the parts which mention 37 & SGMII AN in the 2.5G context:
> > 
> > 1. "Clause 37 (& SGMII) auto-negotiation is supported in 2.5G mode if
> >     the link partner is also operating in the equivalent 2.5G mode."
> > 
> > 2. "During the Clause 37/SGMII as the auto-negotiation link timer
> >     operates with a faster clock in the 2.5G mode, the timeout duration
> >     reduces by a factor of 2.5. To restore the standard specified timeout
> >     period, the respective registers must be re-programmed."
> > 
> > I guess the entire 2.5G-thing understanding could be generalized by
> > the next sentence from the HW manual: "The 2.5G mode of operation is
> > functionally the same as 1000BASE-X/KX mode, except that the
> > clock-rate is 2.5 times the original rate. In this mode, the
> > Serdes/PHY operates at a serial baud-rate of 3.125 Gbps and DWC_xpcs
> > data-path and the GMII interface to MAC operates at 312.5 MHz (instead
> > of 125 MHz)." Thus here is another info regarding AN in that context:
> > 
> > 3. "The DWC_xpcs operates either in 10/100/1000Mbps rate or
> > 25/250/2500Mbps rates respectively with SGMII auto-negotiation. The
> > DWC_xpcs cannot support switching or negotiation between 1G and 2.5G
> > rates using auto-negotiation."
> 
> Thanks for the clarification.
> 
> So this hardware, just like Marvell hardware, operates 2500BASE-X merely
> by up-clocking, and all the features that were available at 1000BASE-X
> are also available at 2500BASE-X, including the in-band signalling.
> 
> Therefore, I think rather than disabling AN outright, the
> PHYLINK_PCS_NEG_* mode passed in should be checked to determine whether
> inband should be used or not.

Just an additional note which might be relevant in the context of the
DW XPCS 1G/2.5G C37 AN. The C37 auto-negotiation feature will be
unavailable for 1000BASE-X and thus for 2500BASE-X if the IP-core is
synthesized with no support of one. It is determined by the CL37_AN
IP-core synthesize parameter state:

Enable SGMII Clause 37 | Description: Configures DWC_xpcs to support the
Auto-Negotiation       |              Clause 37 auto-negotiation
                       |
                       | Dependencies: This option is available in the
                       |   following configurations:
                       |   - SUPPORT_1G = Enabled
                       |   - MAIN_MODE = Backplane Ethernet PCS and
                       |     BACKPLANE_ETH_CONFIG = KX_Only or KX4_KX
                       |     or KR_KX or KR_KX4_KX mode
                       |
                       | Default Value: Enabled for configurations with
                       |   MAIN_MODE = 1000BASEX-Only PCS and Disabled
                       |   for all other configurations
                       |
                       | HDL Parameter Name: CL37_AN

So depending on the particular (vendor-specific) device configuration
the C37 AN might still unavailable even though the device supports the
1000BASE-X and 2500BASE-X interfaces.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

