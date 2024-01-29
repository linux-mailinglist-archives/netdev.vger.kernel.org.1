Return-Path: <netdev+bounces-66550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CA83FB25
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 01:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47DE1F2352B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9C18F;
	Mon, 29 Jan 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cYLszG+L"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E538E
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706487027; cv=none; b=SjWoEfY0eJ4ZE8wX7UFMj9w+RdzzpNX728WHfrJZ3+O4NKL5A0sjuAkQ9V9ivkHLtcR6viVdIqI2LKsVtNQ93Xnbuyj9zuT2spy7p/rdH44iHHJoVJCwqhwbBWziM6/vuqZiJ24j78GZgghg4Ar8bdBUEXiIMz1ejWWwZ/MXNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706487027; c=relaxed/simple;
	bh=SWw0pzIE1rSLYBAGalXiyiUY/FhQBA6pz+n1xviIq6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX5LO1KZSoM++4xFfilTD/vqWSJqv1q0zKj6fV3KoMX4uB8PVOozs/qpB/L9rcp9lONAA1vMpmXa5Y5rQxPAY/gKmeLI8U56AfDSPKx+IWTCUnLZRX/lzA/lwper8V3A4gR9f2cJj2IwIga03ntbOiaBdamZsNvLyWcmjsflX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cYLszG+L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UcXmIojW85Si8A8d5aAY6U+CsLU70ONaYzpdhdboJr0=; b=cYLszG+LBNk3STE0fpkSyfpsDu
	2O28HzfK6uhZ1vIQIehT5YgyhMd9kLmPAkWBmGCUKoaXBmMK3Xf7C5b6KeoDHTwvYQI++wMADvjWS
	omL4TloT/b59ohOBETT8i/FxLAliexNdwSNhBQgfkCY5xZ4XGHUbifCPCVA+XNPRHMrM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUFE9-006Koc-Oi; Mon, 29 Jan 2024 01:10:17 +0100
Date: Mon, 29 Jan 2024 01:10:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/6] ethtool: switch EEE netlink interface to
 use EEE linkmode bitmaps
Message-ID: <0a352643-8cc5-47b7-b31c-dc36ec69fa19@lunn.ch>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>

On Sat, Jan 27, 2024 at 02:24:05PM +0100, Heiner Kallweit wrote:
> So far only 32bit legacy bitmaps are passed to userspace. This makes
> it impossible to manage EEE linkmodes beyond bit 32, e.g. manage EEE
> for 2500BaseT and 5000BaseT. This series adds support for passing
> full linkmode bitmaps between kernel and userspace.
> 
> Fortunately the netlink-based part of ethtool is quite smart and no
> changes are needed in ethtool. However this applies to the netlink
> interface only, the ioctl interface for now remains restricted to
> legacy bitmaps.
> 
> Next step will be adding support for the c45 EEE2 standard registers
> (3.21, 7.62, 7.63) to the genphy_c45 functions dealing with EEE.
> I have a follow-up series for this ready to be submitted.

I tend to disagree. The next step should be to work on each driver
still using supported_32 etc and convert them to use plain supported.

What i don't want is this conversion left half done. I said i'm happy
to help convert the remaining drivers, so lets work on that.

My happy to merge this patchset, its a good intermediary step which
allows each driver to be converted on its own. But i'm likely to NACK
EEE2 until the _32 are gone.

     Andrew

