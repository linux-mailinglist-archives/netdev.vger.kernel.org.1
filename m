Return-Path: <netdev+bounces-177698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C6A714E7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D953B55B5
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D811B6D08;
	Wed, 26 Mar 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ7lfIc+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31C1B4242
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985078; cv=none; b=ZXgyyEOXu8v2Ba/mt5L/H2bkh34jQI4dFA+w4p86KQN/W1Srv92X+ghi4diG6UFo3yXHyz4ZKR5/E5XStardrElz3EU50XZNCbmqMM0vkOkxiX/+5XaCfYs7UNaR29CmcqdcU4mIXH0cnHYHOTNMjmmbmtVRkmK31k/lgahPpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985078; c=relaxed/simple;
	bh=mcWknBaxHnJ1w82lH1q/4q2+Roef2sO9EGG2NfMjQEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwUs4Bg8cKR5VyG8S+nK97qs+FCrzI+p2rGnhigYseCJjzOmYe0okQ80Um+d6vgort9Cwzm/E1TfW1myfvc+Xn2kEfeb+stl80ieHAl3YytbpnKkh/fl46fvwHiZZ6IRe2zjsNJ9fPFjkF9RGuiqWB+KAXbcAOq+6Z5+Z9mD0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ7lfIc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA817C4CEEA;
	Wed, 26 Mar 2025 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742985077;
	bh=mcWknBaxHnJ1w82lH1q/4q2+Roef2sO9EGG2NfMjQEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ7lfIc+fN5CwKQcGccQ2RR2atX6iOXqb0DMHv49ONHMOmeogf9fpylmG6PMoDMX4
	 yAiH0GBI6EwcxjVcolO1QMkS8N/Z2jsBMu+1PebdnwAWsiJrlDfxt7XPPBiWhSC2GU
	 rbXWuwQKlzSV58Ny05TG+ddcR91RazTDDhcLtgiExzhiA/qmBfh+MmkZb7fqCYH8rV
	 NpmT8WlUmoad47b0vY4V0m1bCguPyd0tql376i54CHdR1V+Qxk3zGBhSw1TwXUx+Zw
	 joCfcQcgA5SMLM9IRC9mn3SyQQVaKAy8WLDHCteWaUdamdgQrflp7kz1TgcWl41ZT8
	 sIJuVN7Hzt/0w==
Date: Wed, 26 Mar 2025 10:31:11 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
	geert@linux-m68k.org
Subject: Re: [PATCH net-next v9 14/14] xsc: add ndo_get_stats64
Message-ID: <20250326103111.GC892515@horms.kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
 <20250318151522.1376756-15-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151522.1376756-15-tianx@yunsilicon.com>

On Tue, Mar 18, 2025 at 11:15:24PM +0800, Xin Tian wrote:

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c

...

> @@ -1912,14 +1931,20 @@ static int xsc_eth_probe(struct auxiliary_device *adev,
>  		goto err_nic_cleanup;
>  	}
>  
> +	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
> +	if (!adapter->stats)

Hi Xin Tian,

I think you need to set err to -ENOMEM here, else the function will return 0
even though a memory allocation error has occurred.

Flagged by Smatch (please consider running this tool on your patches).

> +		goto err_detach;
> +
>  	err = register_netdev(netdev);
>  	if (err) {
>  		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
> -		goto err_detach;
> +		goto err_free_stats;
>  	}
>  
>  	return 0;
>  
> +err_free_stats:
> +	kvfree(adapter->stats);
>  err_detach:
>  	xsc_eth_detach(xdev, adapter);
>  err_nic_cleanup:

...

