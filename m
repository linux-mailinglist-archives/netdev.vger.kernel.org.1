Return-Path: <netdev+bounces-209066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF669B0E261
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9C1C8071A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C727E7DF;
	Tue, 22 Jul 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB71g/OW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823786AA7
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204003; cv=none; b=mmh/rS4Ppj27wPOU2VC5mi+hB0sIJbO24fi95MDi/l6q7FsH5rOF5OVH2f9iZRzyOFEOLCf00IF6cmxDrnAmK7YTe9k18SNaizswyddqCFon8/wgQhjoLNe7w13Xzrt9XvWblSq/BYcjCgQASDTsU4sxixXhnwFeKgVN9S1yPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204003; c=relaxed/simple;
	bh=VaptKYe2579UFwn1jg2lg45qqmE0b86homsjfCLU0V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpmmdd2tFYVJtUule5FzzBfx4SndZw/WtyBBDuip99b9W+q6cpXZRHVfgkztJ6vXHj9e+r8wYKo0LF5Py9KCKNtZONlzQ1N/gJ6SvVEPyNdO+kh6RrBGqtt1XBGIeHwAPv+/egcjMpvGYRnBgekWTnW3bOSU+4DevmIJZfyml2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB71g/OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F65C4CEEB;
	Tue, 22 Jul 2025 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204002;
	bh=VaptKYe2579UFwn1jg2lg45qqmE0b86homsjfCLU0V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB71g/OWVwjR00skiv038Xalf1xeMcNShXDfIIaxSzo0tKB28jyHNKl0yBVx8+fwU
	 IMWuJLpyJ2PEdue2u70DFQzx5N7+1+8QswQKiQtmm9QEz2tzll3NnrQv5XnR3vRM0O
	 uwZUWFHsq+UCiqQUSwleKA3R8pq0IskZrYbaK0v2lEVweH9CyGDHg56ezLxu4Ewpaa
	 kfMVa/FUgdxhhj4fYI2b95u09x1tUNIuQ/fQZrpISTuR/dDM7g1SOaP/XnZO/poSyz
	 jVYO3Pdx5XIIpBf9SRisBb/nyh0Nf61LrcKL/h3l+c9iyKnpEaGcCeeIMLQQj/KjpT
	 qawqDD9PYDmFw==
Date: Tue, 22 Jul 2025 18:06:38 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 08/11] octeontx2-pf: Initialize new NIX SQ
 context for cn20k
Message-ID: <20250722170638.GT2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-9-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752772063-6160-9-git-send-email-sbhatta@marvell.com>

On Thu, Jul 17, 2025 at 10:37:40PM +0530, Subbaraya Sundeep wrote:
> cn20k has different NIX context for send queue hence use
> the new cn20k mailbox to init SQ context.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/cn20k.c    | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> index 037548f36940..4f0afa5301b4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> @@ -389,11 +389,45 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
>  	return 0;
>  }
>  
> +static int cn20k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
> +{
> +	struct nix_cn20k_aq_enq_req *aq;
> +	struct otx2_nic *pfvf = dev;
> +
> +	/* Get memory to put this msg */
> +	aq = otx2_mbox_alloc_msg_nix_cn20k_aq_enq(&pfvf->mbox);
> +	if (!aq)
> +		return -ENOMEM;
> +
> +	aq->sq.cq = pfvf->hw.rx_queues + qidx;
> +	aq->sq.max_sqe_size = NIX_MAXSQESZ_W16; /* 128 byte */
> +	aq->sq.cq_ena = 1;
> +	aq->sq.ena = 1;
> +	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
> +	aq->sq.smq_rr_weight = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
> +	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
> +	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
> +	aq->sq.sqb_aura = sqb_aura;
> +	aq->sq.sq_int_ena = NIX_SQINT_BITS;
> +	aq->sq.qint_idx = 0;
> +	/* Due pipelining impact minimum 2000 unused SQ CQE's
> +	 * need to maintain to avoid CQ overflow.
> +	 */
> +	aq->sq.cq_limit = ((SEND_CQ_SKID * 256) / (pfvf->qset.sqe_cnt));

nit: Unnecessary parentheses

     I think this will work just as well (completely untested):

	aq->sq.cq_limit = (SEND_CQ_SKID * 256) / pfvf->qset.sqe_cnt;

> +
> +	/* Fill AQ info */
> +	aq->qidx = qidx;
> +	aq->ctype = NIX_AQ_CTYPE_SQ;
> +	aq->op = NIX_AQ_INSTOP_INIT;
> +
> +	return otx2_sync_mbox_msg(&pfvf->mbox);
> +}

...

