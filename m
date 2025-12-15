Return-Path: <netdev+bounces-244759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B83CBE70A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5456730146C7
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B60311955;
	Mon, 15 Dec 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqn+25td"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CC3115B8;
	Mon, 15 Dec 2025 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807414; cv=none; b=C0Yc6DtXrq1OY13gdArrLXhD/LyOCrfPqzy+25E2YFPnd9keg760UxG2oLMAgeEg7vMjAajl9S5IC0fYq+FyByVf91lnIBfrOPTk4w67czR1ESHY8+zEkKUMmwX55O3mpgPyT5TQEq5vnXiP1HnGv9tUmGZSyT9u2XidDrgiio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807414; c=relaxed/simple;
	bh=rFQyuWHfFcZlHMejIvhAa1DF/jOp6uqvkdWv/+Mb6s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLNgK1O6EMlTyrlM5g1XZ91+ZiAcu8UAX9G5edktL1JvQso6/LMUhk6ycz9jUU7J5MY8X8EWgqS0G5/u8ppTZFKb4f/0+X2VdeojThwBNgsFpSZXsX931MD2IeBekcIl/uJ5qEJSo7eKx3p1/mMgIhQjULc8hgawcNJ6/z6ZyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqn+25td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D12C4CEF5;
	Mon, 15 Dec 2025 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807413;
	bh=rFQyuWHfFcZlHMejIvhAa1DF/jOp6uqvkdWv/+Mb6s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eqn+25tdHr5Wrrm3Xn8rbqWT7Cdod3hLETZm9Xr8ldxluc3aeOueqyGp5QHgBo4tp
	 iudPuSduvdNkGWl9ZP4unZ071ajNA3y3RN1diT0GzQ7znJNaCUVfgYZ/jV/o2TkeRc
	 H2gILEXItKx0IUuWaJk8gz1hQCIzU7AVCWete254A0km3zdQsa4prIUvq0ORAxN7vx
	 xCHXokOZ0NAXxXlMvyrHR44hS2RFx5BNaATueokHHaVsn99rtLIqrTURa0g8jjIhCL
	 YTUS3rgQzHofTHnfi7usX+RYStx+7nMXDKAWYeRn8cHAmDOoiJxHkhdH6349TudcnB
	 4xXdwcFnQQZpA==
Date: Mon, 15 Dec 2025 08:03:30 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	geert+renesas@glider.be, ben.dooks@codethink.co.uk,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 2/3] dt-bindings: net: micrel: Add
 keep-preamble-before-sfd
Message-ID: <20251215140330.GA2360845-robh@kernel.org>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212084657.29239-3-eichest@gmail.com>

On Fri, Dec 12, 2025 at 09:46:17AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a property to activate a Micrel PHY feature that keeps the preamble
> enabled before the SFD (Start Frame Delimiter) is transmitted.
> 
> This allows to workaround broken Ethernet controllers as found on the
> NXP i.MX8MP. Specifically, errata ERR050694 that states:
> ENET_QOS: MAC incorrectly discards the received packets when Preamble
> Byte does not precede SFD or SMD.

It doesn't really work right if you have to change the DT to work-around 
a quirk in the kernel. You should have all the information needed 
already in the DT. The compatible string for the i.MX8MP ethernet 
controller is not sufficient? 

> 
> The bit which disables this feature is not documented in the datasheet
> from Micrel, but has been found by NXP and Micrel following this
> discussion:
> https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> 
> It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> 10MBit. Withouth this property set, no packets are received. With this
> property set, reception works fine.

What's the impact of just unconditionally setting this bit? Seems like 
any impact would be minimal given 10MBit is probably pretty rare now.

