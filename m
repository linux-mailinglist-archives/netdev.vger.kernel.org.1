Return-Path: <netdev+bounces-238134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50AC54856
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F7F4E101D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D14299AA3;
	Wed, 12 Nov 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T5F3tLV9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E22741DA;
	Wed, 12 Nov 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980834; cv=none; b=kr68ulQSvHTZJfkMRPGVDNkF/ysf0cDktPsvgTVD3NWKxDlciwLZ2dyNAFjlC7Wq9iYf/bRq9IlzHTWL6oiWwaM3CZfiIQTmRLS8erpP/4ohJXe4ln8Umplm2BjJKIYy0bP8rdPsI/p6EMUsTzP87cdFOuV69+PQrlQ/ur9vw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980834; c=relaxed/simple;
	bh=Si6ky0PVCXOZ9+9QL8Uy2CSqcyxNRl44nBvNsfXqVno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLmgWm87F2/UkyhGXPGGRojADW0YlN47l9COYUQENlwKCuW9StNZEKzGw4axzgo7nWNtGFAmlYukpGMv2MMtd6jXjmQ00DF61zWp+tOo4rCOQrASspv6lPUUhSz/2qf3KbVzI4hitbloYQV3irQnDuN1kRcE4XvYbAbLgi8dfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T5F3tLV9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7fpBZVidFveA9Ks7wfYkZKKMsRGsjfRV2sjl0L3hrK4=; b=T5F3tLV9R4+zrzj+fQXlj3d3r+
	NW4E2aziwzzkfMFZpeEijNRVTVvoX3nNqrtk1xq/izw6njhOL8A5sFFyZy4E81xkrDG2LwQJ+MyhY
	D8mS5SoyPGG4kvg4XStQqXRXtgxGf9Pf9fzr9p9ncDlUCIbTBqyQU2Dm3cKXNKwpW80M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJHqa-00Dmsd-J6; Wed, 12 Nov 2025 21:53:44 +0100
Date: Wed, 12 Nov 2025 21:53:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, almasrymina@google.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next] eth: fbnic: Configure RDE settings for pause
 frame
Message-ID: <289f4375-c569-44ca-86cb-18b48d17c9c3@lunn.ch>
References: <20251112180427.2904990-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112180427.2904990-1-mohsin.bashr@gmail.com>

> @@ -36,8 +36,13 @@ int fbnic_phylink_set_pauseparam(struct net_device *netdev,
>  				 struct ethtool_pauseparam *pause)
>  {
>  	struct fbnic_net *fbn = netdev_priv(netdev);
> +	int err;
> +
> +	err = phylink_ethtool_set_pauseparam(fbn->phylink, pause);
> +	if (!err)
> +		fbn->tx_pause = pause->tx_pause ? true : false;

You should store this away in mac_link_up. Pause can be negotiated. It
could be the link partner does not want pause, does not support pause.
When phylink calls .mac_link_up this has all been determined and you
then know how to setup the hardware. Here is too early.

	Andrew

