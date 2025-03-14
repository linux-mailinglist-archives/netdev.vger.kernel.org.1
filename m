Return-Path: <netdev+bounces-174989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08BA61CE0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C23D3AA228
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A061A2872;
	Fri, 14 Mar 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="PBVGTM3+"
X-Original-To: netdev@vger.kernel.org
Received: from mx18lb.world4you.com (mx18lb.world4you.com [81.19.149.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5272054FC;
	Fri, 14 Mar 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984640; cv=none; b=dzBQX9LyqV9wAPjiUwu1A6MAAJBV52SYufyrK6hCGDEVSYni7SkpuS1BxPe+7768zySEyPM8Np39U7HJwhXKnfJxtwuSysB/doWeZmgbRl70LAy1ivU8APT8Fwn5wpYBgE6CGftX+hXboQwH0e8AtoRUGCrP6LdIF/Xt/rdnjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984640; c=relaxed/simple;
	bh=KabjsIbP8v1YZwE6BURVO+TQJ3+JP+XqmY0a/eOV2Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNACWKFuYczObpY7pE992sGubRUrmePEGqbLJ2FkIq7Qd1Vy4iYPP7uxgVwYkK3z8jpjcSG5uqp7v9NZXuVERsL1jrxydCaJ+fC3SRQZ+XrRsYNoROGP8b/EUQZ2Rt0asKGSJRbZ4N7JE6gCbNwMu8u6zlxAaNel8X/pj5WN+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=PBVGTM3+; arc=none smtp.client-ip=81.19.149.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nBdrFtqWTipZkEC62GCjdyqRKr/ukOzwzEe19sVot/k=; b=PBVGTM3+7gWcKIKD+ZStBBfNrs
	p/5+op1wpt30ZhKuvFO5N0kwLKxXb+brjHw4X9QuRSaqQJ1yX5bVSZ0gHGwdHmypLe2U7Kx/B1H38
	zwqJK547yN9VXigAVrtLy09NX2HgKAJTfmNiQ9XdUFs57HIOJNWP9x83AC5Ysavu5Dko=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx18lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1ttBmD-000000008Ge-22Dc;
	Fri, 14 Mar 2025 21:37:05 +0100
Message-ID: <806eed8e-0695-450f-a16b-66b602db01dd@engleder-embedded.com>
Date: Fri, 14 Mar 2025 21:37:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: microchip: lan743x: Fix memory
 allocation failure
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250314070227.24423-1-thangaraj.s@microchip.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250314070227.24423-1-thangaraj.s@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.03.25 08:02, Thangaraj Samynathan wrote:
> The driver allocates ring elements using GFP_ATOMIC and GFP_DMA
> flags. The allocation is not done in atomic context and there is
> no dependency from LAN743x hardware on memory allocation should be
> in DMA_ZONE. Hence modifying the flags to use only GFP_KERNEL.
> 
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
>   drivers/net/ethernet/microchip/lan743x_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 23760b613d3e..c10b0131d5fb 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -2495,8 +2495,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
>   
>   	/* save existing skb, allocate new skb and map to dma */
>   	skb = buffer_info->skb;
> -	if (lan743x_rx_init_ring_element(rx, rx->last_head,
> -					 GFP_ATOMIC | GFP_DMA)) {
> +	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_KERNEL)) {

I agree with removing GFP_DMA. If it would be needed, then everywhere
and not only here in NAPI context as it is intended for hardware
limitations.

I'm not sure if GFP_ATOMIC can be removed. Isn't NAPI an atomic context?
For example napi_alloc_skb() and page_pool_dev_alloc_pages() use
GFP_ATOMIC.

Gerhard


