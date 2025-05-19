Return-Path: <netdev+bounces-191576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79033ABC35C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C1189EF31
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8928642A;
	Mon, 19 May 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evws583b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDF1A38F9
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670317; cv=none; b=hTm2U1NKz5jbEe1ccSe7lqc6xP9WHLdWGQoshi/LxrmUrO1M5sVUySnxPYIvvkPJmVQSYR+ES417vcWNZ+HoEQO5DrQuKOUuBit+4yT9WwpCX6LvPZEzKSo3OdzmfKJ/ujEhOlZS7FzpRfPS52poGRMZzv2yoeHdS/YudYbQPjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670317; c=relaxed/simple;
	bh=eNgA2gV+rahKNRNTWs1BnlhZCdPY+XsquLvrpdwuXlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBk8Yq1JOIo33CdPqD3Szp33jpOLWhaUNJ3BURcDDj62sAMozLmTVhNIzFhf3w2wrRPOcTF6MAZY0kCGn4YFQAquxa1OE+DtNgZLzgMsq6EpDC96iEsvlDYC0093U0dEvGutUWrSXp8V3g4Zb4lIKRiNbC5HkMY/4SZ8h9FaQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evws583b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF8EC4CEE4;
	Mon, 19 May 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670317;
	bh=eNgA2gV+rahKNRNTWs1BnlhZCdPY+XsquLvrpdwuXlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Evws583bUfUaWjHD4W3HVUyQJkjLFnOc/GUXw/GxgkX8P2pBrxqigUd3Jpht6wbI4
	 6DgvZ7dajH/lVReT3ML+PCjXUPjQrcR7UMJB6qw1GdCax0RNAXaYC9b9fRUtr7WRVk
	 Ox/fEZqFiaNn70mTE7eTkz19CDU3nyXI0aXlLT4GmM76V5cYCggHNBOe61INe6BLnx
	 5YHKP5+cl58Z6vF9n6/XI8YiOCBVhjM/9q/xu4z1ySfwFUW/fP1SxsNgcyE3uyg5nu
	 KbotCpIIqRUMD7BBBcqy6660pgOt2XVDirESuaqFiQYmP5WQdlTKxvmzA/3QCA6tjL
	 Mnur53OevsSVA==
Date: Mon, 19 May 2025 16:58:33 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 9/9] net: txgbe: Implement SRIOV for AML devices
Message-ID: <20250519155833.GI365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <CE302004991EAA2C+20250516093220.6044-10-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE302004991EAA2C+20250516093220.6044-10-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:20PM +0800, Jiawen Wu wrote:
> Support to bring VFs link up for AML 25G/10G devices.

Hi Jiawen,

I think this warrants a bit more explanation: what is required for
these devices; and perhaps how that differs from other devices.

> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index 6bcf67bef576..7dbcf41750c1 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -10,6 +10,7 @@
>  #include "../libwx/wx_lib.h"
>  #include "../libwx/wx_ptp.h"
>  #include "../libwx/wx_hw.h"
> +#include "../libwx/wx_sriov.h"
>  #include "txgbe_type.h"
>  #include "txgbe_aml.h"
>  #include "txgbe_hw.h"
> @@ -315,6 +316,8 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
>  	wx->last_rx_ptp_check = jiffies;
>  	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
>  		wx_ptp_reset_cyclecounter(wx);
> +	/* ping all the active vfs to let them know we are going up */
> +	wx_ping_all_vfs_with_link_status(wx, true);
>  }
>  
>  static void txgbe_mac_link_down_aml(struct phylink_config *config,
> @@ -329,6 +332,8 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
>  	wx->speed = SPEED_UNKNOWN;
>  	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
>  		wx_ptp_reset_cyclecounter(wx);
> +	/* ping all the active vfs to let them know we are going down */
> +	wx_ping_all_vfs_with_link_status(wx, false);
>  }
>  
>  static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
> -- 
> 2.48.1
> 

