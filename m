Return-Path: <netdev+bounces-12690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E9E73880C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011011C20E15
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65518C2C;
	Wed, 21 Jun 2023 14:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697218C2A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F4AC433C8;
	Wed, 21 Jun 2023 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687359350;
	bh=3nkHxcMV4G3LOSAbCssJSrJUIexihpFEZqQgKvDUeHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqgAyDxoJdQafynZ2SoPGq5a0MmcBsdIfLGtv/7i2Ekk+MpSdnbfffYp82OCQY3ox
	 E7I2LTYfoJtBBWK29NZMHPKhGzvToF86eY4eT4rs4lpP7uxogTGVVV8R+w15QHuRCl
	 EbWcSqR3CYVzwBha9Td+3eVBau+6U0dyzLJALG6nK9Pvi7O7qN8iG14qwE7wgnX5cm
	 lxV5jFkS6uPMQ5TdGktCw8iVDsMiCdF3W6BaeuqrpZxY7ggnVsub257kSe3UkqASsf
	 VWyWOFb4ZCEmOCI08EBErOp0TvmZLOeo6h55bEz7el7S+rvI5rJ7Ekwp7oYeHfp3T2
	 HyiuD3nNVOlRw==
Date: Wed, 21 Jun 2023 15:55:45 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] leds: trigger: netdev: expose hw_control
 status via sysfs
Message-ID: <20230621145545.GC10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-4-ansuelsmth@gmail.com>

On Mon, 19 Jun 2023, Christian Marangi wrote:

> Expose hw_control status via sysfs for the netdev trigger to give
> userspace better understanding of the current state of the trigger and
> the LED.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

