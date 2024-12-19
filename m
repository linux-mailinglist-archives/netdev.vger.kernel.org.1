Return-Path: <netdev+bounces-153447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918B09F802E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2EE7A0519
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC0189BB5;
	Thu, 19 Dec 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bgYLD1fo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17B1850AF
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626713; cv=none; b=N51yrVAHRymR8BA9un2an1aIY5ayRX1xdepBKou8fu8pLyg6UoAq8isNl+pqrgIQT8eKBgHpG5ErZbwqvz6D1p+B/JsBsNwJj1EZYN2vYnZtg7VFqfGH/uDx7D9o8iJK4Mk55siibtWL0KWl2Hc61d/hQKkKXQ7+QANmD8VEkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626713; c=relaxed/simple;
	bh=THCW7IF6f69R/VXlV0vHbL6KOP0k5JLT6oL4pqfJcac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxshcFs2SQBdnJS9sxSBImI+Vy3EMwri7yRewjT1OwlnrZQl9tlUYe1vu+ML1+mNf5FRqsui1v+1BV+V6FSDJ5C1oS2o+sk6uZUY3v0MMMkC5UF0+nuxwi9PO1NIOIvglUSbjlD+3v4UuaRorjaCcj3Pqu+zIes/BVknR2njYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bgYLD1fo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v7iWr2gq5oL5XThj25/bivyLweMz6I23Nm4QC0UzpKg=; b=bgYLD1foc01wWkfrHgUsHc0lOF
	wcLhkjToN8+hjn8pksU11SycNJCgHuA5Re/eISyw3Kn+pPxLWFZ+RwQlpBWCzJXeUOOfIawtyLmnI
	F8ReYQVaaNmtGVpupK9Ke239VdqY02DS+y1i/jSidgsZ6mv9HSNfRRtQFGGeaZLc/nuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJe3-001gUd-DY; Thu, 19 Dec 2024 17:45:03 +0100
Date: Thu, 19 Dec 2024 17:45:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: tn40xx: create software node for
 mdio and phy and add to mdiobus
Message-ID: <bfdd9d04-8f74-422e-8b3e-6f3d2c4d0a3a@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:36PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Create a software node for the mdio function, with a child node for the
> Aquantia AQR105 PHY, providing a firmware-name (and a bit more, which may
> be used for future checks) to allow the PHY to load a MAC specific
> firmware from the file system.
> 
> The name of the PHY software node follows the naming convention suggested
> in the patch for the mdiobus_scan function (in the same patch series).
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/ethernet/tehuti/tn40.c      | 10 ++++-
>  drivers/net/ethernet/tehuti/tn40.h      | 30 +++++++++++++++
>  drivers/net/ethernet/tehuti/tn40_mdio.c | 65 ++++++++++++++++++++++++++++++++-
>  3 files changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index 259bdac24cf211113b8f80934feb093d61e46f2d..5f73eb1f7d9f74294cd5546c2ef4797ebc24c052 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -1778,7 +1778,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	ret = tn40_phy_register(priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to set up PHY.\n");
> -		goto err_free_irq;
> +		goto err_unregister_swnodes;
>  	}
>  
>  	ret = tn40_priv_init(priv);
> @@ -1795,6 +1795,10 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return 0;
>  err_unregister_phydev:
>  	tn40_phy_unregister(priv);
> +err_unregister_swnodes:
> +	fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
> +	device_remove_software_node(&priv->mdio->dev);
> +	software_node_unregister_node_group(priv->nodes.group);
>  err_free_irq:
>  	pci_free_irq_vectors(pdev);
>  err_unset_drvdata:

This looks pretty unsymmetrical. The swnodes are added in
tn40_mdiobus_init(). I would add an tn40_mdiobus_remove() and call
that as the undo function for tn40_mdiobus_init() during cleanup.

	Andrew

