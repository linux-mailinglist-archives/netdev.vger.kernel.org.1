Return-Path: <netdev+bounces-177185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D9A6E359
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC82D3A9476
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3319E965;
	Mon, 24 Mar 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0rN0Vkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27D19E7D1
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844079; cv=none; b=kc0p+gaSlDRugs8WnvGxHsjlHT73e0dhGAeJdMr+zUTNVRf02SGkHFmM4aN/5PS86UzuSv6TUtwEDLFmMAXN8B/kv/VX9bfKAZxuqt8QMBsXpr9pWPXL0rjpUSS8qnHZJb5K88pqxupjiFurMsUVtMcO1FmNsqEb76VwEm293l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844079; c=relaxed/simple;
	bh=Ofk1jSM0bn3G9jXVh8tNjIg0H43S7TCTFpo31E9PBx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojZoI87XmsM73PcnahVGnuDGHP8Sktl61kZuPN+ChvrQaCXc1xGEyyS4zLiIUL3v9ndNlbtzjjq2BflQEcM1vWjc/IQcNbJqIAtL364gDt5++rkSfpriJE0ZKMkJxj2Kl7KhiXiR3L2dWZSyny/ieKxyTmUYH83wms1Q8/dueiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0rN0Vkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A909C4CEE4;
	Mon, 24 Mar 2025 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844079;
	bh=Ofk1jSM0bn3G9jXVh8tNjIg0H43S7TCTFpo31E9PBx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0rN0Vkc6swYdz+Sm7LuqbyN4BYEgF+9hLHgeuNT7THhJerIPqxcddtADp/+YePZ2
	 DhA9TmeaG6MYE32XPpf/saBsCwjcpJMp9JjwudCyO/LGhQAr0hLtyqcCB25BwudCw+
	 wCb7Bo68vUNPHk6NqGv8bljhH2gKc+5xiCvBllVHe0tOUjsqSCeHND294/t/J+Exd4
	 usWdf+BQl1y46oCBHX64AMTTQmT2mjwDyWBbfBPOgwuVi2iRNF4xbJDv2DORo0X0w3
	 V+MDfZiPf/mfV9PoMPYMpv4lZTOEZGV5T0uGeUSJ/CU+8RZObDpId44qZ81xdysku+
	 BAIUU7L85uOog==
Date: Mon, 24 Mar 2025 19:21:16 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 5/6] net: ngbe: add sriov function
 support
Message-ID: <20250324192116.GK892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <9B4D34D65A81485C+20250324020033.36225-6-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B4D34D65A81485C+20250324020033.36225-6-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:32AM +0800, Mengyuan Lou wrote:
> Add sriov_configure for driver ops.
> Add mailbox handler wx_msg_task for ngbe in
> the interrupt handler.
> Add the notification flow when the vfs exist.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

...

> @@ -200,12 +206,10 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
> +static irqreturn_t ngbe_msix_common(struct wx *wx, u32 eicr)
>  {
> -	struct wx *wx = data;
> -	u32 eicr;
> -
> -	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
> +		wx_msg_task(wx);
>  
>  	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
>  		wx_ptp_check_pps_event(wx);
> @@ -217,6 +221,35 @@ static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
> +{
> +	struct wx *wx = data;
> +	u32 eicr;
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +
> +	return ngbe_msix_common(wx, eicr);
> +}
> +
> +static irqreturn_t ngbe_msic_and_queue(int __always_unused irq, void *data)
> +{
> +	struct wx_q_vector *q_vector;
> +	struct wx *wx = data;
> +	u32 eicr;
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +	if (!eicr) {
> +		/* queue */
> +		q_vector = wx->q_vector[0];
> +		napi_schedule_irqoff(&q_vector->napi);
> +		if (netif_running(wx->netdev))
> +			ngbe_irq_enable(wx, true);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return ngbe_msix_common(wx, eicr);
> +}
> +
>  /**
>   * ngbe_request_msix_irqs - Initialize MSI-X interrupts
>   * @wx: board private structure
> @@ -249,8 +282,16 @@ static int ngbe_request_msix_irqs(struct wx *wx)
>  		}
>  	}
>  
> -	err = request_irq(wx->msix_entry->vector,
> -			  ngbe_msix_other, 0, netdev->name, wx);
> +	/* Due to hardware design, when num_vfs < 7, pf can use 0 for misc and 1
> +	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
> +	 * Misc and queue should reuse interrupt vector[0].
> +	 */
> +	if (wx->num_vfs == 7)
> +		err = request_irq(wx->msix_entry->vector,
> +				  ngbe_msic_and_queue, 0, netdev->name, wx);
> +	else
> +		err = request_irq(wx->msix_entry->vector,
> +				  ngbe_msix_other, 0, netdev->name, wx);

Sorry for the late review. It has been a busy time.

I have been thinking about the IRQ handler registration above in the
context of the feedback from Jakub on v7:

	"Do you have proper synchronization in place to make sure IRQs
         don't get mis-routed when SR-IOV is enabled?
         The goal should be to make sure the right handler is register
         for the IRQ, or at least do the muxing earlier in a safe fashion.
         Not decide that it was a packet IRQ half way thru a function called
         ngbe_msix_other"

	Link: https://lore.kernel.org/all/20250211140652.6f1a2aa9@kernel.org/

My understanding is that is that:

* In the case where num_vfs < 7, vector 1 is used by the pf for
  "queue". But when num_vfs == 7 (the maximum value), vector 1 is used
  by the VF6.

* Correspondingly, when num_vfs < 7 vector 0 is only used for
  "misc". While when num_vfs == 7 is used for both "misc" and "queue".

* The code registration above is about vector 0 (while other vectors are
  registered in the code just above this hunk).

* ngbe_msix_other only handles "misc" interrupts, while

* ngbe_msic_and_queue demuxes "misc" and "queue" interrupts
  (without evaluating num_vfs), handling "queue" interrupts inline
  and using a helper function, which is also used by ngbe_msix_other,
  to handle "misc" interrupts.

If so, I believe this addresses Jakub's concerns.

And given that we are at v9 and the last feedback of substance was the
above comment from Jakub, I think this looks good.

Reviewed-by: Simon Horman <horms@kernel.org>

But I would like to say that there could be some follow-up to align
the comment and the names of the handlers:

* "other" seems to be used as a synonym for "misc".
  Perhaps ngbe_msix_misc() ?
* "common" seems to only process "misc" interrupts.
  Perhaps __ngbe_msix_misc() ?
* msic seems to be a misspelling of misc.

>  
>  	if (err) {
>  		wx_err(wx, "request_irq for msix_other failed: %d\n", err);

...

