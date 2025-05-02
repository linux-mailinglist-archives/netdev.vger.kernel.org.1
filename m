Return-Path: <netdev+bounces-187478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BBAA7509
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1590598474F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517612550B2;
	Fri,  2 May 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulU8ezpv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20D151991;
	Fri,  2 May 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196439; cv=none; b=dLuSFqz+nrrqRmUG8fYc8VTovaVGgUfFG7iAp5D4UXbRD+D7QOta4/ledEaqtVtAnPrb/V/nnunUNdTrV/rjPqrPKhdmsrBoxXGNkJd6vqx/4x7htfyxxwheWP0Qr7qc6ov4i9wBeUMS04DTjth9IiaUzefckPzkqUhmgUOxQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196439; c=relaxed/simple;
	bh=3OB+vCsY1Nf1uqDEFMD9tdzEcnzhPdE9qneBGjxivtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfUnwutZhlWGQVCtk1rao8GK2cm3jeHUfS2RqulSxmHjFThs13iWOvEvyoBLKfxr3wfGS3Pibl7QyljVUXNcHd9Vo+/fmp26N0y48Zl4SxztUP3Gq7yc6eJpkEtZUlVaXvA2fmQZjPN6szYlNqYrEfWuUBnj0IsYCYIwAch3OTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulU8ezpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E36C4CEE4;
	Fri,  2 May 2025 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746196437;
	bh=3OB+vCsY1Nf1uqDEFMD9tdzEcnzhPdE9qneBGjxivtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ulU8ezpvMpMndR+a4tvGp+KoP+p+oCpffievS/+dJkj6xqVkxn0sCRAu2U8JnB4VV
	 +zwWoXgxuLrV9cv0EDt0xNHIkG+KXRHMR5WAZ/4dBJnhIoDM85xoV8iBgO8DJ7uxCj
	 2oC7Z/IcA1u7OWaKJfgCChQ3P/LDZOvQcJZy5qwVPnNmwxp7zJSgJljjqM0dmjw1lp
	 k2acbxAw9vFUGDiW6zdz5DXGWudMhbnIQgIT9tPUPY6JmoM1KdQ+Vl3BQvZpSE1mYk
	 HC6sYnOwpgT3nrsL/Kwv6o3Zgod6nYd0E/lL0GQ4fnV55cNu2aRjYZhIskcLbVV0Qp
	 TvhLflrSQkDbA==
Message-ID: <a01df80b-c1ee-4c36-b400-e3044a0156e2@kernel.org>
Date: Fri, 2 May 2025 16:33:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250502074447.2153837-1-lukma@denx.de>
 <20250502074447.2153837-5-lukma@denx.de>
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
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
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
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20250502074447.2153837-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2025 09:44, Lukasz Majewski wrote:
> +
> +static int mtip_parse_of(struct switch_enet_private *fep,
> +			 struct device_node *np)
> +{
> +	struct device_node *p;
> +	unsigned int port_num;
> +	int ret = 0;
> +
> +	p = of_find_node_by_name(np, "ethernet-ports");

This should be looking for children, not any nodes. Otherwise you will
take the ethernet ports from a next device as well.

> +
> +	for_each_available_child_of_node_scoped(p, port) {
> +		if (of_property_read_u32(port, "reg", &port_num))
> +			continue;
> +
> +		if (port_num > SWITCH_EPORT_NUMBER) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: The switch supports up to %d ports!\n",
> +				__func__, SWITCH_EPORT_NUMBER);
> +			goto of_get_err;
> +		}
> +
> +		fep->n_ports = port_num;
> +		ret = of_get_mac_address(port, &fep->mac[port_num - 1][0]);
> +		if (ret)
> +			dev_dbg(&fep->pdev->dev,
> +				"of_get_mac_address(%pOF) failed (%d)!\n",
> +				port, ret);
> +
> +		ret = of_property_read_string(port, "label",
> +					      &fep->ndev_name[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get ethernet port name (%d)!\n",
> +				__func__, ret);
> +			goto of_get_err;
> +		}
> +
> +		ret = of_get_phy_mode(port, &fep->phy_interface[port_num - 1]);
> +		if (ret < 0) {
> +			dev_err(&fep->pdev->dev,
> +				"%s: Cannot get PHY mode (%d)!\n", __func__,
> +				ret);
> +			goto of_get_err;
> +		}
> +
> +		fep->phy_np[port_num - 1] = of_parse_phandle(port,
> +							     "phy-handle", 0);
> +	}
> +
> + of_get_err:
> +	of_node_put(p);
> +
> +	return ret;
> +}
> +
> +static int mtip_sw_learning(void *arg)
> +{
> +	struct switch_enet_private *fep = arg;
> +
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		/* check learning record valid */
> +		mtip_atable_dynamicms_learn_migration(fep, fep->curr_time,
> +						      NULL, NULL);
> +		schedule_timeout(HZ / 100);
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtip_mii_unregister(struct switch_enet_private *fep)
> +{
> +	mdiobus_unregister(fep->mii_bus);
> +	mdiobus_free(fep->mii_bus);
> +}
> +
> +static const struct mtip_devinfo mtip_imx28_l2switch_info = {
> +	.quirks = FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO |
> +		  FEC_QUIRK_SWAP_FRAME,
> +};
> +
> +static const struct of_device_id mtipl2_of_match[] = {
> +	{ .compatible = "nxp,imx28-mtip-switch",
> +	  .data = &mtip_imx28_l2switch_info},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mtipl2_of_match);
> +
> +static int mtip_sw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +	struct switch_enet_private *fep;
> +	struct mtip_devinfo *dev_info;
> +	int ret;
> +
> +	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> +	if (!fep)
> +		return -ENOMEM;
> +
> +	of_id = of_match_node(mtipl2_of_match, pdev->dev.of_node);
> +	if (of_id) {
> +		dev_info = (struct mtip_devinfo *)of_id->data;

Do not open-code of_device_get_match_data().

> +		if (dev_info)
> +			fep->quirks = dev_info->quirks;
> +	}
> +
> +	fep->pdev = pdev;
> +	platform_set_drvdata(pdev, fep);
> +
> +	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fep->enet_addr))
> +		return PTR_ERR(fep->enet_addr);
> +
> +	fep->irq = platform_get_irq_byname(pdev, "enet_switch");
> +	if (fep->irq < 0)
> +		return fep->irq;
> +
> +	ret = mtip_parse_of(fep, np);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "%s: OF parse error (%d)!\n", __func__,
> +			ret);

