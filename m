Return-Path: <netdev+bounces-178119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E67A74C4A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB64D16F040
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E41BD9CE;
	Fri, 28 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUvmTKlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198411B0F33;
	Fri, 28 Mar 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171553; cv=none; b=eEjhKKbub266c8QnrKCn23sO1Ytvr5L6GdQWnCFcM7HB5dk4VdAvTsV74MzXJ/MQMSdDGDQztv/ikQpH1rFGVqxJrH06WP52/XXyq4dyNdiAgDeSGRBmyqEXZQ08ILkzjS6odGs6fW5i8g1oaL46L8xJfrgFZXRz9JrYlQYtWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171553; c=relaxed/simple;
	bh=453jEEEbcZJcDGnlBErpc5uescUKMrgYZjmGEdOp6GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR70Eq61xO/szGBOb+4wDfwHsJFHMYYlqRizsql6wEbKMq+Skm40mJxhv+JEAIx89Rp47xf/Mh6ETL9tYuKs+OGZlPo+krr2+hQTCkipJNHl5B8lKDTzvWDZCEX9k633t/qf2cCdMs4lP5dxYasrhZg8FO17n9t/SpNG1blDmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUvmTKlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D405C4CEEA;
	Fri, 28 Mar 2025 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171552;
	bh=453jEEEbcZJcDGnlBErpc5uescUKMrgYZjmGEdOp6GQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BUvmTKlYyRbj7zjwx82dT0AypjOUBmYrA4ki1VWMld0ft0SzEN27whaNl1x4XJFJ8
	 RsAOC6EpUoah81RAaViXWF5pdyAiLtFj4bi+g8rTq77VroojFuSZAxZdHDFq7EYhOs
	 Jn/Lm8p6rM4otPXfmQo+qUDQ7P0mV8Mb7anb0EDpuxYDaCTbVFm0vX+bDHs3n50vnb
	 dFtNY8o7i4XojQBV8NRvagX08s1XHzP84XQ5TkL652BqOKLD8cHYngO0iq9gqgBNBK
	 zbiXoM02RmhpHSJFJGy04fLBDYGuMhIoSUBc1C9Lu8iMu51fEo7nudBwS6DyIMvhD0
	 nuHYCYq+AULcQ==
Message-ID: <060f8fb2-bade-4d80-93bc-effb3657d5a3@kernel.org>
Date: Fri, 28 Mar 2025 15:19:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net: mtip: The L2 switch driver for imx287
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-5-lukma@denx.de>
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
In-Reply-To: <20250328133544.4149716-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2025 14:35, Lukasz Majewski wrote:
> +
> +static void mtip_mii_unregister(struct switch_enet_private *fep)
> +{
> +	mdiobus_unregister(fep->mii_bus);
> +	mdiobus_free(fep->mii_bus);
> +}
> +
> +static const struct fec_devinfo fec_imx28_l2switch_info = {
> +	.quirks = FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_SINGLE_MDIO,
> +};
> +
> +static struct platform_device_id pdev_id = {

That's const.

> +	.name = "imx28-l2switch",
> +	.driver_data = (kernel_ulong_t)&fec_imx28_l2switch_info,
> +};
> +
> +static int __init mtip_sw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct switch_enet_private *fep;
> +	struct fec_devinfo *dev_info;
> +	struct switch_t *fecp;
> +	int ret;
> +
> +	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> +	if (!fep)
> +		return -ENOMEM;
> +
> +	pdev->id_entry = &pdev_id;

Hm? This is some odd pattern. You are supposed to use OF table and get
matched by it, not populate some custom/odd handling of platform tables.

> +
> +	dev_info = (struct fec_devinfo *)pdev->id_entry->driver_data;

I did not notice it before, but that's a no - you cannot drop the cast.
Driver data is always const.

> +	if (dev_info)
> +		fep->quirks = dev_info->quirks;
> +
> +	fep->pdev = pdev;
> +	platform_set_drvdata(pdev, fep);
> +
> +	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fep->enet_addr))
> +		return PTR_ERR(fep->enet_addr);
> +
> +	fep->irq = platform_get_irq(pdev, 0);
> +	if (fep->irq < 0)
> +		return fep->irq;
> +
> +	ret = mtip_parse_of(fep, np);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "%s: OF parse error (%d)!\n", __func__,
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Create an Ethernet device instance.
> +	 * The switch lookup address memory starts at 0x800FC000
> +	 */
> +	fep->hwp_enet = fep->enet_addr;
> +	fecp = (struct switch_t *)(fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET);
> +
> +	fep->hwp = fecp;
> +	fep->hwentry = (struct mtip_addr_table_t *)
> +		((unsigned long)fecp + MCF_ESW_LOOKUP_MEM_OFFSET);
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
> +	spin_lock_init(&fep->learn_lock);
> +	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->mii_lock);
> +
> +	ret = devm_request_irq(&pdev->dev, fep->irq, mtip_interrupt, 0,
> +			       "mtip_l2sw", fep);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, fep->irq,
> +				     "Could not alloc IRQ\n");
> +
> +	ret = mtip_register_notifiers(fep);
> +	if (ret)
> +		return ret;
> +
> +	ret = mtip_ndev_init(fep);
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
> +		goto task_learning_err;
> +	}
> +
> +	/* setup MII interface for external switch ports*/
> +	mtip_enet_init(fep, 1);
> +	mtip_enet_init(fep, 2);
> +
> +	return 0;
> +
> + task_learning_err:
> +	del_timer(&fep->timer_aging);
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
> +	del_timer(&fep->timer_aging);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	kfree(fep);
> +}
> +
> +static const struct of_device_id mtipl2_of_match[] = {
> +	{ .compatible = "nxp,imx287-mtip-switch", },
> +	{ /* sentinel */ }
> +};

Missing module device table.

> +
> +static struct platform_driver mtipl2plat_driver = {
> +	.driver         = {
> +		.name   = "mtipl2sw",
> +		.of_match_table = mtipl2_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe          = mtip_sw_probe,
> +	.remove_new     = mtip_sw_remove,
> +};
> +
> +module_platform_driver(mtipl2plat_driver);
> +MODULE_AUTHOR("Lukasz Majewski <lukma@denx.de>");
> +MODULE_DESCRIPTION("Driver for MTIP L2 on SOC switch");
> +MODULE_VERSION(VERSION);

What is the point of paralell versioning with the kernel? Are you going
to keep this updated or - just like in other cases - it will stay always
theh same. Look for example at net/bridge/br.c or some other files -
they are always the same even if driver changed significantly.

BTW, this would be 1.0, not 1.4. Your out of tree versioning does not
matter.

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mtipl2sw");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


Best regards,
Krzysztof

