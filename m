Return-Path: <netdev+bounces-106198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1A915302
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2936F1C226D3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA019D8A8;
	Mon, 24 Jun 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="exVvtHBk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D319D88F;
	Mon, 24 Jun 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244653; cv=none; b=VtK0aRhc9CvBGmcH023iAqvY9hTjLQQcj+HaJLVF7zrxIHeXnuuFuiuORaLBkGnE4II9Xavr391D93rE6nFD0Rp496ib5yOlfD9JDe/osb3F9sW9WbCox6+xuLfH9BObhMSBjzz0K0k0OaUh0gs+AzXnC5UfWsUrQ95wBHGDrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244653; c=relaxed/simple;
	bh=4CGU425Suyh+HEKPbHZB/r9PKVUiNLrlI7O04mUpbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFprtCur6CniO/oAwOe9yFnAcZv3heSSstcGMqik8bT/WPyfW5YDobktZgkLEZ1bn8mqQSoIUQkXdeSnYTmvlxa8fImk+zx2ihl4arPUVzVKJQTmjJG0ZV3A7hh+Z8ise8qKmYHzNPFE6YivWJEh/QigskzLZ/GAhOtZ2klwnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=exVvtHBk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RM+ZSQXymnYDzv86I4EKBK+TdprrdQ2pA2LtpZZLKso=; b=exVvtHBk+JYemTi6PvfKAAykKR
	eP0lV37cZV57h7dFfn8mUwThb8bWvCxB8ZGfE4ZM/kXZju/UbHakHWJyho3CPqi7eR1ORxs2oYXvV
	xlTeSDdDd8wVyUi6WZxAXG0TNHyI0HjVQynTvkVtiWYdB4gvKBcvDRt32IwzEm2CUWuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLm4H-000riQ-9i; Mon, 24 Jun 2024 17:57:21 +0200
Date: Mon, 24 Jun 2024 17:57:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <e203100f-7bdd-4512-8a05-9a33476db488@lunn.ch>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
 <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
 <Zni13uFslHz5R6Ns@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zni13uFslHz5R6Ns@lore-desk>

On Mon, Jun 24, 2024 at 01:55:10AM +0200, Lorenzo Bianconi wrote:
> > > +static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
> > > +				    u32 port, u32 queue, u32 val)
> > > +{
> > > +	u32 orig_val, tmp, all_rsv, fq_limit;
> > > +	const u32 pse_port_oq_id[] = {
> > > +		PSE_PORT0_QUEUE,
> > > +		PSE_PORT1_QUEUE,
> > > +		PSE_PORT2_QUEUE,
> > > +		PSE_PORT3_QUEUE,
> > > +		PSE_PORT4_QUEUE,
> > > +		PSE_PORT5_QUEUE,
> > > +		PSE_PORT6_QUEUE,
> > > +		PSE_PORT7_QUEUE,
> > > +		PSE_PORT8_QUEUE,
> > > +		PSE_PORT9_QUEUE,
> > > +		PSE_PORT10_QUEUE
> > > +	};
> > 
> > > +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> > > +{
> > > +	int i;
> > > +
> > > +	/* hw misses PPE2 oq rsv */
> > > +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> > > +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> > > +
> > > +	for (i = 0; i < PSE_PORT0_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> > > +	for (i = 0; i < PSE_PORT1_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> > > +
> > > +	for (i = 6; i < PSE_PORT2_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> > > +
> > > +	for (i = 0; i < PSE_PORT3_QUEUE; i++)
> > > +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);
> > 
> > Code like this is making me wounder about the split between MAC
> > driver, DSA driver and DSA tag driver. Or if it should actually be a
> > pure switchdev driver?
> 
> airoha_eth driver implements just MAC features (FE and QDMA). Currently we only
> support the connection to the DSA switch (GDM1). EN7581 SoC relies on mt7530 driver
> for DSA (I have not posted the patch for mt7530 yet, I will do after airoha_eth
> ones).
 
> airoha_fe_oq_rsv_init() (we can improve naming here :) is supposed to configure
> hw pre-allocated memory for each queue available in Packet Switching Engine
> (PSE) ports. PSE ports are not switch ports, but SoC internal ports used to
> connect PSE to different modules. In particular, we are currently implementing
> just the two connections below:
> - CDM1 (port0) connects PSE to QDMA1
> - GDM1 (port1) connects PSE to MT7530 DSA switch
> 
> In the future we will post support for GDM2, GDM3 and GDM4 ports that are
> connecting PSE to exteranl PHY modules.

Is the PSE involved in WiFi? When you come to implement NAT offload,
etc, will that depend on the PSE?

Figure 9-1 of MT7981B_Wi-Fi6_Platform_Datasheet_Open_V1.0.pdf clearly
shows the PSE outside of the GMAC. I'm just wondering if the PSE
should be a driver, or library, of its own, which is then shared by
users, rather than being embedded in the MAC driver?

       Andrew

