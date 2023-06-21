Return-Path: <netdev+bounces-12689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB5573880A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796111C20ECE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72818C2B;
	Wed, 21 Jun 2023 14:55:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559618C2A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E27C433C0;
	Wed, 21 Jun 2023 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687359317;
	bh=XmUJrXEv6FpzPmLHQQVKfx65ofQ5ze4boTYNspgJr0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYY4WwazOEzAfa9uKMwIbqFeb+IwrNPKg0dDGTL6E7G6rgUqeA0xh8V/X/BLAsJhV
	 XDXyL+NFeKMO2zqsjJ1rcizAgnq1s7xYwvZT4mLYs1F1FmPSKv0RW/NjLyP+PNCv+0
	 QwEryrNC1YNYuoZsGXdEIc5G4hpbgicTWFN36uW9/MZXO+XenFgx0etsg+4rFu6vs0
	 VF3r7OeijylkG4EdhEFUXQcL8ih80xDn/M/Y8htSzcG9/mqw62TfHt9Aw2tjf7uvMh
	 m5PPoUII+bQqsaECsXCOVfgaw0EOp4mDPJ9/4Co35eUq4hgbL9IWgpdGUxUwHcPZay
	 tT30H/lAr7EkA==
Date: Wed, 21 Jun 2023 15:55:12 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 2/3] leds: trigger: netdev: add additional
 specific link duplex mode
Message-ID: <20230621145512.GB10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-3-ansuelsmth@gmail.com>

On Mon, 19 Jun 2023, Christian Marangi wrote:

> Add additional modes for specific link duplex. Use ethtool APIs to get the
> current link duplex and enable the LED accordingly. Under netdev event
> handler the rtnl lock is already held and is not needed to be set to
> access ethtool APIs.
> 
> This is especially useful for PHY and Switch that supports LEDs hw
> control for specific link duplex.
> 
> Add additional modes:
> - half_duplex: Turn on LED when link is half duplex
> - full_duplex: Turn on LED when link is full duplex
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 27 +++++++++++++++++++++++++--
>  include/linux/leds.h                  |  2 ++
>  2 files changed, 27 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

