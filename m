Return-Path: <netdev+bounces-188626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F57AADFAF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CC189E8A8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B22580DD;
	Wed,  7 May 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y78dUSxU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B625A33F;
	Wed,  7 May 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622155; cv=none; b=b0Hi6Ta+1Hwm+T2wf0jAly7gwLRB6nyBUSYDs4ON3ghm7LirD74LSzHQP757LV5xtOF00TvKWp/GPfBQvVn1iF1lKc5sNdfQvCs/2RCmyzaEdUcuWp+z4kAsBCD3V/YyFLKGdRUoxg+cJQRS2+PdxItgC/ztfSFR7dPDPjkbk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622155; c=relaxed/simple;
	bh=9tfcbSp3IEb5qilLXp6Yc87E8IScpkgEXHfbqKkYZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuUKVe0hgAoGFAzi+snT971KMhZsZrxmsyjNHloYVAN2F8G951iaZbcBmVKWBCVSydX3Ms0lnf3ICUa8VTx7GEYG77UFtBJaNMkM81/9uNKm4kBFn2tOujAjnIAYruG9lejdmkVuBxNu4nfitnDdEQKMelExI1bbM8g9xtNGRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y78dUSxU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8SEDqd8rTyWU6DLmTV3kRN5HRkf2oVcmGX0hCAh0wmw=; b=y78dUSxUN3YElhCDppsreeHbew
	PNO5bNqL8mS0t5QSzKWYOxC4uAz/l8Nu8Qyln3EvpwlyrPNHfHe1VRsI1xnW19V8FCronUSDBK9eD
	WrR6xWQcis9EhLXaSQ33HpDCmsKfSM6x5gZ7RRTjtL2GcedAZn6+1e8PNOIQ9mmlY48Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCeCv-00Bsgh-GB; Wed, 07 May 2025 14:49:05 +0200
Date: Wed, 7 May 2025 14:49:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Message-ID: <5ecf2ece-683b-4c7b-a648-aca82d5843ed@lunn.ch>
References: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
 <aBs58BUtVAHeMPip@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBs58BUtVAHeMPip@shell.armlinux.org.uk>

On Wed, May 07, 2025 at 11:46:08AM +0100, Russell King (Oracle) wrote:
> On Wed, May 07, 2025 at 08:17:17AM +0200, Heiner Kallweit wrote:
> > MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
> > select MDIO_DEVRES. So we can remove this symbol.
> 
> Does it make sense for mdio_devres to be a separate module from libphy?

I _think_ Broadcom have one MDIO bus master which is not used for
PHYs/Switches but regulators or GPIOs or something. In theory, you
could build a kernel without networking, but still use those
regulators or GPIOs. But given that Broadcom SoCs are all about
networking, it does seem like a very unlikely situation.

	Andrew

