Return-Path: <netdev+bounces-148314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E49E1186
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5506FB225DD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78314B942;
	Tue,  3 Dec 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kpz3ts+G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98C1465AD;
	Tue,  3 Dec 2024 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194464; cv=none; b=c+oC+e6s9JFLIIVIVyTYDIqVqXi0PfC3oWJQv1TrrFp0rqfsMS+hTiIUnfDIuKs29y3GnBL87wzUkqyCfx+jSzzetUyFoUYhpYp53dMkf3r7qF/2cn27qTVkAD2Vh+uqNL8SHmez3bB4v7PpZSwbwhdoYvtSrU/C0WAZipNy2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194464; c=relaxed/simple;
	bh=I8SirD0yuHcfbPsXm4iZpq51HM5L+c5OfxjNF6/99Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbvlmjv2JfcLKhxiacK/m4Q+VEiK30ZrgtQGYhCejXTcdFBs9HzvpP7igd2ePqAc6zz27Tlpm3MerPWTpBsB5Usrh6CuMtO7yLagfIW0fm/MP1KZk5tJQCJnMedFtEbEyqSkQpr+1UtzdZUWW3jBLG9FzcO3N3UpLUr/U2ctf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kpz3ts+G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9qzV5ByXOmZQgOUKoyAxf8t7EJDqP6dVCVdVgSa0Jtk=; b=Kpz3ts+GahipNYkQ0Btb2bXdb1
	TBcPbtJXFf1EgOAn6sa7gqHMn+GbWD+3wJwyY1CXtlX38SQCj+wLSJyyeQmyqODSP3gtnxKggcPXG
	8Rc00wWoYfi2+DzZJ2cFUazfqYPqnHXEufcYp1Pfk91T0RApdE/11DnXeqZV2zyfgYzI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIJ3J-00F1ZH-ML; Tue, 03 Dec 2024 03:54:17 +0100
Date: Tue, 3 Dec 2024 03:54:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Subject: Re: [PATCH 2/2] net: phy: realtek: add dt property to disable
 broadcast PHY address
Message-ID: <ae46016c-c391-42c1-854e-075e7ee03a62@lunn.ch>
References: <CAHwZ4N0gbTvXFYCawbOUFWk7yitTeAWwUmfmb7RU68n-md8x4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHwZ4N0gbTvXFYCawbOUFWk7yitTeAWwUmfmb7RU68n-md8x4Q@mail.gmail.com>

> > I think you can do this without needing a new property. The DT binding
> > has:
> >
> >             reg = <4>;
> >
> > This is the address the PHY should respond on. If reg is not 0, then
> > broadcast is not wanted.
> >
> First, broadcast has no relationship with PHY address, it allows MAC
> broadcast command to all supported PHY on the MDIO bus.
> 
> I can't assume that there's no user use this feature to configure multiple
> PHY devices (e.g. there's like 3 or more PHYs on board, their address
> represented as 1, 2, 3. When this feature is enabled (default behavior),
> users can send commands to address 0 to configure common parameters shared
> by these PHYs) at the same time.

phylib does not do that. Each PHY is considered a single entity. User
space could in theory do it via phy_do_ioctl(), but that is a very
risky thing to do, there is no locking, and you are likely to confuse
phylib and/or the PHY driver.

So we don't actually need the broadcast feature.

> Again, the broadcast address is shared by all PHYs on MDIO which
> support this feature, it's handy for MAC to change multiple PHYs
> setting at the same time.

Please point me at a MAC driver doing this.

> I would recommend to add this feature, because it doesn't change the
> behavior of this driver, and allows this PHY works together with
> other PHY or switch chip which don't support this feature, like mt7530 or
> Marvell ones.

I agree we should be disabling this when it is safe to disable, but i
don't agree we need a new property, reg is sufficient.

	Andrew

