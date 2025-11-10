Return-Path: <netdev+bounces-237115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65342C456F6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54DCD4E7EF4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99A2FD693;
	Mon, 10 Nov 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J769OGb7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E672FCBF7;
	Mon, 10 Nov 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764592; cv=none; b=G2L5w3PD2vt2fTbVINebIxuIIs/kxSBTkV6YlrQYg6RWe0OB95ZEYV2osWJPKlgzEzBZya9/1zqZ9UtaSu7xnyatiWoTZ0Vwj8iSAupcqaogedY/wPv9ANvrOV6tx345TIjChz6DhVMsy2WGK1T7D+71t/L84ojpqPk+yXNjy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764592; c=relaxed/simple;
	bh=L8WwRtc/KVhcwVxx2iw6AWXl76LzJPVUQX89gEvL+zg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K/LpjJakbIDE2AkOl/b0f5Lj3ALArTo8vKAJqn7p0/dKG+3NsJLvcVHMkWy2QKpJpOKKRVQI6YWTkDpQqNqRISUNaP8r/j/SkjJkKSS1xsIMwQjgHBGGTuY8A0hBQG1vMOTGt54/M1krhdfHy7YUZkp0uxnrEt6HuIz1GZO0moo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J769OGb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397EC116D0;
	Mon, 10 Nov 2025 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762764591;
	bh=L8WwRtc/KVhcwVxx2iw6AWXl76LzJPVUQX89gEvL+zg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=J769OGb7KshC5EGg3bpiJMvSav3sFXhFww5eKdD9rO+6S+MFA/po/bP2bDDzj16I+
	 pvr3d1tCPbD5S8VpW3iOECSeIPqVmdDu+S1ZY6qTTbCHLnnbn/k42Aeqbsq3O1o0aP
	 DYM5wJlMi8l3/IrJEDAv7tzs/B2O7Vj+d1lHEzyMpyRdtG72+lUzZfIoNXE61p3LGJ
	 nG1ADhmy4jP7veqcP8uRKG79G4SriQ12z8XIG054oThmxnRaOvB0jPt9LbR99GI9Y1
	 MWpbm5ItcxEx5agO/oSv/V9OGVmjTPjbdokukGsmTasTSRQtj5tqjl7zOHa4HK2+ln
	 0h+OqSF3jOWYg==
Message-ID: <51c19bc4-35cb-43ea-a4d6-4496142baa9e@kernel.org>
Date: Mon, 10 Nov 2025 09:49:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 17/18] media: videodev2.h, v4l2-ioctl: Add microchip
 statistics format
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
 <20251009155251.102472-18-balamanikandan.gunasundar@microchip.com>
Content-Language: en-US, nl
In-Reply-To: <20251009155251.102472-18-balamanikandan.gunasundar@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2025 17:52, Balamanikandan Gunasundar wrote:
> Add microchip ISC specific statistics meta data format. This data consists
> of raw histogram statistics that is exported to userspace for further
> processing. This fixes the kernel warning "Unknown pixelformat"
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>  include/uapi/linux/videodev2.h       | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 01cf52c3ea33..a03e8f3ab610 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1467,6 +1467,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
>  	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
>  	case V4L2_META_FMT_RK_ISP1_EXT_PARAMS:	descr = "Rockchip ISP1 Ext 3A Params"; break;
> +	case V4L2_META_FMT_ISC_STAT_3A: descr = "Microchip ISP statistics"; break;

statistics -> Statistics

>  	case V4L2_META_FMT_C3ISP_PARAMS:	descr = "Amlogic C3 ISP Parameters"; break;
>  	case V4L2_META_FMT_C3ISP_STATS:		descr = "Amlogic C3 ISP Statistics"; break;
>  	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index becd08fdbddb..ba628f9bb89f 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -875,6 +875,9 @@ struct v4l2_pix_format {
>  #define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A Statistics */
>  #define V4L2_META_FMT_RK_ISP1_EXT_PARAMS	v4l2_fourcc('R', 'K', '1', 'E') /* Rockchip ISP1 3a Extensible Parameters */
>  
> +/* Vendor specific - used for Microchip camera sub-system */
> +#define V4L2_META_FMT_ISC_STAT_3A      v4l2_fourcc('I', 'S', 'C', 'S')
> +
>  /* Vendor specific - used for C3_ISP */
>  #define V4L2_META_FMT_C3ISP_PARAMS	v4l2_fourcc('C', '3', 'P', 'M') /* Amlogic C3 ISP Parameters */
>  #define V4L2_META_FMT_C3ISP_STATS	v4l2_fourcc('C', '3', 'S', 'T') /* Amlogic C3 ISP Statistics */

This meta format must be documented just like e.g. V4L2_META_FMT_C3ISP_STATS.

Regards,

	Hans

