Return-Path: <netdev+bounces-142979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53C9C0D54
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1496283FC0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A85215F58;
	Thu,  7 Nov 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OyqtHaea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE156192B88;
	Thu,  7 Nov 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002049; cv=none; b=Ud5/4LXPrWo3n/DRkIZjZaQxJ2SvGeBaVdAk6AlYkkR2qi14Ko47yb8KOcxXw7uhNzraRcJ+QvcHqt7VVvWLDiBiwxXpLYYCek+A+AiDrMzPH3SekKozB6YlHuX3PKTBDDENf8KU4Rpg2UTcrtatQ2/rMKA9Y5vkJLmbx4EzTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002049; c=relaxed/simple;
	bh=2DW6I+arM88AHVmAeJ6wkQ4KimZp+DEoFp51O2QDEJE=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=CG3j11mhcYnVp1HmbPgVkUlxU1hwZ//6GtCaBW12r1jbC/TiuZgnmg7cJhWMP03q+89/r0dQQefZgkmBhmpiZK4DPKka2C2euoXGWGwI4+ZAuPIfSPLLtp6fDDY5wj2t4aILO+Yt6866z1X6LaSjyy9LXNIjfV1hB3tRfnO4oeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OyqtHaea; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 96hdtNA5ljpcy96hdtxdSs; Thu, 07 Nov 2024 18:53:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731002038;
	bh=cdgcV6wo3982K6zQ+QcgyGnlNupSEkHhyOdc+H7ya3w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=OyqtHaea2fjLJu0H/uOFpRuDkMdy4/RBnhtlN+dvZY0oouNgU++MeW7A2UyeKd73T
	 KQTySv04bVQEoVMjE6VGH61YVW1zlLSdYfeq9wJFE82Jtjc23iNzrGWCTvQXcu8/o7
	 7YdowhKH0jxZWzj2I/jTomCm7+WUU0m7vzqE/HcYa5fx/2B1p7Yeoy4bIaJMnvqpjc
	 uo9EyePb9gFbaz8KAvpk+gR7h/GjNdO3bnWxvHPpiZwglSOBd9h6FbYhCy65CwZhdu
	 fJsrdoZP4sZgscMOz96BUjhPDgl9KL59akPQ3eGO5MYoRyDklOm1LkTNz+AJoNqGj/
	 lPorkANdFP9NQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 07 Nov 2024 18:53:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <4318897e-0f1a-42c7-8f20-065dc690a112@wanadoo.fr>
Date: Thu, 7 Nov 2024 18:53:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [net-next PATCH v3 2/3] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-3-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno," <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
In-Reply-To: <20241106122254.13228-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/11/2024 à 13:22, Christian Marangi a écrit :
> Add Airoha AN8855 5-Port Gigabit DSA switch.
> 
> The switch is also a nvmem-provider as it does have EFUSE to calibrate
> the internal PHYs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Hi,

...

> +#include <linux/bitfield.h>
> +#include <linux/ethtool.h>
> +#include <linux/etherdevice.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/if_bridge.h>
> +#include <linux/iopoll.h>
> +#include <linux/mdio.h>
> +#include <linux/netdevice.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/nvmem-provider.h>

Could be moved a few lines above to keep order.

> +#include <linux/phylink.h>
> +#include <linux/regmap.h>
> +#include <net/dsa.h>
...

> +static int an8855_port_fdb_dump(struct dsa_switch *ds, int port,
> +				dsa_fdb_dump_cb_t *cb, void *data)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	struct an8855_fdb _fdb = {  };

Should it but reseted in the do loop below, instead of only once here?

