Return-Path: <netdev+bounces-216844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF7B357B5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0723AAC14
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCF1B6D08;
	Tue, 26 Aug 2025 08:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D69460
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198511; cv=none; b=c8R/wZAGgJNC7FnI2FI1fHPNeOOrQ/BKyPEmMx7B3+rFlh9kGoU95RYkLypr3obO/8MrnXN1vt/SkfK0xZrTn6JbC1aAWmy4EIKx8Jt/cy6APG9ptvwZkTFDXo90GlJRn8q21T07aJ3p1E9eW2j8bYjTWg3yMoBsVgXZ90C/T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198511; c=relaxed/simple;
	bh=d+h2PRJM2l08TaXnGzcsmwZ3+8ua03+lAD5/yxQMu+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrYSWeA9ZuukNZx2Wf83xZFl+RheNQuxspI5lC+YdebpsX7q2MAcjBR2FnHJYDQYhiclLccrhOabQFnd69ErBLTdgxl6OFiOx5pogY/R277a5huo9+cixlXbD/Oa8EsSX+GZ4bdO+UWhW6rxKv7lj6ESWdZKZch8MeXCVu1S5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqpRq-0003j9-Qa; Tue, 26 Aug 2025 10:54:34 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqpRn-002Cb2-1w;
	Tue, 26 Aug 2025 10:54:31 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uqpRn-0005k0-1e;
	Tue, 26 Aug 2025 10:54:31 +0200
Message-ID: <eb127fd167cfbd885099a7c4c962eb1135a5a8a0.camel@pengutronix.de>
Subject: Re: [PATCH net-next v7 2/5] net: spacemit: Add K1 Ethernet MAC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,  Junhui Liu <junhui.liu@pigmoral.tech>, Simon
 Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2025 10:54:31 +0200
In-Reply-To: <20250826-net-k1-emac-v7-2-5bc158d086ae@iscas.ac.cn>
References: <20250826-net-k1-emac-v7-0-5bc158d086ae@iscas.ac.cn>
	 <20250826-net-k1-emac-v7-2-5bc158d086ae@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Di, 2025-08-26 at 14:23 +0800, Vivian Wang wrote:
> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
>=20
> Supports RGMII and RMII interfaces. Includes support for MAC hardware
> statistics counters. PTP support is not implemented.
>=20
> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/Kconfig            |    1 +
>  drivers/net/ethernet/Makefile           |    1 +
>  drivers/net/ethernet/spacemit/Kconfig   |   29 +
>  drivers/net/ethernet/spacemit/Makefile  |    6 +
>  drivers/net/ethernet/spacemit/k1_emac.c | 2193 +++++++++++++++++++++++++=
++++++
>  drivers/net/ethernet/spacemit/k1_emac.h |  426 ++++++
>  6 files changed, 2656 insertions(+)
>=20
[...]
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethern=
et/spacemit/k1_emac.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e558d5893cfbbda0baa7ad21=
a7209dadda9487e
> --- /dev/null
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -0,0 +1,2193 @@
[...]
> +static int emac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct reset_control *reset;
> +	struct net_device *ndev;
> +	struct emac_priv *priv;
> +	int ret;
> +
> +	ndev =3D devm_alloc_etherdev(dev, sizeof(struct emac_priv));
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	ndev->hw_features =3D NETIF_F_SG;
> +	ndev->features |=3D ndev->hw_features;
> +
> +	ndev->max_mtu =3D EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
> +
> +	priv =3D netdev_priv(ndev);
> +	priv->ndev =3D ndev;
> +	priv->pdev =3D pdev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret =3D emac_config_dt(pdev, priv);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Configuration failed\n");
> +		goto err;

I'd just
		return dev_err_probe(...);
here.

> +	}
> +
> +	ndev->watchdog_timeo =3D 5 * HZ;
> +	ndev->base_addr =3D (unsigned long)priv->iobase;
> +	ndev->irq =3D priv->irq;
> +
> +	ndev->ethtool_ops =3D &emac_ethtool_ops;
> +	ndev->netdev_ops =3D &emac_netdev_ops;
> +
> +	devm_pm_runtime_enable(&pdev->dev);
> +
> +	priv->bus_clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(priv->bus_clk)) {
> +		ret =3D dev_err_probe(dev, PTR_ERR(priv->bus_clk),
> +				    "Failed to get clock\n");
> +		goto err;

Same here.

> +	}
> +
> +	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->d=
ev,
> +								     NULL);
> +	if (IS_ERR(reset)) {
> +		ret =3D dev_err_probe(dev, PTR_ERR(reset),
> +				    "Failed to get reset\n");
> +		goto err;

And here.

> +	}
> +
> +	emac_sw_init(priv);
> +
> +	if (of_phy_is_fixed_link(dev->of_node)) {
> +		ret =3D of_phy_register_fixed_link(dev->of_node);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to register fixed-link");
> +			goto err_timer_delete;

If you can move this section before emac_sw_init(), this could also
just return.

> +		}

Then here a function calling of_phy_deregister_fixed_link() could be
registered with devm_add_action_or_reset(), to avoid duplicated cleanup
in the error path and in emac_remove().


regards
Philipp

