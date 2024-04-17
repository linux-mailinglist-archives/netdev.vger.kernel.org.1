Return-Path: <netdev+bounces-88857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E148A8C1F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84092B20E8A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34B25624;
	Wed, 17 Apr 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="31NQUpK/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6E1BF53
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382266; cv=none; b=dEdec+dcwVz4WSg72Gl70nizBMwCEkHY1qDN2yreu95gEqlkO5JZa9cwawv2KNMuHU/ksBTxFz9Kg6W6LAh2f5CEPmdkGDD416vhbZhVfkDbq72nJNWEDQu3GjHljmIYi7AT+yxHgVzLkTPFkX3NSyaw1VBFit/c37WXk7kShqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382266; c=relaxed/simple;
	bh=r4ME++zOWlVTz/S9j+M4oo9UQtMmKWiymg/o+dhsCGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUvfyq/OBLgH+VEPshpNVge2w3sVDnw/VD4OuFvrMn5WMnR/zx+w6QW0SOvJ+3dYAzqKUYq2xAxjixaRfG2Fb82B8paLJsTVh1YNnYY/lFd+fL/bCW/CoIBO1nf0AT0mLp3Rs4ZLguCfR0HO4yh7/B2zWBbE8EkqQnaq3t8JbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=31NQUpK/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nryns29sH917Q2SebT6PHaDy/PictfIqciIn/zYCqXY=; b=31NQUpK/0ZGt7R2ipQFEqd8nfJ
	HKCiQRCoCyF7Gbn+7Rn0YRWZ9CiavxPArmq73ti85DG3JY2gUQFmHGk3SQ6NUM13RpLomgoS8R7C3
	D01WPN+gPqIVLQury8fKGuvqpyGRGo1hhoz/yICSxLv/l4DZVkPTtEhkWv9YczkDFuew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxAzi-00DHFb-3p; Wed, 17 Apr 2024 21:30:58 +0200
Date: Wed, 17 Apr 2024 21:30:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: netdev@vger.kernel.org
Subject: Re: Beaglebone Ethernet Probe Failure In 6.8+
Message-ID: <53a70554-61e5-414a-96a0-e6edd3b6c077@lunn.ch>
References: <Zh/tyozk1n0cFv+l@euler>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/tyozk1n0cFv+l@euler>

On Wed, Apr 17, 2024 at 10:42:02AM -0500, Colin Foster wrote:
> Hello,
> 
> I'm chasing down an issue in recent kernels. My setup is slightly
> unconventional: a BBB with ETH0 as a CPU port to a DSA switch that is
> controlled by SPI. I'll have hardware next week, but think it is worth
> getting a discussion going.
> 
> The commit in question is commit df16c1c51d81 ("net: phy: mdio_device:
> Reset device only when necessary"). This seems to cause a probe error of
> the MDIO device. A dump_stack was added where the reset is skipped.
> 
> SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5

Can you confirm this EIO is this one:

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/davinci_mdio.c#L440

It would be good to check the value of USERACCESS_ACK, and what the
datasheet says about it.

The MDIO bus itself has no real way of telling if there is a device on
the bus at a given address, and so if the devices actually transfers
anything on a read. So if the resets are wrong, the device is still in
reset, or coming out of reset but not yet ready, you should just read
0xffff. Returning EIO would indicate some other issue.

> Because this failure happens much earlier than DSA, I suspect is isn't
> isolated to me and my setup - but I'm not positive at the moment.
> 
> I suspect one of the following:
> 
> 1. There's an issue with my setup / configuration.
> 
> 2. This is an issue for every BBB device, but probe failures don't
> actually break functionality.
> 
> 
> Depending on which of those is the case, I'll either need to:
> 
> A. revert the patch because it is causing probe failures
> 
> B. determine why the probe is failing in the MDIO driver and try to fix
> that
> 
> C. Introduce an API to force resets, regardless of the previous state,
> and apply that to the failure cases.
> 
> 
> I assume the path forward is option B... but if the issue is more
> widespread, options A or C might be the correct path.

I would prefer B, at least lets try to understand the
problem. Depending on what we find, we might need A, but lets decided
that later.

> [    1.553623] SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> [    1.553762] davinci_mdio 4a101000.mdio: phy[0]: device 4a101000.mdio:00, driver SMSC LAN8710/LAN8720
> [    1.554978] cpsw-switch 4a100000.switch: initialized cpsw ale version 1.4
> [    1.555011] cpsw-switch 4a100000.switch: ALE Table size 1024
> [    1.555210] cpsw-switch 4a100000.switch: cpts: overflow check period 500 (jiffies)
> [    1.555234] cpsw-switch 4a100000.switch: CPTS: ref_clk_freq:250000000 calc_mult:2147483648 calc_shift:29 error:0 nsec/sec
> [    1.555343] cpsw-switch 4a100000.switch: Detected MACID = 24:76:25:76:35:37
> [    1.558098] cpsw-switch 4a100000.switch: initialized (regs 0x4a100000, pool size 256) hw_ver:0019010C 1.12 (0)

So despite the -EIO, it finds the PHY, and the switch seems to probe
O.K?

	Andrew

