Return-Path: <netdev+bounces-211619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6248B1A829
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB973B28A5
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE92192F4;
	Mon,  4 Aug 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TQ5hNFWs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F017736;
	Mon,  4 Aug 2025 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326151; cv=none; b=r2BjDLY3pIn5JKy3om4AJR9XbunmvBHtjWEpkq23HBIixSh9ggF9j2wfQk4MrWWRymtUiMkb92YH+Hw5pdWZEIoNPKb9FhRPYXxg0FA8bNYrx6yXWRy1T2nc4oSGdbu5bXchB5t7ZLtDHKmsiJ08zpOeSL92QmlsEtLQhCnZmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326151; c=relaxed/simple;
	bh=+mYVK5PD3Chpbfe99IJyA1KNNQYnDPyxM6vFQOsMCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3pAqhhR/kMmCbmjk1s3EHI4rVeYt4w3XheWWS3QZ0DocX8X+tbnGOiHdVzq7H2m2tHx+LVjhzVMuYgC3XzIER92EHHT3pZuAdtByZYH1g1mXaxngpjIx/Zrv/PQLzmcRlnD1593W4TDIvID9Lb2b7EfrX1Q0HrvhaB4EsLAE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TQ5hNFWs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y5jNatzr9iPOY+macrl5h9nkF1ONt/HKYGdcJTwX8Mw=; b=TQ5hNFWsQAIW1i2Bm5bN3/y9nF
	uPhfKJ8TLeiAZ+FGWplQvWoCRvjDfWuq3dH96ECeYolilN0VDNIzEaaPRxSgFXbafytvwTyY7JXp0
	J5qpapKFZ9R0zv8TkWZDUYUXv5Ch85Xye9a8xoiZ4+zvhRSZXOGW4oxmW1sDZDy0oKUg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uiyMw-003jFL-QO; Mon, 04 Aug 2025 18:49:02 +0200
Date: Mon, 4 Aug 2025 18:49:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Meghana Malladi <m-malladi@ti.com>,
	Himanshu Mittal <h-mittal1@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix emac link speed
 handling
Message-ID: <be848373-4b7f-4205-b1e4-b08fe161d689@lunn.ch>
References: <20250801121948.1492261-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801121948.1492261-1-danishanwar@ti.com>

On Fri, Aug 01, 2025 at 05:49:48PM +0530, MD Danish Anwar wrote:
> When link settings are changed emac->speed is populated by
> emac_adjust_link(). The link speed and other settings are then written into
> the DRAM. However if both ports are brought down after this and brought up
> again or if the operating mode is changed and a firmware reload is needed,
> the DRAM is cleared by icssg_config(). As a result the link settings are
> lost.
> 
> Fix this by calling emac_adjust_link() after icssg_config(). This re
> populates the settings in the DRAM after a new firmware load.
> 
> Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> v1 - v2: Added phydev lock before calling emac_adjust_link() as suggested
> by Andrew Lunn <andrew@lunn.ch>
> v1 https://lore.kernel.org/all/20250731120812.1606839-1-danishanwar@ti.com/
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 2b973d6e2341..58aec94b7771 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -50,6 +50,8 @@
>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>  
> +static void emac_adjust_link(struct net_device *ndev);
> +
>  static int emac_get_tx_ts(struct prueth_emac *emac,
>  			  struct emac_tx_ts_response *rsp)
>  {
> @@ -229,6 +231,12 @@ static int prueth_emac_common_start(struct prueth *prueth)
>  		ret = icssg_config(prueth, emac, slice);
>  		if (ret)
>  			goto disable_class;
> +
> +		if (emac->ndev->phydev) {
> +			mutex_lock(&emac->ndev->phydev->lock);
> +			emac_adjust_link(emac->ndev);
> +			mutex_unlock(&emac->ndev->phydev->lock);
> +		}

What about the else case? The link settings are lost, and the MAC does
not work?

	Andrew

