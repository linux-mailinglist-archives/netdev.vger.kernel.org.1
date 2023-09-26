Return-Path: <netdev+bounces-36291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929667AEC2C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 40DC8281626
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E520273F6;
	Tue, 26 Sep 2023 12:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E07107B9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 12:09:53 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0656EB
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 05:09:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c012232792so146764371fa.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695730190; x=1696334990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GKgszZtN3P50Dp8VaZAYZUAl1lrWBw1x/OPcHu3sLo=;
        b=WQClluey9oUKgKbTl//ZCnU5kEdFrXYqqRgQioG+jij6F4ogCUFqWOfIj+M8RAiok+
         ogUK60RCFTTGzRgHnRCPcWpbGP9upTWNp9iMuQHmpt9LpjBuIop+icOu1dASz7RErq/b
         k/xqbSjDR5k1BYRE0a3Y6Qv7fd4DvJAEUqnjU0SHXy8cEyWEaxuDhzzu8uGmSdR4RNvO
         6Hi6FaZdNaQ7+2+BaVXVVjjChoUVM7N1RBLuRVuLTG0FWOK1HOh/qn5ADYjnBD5aKKLN
         Z7h3RkaiQkphD0A4wx8/6DzzH3oqUxfx3zJP3popAX9BXAwBd/EN7o0nyZ16CmYgYA7v
         ybzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695730190; x=1696334990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GKgszZtN3P50Dp8VaZAYZUAl1lrWBw1x/OPcHu3sLo=;
        b=oIbi+mT6KuLDPilXV+dcEUcsIrbGjVWPi63eCFBku3ar5Y1pYEfe5sXhN/Q9XsXYUQ
         Iqp7zw+qjv8FUPQ997zJ5CkwL4dxHYYdf32U6HbnMR8IdNR0zoxUjhszhA6WubvtunVe
         oL3i0v70sUChRqh7oE3x41rUkAkz+RHR/uJ4qWfTqa1yViwG2cvn81aLSRd89cpb91EH
         /aRIM5FFphuTEfMfQ0jY6iJOFz3xALXDGRGEMtedQrAHKhyQc8mK3ko9lBZ9LO2KyP51
         W9ecqtqSAQ9OPyYUXbpq1ivYUOwCIV8gnRu86G9B91VbecdRSJBQRvWhwyR4ft04Ocrm
         nUWA==
X-Gm-Message-State: AOJu0YzKlKVeu7D+NScwWaB782gH6R4eguENaU9hZcwbnQehhTJl+sfj
	YAFvKjIdNdEsKukxf63SKqI=
X-Google-Smtp-Source: AGHT+IHwLTJybw8tOMn7xAzMEPpoKUZR/sIqPsxSX2svpGLRfWH94jgwHuzUY+oVsL3O9I+KFE8krA==
X-Received: by 2002:a2e:97c3:0:b0:2b9:ed84:b2bf with SMTP id m3-20020a2e97c3000000b002b9ed84b2bfmr8651641ljj.33.1695730189877;
        Tue, 26 Sep 2023 05:09:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e9d0c000000b002bfb71c076asm2596086lji.43.2023.09.26.05.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:09:49 -0700 (PDT)
Date: Tue, 26 Sep 2023 15:09:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com, 
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
 <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell

On Tue, Sep 26, 2023 at 12:45:47PM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 26, 2023 at 02:39:21PM +0300, Serge Semin wrote:
> > Hi Raju
> > 
> > On Mon, Sep 25, 2023 at 01:21:42PM +0530, Raju Lakkaraju wrote:
> > > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > > Update the port mode and autonegotiation
> > > 
> > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > > ---
> > >  drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
> > >  drivers/net/pcs/pcs-xpcs.h |  4 ++++
> > >  2 files changed, 35 insertions(+)
> > > 
> > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > index 4dbc21f604f2..4f89dcedf0fc 100644
> > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > @@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > >  	return 0;
> > >  }
> > >  
> > > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > > +				    struct phylink_link_state *state)
> > > +{
> > > +	int sts, lpa;
> > > +
> > > +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > 
> > > +	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
> > > +	if (sts < 0 || lpa < 0) {
> > > +		state->link = false;
> > > +		return sts;
> > > +	}
> > 
> > The HW manual says: "The host uses this page to know the link
> > partner's ability when the base page is received through Clause 37
> > auto-negotiation." Seeing xpcs_config_2500basex() disables
> > auto-negotiation and lpa value is unused anyway why do you even need
> > to read the LP_BABL register?
> 

> Since you have access to the hardware manual, what does it say about
> clause 37 auto-negotiation when operating in 2500base-X mode?

Here are the parts which mention 37 & SGMII AN in the 2.5G context:

1. "Clause 37 (& SGMII) auto-negotiation is supported in 2.5G mode if
    the link partner is also operating in the equivalent 2.5G mode."

2. "During the Clause 37/SGMII as the auto-negotiation link timer
    operates with a faster clock in the 2.5G mode, the timeout duration
    reduces by a factor of 2.5. To restore the standard specified timeout
    period, the respective registers must be re-programmed."

I guess the entire 2.5G-thing understanding could be generalized by
the next sentence from the HW manual: "The 2.5G mode of operation is
functionally the same as 1000BASE-X/KX mode, except that the
clock-rate is 2.5 times the original rate. In this mode, the
Serdes/PHY operates at a serial baud-rate of 3.125 Gbps and DWC_xpcs
data-path and the GMII interface to MAC operates at 312.5 MHz (instead
of 125 MHz)." Thus here is another info regarding AN in that context:

3. "The DWC_xpcs operates either in 10/100/1000Mbps rate or
25/250/2500Mbps rates respectively with SGMII auto-negotiation. The
DWC_xpcs cannot support switching or negotiation between 1G and 2.5G
rates using auto-negotiation."

-Serge(y)

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

