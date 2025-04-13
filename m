Return-Path: <netdev+bounces-181999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA20A87497
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC2D188EEA5
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532AC198A1A;
	Sun, 13 Apr 2025 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ciSjOv33"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C818C930
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584505; cv=none; b=QsdvKs5eUCFtDHEgUCeAqe/p3kw8prdqEUBlHZZcLTLCb/my/8dCBHGHUgxOna3rI64Z23i8IGS9163iwkRTO5UvgQ5hlJHx1vFO25SZ/uCDs+Rr/FWxyvJ0YsZ6hI8M958inzOew7yVy8aqInVDJK97J/ttKkb28MQdn+VCOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584505; c=relaxed/simple;
	bh=W1nctRavDkB3IyoI7SOvcLLwfsX8teet2L1KehqY2Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsxT7xzYHtczm8sd1bSi9S9jsU0ArC8SH01gwhezVft3AfGPt7c+hO/FQ1U/DTGDGp1i/18+qpbM6EpaDG0NCQ1iLLaJYVMfFkdi+XuZ2vHvud6K1D1feWisgFL/K9XVZfhI+0NPs0bLyo9gfX5eRZvHFfHLHhQTV6LZl/V3ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ciSjOv33; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wc3hQPnL+F3ev1WHyWrf8FAqTE2yopRhwUwxaCnP6ts=; b=ciSjOv33CYqLN+A0x6uSF6foQ/
	yt/Iq83shz5+Z/Z+D5H5vwrsMpxqmCFgW62J1m1mnJFCeUOZt0mbHR56pDKixcLRNP4zG9tgFGWVP
	zS/iYR7bMgZSllg/R2Obv5O1VejCYBcx7qEXKCqzRl8vG2FZjD6NWCKL8cVaFzROL58k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u467V-0097KZ-13; Mon, 14 Apr 2025 00:48:09 +0200
Date: Mon, 14 Apr 2025 00:48:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/4] net: stmmac: anarion: use
 devm_stmmac_pltfr_probe()
Message-ID: <5501a5fe-a536-45ed-9411-13d2a752aab3@lunn.ch>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfU-000Em3-Mh@rmk-PC.armlinux.org.uk>
 <acd537c9-51f2-4d5c-a07d-032ea628d241@lunn.ch>
 <Z_w9aE62dqOdr4w9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_w9aE62dqOdr4w9@shell.armlinux.org.uk>

> Thanks - but nipa found an error in the patch - s/&pdev->dev/pdev/
> with the new call. Ditto for "net: stmmac: anarion: use
> stmmac_pltfr_probe()" so I'll be sending a v2 for both. Do you
> want me to keep your r-b with that change for both patches?

Yes, keep them. The basic idea looks correct, even if you made a minor
error.

	Andrew

