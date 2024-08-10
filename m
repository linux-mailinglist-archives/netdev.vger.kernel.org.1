Return-Path: <netdev+bounces-117424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1D94DDC4
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AA21F2167C
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514DC160887;
	Sat, 10 Aug 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JgqPDQLZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CFC1370;
	Sat, 10 Aug 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723310787; cv=none; b=lfTCFpB2POdBsptR5VUmn6sjJtPwqGC4BH9By84MHY7krOJ7GmM8wXG7trmbq2Y6IiHNivHy2VWV9z6Y1UEmV/J37O3BVT7BQs5wtjLufgnCDTuL6hlZHNr3x7IuWGn06/rzrnED2y/oNqjbDLRotF31aYyJU2SM2KODEqOzM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723310787; c=relaxed/simple;
	bh=cgp2AY6GEmN/E+/LWHUKb/wBkq90glmO8wXPTIgvi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnWWgV1rPGxIiOcM1ekBBbaX8Jj7943YCH9/NfeTmqpeTN2JYM8XK33s2TZ36n3BGJgy/ToFz2rbfv1atthhmLd7o2yTrON3I1csW7znGVtPHuMsKSImKOz9lqHIAK1L5z4VVZ0t+TySLrGIz8bLJYNMG/RB0ty0Ja0334sxj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JgqPDQLZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=00gGJdUPw87RqHZDb02kQekfGiA5d5tZc+xGQCgcq74=; b=JgqPDQLZx5WFZAiUOC4DRaXJoi
	71EkHnd9FqDT3CAX+tRbJ8OIX1qNUFO6xDK5sipHmK4GcDj8gHssx/yPaaUvfuUHGi6c4LRcUjiYS
	cpAO16bvgBIqKB0i8HWILV4gi+5jV4FaC8te8YEu44w8PSVrqIUfYtFzCVf1SBRqbw00=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scpr6-004SMW-Sp; Sat, 10 Aug 2024 19:26:16 +0200
Date: Sat, 10 Aug 2024 19:26:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: microchip: add SGMII
 port support to KSZ9477 switch
Message-ID: <eae7d246-49c3-486e-bc62-cdb49d6b1d72@lunn.ch>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809233840.59953-2-Tristram.Ha@microchip.com>

On Fri, Aug 09, 2024 at 04:38:37PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> 
> SFP is typically used so the default is 1.  The driver can detect
> 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> has to be explicitly set to 0 as driver cannot detect that
> configuration.

Could you explain this in more detail. Other SGMII blocks don't need
this. Why is this block special?

Has this anything to do with in-band signalling?

    Andrew

