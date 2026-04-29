Return-Path: <netdev+bounces-282162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL7xOJdZ8Wn/gAEAu9opvQ
	(envelope-from <netdev+bounces-282162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:06:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F048DDA2
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC82A3020D60
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282721ADB7;
	Wed, 29 Apr 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTIePY1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3F18A6A8;
	Wed, 29 Apr 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777424787; cv=none; b=YaE+/nHuh83P7qjdnbwnyT8RAwP+6Od+UnUFDvDLVyqK4CNuXpwh983sp7s0xM+k0crHDuoFtgtY2DHyQZZZ8ilJc9oXU0hhEbnfevlP8GSdy/CVlz9wreqpGgRfvBctH+59OYl9GkBpoQpjplp3NY5KK72xlFgbss6E/ohEFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777424787; c=relaxed/simple;
	bh=Xxrd0KVB9QYgYHmSehbX4FGUyhOGOqhtmad+b+hyHQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAB6kMLjyaJ2RpCx5p3ppLjNlbHlMhNn1GI8f8iI3MtvviZcuCci++TgFKj4wfJc+EobSH2tXIuUuTKEwNLE/yAqHqfYg43bu+U1drbankNNPw2TGFtpATwQVqpXEk9Tfk/TK3gK3OtGD1ojLYdwvZlh8MuA8+wMeeapiAwH6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTIePY1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506A3C2BCB7;
	Wed, 29 Apr 2026 01:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777424787;
	bh=Xxrd0KVB9QYgYHmSehbX4FGUyhOGOqhtmad+b+hyHQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTIePY1KYIGjuALHWVK25ANCyWGrczUVdCjVhrVEidGTyuzd5zP0i7r4HYSZbHXlc
	 2c6rOe63916uRvcVFZBFZSmATqVqQCe43XZcQMOw9sSjmaDOmiUKhZyEpuIzIjGjUG
	 fegeXMMBvM1E1hZeOq+uoJHMwHz3T7iz0UnYtV1hbWhKeotUbi9kPjC+8qlvHwnvjs
	 dlOd2urUos2JNtHCC9F3+hrLAhbYjhnHDwggrE9fqhYesdAbeRsYiIlxc75W2vGcuj
	 vKneQ+AWmIzzZoX4ZqwCvqppdrXIL+rjB9RPJgezSfWxEEFuq5/sqWa9cFvQ0MTx1R
	 drjDD77m0+PTg==
Date: Tue, 28 Apr 2026 18:06:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v7 2/4] net: stmmac: eic7700: enable clocks
 before syscon access and correct RX sampling timing
