Return-Path: <netdev+bounces-99836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFEA8D6A30
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047242879D9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9780055;
	Fri, 31 May 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pmyr8u6i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE69380;
	Fri, 31 May 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185406; cv=none; b=sn6DcyTtC1AzAhkgq0+PjBWOxGNux7cYlrp+Zl6buBtc8VqOBXRF0JgrD9wojr0h5Yluj6effIAI9mziyimsqKtc97HG8D3+XHzDcVlbi/8MR2ytBGu3wWKW4m1atj/vRnGIwT7g56w6uPuveO0qYr/j5kkJd5zZ6g0MSBCX6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185406; c=relaxed/simple;
	bh=+eZtCbv2zIz36GeBPn3ygzQntbOSxJ26axyz+qS7G38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN/zPmtinBbyKhVEXN+lQkseNujh00hBEnq65QNUX8WEGY0E22I4JompKNGDlvkrgI+y7gZ7gRXtn3l43QX+/U1RVTtM+3mfYubFNUyy9fZCYeCTdK/Fa05GphafrHgPg9IsPDSQj8pcK5IvFTRmb4LHpzvoEQKKcPi0txzyLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pmyr8u6i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0nu4nW4POrtPq8n+StV9YqZGhyH8UrE3xrORyRuVLfw=; b=pmyr8u6iZKPgwKa3JGfhr8kIxr
	oeN/ChQvKyGGp4eaO48nvvMamTneHMpo5wc0uMi+PhlEd/Euwo1b71kauoI3R4YC4ebDmuui/MKWL
	fm9Ecf92QM/8LOADNyi5mBIbckqIUwJTWD7/gKdM0mDSyZKNogTqE54sGHx71NzAWdPg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sD8MW-00GVvF-0l; Fri, 31 May 2024 21:56:28 +0200
Date: Fri, 31 May 2024 21:56:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robert Marko <robimarko@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/2] net: phy: aquantia: add support for PHY
 LEDs
Message-ID: <25ce6c90-f7c0-4c88-966f-8bbfe59ebde4@lunn.ch>
References: <20240530212043.9006-1-ansuelsmth@gmail.com>
 <20240530212043.9006-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530212043.9006-2-ansuelsmth@gmail.com>

> +#define AQR_MAX_LEDS				3

> +int aqr_phy_led_brightness_set(struct phy_device *phydev,
> +			       u8 index, enum led_brightness value)
> +{
> +	if (index > 2)
> +		return -EINVAL;

AQR_MAX_LEDS should be used here.

Apart from that:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

pw-bot: cr

