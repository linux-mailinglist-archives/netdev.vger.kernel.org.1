Return-Path: <netdev+bounces-237251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A077C47B5D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2DE84EDC25
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C127A123;
	Mon, 10 Nov 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F7VuTdwM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F79271441;
	Mon, 10 Nov 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789577; cv=none; b=S6Pib33pn9Rd+yqmdmLO2SE1Iuc1IrKTjTZf4Q4zfT3liFz/9FLhXfWO+jYAcT84WrkWzR3Tqj+9J6SeRPnnivoXYopoVEW5N/y+29TwNnjsULBC0OsBVOMiA5PMCQ7HYEnnvyTJGmm0q5T+HE/orsMpfywoGQtKNvMqMBqNads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789577; c=relaxed/simple;
	bh=WqowGuoHtsOthmGogNYRqvRTsXGmRWIYLDDP6DGoGgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyiHWAKxHf7c8H42qaH4M1VWoB7JzM8TI58tj01iP+/BNPvXzT+XDlROS7iY63P1ZWhHV608aTr38p8h/koh6PoP7hAftTXPbMM4egQIvfBwQcSNKC87f0Z7lhiVrayGM3jsK0GoP1Zc2g0koN3n/joLPXzLEtUl0Oci+KlmqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F7VuTdwM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8nZLD9diL5Nl54JqOLMmgecUuCsULo/6MkV2RzeMUYA=; b=F7VuTdwMDensrQoEHPLpu3zbJi
	62AkImrh5wvQK3G572aiWMaUpJbB2vNNXs6TxVhfz1pVQ8gU+8Cycs3KCY9PGuIeYiScScJj4Q77/
	H4/1yTstNex7J7LSb+gGbvhqamTNVcVqL4NDtUE9IovP4a5Cwwq9+hYQzPG9RDHvewmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vIU5e-00DXER-4n; Mon, 10 Nov 2025 16:45:58 +0100
Date: Mon, 10 Nov 2025 16:45:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <8c6e1286-782a-44c5-ac9b-21d1db177d6e@lunn.ch>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>

On Mon, Nov 10, 2025 at 07:09:28PM +0800, Jacky Chou wrote:
> On the AST2600 platform, the RGMII delay is controlled via the
> SCU registers. The delay chain configuration differs between MAC0/1
> and MAC2/3, even though all four MACs use a 32-stage delay chain.
> +------+----------+-----------+-------------+-------------+
> |      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> +------+----------+-----------+-------------+-------------+
> |MAC0/1|     45 ps|        32 |           0 |           0 |
> +------+----------+-----------+-------------+-------------+
> |MAC2/3|    250 ps|        32 |           0 |          26 |
> +------+----------+-----------+-------------+-------------+
> For MAC2/3, the "no delay" condition starts from stage 26.
> Setting the RX delay stage to 26 means that no additional RX
> delay is applied.
> Here lists the RX delay setting of MAC2/3 below.
> 26 -> 0   ns, 27 -> 0.25 ns, ... , 31 -> 1.25 ns,
> 0  -> 1.5 ns, 1  -> 1.75 ns, ... , 25 -> 7.75 ns
> 
> Therefore, we calculate the delay stage from the
> rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel
> to or bigger than 32, the delay stage will be mask 0x1f to get
> the correct setting.
> The delay chain is like a ring for configuration.
> Example for the rx-internal-delay-ps of MAC2/3 is 2000 ps,
> we will get the delay stage is 2.
> 
> Strating to this patch, driver will remind the legacy dts to update the
> "phy-mode" to "rgmii-id, and add the corresponding rgmii delay with
> "rx-internal-delay-id" and "tx-internal-delay-id".
> If lack these properties, driver will configure the default rgmii delay,
> that means driver will disable the TX and RX delay in MAC side.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 148 +++++++++++++++++++++++++++++++
>  drivers/net/ethernet/faraday/ftgmac100.h |  20 +++++
>  2 files changed, 168 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index a863f7841210..5cecdd4583f6 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +static int ftgmac100_set_ast2600_rgmii_delay(struct ftgmac100 *priv,
> +					     u32 rgmii_tx_delay,
> +					     u32 rgmii_rx_delay)
> +{
> +	struct device *dev = priv->dev;
> +	struct device_node *np;
> +	u32 rgmii_delay_unit;
> +	u32 rx_delay_index;
> +	u32 tx_delay_index;
> +	struct regmap *scu;
> +	int dly_mask;
> +	int dly_reg;
> +	int mac_id;
> +	int ret;
> +
> +	np = dev->of_node;
> +
> +	/* Add a warning to notify the existed dts based on AST2600. It is
> +	 * recommended to update the dts to add the rx/tx-internal-delay-ps to
> +	 * specify the RGMII delay and we recommend using the "rgmii-id" for
> +	 * phy-mode property to tell the PHY enables TX/RX internal delay and
> +	 * add the corresponding rx/tx-internal-delay-ps properties.
> +	 */
> +	if (priv->netdev->phydev->interface != PHY_INTERFACE_MODE_RGMII_ID)
> +		dev_warn(dev, "Update the phy-mode to 'rgmii-id'.\n");
> +
> +	scu = syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
> +	if (IS_ERR(scu)) {
> +		dev_err(dev, "failed to get aspeed,scu");
> +		return PTR_ERR(scu);
> +	}

You are adding the scu to the dtsi.

> +
> +	ret = of_property_read_u32(np, "aspeed,rgmii-delay-ps",
> +				   &rgmii_delay_unit);
> +	if (ret) {
> +		dev_err(dev, "failed to get aspeed,rgmii-delay-ps value\n");
> +		return -EINVAL;
> +	}

This is probably going away, replaced by hard coded values.

> +	tx_delay_index = DIV_ROUND_CLOSEST(rgmii_tx_delay, rgmii_delay_unit);
> +	if (tx_delay_index >= 32) {
> +		dev_err(dev, "The %u ps of TX delay is out of range\n",
> +			rgmii_tx_delay);
> +		return -EINVAL;
> +	}
> +
> +	rx_delay_index = DIV_ROUND_CLOSEST(rgmii_rx_delay, rgmii_delay_unit);
> +	if (rx_delay_index >= 32) {
> +		dev_err(dev, "The %u ps of RX delay is out of range\n",
> +			rgmii_rx_delay);
> +		return -EINVAL;
> +	}

> +	regmap_update_bits(scu, dly_reg, dly_mask, tx_delay_index | rx_delay_index);

How does backwards compatibility work? rgmii_rx_delay and
rgmii_tx_delay default to zero? So by default, todays working DT blobs
will have 'rgmii', so end up turning off delays here. And then they
pass _RGMII to the PHY, and have no delays. And networking is broken.

I think you actually need to be reading the current SCU settings and
then deciding if you want to override it or not.

I suggest you change the order of the patches in this series. Move
this patch before you update your RDK .dts file. That way, you get to
test both an old and new blob.

	Andrew

