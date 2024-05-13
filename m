Return-Path: <netdev+bounces-96131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8C8C46B3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD512B21D59
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC22C1A9;
	Mon, 13 May 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UvfWN3y5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A629D0B;
	Mon, 13 May 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623656; cv=none; b=hAC0eYTkwfFH6kLmxQsof25rIVEFVwVNSbsb56YXz3k2z1gWQfoFbRiRFHy2jjqsjoQDn/UKkCvcXjZ/wjogPCfOZz5e8cqJ+TJim8sKAF9SPXjIiZMSIC+3DttuKSzwZcZAlRM2zga8jlA4ItyseF6V9cLBiIvMXOEa71QywFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623656; c=relaxed/simple;
	bh=nZVPVyq1aztg9r8lTsw449FeY1mUplfFw33FzVNogD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8276kfIhVS/EOvzlsqkvvLsxCWkRYhTPZnUi4V2CPhVtHOMCRxXi8ylQBoqNv7Y9MiYpxqyoVqnwvk6H5l2qr8PoEioyslGlVnToYPMftoczcG+eIzftJXZFoiI3pP+HNOS2TPYfbjYcsOGm//XsjtH24EK/nXrKGWJPIxDhlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UvfWN3y5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qv4aa2y30wKDIpbTtsqV7m9XFw7hrbmhzvePIaRnkJs=; b=UvfWN3y5pfzUTvOPr5g8P+RC7S
	9msDnr0XJmQf7mI4Ln2mXe2UWfeeFM0FZ9qnl2YU+bdIGup1THUwQ9gZeYUoJ4i1MkedVU8M8kDhM
	YUCPfJOMIuU3Nqn01Y9s8uqK2+PR4ttjSRM9YSm9h72ebhsaRPVe4yxQ1mChxBXmh5lk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6a51-00FKNw-JD; Mon, 13 May 2024 20:07:19 +0200
Date: Mon, 13 May 2024 20:07:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <1484c1b7-90aa-4495-a417-a400add8602a@lunn.ch>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <4ede8911-827d-4fad-b327-52c9aa7ed957@lunn.ch>
 <Zj+nBpQn1cqTMJxQ@shell.armlinux.org.uk>
 <08b9be81-52c9-449d-898f-61aa24a7b276@lunn.ch>
 <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdnO-+V2npKBoXW5o-5avS9HP84LV+nQkvW6AxbLwFOrZuAGg@mail.gmail.com>

> Yes, the MAC directly connects to switch within the SoC with no external MII.
> The SoC is BCM89586M/BCM89587 automotive ethernet switch.
> The SOC presents PCIE interfaces on BCM89586M/BCM89587 automotive
> ethernet switch.
> The switch supports many ethernet interfaces out of which one or two
> interfaces are presented as PCIE endpoints to the host connected on
> the PCIE bus.
> The MAC connects to switch using XGMII interface internal to the SOC.
> The high level diagram is shown below:
> 
> +==================================================+
>    +--------+                     |                     BCM8958X
> switch SoC               +----------------+         |
>    | Host   |                      |  +----------------+
>     +-------+                 |                     |         | ===
> more ethernet IFs
>    | CPU   | ===PCIE===| PCIE endpoint |==DMA==| MAC |==XGMII==|
> switch fabric |         | === more ethernet IFs
>    |Linux   |                      | +----------------+
>    +-------+                 |                      |         |
>    +-------+                       |
>                                       +-----------------+        |
> 
> +==================================================+
> Since the legacy fixed link cannot support 10G, we are initializing to
> fixed speed 1G.

You ASCII art is broken, probably because you are not using a fixed
width font.

So the interface between the MAC and the switch is fixed at XGMII. Is
the MAC actually capable of anything other than XGMII? If XGMII is all
it can do, then there is no need for a fixed link. You use a
fixed-link when you have a conventional off the shelf MAC which can do
10BaseT_Half through to 10GBaseT. Normally there would be a PHY
connected to the MAC and phylib/phylink will determine the line rate
and tell the MAC what speed to operate at. However, if this device
only supports XGMII, it is impossible to connect to a PHY because
there is no external MII interface, then skip all the phylib/phylink
support and hard code it. Look at the patches on the netdev list for
the RealTek automotive driver which seems to be pretty similar.

	   Andrew

	       