Syntax is:
return dev_err_probe
just like you have in other places

> +		return ret;
> +	}
> +
> +	/* Create an Ethernet device instance.
> +	 * The switch lookup address memory starts at 0x800FC000
> +	 */
> +	fep->hwp_enet = fep->enet_addr;
> +	fep->hwp = fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
> +	fep->hwentry = (struct mtip_addr_table __iomem *)
> +		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
> +
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "phy");
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Unable to get and enable 'phy'\n");
> +
> +	fep->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(fep->clk_ipg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ipg),
> +				     "Unable to acquire 'ipg' clock\n");
> +
> +	fep->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(fep->clk_ahb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ahb),
> +				     "Unable to acquire 'ahb' clock\n");
> +
> +	fep->clk_enet_out = devm_clk_get_optional_enabled(&pdev->dev,
> +							  "enet_out");
> +	if (IS_ERR(fep->clk_enet_out))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_enet_out),
> +				     "Unable to acquire 'enet_out' clock\n");
> +
> +	/* setup MII interface for external switch ports */
> +	mtip_enet_init(fep, 1);
> +	mtip_enet_init(fep, 2);
> +
> +	spin_lock_init(&fep->learn_lock);
> +	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->mii_lock);
> +
> +	ret = devm_request_irq(&pdev->dev, fep->irq, mtip_interrupt, 0,
> +			       dev_name(&pdev->dev), fep);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, fep->irq,
> +				     "Could not alloc IRQ\n");
> +
> +	ret = mtip_register_notifiers(fep);
> +	if (ret)
> +		return ret;
> +
> +	ret = mtip_ndev_init(fep, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Failed to create virtual ndev (%d)\n",
> +			__func__, ret);
> +		goto ndev_init_err;
> +	}
> +
> +	ret = mtip_switch_dma_init(fep);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: ethernet switch init fail (%d)!\n",
> +			__func__, ret);
> +		goto dma_init_err;
> +	}
> +
> +	ret = mtip_mii_init(fep, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: Cannot init phy bus (%d)!\n", __func__,
> +			ret);
> +		goto mii_init_err;
> +	}
> +	/* setup timer for learning aging function */
> +	timer_setup(&fep->timer_aging, mtip_aging_timer, 0);
> +	mod_timer(&fep->timer_aging,
> +		  jiffies + msecs_to_jiffies(LEARNING_AGING_INTERVAL));
> +
> +	fep->task = kthread_run(mtip_sw_learning, fep, "mtip_l2sw_learning");
> +	if (IS_ERR(fep->task)) {
> +		ret = PTR_ERR(fep->task);
> +		dev_err(&pdev->dev, "%s: learning kthread_run error (%d)!\n",
> +			__func__, ret);

ret = dev_err_probe

> +		goto task_learning_err;
> +	}
> +
> +	return 0;
> +
> + task_learning_err:
> +	timer_delete_sync(&fep->timer_aging);
> +	mtip_mii_unregister(fep);
> + mii_init_err:
> + dma_init_err:
> +	mtip_ndev_cleanup(fep);
> + ndev_init_err:
> +	mtip_unregister_notifiers(fep);
> +
> +	return ret;
> +}
> +
> +static void mtip_sw_remove(struct platform_device *pdev)
> +{
> +	struct switch_enet_private *fep = platform_get_drvdata(pdev);
> +
> +	mtip_unregister_notifiers(fep);
> +	mtip_ndev_cleanup(fep);
> +
> +	mtip_mii_remove(fep);
> +
> +	kthread_stop(fep->task);
> +	timer_delete_sync(&fep->timer_aging);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	kfree(fep);

Jakub already pointed out that tools would find this bug but also
testing. This was not ever tested. If it was, you would see nice clear
double free.

All last three versions had trivial issues which are pointed out by
tooling, compilers, static analyzers. Before you post next version.
please run standard kernel tools for static analysis, like coccinelle,
smatch and sparse, and fix reported warnings. Also please check for
warnings when building with W=1 with clang. Most of these commands
(checks or W=1 build) can build specific targets, like some directory,
to narrow the scope to only your code. The code here looks like it needs
a fix. Feel free to get in touch if the warning is not clear.

You do not nede the the top-level, one of the most busy maintainers to
point out the issues which compilers find as well. Using reviewers
instead of automated tools is the easiest way to get grumpy responses.


Best regards,
Krzysztof

