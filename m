Return-Path: <netdev+bounces-150457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261F69EA4A4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ECF2828C9
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2944206B;
	Tue, 10 Dec 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1A+KIg2I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F23233129;
	Tue, 10 Dec 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796242; cv=none; b=netI3TVfEmB4HM2vMkKbp+fD9uiqEXXYiMuAe+hNqa8GNhOV+3mAU5AzhKfONZS8eFOquJDfxlY02VssZ2XKoP/6k3gZ1E4LLNrfnywqd5oeoLMM3b5OzyQEe8VwmZt08zeyUM9XI7ISQGNAGpth6jcyleMoHjQmizJyfbEUPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796242; c=relaxed/simple;
	bh=Chh94kYftnp/nx0uj3PwDdZ4ZlVGX+bL9pQM95fGQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBSPjU3HnAoNvxczKEP55kw/zU26n1Vadug+Ja0Gj0OZMDVXaRARlECjCClz7Pb0n8a0mpPy/57Qen2w9Ta3Y3hqMFNUWeQCnqXPK+PSTRTwlwkx4gM08hnpsP7mykawEwMAKdIOlSnUH8IB+baZpLpGbsDEt6GQQ3XqaL36bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1A+KIg2I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eFp65tcXcc958C5eOkNA/EA2BFQGeUtwmJa8uPH36oE=; b=1A+KIg2InrbL2T0UCnrP87R6PB
	UE3GEvwJ21tdUS1r4tq7Q+8IBsVj0we+OTiybgL08fWxRSpw6yG3KWkoeMQrAnpvz0GTgp/R0g8tu
	QBNOSjW6kM9pXfuBZy1KvWuo8QyuaelXFLYpZN4zPU+prT4k4QhZJQytqetXwRPzmkfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpbO-00Fk49-W0; Tue, 10 Dec 2024 03:03:54 +0100
Date: Tue, 10 Dec 2024 03:03:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 04/11] net: usb: lan78xx: Add error handling
 to lan78xx_get_regs
Message-ID: <8e251cd2-00a2-484f-a628-8abe32fb772a@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-5-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:44PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_get_regs` to handle errors during register and PHY
> reads.  Log warnings for failed reads and exit the function early if an
> error occurs.  This ensures that invalid data is not returned to users.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

