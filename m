Return-Path: <netdev+bounces-159228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFDA14D94
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C57188A1C7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742351FBE83;
	Fri, 17 Jan 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwP21x1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC371750;
	Fri, 17 Jan 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109765; cv=none; b=QZnDQHEDooSjOd8oNHdgyjrOkalL3ebJk82Yq3UWdjG9VRpMghZZwawTQvGu/TMG/mVdGrGcTB4xGvaw+fxocaEd91w2Sp4LEBMrgENehOEuOErezsUMYm7Qd8hT1JHEIvhWC9DPJS3ZgTEKwzTRZmpKeGBNRPSsCcB2hdEih+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109765; c=relaxed/simple;
	bh=JNzqAZZqEzq9uR3/LQF+i2F9/22rGZ9S7RZnrC6/MOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CACgrnkFvsKVjmCLj1yuxrMiywQVgsJ+iZq/2eDczBLGtH+kRydaE5gJtlTbTx9wwtXesbxjQ/nnU+e3VRQweyoang7EbG+Sv9rIL70f+HUB+24bX0sq+UCX4nCPm2GaAiuaoZVRDe/oS/zsTaxqOaNYj3AQIUcIM9JpaQOBeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwP21x1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5007C4CEDD;
	Fri, 17 Jan 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737109764;
	bh=JNzqAZZqEzq9uR3/LQF+i2F9/22rGZ9S7RZnrC6/MOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwP21x1pl7/hIEaaESXfRFKhFY0/tCsJ/2vSg0V80YL8GIQST6Rm2i9TDCX5+Bzlm
	 1ptK7myqUlyU1y/tHYZcf37yhP7aTaaQ2JKejYhTVbzAtv3P5kvItvlws4pw9ZOJth
	 pxEaQLChb7/Xyvsoz7wq6c715z4Vl7fcHlfOT9jVUsxdJQYUae91YKFILDYXL5n3Vj
	 zUXGRCrvTkKXf31TCb3juBuYn/CdUfDS4AE0L+pVANX+A0kFRAC4PLYq0Lr4e5I06H
	 w3aDemXTAvj4NClvXfdA3tfuOoEYBlsWimFA2NI3hPnhDl6KUlm9jTRKFmpuOJ8p9D
	 VjBfRuREDTpcQ==
Date: Fri, 17 Jan 2025 10:29:20 +0000
From: Simon Horman <horms@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: bh74.an@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sxgbe: change conditional statement from
 if to switch
Message-ID: <20250117102920.GI6206@kernel.org>
References: <20250116160314.23873-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116160314.23873-1-aha310510@gmail.com>

On Fri, Jan 17, 2025 at 01:03:14AM +0900, Jeongjun Park wrote:
> Change the if conditional statement in sxgbe_rx_ctxt_wbstatus() to a switch
> conditional statement to improve readability, and also add processing for
> cases where all conditions are not satisfied.
> 
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  .../net/ethernet/samsung/sxgbe/sxgbe_desc.c   | 43 +++++++++++++------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> index b33ebf2dca47..5e69ab8a4b90 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> @@ -421,31 +421,48 @@ static void sxgbe_rx_ctxt_wbstatus(struct sxgbe_rx_ctxt_desc *p,

...

> +	default:
> +		pr_err("Invalid PTP Message type\n");
> +		break;
> +	}
>  }

Hi Jeongjun,

I was wondering if it would be best if the error message above should be
rate limited, or perhaps the callback enhanced to return an error in such
cases. But that depends on where sxgbe_rx_ctxt_wbstatus is called.
And I'm unable to find where the it called.

I see that sxgbe_rx_ctxt_wbstatus is registered as a get_rx_ctxt_tstamp_status
callback. But is the get_rx_ctxt_tstamp_status callback called anywhere?

