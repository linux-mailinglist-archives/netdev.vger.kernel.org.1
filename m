Return-Path: <netdev+bounces-169663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9272AA4525F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9098116D92F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9317D346;
	Wed, 26 Feb 2025 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmh5HbcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6354689;
	Wed, 26 Feb 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534476; cv=none; b=qIPV01bvrN+yP/t7FxyD6Prh7lKz7GWI5AgbPQm9hdRwh+SB/1GqiO6PxiPcaOanXu8Ly10d8B0lcnEkxBjcy6Hx2C15Z+s9X/keZ0vlyl7FiuW2ydB6S+dI+K88ZYm85iP5T3qTaq96vKpK2zHEVUO6aYDsBiPclum+ZlLx87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534476; c=relaxed/simple;
	bh=V3CB8LY1DGZbWMpcmpZd8j50hGMDpnu5UssYkcrx0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5GrPYkLRLcC2pB0awWPRbAn2DDE9vpeceH2foaCz9KLv71iehi3xfuGwYnE8VWDgFiRo6mdhT0ezscs4xJAiFPfNOLkSAn/w46KUYumFFOYgggjF5Oh+aTq2HeeqSQN87k5lNn+LkA6HoBte5V2EcFNPOQpFC09ehHkBnOm6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmh5HbcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4361C4CEDD;
	Wed, 26 Feb 2025 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534474;
	bh=V3CB8LY1DGZbWMpcmpZd8j50hGMDpnu5UssYkcrx0sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kmh5HbcDs82upshjPAyIwCjyAkA1oin6SLySK+vyk9WO0zOaYqhbbYWGt+/ol1zY3
	 A/K20xkQeUiXRw/rwjAp5cFIpYT75QGpUca6iwsrw6uHZ8QzEqasRaX/Csws7c8j0Z
	 YQQrI+O1ZXbY8jO0j9iLtOdEkF81tQahQFuQRxU3Ch7cLZ7h73tDcm3ERv9sRSbhkj
	 e5hs+Z0KZuMJtjoONRvOp61iZ8Zy98ooCHeoSZAxMiW/XvV0O9Dx2kxNZ2iSpicC95
	 eHy83tqMBMDkgu4NkPd1Q4rJkd/7nuNcuGc09SWEbBbcL5JThcBQ/dIm1V2PiQs7oh
	 IEEArVJDAgf0g==
Date: Tue, 25 Feb 2025 17:47:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250225174752.5dbf65e2@kernel.org>
In-Reply-To: <20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
	<20250220165129.6f72f51a@kernel.org>
	<20250224141037.1c79122b@kmaincent-XPS-13-7390>
	<20250224134522.1cc36aa3@kernel.org>
	<20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 10:25:58 +0100 Kory Maincent wrote:
> On Mon, 24 Feb 2025 13:45:22 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > > No they can't for now. Even different PSE power domains within the same PSE
> > > controller. I will make it explicit.    
> > 
> > Sounds like the property is placed at the wrong level of the hierarchy,
> > then.  
> 
> When a PSE controller appears to be able to support mixed budget strategy and
> could switch between them it will be better to have it set at the PSE power
> domain level. As the budget is per PSE power domain, its strategy should also
> be per PSE power domain.
> For now, it is simply not configurable and can't be mixed. It is hard-coded by
> the PSE driver.

Yes, but uAPI is forever. We will have to live with those domain
attributes duplicated on each port. Presumably these port attributes
will never support a SET operation, since the set should be towards 
the domain? The uAPI does not inspire confidence. If we need more
drivers to define a common API maybe a local sysfs API in the driver
will do?

