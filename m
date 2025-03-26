Return-Path: <netdev+bounces-177687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D312A7145C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9FA16C356
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465A1B042E;
	Wed, 26 Mar 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKs5JOkK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77021ADFE4;
	Wed, 26 Mar 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983413; cv=none; b=Kq8V0n1d9vpeCrj0dBST7Fu9XhXOmBt1SFJCX1DXRMwDmt8APM32cKG/Aa/r4c8eecAOhjjki/5auHJ2jZquvcfdSHa5BYkt+kQCoCSsze5EfWqo3wLs+ELLFrV0W6ObHtju4bCxUVLAOYnDY/Fy5NtI0KCv+8TPpLVXiUdsrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983413; c=relaxed/simple;
	bh=goOzdIpzzD09tIC7KbQNvYxByDWJjlXrWxqnwD6t3YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgOx9djWFoP5p6F+KaR79KC5iyKw6vqD+OgBFfINrK8x4H9H6vsWBRfvLRatVdcOJ3ucUUl0OzdMQ1vhsQ1jrcRad7cIJ7DOHTBc2NJzWKHpP9JxO5nVe1hQYih4kC3zaB8Wvm2iWbynaar72Ds1iJBcnbbeQ39DVYvL2vXJ9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKs5JOkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A652C4CEEA;
	Wed, 26 Mar 2025 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742983411;
	bh=goOzdIpzzD09tIC7KbQNvYxByDWJjlXrWxqnwD6t3YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKs5JOkKnH7ZF9Qp5x1uSaiN2bK68VkwyXC1Ix6cNzYZFFjhpIou+eLYNDTplx0Bo
	 eyRnozYKcB8hbMYPAZIHzWCPBKbl7M8p+34HfsS5NU80zZmWbm18GysV7er+aqy8bs
	 pJNImtQh119yM0sDtuVrot8pS698dMogqSCNLirQ4mUnUCesNTv+SZIgw2QKsSlku7
	 bFArif5x4ioMdkp/UJW7ylD6A7YEw0I+vj6z1Cl2grCZkMDg7uN3xQsyWNfHBS8c5m
	 QhzFd077+OgJMwo4KUSzM02axQ8UuJ9uONXyikLvVfWNxrW+RnB8ar5CAwh/jTaeNc
	 9oKnxyBDV3Ccw==
Date: Wed, 26 Mar 2025 10:03:27 +0000
From: Simon Horman <horms@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: microchip: lan743x: Fix memory
 allocation failure
Message-ID: <20250326100327.GY892515@horms.kernel.org>
References: <20250325105653.6607-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325105653.6607-1-thangaraj.s@microchip.com>

On Tue, Mar 25, 2025 at 04:26:53PM +0530, Thangaraj Samynathan wrote:
> The driver allocates ring elements using GFP_DMA flags. There is
> no dependency from LAN743x hardware on memory allocation should be
> in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC
> 
> Fixes: e8684db191e4 ("net: ethernet: microchip: lan743x: Fix skb allocation failure")
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>

Hi Thangaraj,

As per the discussion of v1 I agree that dropping GFP_DMA and keeping
GFP_ATOMIC makes sense. So the code change looks good to me.

However, I am not clear that this is fixing a bug, which is
the main pre-requisite for patches for 'net'.

If not, perhaps it should be targeted at 'net-next' instead.
In which case the Fixes tag should be dropped, but you can refer to the
commit that introduced this problem in the commit message using this
syntax if you wish.

   commit e8684db191e4 ("net: ethernet: microchip: lan743x: Fix skb
   allocation failure")

e.g.:

   The driver allocates ring elements using GFP_DMA flags. There is
   no dependency from LAN743x hardware on memory allocation should be
   in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC

   Introduced by commit e8684db191e4 ("net: ethernet: microchip: lan743x:
   Fix skb allocation failure").

   Signed-off-by: ...

If you do post for net-next, keep in mind that net-next is currently closed
for the merge window. I expect is should re-open around the 14th April.
So please post any patches for net-next after it re-opens.

> ---
> v0
> -Initial Commit
> 
> v1
> -Modified GFP flags from GFP_KERNEL to GFP_ATOMIC
> -added fixes tag

Link to v1: https://lore.kernel.org/all/20250314070227.24423-1-thangaraj.s@microchip.com/

> 
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 23760b613d3e..8b6b9b6efe18 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -2495,8 +2495,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
>  
>  	/* save existing skb, allocate new skb and map to dma */
>  	skb = buffer_info->skb;
> -	if (lan743x_rx_init_ring_element(rx, rx->last_head,
> -					 GFP_ATOMIC | GFP_DMA)) {
> +	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_ATOMIC)) {
>  		/* failed to allocate next skb.
>  		 * Memory is very low.
>  		 * Drop this packet and reuse buffer.
> -- 
> 2.25.1
> 
> 

