Return-Path: <netdev+bounces-206891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674DB04B0E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FBD3B8E81
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE792405FD;
	Mon, 14 Jul 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d+KJ0A4Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3022127C;
	Mon, 14 Jul 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533468; cv=none; b=sMbAxuIwZhdRyJW3eoOLrhu2rRnAs3HWDKLvCcX2BwaiiwC9cFwj5AEvrAR2+ghxUbPIp+vqxmkHuZZlNFaPQqqydwJV1J3qDt0R3yoK8ZgPzMTe57VDwP7FVHby2kcnqGF2dcEU6x4h6eDS9d80ahmd+MjNEKC4m3lEKYMrSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533468; c=relaxed/simple;
	bh=R36EfBTNKg2cB3MJbivO9oYOZI0nNCGB1BDVEa0qSvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oItgl2i25SrLxKHc/LUOHojOZMiL6aiUmjeftjihhgD82rDbHdqZoRWkvPUM1MMntfiXXRJFHG943DWksThKG0kdyFQ2iReQybEZexv0cJ8kSZ+mSb50e1d8BUp8rO/4vpeC0tOMaZXHJjmybPcYhXntDJ5joSGrPVPZz4XN8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d+KJ0A4Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HjeoFMni5D8FZbA2QblKQtsOtTKxXPyVOVcubTEine8=; b=d+KJ0A4ZqqvLbmCeMtCn7KZIqK
	lMWirgyILo1QyUWza5WwPn33MyeWPFv3s1FQdB3piR3nRaZ5SNFXhdi7FKCr1kejaPfbSydDLvo6A
	zycMeoYscPdyeyluXwfoIUwCYQaLn4M08MJ8Hpi8s3K1U+jPqmwT6FGM/uk02qrlKPi8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubS0W-001W0H-OT; Tue, 15 Jul 2025 00:50:48 +0200
Date: Tue, 15 Jul 2025 00:50:48 +0200
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
Message-ID: <434a235b-7e33-499f-a9ab-99166297012c@lunn.ch>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
 <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
 <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>
 <86e1e04a-3242-482c-adb0-dde7375561c1@lunn.ch>
 <baed95d4-c220-4d3b-8173-fc673660432d@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baed95d4-c220-4d3b-8173-fc673660432d@altera.com>

On Mon, Jul 14, 2025 at 03:29:21PM -0700, Matthew Gerlach wrote:
> 
> 
> On 7/14/25 11:52 AM, Andrew Lunn wrote:
> > On Mon, Jul 14, 2025 at 11:09:33AM -0700, Matthew Gerlach wrote:
> > > > > On 7/14/25 10:25 AM, Andrew Lunn wrote:
> > > > > +&gmac2 {
> > > > > +	status = "okay";
> > > > > +	phy-mode = "rgmii";	/* Delays implemented by the IO ring of the Agilex5 SOCFPGA. */
> > > > > > Please could you explain in more details what this means.
> > > > > > The normal meaning for 'rgmii' is that the PCB implements the
> > delay. I
> > > > just want to fully understand what this IO ring is, and if it is part
> > > > of the PCB.
> > > > The IO ring is the logic in the Agilex5 that controls the pins on
> > the chip.
> > > It is this logic that sits between the MAC IP in the Agilex5 and the pins
> > > connected to the PCB that is inserting the necessary delays. Technically the
> > > PCB is not implementing the delays, but the "wires" between the MAC and the
> > > external pins of the Agilex5 are implementing the delay. It seems to me that
> > > "rgmii" is a more accurate description of the hardware than "rgmii-id" in
> > > this case.
> > 
> > Is this delay hard coded, physically impossible to be disabled? A
> > syntheses option? Can it be changed at run time? Is the IO ring under
> > the control of a pinctrl driver? Can i use the standard 'skew-delay'
> > DT property to control this delay?

> The delay is not hard coded. It is a synthesis option that can be disabled.

Is there a register you can read which tells you if it is
enabled/disabled?

> The delay in the IO ring can be disabled, but implementing the delay in the
> IO ring allows for RGMII phys that don't implement the delay.

All RGMII PHYs which Linux support have the ability to do delays. And
we recommend the PHY does the delay, just to keep all systems the
same. There are a few exceptions, mostly because the MAC has hard
coded delays which cannot be disabled, but i guess 90% of systems have
the PHY doing the 2ns delays.

So, phy-mode should be set to 'rgmii-id', since the PCB does not add
the delays.

Ideally, you want to read from the IO ring if it is synthesised to do
the 2ns delays. Assuming it is enabled, you then mask the phy-mode
before connecting to the PHY, so avoiding double delays.

	Andrew


