Return-Path: <netdev+bounces-216718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE793B34FEC
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D0084E2968
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996CEAF9;
	Tue, 26 Aug 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEaOYgzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103715D1;
	Tue, 26 Aug 2025 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166671; cv=none; b=TcIQJbMQHpF3hR29T6cSPYQaq8HBwNDqDXaKXzkp+vTUdg9n+rLv0XC7+HB3IdLYwX3m9pxoqA3GiK3qF81i3co1YdpFjWzuByGPiNM4fXnDr6Pnj4Tk3tvwzpv+86x7c0vIXlmiJRaz+3PsFbHbgCmlwSejLGRlrWNTFdxutE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166671; c=relaxed/simple;
	bh=I2CHa28a+kF5TIQpV0OKhcm8Fy+kJZEGtMvHJ4gzr9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm4MJuraPYfxY5pOdxW6oyLeHLUQUiXXrdmYoyyNb3t4a9p1hYnQifLI4UvYJhDYsK9CaU5+zNBIo7NyD02n0uwFwidz8unMd3grFy79J0+wDtgDpBkY54Jl7tHZ5uI8nhcdKTq4B6tDEvR0VJ1chTgOMhg/NBchDQdd/K+biDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEaOYgzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7519EC4CEED;
	Tue, 26 Aug 2025 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756166670;
	bh=I2CHa28a+kF5TIQpV0OKhcm8Fy+kJZEGtMvHJ4gzr9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MEaOYgzBttpgZxpdWBKXPcRDssOKMfD/qLPuBiERWKDr/1yEelSvY3mYHPWcQc3Bx
	 +b8SiI7ADgoACDWGAvNtlDi+U6F5ou+fvBLKIHDePIMWukavxuSPrDXIIJpfHz8QEg
	 eyfupyRuCL2tHESpvywmbxvuOioMUE2tgr4qlqKY5h1eXPYTMxcnFLmXLdb91qsZyv
	 /lbNIJhcsCHJvCOIqGt3AMntOYS0kh/7/OcLbfZ6vTh3nph0BUpDm5LAp8ur7DGb8J
	 K6eX3CX3jJPwxX8b2bRuZRY+7OrA4Dzerb7OP+hbnRirL7957izuEg9W8959CVKEG/
	 8jPGQt1endjeg==
Date: Mon, 25 Aug 2025 17:04:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
 <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next v2] amd-xgbe: Add PPS periodic output support
Message-ID: <20250825170429.0f08fa1e@kernel.org>
In-Reply-To: <20250822103831.2044533-1-Raju.Rangoju@amd.com>
References: <20250822103831.2044533-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:08:31 +0530 Raju Rangoju wrote:
> +#define PPSx_MASK(x) ({						\
> +	unsigned int __x = (x);					\
> +	GENMASK(PPS_MAXIDX(__x), PPS_MINIDX(__x));		\
> +})
> +#define PPSCMDx(x, val) ({					\
> +	unsigned int __x = (x);					\
> +	GENMASK(PPS_MINIDX(__x) + 3, PPS_MINIDX(__x)) &		\
> +	((val) << PPS_MINIDX(__x));				\
> +})
> +#define TRGTMODSELx(x, val) ({					\
> +	unsigned int __x = (x);					\
> +	GENMASK(PPS_MAXIDX(__x) - 1, PPS_MAXIDX(__x) - 2) &	\
> +	((val) << (PPS_MAXIDX(__x) - 2));			\
> +})

These macros are way too gnarly, please simplify them.
For a start I'm not sure why you're making your life harder and try 
to have a shifted mask. Instead of masking the value before shifting.

>  static int xgbe_enable(struct ptp_clock_info *info,
>  		       struct ptp_clock_request *request, int on)
>  {
> -	return -EOPNOTSUPP;
> +	struct xgbe_prv_data *pdata = container_of(info, struct xgbe_prv_data,
> +						   ptp_clock_info);
> +	struct xgbe_pps_config *pps_cfg;
> +	unsigned long flags;
> +	int ret;
> +
> +	dev_dbg(pdata->dev, "rq->type %d on %d\n", request->type, on);
> +
> +	if (request->type != PTP_CLK_REQ_PEROUT)
> +		return -EOPNOTSUPP;
> +
> +	/* Reject requests with unsupported flags */
> +	if (request->perout.flags)
> +		return -EOPNOTSUPP;

Are you sure kernel can actually send you any flags here?
ops->supported_perout_flags exists

> +	/* Validate index against our limit */
> +	if (request->perout.index >= XGBE_MAX_PPS_OUT)
> +		return -EINVAL;

Are you sure kernel can send you an index higher than what driver
registered as supported?
-- 
pw-bot: cr

