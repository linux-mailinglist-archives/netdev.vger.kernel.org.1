Return-Path: <netdev+bounces-110439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED492C68C
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CF3B211A8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A66185636;
	Tue,  9 Jul 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nA5TW+mk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC312185627;
	Tue,  9 Jul 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567432; cv=none; b=kdDZkIjZelz4mOFxpZT1YEhDI6/jNDl6THxUbcsHP09Wogo59kE78XlAlRbvGYFPuiVyrb8ybRSbYe1q+pWbJ1SlmaSakdVSpQ9PzX2AVBTjP92RSsQFGDB9mSiE2LXpWuIstpGLyrZYTjmL11qy2zFi+iMv0VnjidhmHmvz2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567432; c=relaxed/simple;
	bh=nlcFq6G7Ak7cCuekAv9St1CC+jrEhQRZuloOYzJ2wWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nczTFs77eV73sorkbjiPZvIkOSZPb1jCaaTXHdGWWmVG+qaX4yr2hzkV43wtd3lPOhXv3kySpcUSJlsQVwZoTLwfC68tpVaSSarAIr7oIazPEMOfEl3Oh6GXoc7z8Tv2Ct7Se8OPNiWmR8wa2bJbl4j+QrQ6yQ1aeMYhtc7ZC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nA5TW+mk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WKWU3cQ0OIKmF+EkU9Lpuo9od9Ep696yrap97dZ7bt8=; b=nA5TW+mkt8K3HqQRyUiQGaZL0b
	bEAs78IFb3yy1d5tZR9vXvu/jBEV/1NcJrRawvLbGZBsIU0gFL1yz85x1EdN+P0H+EkK1bAMT/yHd
	PwcBte15Pv5rvQGRwXpP7e3FgCPwIlEKRztypSXkTq/fmHLi3OsYkRECKeRT6mqBu348=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRKBM-002BYo-TG; Wed, 10 Jul 2024 01:23:36 +0200
Date: Wed, 10 Jul 2024 01:23:36 +0200
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
	sgoutham@marvell.com, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v6 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <aa66dc50-16b9-4489-ac77-3ef4013b6037@lunn.ch>
References: <cover.1720504637.git.lorenzo@kernel.org>
 <bafc8bcf6c2d8c2b80e6bafebe3661d795ffcbee.1720504637.git.lorenzo@kernel.org>
 <68a37d33-6155-4ffc-a0ad-8c5a5b8fed25@lunn.ch>
 <Zo2ugWhc3wHqyKLq@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2ugWhc3wHqyKLq@lore-desk>

> > > +static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
> > > +{
> > 
> > > +	port = netdev_priv(dev);
> > > +	mutex_init(&port->stats.mutex);
> > > +	port->dev = dev;
> > > +	port->eth = eth;
> > > +	port->id = id;
> > > +
> > > +	err = register_netdev(dev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	eth->ports[index] = port;
> > 
> > eth->ports[index] appears to be used in
> > airoha_qdma_rx_process(). There is a small race condition here, since
> > the interface could be in use before register_netdev() returns,
> > e.g. NFS root. It would be better to do the assignment before
> > registering the interface.
> 
> actually I check eth->ports[] is not NULL before accessing it in
> airoha_qdma_rx_process():
> 
> 	p = airoha_qdma_get_gdm_port(eth, desc);
> 	if (p < 0 || !eth->ports[p]) {
> 		...
> 	}

Yes, you check it is not NULL, so you don't de-reference anything. But
i did not spend enough time to check if you leek something as a result
of it being NULL?

> Moreover, in airoha_alloc_gdm_port(), I set eth->ports[index] pointer just if
> register_netdev() is successful in order to avoid to call unregister_netdev()
> on an not-registered net_device in the airoha_probe() error path. I guess we can
> even check reg_state for this:
> 
> 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> 		...
> 		if (dev->reg_state == NETREG_REGISTERED)
> 			unregister_netdev(dev);
> 	}

I prefer checking reg_state. Problems with this race condition are
hard to track down, so it is better to not have it in the first place.

     Andrew

