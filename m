Return-Path: <netdev+bounces-175215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB4A6464F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F21887109
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EF221558;
	Mon, 17 Mar 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YCLf6vjH"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849C21ABD8;
	Mon, 17 Mar 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201640; cv=none; b=dqd52uIS+qhtan7nMMlMepSUlSZiLj5KHC+UeGLiv0wcA3XXkM4/LtuMD8GskAaT4AearGVU8KXR2qYcvQ/hic6q21Qb+/sfLAHawUQfqtPxIoz3OPpTulA99g7Yya3/vtfSgilA4Uqf8KlSi0a9ZzYYxEbbtzUGR+xaMQELEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201640; c=relaxed/simple;
	bh=mvlHIMW270R7dZycsLruZdJ42iDtj8IQ29EjCbYvgvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH8PSENtiFuCHyQcN1NYgfMNgftwnCGlgpkxd7GhV1VkZlQk8nyfDPWdlYHXEyTMrWBjUGIAF6r9wPxbJ9lEBcoG8ZAMh/90xVCEWEwzITUFQJifESTewgfq8pWOQuj1YoF2itLQwuvWY3dntIER5AYClvI/8XnGlcYfgy2LNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YCLf6vjH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1BDB4322A;
	Mon, 17 Mar 2025 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742201628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfRlKgxGL6xoBQwjzEteEvARnfiax3+DCGaa/aKYtl4=;
	b=YCLf6vjHy3sJd0CsYWO7OZuY4buzPPO5wZbJqQSWcK7t3GABHlfmRQJoZSWTOQ1Zo4nDFe
	NYa2spNHSoIbU9TSvlftuLGzRft0Je0neMbDbkCoecYvgT5g6mH1wVxwlbapeL7YmAXb4w
	MPNFZvAlD2FeYq76sJzV7+BFCkfKb1yqKttrnJSjuG4qrM9sahsSXdS8RrkqN62uL7q48x
	TxDbk5IbPoyVSdcqcmsgvDb/k+67UwIemiT+/XoKd9yB7GGn/8MClLzMnsyRqTuRGZOkOn
	+950TlKYZFaKSVhb0if6ZyGFfvW6CJmN999djpQRpdUWooKL2llQ04EhzHQ0fw==
Date: Mon, 17 Mar 2025 09:53:33 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
 <andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <BMC-SW@aspeedtech.com>
Subject: Re: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Message-ID: <20250317095229.6f8754dd@fedora.home>
In-Reply-To: <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
	<20250317025922.1526937-5-jacky_chou@aspeedtech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeltdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeihfelueevvdekueeghfefiefgheeigeduveeifedvueeuleevudfhledulefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepjhgrtghkhigptghhohhusegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhp
 dhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 17 Mar 2025 10:59:22 +0800
Jacky Chou <jacky_chou@aspeedtech.com> wrote:

