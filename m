Return-Path: <netdev+bounces-228340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A784BBC824D
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8781898BF3
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3C12D3221;
	Thu,  9 Oct 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suYQvi9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1C241CB7
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000091; cv=none; b=hkoIj3KMLrqsQ01AfK+jHzXw+IlFQOjbyVd+hbMqAczw+WUD2PM1ErHS1DwseuVLT7jxIgYfz7F3GZdXDwIcN1RKWqp0Su9F6SxO8x01EDt/DbVgRVnDk6xFfY7/RDVf2FumejseIJuDHGYKWckxXkubm+pZCpGXN+FzUtosUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000091; c=relaxed/simple;
	bh=ZloOlTLnnd1lQwtetVDQnNVcBn0VSlgf2dby3oP+A10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4437b1WUm8nB21D5Q0M512qDaUmX7MIvfVTUXrQzl1aBX2LE/wJyoxt962X2GlQAkt8RWu4ilBEj6KWXTWfCHW13iDGyTvh5LKzH9RCtsV3MEsF847aEni0i4xi1Us/MXgaRy+tPcN8wpVsdYeMRgKrICvJy5LHz5pGVVuZm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suYQvi9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D67C4CEE7;
	Thu,  9 Oct 2025 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000090;
	bh=ZloOlTLnnd1lQwtetVDQnNVcBn0VSlgf2dby3oP+A10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suYQvi9CyNc76fgBHVCilzOJ/oaQP0Dro2E9TrVzXVfQ2T6EjWJlkaT4EKR/+ngfn
	 Qdx2HLEspYt+oicqES2GxMxECWlS1QeS+tjJYDMazIZ2bCyKzTZB9+pNXHSZuicjAg
	 sAFq8s8I6QKswnle3QHg5U9E9Bjb5YwNJYfGz3495NwZZV4WnvZqMOCZbPQnShXswF
	 CUFWStQ2c6kUqW6ZjSAgxAvUaIkAP9Dh/yJWK0pCGfCnyAnl66eQUy2qqxWFg75LRu
	 PhQLk+oag8pIq5vO4DvST9Y2ZkgQUv8f+q5KN/KRXxkZ1JsCQhTM3Dz3m3aNFj4cA/
	 MFOj0ZaSOKvBw==
Date: Thu, 9 Oct 2025 09:54:45 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>,
	Daniel Pawlik <pawlik.dan@gmail.com>,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH net v2] net: mtk: wed: add dma mask limitation and
 GFP_DMA32 for device with more than 4GB DRAM
Message-ID: <20251009085445.GV3060232@horms.kernel.org>
References: <20251009-wed-4g-ram-limitation-v2-1-c0ca75b26a29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-wed-4g-ram-limitation-v2-1-c0ca75b26a29@kernel.org>

On Thu, Oct 09, 2025 at 08:29:34AM +0200, Lorenzo Bianconi wrote:
> From: Rex Lu <rex.lu@mediatek.com>
> 
> Limit tx/rx buffer address to 32-bit address space for board with more
> than 4GB DRAM.
> 
> Fixes: 804775dfc2885 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
> Fixes: 6757d345dd7db ("net: ethernet: mtk_wed: introduce hw_rro support for MT7988")
> Tested-by: Daniel Pawlik <pawlik.dan@gmail.com>
> Tested-by: Matteo Croce <teknoraver@meta.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Add missing Fixes tags
> - Avoid possible deadlock if dma_set_mask_and_coherent fails
> - Link to v1: https://lore.kernel.org/r/20251008-wed-4g-ram-limitation-v1-1-16fe55e1d042@kernel.org

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


