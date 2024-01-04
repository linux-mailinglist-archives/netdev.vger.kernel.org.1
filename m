Return-Path: <netdev+bounces-61686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A488824A1C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4461F21DF4
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E82C681;
	Thu,  4 Jan 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8xDrUH7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8BB2C1AD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4507C433C8;
	Thu,  4 Jan 2024 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704403026;
	bh=znGFu4XDpHsOKdZPT43E7eV9iNDDsdhfOHHSu73cgB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8xDrUH7G/HFGAg2fb+iuUfBha8yicIT63b+oTBwmlxiV6h0ku7UPybAHx54biSwI
	 v2wfRyXDkn+FwzfpswAzyd9QQcp/UR6GQqy0/+0U6zIaAiR5sk8/PYmOwITaXFTzgD
	 FXL0yeUCr9oPGOmFH5NUVoETUPj+K2yNu5d5rGMYhJ2E643POXbAUzaHZXBGqUXMPs
	 nZNPs2vPVMbeeYaFaRll1tR6QOsH4iZkpqHBx7+xD574763E7s4o6AYAJ9/5g0b+Mg
	 c+hxF5Un4w4nym1gc5BS0q+aCC9I0iNoNphEFY+DmbVAXsAvxXM4OMqUoH7+eBAr8z
	 9BnuTw+JnGHzg==
Date: Thu, 4 Jan 2024 21:17:02 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] r8169: fix building with CONFIG_LEDS_CLASS=m
Message-ID: <20240104211702.GP31813@kernel.org>
References: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>

On Wed, Jan 03, 2024 at 04:52:04PM +0100, Heiner Kallweit wrote:
> When r8169 is built-in but LED support is a loadable module, the new
> code to drive the LED causes a link failure:
> 
> ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
> r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'
> 
> LED support is an optional feature, so fix this issue by adding a Kconfig
> symbol R8169_LEDS that is guaranteed to be false if r8169 is built-in
> and LED core support is a module. As a positive side effect of this change
> r8169_leds.o no longer is built under this configuration.
> 
> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312281159.9TPeXbNd-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

...

