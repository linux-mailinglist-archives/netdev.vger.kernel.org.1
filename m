Return-Path: <netdev+bounces-171830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B4A4EE5C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 21:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B226717506F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBD1FECB4;
	Tue,  4 Mar 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5gTZG1K7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DF51F76A8;
	Tue,  4 Mar 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120248; cv=none; b=bUdYpT2GyEU1C+kl5TEPZfRjDJclu6PZcBaLOtceteD95yREYlujxZXblvDz5KCKTqnOHAldOc359xxtWVw1qnx0XpwInBvxOyUv3GczWbWlJhBmDemCAZ6GZbZUfU8zsKRmmdHVp9HtO2PaNbdCOAcug7vhncjMaakgRTBhsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120248; c=relaxed/simple;
	bh=sxNbMdW/Iwem01aQj7BDy124mpTa0wLwsYtG42s4gFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFW0PoLqJDGp3Db4Ql4FVvn9OD/GlBm4lKr+mZil1t3w5Kd9iQNFwLwL/bHZ6C+rprW5UBIXpxtGm8kupp23n0YjAkqf3W8P7jG/JnEXMTIbr7GTnFaGF+O2nrhuBokuXf91IpCODbSGtfzPfmOY1tl6sYPQQre1i+ED/L10yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5gTZG1K7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fDJUnsSxZUnWvgAeUJYgf3CYEraX7n7Xpw2M9p7RPCw=; b=5gTZG1K7DjvFhN2kFzi03FICr/
	I0mRUDdV6TBh8AL+f8V3/JVzqKawTtCV2ipDnjvMCHHNVUsMqPmLu+t2xc0Vv6SAkwtn/cLohau7k
	vLkg7wMW7i3TOA4RBd8/9+r/mCadLFwRCEdchoZLqEeSJ8duqz6TQB4cbGrKGZmrsEAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpYuP-002G8S-IC; Tue, 04 Mar 2025 21:30:33 +0100
Date: Tue, 4 Mar 2025 21:30:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: dimitri.fedrau@liebherr.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 1/2] net: phy: tja11xx: add support for
 TJA1102S
Message-ID: <b7fce5eb-4d85-4ce8-ae78-6dbd942d5f2c@lunn.ch>
References: <20250304-tja1102s-support-v2-0-cd3e61ab920f@liebherr.com>
 <20250304-tja1102s-support-v2-1-cd3e61ab920f@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-tja1102s-support-v2-1-cd3e61ab920f@liebherr.com>

On Tue, Mar 04, 2025 at 07:37:26PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> NXPs TJA1102S is a single PHY version of the TJA1102 in which one of the
> PHYs is disabled.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

