Return-Path: <netdev+bounces-51238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB17F9CCC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8C7B20D9A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED0A168D4;
	Mon, 27 Nov 2023 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUwcmB/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AC806;
	Mon, 27 Nov 2023 09:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E3C433C7;
	Mon, 27 Nov 2023 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701077886;
	bh=BN2LicB5jxds9fx+ZEYukWJ29CfaB31EBJL8lQdSPpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUwcmB/lgL3jexVnTCttyrHGUr+uCTFiZEZ8hgmdHk2vw9TJmIuIOfHtXWmJ3kQj2
	 UiSprLMu3oYSCNX9cGfhg53z0BYsdAeosAir6hK4zobLLKVrvOhLBueWWY+ji1oZTz
	 wrhUZ1tJ4bf8yS/FPSyOp2kLIWgUdWnVbQ3AUiE573G5jCc1y/2qgQbjMg7IIr7jS6
	 MiLNKThT9h1shVCbDuR47x5Y8Hc2i0We224TqtH2PxEpOZgprzYonlUePKDrdHdDqg
	 UU73HOpbe5swirTJMn4vf1ae6FJJY09RRNNBLsfJnwgJCh38eX9/M3t+hwlwMnYw0D
	 qHXYyNHjRPajg==
Date: Mon, 27 Nov 2023 09:37:59 +0000
From: Simon Horman <horms@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 2/9] net: mdio: ipq4019: Enable the clocks for ipq5332
 platform
Message-ID: <20231127093759.GD84723@kernel.org>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-3-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115032515.4249-3-quic_luoj@quicinc.com>

On Wed, Nov 15, 2023 at 11:25:08AM +0800, Luo Jie wrote:
> For the platform ipq5332, the related GCC clocks need to be enabled
> to make the GPIO reset of the MDIO slave devices taking effect.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/mdio/mdio-ipq4019.c | 67 +++++++++++++++++++++++++++++----
>  1 file changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index 9d444f5f7efb..a77982a1a1e1 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c

...

> +const char *const mdio_clk_name[] = {
> +	"gcc_mdio_ahb_clk",
> +	"gcc_uniphy0_ahb_clk",
> +	"gcc_uniphy0_sys_clk",
> +	"gcc_uniphy1_ahb_clk",
> +	"gcc_uniphy1_sys_clk"
>  };

Hi Luo Jie,

A minor nit from my side: It appears that mdio_clk_name is only
used in this file. If so it should be declared as static.

...

