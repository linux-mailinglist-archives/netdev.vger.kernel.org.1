Return-Path: <netdev+bounces-237118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901C5C457C3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECDD3B42CA
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7722259A;
	Mon, 10 Nov 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D84k4Gck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDA26299;
	Mon, 10 Nov 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765286; cv=none; b=OvTR7sdIBV+O1nqoWYG9H2GCf5O9jH8U36rtS+YW1Nr+rs6Yw2cKGkFfa7qw+K+mt5TdxssMBHmH2AS6GftXMrV898rKBCwlt0Kvg1nm68JTftPjCNLH/fHdmbOwghuTBM3w7m94Pb1dJMeNpiy3Viv3GIscOg8tQXAr94h5ZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765286; c=relaxed/simple;
	bh=gSjPQJmyRvp5FhE0nx669b4kg80b70C6/WXDHAf5wEE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hx2xBhN44Djw4X29M9xKtq0ZWUqYV+jk/nG3hXpANwa5YJF8iaeiV27CGr/5x/1FPUmZVoPg8QmTiF4qDdOhzLteQnybN4c/S6y3GnrD+LKJFFq7Ts5oUZAfLTYZlVD+0lIf9qqK+5ALORZ8RFJGm9tcOXb7gNWCFh2ROuCsLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D84k4Gck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8A4C116B1;
	Mon, 10 Nov 2025 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765285;
	bh=gSjPQJmyRvp5FhE0nx669b4kg80b70C6/WXDHAf5wEE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=D84k4GckFjHjwrv48lQ/D9n+GEKWWgXvOkSbUqwc5artvOBfq80Mwwk5SLy5cJ4mn
	 p/Mh+mZUlmpD4A1G1cffHwAwKT6dX5ONntumJemLW6i+YR58yN5CfGQ/0HHViZdS6D
	 HTdUdzm5VmfYybkMetHZUFNUzqF/aRAFnXAp9jROpw4DoHGJbArVvcehjllIvSXWm2
	 TJQiFMzGss6wGXcpsPJ+3nsJL1d+qc6sxdcRs4bNOZOP0fJ+h/obzSRED1JXDQ72C2
	 CG/lu2AC/Cz/M/ztiWSTGLwzSdUGATbhuXtFkvCaESBqIMMClHsaC90lyOUuJ1ApSF
	 aT4XfEE/x6nkA==
Message-ID: <843d646a-a720-4431-b9cb-5a0a9bdc9d59@kernel.org>
Date: Mon, 10 Nov 2025 10:01:21 +0100
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

Hi Balamanikandan,

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

Most of this series is fine, but the histogram part needs more work.

I would recommend splitting up this series in two parts: one for the
various fixes and improvements, and one for the histogram feature.

The first series with the fixes I can take easily. In fact, if you
post that this week (no later than Thursday), then I can pick it
up in time for v6.19.

As mentioned the histogram part needs more work. Mostly small stuff,
but the documentation is the major missing part.

I also want to see the output of 'v4l2-compliance -m0 -s' (i.e.
with streaming) in the cover letter of the histogram series to be
certain nothing was forgotten.

Make sure you compile v4l2-compliance straight from the git repo,
don't use a distro version since that's usually out of date.

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


