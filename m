Return-Path: <netdev+bounces-237117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76624C4576E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDED3AE9EC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E22E9EC7;
	Mon, 10 Nov 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tcrmv+F/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CAA926;
	Mon, 10 Nov 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764956; cv=none; b=Ps+Pl/oP0fjw7rRfT0L/4zqO6nyeYGxddlno6O4o6/T/1nbyhYIpYcMklGPlYPZ+i6INy03/7jvTFucu+wvWKSwyWHQAlQHfiLqL7E6XaHdGDW/DTFCjZACRpuewSD5RmVekV2Zu1aSM/bUngbqyujXWYrbH765ibqwmjtmkqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764956; c=relaxed/simple;
	bh=mSP+xIU4+FoO0L+fWKO5RP9XDBbobaBLZF91BFx8IRY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=myaVB7QBm8fAhCswrNpnn6YSYFnfWd75JBWEO3q8hANjLbMyNn1sTNwhFbHiaqqs/bqU4tVeiqYT2XQiXeYjK2MfvKJzHjPXnTn45RaHnvIfrWiiEI6P8XSo9l7XW8lKfgXjTkSX+uFNlINwlF86hyE1IBuNLb2bm0/3RVf26qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tcrmv+F/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9ABC19421;
	Mon, 10 Nov 2025 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764956;
	bh=mSP+xIU4+FoO0L+fWKO5RP9XDBbobaBLZF91BFx8IRY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Tcrmv+F/8Xfl77PApi/kITQFytI+3zCBcPHxSZ+M7pPm/KuPwar5zGbDtuMNpxqFp
	 lBmOzP5doV4be+vEuV+8YwbfiEHnymUYtowVpX62rD2nWk5VqmvuoBQJqsX0ubsI07
	 aW6quyKtPXdpwr01C8lWhQk72GyZvdE/4OKJlgIdiZ6gGvY853WqNmk1gUaGJe1X4Q
	 Jt9iZq18ii+AOyGmQ0HjK6E0KrxoaYSEBlnBw/GE2lmTFv+hhjPwqaftGNmD2cVHmh
	 DPwCaJAIkqU+2HMWQWqtpGY09HI7+2s3Lz1ppb3BgvPC8cI4DAAb4AD7ARcbFMbwBG
	 06GRVgSS9/fPg==
Message-ID: <affa667c-2d26-44a6-b575-0b147b4af273@kernel.org>
Date: Mon, 10 Nov 2025 09:55:51 +0100
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

Swap the two fields above to avoid introducing holes due to alignment problems.

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

After swapping those two fields you probably can drop __packed, but I'm not certain.
It's probably a good idea to check with the pahole utility if there are no holes in
this structure.

This structure must be part of include/uapi/linux/, probably
include/uapi/linux/media/microchip/something.h

Userspace must have access to this, otherwise it can't parse the metadata. Note
that that also means that the HIST_ENTRIES and HIST_BAYER/ISC_HIS_CFG_MODE_B
defines are in that uapi include as well.

> +
> +/* Statistics measurement type flags */
> +#define ISC_CIF_ISP_STAT_HIST		BIT(0)
> +

Regards,

	Hans