> Use rx-internal-delay-ps and tx-internal-delay-ps
> properties to configue the RGMII delay into corresponding register of
> scu. Currently, the ftgmac100 driver only configures on AST2600 and will
> be by pass the other platforms.
> The details are in faraday,ftgmac100.yaml.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 88 ++++++++++++++++++++++++
>  drivers/net/ethernet/faraday/ftgmac100.h | 12 ++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 17ec35e75a65..ea2061488cba 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -27,6 +27,9 @@
>  #include <linux/phy_fixed.h>
>  #include <net/ip.h>
>  #include <net/ncsi.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
>  
>  #include "ftgmac100.h"
>  
> @@ -1812,6 +1815,88 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
>  	return ret;
>  }
>  
> +static void ftgmac100_set_internal_delay(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct net_device *netdev;
> +	struct ftgmac100 *priv;
> +	struct regmap *scu;
> +	u32 rgmii_tx_delay, rgmii_rx_delay;
> +	u32 dly_reg, tx_dly_mask, rx_dly_mask;
> +	int tx, rx;

Please use the reverse christmas tree notation, sorting declarations by
descending line length

> +	netdev = platform_get_drvdata(pdev);
> +	priv = netdev_priv(netdev);
> +
> +	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
> +	rx = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);
> +
> +	if (of_device_is_compatible(np, "aspeed,ast2600-mac")) {
> +		/* According to mac base address to get mac index */
> +		switch (priv->res->start) {
> +		case 0x1e660000:
> +			dly_reg = AST2600_MAC12_CLK_DLY;
> +			tx_dly_mask = AST2600_MAC1_TX_DLY;
> +			rx_dly_mask = AST2600_MAC1_RX_DLY;
> +			rgmii_tx_delay = FIELD_PREP(AST2600_MAC1_TX_DLY, rgmii_tx_delay);
> +			rgmii_rx_delay = FIELD_PREP(AST2600_MAC1_RX_DLY, rgmii_rx_delay);
> +			break;
> +		case 0x1e680000:
> +			dly_reg = AST2600_MAC12_CLK_DLY;
> +			tx_dly_mask = AST2600_MAC2_TX_DLY;
> +			rx_dly_mask = AST2600_MAC2_RX_DLY;
> +			rgmii_tx_delay = FIELD_PREP(AST2600_MAC2_TX_DLY, rgmii_tx_delay);
> +			rgmii_rx_delay = FIELD_PREP(AST2600_MAC2_RX_DLY, rgmii_rx_delay);
> +			break;
> +		case 0x1e670000:
> +			dly_reg = AST2600_MAC34_CLK_DLY;
> +			tx_dly_mask = AST2600_MAC3_TX_DLY;
> +			rx_dly_mask = AST2600_MAC3_RX_DLY;
> +			rgmii_tx_delay = FIELD_PREP(AST2600_MAC3_TX_DLY, rgmii_tx_delay);
> +			rgmii_rx_delay = FIELD_PREP(AST2600_MAC3_RX_DLY, rgmii_rx_delay);
> +			break;
> +		case 0x1e690000:
> +			dly_reg = AST2600_MAC34_CLK_DLY;
> +			tx_dly_mask = AST2600_MAC4_TX_DLY;
> +			rx_dly_mask = AST2600_MAC4_RX_DLY;
> +			rgmii_tx_delay = FIELD_PREP(AST2600_MAC4_TX_DLY, rgmii_tx_delay);
> +			rgmii_rx_delay = FIELD_PREP(AST2600_MAC4_RX_DLY, rgmii_rx_delay);
> +			break;
> +		default:
> +			dev_warn(&pdev->dev, "Invalid mac base address");
> +			return;

There has to be a better way that directly looking up the base address.
Maybe you need an extra DT property ?

> +		}
> +	} else {
> +		return;
> +	}
> +
> +	scu = syscon_regmap_lookup_by_phandle(np, "scu");
> +	if (IS_ERR(scu)) {
> +		dev_warn(&pdev->dev, "failed to map scu base");
> +		return;
> +	}
> +
> +	if (!tx) {
> +		/* Use tx-internal-delay-ps as index to configure tx delay
> +		 * into scu register.
> +		 */

So this goes completely against the naming of the property. It has the
-ps suffix, so you would expect to have picoseconds values passed, and
not an arbiraty index.

Take a look at other drivers, you should accept picseconds values from
these properties, then compute the relevant index in the driver. That
index should be something internal to your driver.

An example here :

https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_rgmii.c#L51

> +		if (rgmii_tx_delay > 64)
> +			dev_warn(&pdev->dev, "Get invalid tx delay value");
> +		else
> +			regmap_update_bits(scu, dly_reg, tx_dly_mask, rgmii_tx_delay);
> +	}
> +
> +	if (!rx) {
> +		/* Use rx-internal-delay-ps as index to configure rx delay
> +		 * into scu register.
> +		 */
> +		if (rgmii_tx_delay > 64)
> +			dev_warn(&pdev->dev, "Get invalid rx delay value");
> +		else
> +			regmap_update_bits(scu, dly_reg, rx_dly_mask, rgmii_rx_delay);
> +	}
> +}
> +
>  static int ftgmac100_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -1977,6 +2062,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
>  			iowrite32(FTGMAC100_TM_DEFAULT,
>  				  priv->base + FTGMAC100_OFFSET_TM);
> +
> +		/* Configure RGMII delay if there are the corresponding properties */
> +		ftgmac100_set_internal_delay(pdev);
>  	}
>  
>  	/* Default ring sizes */
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 4968f6f0bdbc..d464d287502c 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h
> @@ -271,4 +271,16 @@ struct ftgmac100_rxdes {
>  #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
>  #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
>  
> +/* Aspeed SCU */
> +#define AST2600_MAC12_CLK_DLY	0x340
> +#define AST2600_MAC1_TX_DLY		GENMASK(5, 0)
> +#define AST2600_MAC1_RX_DLY		GENMASK(17, 12)
> +#define AST2600_MAC2_TX_DLY		GENMASK(11, 6)
> +#define AST2600_MAC2_RX_DLY		GENMASK(23, 18)
> +#define AST2600_MAC34_CLK_DLY	0x350
> +#define AST2600_MAC3_TX_DLY		AST2600_MAC1_TX_DLY
> +#define AST2600_MAC3_RX_DLY		AST2600_MAC1_RX_DLY
> +#define AST2600_MAC4_TX_DLY		AST2600_MAC2_TX_DLY
> +#define AST2600_MAC4_RX_DLY		AST2600_MAC2_RX_DLY
> +
>  #endif /* __FTGMAC100_H */

Maxime

