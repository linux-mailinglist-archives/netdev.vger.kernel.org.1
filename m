Return-Path: <netdev+bounces-161925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54463A24A46
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82CB165024
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9031C5D4D;
	Sat,  1 Feb 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+yZl/En"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07C85C5E
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426943; cv=none; b=nuoB/slgJR+5Mae4NAjphT2gOvpv9sFFpUJKWll2HnH5aqwVBlDMc2qWnl3pNUtcwPrKjlNRt213C2gk58QV5C14LMrU1faDTx1zkL89aj7FtQUN5eEe/LoSTx78ivy/xUeeCVWEG0SKNDjvep+Ipl885YEWuQmowtHnRSIzcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426943; c=relaxed/simple;
	bh=uANndDBnE/MHPLaU5aZAamrXuROep8ILF+hrdVvGq2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJhOw3Q3Rf5fd8Ao+U8oZb6f/jMNAmCdU5hetrjc2QbK+R72YwDloAXKbFycFGxwG91Mem+YOJj8oJ7zTwqH14IxE4okLxgCYwutgGUzmzCC/kM2L5wSZvPQJEySKt1ui1lNySMuvNdZ5FKiAYCsyRtQh/f2I45yKEaeuIzaDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+yZl/En; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8085eef9-9724-4148-bdfe-2b7e2066997d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738426938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw1Acy/745b49IlGtU0qrEI2pXC8Lu5R01xakLcZU+U=;
	b=b+yZl/EnRIlr3Tz4NtBnQ/T7SW1peL7IIRdrodVyicO5ASQzLH6rPdHqpUKJsgWkIvcjqZ
	NKyJsUo/cdaUNCogzmQqOCqSODebAS3uUuXRcjRj6oUoIflVPWDntKim19kukHao/llS1W
	VpomR5E51kKUifuixVv5sLSDgyEqWZw=
Date: Sat, 1 Feb 2025 16:22:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next] ptp: Add file permission checks on PHC
 chardevs
