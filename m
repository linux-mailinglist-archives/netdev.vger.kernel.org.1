Return-Path: <netdev+bounces-237124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8CC45A2A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5C3A2766
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853A2FF178;
	Mon, 10 Nov 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDMsKLsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379501DF72C;
	Mon, 10 Nov 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766807; cv=none; b=oKVhH7hlgnt8k7PVUyuNIwOxalSAofSADfz0bQZ63CMjaNy8AXlEnjhR3Nc1oQnFfQrC71yB0pQCfGlfAFNaFQNC7FmZhv/hAcNPEQ10qkhEnC3pE8xLIRLqUIhq04IsyaReMg8dVvjREzCgUBlG5YOsNId/WiUjA4nbWexMhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766807; c=relaxed/simple;
	bh=b0IFXuV/9PpQKpNg/c6/i5YuNUFwarm8QI9JGvletFs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jxcACXhxRhfxwZPhw408Py4ly1CuLV8i72xNlvTeViZSLFfndqe3UCReAH9Icms4TsUaLAN09yebxl3w/Tyoi+gXBYI9fSOL5/+zwW69BEuAAvsgiqaJvB6KN+dZGvcbzvo/jymDE9/EHGRO8IM8ww9Ak/9U440T4Q3VB/0AlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDMsKLsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F06EC116B1;
	Mon, 10 Nov 2025 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766805;
	bh=b0IFXuV/9PpQKpNg/c6/i5YuNUFwarm8QI9JGvletFs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=XDMsKLsK+bVR9DeEuIXtyzRVuyhrICIVTSQIMVL07RtxAGM2Y8MnHEoMVJAQ8piaC
	 ZgoHaLn52+YX/eIS4IDhqSxZJ0jcoiNuujVU08+zY9L3oG0mwVvRIF/h/oAeLIcXa7
	 Oy5eQzv2EzYDCUYESJO4t0Fo8tJyNDMFfBnEl5wjYQZd+uo4uM5KSEAZbGWkECnCvR
	 RQ7Q/5StUrhU7qDDazxIa/MV03yTX9WupBtWECFn+BpV09QaaBNXL6mB6W5jyTkQhM
	 azn9iNXFi4uJbYEVeLrU+e34VFMFcGwS0rBF5LG9LyMg9JFTD/ft899JzkgQqKVqvp
	 Zc47RZDbgZ2tg==
Message-ID: <55a8a7f1-013e-4528-b4dd-b26ee24dbb6b@kernel.org>
Date: Mon, 10 Nov 2025 10:26:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 00/18] media: microchip-isc: Color correction and
 histogram stats
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
Content-Language: en-US, nl
In-Reply-To: <20251009155251.102472-1-balamanikandan.gunasundar@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2025 17:52, Balamanikandan Gunasundar wrote:
> Hi,
> 
> This patch series has a set of enhancements to the Microchip Image Sensor
> Controller driver. The objective is to expand its image processing
> capabilities and to improve the colors.
> 
> This series also introduces a new stats driver that exposes the histogram
> data to userspace via v4l2 controls. This allows applications such as
> libcamera to access real time image statistics for advanced image
> processing like automatic exposure, white balance adjustments etc.

Note that bisect of this series failed: some patches seem to have dependencies
on later patches, which is obviously wrong. Make sure you double check that
for v2.

The documentation also fails to build since there is no documentation for the
new meta format, but I already commented on that.

Regards,

	Hans

> 
> Balakrishnan Sambath (11):
>   media: microchip-isc: Enable GDC and CBC module flags for RGB formats
>   media: microchip-isc: Improve histogram calculation with outlier
>     rejection
>   media: microchip-isc: Use channel averages for Grey World AWB
>   media: microchip-isc: Add range based black level correction
>   media: platform: microchip: Extend gamma table and control range
>   media: platform: microchip: Add new histogram submodule
>   media: microchip-isc: Register and unregister statistics device
>   media: microchip-isc: Always enable histogram for all RAW formats
>   media: microchip-isc: fix histogram state initialization order
>   media: microchip-isc: decouple histogram cycling from AWB mode
>   media: microchip-isc: enable userspace histogram statistics export
> 
> Balamanikandan Gunasundar (7):
>   media: platform: microchip: set maximum resolution for sam9x7
>   media: platform: microchip: Include DPC modules flags in pipeline
>   media: microchip-isc: expose hue and saturation as v4l2 controls
>   media: microchip-isc: Rename CBC to CBHS
>   media: microchip-isc: Store histogram data of all channels
>   media: videodev2.h, v4l2-ioctl: Add microchip statistics format
>   media: microchip-isc: expose color correction registers as v4l2
>     controls
> 
>  drivers/media/platform/microchip/Kconfig      |   2 +
>  drivers/media/platform/microchip/Makefile     |   2 +-
>  .../platform/microchip/microchip-isc-base.c   | 373 ++++++++++--
>  .../platform/microchip/microchip-isc-regs.h   |   3 +
>  .../platform/microchip/microchip-isc-stats.c  | 549 ++++++++++++++++++
>  .../media/platform/microchip/microchip-isc.h  |  44 +-
>  .../microchip/microchip-sama5d2-isc.c         |   2 +-
>  .../microchip/microchip-sama7g5-isc.c         |  73 ++-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>  include/linux/atmel-isc-media.h               |  13 +
>  include/uapi/linux/videodev2.h                |   3 +
>  11 files changed, 1001 insertions(+), 64 deletions(-)
>  create mode 100644 drivers/media/platform/microchip/microchip-isc-stats.c
> 


