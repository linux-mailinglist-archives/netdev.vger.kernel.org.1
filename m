Return-Path: <netdev+bounces-237112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8930AC45660
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C24E4E2710
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3102FC03C;
	Mon, 10 Nov 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqa9EERR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064F2FBE0E;
	Mon, 10 Nov 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764104; cv=none; b=KTsUQfyt45BJ5RG0hijyLyayqDB/yFgOH9R/4qfGzlK/4PTiJXJ+/j2bS3w9XEaOWeC9WTumMVkrtY7odq0RR6gEUGN8fOkqOFGaz4B6exHL3Asa2Eu24iXaUk+Cgq7sAkgqcTOR+WZtEXRfOU6C8gWl0ipz1tjGeGUV//pbx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764104; c=relaxed/simple;
	bh=k/2+Qq2uo1e0KZWTb2BdLiB4p6XQV/sxUM7SShHyubQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KRXVjNJqaBKnGX++7PeIwwcxRdkZRxwERmC/hcSB4CRPcmHyJdF3BNQ6vuk/6o+3N2GrA0FIbZTecNXjnRjNDVo0vz/9wLFuAc/Cs5cMPsoqvPOUKtTOUzhUwdEG1S2gntEq464CTI+e8S2ixWFE1CL3tOIi1h+k+4ZNzGQy9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqa9EERR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C3EC19423;
	Mon, 10 Nov 2025 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764103;
	bh=k/2+Qq2uo1e0KZWTb2BdLiB4p6XQV/sxUM7SShHyubQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=aqa9EERRa9h16e4pbQpi7h+4Be+w2cvoiEiYyoaCfXkBYAqEhFqHpT02B0t3H1B/L
	 iPqrUn3Nr3vsNlOH+lCRQvUcwqTbosk9pCBSce34mNP7DFdXW7MeS7rKd7cvsFFfl7
	 WmguU/U1Byi0a0aS58N4GGrySva3+8zX4LOdJdaPCPohMGhOTvYS+O/gvFjpMWGN6i
	 YzSTMT35PuulUiX+scNgxXHsU+iRw9hcFg3tjeS4+P9By5k6I697Q3oYG71ihVMttF
	 izXpidwbbPL3YoMo2U25i83tAm97LWVIhA7g+cTJ8Ovt0To6EpRsJoEJQpMr1tqAfF
	 2YrdyTe943jiQ==
Message-ID: <6e9a7a6f-98f7-43f8-98df-074225224794@kernel.org>
Date: Mon, 10 Nov 2025 09:41:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 08/18] media: platform: microchip: Add new histogram
 submodule
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Chas Williams
 <3chas3@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Hans Verkuil <hverkuil@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Daniel Scally <dan.scally+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251009155251.102472-1-balamanikandan.gunasundar@microchip.com>
 <20251009155251.102472-9-balamanikandan.gunasundar@microchip.com>
Content-Language: en-US, nl
In-Reply-To: <20251009155251.102472-9-balamanikandan.gunasundar@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Apologies for the late review, but this needs a bit more work:

