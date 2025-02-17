Return-Path: <netdev+bounces-167039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC6A3875F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721D63A9FD0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22821D010;
	Mon, 17 Feb 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2UefaQrU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882031494DF;
	Mon, 17 Feb 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805510; cv=none; b=XN6Z/GoN2rjQw2llwDcE1FWwU4PLaWzl5nQP1ierI1ntRu9lGdw4M5RiD/hjjxJ0t7UfMORM2IyZ81DJXOvJq7Xfo13M0EcJIyu2z2WDTi5wuC2d8BHBZHpxnTuAYZFXXHUz+Q760/7MjkDmfcQ5a9z2d3f3Llu+4XESDGszTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805510; c=relaxed/simple;
	bh=EU3zlPj1sEPYcJJygetbhc5BzF+GN3U4gtIm4tGY330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqJ+3La5EILYVOddkgutDdUUbvb5ug2ni5+rwwro/izbSIvNpQKROIDTsBn6fmIju/1GqAxxtiCeD4aJVdvjfUtKT4RYBl++oG1embsfyGPfsAqyEfiw1QPqug3wpM6BkNg458VGiHBabjJfAS5EPIHwodOK4S9zE35hMTTb1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2UefaQrU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NvYluRdkIYTZI6ccj4hQ+kAHZsTnKaccn8jpIrnuS3A=; b=2UefaQrU/d+T+mYtpph7dWPoXp
	aVvHZBJgTEnrOinhX8HEMfrJs70OqL4CD3KhJuGXaJGvR9OpbNBqCMg+gEX1R/V7jE4RuB6j2CHxG
	Puzdg59ZwMIzvxt+ZI8HuIo6fHQbXq3ijGCm1odfEaEchH67hhBwbD2n8tyNyPBo+DRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tk2st-00F0Ij-7o; Mon, 17 Feb 2025 16:18:11 +0100
Date: Mon, 17 Feb 2025 16:18:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Pankaj	Dubey' <pankaj.dubey@samsung.com>, ravi.patel@samsung.com
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <18746e2f-4124-4f85-97d2-a040b78b4b34@lunn.ch>
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
 <85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
 <00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>
 <ffb13051-ab93-4729-8b98-20e278552673@lunn.ch>
 <011901db80fb$8e968f60$abc3ae20$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011901db80fb$8e968f60$abc3ae20$@samsung.com>

> > > > > +  phy-mode:
> > > > > +    enum:
> > > > > +      - rgmii-id
> > > >
> > > > phy-mode is normally a board property, in the .dts file, since the
> > > > board
> > > might
> > > > decide to have extra long clock lines and so want 'rgmii'.

> Hi Andrew, 
> What you said is right. Generally, PCB provides internal delay.

It is actually pretty unusual for the PCB to add the delays. But there
are some boards which do this. Which is why you should support it.

> But in this case, due to customer request, the delay was added into SoC.

Idealy, by the PHY. However, in terms of DT, the board .dts file just
needs to say 'rmgii-id', meaning that the board does not provide the
delays, so the MAC/PHY pair needs to provide the delay.

> The following doc on rgmii says that "Devices which implement internal delay
> shall be referred to as RGMII-ID. 
> Devices may offer an option to operate with/without internal delay and still
> remain compliant with this spec"
> https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/2
> 0655/1/RGMIIv2_0_final_hp.pdf
> 
> Also, the driver is in such a way that it handles all four rgmii in the same
> way. 
> 
> Considering this, could you let us know what will be the right approach to
> take in this case?

List all four phy-modes in the binding. They should all be
valid. However, the .dtsi file should not list a phy-mode, since it is
a board property, not a SoC property.

	Andrew

