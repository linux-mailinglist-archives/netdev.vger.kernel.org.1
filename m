Return-Path: <netdev+bounces-135195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89699CB7F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67B11F21C76
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32BA1A726B;
	Mon, 14 Oct 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIdTn5bq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298144A3E;
	Mon, 14 Oct 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912148; cv=none; b=QsCqpHl3v1vEkTfsm6LlHv2YjKas3JlCW/0fI5t4FJlpD+bQI8mI5Y6zupFwthdZTpN5iDJgzQgLAfw+cvGNbQPRy+QdSfZydU5X1uRvIV5yfGGOxGWljXL2ZQk4g55B2F1pvdClISLxeZJT/mPltxMcG7JvKzhOciuvNjGU1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912148; c=relaxed/simple;
	bh=feqJ70DmJ2H3ePXvPbCOLKSz9tHkhUPaXDX02tFCN0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBAkADcx20leG33qiEx5wtNVWPUVxN+xhz2ZOOxUbKt725rNE7lSzChpMwQh4LKzE0No7Rd0rc4EvTLGxIkf/6py1ecVsQCFnXyahrEk2KkyvmlqutaT47Ag5KfYsm38wyQEIMGP9ycHrs1pD/zP2dHtUadJc9eVCnoXz0od1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIdTn5bq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9i0GmyStiYse6NHTKKq1pGmahkzhq31504Qqrm1csDU=; b=qIdTn5bqH5Qe6afQZSxu2BtIbk
	hHep3vL5Z3qs6jS5/i/17/ogiKyGm6cjsQU3vu/GFSODid10FW8FXGT3RQ4jIB9du45fkMy6Ed0hE
	NX3xiW0dhDYOz2p/x4qhBvQn/M5ZYSgTohm/YOeMT85wVnqdZ5+e9TpQIZIE5AGP2lHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0L1b-009vVd-NB; Mon, 14 Oct 2024 15:22:15 +0200
Date: Mon, 14 Oct 2024 15:22:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbbmV0?= =?utf-8?Q?=5D?= net: ftgmac100:
 corrcet the phy interface of NC-SI mode
Message-ID: <44575610-70e1-48cf-ac19-3edef0b7a58f@lunn.ch>
References: <20241011082827.2205979-1-jacky_chou@aspeedtech.com>
 <e22bf47d-db22-4659-8246-619aafe1ba43@lunn.ch>
 <SEYPR06MB51349C634A15F932ED0ECF4F9D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB51349C634A15F932ED0ECF4F9D442@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Mon, Oct 14, 2024 at 02:23:40AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thanks for the review.
> 
> > > In NC-SI specification, NC-SI is using RMII, not MII.
> > >
> > > Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for
> > > NC-SI")
> > > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > > ---
> > >  drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > index ae0235a7a74e..85fea13b2879 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -1913,7 +1913,7 @@ static int ftgmac100_probe(struct platform_device
> > *pdev)
> > >  			goto err_phy_connect;
> > >  		}
> > >  		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> > > -					 PHY_INTERFACE_MODE_MII);
> > > +					 PHY_INTERFACE_MODE_RMII);
> > >  		if (err) {
> > >  			dev_err(&pdev->dev, "Connecting PHY failed\n");
> > >  			goto err_phy_connect;
> > 
> > I'm a but confused here. Please could you expand the commit message. When i
> > look at the code:
> > 
> > 		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
> > 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> > 					 PHY_INTERFACE_MODE_MII);
> > 		if (err) {
> > 			dev_err(&pdev->dev, "Connecting PHY failed\n");
> > 			goto err_phy_connect;
> > 		}
> > 
> > The phy being connected to is a fixed PHY. So the interface mode should not
> > matter, at least to the PHY, since there is no physical PHY. Does the MAC driver
> > get this value returned to it, e.g. as part of ftgmac100_adjust_link, and the
> > MAC then configures itself into the wrong interface mode?
> > 
> > For a patch with a Fixes: it is good to describe the problem the user sees.
> 
> Although it is connected to a fixed PHY and do not care what interface mode is, 
> the driver still configures the correct interface.
> 
> In the ftgmac100 driver, the MAC driver does not actually need to know the interface mode 
> connecting the MAC and PHY.
> The driver just needs to get some information from the PHY, like speed, duplex and so on, to 
> configure the MAC.
> 
> Perhaps it is not matter on PHY interface to MAC, it should correct to the correct interface mode 
> for code.

So nothing is actually broken which a user would notice. So please
drop the Fixes: tag, and submit this for net-next.

     Andrew

