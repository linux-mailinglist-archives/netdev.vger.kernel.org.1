Return-Path: <netdev+bounces-155542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D1A02E96
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6207A056C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C630B1662E9;
	Mon,  6 Jan 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GTkWa4Ld"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617114D70B
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183160; cv=none; b=p4PbW8OtbyotP9qJpZN7LuPixzX2IjLYJmMXhIrCeDgBhpr6wRwfyAGZcQZIzO+8aoFz4OAHqUQcGnqXL0g2EU3if9JEncE2+tCM41zZsi6W63FuQ5hpco5W2Ry1hN85vGHMwWdCO70YCRrHgXsz14rYRuTbHbbhH+Tu2Z1H4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183160; c=relaxed/simple;
	bh=dALIICaZDomme8AQSUAXwgs8jcpD0JJatZZKY2WsUmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEVUir0QBwtKYyESwmvgcRxMDUaVKSRSeFGR+F6uO6cleiH5A1ZBTG21a/M8dTwZWq6Pvdc/c65yXcBGS7YZAcYtKRTiwQ4llEcmO8ZGCxifPXSr7ocGvqpR/T6SFvaEROlVaIXmn1E0OdCqDuZl7/arYnQf8gqLcrHUcg/FeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GTkWa4Ld; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+aLrciYDnEQTOvsZYjNjDkrJhzlljLBC+B1yH89oWGQ=; b=GTkWa4LdfKGCX1iy1jfYBdG32d
	j78Um9OW14LZR82fEoKslaeKZpzh2j+iuneGfN5HQNJhyEIbahslJiG2kkJY4BgVeyio2EUUA433G
	xtHtR6nERkSPd+zCeacsMeP5zEZTZYPa6Lu4l7ppz8RQYiT2sL1Zcn0aOE1vpKmbLF4E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqXw-001wOO-7y; Mon, 06 Jan 2025 18:05:44 +0100
Date: Mon, 6 Jan 2025 18:05:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 14/17] net: stmmac: move setup of
 eee_ctrl_timer to stmmac_dvr_probe()
Message-ID: <a6a44c8b-1c8c-47df-b16b-005bb0520927@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmB9-007VXz-8c@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmB9-007VXz-8c@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:25:55PM +0000, Russell King (Oracle) wrote:
> Move the initialisation of the EEE software timer to the probe function
> as it is unnecessary to do this each time we enable software LPI.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

