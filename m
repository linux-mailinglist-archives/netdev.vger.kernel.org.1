Return-Path: <netdev+bounces-200772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982BEAE6CFF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DE23A3CB6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76F2E3396;
	Tue, 24 Jun 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJzds/RD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005C286430;
	Tue, 24 Jun 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783892; cv=none; b=a29vWjsGVHbLYNrO5cUGqMRCO25/8+cRfORkREzX4h0vVtTTOdADjpwT3+rdflvt68W3ry0ze4pXwC25YacuTMIpbjjJOER5W9o0QcJto6LFPqY6++mdonmR1aR5L0Z1kU3PfcDSib9MaxTgfYl41BL4z62YlSozCI9E+Go7gIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783892; c=relaxed/simple;
	bh=1wSlBTA9NchzeWz0Bz19osXwHKWn6c1flflhLXXn9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUD9N0JpA+0fiYXiSDQ5rpyf/bB6mv+vkdU1EbzNyUXyu3v6JC2RYDMqWga4d569I9KWE8410Zf0ghWO5CL4lGWvx19ryIG5lUM4J+cgsUMzMAvMbBbTqu32bawEtpH2D4Y/EhHsHEnwFvqQ4qn7zWx4t1rrVyk2U5+bBNHBdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJzds/RD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A9C4CEE3;
	Tue, 24 Jun 2025 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750783891;
	bh=1wSlBTA9NchzeWz0Bz19osXwHKWn6c1flflhLXXn9Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJzds/RDFtYpk28pkYM55SIIh0W+QHJZC5e+VKIbK2VrrtoWqqiL4d3s4wq/8qoOP
	 D03HN4b91z/Tu8BJXGV4Cmh0Uw3V6kGZ7/NLflTky5C0eJ2Im2cwPw0UmmHAZfytGN
	 7Op3Z4Ag8aojtbF8zbnx+u3edkoK8AvgXDiQGq8GWsjzybENZfa9BGj8fTGAGDrPN+
	 VdGimLMnjjmugFk9ExRK+CnwzyEBX3kmfK3hI5Axm92gkjHRoacmeSCIILQapcG6GU
	 //CLqIlaNyUWCJdnmJxyqIq7KIVQWGxDDSY5BBLY+mAAiU+3C/wNuciyIg+Kd0sNu2
	 2HZ7m8Im5fubg==
Date: Tue, 24 Jun 2025 17:51:28 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Chas Williams <3chas3@gmail.com>,
	"moderated list:ATM" <linux-atm-general@lists.sourceforge.net>,
	"open list:ATM" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
Message-ID: <20250624165128.GA1562@horms.kernel.org>
References: <20250624064148.12815-3-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624064148.12815-3-fourier.thomas@gmail.com>

On Tue, Jun 24, 2025 at 08:41:47AM +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/atm/idt77252.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
> index 1206ab764ba9..f2e91b7d79f0 100644
> --- a/drivers/atm/idt77252.c
> +++ b/drivers/atm/idt77252.c
> @@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
>  
>  	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
>  						 skb->len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
> +		return -ENOMEM;
>  
>  	error = -EINVAL;
>  
> @@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
>  		paddr = dma_map_single(&card->pcidev->dev, skb->data,
>  				       skb_end_pointer(skb) - skb->data,
>  				       DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&card->pcidev->dev, paddr))
> +			goto outpoolrm;
>  		IDT77252_PRV_PADDR(skb) = paddr;
>  
>  		if (push_rx_skb(card, skb, queue)) {
> @@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
>  	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
>  			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
>  
> +outpoolrm:
>  	handle = IDT77252_PRV_POOL(skb);
>  	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;

Hi Thomas,

Can sb_pool_remove() be used here?
It seems to be the converse of sb_pool_add().
And safer than the code above.
But perhaps I'm missing something.

