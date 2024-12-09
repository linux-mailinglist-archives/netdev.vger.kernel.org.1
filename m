Return-Path: <netdev+bounces-150325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687309E9DF9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6168281ED7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE915665C;
	Mon,  9 Dec 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rtl4AdkI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCB14A4DF;
	Mon,  9 Dec 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768530; cv=none; b=YzCL11T5fHuQyUfoEur++exk7DXhNEAEafHxE+9xx6uDxuHSJkBi2w/wSEc3hP3uInGy+PAg06yFsY2f8B+KFwDMJ7l6x9FkRqtDmH9jzvnuBLC1646iinGHF7nehSjh8KtsyFGRNzw2eI4VYZhNnHp1H9F7GIJOI6b87Cpdqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768530; c=relaxed/simple;
	bh=/VGDqhdnkK6ylC+MBbxQLC+Vjx1EVADRGMfyYiYgbmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFZh8CCJFOVlbp+yAlZcQiUA97nEZa0cWal+FQd19q+sj4WRyc2C2HSPJF2hGvl/LTqHOtoTuXYgnXrVR+bSo+mFMpjHgDzWwE8HTxkVphJsgHOk/Sr0YoLi+CbtL3lvUU0T4FH8MJlZp2K26Z4xmFacol7RyPXXPbDTamLobMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rtl4AdkI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h196H/GBlXVpDihxGCGdnI+6In7gBytdrMx0dFG8kNc=; b=rtl4AdkItkyBCQujn8370xKHMh
	GCKMAS7MqlYl/LUkvZwcSYTrqV3ORNix7mjgDdfT9TIcP0/QTVX3qmqq3Z2ZAbNKEp7jPbDqWd396
	BY24uu1inpbVwxWON4u/d27yh422mngFgHTzyu8u8B9PLCzSWEKz7p9MGUBcDobvpuZs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKiOQ-00Fhsa-1v; Mon, 09 Dec 2024 19:22:02 +0100
Date: Mon, 9 Dec 2024 19:22:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fedor Ross <fedor.ross@ifm.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add of config for LED
 mode for ksz87xx and ksz88x3
Message-ID: <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
References: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>

On Mon, Dec 09, 2024 at 06:58:50PM +0100, Fedor Ross wrote:
> Add support for the led-mode property for the following PHYs which have
> a single LED mode configuration value.
> 
> KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
> LED configuration.
> 
> KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
> configuration.

PHY and MAC LEDs should be configured via /sys/class/leds. Please take
a look at how the Marvell PHY and DSA driver, qca8k driver etc do
LEDs.

    Andrew

---
pw-bot: cr

