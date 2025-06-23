Return-Path: <netdev+bounces-200388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2524FAE4C5F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CD71899B9F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAE7288509;
	Mon, 23 Jun 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sbYZ9CCi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29A3D3B8;
	Mon, 23 Jun 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702089; cv=none; b=l0fi/dFUSBdmseofqgPWDE5cobIHl+rACfT9eHe5p7Kden2ofqfvBuc3iKdEmp+GHBV2psObbEDaYIIC34xyFzm7pP3t1nJV7CbLejhMHMVP8IOk1n91HHtWc2rQdO4giazmwwWBC/C4WX3LJ+5mYGpP2WZtZuY7LeF4pbQbLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702089; c=relaxed/simple;
	bh=Gw540lB0qabRIZFGSF4pGyXdG9OF01rsvzlqXNqrokc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ2HfRp8ZYvSShY/jE+nQ2bqj7qU4i2D9vwntbxRcwCOizaYd3jpExa5SuMK8YuvyhfW8Q99xXuZ1OOaVsGTI0qXLtuOAxZYPVNXsNW2kndu/4ZYSmXBO3vESHtEkYVZfIojpzn+KBk1LvciqYuMFOk/JWAPVKWj7GMxE7FA/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sbYZ9CCi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yCA/0vxCehhKCbkvvXTKnnxxPDifpNSysmytY+aC5N4=; b=sb
	YZ9CCiRGyd2ufC69Xq2kqmGPegvuDSEIRdhVkJ9yrxhSKXqgG6RYUyRH/Wt0Z25krp+oDKUpqkDgP
	s3kePd9IFH4NQfPNnUWtvq90qG3kZe3o005KuQRtEGKDs9loxw7c3MOsi0G6DS7uzP1HdeMbb2X52
	8muWPSW7x8FZNDU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTlaK-00GiYi-Az; Mon, 23 Jun 2025 20:08:00 +0200
Date: Mon, 23 Jun 2025 20:08:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: bcm5481x: Implement MII-Lite
 mode
Message-ID: <846f7b15-250f-4e76-99b3-f208768aab32@lunn.ch>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623151048.2391730-2-kamilh@axis.com>

On Mon, Jun 23, 2025 at 05:10:46PM +0200, Kamil Horák - 2N wrote:
> From: Kamil Horák (2N) <kamilh@axis.com>
> 
> The Broadcom bcm54810 and bcm54811 PHYs are capable to operate in
> simplified MII mode, without TXER, RXER, CRS and COL signals as defined
> for the MII. While the PHY can be strapped for MII mode, the selection
> between MII and MII-Lite must be done by software.
> The MII-Lite mode can be used with some Ethernet controllers, usually
> those used in automotive applications. The absence of COL signal
> makes half-duplex link modes impossible but does not interfere with
> BroadR-Reach link modes on Broadcom PHYs, because they are full-duplex
> only. The MII-Lite mode can be also used on an Ethernet controller with
> full MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive.

So everybody seems to be a general agreement this needs more thought.

How does a MAC know its RXER, CRS, COL inputs are inactive? Are you
expecting boards use pull up resistors? Or is the MAC driver expected
to poke around in the PHY node and find this lite property? That would
not be accepted. A phy-mode make would this clear, but it does require
every MAC which could be connected to this PHY needs to also accept
this PHY mode. Which comes back to, are pull-ups enough, so the MAC
has no idea it is connected to a -lite PHY?

	Andrew

