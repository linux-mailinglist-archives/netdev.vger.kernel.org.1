Return-Path: <netdev+bounces-151055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B289EC994
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271461889FE3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB41C5CAC;
	Wed, 11 Dec 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvAEbMI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CF236F9D;
	Wed, 11 Dec 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733910357; cv=none; b=FqzHRO7TKVaWdgyTJ8n788L0oeyQUcPj3bWLjoUq+oIhvvJ/xdSmKhje60YAmREhiwWkTWw0PzRJnOsVPC1D0skMDfxGCAqdHDLw9catj2k62UQituppQtxjbcCzvRHDspbVeDAW0u20/n7QLaBkRQUQrGui5EK6JYdHAkvM/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733910357; c=relaxed/simple;
	bh=TLG1JXv+ExtIVMQQwLMu9xMOfDG7DssWntfH4Ei9uJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwrKXSmW/BfEJAvJOH+3II0vztu/pVt4T0i/jgel/Rj3jO0kwQ8h5MTl66WqF1sHCMqn3Y05/rP4Kx40fa9R9IfG4sXGxSZTHahH+Hl75Ne9kOUzE5a8haq9XjrnBxnK98Hrh8nHJirDtiQsjqhchnwlS5fPiUDYAvFNxlcGMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvAEbMI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AEBC4CED2;
	Wed, 11 Dec 2024 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733910357;
	bh=TLG1JXv+ExtIVMQQwLMu9xMOfDG7DssWntfH4Ei9uJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvAEbMI21N1cZkZRNj/LxwRtEhQiFpDv9rvb0qfZhdTj157y59fr+RTpciHtZLk5B
	 d4Ayh7QqfqVFHq5TdnneEKpMX/E+qJ6t2/ePhqjy8qWtlHrStnnhvE5WT5/LfkHqwy
	 CqLQpUpDfl/Gc6cAE+vsLc26wuITVURc3jptJIZZiogFhR6fXuyKibd4uExZBxK+mD
	 1vVVoHkY6uooE5z6sbLNC+EujORlpprS+yfzyqlPqGGHGJVuhmVua7vUlyL2PKSY4F
	 Gj3waoS3uzt39bU5JapGMa7i3W8paBQbeUrP+0HoB2DnK9qTF43btgZyFn6TS/87Vy
	 m2b3NY6Czbg9g==
Date: Wed, 11 Dec 2024 10:45:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: dp83822: Add support for GPIO2
 clock output
Message-ID: <qqqwdzmcnkuga6qvvszgg7o2myb26sld5i37e4konhln2n4cgc@mwtropwj3ywv>
References: <20241211-dp83822-gpio2-clk-out-v2-0-614a54f6acab@liebherr.com>
 <20241211-dp83822-gpio2-clk-out-v2-2-614a54f6acab@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-dp83822-gpio2-clk-out-v2-2-614a54f6acab@liebherr.com>

On Wed, Dec 11, 2024 at 09:04:40AM +0100, Dimitri Fedrau wrote:
> The GPIO2 pin on the DP83822 can be configured as clock output. Add support
> for configuration via DT.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/net/phy/dp83822.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> index 25ee09c48027c86b7d8f4acb5cbe2e157c56a85a..dc5595eae6cc74e5c77914d53772c5fad64c3e70 100644
> --- a/drivers/net/phy/dp83822.c
> +++ b/drivers/net/phy/dp83822.c
> @@ -14,6 +14,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/bitfield.h>
>  
> +#include <dt-bindings/net/ti-dp83822.h>
> +
>  #define DP83822_PHY_ID	        0x2000a240
>  #define DP83825S_PHY_ID		0x2000a140
>  #define DP83825I_PHY_ID		0x2000a150
> @@ -30,6 +32,7 @@
>  #define MII_DP83822_FCSCR	0x14
>  #define MII_DP83822_RCSR	0x17
>  #define MII_DP83822_RESET_CTRL	0x1f
> +#define MII_DP83822_IOCTRL2	0x463
>  #define MII_DP83822_GENCFG	0x465
>  #define MII_DP83822_SOR1	0x467
>  
> @@ -104,6 +107,11 @@
>  #define DP83822_RX_CLK_SHIFT	BIT(12)
>  #define DP83822_TX_CLK_SHIFT	BIT(11)
>  
> +/* IOCTRL2 bits */
> +#define DP83822_IOCTRL2_GPIO2_CLK_SRC		GENMASK(6, 4)
> +#define DP83822_IOCTRL2_GPIO2_CTRL		GENMASK(2, 0)
> +#define DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF	GENMASK(1, 0)
> +
>  /* SOR1 mode */
>  #define DP83822_STRAP_MODE1	0
>  #define DP83822_STRAP_MODE2	BIT(0)
> @@ -139,6 +147,8 @@ struct dp83822_private {
>  	u8 cfg_dac_minus;
>  	u8 cfg_dac_plus;
>  	struct ethtool_wolinfo wol;
> +	bool set_gpio2_clk_out;
> +	u32 gpio2_clk_out;
>  };
>  
>  static int dp83822_config_wol(struct phy_device *phydev,
> @@ -413,6 +423,15 @@ static int dp83822_config_init(struct phy_device *phydev)
>  	int err = 0;
>  	int bmcr;
>  
> +	if (dp83822->set_gpio2_clk_out)
> +		phy_modify_mmd(phydev, MDIO_MMD_VEND2, MII_DP83822_IOCTRL2,
> +			       DP83822_IOCTRL2_GPIO2_CTRL |
> +			       DP83822_IOCTRL2_GPIO2_CLK_SRC,
> +			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CTRL,
> +					  DP83822_IOCTRL2_GPIO2_CTRL_CLK_REF) |
> +			       FIELD_PREP(DP83822_IOCTRL2_GPIO2_CLK_SRC,
> +					  dp83822->gpio2_clk_out));

You include the header but you do not use the defines, so it's a proof
these are register values. Register values are not bindings, they do not
bind anything. Bindings are imaginary numbers starting from 0 or 1 which
are used between drivers and DTS, serving as abstraction layer (or
abstraction values) between these two.

You do not have here abstraction. Drop the bindings header entirely.

Best regards,
Krzysztof


