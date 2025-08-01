Return-Path: <netdev+bounces-211345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A1B181B1
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679943A701D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB13823BCE3;
	Fri,  1 Aug 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xY8VHEA9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98D2101AE;
	Fri,  1 Aug 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051034; cv=none; b=eojC9DCTKaPK/BvwE79o4lLOTTdc+EeXXWfeyMd3eZrbALb3xvySjjpeO8xiVAJdinUJNg/BEUAno2M72Z4vIBuwvR0NJW2Va87sb0s5JS+SnBJeFSbR7irfI6+R5ktdIQTzz0JiK+XN3Vg25PYskNt9XVwUgQ56MxC/FpU/x4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051034; c=relaxed/simple;
	bh=CWvcMqa6oMk48bltjFUdn2fKq7+eTYiGMbDizThyiMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlgBEI3/4MdQaIVeBZ/Tx8JNJCFwTQ5LT2jz/ensGV78Tx6QTdsvZIMJ6x8kPfSWVMDoFTg2ao2Dk5E8eUevS6xeX/j0qps43U4BlI04XgR+d4yOX9T8RdHL9e7PD+Vdd4bJwJJG070SCG7IB8/HNt8AEiWuu1EC+m68BtVRFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xY8VHEA9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5mGIkPPiW2JIXV9beKpoIxADX0T2OywUXqfMMiZLLrE=; b=xY8VHEA9z7CY1yoxzOBJBUJ8q3
	Oxvs2h/ywY5EWROCAD75R1SSJ7O7Yr/0H/HqKRJKSlIEPZX+hpdWGFrP2F9msDTcBB2fOA2kdgz0z
	E2dnvrCBIFBF3X3tqrJNNZeRaGTR6I0ZSDlnKz2m1yabrIGp+/mfs/JakCLdsfnuyoPxuJaCLvuB1
	a48nyNEFP4nOIsssfRLZu+OITCRVvOz9Q0Loiayv1tS7ewVSuGIt7WqQ3CbVRKDGWWadCe+Mlothl
	juozjdoe6nPNF+7XPpsoQbq7kyKCWacsPXghpZ7sYrn4JDCLkOIRN4IPhpeVUxxhP6Cripy8tWrVy
	gXlaeArQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59144)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhonb-0006Sr-0k;
	Fri, 01 Aug 2025 13:23:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhonY-00023s-2y;
	Fri, 01 Aug 2025 13:23:44 +0100
Date: Fri, 1 Aug 2025 13:23:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 02:06:16PM +0200, Alexander Wilhelm wrote:
> Am Fri, Aug 01, 2025 at 12:58:23PM +0100 schrieb Russell King (Oracle):
> > On Fri, Aug 01, 2025 at 01:54:29PM +0200, Alexander Wilhelm wrote:
> > > Am Fri, Aug 01, 2025 at 02:01:06PM +0300 schrieb Vladimir Oltean:
> > > > On Thu, Jul 31, 2025 at 08:26:43PM +0100, Russell King (Oracle) wrote:
> > > > > and this works. So... we could actually reconfigure the PHY independent
> > > > > of what was programmed into the firmware.
> > > > 
> > > > It does work indeed, the trouble will be adding this code to the common
> > > > mainline kernel driver and then watching various boards break after their
> > > > known-good firmware provisioning was overwritten, from a source of unknown
> > > > applicability to their system.
> > > 
> > > You're right. I've now selected a firmware that uses a different provisioning
> > > table, which already configures the PHY for 2500BASE-X with Flow Control.
> > > According to the documentation, it should support all modes: 10M, 100M, 1G, and
> > > 2.5G.
> > > 
> > > It seems the issue lies with the MAC, as it doesn't appear to handle the
> > > configured PHY_INTERFACE_MODE_2500BASEX correctly. I'm currently investigating
> > > this further.
> > 
> > Which MAC driver, and is it using phylink?
> 
> If I understand it correclty, then yes. It is an Freescale FMAN driver that is
> called through phylink callbacks like the following:
> 
>     static const struct phylink_mac_ops memac_mac_ops = {
>             .validate = memac_validate,
>             .mac_select_pcs = memac_select_pcs,
>             .mac_prepare = memac_prepare,
>             .mac_config = memac_mac_config,
>             .mac_link_up = memac_link_up,
>             .mac_link_down = memac_link_down,
>     };

Thanks.

It looks like memac_select_pcs() and memac_prepare() fail to
handle 2500BASEX despite memac_initialization() suggesting the
SGMII PCS supports 2500BASEX.

It would also be good if the driver can also use
pcs->supported_interfaces which states which modes the PCS layer
supports as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

