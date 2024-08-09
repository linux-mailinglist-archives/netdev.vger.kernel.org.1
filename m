Return-Path: <netdev+bounces-117153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0A94CE68
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A97B283140
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A718C906;
	Fri,  9 Aug 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luUztuZJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54F17BBF;
	Fri,  9 Aug 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198577; cv=none; b=QY4A94h2GbZM1F+eWLv1egQcXCH7wWaVemJfr+LuteslNkXELLtP31XIosbIQUyzKHkj9cH5OlGP/e1w7ovpRmBbtxEMi5YoG95bicMfWDXam7LruWmu1JSiproBSIDWI6fWbSDM8pMUfPKJju6+TNvPVW15aKY1B9UtASwXZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198577; c=relaxed/simple;
	bh=/4yHL3Ff4I9Wn8sXPTVtpcTghEGf/AxD7mHtkI/OQ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpUGArLIuDrGF1U1BvvEVbXpFoEc+DHJ2KSWm8felH7fTHJK2gI3eDLLVjWnvp59aczvqAk234u7UwnEK4MCuJYrypyDOtxnE4l6JMcByDq9KW4bqHlLVj+777y272/18khnZl8Mc68BuROrnqTGiqPrfNrcaqAwWF6KnKHHW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luUztuZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9417AC32782;
	Fri,  9 Aug 2024 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723198576;
	bh=/4yHL3Ff4I9Wn8sXPTVtpcTghEGf/AxD7mHtkI/OQ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luUztuZJa9RA4bGErPWjmMzxsmrns1HYkDToPYOq5QtSsL5x8i7IxEBREP54bF9/v
	 DX0CWKoR8NyYSrbxOr6aZnPUKyHqFO3XZK05tC3QBMQt6CyPk87zFFzizDn3T1cpz2
	 dxdsj66AdNwf0C2U6qB2CKwDqTnW7LLjCvk1Df1lXUA3UGAzz4T6bXUl2Sl+hqHeKk
	 /cp/yysCsfc4A0Ct9jz5ZzMOwDVQaRcDJipLqDIbVeDMX6hMdIFTXqCzz5eWAErOdA
	 Sm7R7A0f+U1MrDM7uFQZNhOv/9AC4fhrKpRDwgtdCGxja7WUPfsQxMIJkYhk8oQlGM
	 L39lABwggcqeA==
Date: Fri, 9 Aug 2024 11:16:12 +0100
From: Simon Horman <horms@kernel.org>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Georgi Valkov <gvalkov@gmail.com>, Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] usbnet: ipheth: remove extraneous rx URB
 length check
Message-ID: <20240809101612.GJ3075665@kernel.org>
References: <20240806172809.675044-1-forst@pen.gy>
 <20240806172809.675044-2-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806172809.675044-2-forst@pen.gy>

On Tue, Aug 06, 2024 at 07:28:06PM +0200, Foster Snowhill wrote:
> Rx URB length was already checked in ipheth_rcvbulk_callback_legacy()
> and ipheth_rcvbulk_callback_ncm(), depending on the current mode.
> The check in ipheth_rcvbulk_callback() was thus mostly a duplicate.
> 
> The only place in ipheth_rcvbulk_callback() where we care about the URB
> length is for the initial control frame. These frames are always 4 bytes
> long. This has been checked as far back as iOS 4.2.1 on iPhone 3G.
> 
> Remove the extraneous URB length check. For control frames, check for
> the specific 4-byte length instead.

Hi Foster,

I am slightly concerned what happens if a frame that does not match the
slightly stricter check in this patch, is now passed to
dev->rcvbulk_callback().

I see that observations have been made that this does not happen.  But is
there no was to inject malicious packets, or for something to malfunction?

> 
> Signed-off-by: Foster Snowhill <forst@pen.gy>
> Tested-by: Georgi Valkov <gvalkov@gmail.com>
> ---
>  drivers/net/usb/ipheth.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
> index 6eeef10edada..017255615508 100644
> --- a/drivers/net/usb/ipheth.c
> +++ b/drivers/net/usb/ipheth.c
> @@ -286,11 +286,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
>  		return;
>  	}
>  
> -	if (urb->actual_length <= IPHETH_IP_ALIGN) {
> -		dev->net->stats.rx_length_errors++;
> -		return;
> -	}
> -
>  	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
>  	 * but rather are control frames. Their purpose is not documented, and
>  	 * they don't affect driver functionality, okay to drop them.
> @@ -298,7 +293,8 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
>  	 * URB received from the bulk IN endpoint.
>  	 */
>  	if (unlikely
> -		(((char *)urb->transfer_buffer)[0] == 0 &&
> +		(urb->actual_length == 4 &&
> +		 ((char *)urb->transfer_buffer)[0] == 0 &&
>  		 ((char *)urb->transfer_buffer)[1] == 1))
>  		goto rx_submit;
>  
> -- 
> 2.45.1
> 
> 

