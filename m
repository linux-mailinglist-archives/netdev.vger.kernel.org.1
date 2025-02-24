Return-Path: <netdev+bounces-168881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC109A4140F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 04:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F477A5078
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415B1A5B92;
	Mon, 24 Feb 2025 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NFMZ5l7Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538DCF510;
	Mon, 24 Feb 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367968; cv=none; b=F3KiQzANQG0MC2vTMPfpd+LsyMUfMyGlsUBd2qDLMYKiE6uE/vNDfqJAZaT/dJIbf9D8WTT9QwykeQyzzZCjrCDWIJX8l5ttPFvkFcV0ei12F6ArTIX+LaGUN3/F3YArBy4OY/DA042bqUNEohWN2mCQqX8kOq2HHU4oX+5WST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367968; c=relaxed/simple;
	bh=I0LUpuGqWrFRQZA2gvT1xXgplSQj+jWqnvTfsiQjC44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiH+VpYLc4apRocHmJ/m5J1VQtqwb0ZEXzCigzYJxMd8LKux/yXykLDGp25nfuSjDn6yAoX2NFUNP9t8+QMsF/sx7xogQnthE35zg9A/m4iCbBX9e7kmivnybaMXVyREWLhMbKx2cySIxvJ6qk+uYI6Bve/PYZ5gP7vTCWn0NUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NFMZ5l7Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mt5iAw9fIPP/4TCXO3fsICmQc2owlHYI9R2MBfTvz1U=; b=NFMZ5l7QPtmTdbsAFUkiWRsUU8
	RrbaJp2uqe5nikf8LyMe6336Hse3MPec33uHitd7hA0/1oeKYLo6Hh2CUivzi6yHpUIknZepUfO6d
	0HWkjqpwJ38j616ngNwxGc7WWYfNpqsNQkR0aHlxGyfCgRVAPPJcBBUwtznt2Qn1m9wI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmPCn-00H1iV-PO; Mon, 24 Feb 2025 04:32:29 +0100
Date: Mon, 24 Feb 2025 04:32:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
 <87r03otsmm.fsf@miraculix.mork.no>
 <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>

> So, not only do I think that hwmon should be disabled if using SMBus,
> but I also think that the kernel should print a warning that SMBus is
> being used and therefore e.g. copper modules will be unreliable. We
> don't know how the various firmwares in various microprocessors that
> convert I2C to MDIO will behave when faced with SMBus transfers.

I agree, hwmon should be disabled, and that the kernel should printing
a warning that the hardware is broken and that networking is not
guaranteed to be reliable.

	Andrew