Message-ID: <20260428180625.738223cf@kernel.org>
In-Reply-To: <20260427072508.1151-1-lizhi2@eswincomputing.com>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
	<20260427072508.1151-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 470F048DDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,bootlin.com,eswincomputing.com,einfochips.com];
	TAGGED_FROM(0.00)[bounces-282162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 15:25:05 +0800 lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
>=20
> The second Ethernet controller (eth1) on the Eswin EIC7700 SoC may fail
> to sample RX data correctly at Gigabit speed due to EIC7700-specific
> receive clock to data skew at the MAC input in the silicon.
>=20
> The existing internal delay configuration does not provide sufficient
> adjustment range to compensate for this condition at 1000Mbps.
> Update the EIC7700 DWMAC glue driver to apply EIC7700-specific clock
> sampling inversion only during Gigabit operation on MAC instances
> that require it.
>=20
> TXD and RXD delay registers are explicitly cleared during initialization
> to override any residual configuration left by the bootloader. All HSP
> CSR register accesses are performed only after the required clocks are
> enabled.
>=20
> Fixes: ea77dbbdbc4e ("net: stmmac: add Eswin EIC7700 glue driver")

Why Fixes? If eth1 never worked this is not a fix but new functionality
If you want to make this a fix to prevent incompatibility - cut it down
just to the eth0 changes.

> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 183 ++++++++++++++----
>  1 file changed, 140 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/driver=
s/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> index bcb8e000e720..33144611da8d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> @@ -28,20 +28,40 @@
> =20
>  /*
>   * TX/RX Clock Delay Bit Masks:
> - * - TX Delay: bits [14:8] =E2=80=94 TX_CLK delay (unit: 0.1ns per bit)
> - * - RX Delay: bits [30:24] =E2=80=94 RX_CLK delay (unit: 0.1ns per bit)
> + * - TX Delay: bits [14:8] =E2=80=94 TX_CLK delay (unit: 0.02ns per bit)
> + * - TX Invert : bit  [15]
> + * - RX Delay: bits [30:24] =E2=80=94 RX_CLK delay (unit: 0.02ns per bit)
> + * - RX Invert : bit  [31]
>   */
>  #define EIC7700_ETH_TX_ADJ_DELAY	GENMASK(14, 8)
>  #define EIC7700_ETH_RX_ADJ_DELAY	GENMASK(30, 24)
> +#define EIC7700_ETH_TX_INV_DELAY	BIT(15)
> +#define EIC7700_ETH_RX_INV_DELAY	BIT(31)
> =20
> -#define EIC7700_MAX_DELAY_UNIT 0x7F
> +#define EIC7700_MAX_DELAY_STEPS		0x7F
> +#define EIC7700_DELAY_STEP_PS		20
> +#define EIC7700_MAX_DELAY_PS	\
> +	(EIC7700_MAX_DELAY_STEPS * EIC7700_DELAY_STEP_PS)

AI says:

  The step unit is being silently changed from 0.1 ns (delay_ps / 100)
  to 0.02 ns (delay_ps / 20).  The same DT value now programs 5x the number
  of delay steps into the hardware.

>  static const char * const eic7700_clk_names[] =3D {
>  	"tx", "axi", "cfg",
>  };
> =20
> +struct eic7700_dwmac_data {
> +	bool rgmii_rx_clk_invert;
> +};
> +
>  struct eic7700_qos_priv {
> +	struct device *dev;
>  	struct plat_stmmacenet_data *plat_dat;
> +	struct regmap *eic7700_hsp_regmap;
> +	u32 eth_axi_lp_ctrl_offset;
> +	u32 eth_phy_ctrl_offset;
> +	u32 eth_txd_offset;
> +	u32 eth_clk_offset;
> +	u32 eth_rxd_offset;
> +	u32 eth_clk_dly_param;
> +	bool eth_rx_clk_inv;
>  };
> =20
>  static int eic7700_clks_config(void *priv, bool enabled)
> @@ -61,8 +81,28 @@ static int eic7700_clks_config(void *priv, bool enable=
d)
>  static int eic7700_dwmac_init(struct device *dev, void *priv)
>  {
>  	struct eic7700_qos_priv *dwc =3D priv;
> +	int ret;
> +
> +	ret =3D eic7700_clks_config(dwc, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_set_bits(dwc->eic7700_hsp_regmap,
> +			      dwc->eth_phy_ctrl_offset,
> +			      EIC7700_ETH_TX_CLK_SEL |
> +			      EIC7700_ETH_PHY_INTF_SELI);
> +	if (ret) {
> +		eic7700_clks_config(dwc, false);
> +		return ret;
> +	}
> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
> +		     EIC7700_ETH_CSYSREQ_VAL);
> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
> =20
> -	return eic7700_clks_config(dwc, true);
> +	return 0;
>  }
> =20
>  static void eic7700_dwmac_exit(struct device *dev, void *priv)
> @@ -88,18 +128,35 @@ static int eic7700_dwmac_resume(struct device *dev, =
void *priv)
>  	return ret;
>  }
> =20
> +static void eic7700_dwmac_fix_speed(void *priv, phy_interface_t interfac=
e,
> +				    int speed, unsigned int mode)
> +{
> +	struct eic7700_qos_priv *dwc =3D (struct eic7700_qos_priv *)priv;
> +	u32 dly_param =3D dwc->eth_clk_dly_param;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		if (dwc->eth_rx_clk_inv)
> +			dly_param |=3D EIC7700_ETH_RX_INV_DELAY;
> +		break;
> +	case SPEED_100:
> +	case SPEED_10:
> +		break;
> +	default:
> +		dev_err(dwc->dev, "invalid speed %u\n", speed);
> +		break;
> +	}
> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset, dly_param);

