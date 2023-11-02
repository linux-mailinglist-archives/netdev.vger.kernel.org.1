Return-Path: <netdev+bounces-45789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1977DF9CB
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15877B20B61
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C421117;
	Thu,  2 Nov 2023 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jcline.org header.i=@jcline.org header.b="mKvxFm0D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2ci7TaD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64436210ED
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 18:17:21 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D919D;
	Thu,  2 Nov 2023 11:17:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1BEC5320093C;
	Thu,  2 Nov 2023 14:16:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 14:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698949016; x=1699035416; bh=cc
	Rdkv2KouFQrXacW6T4fBEpKBx+OWWMqYeM7hOtQhw=; b=mKvxFm0DCr9N84kDn+
	EZWTm5c4Z4j2jEi30p/sjG6MCl2TdBNKldA7SvxfsvDW4Lg/STFFxTcn5T7YormW
	fIQZyiPv0CRhBQ0k4MqZC0CpWl+M2mGzAthc+phgggSLGRWX6pB8JYEGMhqAPBwm
	V86BWApKHKcS4y6L7cNKdrDB9YD8snnt83csswhdicOq1R41V4YSFyOSHANLQ8zd
	jN+hHJKQI//CFD23Jq8w2MCMOnNafXRU6LyoLlYnrXM4l2E9ZSn6kdT1rA/J0slo
	uINX5UPMSyse2Iu6AUJSng3frDaNoCP7dG3fIY9/c3pQCLUQxhbNHOBsqZN5VvQG
	Qy0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698949016; x=1699035416; bh=ccRdkv2KouFQr
	XacW6T4fBEpKBx+OWWMqYeM7hOtQhw=; b=X2ci7TaDRAwKRs2TPjmHaENk9MuIB
	5ELb9NI75Pq0qo5PwFW3pGswaY/Ht1RxZRx8cGw1R19bFsXWPZZcbArDpb42OMPr
	fh1eIE85LNlOix8CAG20bs9ibFHr6YPEhlcZgNzs3rGNA7wphh1oEvoQbmuEFyOe
	7Ssrx3RiJqQ1YpnrJOga8lTE5q66ClXV4XC3/jaYfl4XnLCrPasK+KAA9UpQoWDq
	nM9Ym1u5chUDrJbqRlDHUGsLuIyPZ3sSxdW8h/iBL9HT/yzRYFr+YUcf5GvdtDx6
	J9pp5H1DItU5tRcH5+V/ja0Bg4BzORKBwXJhlq7dxc+VwGWk8i2Trj7CA==
X-ME-Sender: <xms:mOdDZXM8Q9x_eynSwNS7gndNYKzzGbqezej7swj59Kq2yIuvHc865w>
    <xme:mOdDZR8r6uzVz0czCRFRjTdKHfzTWV_Vj66x9890_crsB-utK2RS07DkB6z_IdhBE
    yW2few7xfh3B27km5c>
X-ME-Received: <xmr:mOdDZWSOZtyku_2_EYXMo3RwKXL0WTjWi0GYViasbtD2oYRHcp10Pk9FaLFxh5HPqxOkBQ4d8ejG4akC1Wz_xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflvghr
    vghmhicuvehlihhnvgcuoehjvghrvghmhiesjhgtlhhinhgvrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeigeejfeefueejheeujeduleegueehtdeltedvieevgeefffeljeelvdej
    hfehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjvghrvghmhiesjhgtlhhinhgvrdhorhhg
X-ME-Proxy: <xmx:mOdDZbvkqzxxh4mDQ3T6GPoI_5SMO7TxkW9A3TRNtc4jFMtcHXXrUw>
    <xmx:mOdDZfcpWIexFtzzTT8puHOJNPIIuog7kB4E6VpSgEzyKhk2JhHFHw>
    <xmx:mOdDZX1k2Di95uM9jG2tk_4CWJM7o1BwoZ5-fLSJ4W3isRZcbGclng>
    <xmx:mOdDZRu7QBhNHpGMWjdzLoiZHoxdOw6yZCePwYVIxhsvFV7DV-7vAg>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 14:16:55 -0400 (EDT)
Date: Thu, 2 Nov 2023 14:16:54 -0400
From: Jeremy Cline <jeremy@jcline.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: habetsm.xilinx@gmail.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com, richardcochran@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUPnlsm91R72MBs7@dev>
References: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2C67C6D2537B236F497823BCC457976F9705@qq.com>

Hi Edward,

On Tue, Oct 31, 2023 at 06:25:42PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption, use mutex lock to avoid this 
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted together.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/ptp/ptp_chardev.c | 11 +++++++++--
>  drivers/ptp/ptp_clock.c   |  3 +++
>  drivers/ptp/ptp_private.h |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..e31551d2697d 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	struct timestamp_event_queue *queue;
>  	char debugfsname[32];
>  
> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +		return -ERESTARTSYS;
> +
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
>  		return -EINVAL;
> @@ -132,15 +135,20 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
>  				 &queue->dfs_bitmap);
>  
> +	mutex_unlock(&ptp->tsevq_mux);

The lock doesn't need to be held so long here. Doing so causes a bit of
an issue, actually, because the memory allocation for the queue can fail
which will cause the function to return early without releasing the
mutex.

The lock only needs to be held for the list_add_tail() call.

>  	return 0;
>  }
>  
>  int ptp_release(struct posix_clock_context *pccontext)
>  {
>  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
> +	struct ptp_clock *ptp =
> +		container_of(pccontext->clk, struct ptp_clock, clock);
>  	unsigned long flags;
>  
>  	if (queue) {
> +		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +			return -ERESTARTSYS;
>  		debugfs_remove(queue->debugfs_instance);
>  		pccontext->private_clkdata = NULL;
>  		spin_lock_irqsave(&queue->lock, flags);
> @@ -148,6 +156,7 @@ int ptp_release(struct posix_clock_context *pccontext)
>  		spin_unlock_irqrestore(&queue->lock, flags);
>  		bitmap_free(queue->mask);
>  		kfree(queue);
> +		mutex_unlock(&ptp->tsevq_mux);

Similar to the above note, you don't want to hold the lock any longer
than you must.

While this patch looks to cover adding and removing items from the list,
the code that iterates over the list isn't covered which can be
problematic. If the list is modified while it is being iterated, the
iterating code could chase an invalid pointer.

Regards,
Jeremy

