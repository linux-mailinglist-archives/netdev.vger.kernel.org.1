Return-Path: <netdev+bounces-152603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDDB9F4C85
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE7518925C2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D651F4274;
	Tue, 17 Dec 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhyYMaiy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873881F3D57;
	Tue, 17 Dec 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442444; cv=none; b=A/mAN4tmkaYN3CanRwyyVmCYGlYvbEgMlR5E/jTxJ41bUBDWbORk2DW+54PQkIqxLcTUVCvEDrNU87O+c45Mo7xBTH5E/ISIwJ2A1OJRK6Jz28+wJeFo6kWg/2K77N5+1ZTRa14MRAhbjr5+3JlqvpcWUAK3krDsq6L2bw+mB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442444; c=relaxed/simple;
	bh=FV7yQyFVJ8Ft59KQYAkWNEMbxJuXWysadQd4/zHTn00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbPrfP/a4zzk97IGS+11XofUEm3Wa+Zlku4rh1tMQJNBmG1/p+UFHGHe2w5bI5pk81FWO19TJjqdAkCRK+sDEIhXjmlYb1uNKH6azbWzAUXgZ5FtRZBddxIuGU8v7CwbbcHPl3mHd3m6j3vveQDzsqfyc2XuIWOogpbM9KPKvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhyYMaiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC339C4CED3;
	Tue, 17 Dec 2024 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442444;
	bh=FV7yQyFVJ8Ft59KQYAkWNEMbxJuXWysadQd4/zHTn00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhyYMaiy6aGNyGePj+6azwdsJCJBXqJMosk4meHT7M19ZUxxNbfzJ9H7T90QaWUSQ
	 Qb1AfoEMow6wqOxQYjgewm7r2Aj0/YjQtY/Ccv99dqYWlLspdzKric/3xd6LsnCer1
	 +2lHwtFDAWUm/6hQ3hUXD8hEVZeyzArkUhBb8CQCmhBGpHvTwuki5npxwkZcSSgnSw
	 7Xjfd4NeepGzRhbSyeV/mXfLywHW2wnyvFH/LDNXUmkQAGQRp7M6YXJXv3izwYONN7
	 S/mrFpM/xwiDuuiCBRlzRTa9bF9IguiQeAXRa7nfrI5T07mZXyFcrwuWRcVZ1NmbbJ
	 Ju5UYkSc3H/LA==
Date: Tue, 17 Dec 2024 07:34:02 -0600
From: Rob Herring <robh@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Fedor Ross <fedor.ross@ifm.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add of config for LED
 mode for ksz87xx and ksz88x3
Message-ID: <20241217133402.GA1420212-robh@kernel.org>
References: <20241209-netdev-net-next-ksz8_led-mode-v1-0-c7b52c2ebf1b@ifm.com>
 <c934f10d-1a75-4ca8-bd0b-f08544c7d333@lunn.ch>
 <c970bdbc-5831-470c-9040-b37c4f76baf2@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c970bdbc-5831-470c-9040-b37c4f76baf2@denx.de>

On Mon, Dec 09, 2024 at 09:26:33PM +0100, Marek Vasut wrote:
> On 12/9/24 7:22 PM, Andrew Lunn wrote:
> > On Mon, Dec 09, 2024 at 06:58:50PM +0100, Fedor Ross wrote:
> > > Add support for the led-mode property for the following PHYs which have
> > > a single LED mode configuration value.
> > > 
> > > KSZ8765, KSZ8794 and KSZ8795 use register 0x0b bits 5,4 to control the
> > > LED configuration.
> > > 
> > > KSZ8863 and KSZ8873 use register 0xc3 bits 5,4 to control the LED
> > > configuration.
> > 
> > PHY and MAC LEDs should be configured via /sys/class/leds. Please take
> > a look at how the Marvell PHY and DSA driver, qca8k driver etc do
> > LEDs.
> According to KSZ8794 datasheet, this register 0xb is Global Control:
> 
> Register 11 (0x0B): Global Control 9
> 
> So this does not seems like per-port LED control, but rather some global
> control for all LEDs on all ports on the chip ?

Still should be able to use the standard binding and sysfs controls. The 
driver just has to reject invalid combinations.

Rob


