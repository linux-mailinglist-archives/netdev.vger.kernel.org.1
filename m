Return-Path: <netdev+bounces-234249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DFC1E1E1
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5636E4E36AA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F78303A06;
	Thu, 30 Oct 2025 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXeivoYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC232302CC9;
	Thu, 30 Oct 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790898; cv=none; b=PKIiM01Rc6YR5+wCBP/UpocdNEWSpMWA3SBE/iZdBuOzBuKoEC3hnSmgBIPE7W5HNVTbTv+eLOllJhZoHMc5o5gPASf27QW4ZKZCXytWa7HEBHoBFAaGYfdij906OcBPop4zxaFRTl8FUIK6AXorvv9HgglxyFBC7NqGvOtK2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790898; c=relaxed/simple;
	bh=wa2sUdEchOAiuz3+hiAyB8Dv5L0tT3wnkmLfpm/KCOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfU36ICQ64XMwN5NmeEPCiVwlyxMgZeYuRQqp9vQ5NyM1UIYY93/PlZmWBrxkw9T0bbi/TdBsCRkY9dIoxwrzBrrDDTvneOVFLc2q/SMblKvgPnmiBLQmval9nyhfSTmir+Li9nnD9ao5FRlQHF7nnglDoKrYbwzYyfglLgdRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXeivoYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51F5C4CEF7;
	Thu, 30 Oct 2025 02:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761790897;
	bh=wa2sUdEchOAiuz3+hiAyB8Dv5L0tT3wnkmLfpm/KCOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DXeivoYtgN4428rHUo6UoD4UJNXMGRvMJi74zv3PZ/bpW+5bMi9eJxtx5nWE5vAor
	 gwHFz6Y+ZPh+E0EuzS45oB+4hDkIr0rHKYiCfLXZ8/QISfzfkwn+peHlButTtty5nY
	 3WRUIzWZ4t3TKNOy7l5x8bYFH//jQvoOyorXdZzspMRsofOTHLyf+klN/lKUjUkeuX
	 0LpYvtQNsHRMPjLXwiKsyTE0tugT2rnwjCaoOi/Nx++zXYDsdWv8xsz0Mc+cLlIGgG
	 KguuOrZ5iZ0+gl8i2qfynK/L/gxkys/8Aho3hapiDjMaIzmWh6JRW9Bs48AXiHR+Ov
	 KkEF3rvz51Y4Q==
Date: Wed, 29 Oct 2025 19:21:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Message-ID: <20251029192135.0bada779@kernel.org>
In-Reply-To: <20251027032905.94147-6-dong100@mucse.com>
References: <20251027032905.94147-1-dong100@mucse.com>
	<20251027032905.94147-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 11:29:05 +0800 Dong Yibo wrote:
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 37bd9278beaa..27fb080c0e37 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>

Why do you need to include netdevice.h here now?
This patch doesn't add anything that'd need it to the header.

>  enum rnpgbe_boards {
>  	board_n500,
> @@ -26,18 +27,38 @@ struct mucse_mbx_info {
>  	u32 fwpf_ctrl_base;
>  };
>  
> +/* Enum for firmware notification modes,
> + * more modes (e.g., portup, link_report) will be added in future
> + **/
> +enum {
> +	mucse_fw_powerup,
> +};

> +	err = rnpgbe_get_permanent_mac(hw);
> +	if (err == -EINVAL) {
> +		dev_warn(&pdev->dev, "Using random MAC\n");
> +		eth_random_addr(hw->perm_addr);
> +	} else if (err) {
> +		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
> +		goto err_powerdown;
> +	}
> +
> +	eth_hw_addr_set(netdev, hw->perm_addr);

This is wrong, you may have gotten random address. This will make it
look like a real permanent address. Should be:

	err = rnpgbe_get_permanent_mac(hw);
	if (!err) {
		eth_hw_addr_set(netdev, hw->perm_addr);
	} else if (err == -EINVAL) {
		dev_warn(&pdev->dev, "Using random MAC\n");
		eth_hw_addr_random(netdev);
		ether_addr_copy(hw->perm_addr, dev->dev_addr);
	} else if (err) {
		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
		goto err_powerdown;
	}

