Return-Path: <netdev+bounces-148653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D09E2D14
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E30165A9D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579B205AB4;
	Tue,  3 Dec 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s9+yw+XR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5952F9E;
	Tue,  3 Dec 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257805; cv=none; b=ASBDByxvsaYXPqxMLW5jkzfkgljGzlfth3Id+7eeYUtr4GjcVCOcxRFvo9nLfTv/X9CrBTy/ARkEOLkwhwEbkHVttq4SuBVQ5tG03c6zgj9e/kgyvxgPyehvTIhbttHRoqardlSade3J38bLVF8oIngy+igYITh+ZFLpRBmFVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257805; c=relaxed/simple;
	bh=ygU4cDdf1aNKCANLQbHcYyLJPac2zAuV88dsS8gsnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxDTA7QK6jTL3YLm7so/p7/GtRI8oNWp6STsukYsc4Hr4lbQR6tBWJH987hRJ/Ocr8RHgxi/7ocJzPLeu89nAEEcpeVDwqTDsf2qfE1By0BmAT60B0ZLGlPeIh0kdG0z+7aofmNNXGk/atwos8eBO8oeeJeK6uB5RkCMk6nzNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s9+yw+XR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3CguHt6X8P58BimZogJtxHqiLeYuGQMNg1+by0xxqgk=; b=s9+yw+XRmUHfREv6JmbYOdwTXT
	kf45UNJzjYHXl6phoGOC43AstxS5NS+y7jtA5I70/fg22Wz26hngQF0gUgo5q9Y6ED1Nqp6l3z506
	TryIxr9fz8ynFKrn2V9Kp1HRU9exw9Iv5DoYULGUrPRlDJ/h/geMIbkhb0SghHCtmP74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZWw-00F83p-Hn; Tue, 03 Dec 2024 21:29:58 +0100
Date: Tue, 3 Dec 2024 21:29:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 03/21] net: usb: lan78xx: move functions to
 avoid forward definitions
Message-ID: <26ba9118-1aa7-40ba-928b-448462378969@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-4-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:36AM +0100, Oleksij Rempel wrote:
> Move following functions to avoid forward declarations in the code:
> - lan78xx_start_hw()
> - lan78xx_stop_hw()
> - lan78xx_flush_fifo()
> - lan78xx_start_tx_path()
> - lan78xx_stop_tx_path()
> - lan78xx_flush_tx_fifo()
> - lan78xx_start_rx_path()
> - lan78xx_stop_rx_path()
> - lan78xx_flush_rx_fifo()
> 
> These functions will be used in an upcoming PHYlink migration patch.
> 
> No modifications to the functionality of the code are made.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

