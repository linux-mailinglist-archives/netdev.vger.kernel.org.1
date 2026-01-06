Return-Path: <netdev+bounces-247248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E163ECF6441
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76F71304DB72
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B613A3ED;
	Tue,  6 Jan 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OztnDUW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35557640E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662867; cv=none; b=ic5dlBmF3uBCX0ufhlP2OXy+TCgqPwjB7yxFB8bu4yo1nzpKLBXSAl+vDKdOF5vmLxOgcCs6Q2VIa6qfp6/OHbNxs7O85XcqDlhTw3IRDuLunrjmDackHIvUrJ5GNnKHN7NuiP13C3b46mcbKkiil3pe1jO2SBykA9cEaInJQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662867; c=relaxed/simple;
	bh=HjmmbT7swPUwLz2gSCBCSLmFC0htS2vCSiQNmDztMQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGoYuc/YTUmocHVQk7CFwQbsWUIQFkzi8YoHXRi/wJq0qt8fYZP1ITZ1p1j2SHzv1AkwBQMngry/uGeeQZ+GQ2+VD9nu9HDB75Lm4fc3C+tTYMNqD10YwPUMxbdLk0jxCKmow5tgbe75yBASoWmUMyTgCRe1eMAJNemSIDv7TVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OztnDUW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8AC116D0;
	Tue,  6 Jan 2026 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767662867;
	bh=HjmmbT7swPUwLz2gSCBCSLmFC0htS2vCSiQNmDztMQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OztnDUW/IqqWHPqoMLz7nnfz3BTXNvUJvK6w97FtsGBPVPyXOJAh340w+lD7G0NHP
	 zloQ9g6/xn6owcg2BcUhn5yCZ/R6zx+arBIWjTs+yz2cl8N4gNgmbNi0pQOrSmRVGN
	 vD85Tx3cw7rHV6DyTKfBd9TtJ7t+zykwMSOik8Mr15MI3XonRsthSZZkwarxE4MIe6
	 OReHEmO23vijsbtkvrYmHr2DXa4KOcIJ8KskmxEOMM5u4AloAfEc62nAxdn7ItJna4
	 LFIGZd3aksszBcsVglvGf2j6ON/2/S/oF9R1Pbly7q+7Kt0tDQagREO9+kmBnNMfKR
	 2uwfl3qevfIrQ==
Date: Mon, 5 Jan 2026 17:27:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net
Subject: Re: [PATCH v3 1/2] tls: TLS 1.3 hardware offload support
Message-ID: <20260105172745.5cc67e79@kernel.org>
In-Reply-To: <20260102184708.24618-2-rjethwani@purestorage.com>
References: <20260102184708.24618-1-rjethwani@purestorage.com>
	<20260102184708.24618-2-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 11:47:07 -0700 Rishikesh Jethwani wrote:
> Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
> enabling hardware acceleration for TLS 1.3 connections on capable NICs.
> 
> This patch implements the critical differences between TLS 1.2 and TLS 1.3
> record formats for hardware offload:
> 
> TLS 1.2 record structure:
>   [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]
> 
> TLS 1.3 record structure:
>   [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
> 
> Key changes:
> 1. Content type handling: In TLS 1.3, the content type byte is appended
>    to the plaintext before encryption and tag computation. This byte must
>    be encrypted along with the ciphertext to compute the correct
>    authentication tag. Modified tls_device_record_close() to append
>    the content type before the tag for TLS 1.3 records.
> 
> 2. Version validation: Both tls_set_device_offload() and
>    tls_set_device_offload_rx() now accept TLS_1_3_VERSION in addition
>    to TLS_1_2_VERSION.
> 
> 3. Pre-populate dummy_page with valid record types for memory
>    allocation failure fallback path.
> 
> Note: TLS 1.3 protocol parameters (aad_size, tail_size, prepend_size)
> are already handled by init_prot_info() in tls_sw.c.

I don't see you handling re-keying, which is supported in SW.

> Testing:
> Verified on Broadcom BCM957608 (Thor 2) and Mellanox ConnectX-6 Dx
> (Crypto Enabled) using ktls_test. Both TX and RX hardware offload working
> successfully with TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher suites.

The kernel has come a long way in terms of HW testing since TLS was
added. We now require in-tree selftests for new capabilities. Some
relevant information here: https://github.com/linux-netdev/nipa/wiki

> The upstream Broadcom bnxt_en driver does not yet support kTLS offload.
> Testing was performed using the out-of-tree driver version
> bnxt_en-1.10.3-235.1.154.0, which works without modifications.

It's a bit odd to mention that you tested some out of tree code.
Glad it works, but I don't see the relevance upstream. Please drop
the mentions of Broadcom until the driver has TLS offload support added.

> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  net/tls/tls_device.c | 49 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index 82ea407e520a..f57e96862b1c 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -319,6 +319,36 @@ static void tls_device_record_close(struct sock *sk,
>  	struct tls_prot_info *prot = &ctx->prot_info;
>  	struct page_frag dummy_tag_frag;
>  
> +	/* TLS 1.3: append content type byte before tag.
> +	 * Record structure: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
> +	 * The content type is encrypted with the ciphertext for authentication.
> +	 */
> +	if (prot->version == TLS_1_3_VERSION) {
> +		struct page_frag dummy_content_type_frag;
> +		struct page_frag *content_type_pfrag = pfrag;
> +
> +		/* Validate record type range */
> +		if (unlikely(record_type < TLS_RECORD_TYPE_CHANGE_CIPHER_SPEC ||
> +			     record_type > TLS_RECORD_TYPE_ACK)) {
> +			pr_err_once("tls_device: invalid record type %u\n",
> +				    record_type);
> +			return;

This check is really odd. Why is it relevant, and yet not relevant
enough to handle cleanly? On a quick look it appears that the user
can set whatever content type they want.

> +
> +		if (unlikely(pfrag->size - pfrag->offset < prot->tail_size) &&
> +		    !skb_page_frag_refill(prot->tail_size, pfrag, sk->sk_allocation)) {
> +			/* Out of memory: use pre-populated dummy_page */
> +			dummy_content_type_frag.page = dummy_page;
> +			dummy_content_type_frag.offset = record_type;
> +			content_type_pfrag = &dummy_content_type_frag;
> +		} else {
> +			/* Current pfrag has space or allocation succeeded - write content type */
> +			*(unsigned char *)(page_address(pfrag->page) + pfrag->offset) =
> +				record_type;

wrap at 80chars and please refactor this long line into something more
readable.

> +		}
> +		tls_append_frag(record, content_type_pfrag, prot->tail_size);
> +	}
> +
>  	/* append tag
>  	 * device will fill in the tag, we just need to append a placeholder
>  	 * use socket memory to improve coalescing (re-using a single buffer
> @@ -335,7 +365,7 @@ static void tls_device_record_close(struct sock *sk,
>  
>  	/* fill prepend */
>  	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
> -			 record->len - prot->overhead_size,
> +			 (record->len - prot->overhead_size) + prot->tail_size,
>  			 record_type);
>  }
>  
> @@ -1089,7 +1119,8 @@ int tls_set_device_offload(struct sock *sk)
>  	}
>  
>  	crypto_info = &ctx->crypto_send.info;
> -	if (crypto_info->version != TLS_1_2_VERSION) {
> +	if (crypto_info->version != TLS_1_2_VERSION &&
> +	    crypto_info->version != TLS_1_3_VERSION) {
>  		rc = -EOPNOTSUPP;
>  		goto release_netdev;
>  	}

Are all existing drivers rejecting TLS 1.3 sessions?
These days we prefer for drivers to explicitly opt into new features 
to avoid surprises.
-- 
pw-bot: cr

