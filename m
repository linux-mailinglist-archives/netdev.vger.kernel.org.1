Return-Path: <netdev+bounces-103323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA490799E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B611C205E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30281494D1;
	Thu, 13 Jun 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mn5uXGuV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E001311A1;
	Thu, 13 Jun 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299195; cv=none; b=sOBfp0MZ5WkZpXQMkGx/lich1mw1Bb4H7oX7TCeJsxZBD2rbWN09vckknh879lkPqAA4Oc1fui9lzJnnnPek0G1VZ0aYv8YAAtbAFyKxGtSNphIkdBiE/5/LUNCVHZArM5fRYCtbUlKBCN3QtnNnDdm9XZ1xCM6PPMtSi7TH9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299195; c=relaxed/simple;
	bh=/iw94elK2KvQ1WS9JyAyDc6M5OwEKcTym8VIp6OX/50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njMVyK9lMuhCoQCnFKE5R+LNnx3MyzRxEvGfcZLvM25DniRlciXtYuwUEZNXnHSQCPV8UQZHLI06+fx3f+3fz6eyHVg9EwRtHHrDtA2vl6bbqXg4v56gCDnUcXuLE0hZ4yUcl1PU/kZCiRiJjDJMoX6BFtRg8k035RNgeQiaoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mn5uXGuV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wdPsX4RB9oiW3AuQOrVhfSo6eB0c1kmtven1xn6Dx+M=; b=Mn5uXGuViHc8yTKkyhgiMEvPzh
	e86fjCCPe8xVIHMIsMavkb4tuv5nlBRCOrhGJ6SjvGywYZSE8bJYXeKAYKu6jC9owxwlWXyFPvIgd
	Rt15ppC1hCcvEsXk+I3w0/etVUg18UIRCR/QN2jMFZAwqjKx3GKWYIBs7OLMgO7HitsQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHo6z-00HaZ7-Pb; Thu, 13 Jun 2024 19:19:45 +0200
Date: Thu, 13 Jun 2024 19:19:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Jo=E3o?= Rodrigues <jrodrigues@ubimet.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: dp83867: add cable test support
Message-ID: <d2e2232e-7519-4d62-b2be-265058350e08@lunn.ch>
References: <20240613145153.2345826-1-jrodrigues@ubimet.com>
 <20240613145153.2345826-3-jrodrigues@ubimet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613145153.2345826-3-jrodrigues@ubimet.com>

> +/* TDR bits */
> +#define DP83867_TDR_GEN_CFG5_FLAGS	0x294A
> +#define DP83867_TDR_GEN_CFG6_FLAGS	0x0A9B

Is it documented what these bits actually mean?

   Andrew

