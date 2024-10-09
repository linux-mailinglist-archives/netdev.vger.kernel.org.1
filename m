Return-Path: <netdev+bounces-133462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024F996050
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3781C1F22F59
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA317A584;
	Wed,  9 Oct 2024 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR8SVwC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C8154BEE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457600; cv=none; b=t7e2g3JBUaQlLrMhKDVzhJ2sFzubb8BjRigIcnaa31ROIvfwqpKJaNyXLflaKH+Id+pV9rsjQGNP9Jew32Rk8nuQ6RbiDh1vLlrzATNOGL549iici+rcj/pZ9EAZC6MC2jjeskq6ENksdB9LPvP2WnsS/ZiW7/j3JdyEcIjhrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457600; c=relaxed/simple;
	bh=2PFZc2FVq4xCINxf48pAkG1NV4NqnK/IrZpYg6fCBSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+4nfH9xiKzUE6Xx6rBon5IvLyNwrsd5Rp/le4pWqT8fNQTvZRObi+9LyiW13DfXKNSyBQMRAOEniYI11RE4keBRQ7OJMebkVP6YNiHkj/k+rkQjQxwwPoJN2B6QCXCDLaWQyW4dg9F+jBwO70mif4AN0az2yGxQm6Ayn+m6gcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR8SVwC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EBCC4CEC5;
	Wed,  9 Oct 2024 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728457600;
	bh=2PFZc2FVq4xCINxf48pAkG1NV4NqnK/IrZpYg6fCBSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR8SVwC+Irs/9n9866eZfQwqDMtdVeEH/l9yC3x6fpKwtFFzrMwtEQSrHwWCQCAcZ
	 ACTujtiECmPRW8UroUgtZQJG8lx6m7x9ZGLfc+PiJrlsr1rlCvymL3dQvj6F+ZYqYO
	 YC7SzU8qa+mFmW7rFzsGJNW7VY1UpBsxuvA/qmEymKk643F+RyIF5Z/J4d/sviYx85
	 fLPDvlSBDRYwutbYgNcIWznVOc+kZhsEPxgxbZpWpw88WsWmCFUtxNhFo/ewia7myG
	 IuH0gDwVFN+VDLjvTnvUCCQTSP+GX8NZOwRVU2bjjw4EyKuQ+UzVL6ShKave/KTgAH
	 SXxefklS3/QlQ==
Date: Wed, 9 Oct 2024 08:06:37 +0100
From: Simon Horman <horms@kernel.org>
To: tao <wangtaowt166@163.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org
Subject: Re: [RFC] ptp: Delete invalided timestamp event queue code
Message-ID: <20241009070637.GF99782@kernel.org>
References: <20241007152502.387840-1-wangtaowt166@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007152502.387840-1-wangtaowt166@163.com>

On Mon, Oct 07, 2024 at 11:25:02PM +0800, tao wrote:
> used timestamp event queue In ptp_open func,  queue of ptp_clock_register
>  already invalid so delete it
> 
> Signed-off-by: tao <wangtaowt166@163.com>
> ---
>  drivers/ptp/ptp_clock.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index c56cd0f63909..9be8136cb64c 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -235,7 +235,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  				     struct device *parent)
>  {
>  	struct ptp_clock *ptp;
> -	struct timestamp_event_queue *queue = NULL;
>  	int err, index, major = MAJOR(ptp_devt);
>  	char debugfsname[16];
>  	size_t size;
> @@ -260,20 +259,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	ptp->devid = MKDEV(major, index);
>  	ptp->index = index;
>  	INIT_LIST_HEAD(&ptp->tsevqs);
> -	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> -	if (!queue) {
> -		err = -ENOMEM;
> -		goto no_memory_queue;
> -	}
> -	list_add_tail(&queue->qlist, &ptp->tsevqs);

Here the queue is connected to ptp->tseqvs,
as was the case when it was added in

d26ab5a35ad9 ("ptp: Replace timestamp event queue with linked list")

Are you saying that it is no longer used as per that commit?

>  	spin_lock_init(&ptp->tsevqs_lock);
> -	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
> -	if (!queue->mask) {
> -		err = -ENOMEM;
> -		goto no_memory_bitmap;
> -	}
> -	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
> -	spin_lock_init(&queue->lock);
>  	mutex_init(&ptp->pincfg_mux);
>  	mutex_init(&ptp->n_vclocks_mux);
>  	init_waitqueue_head(&ptp->tsev_wq);
> @@ -380,11 +366,6 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  kworker_err:
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
> -	bitmap_free(queue->mask);
> -no_memory_bitmap:
> -	list_del(&queue->qlist);
> -	kfree(queue);
> -no_memory_queue:
>  	xa_erase(&ptp_clocks_map, index);
>  no_slot:
>  	kfree(ptp);
> -- 
> 2.25.1
> 
> 