To: Wojtek Wasko <wwasko@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/01/2025 18:29, Wojtek Wasko wrote:
> Udev sets strict 600 permissions on /dev/ptp* devices, preventing
> unprivileged users from accessing the time [1]. This patch enables
> more granular permissions and allows readonly access to the PTP clocks.
> 
> Add permission checking for ioctls which modify the state of device.
> Notably, require WRITE for polling as it is only used for later reading
> timestamps from the queue (there is no peek support). POSIX clock
> operations (settime, adjtime) are checked in the POSIX layer.
> 
> [1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html
> 
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
> ---
>   drivers/ptp/ptp_chardev.c | 66 +++++++++++++++++++++++++++++++++++----
>   drivers/ptp/ptp_private.h |  5 +++
>   2 files changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index bf6468c56419..5e6f404b9282 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -108,15 +108,22 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>   {
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
> +	struct ptp_private_ctxdata *ctxdata;
>   	struct timestamp_event_queue *queue;
>   	char debugfsname[32];
>   	unsigned long flags;
>   
> +	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
> +	if (!ctxdata)
> +		return -EINVAL;
>   	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> -	if (!queue)
> +	if (!queue) {
> +		kfree(ctxdata);
>   		return -EINVAL;
> +	}

Given that struct ptp_private_ctxdata is quite simple, we can
potentially embed struct timestamp_event_queue into it and avoid
double allocation here?

>   	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
>   	if (!queue->mask) {
> +		kfree(ctxdata);
>   		kfree(queue);
>   		return -EINVAL;
>   	}
> @@ -125,7 +132,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>   	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
>   	list_add_tail(&queue->qlist, &ptp->tsevqs);
>   	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
> -	pccontext->private_clkdata = queue;
> +	ctxdata->queue = queue;
> +	ctxdata->fmode = fmode;
> +	pccontext->private_clkdata = ctxdata;
>   
>   	/* Debugfs contents */
>   	sprintf(debugfsname, "0x%p", queue);
> @@ -142,7 +151,8 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>   
>   int ptp_release(struct posix_clock_context *pccontext)
>   {
> -	struct timestamp_event_queue *queue = pccontext->private_clkdata;
> +	struct ptp_private_ctxdata *ctxdata = pccontext->private_clkdata;
> +	struct timestamp_event_queue *queue = ctxdata->queue;
>   	unsigned long flags;
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
> @@ -154,6 +164,7 @@ int ptp_release(struct posix_clock_context *pccontext)
>   	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
>   	bitmap_free(queue->mask);
>   	kfree(queue);
> +	kfree(ctxdata);
>   	return 0;
>   }
>   
> @@ -167,6 +178,7 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	struct system_device_crosststamp xtstamp;
>   	struct ptp_clock_info *ops = ptp->info;
>   	struct ptp_sys_offset *sysoff = NULL;
> +	struct ptp_private_ctxdata *ctxdata;
>   	struct timestamp_event_queue *tsevq;
>   	struct ptp_system_timestamp sts;
>   	struct ptp_clock_request req;
> @@ -180,7 +192,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
>   		arg = (unsigned long)compat_ptr(arg);
>   
> -	tsevq = pccontext->private_clkdata;
> +	ctxdata = pccontext->private_clkdata;
> +	tsevq = ctxdata->queue;
>   
>   	switch (cmd) {
>   
> @@ -205,6 +218,11 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   
>   	case PTP_EXTTS_REQUEST:
>   	case PTP_EXTTS_REQUEST2:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
> +
>   		memset(&req, 0, sizeof(req));
>   
>   		if (copy_from_user(&req.extts, (void __user *)arg,
> @@ -246,6 +264,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   
>   	case PTP_PEROUT_REQUEST:
>   	case PTP_PEROUT_REQUEST2:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
>   		memset(&req, 0, sizeof(req));
>   
>   		if (copy_from_user(&req.perout, (void __user *)arg,
> @@ -314,6 +336,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   
>   	case PTP_ENABLE_PPS:
>   	case PTP_ENABLE_PPS2:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
>   		memset(&req, 0, sizeof(req));
>   
>   		if (!capable(CAP_SYS_TIME))
> @@ -456,6 +482,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   
>   	case PTP_PIN_SETFUNC:
>   	case PTP_PIN_SETFUNC2:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
>   		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
>   			err = -EFAULT;
>   			break;
> @@ -485,10 +515,18 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
>   		break;
>   
>   	case PTP_MASK_CLEAR_ALL:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
>   		bitmap_clear(tsevq->mask, 0, PTP_MAX_CHANNELS);
>   		break;
>   
>   	case PTP_MASK_EN_SINGLE:
> +		if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +			err = -EACCES;
> +			break;
> +		}
>   		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
>   			err = -EFAULT;
>   			break;
> @@ -516,9 +554,15 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
>   {
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
> +	struct ptp_private_ctxdata *ctxdata;
>   	struct timestamp_event_queue *queue;
>   
> -	queue = pccontext->private_clkdata;
> +	ctxdata = pccontext->private_clkdata;
> +	if (!ctxdata)
> +		return EPOLLERR;
> +	if ((ctxdata->fmode & FMODE_WRITE) == 0)
> +		return EACCES;
> +	queue = ctxdata->queue;
>   	if (!queue)
>   		return EPOLLERR;
>   
> @@ -534,13 +578,23 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>   {
>   	struct ptp_clock *ptp =
>   		container_of(pccontext->clk, struct ptp_clock, clock);
> +	struct ptp_private_ctxdata *ctxdata;
>   	struct timestamp_event_queue *queue;
>   	struct ptp_extts_event *event;
>   	unsigned long flags;
>   	size_t qcnt, i;
>   	int result;
>   
> -	queue = pccontext->private_clkdata;
> +	ctxdata = pccontext->private_clkdata;
> +	if (!ctxdata) {
> +		result = -EINVAL;
> +		goto exit;
> +	}
> +	if ((ctxdata->fmode & FMODE_WRITE) == 0) {
> +		result = -EACCES;
> +		goto exit;
> +	}
> +	queue = ctxdata->queue;
>   	if (!queue) {
>   		result = -EINVAL;
>   		goto exit;
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 18934e28469e..fb4fa5c8c1c7 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -64,6 +64,11 @@ struct ptp_clock {
>   	struct dentry *debugfs_root;
>   };
>   
> +struct ptp_private_ctxdata {
> +	struct timestamp_event_queue *queue;
> +	fmode_t fmode;
> +};
> +
>   #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
>   #define cc_to_vclock(d) container_of((d), struct ptp_vclock, cc)
>   #define dw_to_vclock(d) container_of((d), struct ptp_vclock, refresh_work)


