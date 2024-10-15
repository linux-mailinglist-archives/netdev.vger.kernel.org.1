Return-Path: <netdev+bounces-135528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC199E335
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346FA1C21E08
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8421E0B65;
	Tue, 15 Oct 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FVkYoFdl"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563A1E0DB0;
	Tue, 15 Oct 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986239; cv=none; b=B2WqPiVHiJlC0Wha//zcJQlagOLsL1fOsoRM0iGk4rS2yIK9OFLFYvGbxCConsvZ3ASchVXQGayOgCw2j2IRoQHt+59aJeMj5zL0bz2HQEyZXdYHSX6GyIOUaoj5R/GuwsDa+gATzXsw+hVWmL9sKppRhHbaQUuDxQskCzrhxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986239; c=relaxed/simple;
	bh=dftW7zcS2EBNTF8YK9j9q7zTGJtVX3ZG0gx0rptQNtk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=TEtMbEMQk9M4cZT4PlQWDoXrJW5tu0zCw3GeoPBU9mZPmhQ/ZA5Qq6r5Rbdf38iN6GT0mdYuIQB8tjNVwZiARVqxgN52fW1MOq1C0oaBo75Kmp08DWsq/SlqBq91Qs6vRwGWZST1d7jYTNaotaK5DQAW7eAOOFv2TjZSCAG0PLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FVkYoFdl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728986233; h=Message-ID:Subject:Date:From:To;
	bh=Iaouv12bpH/2YtDLBwzWAXYEX0p/SxNsdOECyiypjOw=;
	b=FVkYoFdlaCHud+YZbrTv8Z6R2O7gagja7k24TWVXn0ea3FDhyls626JYpvgvbhiKXKPsbNxqPajgZIstowhXQHwW1Rj+A7c6ezWr7irpvDl6VQQoF9kKqp1UitOfiDEntydzeNlxoKRvTFY5NmS26S7p4uwoOEaAAjFoAkauRzY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WHDG-1b_1728986232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:57:13 +0800
Message-ID: <1728986129.331167-1-xuanzhuo@linux.alibaba.com>
Subject: Re: virtio_net: support device stats
Date: Tue, 15 Oct 2024 17:55:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Colin King (gmail)" <colin.i.king@gmail.com>
References: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>
 <20241014054305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241014054305-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 14 Oct 2024 05:47:41 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Oct 14, 2024 at 10:39:26AM +0100, Colin King (gmail) wrote:
> > Hi,
> >
> > Static analysis on Linux-next has detected a potential issue with the
> > following commit:
> >
> > commit 941168f8b40e50518a3bc6ce770a7062a5d99230
> > Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Date:   Fri Apr 26 11:39:24 2024 +0800
> >
> >     virtio_net: support device stats
> >
> >
> > The issue is in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c
> > as follows:
> >
> >         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
> >                 queue_type = VIRTNET_Q_TYPE_CQ;
> >
> >                 ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
> >                 ctx->desc_num[queue_type] +=
> > ARRAY_SIZE(virtnet_stats_cvq_desc);
> >                 ctx->size[queue_type]     += sizeof(struct
> > virtio_net_stats_cvq);
> >         }
> >
> >
> > ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
> > VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
> >
> > include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <<
> > 32)
> >
> > ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
> > because 1ULL < 32 is too wide for a u32.
>
> Indeed. Xuan Zhuo how did you test this patch?

In our machines, cvq type is not supported. ^_^

Why gcc has not warning for this, or I missed it.

>
> > I suspect ctx->bitmap should be
> > declared as u64.
> >
> > Colin
> >
> >
>
> In fact, it is read into a u64:
>
>        u64 offset, bitmap;
> ....
>         bitmap = ctx->bitmap[queue_type];
>
> we'll have to reorder fields to avoid wasting memory.
> Like this I guess:
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks

>
> Colin, can you confirm pls?
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..ef221429f784 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4111,12 +4111,12 @@ struct virtnet_stats_ctx {
>  	/* Used to calculate the offset inside the output buffer. */
>  	u32 desc_num[3];
>
> -	/* The actual supported stat types. */
> -	u32 bitmap[3];
> -
>  	/* Used to calculate the reply buffer size. */
>  	u32 size[3];
>
> +	/* The actual supported stat types. */
> +	u64 bitmap[3];
> +
>  	/* Record the output buffer. */
>  	u64 *data;
>  };
> --
> MST
>

