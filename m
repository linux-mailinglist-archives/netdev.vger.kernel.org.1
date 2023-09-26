Return-Path: <netdev+bounces-36275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB17AEBB0
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 3263F1C2048C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFCB26E2D;
	Tue, 26 Sep 2023 11:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA386569D
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:45:54 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581CDE
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QP2gWcM8bKGV7rRFCtnTK/DfPHrVS3kMN4EoUuhfj3s=; b=w7EXBMLKAXDiA/bCNNc76shYvM
	Yp2GFRmFW+tGbS13E7NisXK10uvHkYZhTg8NVyeQ0pmKYmFQ534WN51nrbkOC+N8ZLu+9O6Y86gGg
	t7ju+vyoWMkg0ruPnVJl/hjagFGGBEfAkfltCVQQDH8YKPy5UIHwBLIk0yN/nXBxEykb5CCKbcqVk
	C80NoX1qGzZfB8wDbCAxxNxtEfKx41Dup8P8U20zbKLPtT1xkHZ8HNsVFjHdAV3U7NphpWLT9dIkf
	rv1hv2JeO4QffT+ZJEpw2WQg3B0X8xYNtkOJLQrJjAtJlZE4XEWahYpPOOadjM2Ori1IVBSVG3hGj
	y1VGIBXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60482)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ql6Vf-0002NE-2o;
	Tue, 26 Sep 2023 12:45:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ql6Vf-0000NQ-7v; Tue, 26 Sep 2023 12:45:47 +0100
Date: Tue, 26 Sep 2023 12:45:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 02:39:21PM +0300, Serge Semin wrote:
> Hi Raju
> 
> On Mon, Sep 25, 2023 at 01:21:42PM +0530, Raju Lakkaraju wrote:
> > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > Update the port mode and autonegotiation
> > 
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> >  drivers/net/pcs/pcs-xpcs.c | 31 +++++++++++++++++++++++++++++++
> >  drivers/net/pcs/pcs-xpcs.h |  4 ++++
> >  2 files changed, 35 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 4dbc21f604f2..4f89dcedf0fc 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> > @@ -1090,6 +1090,30 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> >  	return 0;
> >  }
> >  
> > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > +				    struct phylink_link_state *state)
> > +{
> > +	int sts, lpa;
> > +
> > +	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> 
> > +	lpa = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_LP_BABL);
> > +	if (sts < 0 || lpa < 0) {
> > +		state->link = false;
> > +		return sts;
> > +	}
> 
> The HW manual says: "The host uses this page to know the link
> partner's ability when the base page is received through Clause 37
> auto-negotiation." Seeing xpcs_config_2500basex() disables
> auto-negotiation and lpa value is unused anyway why do you even need
> to read the LP_BABL register?

Since you have access to the hardware manual, what does it say about
clause 37 auto-negotiation when operating in 2500base-X mode?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

