Return-Path: <netdev+bounces-229525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312EFBDD91F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9143E1920656
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D41E260D;
	Wed, 15 Oct 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH+F/PFS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A13195FC;
	Wed, 15 Oct 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518764; cv=none; b=hAGiWlsw6TLakxlj7M3Yvvs3r7WnqqMTFGZYhrrhdjkjwGLzWCBkTJJP36vDLcOxqe2FMgY/8YzXfPP/MCYCY3iVsq2F0FEXc9u3lHz/6ZDf9ipdQWzRpODsyW3c/9+B2YXwR9cce/mpR+HICZWaxSI8Ky9lQtPUM/mdIx5G9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518764; c=relaxed/simple;
	bh=EUYhWksXVGZIMju1edC1CGm/fB7mrhfKVvKphQHqdsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGgA3kwyWNpmY1UZYTXa+rTX9GcSFMWxxb180bNudd19DS5BJNSuKCjRAqrnzsAQPY2Bru6HbpPOJdJC66VnZ0D9gG6HB3Cw0CKCXWNYMCCfCtLdgodERg1PNt1ppGigZu9yZ6XrgKZkd2zMLauWFhUSsxiHfeJkxv/SKNHH4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH+F/PFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D39BC4CEF8;
	Wed, 15 Oct 2025 08:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760518763;
	bh=EUYhWksXVGZIMju1edC1CGm/fB7mrhfKVvKphQHqdsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rH+F/PFSbSD5IInXuBF4/jDYiiMZTN23+ow/kLEFM6BYicaDp13195B7+KbDTI4tx
	 qhl2be3E56oVhlCNoJrZACe3iLiwODwZXbjnhIJVlLPZgQyR6PwHbuWuTT0EQ5qmN0
	 68o3n3a8sn21DrcdRfN6su9UF0QA8wFe/ESAf4DfVKcN+aET1TFCDWEB43P8BmhHD0
	 y3zHF6P4eoKJoqI5f3xmaBlmo4z9ivcLLyzynb5Vn8dgMdajJQzJqC662g6RBMyFz2
	 mRef9MD4sI4guKNrC8BZ8truUf0o5P5kllFhvS5pASuefg47i3npqJx0h2dzZQRDc5
	 gX11R2L66LkQA==
Date: Wed, 15 Oct 2025 09:59:18 +0100
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
 value of the phy_power_on()
Message-ID: <aO9iZiMBs3pUnb77@horms.kernel.org>
References: <20251015040847.6421-1-sensor1010@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015040847.6421-1-sensor1010@163.com>

On Tue, Oct 14, 2025 at 09:08:47PM -0700, Lizhe wrote:
> 'phy_power_on' is a local scope one within the driver, since the return
> value of the phy_power_on() function is always 0, checking its return
> value is redundant.
> 
> the function name 'phy_power_on()' conflicts with the existing
> phy_power_on() function in the PHY subsystem. a suitable alternative
> name would be rk_phy_power_set(), particularly since when the second
> argument is false, this function actually powers off the PHY
> 
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 51ea0caf16c1..9d296bfab013 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1461,23 +1461,18 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
>  	return 0;
>  }
>  
> -static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
> +static void rk_phy_power_on(struct rk_priv_data *bsp_priv, bool enable)

Hi Lizhe,

This introduces a compilation error because phy_power_on()
is still used on line 1670.

Perhaps the hunk to update that line got lost somewhere.

-- 
pw-bot: changes-requested

...

