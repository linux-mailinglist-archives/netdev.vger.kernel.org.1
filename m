Return-Path: <netdev+bounces-108470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB24923EC9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247AC28811D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403F1AD9E7;
	Tue,  2 Jul 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mngtAgeM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3B19D085;
	Tue,  2 Jul 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926488; cv=none; b=J8dtcNHmCII19AkbBLmAxwO11BsX3HkwL3rMwxAc+3hd5nXo7IkvZKNIUjs5FPJBoIfADM6BnoWQONkgzIzskxfdXZ3XsHVTWGEkt4KEb+au3nSjwRvCIZ2k8OTcR5P2ZzG18/R/JINYZ23mGhlc/XmJnba2v5dBRWt+3mqNSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926488; c=relaxed/simple;
	bh=Z3TpF0Wkv2GL991OM6qpoiwzwswLje71quWBU6oLG3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9Ii9+kHYlWmmX1oXF4glUD7Ky9Ip832Je65/pcgSwlXdW99vlIDxVTg9pk+wwIskL8QresWQsY/EgWrOjjZd3OtXwNlM3jCTmAH1ndUlupXCfLbj3QJltpue7cZI2anJo4YEaU+oMBCQ/AFhF4X9u97zdiFDikINbA9eoOgrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mngtAgeM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1xDsfm4Y/LtLrp+GL7JQi0vWoAc+ybfwPXxT0wl27Xk=; b=mngtAgeMXcJNnpYXVeeTnCyuVB
	pPqaFnVSAxLtDRGbMM3OtAxJqnbOkoD9/KaFucFQiFEe6KTOoj7H1qeuoRM+XeAOjCHK365Z8UJTN
	TTFbYD3II9bsjPfNNEw76a5HRU0mZqIlTRX93FpIzJxhSFFwVCsej5echVpUZNpLSYLk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOdRV-001dhr-Dq; Tue, 02 Jul 2024 15:21:09 +0200
Date: Tue, 2 Jul 2024 15:21:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP modules
Message-ID: <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
 <f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
 <2273795.iZASKD2KPV@fw-rgant>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2273795.iZASKD2KPV@fw-rgant>

On Tue, Jul 02, 2024 at 10:11:07AM +0200, Romain Gantois wrote:
> Hello Andrew, thanks for the review!
> 
> I think this particular patch warrants that I explain myself a bit more.
> 
> Some SGMII SFP modules will work fine once they're inserted and the appropriate 
> probe() function has been called by the SFP PHY driver. However, this is not 
> necessarily the case, as some SFP PHYs require further configuration before the 
> link can be brought up (e.g. calling phy_init_hw() on them which will 
> eventually call things like config_init()).
> 
> This configuration usually doesn't happen before the PHY device is attached to 
> a network device. In this case, the DP83869 PHY is placed between the MAC and 
> the SFP PHY. Thus, the DP83869 is attached to a network device while the SFP 
> PHY is not. This means that the DP83869 driver basically takes on the role of 
> the MAC driver in some aspects.
> 
> In this patch, I used the connect_phy() callback as a way to get a handle to 
> the downstream SFP PHY. This callback is only implemented by phylink so far.
> 
> I used the module_start() callback to initialize the SFP PHY hardware and 
> start it's state machine.

The SFP PHY is however a PHY which phylib is managing. And you have
phylink on top of that, which knows about both PHYs. Architecturally,
i really think phylink should be dealing with all this
configuration.

The MAC driver has told phylink its pause capabilities.
phylink_bringup_phy() will tell phylib these capabilities by calling
phy_support_asym_pause(). Why does this not work for the SFP PHY?

phylink knows when the SFP PHY is plugged in, and knows if the link is
admin up. It should be starting the state machine, not the PHY.

Do you have access to a macchiatobin? I suggest you play with one, see
how the marvell PHY driver works when you plug in a copper SFP module.

	Andrew

