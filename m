Return-Path: <netdev+bounces-177643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A626A70D46
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 23:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030CA179306
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98E26A0C6;
	Tue, 25 Mar 2025 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tybl/GdL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011051EFF98;
	Tue, 25 Mar 2025 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943144; cv=none; b=fC6qGS/1CLGt3letAGhaR/POe72PeJ3g3RiTMA58DmHp4w7QNl+/IM+P93/AvUvaoGOieKI0VuPztGXJA3b1ep+s7a9NfmVdKvCoo+WmMuxpfwqqz3T3duXV+PGh11QzP1JZyEbQZ2oou7dKfQnYLLyjafx/ZKM3euEmDn/FjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943144; c=relaxed/simple;
	bh=s5q9+6fIiVBPUE+BCuIyJBoQUMY7xMb7Hz+fIrOUrpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqUM5nBGpmyceZkUc2Khx3WkcrKQ1nP6IdKEgQ5HN5jS8tbNuD7TfoRPd4eRaCQPRbVoV1njzMxTWvmeHy2j5wRmhPMafe1XjoajgvBxbSgvyVzcXPYr05kpPecZSHAN+PKhZaXq/D/09B0njJamaqfLF8PVfChs7VeyygRVYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tybl/GdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E030C4CEE9;
	Tue, 25 Mar 2025 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742943143;
	bh=s5q9+6fIiVBPUE+BCuIyJBoQUMY7xMb7Hz+fIrOUrpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tybl/GdLK10TBJU+VIc63abkA175F4g9CqD7Yl8FNGtk93qpc55VSIRzKlHvaEwrX
	 ari8G50MwUaLxk0NjspvoPcMabur7H9rISJ44mGnkDV9TK+w36m1o9lzgFkPAhUkX4
	 WirUjY7EDj3HE5TBvRdV2IXrK0QelCesepX4yoZBZ++SOcb3aSOL9QTja+Ab0Wukdj
	 kPDZiiH3QkQb0igc4O+Da/3J5dYR2Zw20G5omsdNCwUvmohmJjTfbCbmLUGeO7YYb8
	 puxYp5FMOrwa8OdmVVFHcIsfQ/oRXl7FnCjpUoTzVAVBFugB2bvVkIHPdc/vzUMhY7
	 kTJl1vN5uDk+A==
Date: Tue, 25 Mar 2025 15:52:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lucien.Jheng" <lucienx123@gmail.com>
Cc: linux-clk@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, daniel@makrotopia.org, ericwouds@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com
Subject: Re: [PATCH v6 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
Message-ID: <20250325155214.44a65306@kernel.org>
In-Reply-To: <20250324142759.35141-1-lucienx123@gmail.com>
References: <20250324142759.35141-1-lucienx123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 22:27:59 +0800 Lucien.Jheng wrote:
> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
> CKO clock operates continuously from power-up through md32 loading.
> Implement clk provider driver so we can disable the clock output in case
> it isn't needed, which also helps to reduce EMF noise
> 
> Signed-off-by: Lucien.Jheng <lucienx123@gmail.com>

This was posted after merge window started, so let me give you some
extra nit picks and please repost after April 7th.

> +static int en8811h_clk_enable(struct clk_hw *hw)
> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +
> +	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
> +				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);

misaligned, continuation should align to opening bracket

> +static int en8811h_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
> +	struct phy_device *phydev = priv->phydev;
> +	int ret = 0;

unnecessary init

> +	u32 pbus_value;
> +
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (pbus_value & EN8811H_CLK_CGM_CKO);
> +}
> +
> +static const struct clk_ops en8811h_clk_ops = {
> +	.recalc_rate = en8811h_clk_recalc_rate,
> +	.enable = en8811h_clk_enable,
> +	.disable = en8811h_clk_disable,

these are not tab-aligned

> +	.is_enabled	= en8811h_clk_is_enabled,

this one is

> +};
> +
> +static int en8811h_clk_provider_setup(struct device *dev,
> +				      struct clk_hw *hw)

no need to wrap this line

> +{
> +	struct clk_init_data init;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name =  devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
> +				    fwnode_get_name(dev_fwnode(dev)));

double space
-- 
pw-bot: cr