AI says

  In the default case this logs "invalid speed %u" but then falls
  through and still executes the regmap_write() with the base dly_param.  An
  unsupported speed reports an error and reprograms the hardware anyway.

  Should the default path return without writing, or should the write be
  moved into the valid cases only?

> +}
> +
>  static int eic7700_dwmac_probe(struct platform_device *pdev)
>  {
> +	const struct eic7700_dwmac_data *data;
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct eic7700_qos_priv *dwc_priv;
> -	struct regmap *eic7700_hsp_regmap;
> -	u32 eth_axi_lp_ctrl_offset;
> -	u32 eth_phy_ctrl_offset;
> -	u32 eth_phy_ctrl_regset;
> -	u32 eth_rxd_dly_offset;
> -	u32 eth_dly_param =3D 0;
> -	u32 delay_ps;
> +	u32 delay_ps, val;
>  	int i, ret;
> =20
>  	ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> @@ -116,70 +173,95 @@ static int eic7700_dwmac_probe(struct platform_devi=
ce *pdev)
>  	if (!dwc_priv)
>  		return -ENOMEM;
> =20
> +	dwc_priv->dev =3D &pdev->dev;
> +
> +	data =3D device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return dev_err_probe(&pdev->dev,
> +				     -EINVAL, "no match data found\n");
> +
> +	dwc_priv->eth_rx_clk_inv =3D data->rgmii_rx_clk_invert;
> +
>  	/* Read rx-internal-delay-ps and update rx_clk delay */
>  	if (!of_property_read_u32(pdev->dev.of_node,
>  				  "rx-internal-delay-ps", &delay_ps)) {
> -		u32 val =3D min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +		if (delay_ps % EIC7700_DELAY_STEP_PS)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +				"rx delay must be multiple of %dps\n",
> +				EIC7700_DELAY_STEP_PS);
> +
> +		if (delay_ps > EIC7700_MAX_DELAY_PS)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +				"rx delay out of range\n");
> =20
> -		eth_dly_param &=3D ~EIC7700_ETH_RX_ADJ_DELAY;
> -		eth_dly_param |=3D FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> -	} else {
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -			"missing required property rx-internal-delay-ps\n");
> +		val =3D delay_ps / EIC7700_DELAY_STEP_PS;
> +
> +		dwc_priv->eth_clk_dly_param &=3D ~EIC7700_ETH_RX_ADJ_DELAY;
> +		dwc_priv->eth_clk_dly_param |=3D
> +				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
>  	}
> =20
>  	/* Read tx-internal-delay-ps and update tx_clk delay */
>  	if (!of_property_read_u32(pdev->dev.of_node,
>  				  "tx-internal-delay-ps", &delay_ps)) {
> -		u32 val =3D min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +		if (delay_ps % EIC7700_DELAY_STEP_PS)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +				"tx delay must be multiple of %dps\n",
> +				EIC7700_DELAY_STEP_PS);
> +
> +		if (delay_ps > EIC7700_MAX_DELAY_PS)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +				"tx delay out of range\n");
> +
> +		val =3D delay_ps / EIC7700_DELAY_STEP_PS;
> =20
> -		eth_dly_param &=3D ~EIC7700_ETH_TX_ADJ_DELAY;
> -		eth_dly_param |=3D FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
> -	} else {
> -		return dev_err_probe(&pdev->dev, -EINVAL,
> -			"missing required property tx-internal-delay-ps\n");
> +		dwc_priv->eth_clk_dly_param &=3D ~EIC7700_ETH_TX_ADJ_DELAY;
> +		dwc_priv->eth_clk_dly_param |=3D
> +				 FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
>  	}

