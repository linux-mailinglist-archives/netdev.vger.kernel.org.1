Return-Path: <netdev+bounces-161492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B0A21D8A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E353A6FD2
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F46EAC5;
	Wed, 29 Jan 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UzporGQk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B364D5AB;
	Wed, 29 Jan 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156029; cv=none; b=BQa6jkBAOPO7WCxmSkaeyJSe0RqTlNoKAmpyrnzlSU+wTPIE3X8XV49RDxuPj0LnRp5OdreuQalx7SIA8URdOF5V9exdYeEZayOLzbmE0BEwAOG8pvgKjtzC57TqDt230h1up6ZhAq7kafyAYiNTBHD9AD1r/idg3Gv7+JwutPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156029; c=relaxed/simple;
	bh=lnZYKHnsajYmGKPEp/KG42QEGA8uR313hXe7AflDXhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaPz3Hj1YjXvnEXk8FiWJdYskauTb7MnGJkc3pge1zJM2jB962bj5em+zePaRafOG27181sexoEmyBg+4msbDEiAQJIrDNyX1xpP2Di+FlqpVo0VZiq3PXW7gQG8Cpd1vZI52Kni7ZQs0KRLp0CgzH4QUBTSsU7vO0HMki9P0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UzporGQk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NE+/cXEahUBCqeTZXG0troRfgMK7rMSagxCJsqVZEks=; b=UzporGQkBf1nm2HZlsOn+y9rTZ
	OjGPEsEd6+PwBg0wNZPQ16H1EKVb6Xc5mvAKzVwh0rPS43WkbbO2IYEAoWFvDAzao89F/yJH3tWzN
	i6AtywwHN8SANcBGiYEwkIXUOeZ6nPafstR+QZdOkwCzCWxmUwQm9J9uud+94fTObWBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1td7mY-0098By-Px; Wed, 29 Jan 2025 14:07:02 +0100
Date: Wed, 29 Jan 2025 14:07:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com
Subject: Re: [PATCH v5 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
 Block of FSD SoC
Message-ID: <c86d69f5-eb97-4e0b-b2db-5b30f472a0d3@lunn.ch>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102743epcas5p1388a66efc96444adc8f1dbe78d7239b9@epcas5p1.samsung.com>
 <20250128102558.22459-5-swathi.ks@samsung.com>
 <918d6885-969e-46f1-b414-614905b12831@kernel.org>
 <002e01db722e$e018b7e0$a04a27a0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01db722e$e018b7e0$a04a27a0$@samsung.com>

On Wed, Jan 29, 2025 at 02:49:14PM +0530, Swathi K S wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 28 January 2025 19:48
> > To: Swathi K S <swathi.ks@samsung.com>; robh@kernel.org;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; conor+dt@kernel.org; richardcochran@gmail.com;
> > mcoquelin.stm32@gmail.com; andrew@lunn.ch; alim.akhtar@samsung.com;
> > linux-fsd@tesla.com
> > Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> > alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
> > joabreu@synopsys.com; rcsekar@samsung.com; ssiddha@tesla.com;
> > jayati.sahu@samsung.com; pankaj.dubey@samsung.com;
> > ravi.patel@samsung.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v5 4/4] arm64: dts: fsd: Add Ethernet support for PERIC
> > Block of FSD SoC
> > 
> > On 28/01/2025 11:25, Swathi K S wrote:
> > >
> > >  &pinctrl_pmu {
> > > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > > index cc67930ebf78..670f6a852542 100644
> > > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > > @@ -1027,6 +1027,33 @@
> > >  			phy-mode = "rgmii-id";
> > >  			status = "disabled";
> > >  		};
> > > +
> > > +		ethernet_1: ethernet@14300000 {
> > 
> > Don't add nodes to the end, because that lead to mess we have there.
> > Squeeze it somewhere where impact on resorting would be the smallest.
> 
> Just to clarify,  inserting the node somewhere in the middle, where it fits alphabetically, would minimize the impact on resorting.
> Is my understanding correct?

I think the coding style says to order them by address. So sort on
14300000.

The issue here is merging patches coming from different subsystems. If
these patches are merged via netdev, and there are other patches for
other devices coming from other subsystem, there is going to be a
merge conflict if they all append to the end. By keeping things
ordered, the chance of a merge conflict is much lower, since the
changes are likely to be separated. So you will find in Linux anything
which can be sorted is sorted. Makefile, Kconfig, order of #includes
etc.

	Andrew

