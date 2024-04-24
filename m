Return-Path: <netdev+bounces-91048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5C8B11B6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA052899B6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7816D4FF;
	Wed, 24 Apr 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elnTCy8B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800416C6A5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982147; cv=none; b=mbjgrICZqbXCw8REtggfILdorjHTZ6GtQRpCRJVxG4j5BD2cKtKJ80dYHxNhx/lG6Z1SSkxEKvfNjEHl9mopHxSLMKVS04o1WclxWpKvB/alWvFq8Alr4TOhJvtEIyKt0PdG/gTF7/6h7zvPOjYWouS0aIk2PbCOJLsr1WsPcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982147; c=relaxed/simple;
	bh=ncKcQctT+eLAn0pmlBreZeTWWqsG8ClAkTvI/8K11t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9pUjE2+Jse/4B4krX8yb6Qcao6kEQlWLHly+dwW0DtNC5DN+sTN5+fMmnyizFxdD18l48aju0KERf14kQSv7IQPFJ1O19BeBIZXZIZZyd0r7NplhSQAszI5wTXvTWhfDX2idjRmrVYgjoKPKbDhKNUO9wYLjLNefzMzDTIpe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elnTCy8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AAEC113CD;
	Wed, 24 Apr 2024 18:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713982147;
	bh=ncKcQctT+eLAn0pmlBreZeTWWqsG8ClAkTvI/8K11t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elnTCy8B+2NjOnUuXtIY002j1dLP5oXX3z8XPS/l1JzJaw6OHQcx0U4QdYs4OTAeR
	 boR7+m1NxPOIlFY5UeMffiwTlvsOnHP5vsa5Y4HCg+tC8MC8TyLpMvkmpxq59m8pOW
	 fv2iHdcdE9nl84DOtUgF0UD4DmthTlo9DAELp6m2r5lr5qDUXot82IJIR8r5Ee8IBi
	 r6Qa4T8OdkDWiff2bXFWg7bBoV82keLUQChWkjmQTV4BA8i3Til1JN1ZZ5KheI+7vu
	 HMdyzb+UpUtXk8lpFtMKsMaAVDIhiKCLi0xsKlyXSEIO8aKKEDXzGVssZLYX5KpO83
	 T3qSG/1S+P0Rg==
Date: Wed, 24 Apr 2024 19:09:03 +0100
From: Simon Horman <horms@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org, Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] enic: Replace hardcoded values for vnic
 descriptor by defines
Message-ID: <20240424180903.GR42092@kernel.org>
References: <20240423035305.6858-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423035305.6858-1-satishkh@cisco.com>

+ Christian, Satish, Dave, Eric, Jakub & Paolo

On Mon, Apr 22, 2024 at 08:53:05PM -0700, Satish Kharat wrote:
> Replace the hardcoded values used in the calculations for
> vnic descriptors and rings with defines. Minor code cleanup.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Hi Satish,

it is probably not necessary to repost because of this,
but please use get_maintainers.pl my.patch to seed
the CC list when posting Networking patches.

That notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/cisco/enic/vnic_dev.c | 20 ++++++++------------
>  drivers/net/ethernet/cisco/enic/vnic_dev.h |  5 +++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
> index 12a83fa1302d..9f6089e81608 100644
> --- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
> +++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
> @@ -146,23 +146,19 @@ EXPORT_SYMBOL(vnic_dev_get_res);
>  static unsigned int vnic_dev_desc_ring_size(struct vnic_dev_ring *ring,
>  	unsigned int desc_count, unsigned int desc_size)
>  {
> -	/* The base address of the desc rings must be 512 byte aligned.
> -	 * Descriptor count is aligned to groups of 32 descriptors.  A
> -	 * count of 0 means the maximum 4096 descriptors.  Descriptor
> -	 * size is aligned to 16 bytes.
> -	 */
> -
> -	unsigned int count_align = 32;
> -	unsigned int desc_align = 16;
>  
> -	ring->base_align = 512;
> +	/* Descriptor ring base address alignment in bytes*/
> +	ring->base_align = VNIC_DESC_BASE_ALIGN;
>  
> +	/* A count of 0 means the maximum descriptors */
>  	if (desc_count == 0)
> -		desc_count = 4096;
> +		desc_count = VNIC_DESC_MAX_COUNT;
>  
> -	ring->desc_count = ALIGN(desc_count, count_align);
> +	/* Descriptor count aligned in groups of VNIC_DESC_COUNT_ALIGN descriptors */
> +	ring->desc_count = ALIGN(desc_count, VNIC_DESC_COUNT_ALIGN);
>  
> -	ring->desc_size = ALIGN(desc_size, desc_align);
> +	/* Descriptor size alignment in bytes */
> +	ring->desc_size = ALIGN(desc_size, VNIC_DESC_SIZE_ALIGN);
>  
>  	ring->size = ring->desc_count * ring->desc_size;
>  	ring->size_unaligned = ring->size + ring->base_align;
> diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.h b/drivers/net/ethernet/cisco/enic/vnic_dev.h
> index 6273794b923b..7fdd8c661c99 100644
> --- a/drivers/net/ethernet/cisco/enic/vnic_dev.h
> +++ b/drivers/net/ethernet/cisco/enic/vnic_dev.h
> @@ -31,6 +31,11 @@ static inline void writeq(u64 val, void __iomem *reg)
>  #undef pr_fmt
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#define VNIC_DESC_SIZE_ALIGN	16
> +#define VNIC_DESC_COUNT_ALIGN	32
> +#define VNIC_DESC_BASE_ALIGN	512
> +#define VNIC_DESC_MAX_COUNT	4096
> +
>  enum vnic_dev_intr_mode {
>  	VNIC_DEV_INTR_MODE_UNKNOWN,
>  	VNIC_DEV_INTR_MODE_INTX,
> -- 
> 2.44.0
> 
> 

