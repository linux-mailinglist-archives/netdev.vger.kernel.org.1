Return-Path: <netdev+bounces-263850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIjcE6VLqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:11:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF62024F8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C363302E754
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D68D3C3C1D;
	Wed,  4 Mar 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BexXbVtF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3523C3C07;
	Wed,  4 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636402; cv=none; b=Rm47Ht9nLsd3fmLfaeCPqZhfTP3b1ipztKHqOmwsOVO0PLEQhVpQ67ULrh+LqmZYkUn+QdBW3nOE5sfIYwV9ZWryqAIfCqIsGdXPy0Lz9d1FLweRQkCIV6ej4BDqd5YDYGZApFxmadIze/zVpkKG7WynnC016Y39Gi/E4ISsXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636402; c=relaxed/simple;
	bh=wL+j94lcC2pnf64dqcTGe4lJKYr0KLZgqJWZVNjFYA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR1B2GvTvG4j+4oQZfpROQ14BgeaejOUNDTqVQ49vtOA7DFPBdJdcvlLqXIuXfzmioAGyN5YwigP4p70yS0gFTTMuLVZEkoriPCXjqthvTOdIoLD0aRKnyJ/bC770uxxDmjVA/r861t/M3GMC5Kr1zUrHKYpAzlu4s/9K7qnvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BexXbVtF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vqPIfe+mfsqFhoVG72QNFvYOtrojMOGGbstCn1l5Va0=; b=BexXbVtFTtWrabAERt3I7VaQUE
	1MDE/MWnlrPGimoVaeUcdFk3FB5zaA8BjNLAPHpAYn7v9Q4G0Kwcr5Jl3Q1XLsVswkXw0CyTTLaL/
	g/dxJutxfPtrr083s9hbQTqwycBJ/VpA4S0S99OWCob94R/W08s1BOKSyzpRiCrzXEWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxnhP-00A7ZE-C5; Wed, 04 Mar 2026 15:59:43 +0100
Date: Wed, 4 Mar 2026 15:59:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: Introduce Airoha AN8801/R Gigabit
 Ethernet PHY driver
Message-ID: <3fbfabf7-b3af-405b-ade4-4f62db2c1c45@lunn.ch>
References: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
 <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-add-airoha-an8801-support-v1-2-0ae4ee5a2f9d@collabora.com>
X-Rspamd-Queue-Id: E4AF62024F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263850-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

> +static int an8801r_did_interrupt(struct phy_device *phydev)
> +{
> +	u32 irq_en, irq_status;
> +	int ret;
> +
> +	ret = air_buckpbus_reg_read(phydev, AN8801_BPBUS_REG_WAKE_IRQ_EN,
> +				    &irq_en);
> +	if (ret)
> +		return ret;
> +
> +	ret = air_buckpbus_reg_read(phydev, AN8801_BPBUS_REG_WAKE_IRQ_STS,
> +				    &irq_status);
> +	if (ret)
> +		return ret;
> +
> +	if (irq_status & AN8801_IRQ_WAKE_MAGICPKT)
> +		return 0;

With a name like an8801r_did_interrupt() you would expect the return
value to be some value of True, if there was an interrupt. I would
suggest either a different name, or return 1. Maybe also add a
kerneldoc header indicating the return values, since it is probably
not going to be standard.

> +static void an8801r_get_wol(struct phy_device *phydev,
> +			    struct ethtool_wolinfo *wol)
> +{
> +	u32 reg_val;
> +
> +	air_buckpbus_reg_read(phydev, AN8801_BPBUS_REG_WAKEUP_CTL1, &reg_val);
> +
> +	wol->supported = WAKE_MAGIC;

How does WoL work on this device. Only via interrupts? If so, maybe
you should only return WAKE_MAGIC as supported if there is a valid
interrupt?

> +static int an8801r_rgmii_delay_config(struct phy_device *phydev)
> +{
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return an8801r_rgmii_txdelay(phydev, 4);
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		return an8801r_rgmii_rxdelay(phydev, 0);
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		return an8801r_rgmii_txdelay(phydev, 4);
> +		return an8801r_rgmii_rxdelay(phydev, 0);

The parameters look very odd here. 4 means 2ns, but 0 also means 0ns?
Can this API be improved?

Also, PHY_INTERFACE_MODE_RGMII_TXID means 2ns delay for TX, but it
also means 0ns delay for RX. The code appears to be missing this
second part.


> +	case PHY_INTERFACE_MODE_RGMII:

And here you should be disabling all delays. We have seen boards where
the strapping is wrong, the PHY boots in RGMII_ID, but RGMII is
required, and so the driver must fully implement
PHY_INTERFACE_MODE_RGMII disabling the delays.

> +static int an8801r_config_init(struct phy_device *phydev)
> +{
> +	u8 led_default_function[AN8801R_NUM_LEDS] = { 0 };
> +	int prev_page, ret;
> +
> +	ret = an8801r_of_init_leds(phydev, led_default_function);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable Low Power Mode (LPM) */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AN8801_REG_PHY_INTERNAL0,
> +			    FIELD_PREP(AN8801_PHY_INTFUNC_MASK, 0x1e));
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AN8801_REG_PHY_INTERNAL1,
> +			    FIELD_PREP(AN8801_PHY_INTFUNC_MASK, 0x2));
> +	if (ret)
> +		return ret;
> +
> +	/* Disable EEE by default */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> +	if (ret)
> +		return ret;

Why? If EEE is broken, this is not sufficient to stop a user
re-enabling it.

> +static int an8801r_read_status(struct phy_device *phydev)
> +{
> +	int prev_speed, ret;
> +	u32 val;
> +
> +	prev_speed = phydev->speed;
> +
> +	ret = genphy_read_status(phydev);
> +	if (ret)
> +		return ret;

You configure the PHY to support downshift. If it has performed a
downshift, does it report the actual speed in the usual registers read
by genphy_read_status(), or is it necessary to read a vendor register?

> +static struct phy_driver airoha_driver[] = {
> +{
> +	PHY_ID_MATCH_MODEL(AN8801R_PHY_ID),
> +	.name			= "Airoha AN8801R",
> +	.features		= PHY_GBIT_FEATURES,

Should not be needed, if the PHY enumerates its capabilities
correctly.

    Andrew

---
pw-bot: cr

