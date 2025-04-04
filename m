Return-Path: <netdev+bounces-179292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1018AA7BB53
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 13:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5143B76F4
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0D1CCEC8;
	Fri,  4 Apr 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmIpvFwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC52E62A0;
	Fri,  4 Apr 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764786; cv=none; b=RohMo8OJvvOzxHkPOSes5KhkEquITzOxrhCp3HBXJeAB9xS1g2VBs+HPm1gLkHZcsr7V4Xrm/QnvAhJgxRhVl5N9mJW4wOp88io5R74Xdp9/jcTnC3OcbLJl8aHL34Xra7W2esHvwo/Jz8INo/YuOCf4SrTrecIIECKriaJjkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764786; c=relaxed/simple;
	bh=Bdnpcma/og4BEa1wboh85cPY+bwsEOJhpHjHNZRnWko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcUjRHZBTXsQW4Qbb+LfCwLCjPrhlbDahMGcY6bSisJQfVkZFhbItAxtYoD6EkqhgQ1UQYMgdYRazdppbVe2+Xv7uwEmjRzB48FtYdK9TEfHZj+PrLq/iEiRh0Jwc2yITVP6PCV6EVXONkPiI54XfV9kInGvTcVu6hgYLtU8Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmIpvFwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5E2C4CEDD;
	Fri,  4 Apr 2025 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743764785;
	bh=Bdnpcma/og4BEa1wboh85cPY+bwsEOJhpHjHNZRnWko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmIpvFwXuGySAjO4e24DI2MN2Tl5mICt0Rmh8bJmGmvIpdFbwMf4py0I6FhcsrRwv
	 ++Q8BLpI+aq454a1e/m/BEpxZr2Vx9yxViKFk1o7uTPaDjn5S7EW22074ujmWVzSlp
	 AaPFSiou1O9XdbNG4KHtQ8j2ZOMmDM6gqHlTPxGTVn7kXb7XpePvKLL/bqoQOsw0Ne
	 ZFncgQxrT2pSOrAsD4RaDK6pFblEJ0KRXpSl7UjeBBE7vAuM9aOdkV4qSUngs1nu2I
	 9pvDMbHj9QvbCT/nP2EJC/LowuVa5sSe7JTuDUvO7d3Myf2uePuNj5n4TI3R3EQoix
	 5QkWgiLS0iD+Q==
Date: Fri, 4 Apr 2025 12:06:20 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <20250404110620.GG214849@horms.kernel.org>
References: <20250403151303.2280-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151303.2280-1-vulab@iscas.ac.cn>

On Thu, Apr 03, 2025 at 11:13:03PM +0800, Wentao Liang wrote:
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors. A proper
> implementation can be found in cn10k_set_matchall_ipolicer_rate().
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop. Jump to unlock function and return the error code if the
> funciton fails to unmap policer.
> 
> Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..ce58ad61198e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
>  
>  	/* Remove RQ's policer mapping */
>  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> -					   hw->matchall_ipolicer, false);
> +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> +		if (rc)
> +			goto out;

I'm not sure that bailing out is the right thing to do here.
Won't it result in leaked resources?

>  
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
>  
> +out:
>  	mutex_unlock(&pfvf->mbox.lock);
>  	return rc;
>  }
> -- 
> 2.42.0.windows.2
> 
> 

