Return-Path: <netdev+bounces-102406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB8902DA6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163191C2185F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C58B816;
	Tue, 11 Jun 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n4Hashe/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173CEDF;
	Tue, 11 Jun 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065619; cv=none; b=HWK+oiysAcQTlg4HLCef7UW488lmsJb59gYXxCIprAycBrzGK+TB3mk8OjZP8EKCqxTT9KdkLxu3yoUTfJ7cJLVJNsqB9c7z4ZoutEENU58ubcULp8sI397pd3spQ80UBMaz9hcXxIsfpRkbNKl3MZfMWxEcMcBDoXD/M63xSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065619; c=relaxed/simple;
	bh=Rh8XKVV9RvMjAjX+zuKx4/MNQDLuuKmms5rwQuWaenU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3rkEuJkbhKAVbbaV8fJj6tQZnu50DZUlhmbm3HJQbHJxIr0U/RYA0kGlyW5dJrKcQMlQeT89A0Clck1g+ZajyjsPGNFJxaUM5l6sZLgujiRE/1z/SXjlLuPwQqi4/e1YY+8tQOMcqLEYyLbwINsk4jjZhxcgJp94jqm0iismKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n4Hashe/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nwEG30uKgN6S1KNUiUbynw41vDPsjIY/Sw3Pjkp1JnI=; b=n4Hashe/zoTiQcObiKnNdxvY6X
	7adNPCYq6MDha3keOCuu9JRaVvZcSx6hzDui4suxeVj5b9vHDflb4L7T7Duhl5gCpiDtqTF6eptbg
	u0XGVQ8i/A9MyAEI2kPVL1gT3ygr0cLN8PCjVLcjzi6P9+KzBtlvLOUoLsUJtLdGVFNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGpLb-00HLBr-GB; Tue, 11 Jun 2024 02:26:47 +0200
Date: Tue, 11 Jun 2024 02:26:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Message-ID: <40cff9a6-bad3-4f85-8cbc-6d4bc72f9b9f@lunn.ch>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610231022.2460953-4-sean.anderson@linux.dev>

> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
> +{
> +	return u64_stats_read(&lp->hw_stats[stat]);
> +}
> @@ -1695,6 +1760,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  		stats->tx_packets = u64_stats_read(&lp->tx_packets);
>  		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
>  	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
> +
> +	if (!(lp->features & XAE_FEATURE_STATS))
> +		return;
> +
> +	do {
> +		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
> +		stats->rx_length_errors =
> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);

I'm i reading this correctly. You are returning the counters from the
last refresh period. What is that? 2.5Gbps would wrapper around a 32
byte counter in 13 seconds. I hope these statistics are not 13 seconds
out of date?

Since axienet_stats_update() also uses the lp->hw_stat_sync, i don't
see why you cannot read the hardware counter value and update to the
latest value.

       Andrew

