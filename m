Return-Path: <netdev+bounces-231118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F5BF566A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 285AB3516A6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CB31DD85;
	Tue, 21 Oct 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mfCbNVAC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A5328B60;
	Tue, 21 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037446; cv=none; b=hImINQ/PX1OxC5kqzizh+TrNpP8+3FCm21Ckssr1KDiW+qJnq4kZFKo6mLCx/0jaGQG3pMevF1dfs2NTE8hToSsxJI8zjdVXbPAUNuWSIm0wKGOCxHDNotxR1Y2DpRu+GSPyKz/UjyiA2STfG92CShcRfaP1FqKWbsH5A7HnykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037446; c=relaxed/simple;
	bh=k5Buo0le6EqXUC/QN/g5Mt0ej2j7xhhd8+t9O1O2Png=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqBf6YJmevmKS7vFdrZCGhxVA6KsPfWcxHgzCAxrneix1G4D8n+42nx/7q0peRwwk6JjFIbMPgGYk4qk00vegxLmvJ9+nWCOHakuAFcWq+1vPQ2+6kuCm7YvIa/I7EYQIadjGbTVu/9RMDqrEMeXDfOLiWhWIY1sNji+NyJefjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mfCbNVAC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VSk3y2Mk5tvsRCRDhegaZJGDtEZ5KIaLNXeYF9q4FCs=; b=mfCbNVACWYLZeUU8wq34OFmldn
	sC4nEKCA2KivdMJn9v8HB1QudaCWpHUkIBU/t+1ig0eaMY4bl32KlpN5RmSWCpdRybkdB6CECGgfO
	xblkQ5paGdsAKuNqkLovVDx1diBFbmbavQG/PDfLgG9+r0l7fS65SRv15jDmqqSrUB+JZukPnLzGr
	J0KitZsqY3pIh81IVNWYKFvsxs5obKEheAcne8A4J6hqLjXehFw/Lud2vCow/ycSyJ+55pBTemwVI
	25Pz25DbgZpkVF/0DwCAbWSDpN1EU+hscanWWCG03IPVfUs6yE/vjaOCQ5vZw3zQei0Qlgzlr79EF
	8ooGeWow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vB8Hf-000000003Uk-1ylP;
	Tue, 21 Oct 2025 10:03:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vB8Hc-00000000847-2URk;
	Tue, 21 Oct 2025 10:03:56 +0100
Date: Tue, 21 Oct 2025 10:03:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
Message-ID: <aPdMfMlYMXHjvw_l@shell.armlinux.org.uk>
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
 <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
 <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
 <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 20, 2025 at 08:11:13PM +0200, Gerhard Engleder wrote:
> On 20.10.25 08:39, Horatiu Vultur wrote:
> > The 10/17/2025 23:15, Gerhard Engleder wrote:
> 
> ...
> 
> > > > 
> > > > +/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
> > > > + * some of them support PTP while others don't support it. This function will
> > > > + * return true is the sku supports it, otherwise will return false.
> > > > + */
> > > 
> > > Hasn't net also switched to the common kernel multiline comment style
> > > starting with an empty line?
> > 
> > I am not sure because I can see some previous commits where people used
> > the same comment style:
> > e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
> > 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
> 
> The special coding style for multi line comments for net and drivers/net has
> been removed with
> 82b8000c28 ("net: drop special comment style")
> 
> But I checked a few mails on the list and also found the old style in
> new patches.

I hope this means we aren't going to be flooded with loads of "cleanup"
patches converting the comment style.

I also think that the general rule of coding should still apply: keep to
the style that is already present in the file being modified - or if
you're intending to change style, one of the initial patches should do
that before one's own modifications (so the style remains consistent.)
Hopefully netdev maintainers will agree with this ^^^ :)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

