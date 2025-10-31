Return-Path: <netdev+bounces-234699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7EC26225
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566AA6216DD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04C280023;
	Fri, 31 Oct 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sh2uVxHl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B844C25EFBB;
	Fri, 31 Oct 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927576; cv=none; b=Wu2fAHLpXOiLM27bjrgLRTX/qUc5JKuVRUYpP5KGm8Jxr2ZlB3MQh5L9wdLtWr4+OxZJEmIcfucXgqY+6Qt5r8Q2xoOGibPleTloNENNJmUwXWjSxB3dVYoYiXII57TghpCUyLU+R1suWNLF8vmxbFdEFlxAhC954J0NF8Q0BA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927576; c=relaxed/simple;
	bh=8jSGa5FBFz+lpGdyBN62ollii75N0UH/s7FBkDBu8d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMZYUJByMRunkym43SlSMZaC8iX5XaqkncjB/B1aRavPG8Ll4EkaBgT89Sq3PLr7XNA+RnnNYY0XK/Z+o8x1zjUzrY8KAw3p363y2xjoi4jiOdMTQk7ZVXubY9ZsfrC8uY5n+EMw+d0tqQOIC7JxSBpvXOL28DEGRPQG/pLyeWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sh2uVxHl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h8x00BdGOX6ejpZ5GnXP3pUZyObW3nrJsk+6UQ17jcY=; b=Sh2uVxHllkyCKnq3Vo3xPtsgQn
	pBE2/nBCVgPoZmVueMYMD54kiE7r4o/JXGvhClZkerKo39qO9REi1EeDtIyVRFr8R65zzN5TvzDZ2
	20vajedRanVt/fe6/uCsAQppnw6YAPuktdu6y6wUNvEMUDm/NDX1AjrRVrnjFprPxngs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vErqS-00Cc8U-Gi; Fri, 31 Oct 2025 17:19:20 +0100
Date: Fri, 31 Oct 2025 17:19:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: altera-tse: Init PCS and phylink
 before registering netdev
Message-ID: <c4e3dc1c-e730-4240-860b-426da10840c4@lunn.ch>
References: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
 <20251030102418.114518-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030102418.114518-5-maxime.chevallier@bootlin.com>

On Thu, Oct 30, 2025 at 11:24:17AM +0100, Maxime Chevallier wrote:
> register_netdev() must be done only once all resources are ready, as
> they may be used in .ndo_open() immediately upon registration.
> 
> Move the lynx PCS and phylink initialisation before registerng the
> netdevice. We also remove the call to netif_carrier_off(), as phylink
> takes care of that.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

