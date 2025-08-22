Return-Path: <netdev+bounces-216113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43D5B32164
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9FB03F2B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59418275AFF;
	Fri, 22 Aug 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TxLFFCTE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93951150997;
	Fri, 22 Aug 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883089; cv=none; b=hqkJs39npMPzd4YMIx/F7LST95MlhuZCHaTJjKb04K+T6kfgn+If+0sTaX1lKjLuCuwg9GfPmGhk1ryL0nE7CBkJSIpGM2bY2/S79fQxoruySvxjI1z2EFJGoy5KnlaaBzwC8Zc7IBosp4lRH1YEx9xiTXZGn7UYPON0qLBHAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883089; c=relaxed/simple;
	bh=hwrq1lLw6KjKJXICYD1LyrY0tRzO1wdYV6C9hUmJ6Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnPP8GSZ/VgjF1I5rLNv3jZny43N3L784tsgbd+sYeYLEO0kNGF04i5EggrL+P4fN+lhXJRsLCU7ZDPqxzCsAelauzTD8+pi9IpcZrGTFL9R0ovnfQDWEE0eWE1tNn7N2R8EustSqr5yWgQIqsd6qtTglzVNRC0L2922bTBJFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TxLFFCTE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wvV9mGgYGu2s3zN+tea3Jt5QUjc2PHAs2MlqyU2ivQs=; b=TxLFFCTE9PpJ470k54MDStR0wN
	4StI79XiOXLUv7eBg6QBy3/9hKpbDzgxyAgN7REKlOUZy0sOBk1cVTvzMeCC8NwPmgoCvUMFB8X4V
	EZRoCB6rAWj2/6FbVFowHMLdcerI9Vzd+u7q4cXUuCmb151UiJa1gnS7QE/joGaEHX/U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upVOm-005bPL-0M; Fri, 22 Aug 2025 19:17:56 +0200
Date: Fri, 22 Aug 2025 19:17:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
 <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>

On Fri, Aug 22, 2025 at 05:37:02PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add sysfs attributes save_conf and reset_conf to enable userspace
> management of the PSE's permanent configuration stored in EEPROM.
> 
> The save_conf attribute allows saving the current configuration to
> EEPROM by writing '1'. The reset_conf attribute restores factory
> defaults and reinitializes the port matrix configuration.

I'm not sure sysfs is the correct interface for this.

Lets take a step back.

I assume ethtool will report the correct state after a reboot when the
EEPROM has content? The driver does not hold configuration state which
cannot be represented in the EEPROM?

Is the EEPROM mandatory, or optional? Is it built into the controller?

How fast is it to store the settings?

I'm wondering if rather than having this sysfs parameter, you just
store every configuration change? That could be more intuitive.

I've not looked at the sysfs documentation. Are there other examples
of such a property?

      Andrew

