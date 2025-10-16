Return-Path: <netdev+bounces-230057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC318BE36C1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7657B582CC5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EE31AF1E;
	Thu, 16 Oct 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwiTDTK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4762E36F2;
	Thu, 16 Oct 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618214; cv=none; b=AV4yUlTv7QVtzod4OiWsfdCYfOLHu3xxMCrWJoNWb2Aks3za1FekfRkiVPyJ2D04spDbEJxMeeH3hy2s8S9fi6yvEmgwlrFnk/UnCkSGT0YVzhEfH+j32CNLi+p9utsaYOof6QE8FIWyrW73Qfj9zGtcahBWfsKUdC4OVEkYgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618214; c=relaxed/simple;
	bh=rWo5L43Wc3sm+4xT2/uBYLFVmx0bMIQ/PWAvIzOWufU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni8kU+6J8z7P+xyXT1RQM2ZyOtsPyqUToHEpqozl4l7HxvIwBFJXZXjE2WC1Ge55Hjd4x7Fnle79aBlj0hSlWPxJF50s63y61sKoA00g+Bmz35b11uscraPet7Tx66DvcYKYV9gz+WYu6+ysJcRyZDZHhdaHnBDDHHbvnwqIk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwiTDTK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7D2C113D0;
	Thu, 16 Oct 2025 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618214;
	bh=rWo5L43Wc3sm+4xT2/uBYLFVmx0bMIQ/PWAvIzOWufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwiTDTK0gLGZXQE1l0ADMryUJjR9GTZMa2eNNVrsEHwO61+qcOveY91BrUHlsy3jD
	 bs+Os5OmP32KJuLwI3/cCeT3bu4jorr2kobS7TZnEeRdfqM6hyb5cBk4k0lq+OlpX+
	 2vFK9Ss54Cs765ahcx19wfI7VfnAIKuuqZaZOE71YajqeI6PgkU1TdKDrj5ghfT/Vb
	 PnBn4wvJAFlyVQP1MYmsY9zv+uFM73Y+OyQJ50fxehDvxSqRega70Utmw+S3sCYTkr
	 WDZzLC+KSXxVsxxeLkEXIHi6VlHruA397fKOorRpSTFoEm3hLJJas9gj123k/GKor+
	 5dvPxGnSOqlyA==
Date: Thu, 16 Oct 2025 13:36:48 +0100
From: Simon Horman <horms@kernel.org>
To: Lizhe <sensor1010@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	jonas@kwiboo.se, chaoyi.chen@rock-chips.com,
	david.wu@rock-chips.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dwmac-rk: No need to check the return
 value of phy_power_on()
Message-ID: <aPDm4OMiM7Ug9rDf@horms.kernel.org>
References: <20251015051446.2677-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015051446.2677-1-sensor1010@163.com>

On Tue, Oct 14, 2025 at 10:14:46PM -0700, Lizhe wrote:
> 'phy_power_on' is a local scope one within the driver, since the
> return value of the phy_power_on() function is always 0, checking
> its return value is redundant.
> 
> the function name 'phy_power_on()' conflicts with the existing
> phy_power_on() function in the PHY subsystem. a suitable alternative
> name would be rk_phy_power_set(), particularly since when the
> second argument is false, this function actually powers off the PHY

This is two changes. I would lean towards splitting it into
two patches (in a single patch-set).

> 
> Signed-off-by: Lizhe <sensor1010@163.com>

Also, in future, please wait 24h between posting revisions of a patchset.
And note revisions in the subject, like this:

  Subject: [PATCH net-next v2] ...

https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 51ea0caf16c1..ac3324430b2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1461,23 +1461,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
>  	return 0;
>  }
>  
> -static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
> +static void rk_phy_power_set(struct rk_priv_data *bsp_priv, bool enable)
>  {
>  	struct regulator *ldo = bsp_priv->regulator;
>  	struct device *dev = bsp_priv->dev;
> -	int ret;
>  
>  	if (enable) {
> -		ret = regulator_enable(ldo);
> -		if (ret)
> +		if (regulator_enable(ldo))
>  			dev_err(dev, "fail to enable phy-supply\n");
>  	} else {
> -		ret = regulator_disable(ldo);
> -		if (ret)
> +		if (regulator_disable(ldo))
>  			dev_err(dev, "fail to disable phy-supply\n");

The 'ret' changes above don't relate to the patch description.
I'd leave this be. But if you really want to go this way
I think it would be a separate patch.

>  	}
> -
> -	return 0;
>  }
>  
>  static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,

-- 
pw-bot: changes-requested

