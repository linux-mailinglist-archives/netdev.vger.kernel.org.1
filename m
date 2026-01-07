Return-Path: <netdev+bounces-247812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14FECFEC3E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B278130019DD
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E538B996;
	Wed,  7 Jan 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atRHehhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A33A981A;
	Wed,  7 Jan 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801323; cv=none; b=nJNFEtNm966DxEW38q2mgadqQekFrltJvuDRD+c2R2Ri5JTsTpV31338rLy7g2ZtIhZRPMXF3Af/OR9jL9XwzqpHh7ve7UsYCDU+fp07NIqYtB+OPXr4BeSj+m8204NhhXuSxd456NorIcLDMA47kw5n8Aqn4HBlMGEhQxrwkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801323; c=relaxed/simple;
	bh=kYVwO3rYvaj9FbefwMJ9YShwPb9d1RsDG3k8NGmOwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2L0+KnblnbyHCliERPfEt/bKNyhJQwRerM0hlKpTWLe0WflN+wImEZ05DjLkjeDcuFC3t15iGeJroAPbGV7BjvaXuTSBchBBczDzgkmfxrhlI6wj/pqUFH9Z6c4oMBNJFDwjsmUISTd9+H/gFKjbjHsrGqw6KNvtyLElt1LJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atRHehhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE47C4CEF1;
	Wed,  7 Jan 2026 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801321;
	bh=kYVwO3rYvaj9FbefwMJ9YShwPb9d1RsDG3k8NGmOwBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atRHehhyJpnBldSqmxhxLHSYnEqjnhYnG+rxBy6VF2QvfzR1B7GxWBiDIF2+nJsOb
	 B6mhe/nJ0SHuMiKBgH1cvXMIbaJOD4NyLPIKHbnBDez2HTc0AEe/A0IvBzYJHbpIhl
	 z5sKmwFaFyKqPaU9bxFlknevQc9J0JIVamfm8lAFMP/XGFuozNkTJjHhPkWrVJZ8V6
	 hlN9QtJP91XRQg0sj6CSLLccDd6+cq5OP+Cl6Vy5FExDjQ/VeD0idijLvw1bOe+Gk6
	 OJvubP5JeQN7YBa+Gcb5yYjv9TbSuNV1a8B8F5sYeIxnkAKEHm6Ofd7t9QfwjsWqmK
	 TCDO/teg7edng==
Date: Wed, 7 Jan 2026 15:55:17 +0000
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 04/15] net: ftgmac100: Use devm_alloc_etherdev()
Message-ID: <20260107155517.GC345651@kernel.org>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260105-ftgmac-cleanup-v1-4-b68e4a3d8fbe@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-ftgmac-cleanup-v1-4-b68e4a3d8fbe@aspeedtech.com>

On Mon, Jan 05, 2026 at 03:08:50PM +0800, Jacky Chou wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Make use of devm_alloc_etherdev() to simplify cleanup.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index f07167cabf39..75c7ab43e7e9 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1877,10 +1877,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	/* setup net_device */
> -	netdev = alloc_etherdev(sizeof(*priv));
> +	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
>  	if (!netdev) {
> -		err = -ENOMEM;
> -		goto err_alloc_etherdev;
> +		return -ENOMEM;
>  	}

nit: There is no longer any need for {} here.

...

