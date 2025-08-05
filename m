Return-Path: <netdev+bounces-211793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE1B1BBC8
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C1B3AB941
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E590B2253E0;
	Tue,  5 Aug 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UmmtEqGo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6581C8633;
	Tue,  5 Aug 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429542; cv=none; b=mbvTCzzqOzqtH8cmFa2aN7+duFu1GmC6oj+wY76hoKk3Wc9thCYnQ1CRMJwU8OTaAQ/kLJSnrVfWUaINGikMnus3clWyMsiAvlK4YPW4pwptJNXdGK5ZvM691j1GYQHeoZubaIRj3Lh/xiax6u8tAVpi8bDWHr0AR2GeNf9F2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429542; c=relaxed/simple;
	bh=FKMtt4C7SiHLDtPX/p8cSSP5Ihvqa+3tSZWKlaBZpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCeIWPW0xHyr7m+bPKKugNfAXZJfguogyuUO6Xx3k60LjnFvFTjy1WrnYWzaDAhzAH8lx+/8ykJLykfkbcm4fankMUsAXsXHad8pIeVCQFAq8Lqzc+5wVb3n0zI53kAWTTHx0ETOZAsyXZWD39T2fhLDL4EBmV0QhDffGb0EHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UmmtEqGo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ehg7mtVEZG5GkLeNFV5NybHMZ76+3RE7nNoKJBi39vM=; b=UmmtEqGoQCHJCUJD2FPuSpUcxJ
	kEDJzF3QrGcSGTcRZP4Tm21LpfrkrbMshAqMWfQWUDCS3NDRs9oYEDR7cw+uHekZQ/MiQHVsF8B4i
	01H8w1v0bMNseWAHoGcrzkEP7+9yNXGgHyAuJsL8MefLvCR0a0gVr/v8RGNVSOjI77v8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ujPGX-003pQr-Ib; Tue, 05 Aug 2025 23:32:13 +0200
Date: Tue, 5 Aug 2025 23:32:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v4 6/7] net: axienet: Rearrange lifetime
 functions
Message-ID: <69b08e90-ae99-43fd-9779-dd5497a26e1f@lunn.ch>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805153456.1313661-7-sean.anderson@linux.dev>

On Tue, Aug 05, 2025 at 11:34:55AM -0400, Sean Anderson wrote:
> Rearrange the lifetime functions (probe, remove, etc.) in preparation
> for the next commit. No functional change intended.

There is a lot going on in this patch. Can it be broken up a bit more?

The phase "No functional change intended" generally means, its the
same code, just in a different place in the files. This is not true of
this patch.

> +struct axienet_common {
> +	struct platform_device *pdev;
> +
> +	struct clk *axi_clk;
> +
> +	struct mutex reset_lock;

>  static inline void axienet_lock_mii(struct axienet_local *lp)
>  {
> -	if (lp->mii_bus)
> -		mutex_lock(&lp->mii_bus->mdio_lock);
> +	mutex_lock(&lp->cp->reset_lock);

This lock is different to the bus lock. This is definitely not a "no
functional change".

Please make this lock change a patch of its own, with a good commit
message which considers the consequences of this change of lock.

>  		if (!np) {
> -			dev_err(dev, "pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
> -			ret = -EINVAL;
> -			goto cleanup_mdio;
> +			dev_err(dev,
> +				"pcs-handle (preferred) or phy-handle required for 1000BaseX/SGMII\n");
> +			return -EINVAL;

That looks like a whitespace change. This is a "No functional change
intended" sort of patch. You can collect all such whitespace changes
into one patch.

>  		}
>  		lp->pcs_phy = of_mdio_find_device(np);
> -		np1 = of_find_node_by_name(NULL, "lpu");
> +		np1 = of_find_node_by_name(NULL, "cpu");

Interesting. Maybe you should review your own patches.


    Andrew

---
pw-bot: cr