> +	int banks, count = 0;
> +	u32 rsp;
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&priv->reg_mutex);
> +
> +	/* Load search port */
> +	ret = regmap_write(priv->regmap, AN8855_ATWD2,
> +			   FIELD_PREP(AN8855_ATWD2_PORT, port));
> +	if (ret)
> +		goto exit;
> +	ret = an8855_fdb_cmd(priv, AN8855_ATC_MAT(AND8855_FDB_MAT_MAC_PORT) |
> +			     AN8855_FDB_START, &rsp);
> +	if (ret < 0)
> +		goto exit;
> +
> +	do {
> +		/* From response get the number of banks to read, exit if 0 */
> +		banks = FIELD_GET(AN8855_ATC_HIT, rsp);
> +		if (!banks)
> +			break;
> +
> +		/* Each banks have 4 entry */
> +		for (i = 0; i < 4; i++) {
> +			count++;
> +
> +			/* Check if bank is present */
> +			if (!(banks & BIT(i)))
> +				continue;
> +
> +			/* Select bank entry index */
> +			ret = regmap_write(priv->regmap, AN8855_ATRDS,
> +					   FIELD_PREP(AN8855_ATRD_SEL, i));
> +			if (ret)
> +				break;
> +			/* wait 1ms for the bank entry to be filled */
> +			usleep_range(1000, 1500);
> +			an8855_fdb_read(priv, &_fdb);
> +
> +			if (!_fdb.live)
> +				continue;
> +			ret = cb(_fdb.mac, _fdb.vid, _fdb.noarp, data);
> +			if (ret < 0)
> +				break;
> +		}
> +
> +		/* Stop if reached max FDB number */
> +		if (count >= AN8855_NUM_FDB_RECORDS)
> +			break;
> +
> +		/* Read next bank */
> +		ret = an8855_fdb_cmd(priv, AN8855_ATC_MAT(AND8855_FDB_MAT_MAC_PORT) |
> +				     AN8855_FDB_NEXT, &rsp);
> +		if (ret < 0)
> +			break;
> +	} while (true);
> +
> +exit:
> +	mutex_unlock(&priv->reg_mutex);
> +	return ret;
> +}

...

> +	ret = regmap_set_bits(priv->regmap, AN8855_RG_RATE_ADAPT_CTRL_0,
> +			      AN8855_RG_RATE_ADAPT_RX_BYPASS |
> +			      AN8855_RG_RATE_ADAPT_TX_BYPASS |
> +			      AN8855_RG_RATE_ADAPT_RX_EN |
> +			      AN8855_RG_RATE_ADAPT_TX_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable AN if not in autoneg */
> +	ret = regmap_update_bits(priv->regmap, AN8855_SGMII_REG_AN0, BMCR_ANENABLE,
> +				 neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED ? BMCR_ANENABLE :
> +									      0);

Should 'ret' be tested here?

> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_DISABLED) {
> +		ret = regmap_set_bits(priv->regmap, AN8855_PHY_RX_FORCE_CTRL_0,
> +				      AN8855_RG_FORCE_TXC_SEL);
> +		if (ret)
> +			return ret;
> +	}

...

> +	priv->ds = devm_kzalloc(&mdiodev->dev, sizeof(*priv->ds), GFP_KERNEL);
> +	if (!priv->ds)
> +		return -ENOMEM;
> +
> +	priv->ds->dev = &mdiodev->dev;
> +	priv->ds->num_ports = AN8855_NUM_PORTS;
> +	priv->ds->priv = priv;
> +	priv->ds->ops = &an8855_switch_ops;
> +	mutex_init(&priv->reg_mutex);

devm_mutex_init() to slightly simplify the remove function?

