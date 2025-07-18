Return-Path: <netdev+bounces-208149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA4B0A4B5
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539B37B9E3E
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADCD2C08BB;
	Fri, 18 Jul 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0QR/I1lx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4582DC32A;
	Fri, 18 Jul 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843814; cv=none; b=kLEngAH+Zkk37qewlKyhCc6U0nsuWpRCD3eEiyiTKZfsM/9WNtm2LfPV/hH0hTBwZMXRqMTxTHsUUndgf8aBL18PZ0mcuLnhuTjMV9pgT09y17Ajj/cv90VrQHBu1kqKaa4eCUxEnImoqTUHUkL0weevzN2nN8VBbwXS3nYF5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843814; c=relaxed/simple;
	bh=5ayYB4lf8WYc5q2/lWQPGTHFYjF+7Uui7cSz39xP6dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR5WBbjNk/L3oSGObXSrKjA7E/5rmFAlr60EEKIONVvrglfm50PWW0ZckkfxqunlZ/b86QPZPIMWv01RPhRLIetnbCUscwEaERN4nTeruxxxRz7ouiswklJoSeD9WnvLq108XuqCLjeSUnSB44cH37qxRJNArppWmuvnefrAtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0QR/I1lx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NfDSDunZnUOAV0VPZMBtehP13sl6rzJgwVyI/4SEuS4=; b=0QR/I1lxy3aWu5Z3G3nCiY7D17
	SgVLxMvMMpwPvD9wl1xKrBPuOHCkHkjteNCW7CBHDEg2ln+BY+lUt3RO0v2gC6TMaSl5rV6IZB4uW
	1JHUIrf8V+xL+DirPeUmWIZQah03K2/blqyDK5hV6LKnF584SFCUYBUt38RmRGPtoL54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uckkD-001zYe-9H; Fri, 18 Jul 2025 15:03:21 +0200
Date: Fri, 18 Jul 2025 15:03:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 1/1] net: usb: smsc95xx: add support for
 ethtool pause parameters
Message-ID: <d451fa3b-e97d-4b01-a0bc-1a296777f004@lunn.ch>
References: <20250718075157.297923-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718075157.297923-1-o.rempel@pengutronix.de>

On Fri, Jul 18, 2025 at 09:51:56AM +0200, Oleksij Rempel wrote:
> Implement ethtool .get_pauseparam and .set_pauseparam handlers for
> configuring flow control on smsc95xx. The driver now supports enabling
> or disabling transmit and receive pause frames, with or without
> autonegotiation. Pause settings are applied during link-up based on
> current PHY state and user configuration.
> 
> Previously, the driver used phy_get_pause() during link-up handling,
> but lacked initialization and an ethtool interface to configure pause
> modes. As a result, flow control support was effectively non-functional.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

