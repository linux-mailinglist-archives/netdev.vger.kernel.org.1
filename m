Return-Path: <netdev+bounces-88329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFF8A6BAE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDF01C21888
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4A12C475;
	Tue, 16 Apr 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xz200249"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9812C476
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272283; cv=none; b=C2LxGBV6KTnU1nwm14MtXzcnMuYi+zQMkJgR/Vt1nFmKVHpHSNemNoYfMedI2y+5KxSlTAw1ykUa72ussKadiEn7h6TvK0cuHfXmawrYcFug4k6I/2y1HQKOtyuEu/H8hKQTmwdOPz9miVLHjvzuRvnitc+awlMY7lIIF+iJE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272283; c=relaxed/simple;
	bh=4oH+g5yRCwMfIEAAG392Pt5nGPERVVhuatHgP36YYQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0Conrd5N2rRN1vOLd5rJI3afQwwtt4X7AlxjR62buCGU8sjAT/9Vc9YkKAW0iXCRLgOeb5zkdsTUpbo2pSRiIVIwCWCvRBr2hsVdg9DuduHW5tObF08z+jZJLRNS2q+eTW8p3NrTvHJlePFLwt9SkzOxfu+DXvWkwKWPFvaYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xz200249; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hMYKr5shDZXOKEUgK/JHp1Ux6zqCCtDmK7bt9Qj6La4=; b=Xz2002493UWyD2DHrrZFxr7KNs
	lcVn7syrIhvUr0uow6z17DdKdqDJUrJRnqrYoTFiLEx7y0h9EVe5qGsdFlNpha09C7MU8IBcn/iRU
	nIboZ/0zJXDWCSoHlAvm6JrDdp3EHsZkvUUUufW0t2eqL9mb8SWPKdE8zsPzELGhzDUQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwiNq-00D8TE-RQ; Tue, 16 Apr 2024 14:57:58 +0200
Date: Tue, 16 Apr 2024 14:57:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
Message-ID: <daf9400f-c7e0-4f76-9a8d-977d9f82758a@lunn.ch>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-6-fujita.tomonori@gmail.com>
 <7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
 <20240416.211926.560322866915632259.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416.211926.560322866915632259.fujita.tomonori@gmail.com>

> > Are there variants of this device using SFP? It might be you actually
> > want to use phylink, not phylib. That is a bit messy for a PCI device,
> > look at drivers/net/ethernet/wangxun.
> 
> phylink is necessary if PHY is hot-pluggable, right? if so, the driver
> doesn't need it. The PHYs that adapters with TN40XX use are

There is more to it than that. phylib has problems when the bandwidth
is > 1G and the MAC/PHY link becomes more problematic. Often the PHY
will change this link depending on what the media side is doing. If
you have a 1G SFP inserted, the QT2025 will change the MAC/PHY link to
1000BaseX. If it has a 10G SFP it will use XAUI. phylink knows how to
decode the SFP EEPROM to determine what sort of module it is, and how
the PHY should be configured.

To fully support this hardware you are going to need to use phylink.

> >> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> >> index 4198fd59e42e..71f22471f9a0 100644
> >> --- a/drivers/net/ethernet/tehuti/Kconfig
> >> +++ b/drivers/net/ethernet/tehuti/Kconfig
> >> @@ -27,6 +27,7 @@ config TEHUTI_TN40
> >>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
> >>  	depends on PCI
> >>  	select FW_LOADER
> >> +	select AMCC_QT2025_PHY
> > 
> > That is pretty unusual, especially when you say there are a few
> > different choices.
> 
> I should not put any 'select *_PHY' here?

Correct. Most distributions just package everything.

We are going to get into an odd corner case that since Rust is still
experimental, i doubt distributions are building Rust modules. So they
will end up with a MAC driver but no PHY driver, at least not for the
QT2025. The Marvell and Aquantia PHY should just work.

Anybody who does want to use the QT2025 will either need to
build there own kernel, or black list the in kernel MAC driver and use
the out of tree driver. But eventually, Rust will start to be
packaged, and then it should work out O.K.
 
	Andrew

