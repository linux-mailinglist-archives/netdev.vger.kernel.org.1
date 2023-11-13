Return-Path: <netdev+bounces-47386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510F7E9FA6
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210BB2808B5
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FA2111C;
	Mon, 13 Nov 2023 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="acAo3sDo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51620B0B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:56 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6578D4D;
	Mon, 13 Nov 2023 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w4r5n2YqKwauxZPkYNoZPayUyNIvFJwhaBbPRnMiHSQ=; b=acAo3sDoL80OLCoV909kPkt5Bb
	FsNsxjkQ0XFnFXJu/C3H8BVGpxrotPuy8Jg1qu53i8XTndswh6l4qOd6jHzcG5iekh7EnlXKhFurR
	v6yUXWu/+pbjo9cIrRM/BrANDs2YXzEDUTOTEWFru/LCr3trrx+o8tDZM9G+hdV693vt7u0uYeNiw
	uuo826RcqTdDckXLsJKQ9pAEZsQRhwSmPARdCxn6TTRS+zUCHfdvhR7FRDvPI4tO9j8AHvfOHkfhR
	bDmbl+rtZvYJkCA40BXRBPWcEpJo2RSvOmbmVUcH6NvW/vx5+Faefh5AZQIfrZ/7PdtYAreU7xjhg
	MOrhUrSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r2YbI-0006lR-0c;
	Mon, 13 Nov 2023 15:11:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r2YbI-0004dQ-51; Mon, 13 Nov 2023 15:11:44 +0000
Date: Mon, 13 Nov 2023 15:11:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jie Luo <quic_luoj@quicinc.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVI8sOTEKITeHPc+@shell.armlinux.org.uk>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <20231110101841.27aba547@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110101841.27aba547@fedora>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 10, 2023 at 10:18:41AM +0100, Maxime Chevallier wrote:
> On Fri, 10 Nov 2023 16:53:39 +0800
> Jie Luo <quic_luoj@quicinc.com> wrote:
> 
> > On 11/9/2023 5:16 PM, Maxime Chevallier wrote:
> > > Hello,
> > > 
> > > On Thu, 9 Nov 2023 16:32:36 +0800
> > > Jie Luo <quic_luoj@quicinc.com> wrote:
> > > 
> > > [...]
> > >   
> > >>> What I understand from this is that this PHY can be used either as a
> > >>> switch, in which case port 4 would be connected to the host interface
> > >>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> > >>> speed would be limited to 1G per-port, is that correct ?  
> > >>
> > >> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> > >> PHYs can support to the max link speed 2.5G, actually the PHY can
> > >> support to max link speed 2.5G for all supported interface modes
> > >> including qusgmii and sgmii.  
> > > 
> > > I'm a bit confused then, as the USGMII spec says that Quad USGMII really
> > > is for quad 10/100/1000 speeds, using 10b/8b encoding.
> > > 
> > > Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> > >   with 66b/64b encoding ?
> > > 
> > > Thanks,
> > > 
> > > Maxime  
> > 
> > Hi Maxime,
> > Yes, for quad PHY mode, it is using 66b/64 encoding.
> > 
> > it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> > so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> > quad PHYs here.
> 
> I see, when I added the QUSGMII mode I wrongly stated that it came from
> the USXGMII spec where it really comes from USGMII, my bad.
> 
> > can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> > case(qca8084 quad PHY mode)?
> 
> From what I can see, the USXGMII mode in the kernel is used as the
> single-port 10G mode of usxgmii. You might need to create a new mode
> for quad usxgmii at 10G, the spec calls it 10G-QXGMII I think, but as
> the spec defines quite a lot of modes, should we define all of them or
> rely on some other parameters to select the actual mode ?
> 
> Andrew, Heiner, Russell, what do you think ?

Looking at the Cisco USXGMII Multiport Copper Interface specification,
you appear to be correct with the "10G-QXGMII" name. I note that it is
also specified that "System Interface operates in full duplex mode
only." and makes no other significant mention of duplex, so it's not
clear whether half duplex is supported on the media side.

Figure 2 in this document is the significant one that we need to
consider, as we're talking about N network interfaces connecting to a
system interface that then connects to a PHY with multiple ports.

Given our model, I think it's quite right to use "10G-QXGMII" because
that describes the protocol over the system interface that will be
used. However, we need to consider whether this is the only information
we need, or whether we need to also be thinking about expanding the
"pcs" property to something such as:

	pcs = <&usxgmiim_pcs PORT>;

where PORT is the port number on the USXGMII PHY as described by figure
2. It seems to me that a driver for this USXGMII PHY would need to know
the port information that a network interface is connected to.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

