Return-Path: <netdev+bounces-223634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9CB59C63
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0461A1C0341C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E193680A9;
	Tue, 16 Sep 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmu4v4yV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20036808A;
	Tue, 16 Sep 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037506; cv=none; b=IsiLs7WGLy9ZZOU2L5EusE7CD+iGNClvIGYFGxVxq3M79gBB8+OO9lkmrS8JX9bdK6eTdIHW0UCIR2Ghxd5qh1TYoAZf8AFtmV89RSte/sMFntnwnDun62i5hUetlusgWNbJnwWOfHqyc42bp4JnG7WtTykgM0i1+2hnh9T6o7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037506; c=relaxed/simple;
	bh=eC9k2DCS0Nr6NJ6m20AY0awJ6jRafrqSZeO9AHnF270=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usyNmSSCA3GhBm7f01zmk2bLu/8IRxndHNLsXeN3UPCtHzIXniQTymjmMWoBJ3IkxW0BwhN3i7alIYM2m8rdMNjCiJfuf893vjXsIOYHZgtontJ4T9yaBDLkUzv4XSrLlwByk+ErRMtCxGZjPghYbcMYGSPnkh7YXL0Wg8wa4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmu4v4yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60658C4CEEB;
	Tue, 16 Sep 2025 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037505;
	bh=eC9k2DCS0Nr6NJ6m20AY0awJ6jRafrqSZeO9AHnF270=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmu4v4yVkvqYqxGpUUuRN2EXkkuwO7SeyVVL0P7dSjWPS7Jh5lxFK8fPVX8Kv42Kq
	 Vjf+kg6oj2j5+78lIHXOs0lFAv6paVT4oNQ2rE7WqQI5HS7Ubz6tuTwYvxlYqu2ONW
	 xAR8mvw6DgV1/Tb9yRFtCySF0JOxHwIWxeXRNjvbtSKG7tKwSqSMzmOJRhNbvmbeba
	 TFn+2Z19LUWOnPp57PpNed6u+A6b9pIjAB0Sn5eiJx4lFTNXcqsJCudDI0Da9wtNIp
	 2xJwOoUfH44oUbgSWuKxvanpGZRt4dtO0Ck+843Fkv4TKUVuVqKBrrDVbl4voeMhQQ
	 0i1YAF00zEiUA==
Date: Tue, 16 Sep 2025 16:45:01 +0100
From: Simon Horman <horms@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 05/10] bng_en: Initialise core resources
Message-ID: <20250916154501.GJ224143@horms.kernel.org>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-6-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911193505.24068-6-bhargava.marreddy@broadcom.com>

On Fri, Sep 12, 2025 at 01:05:00AM +0530, Bhargava Marreddy wrote:
> Add initial settings to all core resources, such as
> the RX, AGG, TX, CQ, and NQ rings, as well as the VNIC.
> This will help enable these resources in future patches.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>  .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 213 ++++++++++++++++++
>  .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  50 ++++
>  .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   1 +
>  3 files changed, 264 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

...

> +static int bnge_init_tx_rings(struct bnge_net *bn)
> +{
> +	int i;
> +
> +	bn->tx_wake_thresh = max_t(int, bn->tx_ring_size / 2,
> +				   BNGE_MIN_TX_DESC_CNT);

The use of max_t caught my eye.

And I'm curious to know why tx_wake_thresh is signed.
I don't see it used in this patchset other than
being set on the line above.

In any case, I expect that max() can be used instead of max_t() here.

> +
> +	for (i = 0; i < bn->bd->tx_nr_rings; i++) {
> +		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
> +		struct bnge_ring_struct *ring = &txr->tx_ring_struct;
> +
> +		ring->fw_ring_id = INVALID_HW_RING_ID;
> +
> +		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX,
> +				     &txr->bnapi->napi);
> +	}
> +
> +	return 0;
> +}

...

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h

...

> @@ -176,9 +212,19 @@ struct bnge_net {
>  	u16				*tx_ring_map;
>  	enum dma_data_direction		rx_dir;
>  
> +	/* grp_info indexed by napi/nq index */
> +	struct bnge_ring_grp_info	*grp_info;
>  	struct bnge_vnic_info		*vnic_info;
>  	int				nr_vnics;
>  	int				total_irqs;
> +
> +	int			tx_wake_thresh;
> +	u16			rx_offset;
> +	u16			rx_dma_offset;
> +
> +	u8			rss_hash_key[HW_HASH_KEY_SIZE];
> +	u8			rss_hash_key_valid:1;
> +	u8			rss_hash_key_updated:1;
>  };

...

