Return-Path: <netdev+bounces-36312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6D7AEE84
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E966B28155E
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6226E09;
	Tue, 26 Sep 2023 14:46:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B6266BA
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:46:31 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE6E6
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hmu/g01FVzZRJFkBit/YRRr4Q0IO9hiVE+7zWP268BM=; b=L8+7oR8m5zW8lcQZmKFfSQOzg5
	Jfc1qeYbvECuHsbah+o++6nsXqwvs4UJkxHJr/gHpWCQVwr78KptLjRYXKKQ2fftK3JE4dZgV0XZS
	TEdDfD0MVS/pPbsXPAaWA4knziZTouuvPV2TNpDlQEpnHL9DizEMU8KS21J4Q9gtdR6jFHON8TecH
	QH0Ce7IVch4xXw9uvxy7ajgXmtUnGchmD8sw+psbn5eM/WhDJq8XVhNPujDsh4s52I1+PxoNhG/1f
	SoGybYm+iS7PkBO5n8hfKed7jil5Ncd5pRabxxYdfRNn5KoF6VjWJSvIo1s0RkuGSFCc7TMysUJV0
	YPAXpaLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36334)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ql9KS-0002am-2V;
	Tue, 26 Sep 2023 15:46:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ql9KR-0000UU-KH; Tue, 26 Sep 2023 15:46:23 +0100
Date: Tue, 26 Sep 2023 15:46:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZRLuv77VSTXSZSc7@shell.armlinux.org.uk>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
 <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
 <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 03:09:47PM +0300, Serge Semin wrote:
> Hi Russell
> 
> On Tue, Sep 26, 2023 at 12:45:47PM +0100, Russell King (Oracle) wrote:
> > On Tue, Sep 26, 2023 at 02:39:21PM +0300, Serge Semin wrote:
> > > Hi Raju
> > > 
> > > On Mon, Sep 25, 2023 at 01:21:42PM +0530, Raju Lakkaraju wrote:
> > > > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > > > Update the port mode and autonegotiation
> > > > 
> > > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > > > ---
> > > >  drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
> > > >  drivers/net/pcs/pcs-xpcs.h |  4 ++++
> > > >  2 files changed, 35 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > > index 4dbc21f604f2..4f89dcedf0fc 100644
> > > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > > @@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > > > +				    struct phylink_link_state *state)
> > > > +{
> > > > +	int sts, lpa;
> > > > +
> > > > +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > > 
> > > > +	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
> > > > +	if (sts < 0 || lpa < 0) {
> > > > +		state->link = false;
> > > > +		return sts;
> > > > +	}
> > > 
> > > The HW manual says: "The host uses this page to know the link
> > > partner's ability when the base page is received through Clause 37
> > > auto-negotiation." Seeing xpcs_config_2500basex() disables
> > > auto-negotiation and lpa value is unused anyway why do you even need
> > > to read the LP_BABL register?
> > 
> 
> > Since you have access to the hardware manual, what does it say about
> > clause 37 auto-negotiation when operating in 2500base-X mode?
> 
> Here are the parts which mention 37 & SGMII AN in the 2.5G context:
> 
> 1. "Clause 37 (& SGMII) auto-negotiation is supported in 2.5G mode if
>     the link partner is also operating in the equivalent 2.5G mode."
> 
> 2. "During the Clause 37/SGMII as the auto-negotiation link timer
>     operates with a faster clock in the 2.5G mode, the timeout duration
>     reduces by a factor of 2.5. To restore the standard specified timeout
>     period, the respective registers must be re-programmed."
> 
> I guess the entire 2.5G-thing understanding could be generalized by
> the next sentence from the HW manual: "The 2.5G mode of operation is
> functionally the same as 1000BASE-X/KX mode, except that the
> clock-rate is 2.5 times the original rate. In this mode, the
> Serdes/PHY operates at a serial baud-rate of 3.125 Gbps and DWC_xpcs
> data-path and the GMII interface to MAC operates at 312.5 MHz (instead
> of 125 MHz)." Thus here is another info regarding AN in that context:
> 
> 3. "The DWC_xpcs operates either in 10/100/1000Mbps rate or
> 25/250/2500Mbps rates respectively with SGMII auto-negotiation. The
> DWC_xpcs cannot support switching or negotiation between 1G and 2.5G
> rates using auto-negotiation."

Thanks for the clarification.

So this hardware, just like Marvell hardware, operates 2500BASE-X merely
by up-clocking, and all the features that were available at 1000BASE-X
are also available at 2500BASE-X, including the in-band signalling.

Therefore, I think rather than disabling AN outright, the
PHYLINK_PCS_NEG_* mode passed in should be checked to determine whether
inband should be used or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

