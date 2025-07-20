Return-Path: <netdev+bounces-208459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B6B0B8E6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 00:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A281898784
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505622069E;
	Sun, 20 Jul 2025 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoT/O8V9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663791DE3C0;
	Sun, 20 Jul 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051076; cv=none; b=TjEP9XHt4Wr1voWP+iQg3bUiAFvs9a3Khlyb94v2lsJ242puyZWtr3FufD41T74Q9OpL2ycJ0eTkhcqCdelIbPRnJ8+xGdwkd28jsmH5bbq9PKfSMSeCE54IFvCsdb0uVKw6H5boMhxaISI1wHOSHrhljcih2ZA89lGwR5pos0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051076; c=relaxed/simple;
	bh=bQHLI/XDtJZm9HEsQ0g9deG5tqTi5tjlQkIA/REe/F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln7KmbGDPsJVOZUX7EDizbaGLPMZw9/BLvWz9CbWEkMZS9mNR4bxA2wIo8OxiVkyP6Ye+aY1GoEl3o6PLmJh0bow30c+AlT9bMwsZTxQxWG8O5B+n/svY4n43R8bkwG0JAzlRW2Y47gaQpWNrBPHvHy0tdAl1UexFstMG/lVMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoT/O8V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBD1C4CEE7;
	Sun, 20 Jul 2025 22:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051074;
	bh=bQHLI/XDtJZm9HEsQ0g9deG5tqTi5tjlQkIA/REe/F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoT/O8V9KBXBA0FUiJZF/6j68UfmQEKaN/YewQX4asJQrEW6Fm8k2RR0fzVkloNYT
	 eJzZSNzt+TTD81Bb7zYjljpkdQPFkwDRYKs6qxETWBe0jexaxxJJfExoZsUs6OLmVW
	 BFa8UnwYtTKnP8LpdfAhp4dT6rOmYOAiBu9I9HVbocpKwyOy7ownAAUaY2gw9vJ4rP
	 exHHaLT1RAQofvHaZjG/VilETXQN1yZM4KkOL8YEf4OG6PEjgVJVVLazWWgUX01Zqu
	 JFwjqKzZPwQMTip31DT+mQKRNTOR27T9AJS7lVIq4SC79o/mltAwRmmtLa6hfi9rJ9
	 LESEBrti0OtIw==
Date: Sun, 20 Jul 2025 17:37:54 -0500
From: Rob Herring <robh@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, noltari@gmail.com,
	jonas.gorski@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] net: dsa: b53: mmap: Add reference to
 bcm63xx gpio controller
Message-ID: <20250720223754.GA2930944-robh@kernel.org>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-3-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716002922.230807-3-kylehendrydev@gmail.com>

On Tue, Jul 15, 2025 at 05:29:01PM -0700, Kyle Hendry wrote:
> On bcm63xx SoCs there are registers that control the PHYs in
> the GPIO controller. Allow the b53 driver to access them
> by passing in the syscon through the device tree.

Bindings go before users of the binding.

More importantly, this patch does nothing on its own. Squash it with 
were you actually use priv->gpio_ctrl.

> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_mmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
> index c687360a5b7f..a0c06d703861 100644
> --- a/drivers/net/dsa/b53/b53_mmap.c
> +++ b/drivers/net/dsa/b53/b53_mmap.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/b53.h>
>  
> @@ -28,6 +29,7 @@
>  
>  struct b53_mmap_priv {
>  	void __iomem *regs;
> +	struct regmap *gpio_ctrl;
>  };
>  
>  static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
> @@ -313,6 +315,8 @@ static int b53_mmap_probe(struct platform_device *pdev)
>  
>  	priv->regs = pdata->regs;
>  
> +	priv->gpio_ctrl = syscon_regmap_lookup_by_phandle(np, "brcm,gpio-ctrl");
> +
>  	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
>  	if (!dev)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

