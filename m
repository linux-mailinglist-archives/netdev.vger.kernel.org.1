Return-Path: <netdev+bounces-203747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D6AF6F4F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BDE1C47B7B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15F2E0417;
	Thu,  3 Jul 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1W0cLuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98B2E040C;
	Thu,  3 Jul 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536422; cv=none; b=GMUdovXEguOd0rhOSBx5mmpP0d5RgOvZ0IH7L4xN4mr/EWMBoTzPmowsGvGzUfcAJDkRTIG4lcDYnFCHlgkGNUGkw3dRYwBGMDbW//XNXV7gpH5Ox4J98e380LTSIHxbeLW60IaBYMiUoTYUSKc4hB4WFybPjeulCCJWeghu0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536422; c=relaxed/simple;
	bh=Bi7+i0xNf9WQfukuXGjoBWe+6weV84Rvxqt6OcF2qAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZSfAM4CdQ8L2aD9/pKgwN2JMxMlDSn9BTFBElQlmfQdD/cTbY9ln7MaUmXg42tHt7B/f/hxruyJugc1nRJlkK+YvvEHSGUI9uESJKw8h4t2NGVrws0I+9t5DklCmTbnmAIDbp/4VYWDqGCOwIPhyTJ+RQBF50gbKVWsu+0zDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1W0cLuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACFC4CEE3;
	Thu,  3 Jul 2025 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751536421;
	bh=Bi7+i0xNf9WQfukuXGjoBWe+6weV84Rvxqt6OcF2qAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V1W0cLuADda8+8dkcJQZ6ONYe+BTc32UJh52Ihb0I074zOxXB8bR/F9I+cB+BT2uG
	 83MOZGrwN15ugDYfvoAakYItQIFz5xbrI4/99Z+I30+DnNpBB55+PtjKlvmhwU78O4
	 APJnwZRgJydgdgkd1ekU9K2uZgCYZgM39prCX4/Hil1G60RlhqwbmWXpo7UOk4N2P5
	 42bATMK7m3sl6psUl7bRE3udWeMHOPdxHztv6VJIgUSFgvG7gPvb1oSMtKlF5FeHZN
	 MtdHcfFLj9SOoiOt2UynwTYVnXmg62qs0d5xunlTuPasgnB5lPZwh4oXDp+VDoeSd7
	 cSj1VwLmkbn+g==
Message-ID: <f096afa1-260e-4f8c-8595-3b41425b2964@kernel.org>
Date: Thu, 3 Jul 2025 11:53:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ethernet: eswin: Add eic7700 ethernet driver
To: weishangjuan@eswincomputing.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
 vladimir.oltean@nxp.com, jszhang@kernel.org, jan.petrous@oss.nxp.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
 boon.khai.ng@altera.com, dfustini@tenstorrent.com, 0x1207@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703092015.1200-1-weishangjuan@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250703092015.1200-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2025 11:20, weishangjuan@eswincomputing.com wrote:
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 1,
> +					 &hsp_aclk_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get hsp_aclk_ctrl_offset\n");
> +
> +	regmap_read(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, &hsp_aclk_ctrl_regset);
> +	hsp_aclk_ctrl_regset |= (EIC7700_HSP_ACLK_CLKEN | EIC7700_HSP_ACLK_DIVSOR);
> +	regmap_write(dwc_priv->crg_regmap, hsp_aclk_ctrl_offset, hsp_aclk_ctrl_regset);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr", 2,
> +					 &hsp_cfg_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get hsp_cfg_ctrl_offset\n");
> +
> +	regmap_write(dwc_priv->crg_regmap, hsp_cfg_ctrl_offset, EIC7700_HSP_CFG_CTRL_REGSET);
> +
> +	dwc_priv->hsp_regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +							       "eswin,hsp_sp_csr");

There is no such property. I already said at v2 you cannot have
undocumented ABI.

> +	if (IS_ERR(dwc_priv->hsp_regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwc_priv->hsp_regmap),
> +				"Failed to get hsp_sp_csr regmap\n");
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 2,

NAK

> +					 &eth_phy_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get eth_phy_ctrl_offset\n");
> +
> +	regmap_read(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, &eth_phy_ctrl_regset);
> +	eth_phy_ctrl_regset |= (EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
> +	regmap_write(dwc_priv->hsp_regmap, eth_phy_ctrl_offset, eth_phy_ctrl_regset);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr", 3,
> +					 &eth_axi_lp_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "can't get eth_axi_lp_ctrl_offset\n");
> +
> +	regmap_write(dwc_priv->hsp_regmap, eth_axi_lp_ctrl_offset, EIC7700_ETH_CSYSREQ_VAL);
> +
> +	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> +	if (IS_ERR(plat_dat->clk_tx_i))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
> +				"error getting tx clock\n");
> +
> +	plat_dat->fix_mac_speed = eic7700_qos_fix_speed;
> +	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> +	plat_dat->bsp_priv = dwc_priv;
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to driver probe\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id eic7700_dwmac_match[] = {
> +	{ .compatible = "eswin,eic7700-qos-eth" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, eic7700_dwmac_match);
> +
> +static struct platform_driver eic7700_dwmac_driver = {
> +	.probe  = eic7700_dwmac_probe,
> +	.remove = stmmac_pltfr_remove,
> +	.driver = {
> +		.name           = "eic7700-eth-dwmac",
> +		.pm             = &stmmac_pltfr_pm_ops,
> +		.of_match_table = eic7700_dwmac_match,
> +	},
> +};
> +module_platform_driver(eic7700_dwmac_driver);
> +
> +MODULE_AUTHOR("Eswin");

Drop, that's not a person.


Best regards,
Krzysztof

