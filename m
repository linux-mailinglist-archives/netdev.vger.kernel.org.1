Return-Path: <netdev+bounces-177823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE99A71E88
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4097A2E5B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E624CEE3;
	Wed, 26 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VudsCLYv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10F215058;
	Wed, 26 Mar 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014292; cv=none; b=jIZht0GQ3AsXHBYyxBxn0m5chYVIa7O1yhP5xZtf2GPTMus85j6dOfksRsAtDA4m4EUPYk4I1py74XRcxEDyFZ6km/YIIHVdy0Ev4YfZ5XaPKjF6omw+qOdblM8MF4c3dNrFyjWLypNUUvBKwaHGnktl6h2i87D0NJ1lhyoRsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014292; c=relaxed/simple;
	bh=1t7xODy4KH9rbWcPUjlVK/xwCOzHA+TpyiyRoAef0o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxVX/rt3DYe4bPvyb0SeGIqSIkrnL5I4EtCRNx/N3drEuwGE6Pzco3LP0Jii1BADSFgLbUcrgqIfCSQyAfWiS+MPdjBgQvaFfnLJ4K+ctvnZUgf7cPn2wz58YrWz9/df5wGAMB26SHewLOKWn1x3Eo/Xey+B4iCVNZLho9ALktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VudsCLYv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HsaZBwcIMs6THkgSKphP0b6hPFh+WRNHRlYSs0zUBAQ=; b=VudsCLYviQlgmSrK+6NYoTkxD1
	a1kGIbl4zzF4rgUHHpNbxB1gnYglkfIGFvTu1h8wpJq19/iVkK8mhYjxYKIrxgiDEeBdupKxnBNTX
	RRmB70l/ZQh6ppGtCCVUSleGXWIiiVEMKJdAuubuEB4wrAplAKqrXS0JBOs9hQNZh4sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txVdX-007Cha-4S; Wed, 26 Mar 2025 19:37:59 +0100
Date: Wed, 26 Mar 2025 19:37:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: dsa: felix: check felix_cpu_port_for_conduit() for
 failure
Message-ID: <3370aa96-a320-4b8e-b37b-b8100094d3c9@lunn.ch>
References: <20250326161251.7233-1-v.shevtsov@mt-integration.ru>
 <dc85eb72-cdec-43a1-8ad7-6cd7db9c6b25@lunn.ch>
 <20250326232929.809a37357877ef3168dfc097@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326232929.809a37357877ef3168dfc097@mt-integration.ru>

On Wed, Mar 26, 2025 at 11:29:29PM +0500, Vitaliy Shevtsov wrote:
> On Wed, 26 Mar 2025 19:22:07 +0100, Andrew Lunn wrote:
> 
> > If i'm reading the code correctly you mean ocelot_bond_get_id()
> > returns -ENOENT?
> > 
> > If so, you should return the ENOENT, not replace it by EINVAL.
> > 
> > 	Andrew
> 
> Or maybe it's better to just return negative cpu value instead?

Yes, that is what i meant. The typical pattern is:

			int lag = ocelot_bond_get_id(ocelot, bond);
			if (lag < 0)
				return lag

	Andrew

