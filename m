Return-Path: <netdev+bounces-251147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A7D3AD51
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70EAB300E7B1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B138A288;
	Mon, 19 Jan 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtVFWEHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAB4C92;
	Mon, 19 Jan 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834415; cv=none; b=ULGoAc/lbxdBpUxHJexNp0UGWZTs51X1qc68xLFqCbF3aRlbuIZBhWF+LV2FY2x5gy2jjov7UcOBYzF5+w1l8y5WT/F8j40Ej9mEjW66TRn2H2PVAFcyOPDj1hAAXPIAAuunKqb4OrCfCDIk1VtZpS+SgazYUlF77wX36SVnmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834415; c=relaxed/simple;
	bh=n+spNRVO7mggUSyXYANfNjHawunxAXxcGIdjXfqsl7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTlqg5QzZVx1BnariwcEWN8Nucj3RZg9pwUaGGzd8RqKwpQunQezkzRycXdCAna5KoeB1VcKgmTYkTwB8KCBMx6wS1sxgwPe6ghTbc2WbANrqhzNqX+5pPq0ciorBisPVVvEtx9X9gwMAO4iKd05PEa4g7aJYiwyiLmAYN64w0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtVFWEHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C7C116C6;
	Mon, 19 Jan 2026 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768834415;
	bh=n+spNRVO7mggUSyXYANfNjHawunxAXxcGIdjXfqsl7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtVFWEHn8Ae/H06PsnUEwF8yM/epnmqqG9UKN4t9CbaUh0um+u8jctunc5pJs4kmT
	 w8WjtjNyzHeAMfDIzPwDRswwi/23teHxS4cS4qy4YF8Ju6hgPtspuDt0XHO19pJexc
	 K70mhCApQEPeQ9/2W8LlrWgnq1YPmbzJ7tO0B+oGaV2WE+ODBi1CZ9QzeL9Lqhf1D8
	 dCDniHETnXaYzD3fxvZrr4EFOz86MB23pOz4gcgiMn8mCBGWnB/HX62iCYi7WYZ7eo
	 cnitEuGQx/bcQ0aLJtm8n6eF8J7HZCxsZcFBQM50FTeFFH0NhseMr0QuQ+kl0iDHBK
	 qllCK6VkH/E9g==
Date: Mon, 19 Jan 2026 14:53:30 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, bbhushan2@marvell.com
Subject: Re: [net-next 1/2] octeontx2-af:  Mailbox handlers to fetch DMAC
 filter drop counter
Message-ID: <aW5FagLp_SCH-tqQ@horms.kernel.org>
References: <20260114065743.2162706-1-hkelam@marvell.com>
 <20260114065743.2162706-2-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114065743.2162706-2-hkelam@marvell.com>

On Wed, Jan 14, 2026 at 12:27:42PM +0530, Hariprasad Kelam wrote:
> Both CGX/RPM mac blocks support DMAC filters. This patch
> adds mbox support to read the counter.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 3abd750a4bd7..aef0087174b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -1352,3 +1352,23 @@ void rvu_mac_reset(struct rvu *rvu, u16 pcifunc)
>  	if (mac_ops->mac_reset(cgxd, lmac, !is_vf(pcifunc)))
>  		dev_err(rvu->dev, "Failed to reset MAC\n");
>  }
> +
> +int rvu_mbox_handler_cgx_get_dmacflt_dropped_pktcnt(struct rvu *rvu,
> +						    struct msg_req *req,
> +						    struct cgx_dmac_filter_drop_cnt *rsp)
> +{
> +	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
> +	struct mac_ops *mac_ops;
> +	u8 cgx_id, lmac_id;
> +	void *cgxd;
> +
> +	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> +	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> +	mac_ops = get_mac_ops(cgxd);

Hi Hariprasad,

Claude Code with Review Prompts [1] flags that get_mac_ops may not
always return a valid ops structure. And that other handlers that
mac_ops guard against this using is_cgx_config_permitted().

I am wondering if that is appropriate here too.

[1] https://github.com/masoncl/review-prompts/

> +
> +	if (!mac_ops->get_dmacflt_dropped_pktcnt)
> +		return 0;
> +
> +	rsp->count =  mac_ops->get_dmacflt_dropped_pktcnt(cgxd, lmac_id);
> +	return 0;
> +}
> -- 
> 2.34.1
> 
> 

