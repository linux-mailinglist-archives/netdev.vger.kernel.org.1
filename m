Return-Path: <netdev+bounces-119719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD78956B7B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1368A1F22D4F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69ED16BE0A;
	Mon, 19 Aug 2024 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fl3ez20D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03CF16B3A3;
	Mon, 19 Aug 2024 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072777; cv=none; b=fe6BbP3F5LHUYHlxkTF51g1KnQz4Ba5sLjUCrdEHGj/PkteZz8qDjEFHPRpzDgH/gxfQrX97tJlRxBAbfaacwEDGrfXFiqUmJ2ao9iRdfrLsZTw4m50gsP3+cAjtQtBjNlNAwzcedcXnfz7GDGpuUJEGFLnSpTVsRC0MWKNxz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072777; c=relaxed/simple;
	bh=yPwQtu9ii2BFF0lOQKZTMHXm0Gd9E+ARgop2ih/NtuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvMwYWOrgceIUtuA+14XqCq3IcYzTHfuzoHv+F3sWz9uhr9z47kZlJnuXqqcP9fDHQ2i2VnPmwChxhCFbReOY5ZF5BMkzLX2vuC3p/0tiMxTL5FMpnpftkXnvGJ61pSyPAQXJoGDf4SyhmRmM/e1N0LHLQiYrxp4iChc7DsM1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fl3ez20D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0knCb73dTbdc2liwQDi4LPRFKeoN3hTyrb5NdFVz+JY=; b=Fl3ez20DicjjSWqBkCfS/wYW2o
	ZN+GCtG/6LESIC6Tmo5tCy369LCjv1yf9WPrdPmKox6D10GOrcQwcIEaNEvtQk4H0iMmJNewX92YP
	X32c9WqhzIrBFhIqKKC7ard88PERzpB1z32KU4WdPJ5/aABnX8PAk0agLRKhvRhvAw8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg256-0056ya-SE; Mon, 19 Aug 2024 15:05:56 +0200
Date: Mon, 19 Aug 2024 15:05:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pieter <vtpieter@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>

> Previously I could not use DSA because of the macb driver limitation, now
> fixed (max_mtu increase, submitted here). Once I got that working, I notice
> that full DSA was not a compatible use case for my board because of
> requiring the conduit interface to behave as a regular ethernet interface.
> So it's really the unmanaged switch case, which I though I motivated well in
> the patch description here (PHY library, ethtool and switch WoL management).

If its an unmanaged switch, you don't need DSA, or anything at all
other than MACB. Linux is just a plain host connected to a switch. It
is a little unusual that the switch is integrated into the same box,
rather than being a patch cable away, bit linux does not really see
this difference compared to any other unmanaged switch.

	Andrew

