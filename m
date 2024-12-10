Return-Path: <netdev+bounces-150710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A59EB384
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BA01883C41
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E51B394E;
	Tue, 10 Dec 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmmhdpNK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED61B21A0;
	Tue, 10 Dec 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841426; cv=none; b=VqOyRJrlq5Cr3d1eEJ76mSXyDRqMpPmP9DYrxGQwelWQsoMqaslBvy++DYCA4N1e2LANVyg1nWsHD5TaviDIXbbjslCb9WnDEk8RIrfXi5F7NDLv+vSfe9G9HeIZNb9SpxjT2ZhQTwM8UcTuZPTof0oZK9RkGYLx8t1U6W0tZy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841426; c=relaxed/simple;
	bh=0zTO85Ef0r5vwedW1R+Oz3DQpMhOwp9gRtoPw4cpcvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dpr4OPwMvm2fBb/EkC0BgV9dtlrVDZLH96F40R0tOERmIhjZJzvdMRUi3H0PJbymKnlzSdwRlDMVUDTTdBBaxiQ49LHYKZQoPjHB6l4jRa8PbAO+ZWxO9VeEcoYM8al7MJpWcYSQjXQlRpw621irG2cD9mWEzftWTxChGm1Trpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmmhdpNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26122C4CED6;
	Tue, 10 Dec 2024 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841425;
	bh=0zTO85Ef0r5vwedW1R+Oz3DQpMhOwp9gRtoPw4cpcvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bmmhdpNK5lajnWc8RWTrVAIWk3x/s2bEnYFJy/7pAlRm47WQ8wNNSD/lKfP7OSdrB
	 lWUv4Szx1zQpyznAHRhe5Qoy0wefA3LZHDXh/2jwgkoo7nVzwI35WW8yQkurl/n7wN
	 /xTlReSC4MAuvtRboXNjZYPoY1LJbFBDgAYrgb9KmdGyvMFHyVn3Ng7NvlE7vswslU
	 QzocjUopNQ3oiKP6xXnCVbc3Q94YkQmF9dhVNFIYaUfnaB7nICT8JdxHTUNvYDMO0Z
	 T95QQn/X5q0ZlPV6lbB88q2Dnh/3/TYa+UlhApvDIZDF4vz0M56WhtZGyb167azL3j
	 Hct/I8qbx8sDQ==
Date: Tue, 10 Dec 2024 06:37:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: Move callback comments from
 struct to kernel-doc section
Message-ID: <20241210063704.09c0ac8a@kernel.org>
In-Reply-To: <Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
References: <20241206113952.406311-1-o.rempel@pengutronix.de>
	<e6a812ba-b7ea-4f8a-8bdd-1306921c318f@redhat.com>
	<Z1hJ4Wopr_4BJzan@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 14:02:09 +0000 Russell King (Oracle) wrote:
> On Tue, Dec 10, 2024 at 12:56:07PM +0100, Paolo Abeni wrote:
> > On 12/6/24 12:39, Oleksij Rempel wrote:  
> > > +#if 0 /* For kernel-doc purposes only. */
> > > +
> > > +/**
> > > + * soft_reset - Issue a PHY software reset.
> > > + * @phydev: The PHY device to reset.
> > > + *
> > > + * Returns 0 on success or a negative error code on failure.  
> > 
> > KDoc is not happy about the lack of ':' after 'Returns':
> > 
> > include/linux/phy.h:1099: warning: No description found for return value
> > of 'soft_reset'  
> 
> We have a huge amount of kernel-doc comments that use "Returns" without
> a colon. I've raised this with Jakub previously, and I think kernel-doc
> folk were quite relaxed about the idea of allowing it if there's enough
> demand.

Ack, and I do apply your patches. IIRC lack of Returns: in a C source 
now causes a W=1 build warning, which I personally think was a wrong
decision, it's a distraction. W=2 would be more appropriate.

> I certainly can't help but write the "returns" statement in natural
> English, rather than kernel-doc "Returns:" style as can be seen from
> my recent patches that have been merged. "Returns" without a colon is
> just way more natural when writing documentation.
> 
> IMHO, kernel-doc has made a wrong decision by requiring the colon.

For the patch under consideration, however, I think _some_ attempt 
to make fully documenting callbacks inline possible needs to be made :(

