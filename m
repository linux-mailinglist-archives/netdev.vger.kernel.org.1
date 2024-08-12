Return-Path: <netdev+bounces-117838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FF94F825
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AE1F22481
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C6193069;
	Mon, 12 Aug 2024 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rva8snpV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6B186E30;
	Mon, 12 Aug 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494151; cv=none; b=Qo6AKAx5TWuXj6gQS66cV5m5RAKs8p6oxUPfZM9gb7EswSwFKaSEh24d+RM3xjrrauN6jks/qUvFYLk4xy+HYOb8Ed+rA4idBIfVusxfjAU3LlZO7LTdM5zbUzPGOCnx94l81mKX6eALcS2bwA9d4E0yA8ZiMbgyWNHbIzuhrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494151; c=relaxed/simple;
	bh=otiKvNXT1TZyEdmB0RL7gA55pIcWsw+RG+ac53fD7HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDvQhc0wdHqyAbPYTXfTLupCN/AinPlwUVPKgJ6Ga6C/iBo8zm7ATUtGeOND6u1A7YVmUfgo4bpchYYXpfKA+GDx3+lpMxnzAx57Wke1gGr6N9s0JdxgOvfDSLEI0nEQyaq4RzVgJk7Malzo8iIZ3dvOZ++yayRTM7/y6N1FpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rva8snpV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O8IRnInZINo2pPnJLcokAejXz1Yw9TmlkcZMR1b30CQ=; b=rva8snpVqAC7jLEmtyGHq4uq0f
	IROPI9rNsyjsFp8tVkymzucocvOhB4IhY6n9ZOa5966yNt+ybbrdhytvaNzEkDZ9g2or7wu/xNUE8
	X0tFUjaR6hb/hgmiDZYJTnLdcyxJ3x9MoTLH2icl07nHJbq4pip900JawcxN7GbQr0Ao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdbYa-004cCs-B5; Mon, 12 Aug 2024 22:22:20 +0200
Date: Mon, 12 Aug 2024 22:22:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 2/2] net: xilinx: axienet: Add statistics
 support
Message-ID: <e78256f2-9ad6-49e1-9cd5-02a28c92d2fc@lunn.ch>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
 <20240812174118.3560730-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812174118.3560730-3-sean.anderson@linux.dev>

>  static int __axienet_device_reset(struct axienet_local *lp)
>  {
>  	u32 value;
>  	int ret;
>  
> +	/* Save statistics counters in case they will be reset */
> +	guard(mutex)(&lp->stats_lock);
> +	if (lp->features & XAE_FEATURE_STATS)
> +		axienet_stats_update(lp, true);

My understanding of guard() is that the mutex is held until the
function completes. That is much longer than you need. A
scoped_guard() would be better here, and it makes it clear when the
mutex will be released.

> +
>  	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
>  	 * process of Axi DMA takes a while to complete as all pending
>  	 * commands/transfers will be flushed or completed during this
> @@ -551,6 +595,23 @@ static int __axienet_device_reset(struct axienet_local *lp)
>  		return ret;
>  	}
>  
> +	/* Update statistics counters with new values */
> +	if (lp->features & XAE_FEATURE_STATS) {
> +		enum temac_stat stat;
> +
> +		write_seqcount_begin(&lp->hw_stats_seqcount);
> +		lp->reset_in_progress = false;
> +		for (stat = 0; stat < STAT_COUNT; stat++) {
> +			u32 counter =
> +				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
> +
> +			lp->hw_stat_base[stat] +=
> +				lp->hw_last_counter[stat] - counter;
> +			lp->hw_last_counter[stat] = counter;
> +		}
> +		write_seqcount_end(&lp->hw_stats_seqcount);
> +	}
> +
>  	return 0;
>  }
>  

	Andrew

