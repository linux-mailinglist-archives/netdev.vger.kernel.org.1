Return-Path: <netdev+bounces-152459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6431B9F403F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A558816CD17
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C96EB7C;
	Tue, 17 Dec 2024 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTrd9dUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C32E630;
	Tue, 17 Dec 2024 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400401; cv=none; b=hx39VOTkJS9GPuuVG5vRnhc3byaNpvBnXNinvRG75jWAUVFLGKbC5uoZJF3sHx9d0nUY9FbU4bfqmsm31QVTiWQwqYPJs80VpanFEEGaxoUc1TvkTHbgn+3/Rhgje20wNCPWW+yBAe4p4h+Oc27tx3Ei+NHQyJONXJ3jYc2xMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400401; c=relaxed/simple;
	bh=cCd9LetX3I9zS6W6jciuR7KrPipj34UXM2ruuYYN6ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isMHe3aqefgre/MjklwpzY0XOjbyXczB4EH82LIB0SUIFhKY02KkVEjUxTUD6uO00EM+/N3R+ypaXGnBNbBWUXCUlBLY7riqTlaUcZ1L2865qeN3cuFbS04QRLhdN+VLsPL2zs5tfektmRyq237t3mNr2hMrDbSS1FeYgL1UTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTrd9dUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A1C4CED0;
	Tue, 17 Dec 2024 01:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734400398;
	bh=cCd9LetX3I9zS6W6jciuR7KrPipj34UXM2ruuYYN6ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KTrd9dUSKuf1G8zT0vQWaGTTV6btHD770loPvhwgefnRcuIS35NrKKAVKemn26dMH
	 1Vq3YrGwVOInX+bIip/ScVnffi4HRGD32O5AH1rFkmFIbOCY1PD63a7qQatrQXdn7P
	 t3tz00u8KizTuaLegh6+fCa7HWssMVWMsBSdU11vJAczrUKxFqeFMvL9dWDJ5YVAQV
	 Qsg5bCqoMzSEnP3D2VW/JRpIdr280Ob4HrLCE+ks3aJV3q2v5r6X4fwEeGD5cRD8zx
	 M25ernHpTG46p+I49xAQoD362flfmjSbd+uJTKIwHdvB2Mk5FaXe7pXbprgq9RoeqT
	 W/FFc+xwuZnHQ==
Date: Mon, 16 Dec 2024 17:53:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <20241216175316.6df45645@kernel.org>
In-Reply-To: <Z2AbBilPf2JRXNzH@pengutronix.de>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
	<e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
	<Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
	<20241210063704.09c0ac8a@kernel.org>
	<Z2AbBilPf2JRXNzH@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 13:20:22 +0100 Oleksij Rempel wrote:
> On Tue, Dec 10, 2024 at 06:37:04AM -0800, Jakub Kicinski wrote:
> > > I certainly can't help but write the "returns" statement in natural
> > > English, rather than kernel-doc "Returns:" style as can be seen from
> > > my recent patches that have been merged. "Returns" without a colon is
> > > just way more natural when writing documentation.
> > > 
> > > IMHO, kernel-doc has made a wrong decision by requiring the colon.  
> > 
> > For the patch under consideration, however, I think _some_ attempt 
> > to make fully documenting callbacks inline possible needs to be made :(  
> 
> Please rephrase, I do not understand.
> 
> Should I resend this patch with corrected "Return:" description, or
> continue with inlined comments withing the struct and drop this patch?

I'm not talking about Returns, I'm talking about the core idea of
the patch. The duplicate definitions seem odd, can we teach kernel-doc
to understand function args instead? Most obvious format which comes 
to mind:

	* ...
	* @config_init - Initialize the PHY, including after a reset.
	* @config_init.phydev: The PHY device to initialize.
	*
	* Returns: 0 on success or a negative error code on failure.
	* ...

