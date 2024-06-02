Return-Path: <netdev+bounces-100015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BAD8D7753
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8310B21103
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26558AC3;
	Sun,  2 Jun 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4fhxDzn4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055A2A1B0;
	Sun,  2 Jun 2024 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349938; cv=none; b=h5Qm0ZSKkYEq2odNhRS3yMeLESfgvzJM6WyItgKRU0/NKkQnLPJeAOTku92NhWZy/dsOxXixVZYZijtl6R6wKQmc+hoY33RxBGw/MnB9Y6GBUQ5hlJlDmOzklHCPo5Be8vCSCxs3fWVB5PoT2EYaxAwqRAL5kGyfJx+jzpUVep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349938; c=relaxed/simple;
	bh=devnn4zZxfu8O3nTe5d1IHpUWLRQlSeQv/XWAaiYWDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+7ttb8yIpptAAyFWLCcOCLKI1yVFsqs8q0cXtySlJ9QRuDlOnZgeA1cRHwQfzSA9itk/otv8/XyLuX/JYNgFHJ0EXXBA13KScAImCV/+KVTheu/uq3/nomcGa5Pl6hjoNna8IRGw5cdIxgP9w02c0YIPm92u28ZcOkpj2dRIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4fhxDzn4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G0FCah8nSh2Cs+IMckKKZyKAW464iVYw8O+hNfruJyI=; b=4fhxDzn4T8JUIN8S4GGm+PRimU
	nMSHcaA+zFIZOn0aT3xyA482BjAoU4843fz9r8hmTrI4/rfO/KVh/vmzlNedTrXgc7a1xvnOHT36l
	lAA46XLFN3OSLN3c6DRocp6yh/qY06QT3iBMdSoOqmyVQg9TVHKiUwyphSrxyFaNMUs0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDpAN-00GeGF-96; Sun, 02 Jun 2024 19:38:47 +0200
Date: Sun, 2 Jun 2024 19:38:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <c3207c89-2d4e-4e92-8822-f6a1f7d64e06@lunn.ch>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>

> +static int airoha_set_gdma_port(struct airoha_eth *eth, int port, bool enable)
> +{
> +	u32 vip_port, cfg_addr, val = enable ? FE_DP_PPE : FE_DP_DROP;
> +
> +	switch (port) {
> +	case 0:
> +		vip_port = BIT(22);
> +		cfg_addr = REG_GDM3_FWD_CFG;
> +		break;
> +	case 1:
> +		vip_port = BIT(23);
> +		cfg_addr = REG_GDM3_FWD_CFG;
> +		break;
> +	case 2:
> +		vip_port = BIT(25);
> +		cfg_addr = REG_GDM4_FWD_CFG;
> +		break;
> +	case 4:
> +		vip_port = BIT(24);
> +		cfg_addr = REG_GDM4_FWD_CFG;
> +		break;

Please add some #defines for the BIT(), so there is descriptive
names. Please do the same other places you have BIT macros, it makes
the code easier to understand.

> +static int airoha_set_gdma_ports(struct airoha_eth *eth, bool enable)
> +{
> +	const int port_list[] = { 0, 1, 2, 4 };
> +	int i;

Maybe add a comment about port 3?

> +static void airoha_fe_vip_setup(struct airoha_eth *eth)
> +{
> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(3), 0x8863); /* ETH->PPP (0x8863) */

Rather than a comment, use ETH_P_PPP_DISC

> +	airoha_fe_wr(eth, REG_FE_VIP_EN(3), PATN_FCPU_EN_MASK | PATN_EN_MASK);
> +
> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(4), 0xc021); /* PPP->LCP (0xc021) */

PPP_LCP

> +	airoha_fe_wr(eth, REG_FE_VIP_EN(4),
> +		     PATN_FCPU_EN_MASK | FIELD_PREP(PATN_TYPE_MASK, 1) |
> +		     PATN_EN_MASK);
> +
> +	airoha_fe_wr(eth, REG_FE_VIP_PATN(6), 0x8021); /* PPP->IPCP (0x8021) */

PPP_IPCP

etc...

> +static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
> +{
> +	struct airoha_eth *eth = q->eth;
> +	struct device *dev = eth->net_dev->dev.parent;
> +	int qid = q - &eth->q_rx[0], nframes = 0;

Reverse Christmass tree. Which means you will need to move some of the
assignments into the body of the function.

> +static int airoha_dev_open(struct net_device *dev)
> +{
> +	struct airoha_eth *eth = netdev_priv(dev);
> +	int err;
> +
> +	if (netdev_uses_dsa(dev))
> +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> +	else
> +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);

Does this imply the hardware can be used in a situation where it is
not connected to a switch? Does it have an MII and MDIO bus? Could a
PHY be connected? If it can be used as a conventional NIC, we need to
ensure there is a path to use usage without an ABI breakage.

> +static int airoha_register_debugfs(struct airoha_eth *eth)
> +{
> +	eth->debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +	if (IS_ERR(eth->debugfs_dir))
> +		return PTR_ERR(eth->debugfs_dir);

No error checking should be performed with debugfs calls. Just keep
going and it will work out O.K.

> +	err = of_get_ethdev_address(np, dev);
> +	if (err) {
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +
> +		eth_hw_addr_random(dev);
> +		dev_err(&pdev->dev, "generated random MAC address %pM\n",
> +			dev->dev_addr);

dev_info() would be better here, since it is not considered an error.

> +	err = airoha_hw_init(eth);
> +	if (err)
> +		return err;
> +
> +	airoha_qdma_start_napi(eth);
> +	err = register_netdev(dev);
> +	if (err)
> +		return err;
> +
> +	err = airoha_register_debugfs(eth);
> +	if (err)
> +		return err;
> +
> +	platform_set_drvdata(pdev, eth);

Is this required? As soon as you call register_netdev(), the device is
live and in use. It can be sending the first packets before the
function returns. So if anything needs this connection between the
platform data and the eth, it will not be in place, and bad things
will happen.

> +static inline void airoha_qdma_start_napi(struct airoha_eth *eth)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> +		napi_enable(&eth->q_tx_irq[i].napi);
> +
> +	airoha_qdma_for_each_q_rx(eth, i)
> +		napi_enable(&eth->q_rx[i].napi);
> +}
> +
> +static inline void airoha_qdma_stop_napi(struct airoha_eth *eth)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> +		napi_disable(&eth->q_tx_irq[i].napi);
> +
> +	airoha_qdma_for_each_q_rx(eth, i)
> +		napi_disable(&eth->q_rx[i].napi);
> +}

These seem off to be in a header file?

    Andrew

---
pw-bot: cr

