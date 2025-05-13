Return-Path: <netdev+bounces-190177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC4AB5761
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B7C16F76E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B324728C;
	Tue, 13 May 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGfsG26f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14D1AF0A7;
	Tue, 13 May 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147288; cv=none; b=RI6yZvsHZtziQI7GRiS5XvB3l/owIgg8A0/IdXlWt9Qzc5GyxvP1CyDiSPZSd1xtoej7IqSemAJPSyYicJayXCcKUclsxyEHm/N1SiYIFPz8USDFakI2/ntsriJ/raZcwffSauNFePqsJ9DrvPA7JMAeAJFThxWYxECVhMY5ENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147288; c=relaxed/simple;
	bh=9rek26u3z9azmwOQJIZVAvbpbRZcwrSvVWLI/781IIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMWAzHnCwvR/orsu8NGLMwvSwlP7VICmepSf6sMEBw8Y1D5tQli+pBLYJk/NqJ56M6VkKV2ULGMZgBIUDqjGT2NIvUaf1VyvG6eiW4N4aMGqHd6UvbmWa+gDuO0NHjPIpbhC6GVWdXGzM7mDIVr+zYffEaRGE6xBHG9x6jJCpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGfsG26f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E73C4CEE4;
	Tue, 13 May 2025 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747147288;
	bh=9rek26u3z9azmwOQJIZVAvbpbRZcwrSvVWLI/781IIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGfsG26f/rgdzMXctx0MglLJybNp+KWifX6SJ136P6pW3LpTXKI6UHRPvbqdn8gCQ
	 wsuGO387b9knuH5ITzA6E4CLjpKJPu7jZfh68e2JBLooX1Q0DefAfNKjtJt4ravwhn
	 mCijz7ggSDagZH1eG9ETQmArV3xy00Y6TL/CMlZ9J1WQJ6eejFrdHRxvZy0bwN7H0H
	 FUJqhmL2gHuKqOU7bgiyJDWwLJaaZh8FFhX2z1a+RYyjmImL8WNkrAHgNEK2KHWTZz
	 EI49b7rHqPxyLgd7MPT8QENtb0FWgeudX+mmzO+QpuF61BxV1/nI5JeY4AtaK7ka6P
	 b8ZJ9KuSJ2VVA==
Date: Tue, 13 May 2025 07:41:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250513074127.5b64fc6e@kernel.org>
In-Reply-To: <20250513114409.6aae3eb9@kmaincent-XPS-13-7390>
References: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
	<20250506-feature_poe_port_prio-v10-2-55679a4895f9@bootlin.com>
	<20250508201041.40566d3f@kernel.org>
	<20250513114409.6aae3eb9@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 11:44:09 +0200 Kory Maincent wrote:
> > >  attribute-sets:
> > >    -
> > > @@ -1528,6 +1534,18 @@ attribute-sets:
> > >          name: hwtstamp-flags
> > >          type: nest
> > >          nested-attributes: bitset
> > > +  -
> > > +    name: pse-ntf
> > > +    attr-cnt-name: __ethtool-a-pse-ntf-cnt    
> > 
> > please use -- instead of underscores  
> 
> All the other attributes are using underscore in this property.
> Are you sure about this?

yessir, we're trying to guide everyone to use -- these days.
We should probably s/_/-/ all the existing cases which don't
result in codegen changes.

