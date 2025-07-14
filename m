Return-Path: <netdev+bounces-206831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D6B0478C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AC94E101D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22581277807;
	Mon, 14 Jul 2025 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hrFQBCcJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926327703A;
	Mon, 14 Jul 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519151; cv=none; b=o01zQiSgmMnexD+vU5aHeohsHdywTMFNYQAlLMBy3M6EpTOdE9R/xTHIqF6xfs+5+zdeN9p4K6jNXLbb/RmQk7g1nJ1zIcVhCYC/B4cUIPgFfAFCFaKIlkKMPgwT/oNkyA4A8D2/hs2A/LP9jfER9Y/thy3KtxA8RMt3Bd7uUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519151; c=relaxed/simple;
	bh=lijElj7CzTGD5PyNhNfpkNy08rng4q72faSFa1O+88I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQpwNpiXZjVfkt5ngGQubFbSprKcXFVrzHDZJQ/CnQlYPHXOa5Vy2sLyOodTH18McUH/pDWahsi3wEeXsZLD5nYD8b2RoF5yuQHEKHv59VrhiLVoWqv31FH3/jmlAWoasLsXKPolh9q4wi0MWySgvk7JuooQ2Szmizm3q5zDUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hrFQBCcJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4mcaPOCXuzcuqrql8CPC5ZiVQE91mo1ELmABGML81qY=; b=hrFQBCcJKrv941KwidwkQk5On0
	sxEaQxGet6J1wRs/YJC9eALAMFdzcFjE6rM3vHOOOq3smX+wk7XtWc3iet3vCh/bbMQeF6sumdaa9
	VYBJ3aDVS9J7gemohTr+FBreGj6t76boDpUEJrzYRJQau85/5pr1nPUqFB+Tumsb8JRQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubOHh-001V2I-Uc; Mon, 14 Jul 2025 20:52:17 +0200
Date: Mon, 14 Jul 2025 20:52:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, dinguyen@kernel.org,
	maxime.chevallier@bootlin.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
 Agilex5 dev kit
Message-ID: <86e1e04a-3242-482c-adb0-dde7375561c1@lunn.ch>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
 <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
 <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>

On Mon, Jul 14, 2025 at 11:09:33AM -0700, Matthew Gerlach wrote:
> 
> 
> On 7/14/25 10:25 AM, Andrew Lunn wrote:
> > > +&gmac2 {
> > > +	status = "okay";
> > > +	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */
> > 
> > Please could you explain in more details what this means.
> > 
> > The normal meaning for 'rgmii' is that the PCB implements the delay. I
> > just want to fully understand what this IO ring is, and if it is part
> > of the PCB.
> 
> The IO ring is the logic in the Agilex5 that controls the pins on the chip.
> It is this logic that sits between the MAC IP in the Agilex5 and the pins
> connected to the PCB that is inserting the necessary delays. Technically the
> PCB is not implementing the delays, but the "wires" between the MAC and the
> external pins of the Agilex5 are implementing the delay. It seems to me that
> "rgmii" is a more accurate description of the hardware than "rgmii-id" in
> this case.

Is this delay hard coded, physically impossible to be disabled? A
syntheses option? Can it be changed at run time? Is the IO ring under
the control of a pinctrl driver? Can i use the standard 'skew-delay'
DT property to control this delay?

For silicon, if the delay cannot be removed, we have MAC drivers masks
the phy-mode to indicate it has implemented the delay. The MAC driver
should also return -EINVAL for any other RGMII mode than rgmii-id,
because that is the only RGMII mode which is possible.

Since this is an FPGA, it is a bit more complex, so i want to fully
understand what is going on, what the different options are.

	Andrew