> +	priv->ds->phylink_mac_ops = &an8855_phylink_mac_ops;
> +
> +	priv->pcs.ops = &an8855_pcs_ops;
> +	priv->pcs.neg_mode = true;
> +	priv->pcs.poll = true;
> +
> +	ret = an8855_sw_register_nvmem(priv);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(&mdiodev->dev, priv);
> +
> +	return dsa_register_switch(priv->ds);
> +}
> +
> +static void
> +an8855_sw_remove(struct mdio_device *mdiodev)
> +{
> +	struct an8855_priv *priv = dev_get_drvdata(&mdiodev->dev);
> +
> +	dsa_unregister_switch(priv->ds);
> +	mutex_destroy(&priv->reg_mutex);
> +}
> +
> +static const struct of_device_id an8855_of_match[] = {
> +	{ .compatible = "airoha,an8855" },
> +	{ /* sentinel */ },

Ending comma is usually not needed after a terminator.

> +};
> +
> +static struct mdio_driver an8855_mdio_driver = {
> +	.probe = an8855_sw_probe,
> +	.remove = an8855_sw_remove,
> +	.mdiodrv.driver = {
> +		.name = "an8855",
> +		.of_match_table = an8855_of_match,
> +	},
> +};

...

> +#define	  AN8855_VA0_VTAG_EN		BIT(10) /* Per VLAN Egress Tag Control */
> +#define	  AN8855_VA0_IVL_MAC		BIT(5) /* Independent VLAN Learning */
> +#define	  AN8855_VA0_VLAN_VALID		BIT(0) /* VLAN Entry Valid */
> +#define AN8855_VAWD1			0x10200608
> +#define	  AN8855_VA1_PORT_STAG		BIT(1)
> +
> +/* Same register map of VAWD0 */

Not sure to follow. AN8855_VAWD0 above is 0x10200604, not 0x10200618

> +#define AN8855_VARD0			0x10200618
> +
> +enum an8855_vlan_egress_attr {
> +	AN8855_VLAN_EGRESS_UNTAG = 0,
> +	AN8855_VLAN_EGRESS_TAG = 2,
> +	AN8855_VLAN_EGRESS_STACK = 3,
> +};
> +
> +/* Register for port STP state control */
> +#define AN8855_SSP_P(x)			(0x10208000 + ((x) * 0x200))
> +#define	 AN8855_FID_PST			GENMASK(1, 0)
> +
> +enum an8855_stp_state {
> +	AN8855_STP_DISABLED = 0,
> +	AN8855_STP_BLOCKING = 1,
> +	AN8855_STP_LISTENING = 1,

Just wondering if this 0, 1, *1*, 2, 3 was intentional?

> +	AN8855_STP_LEARNING = 2,
> +	AN8855_STP_FORWARDING = 3
> +};
> +
> +/* Register for port control */
> +#define AN8855_PCR_P(x)			(0x10208004 + ((x) * 0x200))
> +#define	  AN8855_EG_TAG			GENMASK(29, 28)
> +#define	  AN8855_PORT_PRI		GENMASK(26, 24)
> +#define	  AN8855_PORT_TX_MIR		BIT(20)
> +#define	  AN8855_PORT_RX_MIR		BIT(16)
> +#define	  AN8855_PORT_VLAN		GENMASK(1, 0)
> +
> +enum an8855_port_mode {
> +	/* Port Matrix Mode: Frames are forwarded by the PCR_MATRIX members. */
> +	AN8855_PORT_MATRIX_MODE = 0,
> +
> +	/* Fallback Mode: Forward received frames with ingress ports that do
> +	 * not belong to the VLAN member. Frames whose VID is not listed on
> +	 * the VLAN table are forwarded by the PCR_MATRIX members.
> +	 */
> +	AN8855_PORT_FALLBACK_MODE = 1,
> +
> +	/* Check Mode: Forward received frames whose ingress do not
> +	 * belong to the VLAN member. Discard frames if VID ismiddes on the
> +	 * VLAN table.
> +	 */
> +	AN8855_PORT_CHECK_MODE = 1,

Just wondering if this 0, 1, *1*, 3 was intentional?

> +
> +	/* Security Mode: Discard any frame due to ingress membership
> +	 * violation or VID missed on the VLAN table.
> +	 */
> +	AN8855_PORT_SECURITY_MODE = 3,
> +};
...

CJ