On 09/10/2025 17:52, Balamanikandan Gunasundar wrote:
> From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> 
> Add new histogram submodule driver to export raw histogram statistics
> and data to userspace.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  drivers/media/platform/microchip/Kconfig      |   2 +
>  drivers/media/platform/microchip/Makefile     |   2 +-
>  .../platform/microchip/microchip-isc-stats.c  | 549 ++++++++++++++++++
>  .../media/platform/microchip/microchip-isc.h  |  24 +
>  4 files changed, 576 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/platform/microchip/microchip-isc-stats.c
> 
> diff --git a/drivers/media/platform/microchip/Kconfig b/drivers/media/platform/microchip/Kconfig
> index 4734ecced029..2864a57e2ff4 100644
> --- a/drivers/media/platform/microchip/Kconfig
> +++ b/drivers/media/platform/microchip/Kconfig
> @@ -10,6 +10,7 @@ config VIDEO_MICROCHIP_ISC
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select VIDEOBUF2_DMA_CONTIG
> +	select VIDEOBUF2_VMALLOC
>  	select REGMAP_MMIO
>  	select V4L2_FWNODE
>  	select VIDEO_MICROCHIP_ISC_BASE
> @@ -26,6 +27,7 @@ config VIDEO_MICROCHIP_XISC
>  	depends on VIDEO_DEV && COMMON_CLK
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	select VIDEOBUF2_DMA_CONTIG
> +	select VIDEOBUF2_VMALLOC
>  	select REGMAP_MMIO
>  	select V4L2_FWNODE
>  	select VIDEO_MICROCHIP_ISC_BASE
> diff --git a/drivers/media/platform/microchip/Makefile b/drivers/media/platform/microchip/Makefile
> index bd8d6e779c51..94c64d3d242c 100644
> --- a/drivers/media/platform/microchip/Makefile
> +++ b/drivers/media/platform/microchip/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  microchip-isc-objs = microchip-sama5d2-isc.o
>  microchip-xisc-objs = microchip-sama7g5-isc.o
> -microchip-isc-common-objs = microchip-isc-base.o microchip-isc-clk.o microchip-isc-scaler.o
> +microchip-isc-common-objs = microchip-isc-base.o microchip-isc-clk.o microchip-isc-scaler.o microchip-isc-stats.o
>  
>  obj-$(CONFIG_VIDEO_MICROCHIP_ISC_BASE) += microchip-isc-common.o
>  obj-$(CONFIG_VIDEO_MICROCHIP_ISC) += microchip-isc.o
> diff --git a/drivers/media/platform/microchip/microchip-isc-stats.c b/drivers/media/platform/microchip/microchip-isc-stats.c
> new file mode 100644
> index 000000000000..d7813c9d95ac
> --- /dev/null
> +++ b/drivers/media/platform/microchip/microchip-isc-stats.c
> @@ -0,0 +1,549 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Microchip ISC Driver - Statistics Subdevice
> + * Raw Histogram Export for Userspace Applications
> + *
> + * Copyright (C) 2025 Microchip Technology Inc.
> + *
> + * Author: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-vmalloc.h>
> +#include "microchip-isc-regs.h"
> +#include "microchip-isc.h"
> +
> +#define ISC_STATS_DEV_NAME	"microchip-isc_stats"
> +#define ISC_STATS_MIN_BUFS	2
> +#define ISC_STATS_MAX_BUFS	8
> +
> +/**
> + * struct isc_stat_buffer - Raw histogram statistics buffer structure
> + * @frame_number: Sequential frame number from capture
> + * @timestamp: Frame capture timestamp in nanoseconds
> + * @meas_type: Bitmask of measurement types available (ISC_CIF_ISP_STAT_*)
> + * @hist: Array of histogram data for each Bayer channel
> + * @hist.hist_bins: Raw 512-bin histogram data from hardware
> + * @hist.hist_min: Minimum pixel value observed in channel
> + * @hist.hist_max: Maximum pixel value observed in channel
> + * @hist.total_pixels: Total number of pixels processed in channel
> + * @valid_channels: Bitmask indicating which Bayer channels contain valid data
> + * @bayer_pattern: Current Bayer pattern configuration (CFA_BAYCFG_*)
> + * @reserved: Padding for future expansion and alignment
> + *
> + * This structure contains raw, unprocessed histogram data from the ISC
> + * hardware for all four Bayer channels (GR, R, GB, B). No algorithmic
> + * processing is performed - data is exported directly from hardware
> + * registers for userspace processing applications.
> + */
> +struct isc_stat_buffer {
> +	u32 frame_number;
> +	u64 timestamp;
> +	u32 meas_type;
> +
> +	struct {
> +		u32 hist_bins[HIST_ENTRIES];
> +		u32 hist_min;
> +		u32 hist_max;
> +		u32 total_pixels;
> +	} hist[HIST_BAYER];
> +
> +	u8 valid_channels;
> +	u8 bayer_pattern;
> +	u16 reserved[2];
> +} __packed;
> +
> +/* Statistics measurement type flags */
> +#define ISC_CIF_ISP_STAT_HIST		BIT(0)
> +
> +static bool isc_stats_in_use(struct isc_stats *stats)
> +{
> +	struct video_device *vdev;
> +
> +	if (!stats || !stats->isc)
> +		return false;
> +
> +	vdev = &stats->vnode.vdev;
> +	return vdev && video_is_registered(vdev) && !list_empty(&vdev->fh_list);
> +}
> +
> +static bool isc_stats_has_bufs(struct isc_stats *stats)
> +{
> +	bool has_buffers;
> +
> +	if (!stats)
> +		return false;
> +
> +	spin_lock(&stats->lock);
> +	has_buffers = !list_empty(&stats->stat);
> +	spin_unlock(&stats->lock);
> +
> +	return has_buffers;
> +}
> +
> +/*
> + * V4L2 device operations
> + */
> +
> +static int isc_stats_enum_fmt_meta_cap(struct file *file, void *priv,
> +				       struct v4l2_fmtdesc *f)
> +{
> +	struct video_device *video = video_devdata(file);
> +	struct isc_stats *stats = video_get_drvdata(video);
> +
> +	if (f->index > 0 || f->type != video->queue->type)
> +		return -EINVAL;

No need for the f->type check.

> +
> +	f->pixelformat = stats->vdev_fmt.fmt.meta.dataformat;
> +	return 0;
> +}
> +
> +static int isc_stats_g_fmt_meta_cap(struct file *file, void *priv,
> +				    struct v4l2_format *f)
> +{
> +	struct video_device *video = video_devdata(file);
> +	struct isc_stats *stats = video_get_drvdata(video);
> +	struct v4l2_meta_format *meta = &f->fmt.meta;
> +
> +	if (f->type != video->queue->type)
> +		return -EINVAL;

No need for this, just drop this check.

> +
> +	memset(meta, 0, sizeof(*meta));

No need, it's already zeroed by the V4L2 core.

> +	meta->dataformat = stats->vdev_fmt.fmt.meta.dataformat;
> +	meta->buffersize = stats->vdev_fmt.fmt.meta.buffersize;
> +
> +	return 0;
> +}
> +
> +static int isc_stats_querycap(struct file *file, void *priv,
> +			      struct v4l2_capability *cap)
> +{
> +	struct video_device *vdev = video_devdata(file);
> +
> +	strscpy(cap->driver, "microchip-isc", sizeof(cap->driver));
> +	strscpy(cap->card, vdev->name, sizeof(cap->card));
> +	strscpy(cap->bus_info, "platform:microchip-isc", sizeof(cap->bus_info));

You can drop the last line, it's filled in by the V4L2 core.

> +
> +	return 0;
> +}
> +
> +static int isc_stats_open(struct file *file)
> +{
> +	struct video_device *vdev = video_devdata(file);
> +	struct isc_stats *stats = video_get_drvdata(vdev);
> +
> +	dev_dbg(stats->isc->dev, "Stats device opened by %s (pid %d)\n",
> +		current->comm, current->pid);
> +
> +	return v4l2_fh_open(file);
> +}
> +
> +static int isc_stats_release(struct file *file)
> +{
> +	struct video_device *vdev = video_devdata(file);
> +	struct isc_stats *stats = video_get_drvdata(vdev);
> +
> +	dev_dbg(stats->isc->dev, "Stats device closed by %s (pid %d)\n",
> +		current->comm, current->pid);
> +
> +	return _vb2_fop_release(file, NULL);
> +}

