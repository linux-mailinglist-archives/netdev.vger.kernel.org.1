Return-Path: <netdev+bounces-36315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23C7AEFF6
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CA7FE2814EE
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66B30D06;
	Tue, 26 Sep 2023 15:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180D30D03
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 15:47:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E71B3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dKieqyHLVmbPlA5ShK1WouVOc3ccxmB1XKlRT4o3G6E=; b=1n5GGsmQWeokFpr2FwHGp2QMeM
	TIajbMVs0haf9T0HEN4Hd0Vp+NZdLMhlQ1QbC/l5Z+jCwU9RDgIgEL9/pflMfevxlUqCaGJ1RJmcD
	wKdxtFwJ4GOCRApbU+fjKh0WAU/lHTUDgqP+Hi2xhv2yEEQ8IzXy4a1tDe+kDMB1JOq1a3lXmDCiH
	fZXlOfKbTTnacoMDI+CVkLcJZJVBXZTvu5PqhidHjYAWgZWhUzkS+Y23zvXFl92AmYS2lKe+e1Ybu
	LLOJJaMNV+9DvDjHYnYUUmmgHgHny9Tk3sIj6qYmO27Zt9kn4onVtcsWLVKDdhk05ZFcqlOIpqMNu
	e+N49kxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qlAHL-0002eC-38;
	Tue, 26 Sep 2023 16:47:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qlAHL-0000X6-1K; Tue, 26 Sep 2023 16:47:15 +0100
Date: Tue, 26 Sep 2023 16:47:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
	davem@davemloft.net, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZRL9AoHpiUJRFJRc@shell.armlinux.org.uk>
References: <20230925075142.266026-1-Raju.Lakkaraju@microchip.com>
 <fbkzmsznag5yjypbzmbmvtzfgdgx3v4pc6njmelrz3x7pvlojq@rh3tqyo5sr26>
 <ZRLEazyb0yS1Oxft@shell.armlinux.org.uk>
 <jhmdppifw4qverxedn6l3bk3tuwyuww7rcvqvtzbxhh5livowv@3jpc4m3kfgno>
 <ZRLuv77VSTXSZSc7@shell.armlinux.org.uk>
 <rbavthifczzgwxmgtb4hbv6hnqb57timfzvbizscdtxz62ookg@bgrwergjyulb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rbavthifczzgwxmgtb4hbv6hnqb57timfzvbizscdtxz62ookg@bgrwergjyulb>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 06:27:45PM +0300, Serge Semin wrote:
> On Tue, Sep 26, 2023 at 03:46:23PM +0100, Russell King (Oracle) wrote:
> > On Tue, Sep 26, 2023 at 03:09:47PM +0300, Serge Semin wrote:
> > > Hi Russell
> > > 
> > > > Since you have access to the hardware manual, what does it say about
> > > > clause 37 auto-negotiation when operating in 2500base-X mode?
> > > 
> > > Here are the parts which mention 37 & SGMII AN in the 2.5G context:
> > > 
> > > 1. "Clause 37 (& SGMII) auto-negotiation is supported in 2.5G mode if
> > >     the link partner is also operating in the equivalent 2.5G mode."
> > > 
> > > 2. "During the Clause 37/SGMII as the auto-negotiation link timer
> > >     operates with a faster clock in the 2.5G mode, the timeout duration
> > >     reduces by a factor of 2.5. To restore the standard specified timeout
> > >     period, the respective registers must be re-programmed."
> > > 
> > > I guess the entire 2.5G-thing understanding could be generalized by
> > > the next sentence from the HW manual: "The 2.5G mode of operation is
> > > functionally the same as 1000BASE-X/KX mode, except that the
> > > clock-rate is 2.5 times the original rate. In this mode, the
> > > Serdes/PHY operates at a serial baud-rate of 3.125 Gbps and DWC_xpcs
> > > data-path and the GMII interface to MAC operates at 312.5 MHz (instead
> > > of 125 MHz)." Thus here is another info regarding AN in that context:
> > > 
> > > 3. "The DWC_xpcs operates either in 10/100/1000Mbps rate or
> > > 25/250/2500Mbps rates respectively with SGMII auto-negotiation. The
> > > DWC_xpcs cannot support switching or negotiation between 1G and 2.5G
> > > rates using auto-negotiation."
> > 
> > Thanks for the clarification.
> > 
> > So this hardware, just like Marvell hardware, operates 2500BASE-X merely
> > by up-clocking, and all the features that were available at 1000BASE-X
> > are also available at 2500BASE-X, including the in-band signalling.
> > 
> > Therefore, I think rather than disabling AN outright, the
> > PHYLINK_PCS_NEG_* mode passed in should be checked to determine whether
> > inband should be used or not.
> 
> Just an additional note which might be relevant in the context of the
> DW XPCS 1G/2.5G C37 AN. The C37 auto-negotiation feature will be
> unavailable for 1000BASE-X and thus for 2500BASE-X if the IP-core is
> synthesized with no support of one. It is determined by the CL37_AN
> IP-core synthesize parameter state:
> 
> Enable SGMII Clause 37 | Description: Configures DWC_xpcs to support the
> Auto-Negotiation       |              Clause 37 auto-negotiation
>                        |
>                        | Dependencies: This option is available in the
>                        |   following configurations:
>                        |   - SUPPORT_1G = Enabled
>                        |   - MAIN_MODE = Backplane Ethernet PCS and
>                        |     BACKPLANE_ETH_CONFIG = KX_Only or KX4_KX
>                        |     or KR_KX or KR_KX4_KX mode
>                        |
>                        | Default Value: Enabled for configurations with
>                        |   MAIN_MODE = 1000BASEX-Only PCS and Disabled
>                        |   for all other configurations
>                        |
>                        | HDL Parameter Name: CL37_AN
> 
> So depending on the particular (vendor-specific) device configuration
> the C37 AN might still unavailable even though the device supports the
> 1000BASE-X and 2500BASE-X interfaces.

Thanks. I guess there's no way to read the CL37_AN setting from
software?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

