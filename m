Return-Path: <netdev+bounces-215255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4FB2DCC5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B213BA638
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E828311C16;
	Wed, 20 Aug 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="szvdnviO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14B311C03;
	Wed, 20 Aug 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693412; cv=none; b=Xe+6VLGj+lJrPltlbIIQXcJdI/I2ly/sCY/TcgnkilT3G4y3KWg6+tV7MI7gbj8NQsYFAyUAUmgF/JOsOMGpviOLcn8i9Yrbtc3G8STusGygYKX2MzXamCq1dR7wkejWXpTKvXtjNhn+kXtFw5Hxx9pj+GTOD4GLw3mY7QuoGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693412; c=relaxed/simple;
	bh=VIDrPunw/2JzpejDhUs7NcEYeN98ymFfehpbQmS0wJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6bd58ElMy+bwckqrYemrFiI8sb3M+C6DPpIBrsvby/qkcuD0ybxPUV7+sFdu7MxYrZ1hv3c1sdj0alRsvXcJQ+ktiXHhQNzz6NP1PG5XEVWkHofS4N7zXa5IvGxp+8po8hg+XmAF9nObuepLNhOk4NYomhdw/avyrxgysdh70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=szvdnviO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EF3c1LrjzPOtgfZvnP8yaAbWzaLVMBt0Ay/Kfnqyg60=; b=szvdnviOgP+OyVjbNiLur+NpVz
	HBtwYFQpM7RH0fio06QrQqdIfwg0nh9RL9JWiAwX3prD3g/7ZvxM4m7+jWO+7iiaqB1WCHoEeTqHZ
	csIe1Y+DbGMmsX1BG4HdDvNojKxBgoAJNjacyDP86fXDZiwxQKDZ0UE3wgKNOdnGh4GE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoi3T-005JvJ-S4; Wed, 20 Aug 2025 14:36:39 +0200
Date: Wed, 20 Aug 2025 14:36:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: phy: mxl-86110: fix indentation in
 struct phy_driver
Message-ID: <0df53861-7c7d-4514-9b4b-495a1e2f52bd@lunn.ch>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
 <5591a3b638c4d42950375781a76e7e7116bf4219.1755691622.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5591a3b638c4d42950375781a76e7e7116bf4219.1755691622.git.daniel@makrotopia.org>

On Wed, Aug 20, 2025 at 01:11:29PM +0100, Daniel Golle wrote:
61;8003;1c> The .led_hw_control_get and .led_hw_control_set ops are indented with
> spaces instead of tabs, unlike the rest of the values of the PHY's
> struct phy_driver instance.
> Use tabs instead of spaces resulting in a uniform indentation style.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

