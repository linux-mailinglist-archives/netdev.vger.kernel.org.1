Return-Path: <netdev+bounces-128601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FB97A85D
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914011F290A8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A81422D8;
	Mon, 16 Sep 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f40rVowA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE1107A0;
	Mon, 16 Sep 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519089; cv=none; b=PzQsfAbHVH6Vbeh0UuAGm3YnF2opgBNxMaHCmQXWG2o9MhRvPHCeJVNubfZ0HroGpMWGvG/6QYIh/bCVIal4TJzVCUHC5TEEI3zf5hUMGli/k315go7iePz9iVuceva3CEmUoK2rRafMn/fs/15GNu6pOuMMhHE/i/3hl27ihFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519089; c=relaxed/simple;
	bh=q83pgDV47Qc7WSIKT4BqeRJMitDCo2e6t6YcampYFxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dpw9QPExsSTdREXP9dK9UghWs/IL6Cr+AFp59E4FXNbudZ1fGN2B5uhJrtP7VvwFVlhzf1tnORAVbCRXxNw/K563h9Fjlom1AKoRHrdzD35yKxecgDia5+vARKw/O1/ZGtO6s+vHTO+D/PxkB/uCS0SKBgCUkiePtjuBaxnthEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f40rVowA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=89CEOgVHqh6yYFL1GhUKj/NHWtr3/ma627UDSS+G7zY=; b=f40rVowAk0fnhNNqTO3VK6iLyO
	saTjWfjIIHXQSoYQQuT0XzcIGFF+oueVCZxTpB1Aiyb9EUiprvm9lEErSGf7ZVosk7v61thbBsCoi
	aE/SpyrWVyIfdWZ1y0nemK6YLD38Jc5AVyOpVdW4SDzIMnMRxjykvLjrAyUAy3G7dMy4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqITY-007aiz-Ia; Mon, 16 Sep 2024 22:37:36 +0200
Date: Mon, 16 Sep 2024 22:37:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com,
	rdunlap@infradead.org, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <ee5a5bf2-a014-448c-9e28-d4caea3f481e@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
 <c93c4fe2-e3bb-4ee9-be17-ca8cb9206386@wanadoo.fr>
 <ZuKLGYThw8xBKw7E@HYD-DK-UNGSW21.microchip.com>
 <ZuiHhoxi05IOWphr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuiHhoxi05IOWphr@shell.armlinux.org.uk>

> If you really want to do this kind of thing, at least write it in
> a safe way...
> 
> 	snprintf(..., "%s", string);
> 
> rather than:
> 
> 	snprintf(..., string);
> 
> so that "string" doesn't attempt to be escape-expanded.

One of the static analysers is complaining about this danger, or it
might be GCC itself if you up the warning level. The kernel hardening
people are replacing all such bad cases, one by one. So we definitely
don't want to add more.

	Andrew

