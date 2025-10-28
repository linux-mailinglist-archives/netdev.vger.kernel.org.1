Return-Path: <netdev+bounces-233556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6CEC155F9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E273188E573
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967633CE9B;
	Tue, 28 Oct 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXTcg0jj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B025F7B9;
	Tue, 28 Oct 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664667; cv=none; b=tt8YQF+Hl2W1uKgx21RadZKyd40h+V4Rp5uFhtA15kyDMMxUxsKd69L3zog6OMgzeMqZ0zcg/hxJSqMb4lPoidHoOWQz5XXA7P+D26aEByO1nMp20HAfgMxZIG1Br3GX60bsHBHpX+kD/e9UhYW2JRCSG+GvW9XX90ezH9vXQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664667; c=relaxed/simple;
	bh=PQq14YNtGBdvwq+dX4gUGxliEpdbUTWWE8fvTpPA3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpH8gQt8CiGyblvbahRb4iLaQSAaVgruK96YGTQXm+I+8mAaR90haZhgDLbHwdGo17aj0GjfP+IixUi2G4VDuEV3uxLlhdrEJRnzGFewEjV6PK1CRT4CorPnO5RPvKxXa5XRv30LKAgOcy9lgLHq9EgSpSzVOxyBd7ZMuLIznRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXTcg0jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D34C4CEE7;
	Tue, 28 Oct 2025 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664667;
	bh=PQq14YNtGBdvwq+dX4gUGxliEpdbUTWWE8fvTpPA3h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXTcg0jjDTNN2sa1ucH7Hs+RVGNbGuuMblYlHZTp6eVzapA1h5JgOOxYio1sy2yDs
	 bAjxj1WLzziIucc1OxXsWm/tUdEYHiPt1LrfsfpjxTjGgUJg4ITwDOMyZJ5U97vicC
	 lIfH+09X6qJA7t3FHFyL7TXUN4HiO8AFnNmTQPYMaicjz5hFoHNNZnzHvCIqKaiU9O
	 ot+X7d4JiL8QVkFNYTGBFbyeQQSPv0jjbLz5Nyu6FLQ2hinM4Xhz8UleJKBIPAhUxs
	 Icw6KE7fizzbqBTapytd9SWzq2xLMb+tjkiY9aNueN7M81moLnndrGmRNfsA1Qy/6s
	 OplAK6Bx2n7Dw==
Date: Tue, 28 Oct 2025 15:17:41 +0000
From: Simon Horman <horms@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, kuniyu@google.com,
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: Re: [RFC PATCH net-next v2 2/2] net: ethernet: Implement
 ndo_write_rx_config callback for the 8139cp driver
Message-ID: <aQDelXtB1--OdERb@horms.kernel.org>
References: <20251026175445.1519537-1-viswanathiyyappan@gmail.com>
 <20251026175445.1519537-3-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026175445.1519537-3-viswanathiyyappan@gmail.com>

On Sun, Oct 26, 2025 at 11:24:45PM +0530, I Viswanath wrote:
> Implement ndo_write_rx_config for the 8139cp driver
> 
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

...

> @@ -882,55 +886,53 @@ static netdev_tx_t cp_start_xmit (struct sk_buff *skb,
>  	goto out_unlock;
>  }
>  
> +static void cp_write_rx_config(struct net_device *dev)
> +{
> +	struct cp_private *cp = netdev_priv(dev);
> +	struct cp_rx_config snapshot;
> +
> +	read_snapshot((&snapshot), struct cp_private);
> +
> +	/* We can safely update without stopping the chip. */
> +	cpw32_f(RxConfig, snapshot.rx_mode);
> +
> +	cpw32_f(MAR0 + 0, snapshot.mc_filter[0]);
> +	cpw32_f(MAR0 + 4, snapshot.mc_filter[1]);
> +}Firstly, think whether you have a bug fix or new "next-like" content.
> Then once decided, assuming that you use git, use the prefix flag, i.e.

FWIIW, this patch is mangled, e.g. the lines above.

> +
>  /* Set or clear the multicast filter for this adaptor.
>     This routine is not state sensitive and need not be SMP locked. */

...

