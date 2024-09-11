Return-Path: <netdev+bounces-127494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9B975928
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B4F1C22F6E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C51AC8B2;
	Wed, 11 Sep 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qs45Z9y0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5C5FB8D;
	Wed, 11 Sep 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075048; cv=none; b=JMIGTibQYfKo7azPQuSC4Sr9jlbwVh820B308bZpt1dVEwlC8d93nYCEaLSSJo8mKYHj9llx4lqS44NdgdOlqryLPl/8dritzL39EFz+BaErRkeuEDLk2AGlIQzuCDxUW2ez09/w8Y1fAtuQlHvU2VUROg/GmTDrpQUw4m7hhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075048; c=relaxed/simple;
	bh=5UYjBU3+9f00Np4eAEbrOzDEg12YW2NhV/ZLEb9TKVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD09OiKZtH8TvxEEsnf+2fdottLYLw50s5mkf2r+odq9pz58oEjI+yxc0DUDoeTomSFIxQaW2K2+5TCIwyYqy52rXdvmcEbbqvdJtDehN0zGBJLgxIhHvI1m9QpkcVC6ABnxuzsKpyU4CMA8x2pTGIlqdeD/V/kmJTUpQiPn6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qs45Z9y0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AoOBj7v9nDNKWYQoDY048eHpYi95ao0hxBfOBrjvCak=; b=qs45Z9y04KuW6iWKLiBjF3McLC
	Z/wG2hq9fjVH5JvdGznc4BGIn3p9Xrc6VfWHVDh6khYfdENippiKCDA3pDac2m1LMhenISso4vi8U
	rlU83UehjON5gTygZJdVz2T0UXxZcAiPN06/YYriWkSwEDkDaI4UZ2lT2Q/o7eN8sb3E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soQxu-007Eix-Ik; Wed, 11 Sep 2024 19:17:14 +0200
Date: Wed, 11 Sep 2024 19:17:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 2/5] net: lan743x: Add support to
 software-nodes for sfp
Message-ID: <cb39041e-9b72-4b76-bfd7-03f825b20f23@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>

> diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
> index 2e3eb37a45cd..9c08a4af257a 100644
> --- a/drivers/net/ethernet/microchip/Kconfig
> +++ b/drivers/net/ethernet/microchip/Kconfig
> @@ -50,6 +50,8 @@ config LAN743X
>  	select CRC16
>  	select CRC32
>  	select PHYLINK
> +	select I2C_PCI1XXXX
> +	select GP_PCI1XXXX

GP_ is odd. GPIO drivers usually use GPIO_. Saying that, GPIO_PCI1XXXX
is not in 6.11-rc7. Is it in gpio-next?

> +static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
> +					u16 perif_id)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct pci_bus *perif_bus;
> +	struct pci_dev *perif_dev;
> +	struct pci_dev *br_dev;
> +	struct pci_bus *br_bus;
> +	struct pci_dev *dev;
> +
> +	/* PCI11x1x devices' PCIe topology consists of a top level pcie
> +	 * switch with up to four downstream ports, some of which have
> +	 * integrated endpoints connected to them. One of the downstream ports
> +	 * has an embedded single function pcie ethernet controller which is
> +	 * handled by this driver. Another downstream port has an
> +	 * embedded multifunction pcie endpoint, with four pcie functions
> +	 * (the "peripheral controllers": I2C controller, GPIO controller,
> +	 * UART controllers, SPIcontrollers)
> +	 * The code below navigates the PCI11x1x topology
> +	 * to find (by matching its PCI device ID) the peripheral controller
> +	 * that should be paired to the embedded ethernet controller.
> +	 */
> +	br_dev = pci_upstream_bridge(pdev);
> +	if (!br_dev) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "upstream bridge not found\n");
> +		return br_dev;
> +	}
> +
> +	br_bus = br_dev->bus;
> +	list_for_each_entry(dev, &br_bus->devices, bus_list) {
> +		if (dev->vendor == PCI1XXXX_VENDOR_ID &&
> +		    (dev->device & ~PCI1XXXX_DEV_MASK) ==
> +		     PCI1XXXX_BR_PERIF_ID) {
> +			perif_bus = dev->subordinate;
> +			list_for_each_entry(perif_dev, &perif_bus->devices,
> +					    bus_list) {
> +				if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
> +				    (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
> +				     perif_id)
> +					return pci_get_drvdata(perif_dev);
> +			}
> +		}
> +	}

It would be good to have the PCI Maintainers review of this. Maybe
pull this out into a patch of its own and Cc: Bjorn Helgaas
<bhelgaas@google.com>

	Andrew

