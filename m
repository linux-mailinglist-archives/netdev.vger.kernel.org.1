Return-Path: <netdev+bounces-120510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9A959A95
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F071F216A0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347AB1A4AB8;
	Wed, 21 Aug 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4u2/6oM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABA14C5BD;
	Wed, 21 Aug 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239674; cv=none; b=dN9CL56kEzslSENt9xZ4elb7fHrGqGFtx3ajIY9FkOBHsz+zfBwLbXH7x3k1EQKp0ELwtBFYcpX6zCDmFHE+UTgp021Qn3Z2QrUxJn9G0G4lK3Ak0UTcBbnYZMFJySFzEQeELt4Mc1LgLHkoRQG/zSW3WNjKVCJTFfRMJb8FW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239674; c=relaxed/simple;
	bh=B/Yqf661OpefJ+5m/Zlzn8b5CARyVavHgTOFURnqlf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko2o8kCf7H2x6iGgqj1wZjfh0eiZZpttXJONX0tFqWoURuFA5DhUHocJoSdCnjqmkuoxAUL+CVL8FhgXe7yfG/sgenqAAT3saVcprLvQCB6ogsnosfkA4EztY2vtAWWBZYPHAdg0jPTyWWfZmNBU+OXZxShlu/i9W5t+DjYl4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4u2/6oM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF965C4AF0C;
	Wed, 21 Aug 2024 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239673;
	bh=B/Yqf661OpefJ+5m/Zlzn8b5CARyVavHgTOFURnqlf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N4u2/6oMQoydd77g5/Es/i0CE9m6gPHXQ/9/ue9t8JGAygO/2xf6BKfYdqU0LaYeF
	 3zkKMs87AGj4fsmMnl4KrmNW1K5PNU2GAw8TDICo+z9rDe2wOUPrZ67w3Bvfv1JW5y
	 xfjwERohP1WtJXl/9udHigQGWJTetw9xkM9wijeiC5MlbolI+62MRAroSU7yJ3KA74
	 hEdFlylfVYflcsB2vIY0rr7W0T2IbsG7cI6dNFTt+YPnyZo2KAWbKfQ2g0za5DjYlu
	 wVH4dHWv+VhmhR4AjkwcGWxmOtUnJx5Axwh2yXifGvUF929Kg5+HZIALcFNkLnrb0Q
	 0ryA4eVqUDxHA==
Message-ID: <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
Date: Wed, 21 Aug 2024 14:27:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Jan Kiszka <jan.kiszka@siemens.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240813074233.2473876-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13/08/2024 10:42, MD Danish Anwar wrote:
> IEP1 is needed by firmware to enable FDB learning and FDB ageing.

Required by which firmware?

Does dual-emac firmware need this?

> Always enable IEP1
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 53a3e44b99a2..613bd8de6eb8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1256,12 +1256,8 @@ static int prueth_probe(struct platform_device *pdev)
>  		goto put_iep0;
>  	}
>  
> -	if (prueth->pdata.quirk_10m_link_issue) {
> -		/* Enable IEP1 for FW in 64bit mode as W/A for 10M FD link detect issue under TX
> -		 * traffic.
> -		 */
> -		icss_iep_init_fw(prueth->iep1);
> -	}
> +	/* Enable IEP1 for FW as it's needed by FW for FDB Learning and FDB ageing */
> +	icss_iep_init_fw(prueth->iep1);
>  
>  	/* setup netdev interfaces */
>  	if (eth0_node) {
> @@ -1366,8 +1362,7 @@ static int prueth_probe(struct platform_device *pdev)
>  	}
>  
>  exit_iep:
> -	if (prueth->pdata.quirk_10m_link_issue)
> -		icss_iep_exit_fw(prueth->iep1);
> +	icss_iep_exit_fw(prueth->iep1);
>  	icss_iep_put(prueth->iep1);
>  
>  put_iep0:
> @@ -1424,8 +1419,7 @@ static void prueth_remove(struct platform_device *pdev)
>  		prueth_netdev_exit(prueth, eth_node);
>  	}
>  
> -	if (prueth->pdata.quirk_10m_link_issue)
> -		icss_iep_exit_fw(prueth->iep1);
> +	icss_iep_exit_fw(prueth->iep1);
>  
>  	icss_iep_put(prueth->iep1);
>  	icss_iep_put(prueth->iep0);

-- 
cheers,
-roger

