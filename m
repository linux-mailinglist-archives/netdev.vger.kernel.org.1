Return-Path: <netdev+bounces-152488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208339F4314
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8F188C9CB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC4157A46;
	Tue, 17 Dec 2024 05:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C314D456
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414087; cv=none; b=Nu6CHwzNJ2hsMa2oV4JqacE+ubazeM5mWprPyQWIyRlhylOmuLTnbUIfU1257Dq4pC/li8VrxW32XydCB4kBevqoM0thRgvELX+wCY0qMJ0v0UFF4fC10vWqwZ6v+DhUKiaOmTTbzatIErwhaG0RZCvkV7Ky1XfE+yNnWPC1Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414087; c=relaxed/simple;
	bh=YIAgPx6TjU0VovQcp2U+hPkdjSUxehbsWh4alTYkSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iItYaRgGq3HaThj/82JlRyjVcIIoAQ4lF7DexcFKi2UbyTwKyvJmKyJhC6lo0b1sJPJEUPNjeMwuIiQCXI2/DC/fPEoLcRBn4cnth7aKDnffOuQincmCqMR/Ico28xd7XnZyi0CMMbqL63lI1PojPHF27i7GtRUjuuYaVLx53yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tNQKE-0004cp-Ul; Tue, 17 Dec 2024 06:40:54 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNQKA-003oTV-2K;
	Tue, 17 Dec 2024 06:40:51 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tNQKB-004RXK-1E;
	Tue, 17 Dec 2024 06:40:51 +0100
Date: Tue, 17 Dec 2024 06:40:51 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <Z2EO45xuUkzlw-Uy@pengutronix.de>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
 <e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
 <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
 <20241210063704.09c0ac8a@kernel.org>
 <Z2AbBilPf2JRXNzH@pengutronix.de>
 <20241216175316.6df45645@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216175316.6df45645@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Dec 16, 2024 at 05:53:16PM -0800, Jakub Kicinski wrote:
> On Mon, 16 Dec 2024 13:20:22 +0100 Oleksij Rempel wrote:
> > On Tue, Dec 10, 2024 at 06:37:04AM -0800, Jakub Kicinski wrote:
> > > > I certainly can't help but write the "returns" statement in natural
> > > > English, rather than kernel-doc "Returns:" style as can be seen from
> > > > my recent patches that have been merged. "Returns" without a colon is
> > > > just way more natural when writing documentation.
> > > > 
> > > > IMHO, kernel-doc has made a wrong decision by requiring the colon.  
> > > 
> > > For the patch under consideration, however, I think _some_ attempt 
> > > to make fully documenting callbacks inline possible needs to be made :(  
> > 
> > Please rephrase, I do not understand.
> > 
> > Should I resend this patch with corrected "Return:" description, or
> > continue with inlined comments withing the struct and drop this patch?
> 
> I'm not talking about Returns, I'm talking about the core idea of
> the patch. The duplicate definitions seem odd, can we teach kernel-doc
> to understand function args instead? Most obvious format which comes 
> to mind:
> 
> 	* ...
> 	* @config_init - Initialize the PHY, including after a reset.
> 	* @config_init.phydev: The PHY device to initialize.
> 	*
> 	* Returns: 0 on success or a negative error code on failure.
> 	* ...

It will be too many side quests to me for now. I can streamline comments
if there is agreement how it should look like. But fixing kdoc - I would leave
it to the experts.

What do you prefer, proceed with stats patch without fixing comments or
fix comment without fixing kdoc?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

