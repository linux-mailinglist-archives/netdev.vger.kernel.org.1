Return-Path: <netdev+bounces-107768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4491C458
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A251F2230D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF11BE25D;
	Fri, 28 Jun 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WleQ6sQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE501CD15
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594203; cv=none; b=Rc13AaYNBc848Qx0Jf47jOrxQhRL2mnqKXF4Y4jzP8rxoo7qgko6u9U0GHgsVmkBVi0VmNZQ/wXiY/MYYLNxCGRKxxiRLK4Q1WGfYBqsan/YEbag5Ds6HuSzLFSfh4umbfTlgQuXH0Ai8zTwzrJC1mSRraQ9UhZbjJAB6RLol8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594203; c=relaxed/simple;
	bh=xYd1U3zYkXfmLZ0+KG+DPqdmHIuN/uK6t05v6u6/JEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEWusO3Cb9sIrNS2zht43JEUWdidsA0rouJVcE+0YS/Hk1wEnvzS5TiAXgry6LFGLf8u6X0Po5+BRDa0ngGqbIxDRN12HWGJRiQWJ0SoI27e4xs5mBOGiPJ28+/rMtk9r3NWW4bZG/ugsXXHiqPxjKhQ1oUSqgyFdMuQzwsK4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WleQ6sQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70ECC116B1;
	Fri, 28 Jun 2024 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594202;
	bh=xYd1U3zYkXfmLZ0+KG+DPqdmHIuN/uK6t05v6u6/JEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WleQ6sQtPGh3FlRhCfAvTt24y5rZUYVZ0+aQv79FFRkkxx1YiM0+aLWroLC+fSUQ6
	 /kjuyj1nFT7rU3F3epV6W7xhe3u961DXe1gMktMxb+1hb9Z+UhFugBpdt2R7ZPbyzN
	 ge9q26tng8YlvmCcMeDyXoOjZ7WAJXh79B9DFpDJwvo07lVuM6gl0QlSTDXqiLyde6
	 tB59KIKlAvKWNJety8LcFuUTtmy60qh2Rrk/Q1F1mLmajc9hkABc+0O1tjkXDTeO2R
	 bn16L3YiffPY/diSuTgGUH/jO21hn2NvzGIRtHAc8gfYk+S0zsTbjfJhu01Fe0UQB1
	 ehe84DJ+1L5CQ==
Date: Fri, 28 Jun 2024 18:03:18 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 09/10] bnxt_en: Increase the max total
 outstanding PTP TX packets to 4
Message-ID: <20240628170318.GK783093@kernel.org>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626164307.219568-10-michael.chan@broadcom.com>

On Wed, Jun 26, 2024 at 09:43:06AM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Start accepting up to 4 TX TS requests on BCM5750X (P5) chips.
> These PTP TX packets will be queued in the ptp->txts_req[] array
> waiting for the TX timestamp to complete.  The entries in the
> array will be managed by a producer and consumer index.  The
> producer index is updated under spinlock since multiple TX rings
> can try to send PTP packets at the same time.
> 
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ed2bbdf6b25f..0867861c14bd 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -457,8 +457,8 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	unsigned int length, pad = 0;
>  	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>  	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
> -	u16 prod, last_frag;
>  	struct pci_dev *pdev = bp->pdev;
> +	u16 prod, last_frag, txts_prod;
>  	struct bnxt_tx_ring_info *txr;
>  	struct bnxt_sw_tx_bd *tx_buf;
>  	__le32 lflags = 0;
> @@ -526,11 +526,19 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  			if (!bnxt_ptp_parse(skb, &seq_id, &hdr_off)) {
>  				if (vlan_tag_flags)
>  					hdr_off += VLAN_HLEN;
> -				ptp->txts_req.tx_seqid = seq_id;
> -				ptp->txts_req.tx_hdr_off = hdr_off;
>  				lflags |= cpu_to_le32(TX_BD_FLAGS_STAMP);
>  				tx_buf->is_ts_pkt = 1;
>  				skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +				spin_lock_bh(&ptp->ptp_tx_lock);
> +				txts_prod = ptp->txts_prod;
> +				ptp->txts_prod = NEXT_TXTS(txts_prod);
> +				spin_unlock_bh(&ptp->ptp_tx_lock);
> +
> +				ptp->txts_req[txts_prod].tx_seqid = seq_id;
> +				ptp->txts_req[txts_prod].tx_hdr_off = hdr_off;
> +				tx_buf->txts_prod = txts_prod;
> +
>  			} else {
>  				atomic_inc(&bp->ptp_cfg->tx_avail);
>  			}
> @@ -770,7 +778,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  tx_kick_pending:
>  	if (BNXT_TX_PTP_IS_SET(lflags)) {
>  		atomic64_inc(&bp->ptp_cfg->stats.ts_err);
> -		atomic_inc(&bp->ptp_cfg->tx_avail);
> +		if (!(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> +			/* set SKB to err so PTP worker will clean up */
> +			ptp->txts_req[txts_prod].tx_skb = ERR_PTR(-EIO);

Hi Michael

Sparse complains that previously it was assumed that ptp could be NULL,
but here it is accessed without checking for that.

Perhaps it can't occur, but my brief check leads me to think it might.

On line 488 there is the following:

	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
		goto tx_free;

Which will lead to the code in the hunk above.

Then on line 513 there is a check for ptp being NULL:


	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && ptp &&
	    ptp->tx_tstamp_en) {

And ptp is not set between lines 488 and 513.


Sparse also complains that txts_prod may be used uninitaialised.
This also seems to be a valid concern as it does seem to be the case
on line 488.

>  	}
>  	if (txr->kick_pending)
>  		bnxt_txr_db_kick(bp, txr, txr->tx_prod);

...