AI says:

  First, rx-internal-delay-ps and tx-internal-delay-ps are silently
  demoted from required to optional.  The previous driver returned
  -EINVAL with "missing required property ..." when either was absent;
  the else branches have been removed, so missing properties now leave
  eth_clk_dly_param at zero and fix_mac_speed() programs zero delay
  without diagnostic.  Is this intentional, and if so should the commit
  message and the DT binding reflect it?
=20
  Second, the previous code silently clamped out-of-range values via
  min() and only required non-zero step units by integer truncation.
  The new code rejects non-multiples of 20 and values greater than 2540
  ps with -EINVAL at probe time.  DTBs that previously probed with
  clamped delays will now fail probe.  Should this stricter validation
  also be called out in the commit message?


> -	eic7700_hsp_regmap =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_nod=
e,
> -							     "eswin,hsp-sp-csr");
> -	if (IS_ERR(eic7700_hsp_regmap))
> +	dwc_priv->eic7700_hsp_regmap =3D
> +			syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +							"eswin,hsp-sp-csr");
> +	if (IS_ERR(dwc_priv->eic7700_hsp_regmap))
>  		return dev_err_probe(&pdev->dev,
> -				PTR_ERR(eic7700_hsp_regmap),
> +				PTR_ERR(dwc_priv->eic7700_hsp_regmap),
>  				"Failed to get hsp-sp-csr regmap\n");
> =20
>  	ret =3D of_property_read_u32_index(pdev->dev.of_node,
>  					 "eswin,hsp-sp-csr",
> -					 1, &eth_phy_ctrl_offset);
> +					 1, &dwc_priv->eth_phy_ctrl_offset);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "can't get eth_phy_ctrl_offset\n");
> =20
> -	regmap_read(eic7700_hsp_regmap, eth_phy_ctrl_offset,
> -		    &eth_phy_ctrl_regset);
> -	eth_phy_ctrl_regset |=3D
> -		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
> -	regmap_write(eic7700_hsp_regmap, eth_phy_ctrl_offset,
> -		     eth_phy_ctrl_regset);
> -
>  	ret =3D of_property_read_u32_index(pdev->dev.of_node,
>  					 "eswin,hsp-sp-csr",
> -					 2, &eth_axi_lp_ctrl_offset);
> +					 2, &dwc_priv->eth_axi_lp_ctrl_offset);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "can't get eth_axi_lp_ctrl_offset\n");
> =20
> -	regmap_write(eic7700_hsp_regmap, eth_axi_lp_ctrl_offset,
> -		     EIC7700_ETH_CSYSREQ_VAL);
> +	ret =3D of_property_read_u32_index(pdev->dev.of_node,
> +					 "eswin,hsp-sp-csr",
> +					 3, &dwc_priv->eth_clk_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "can't get eth_clk_offset\n");
> =20
>  	ret =3D of_property_read_u32_index(pdev->dev.of_node,
>  					 "eswin,hsp-sp-csr",
> -					 3, &eth_rxd_dly_offset);
> +					 4, &dwc_priv->eth_txd_offset);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret,
> -				     "can't get eth_rxd_dly_offset\n");
> +				     "can't get eth_txd_offset\n");
> =20
> -	regmap_write(eic7700_hsp_regmap, eth_rxd_dly_offset,
> -		     eth_dly_param);
> +	ret =3D of_property_read_u32_index(pdev->dev.of_node,
> +					 "eswin,hsp-sp-csr",
> +					 5, &dwc_priv->eth_rxd_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "can't get eth_rxd_offset\n");

AI says:

  The eswin,hsp-sp-csr phandle-args layout is expanded from 4 cells
  (phandle + 3 offsets) to 6 cells (phandle + 5 offsets), with new
  indices 3/4/5 now required.  Any DTB produced against the original
  ea77dbbdbc4e binding will fail probe here with -EINVAL.
--=20
pw-bot: cr

