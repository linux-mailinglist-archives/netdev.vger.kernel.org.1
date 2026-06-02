Return-Path: <netdev+bounces-293987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBm9JohHHmomiQkAu9opvQ
	(envelope-from <netdev+bounces-293987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA26277FA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04236300CCA3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE44360751;
	Tue,  2 Jun 2026 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0tAwr1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49E331A56
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369284; cv=none; b=nrpqfKeK9jrwHNwIanRc36tUgnQOS+tvycLrGj89sGd21hNvgx19VnBpUHrrbhC6WC8PGImvDKnQLt+dNSxLGMI+0troXPZDMD+DPKRoKGNYfnPPI8M5cojo3knN6G8KljShdiLj+A6Insisbt87jxUjB/c82Qs9B1O3Y626rRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369284; c=relaxed/simple;
	bh=wmDfSUCe/o6nw2WKgF3nqFzmLj1E0LIQHqICd8jCXBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3pgLH8FFoT+iPpfeaoFi9+wiFmiYxnLLqiuiqlFYDCdaR9aBi4Fe+cY97fEAPDrHfTwGSJbrsqimfXEJNfuG6NZqCR1Q8o0cu0jKgF7SsnqPpG7BzeOOvRhaWoRbyTy2hXeTwwPfdiuI2+PzozguZT8lBk89iVS7lnuyGI3MZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0tAwr1y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A801F00893;
	Tue,  2 Jun 2026 03:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780369283;
	bh=YqLEiPWVNevLH0fRCbZHcNaExbbQ6VODrV8Sq6lkEVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d0tAwr1yEHeJpkAhlDdBnLLlLcROzKQgaNReoTFNpLLLUhBdx8jLb/BQ0Y13Kc78J
	 CYmI1ub9S+9p3RlglsJ1t6UhCeULYHm2OBMRSxEkP5XGy5Ri4E3xQaJiQEN67NHVOn
	 FIw//Cr9jD34ptl+D/O1fT+ZFe2a+ysfZbp2qGBod4hH+qrWTl8Z1YCB7SI0f9dHqp
	 PnJP/oAQeobwWPFe4boJC93jEe7u1sJX7ojJkKX7eWXAYQNpUbB6R6pAQxylmIVmZe
	 wNi4/Eqmomrf8hLLN44RfDyDtHWp1+Rr4BAVcQ7Cg0aaN5ZUxrfTScJ2UoLI/t6vPV
	 KzqjbaGtEM9Ug==
Date: Mon, 1 Jun 2026 20:01:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/2] net: phy: dp83822: Add optional external PHY
 clock
Message-ID: <20260601200122.17d1cea2@kernel.org>
In-Reply-To: <20260528184642.33424-3-wahrenst@gmx.net>
References: <20260528184642.33424-1-wahrenst@gmx.net>
	<20260528184642.33424-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293987-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1DBA26277FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 20:46:42 +0200 Stefan Wahren wrote:
> In some cases, the PHY can use an external ref clock source instead of a
> crystal.
> 
> Add an optional clock in the PHY node to make sure that the clock source
> is enabled, if specified, before probing.


> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index d8c5b5cd1bc0..6fc86be9d593 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2017 Texas Instruments Inc.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/ethtool.h>
>  #include <linux/etherdevice.h>
>  #include <linux/kernel.h>
> @@ -986,11 +987,18 @@ static int dp8382x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
>  	struct dp83822_private *dp83822;
> +	struct clk *clk;
>  
>  	dp83822 = devm_kzalloc(dev, sizeof(*dp83822), GFP_KERNEL);
>  	if (!dp83822)
>  		return -ENOMEM;
>  
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to request ref clock\n");
> +	}

nit: unnecessary parenthesis

The AI says:

  Does this initialization sequence violate the DP83822 power-on
  requirements? The PHY framework deasserts the hardware reset line before
  invoking the probe callback. By enabling the external clock here, 
  the clock starts after the hardware reset is already deasserted.

  The datasheet requires the reset signal to be asserted for at least 
  50 ms after power and clocks are stable. Without performing a subsequent
  hardware reset here, could the PHY be left in an undefined state or
  lead to initialization failures?

Did it really read the datasheet or is this a hallucination?

FWIW it also says:

  Should this clock pointer be saved in the driver's private data
  structure (struct dp83822_private) instead of a local variable?

  Without storing it, the dp83822_suspend callback cannot disable the clock
  when Wake-on-LAN is disabled, which could prevent the clock provider from
  entering low-power states.

