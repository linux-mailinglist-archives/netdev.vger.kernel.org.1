Return-Path: <netdev+bounces-24992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CA977278D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D5281399
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141581096D;
	Mon,  7 Aug 2023 14:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C8FC13
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B3DC433C8;
	Mon,  7 Aug 2023 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691418124;
	bh=cXFiuh6QE/l5gO4LSGbmHHnCOg0r0pMDyGjk4yYWqGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0jWe+U56RKMxh65PlSh0uPPdDBU77fJ9Tn/1K+nNW3X5eLmlmcqQ1IO/XanTxc4y
	 /r4mYYmhEJP9y+6hzmnp8PojJb3N1XcfwZUNwvOMrtmhTmBFO4vTjjq44TjR5Zbc+A
	 KMXyo+IYxfXbHpjq9MUoGp6fL/HiZObf+2O9Z3g1HTchwW5MQj6kIO6pCxC7vQ1b2T
	 O2+590JEwTPQK5Jvsy7VTDDtKkLMHICHK9o/A+rMINyr3MpMZ/80eEKqryjs96Fpmq
	 GD+y1WWgWk9ePAnQ+hgEknZh6VzDY63ob2hH+dYAKRm2hN5+KfZRX0qpnshbR/dagZ
	 9f9zydEc+YiOQ==
Date: Mon, 7 Aug 2023 16:21:58 +0200
From: Simon Horman <horms@kernel.org>
To: Da Xue <da@libre.computer>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Luke Lu <luke.lu@libre.computer>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] net: phy: meson-gxl: implement
 meson_gxl_phy_resume()
Message-ID: <ZND+BrB0OCqgLo9u@vergenet.net>
References: <20230804201903.1303713-1-da@libre.computer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804201903.1303713-1-da@libre.computer>

On Fri, Aug 04, 2023 at 04:19:02PM -0400, Da Xue wrote:
> After suspend and resume, the meson GXL internal PHY config needs to be initialized again or the carrier cannot be found.
> 
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> Reviewed-by: Da Xue <da@libre.computer>

Hi Da Xue,

as the posted of this patch you need to provide your signed-off-by line.

From the way things are structured above it is unclear what Luke's
role is. Was he the author of the patch? If so the body of the email,
just above the patch description, should start with:

From: Luke Lu <luke.lu@libre.computer>

Link: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index bb9b33b6b..2df516ed4 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int meson_gxl_phy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	genphy_resume();

This patch doesn't compile because the call to genphy_resume() has too
few arguments.

> +	ret = meson_gxl_config_init(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /* This function is provided to cope with the possible failures of this phy
>   * during aneg process. When aneg fails, the PHY reports that aneg is done
>   * but the value found in MII_LPA is wrong:
> @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
>  		.config_intr	= smsc_phy_config_intr,
>  		.handle_interrupt = smsc_phy_handle_interrupt,
>  		.suspend        = genphy_suspend,
> -		.resume         = genphy_resume,
> +		.resume         = meson_gxl_phy_resume,
>  		.read_mmd	= genphy_read_mmd_unsupported,
>  		.write_mmd	= genphy_write_mmd_unsupported,
>  	}, {
> -- 
> 2.39.2
> 
> 

