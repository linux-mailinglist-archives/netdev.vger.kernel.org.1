Return-Path: <netdev+bounces-250984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 523CBD39EC0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 07:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2E5E3006720
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABC26FA5B;
	Mon, 19 Jan 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QUsNlBVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="goVa2PNG"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BE7260A;
	Mon, 19 Jan 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804859; cv=none; b=aePf3Mod9VCO0rYtbD+GqLhoYUActUe9+b1TzNPBAWyCSAwK4uBRdIZUOGS5C74hD73m/fZevmwzwZ0Ud9/M1Cy7w+rdcvQFc5dZ+2WTfQBp8/J1hA+J1SLqPmdw17+GTlYx4AzGA6bQ9TDCRFtJ2safNwiXhFI9vuvsMc67r1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804859; c=relaxed/simple;
	bh=tQVlhYJVWlzkt3a0pH8kceM5jDcNTbnYDyCm+wlccHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1x+JlaQ+H6fE/TL6Vr0W3o0SyNv1CVaJUthbxR6aIbxR5ILJ4VjC3W7LqV5Y7ctL6BuCmXyhmvEdcuufZbS+Z8KmNuus5J14xejHYWbg9zm10xWcuNedbJjUmHi6/xp6KHPERDGC3DyXj69JyY7tsUx+vcInQfCwBtrOEucgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QUsNlBVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=goVa2PNG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D5103EC092C;
	Mon, 19 Jan 2026 01:40:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 19 Jan 2026 01:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768804856; x=1768891256; bh=evLdQNqCng
	bOOjz20A0jUiiiWUzlHQOTkesTl/nlPNY=; b=QUsNlBVRT63ABpm0xK18vKZAMQ
	balDfoff3Rqzp9X8tC4NMAt/AyzqXOgrAsziEtXetJhHb/AK6UD/Dx6D+Vnaz5nh
	OrtqMl83LidBPHCmk6GKiJpO8qr8/ultEPHDbrapmdin1eZxzVZBDdIAmJ6V/0lt
	4WPN9agG7fNpdwUcOquRwdtLAMyAgXs8RiADTkIIoQdIlftaMxhL/IABmFiiGaIQ
	nJTmLB8ZqzQT4nPirOv9wjC9FjnT3uwzoHPcsKZzcXjfdhrYj6lSh7ZyX0ILcFIU
	61v85qEV1LS8Piuha2EcVxuVR6TohDs2rehPHJ25pZnySX11FRCDXN/ZPwzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768804856; x=1768891256; bh=evLdQNqCngbOOjz20A0jUiiiWUzlHQOTkes
	Tl/nlPNY=; b=goVa2PNGkl3PWKm8NN0r13ebLUBPancIe5g9GGDlG2+jWYkB5Ga
	Ce0VfS6AcIHLIOrsIoW7kdGamHZoQ5wWBsJaLExSeQi5gRHC12DyxxCWfA/xD/SR
	R87+syHnRV3KvwtMfe7khOrjrEnbdvavORpJw0M1klOG1dqEfPRUTRvsZJVXgXg1
	ZZDaqjzze0MP0Apnob2KXsOnNinbEUndLPXBVaX5v355pmrIr+9tedeDrLzKlqN1
	79uqjcyL7UsxCgI0hrRyljzbphRbUK1dmJEkM/Mnlvge7pRcr9JBL3jmwR8gv6LV
	MXzWqPcWMqYzxKSY/rnonkXOidpHH7/Lb6A==
X-ME-Sender: <xms:-NFtacqjSs-4HC02qN_xGvlT4jfUAnY3AdWE7cVQYc6U-_G_BNyfUw>
    <xme:-NFtaanvHYBpMQSvcdn4sNQtcW-pFB3ll_nDps2fMsY4mq9copQF8FS7_07VlR4Yn
    bvHwnCylMcUJEsgaJSXCagNc1oqL_92BWfEEWiFtPNbYsqeNw>
X-ME-Received: <xmr:-NFtaYbqggV4Pcxy4AG96cjSsMxVyIv5CtaP74XsvpyFbX2oMTgYa5f6xzfl4vB8fB8b78ZzwojALC7QOlri4rGpJwRu8t_N5jj8sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeikeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehinhhshigvlhhusehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtth
    hopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhhitggpshif
    shgusehrvggrlhhtvghkrdgtohhmpdhrtghpthhtohepthhifigrihesshhushgvrdguvg
    dprhgtphhtthhopehhrgihvghsfigrnhhgsehrvggrlhhtvghkrdgtohhmpdhrtghpthht
    oheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-NFtaaWc3XMLV8zrY1mcEHg9sxFqbzvbKZU-A9R7gqOzHT3NJFPQjQ>
    <xmx:-NFtaYBCI6Ch-cYabybjhUX_xffb_sTUIAd6DTHCH90KANpJAqHsFg>
    <xmx:-NFtaZyIeE_61-DEk9uLWoCncKEJIae7n73CEva4dSrk5L9g4K85BQ>
    <xmx:-NFtaeZGPXOYPKXZh8e8sWbkq98y7DQynR82W1sS8PUSUR2bxhPOSA>
    <xmx:-NFtaaBv0FXBDU3y19XiygBDpCWf21pAmDVVCmWENpGnKq_rmS6d_RQY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:40:56 -0500 (EST)
Date: Mon, 19 Jan 2026 07:40:52 +0100
From: Greg KH <greg@kroah.com>
To: insyelu <insyelu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, nic_swsd@realtek.com,
	tiwai@suse.de, hayeswang@realtek.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Message-ID: <2026011928-eggbeater-manhunt-d3a1@gregkh>
References: <20260119022802.3705-1-insyelu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119022802.3705-1-insyelu@gmail.com>

On Mon, Jan 19, 2026 at 10:28:02AM +0800, insyelu wrote:
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
> 
> This patch updates the trans_start timestamp of the transmit queue
> on every asynchronous USB URB submission along the transmit path,
> ensuring that the network watchdog accurately reflects ongoing
> transmission activity.
> 
> Signed-off-by: insyelu <insyelu@gmail.com>
> ---
> v2: Update the transmit timestamp when submitting the USB URB.
> ---
>  drivers/net/usb/r8152.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index fa5192583860..880b59ed5422 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
>  	ret = usb_submit_urb(agg->urb, GFP_ATOMIC);
>  	if (ret < 0)
>  		usb_autopm_put_interface_async(tp->intf);
> +	else
> +		netif_trans_update(tp->netdev);
>  
>  out_tx_fill:
>  	return ret;
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

