Return-Path: <netdev+bounces-159307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B62A1509A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0B83A53B6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB561FF7CF;
	Fri, 17 Jan 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L/ZvofIg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5C1FF61D;
	Fri, 17 Jan 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120983; cv=none; b=doeXTWt0ge/coM/w14FMg6MsC8D3eN5OBwbRZxEXVcSeHvbdAgt08zfaTUZ7Pnm2acsT9ngi2yg9EKPUIRAtW4cUzxTYBaqLNHEZnYv+g2JGPKbFiY6yRgO6ZmcuG/1LPzQABWg0chmKRjzt1AFx0uAz24wbB6tw993TUI8DXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120983; c=relaxed/simple;
	bh=mnCt0+GcneoP9kR4t8VIpytKEA0zAIYPNbXWrDKuiyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeSQDqKhfYfBKjRTjzr6Emr4kUKz7f96A4e0Ylle/q3Rtnv0h3/o1xhFrc7pN/2kgLLqbVywT7l46uFEe/vUrKOok/GBBFWC5zYZ+JoWbutByRY75UjRE/PRogzpGGejiWRCc6LjN2Kh5ak+S+ARItJiDZbCjdrsfGA7evQACR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L/ZvofIg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0ksF4VTXO4nIdy/fGUmkRzfewgZbZN5fWTY4cZ+I/Ow=; b=L/ZvofIg7THDmstvI6qKouyAB+
	WZW6lWFPkuW7ue8sCEjUBMRgl2Q18OwmNeyUWF7JqMTbULu24Q6E43HmXDtuLO2SzjO7Sbp+eDY9m
	c1gyT7Q9qPrsPUxdgY0m2xJetorM26QiBVQgasLBiisUILQJNPPOvmj4hKyz0SnZZpiA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYmWD-005SM0-A2; Fri, 17 Jan 2025 14:36:13 +0100
Date: Fri, 17 Jan 2025 14:36:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: maxime.chevallier@bootlin.com, olteanv@gmail.com,
	Woojung.Huh@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
 <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>

> The KSZ9477 SGMII module does use DesignWare IP, but its implementation
> is probably too old as some registers do not match.

Is there a revision value somewhere in the registers? Maybe the lower
nibble of ID registers 2 and 3?

> When using XPCS
> driver link detection works but the SGMII port does not pass traffic for
> some SFPs.  It is probably doable to update the XPCS driver to work in
> KSZ9477, but there is no way to submit that patch as that may affect
> other hardware implementation.

We have PHY drivers which change their behaviour based on the
revision. So it is possible. And XPCS is used quite a bit, so i don't
think it will be an issue finding somebody to do some regression
testing.

Using a PCS driver is the correct way to go here. So either you need
to copy/paste/edit the XPCS driver to create a version specific for
you hardware, or you need to extend the XPCS driver so it supports
your hardware.

	Andrew