These two functions make no sense. Drop them, see below for what to use instead.

> +
> +static const struct v4l2_ioctl_ops isc_stats_ioctl_ops = {
> +	.vidioc_reqbufs = vb2_ioctl_reqbufs,
> +	.vidioc_querybuf = vb2_ioctl_querybuf,
> +	.vidioc_create_bufs = vb2_ioctl_create_bufs,
> +	.vidioc_qbuf = vb2_ioctl_qbuf,
> +	.vidioc_dqbuf = vb2_ioctl_dqbuf,
> +	.vidioc_prepare_buf = vb2_ioctl_prepare_buf,
> +	.vidioc_expbuf = vb2_ioctl_expbuf,
> +	.vidioc_streamon = vb2_ioctl_streamon,
> +	.vidioc_streamoff = vb2_ioctl_streamoff,
> +	.vidioc_enum_fmt_meta_cap = isc_stats_enum_fmt_meta_cap,
> +	.vidioc_g_fmt_meta_cap = isc_stats_g_fmt_meta_cap,
> +	.vidioc_s_fmt_meta_cap = isc_stats_g_fmt_meta_cap,
> +	.vidioc_try_fmt_meta_cap = isc_stats_g_fmt_meta_cap,
> +	.vidioc_querycap = isc_stats_querycap,
> +	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> +	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
> +};
> +
> +static const struct v4l2_file_operations isc_stats_fops = {
> +	.mmap = vb2_fop_mmap,
> +	.unlocked_ioctl = video_ioctl2,
> +	.poll = vb2_fop_poll,
> +	.open = isc_stats_open,

Just use v4l2_fh_open.

> +	.release = isc_stats_release

And for this use vb2_fop_release.

> +};
> +
> +/*
> + * VB2 queue operations
> + */
> +
> +static int isc_stats_vb2_queue_setup(struct vb2_queue *vq,
> +				     unsigned int *num_buffers,
> +				     unsigned int *num_planes,
> +				     unsigned int sizes[],
> +				     struct device *alloc_devs[])
> +{
> +	struct isc_stats *stats = vq->drv_priv;
> +

This doesn't handle VIDIOC_CREATEBUFS correctly. See isc_queue_setup
on how to do that correctly.

> +	*num_planes = 1;
> +	*num_buffers = clamp_t(u32, *num_buffers, ISC_STATS_MIN_BUFS,
> +			       ISC_STATS_MAX_BUFS);

Why limit the number of buffers? The default max is 32 (VIDEO_MAX_FRAME),
and unless there are hardware limitations that require adjustments, I'd
just leave *num_buffers alone.

> +	sizes[0] = sizeof(struct isc_stat_buffer);
> +
> +	dev_dbg(stats->isc->dev, "Stats queue: %u buffers, %u bytes each\n",
> +		*num_buffers, sizes[0]);
> +
> +	return 0;
> +}
> +
> +static void isc_stats_vb2_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct isc_buffer *stats_buf = container_of(vbuf, struct isc_buffer, vb);
> +	struct vb2_queue *vq = vb->vb2_queue;
> +	struct isc_stats *stats_dev = vq->drv_priv;
> +
> +	spin_lock_irq(&stats_dev->lock);
> +	list_add_tail(&stats_buf->list, &stats_dev->stat);
> +	spin_unlock_irq(&stats_dev->lock);
> +
> +	dev_dbg(stats_dev->isc->dev, "Stats buffer %d queued\n", vb->index);
> +}
> +
> +static int isc_stats_vb2_buf_prepare(struct vb2_buffer *vb)
> +{
> +	if (vb2_plane_size(vb, 0) < sizeof(struct isc_stat_buffer))
> +		return -EINVAL;
> +
> +	vb2_set_plane_payload(vb, 0, sizeof(struct isc_stat_buffer));
> +	return 0;
> +}
> +
> +static int isc_stats_vb2_start_streaming(struct vb2_queue *vq,
> +					 unsigned int count)
> +{
> +	struct isc_stats *stats = vq->drv_priv;
> +
> +	dev_dbg(stats->isc->dev, "Stats streaming started\n");
> +	return 0;
> +}
> +
> +static void isc_stats_vb2_stop_streaming(struct vb2_queue *vq)
> +{
> +	struct isc_stats *stats = vq->drv_priv;
> +	struct isc_buffer *buf;
> +	unsigned int i;
> +
> +	dev_dbg(stats->isc->dev, "Stats streaming stopped\n");
> +
> +	spin_lock_irq(&stats->lock);
> +	for (i = 0; i < ISC_STATS_MAX_BUFS; i++) {
> +		if (list_empty(&stats->stat))
> +			break;
> +		buf = list_first_entry(&stats->stat, struct isc_buffer, list);
> +		list_del(&buf->list);
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +	}
> +	spin_unlock_irq(&stats->lock);
> +}
> +
> +static const struct vb2_ops isc_stats_vb2_ops = {
> +	.queue_setup = isc_stats_vb2_queue_setup,
> +	.buf_queue = isc_stats_vb2_buf_queue,
> +	.buf_prepare = isc_stats_vb2_buf_prepare,
> +	.start_streaming = isc_stats_vb2_start_streaming,
> +	.stop_streaming = isc_stats_vb2_stop_streaming,
> +	.wait_prepare = vb2_ops_wait_prepare,
> +	.wait_finish = vb2_ops_wait_finish,

Drop these last two lines: wait_prepare/finish is deprecated and will hopefully be
removed in 6.20.

> +};
> +
> +static int isc_stats_init_vb2_queue(struct vb2_queue *q,
> +				    struct isc_stats *stats)
> +{
> +	struct isc_vdev_node *node;
> +
> +	node = container_of(q, struct isc_vdev_node, buf_queue);
> +
> +	q->type = V4L2_BUF_TYPE_META_CAPTURE;
> +	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;

I'm not keen on VB2_USERPTR for new drivers. But I won't block it if you
believe there is a good use case for this.

> +	q->drv_priv = stats;
> +	q->ops = &isc_stats_vb2_ops;
> +	q->mem_ops = &vb2_vmalloc_memops;
> +	q->buf_struct_size = sizeof(struct isc_buffer);
> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->lock = &node->vlock;
> +
> +	return vb2_queue_init(q);
> +}
> +
> +/*
> + * Histogram data processing
> + */
> +
> +static void isc_stats_fill_data(struct isc_stats *stats,
> +				struct isc_stat_buffer *pbuf)
> +{
> +	struct isc_device *isc = stats->isc;
> +	struct isc_ctrls *ctrls = &isc->ctrls;
> +	int c;
> +
> +	pbuf->meas_type |= ISC_CIF_ISP_STAT_HIST;
> +
> +	/* Copy existing histogram data from AWB work function */
> +	for (c = 0; c < HIST_BAYER; c++) {
> +		memcpy(pbuf->hist[c].hist_bins, isc->full_hist_data[c],
> +		       sizeof(pbuf->hist[c].hist_bins));
> +
> +		pbuf->hist[c].hist_min = ctrls->hist_minmax[c][HIST_MIN_INDEX];
> +		pbuf->hist[c].hist_max = ctrls->hist_minmax[c][HIST_MAX_INDEX];
> +		pbuf->hist[c].total_pixels = ctrls->total_pixels[c];
> +	}
> +
> +	/* Set valid channels - all 4 Bayer channels */
> +	pbuf->valid_channels = 0x0F;
> +
> +	/* Set Bayer pattern */
> +	if (isc->config.sd_format)
> +		pbuf->bayer_pattern = isc->config.sd_format->cfa_baycfg;
> +	else
> +		pbuf->bayer_pattern = 0;
> +
> +	dev_dbg(isc->dev,
> +		"Stats data ready: pixels=[%u,%u,%u,%u], valid_channels=0x%x\n",
> +		pbuf->hist[0].total_pixels, pbuf->hist[1].total_pixels,
> +		pbuf->hist[2].total_pixels, pbuf->hist[3].total_pixels,
> +		pbuf->valid_channels);
> +}
> +
> +static void isc_stats_send_buf(struct isc_stats *stats)
> +{
> +	struct isc_stat_buffer *cur_stat_buf;
> +	struct isc_buffer *cur_buf = NULL;
> +	struct isc_device *isc = stats->isc;
> +	unsigned int frame_sequence = isc->sequence;
> +	u64 timestamp = ktime_get_ns();
> +
> +	/* Get one empty buffer from userspace */
> +	spin_lock(&stats->lock);
> +	if (!list_empty(&stats->stat)) {
> +		cur_buf = list_first_entry(&stats->stat,
> +					   struct isc_buffer, list);
> +		list_del(&cur_buf->list);
> +	}
> +	spin_unlock(&stats->lock);
> +
> +	if (!cur_buf) {
> +		dev_dbg(isc->dev, "No stats buffer available\n");
> +		return;
> +	}
> +
> +	cur_stat_buf = vb2_plane_vaddr(&cur_buf->vb.vb2_buf, 0);
> +	if (!cur_stat_buf) {
> +		dev_err(isc->dev, "Failed to get stats buffer vaddr\n");
> +		goto error_return_buffer;
> +	}
> +
> +	/* Clear buffer and fill metadata */
> +	memset(cur_stat_buf, 0, sizeof(*cur_stat_buf));
> +	cur_stat_buf->frame_number = frame_sequence;
> +	cur_stat_buf->timestamp = timestamp;
> +
> +	/* Fill raw histogram data */
> +	isc_stats_fill_data(stats, cur_stat_buf);
> +
> +	/* Send buffer to userspace */
> +	vb2_set_plane_payload(&cur_buf->vb.vb2_buf, 0,
> +			      sizeof(struct isc_stat_buffer));
> +	cur_buf->vb.sequence = frame_sequence;
> +	cur_buf->vb.vb2_buf.timestamp = timestamp;
> +	vb2_buffer_done(&cur_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +
> +	dev_dbg(isc->dev,
> +		"Stats sent: frame=%u, channels=[%u,%u,%u,%u] pixels\n",
> +		frame_sequence,
> +		cur_stat_buf->hist[0].total_pixels,
> +		cur_stat_buf->hist[1].total_pixels,
> +		cur_stat_buf->hist[2].total_pixels,
> +		cur_stat_buf->hist[3].total_pixels);
> +	return;
> +
> +error_return_buffer:
> +	/* Return buffer to queue on error */
> +	spin_lock(&stats->lock);
> +	list_add(&cur_buf->list, &stats->stat);
> +	spin_unlock(&stats->lock);
> +}
> +
> +/*
> + * Public API functions
> + */
> +
> +/**
> + * isc_stats_isr() - Process statistics in interrupt context
> + * @stats: ISC histogram statistics device
> + *
> + * Called from the ISC interrupt handler when histogram data is ready.
> + * Exports raw histogram data to userspace applications that have
> + * buffers queued on the statistics device.
> + */
> +void isc_stats_isr(struct isc_stats *stats)
> +{
> +	if (!stats) {
> +		pr_err("ISC stats: stats is NULL\n");
> +		return;
> +	}
> +
> +	if (!stats->isc) {
> +		pr_err("ISC stats: stats->isc is NULL\n");
> +		return;
> +	}
> +
> +	/* Only send data if userspace is using the device */
> +	if (!isc_stats_in_use(stats)) {
> +		dev_dbg(stats->isc->dev, "Stats device not in use\n");
> +		return;
> +	}
> +
> +	/* Only send data if userspace has queued buffers */
> +	if (!isc_stats_has_bufs(stats)) {
> +		dev_dbg(stats->isc->dev, "No queued buffers\n");
> +		return;
> +	}
> +
> +	/* Send histogram data to userspace */
> +	isc_stats_send_buf(stats);
> +}
> +EXPORT_SYMBOL_GPL(isc_stats_isr);
> +
> +/**
> + * isc_stats_active() - Check if userspace is actively using stats
> + * @stats: ISC histogram statistics device
> + *
> + * Determines if any userspace application has the statistics device open
> + * and has queued buffers waiting for histogram data.
> + *
> + * Return: true if userspace is ready to receive data, false otherwise
> + */
> +bool isc_stats_active(struct isc_stats *stats)
> +{
> +	return isc_stats_in_use(stats) && isc_stats_has_bufs(stats);
> +}
> +EXPORT_SYMBOL_GPL(isc_stats_active);
> +
> +static void isc_stats_init(struct isc_stats *stats)
> +{
> +	stats->vdev_fmt.fmt.meta.dataformat = V4L2_META_FMT_ISC_STAT_3A;
> +	stats->vdev_fmt.fmt.meta.buffersize = sizeof(struct isc_stat_buffer);

It's a bit overkill to have the vdev_fmt field in stats. Just drop the field and
this function and just set these values directly in g/enum_fmt.

> +}
> +
> +/**
> + * isc_stats_register() - Register statistics device
> + * @isc: ISC device
> + *
> + * Creates and registers a V4L2 video device for exporting raw histogram
> + * statistics to userspace.
> + *
> + */
> +int isc_stats_register(struct isc_device *isc)
> +{
> +	struct isc_stats *stats = &isc->stats;
> +	struct isc_vdev_node *node = &stats->vnode;
> +	struct video_device *vdev = &node->vdev;
> +	int ret;
> +
> +	/* Initialize stats structure */
> +	stats->isc = isc;
> +	mutex_init(&node->vlock);
> +	INIT_LIST_HEAD(&stats->stat);
> +	spin_lock_init(&stats->lock);
> +
> +	/* Configure video device */
> +	strscpy(vdev->name, ISC_STATS_DEV_NAME, sizeof(vdev->name));
> +	vdev->ioctl_ops = &isc_stats_ioctl_ops;
> +	vdev->fops = &isc_stats_fops;
> +	vdev->release = video_device_release_empty;
> +	vdev->lock = &node->vlock;
> +	vdev->v4l2_dev = &isc->v4l2_dev;
> +	vdev->queue = &node->buf_queue;
> +	vdev->device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
> +	vdev->vfl_dir = VFL_DIR_RX;
> +
> +	/* Initialize VB2 queue */
> +	ret = isc_stats_init_vb2_queue(vdev->queue, stats);
> +	if (ret) {
> +		dev_err(isc->dev, "Failed to init stats VB2 queue: %d\n", ret);
> +		goto error_cleanup;
> +	}
> +
> +	/* Initialize stats format */
> +	isc_stats_init(stats);
> +
> +	video_set_drvdata(vdev, stats);
> +
> +	node->pad.flags = MEDIA_PAD_FL_SINK;
> +	ret = media_entity_pads_init(&vdev->entity, 1, &node->pad);
> +	if (ret) {
> +		dev_err(isc->dev, "Failed to init stats media entity: %d\n", ret);
> +		goto error_cleanup;
> +	}
> +
> +	/* Register video device */
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret) {
> +		dev_err(isc->dev, "Failed to register stats device: %d\n", ret);
> +		goto error_media_cleanup;
> +	}
> +
> +	dev_info(isc->dev, "Stats device registered as %s\n",
> +		 video_device_node_name(vdev));
> +
> +	return 0;
> +
> +error_media_cleanup:
> +	media_entity_cleanup(&vdev->entity);
> +error_cleanup:
> +	mutex_destroy(&node->vlock);
> +	stats->isc = NULL;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(isc_stats_register);
> +
> +/**
> + * isc_stats_unregister() - Unregister statistics device
> + * @isc: ISC device
> + *
> + * Unregisters and cleans up the statistics video device.
> + */
> +void isc_stats_unregister(struct isc_device *isc)
> +{
> +	struct isc_stats *stats = &isc->stats;
> +	struct isc_vdev_node *node = &stats->vnode;
> +	struct video_device *vdev = &node->vdev;
> +
> +	if (!stats->isc)
> +		return;
> +
> +	dev_dbg(isc->dev, "Unregistering stats device\n");
> +
> +	/* Unregister video device */
> +	vb2_video_unregister_device(vdev);
> +
> +	media_entity_cleanup(&vdev->entity);
> +
> +	/* Destroy synchronization primitives */
> +	mutex_destroy(&node->vlock);
> +
> +	stats->isc = NULL;
> +}
> +EXPORT_SYMBOL_GPL(isc_stats_unregister);
> +
> +MODULE_AUTHOR("Balakrishnan Sambath <balakrishnan.s@microchip.com>");
> +MODULE_DESCRIPTION("Microchip ISC Statistics Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
> index bd75ff4f109b..5245e2790268 100644
> --- a/drivers/media/platform/microchip/microchip-isc.h
> +++ b/drivers/media/platform/microchip/microchip-isc.h
> @@ -197,6 +197,23 @@ enum isc_scaler_pads {
>  	ISC_SCALER_PADS_NUM	= 2,
>  };
>  
> +/* Video device node structure */
> +struct isc_vdev_node {
> +	struct video_device vdev;
> +	struct vb2_queue buf_queue;
> +	struct mutex vlock; /* lock for video node */
> +	struct media_pad pad;
> +};
> +
> +/* Statistics device structure */
> +struct isc_stats {
> +	struct isc_device *isc;
> +	struct isc_vdev_node vnode;
> +	struct list_head stat;
> +	spinlock_t lock; /* lock for buffers */
> +	struct v4l2_format vdev_fmt;
> +};
> +
>  /*
>   * struct isc_device - ISC device driver data/config struct
>   * @regmap:		Register map
> @@ -340,6 +357,9 @@ struct isc_device {
>  		struct v4l2_ctrl	*gb_off_ctrl;
>  	};
>  
> +	/* Statistics device */
> +	struct isc_stats stats;
> +
>  #define GAMMA_ENTRIES	64
>  	/* pointer to the defined gamma table */
>  	const u32	(*gamma_table)[GAMMA_ENTRIES];
> @@ -396,6 +416,10 @@ int isc_scaler_link(struct isc_device *isc);
>  int isc_scaler_init(struct isc_device *isc);
>  int isc_mc_init(struct isc_device *isc, u32 ver);
>  void isc_mc_cleanup(struct isc_device *isc);
> +int isc_stats_register(struct isc_device *isc);
> +void isc_stats_unregister(struct isc_device *isc);
> +void isc_stats_isr(struct isc_stats *stats);
> +bool isc_stats_active(struct isc_stats *stats);
>  
>  struct isc_format *isc_find_format_by_code(struct isc_device *isc,
>  					   unsigned int code, int *index);

Regards,

	Hans

