Return-Path: <netdev+bounces-231570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA3BFAA5D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF1D950530B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB82FB99B;
	Wed, 22 Oct 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MDVGp1r6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF532FB61F
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118939; cv=none; b=h2NqbolNr1xWOlgigu9t3YPjLQrjwt5PKZe1WbyftZko+HoWK9UkbRMY7eAPyy51MRjDiZ8pdNiqQ269SXbWHyBgpWyWDv9CVk5VS/ep5tNjfKQxaBkWdyfvFM9ZrB4Sm/D97iVbhZcRP8AmZAjDx7jgQOGqSrgSiq2s8UDHo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118939; c=relaxed/simple;
	bh=7MssKyPd9ezRO88qcA55lCsCLCvegrajNytoYUMKDkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TIoukBiPol73dWDOTbslkUuXX2/GyD9KxkoanckPWwFHHKJmXLsUkNwVk4o1hGsHwKZwIOUmTmdTfh0TI8JFo+/bbmbtjQBBZHHsQu8OkEUIJQEOO7rS8Hv0KKowVtXV6tauk93dciNQXiH4A0fiAWwKF4aHSFirsN534zAyxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MDVGp1r6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 401211A15D3;
	Wed, 22 Oct 2025 07:42:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 058D0606DC;
	Wed, 22 Oct 2025 07:42:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87690102F241B;
	Wed, 22 Oct 2025 09:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118935; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=02XK0aWcsbyJv7uQCLUfPYNpW5LcuCGsqkHjPzwoRqc=;
	b=MDVGp1r63WmOq64jmekkj2mNKIHbs8gK1TGb34e0gPscoq9dNeHqWxN5JDVukN66yBPu2i
	eGSvf8Qtm3kmKeeUHL4nm2pbJCglwa6JYLmoGL1ofZh/6fcdt5zuCoqzvgQURNM7Bb/8b/
	QOqz2a3N7Ij0zLkxQRUIN+RVMn2dDBD3NUDtrpV4wRdpR6hN/git6lvfza+VrJr4sdq/57
	i1LWPlnHC2K0/kaPUR6MauG2ylML2CFrnC02YfK6uO9qZA33Ucsm46Pfi3AmDMIa5H1xqQ
	blzuMkZylIM6hhWAKueQv0cDGxw7XuOj36EFpGAMYJCZcNql1QqO1c66Vxx/MQ==
Message-ID: <2a9e1ecc-2f33-432b-bf77-e08ce7ccd0ce@bootlin.com>
Date: Wed, 22 Oct 2025 09:42:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 2/2] net: airoha: add phylink support for GDM1
To: Christian Marangi <ansuelsmth@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
 <20251021193315.2192359-3-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251021193315.2192359-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 21/10/2025 21:33, Christian Marangi wrote:
> In preparation for support of GDM2+ port, fill in phylink OPs for GDM1
> that is an INTERNAL port for the Embedded Switch.
> 
> Rework the GDM init logic by first preparing the struct with all the
> required info and creating the phylink interface and only after the
> parsing register the related netdev.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 108 ++++++++++++++++++++---
>  drivers/net/ethernet/airoha/airoha_eth.h |   3 +
>  2 files changed, 99 insertions(+), 12 deletions(-)

You also need to select PHYLINK in Kconfig

> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index ce6d13b10e27..fc237775a998 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1613,6 +1613,8 @@ static int airoha_dev_open(struct net_device *dev)
>  	struct airoha_gdm_port *port = netdev_priv(dev);
>  	struct airoha_qdma *qdma = port->qdma;
>  
> +	phylink_start(port->phylink);
> +
>  	netif_tx_start_all_queues(dev);
>  	err = airoha_set_vip_for_gdm_port(port, true);
>  	if (err)
> @@ -1665,6 +1667,8 @@ static int airoha_dev_stop(struct net_device *dev)
>  		}
>  	}
>  
> +	phylink_stop(port->phylink);
> +
>  	return 0;
>  }
>  
> @@ -2813,6 +2817,17 @@ static const struct ethtool_ops airoha_ethtool_ops = {
>  	.get_link		= ethtool_op_get_link,
>  };
>  
> +static struct phylink_pcs *airoha_phylink_mac_select_pcs(struct phylink_config *config,
> +							 phy_interface_t interface)
> +{
> +	return NULL;
> +}
> +
> +static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
> +			      const struct phylink_link_state *state)
> +{
> +}
> +
>  static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
>  {
>  	int i;
> @@ -2857,6 +2872,55 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
>  	return false;
>  }
>  
> +static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
> +			       unsigned int mode, phy_interface_t interface,
> +			       int speed, int duplex, bool tx_pause, bool rx_pause)
> +{
> +}
> +
> +static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
> +				 phy_interface_t interface)
> +{
> +}
> +
> +static const struct phylink_mac_ops airoha_phylink_ops = {
> +	.mac_select_pcs = airoha_phylink_mac_select_pcs,
> +	.mac_config = airoha_mac_config,
> +	.mac_link_up = airoha_mac_link_up,
> +	.mac_link_down = airoha_mac_link_down,
> +};
> +
> +static int airoha_setup_phylink(struct net_device *netdev)
> +{
> +	struct airoha_gdm_port *port = netdev_priv(netdev);
> +	struct device *dev = &netdev->dev;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
> +
> +	phy_mode = device_get_phy_mode(dev);
> +	if (phy_mode < 0) {
> +		dev_err(dev, "incorrect phy-mode\n");
> +		return phy_mode;
> +	}
> +
> +	port->phylink_config.dev = dev;
> +	port->phylink_config.type = PHYLINK_NETDEV;
> +	port->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +						MAC_10000FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  port->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&port->phylink_config, dev_fwnode(dev),
> +				 phy_mode, &airoha_phylink_ops);
> +	if (IS_ERR(phylink))
> +		return PTR_ERR(phylink);
> +
> +	port->phylink = phylink;
> +
> +	return 0;
> +}
> +
>  static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  				 struct device_node *np, int index)
>  {
> @@ -2931,19 +2995,30 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>  	port->id = id;
>  	eth->ports[p] = port;
>  
> -	err = airoha_metadata_dst_alloc(port);
> -	if (err)
> -		return err;
> +	return airoha_metadata_dst_alloc(port);
> +}
>  
> -	err = register_netdev(dev);
> -	if (err)
> -		goto free_metadata_dst;
> +static int airoha_register_gdm_ports(struct airoha_eth *eth)
> +{
> +	int i;
>  
> -	return 0;
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port = eth->ports[i];
> +		int err;
>  
> -free_metadata_dst:
> -	airoha_metadata_dst_free(port);
> -	return err;
> +		if (!port)
> +			continue;
> +
> +		err = airoha_setup_phylink(port->dev);
> +		if (err)
> +			return err;
> +
> +		err = register_netdev(port->dev);
> +		if (err)
> +			return err;

The cleanup for that path seems to only be done if

  port->dev->reg_state == NETREG_REGISTERED

So if netdev registration fails here, you'll never destroy
the phylink instance :(

Maxime



