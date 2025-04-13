Return-Path: <netdev+bounces-181978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A348EA873D1
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDAA1893381
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FC1624C9;
	Sun, 13 Apr 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b+mAuese"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418F134CF;
	Sun, 13 Apr 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744576419; cv=none; b=HLm/IZRWG5tl7V9FNh6Hw+vMlSgog9m6J8M4V/FHUU6xBhDkx9xibZTNg4xTyTh7PMrfTaz8UPq/cK9MgL+HL3U+NU59RuvocA2iksrzyVvP+9RlWfqsZ16YtVfWNUNn7ld9OJJsGtTTLNb7yeCZxLwmh/J08rMsBH0kFElE+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744576419; c=relaxed/simple;
	bh=WB4Yla/3Tg0ZtllH2jQcdl22/LiuvuNCfqdh6jpH2Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlMDx3udmX21lSwUlvG3FjKV46btk0KbW1FaNubEDevOKdSufrGct6IFW3qEZ/15tL2E4w/ZeKkBbNw0XxqX5f2rFkZOjG19HyapXP9AjRIXhQMzwSymHQJXLghLUvWNJd0soqLFInA0QTgt9RHQI+qlXK4NxnHqFasfd0GWvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b+mAuese; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4suwe0GPghGVOUBQOhjESsEsml3JzRYI5cuxzx0xBqk=; b=b+
	mAuesefucksWwDFb5CqmhRU+CyhnMXJS7vJZpj6JBC65+fE6yta+glE2+wYimYkYrbydxagW5IRh2
	p256uRvACRqA1UsBGj7GZOFQhI/cOruTxAnj3m7OGiH9agsx7ixlSeaZh5nV7XyOH8/t78BGKpq99
	24DaJ8TObQA8Tb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4411-0095wc-Qy; Sun, 13 Apr 2025 22:33:19 +0200
Date: Sun, 13 Apr 2025 22:33:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com, linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>, lee@trager.us,
	horms@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
	geert+renesas@glider.be, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <4fac4c4f-543b-4887-ace9-d264a0e5b0f2@lunn.ch>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
 <Z_T6vv013jraCzSD@shell.armlinux.org.uk>
 <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da434f13-fb08-4036-96ed-7de579cb9ddc@motor-comm.com>

On Fri, Apr 11, 2025 at 05:50:55PM +0800, Frank Sae wrote:
> 
> 
> On 2025/4/8 18:30, Russell King (Oracle) wrote:
> > On Tue, Apr 08, 2025 at 05:28:21PM +0800, Frank Sae wrote:
> >> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> >>  and adding yt6801 ethernet driver entry in MAINTAINERS file.
> >> YT6801 integrates a YT8531S phy.
> > 
> > What is different between this and the Designware GMAC4 core supported
> > by drivers/net/ethernet/stmicro/stmmac/ ?
> > 
> 
> We support more features: NS, RSS, wpi, wol pattern and aspm control.

Details please as to why these preventing the stmmac driver from being
used? Our default opinion will be that you will extend that stmmac
driver. In order to change that, you need to give us deep technical
arguments why it cannot be done.

> > Looking at the register layout, it looks very similar. The layout of the
> > MAC control register looks similar. The RX queue and PMT registers are
> > at the same relative offset. The MDIO registers as well.
> > 
> > Can you re-use the stmmac driver?
> > 
> 
> I can not re-use the stmmac driver, because pcie and ephy can not work well on
> the stmmac driver.

Please could you explain that in detail. What exactly does not work?
What is stmmac_pci.c about if not PCI?

	Andrew

