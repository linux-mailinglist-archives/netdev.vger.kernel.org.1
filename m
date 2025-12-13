Return-Path: <netdev+bounces-244599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBDCBB2A7
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 20:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF92300B832
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A52E8B98;
	Sat, 13 Dec 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g4QdqlGX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D926299;
	Sat, 13 Dec 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765654174; cv=none; b=Zh2Ml9jHldbTSGQpiuNcIgEqbRBs04lP1+4yuLgph5s3mD6Wrc5BOU3xiI67JRLf3VKfNOtumvymMYVYV5gJMPPxjewOXsgt13ryaGpi5fJp03Icl64iZNcLifS1PrnjiqXiWlibDLAJaqVT5duSR0Vn3GZmnBwAdehGapqBDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765654174; c=relaxed/simple;
	bh=sQykiy83ntsZi5EW7eNjBajUNY6iljFQ3YXbvCTelMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrw5YrxzIIcLZ0aYPG9BzBYIAyRcuAFcD5bH+CFgBFNbXR4aMRu4DC0PptekLtFIrIozIEbMXPfBBq0k9Tn6Wd6lNuUxQUWsuFGeAwFiPfxZnHbMaVIlkQX1/ewr9D7qjUV0An6s9EKE4KP1Fd3cKUmd3yoquueTsLLDhwehXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g4QdqlGX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hTeoTvlaNorrYgtUcshYvC26vMurz9r1gkz10HbyfUo=; b=g4QdqlGXQ6YFEl9fy6/cZAlfyJ
	35xQKywiIN2d6yC3Q2C9DlTXoVJ5N4nRoyOZi2dwR7utfVGziWtO5K+K118f+nziH+OqZ4ojnJFgP
	ooYl5TathljPM3HGpHxW07zgo9Rz2/eRyZLVeVHVbv3nsBb4wD/D3QVm8lTG5V19VW6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUVIu-00GsGC-SB; Sat, 13 Dec 2025 20:29:20 +0100
Date: Sat, 13 Dec 2025 20:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: realtek: increase
 rtl822x_c45_soft_reset() poll timeout
Message-ID: <0163c5f3-44a5-4b2a-aeb6-ce924e9a7492@lunn.ch>
References: <TYRPR01MB13830B4914CFB007B74366AEDBCAFA@TYRPR01MB13830.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYRPR01MB13830B4914CFB007B74366AEDBCAFA@TYRPR01MB13830.jpnprd01.prod.outlook.com>

On Sat, Dec 13, 2025 at 11:21:30PM +0800, Shiji Yang wrote:
> It's noticed that sometimes RTL8221B-VB-CG cannot be reset properly.
> Increase the polling timeout value to fix this issue. The generic
> phy reset function genphy_soft_reset() also uses 600ms as the timeout
> threshold.

Should this be considered a fix and back ported to stable? If so,
please target net, and add a Fixes: tag.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

