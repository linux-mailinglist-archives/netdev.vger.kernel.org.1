Return-Path: <netdev+bounces-175421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E6A65BA3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379FB17625B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE91A38E3;
	Mon, 17 Mar 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o94AdjfK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF01CA81;
	Mon, 17 Mar 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234196; cv=none; b=YSy/KUVX9+c55M7Vhq8avEihNkYzAKTrqt023d9A6HotuBIk+Vq15PfJuYCPcFGrxUj6sKXapz0etGFb7jnelKo3SKPN4pSzNyhr9BfsTplw+He4NE2+Q2tTigbVsbZD1LiP200iTs1vvosMkRY5CaXwT2SAUvuWBdCLuxtaz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234196; c=relaxed/simple;
	bh=9CIQEDMqipxZkoDlNbl4r93dgPJcZzoJUDoBfZorCPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAPXc/xcPshWfbXs+5lED4dw6t0yFHVE98t3PLpN4Rq8AdjgX1cilpY65TxaKGL8n8OwzwWVBpA/+JBwcoAyHH9sLiD8ruO5Pb+LayB29l9cwHSKBrONhYI4FEewrlV704uAwpYf/VtRGzs3ofrWnb2Zc8Naxz65bMrIhQysR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o94AdjfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3080EC4CEE3;
	Mon, 17 Mar 2025 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234195;
	bh=9CIQEDMqipxZkoDlNbl4r93dgPJcZzoJUDoBfZorCPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o94AdjfKm1/Yr2/hu0lhVwsra56G8VnN/r+qQPiLLvZMwmDOufoziwHdQZNs7LJ5l
	 IXpIqYmFNIjzVrKQVZKKjYXdtMdgeT21/Hbzi1skeCEBUIN/NeOF8FihS1AJkZLfd3
	 o7BQOEV0OvtsfPTPTlM6jgRraxF4AdmBb/cQRDj1sHs2gVdIofengeUpWJlR18EVe3
	 gqNnkBs1Ut2t4oY+KjJELsb6aoG2+ynFdIex4WMDvXZFhctY4TGaeXWwqt6F5hkKH+
	 a7R6qdLsi5xSBMOFeaejH1FAGjYGYvANqHebGHZvNn5yh9APBvxarEPO8XzFcgUZLO
	 grT79zH5JmxNQ==
Date: Mon, 17 Mar 2025 17:56:32 +0000
From: Simon Horman <horms@kernel.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: isdn@linux-pingi.de, kuba@kernel.org, quic_jjohnson@quicinc.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] isdn: mISDN: Fix typo 'intervall' to 'interval' in
 hfcsusb.c
Message-ID: <20250317175632.GJ688833@kernel.org>
References: <20250311160637.467759-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311160637.467759-1-surajpatil522@gmail.com>

On Tue, Mar 11, 2025 at 04:06:37PM +0000, Suraj Patil wrote:
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
> ---
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
> index e54419a4e731..ebe57c190476 100644
> --- a/drivers/isdn/hardware/mISDN/hfcsusb.c
> +++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
> @@ -1063,7 +1063,7 @@ rx_iso_complete(struct urb *urb)
>  
>  		fill_isoc_urb(urb, fifo->hw->dev, fifo->pipe,
>  			      context_iso_urb->buffer, num_isoc_packets,
> -			      fifo->usb_packet_maxlen, fifo->intervall,
> +			      fifo->usb_packet_maxlen, fifo->interval,

Perhaps it is addressed in patch 1/2 (which i am unable to locate), in
which case the relevant change should be folded into this patch to avoid
breaking bisection. But as this stands, with this patch (only) applied
builds fail because there is no member called interval in struct usb_fifo.

-- 
pw-bot: not-applicable

