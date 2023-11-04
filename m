Return-Path: <netdev+bounces-46062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD47E10A0
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 19:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F74B20E54
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3114F9D;
	Sat,  4 Nov 2023 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5LVsYt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0A747B
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9FC433C7;
	Sat,  4 Nov 2023 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699123163;
	bh=iNbBO4/XmUOZDn0D5os9SPWWF4W3nINXE0T8SrfiVtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5LVsYt9BhiPD0ItgxMa/VPuDRXCsB983VK1qLqFs16jS7k9+DaTph88Mct0RPOdH
	 AuWPw+Pdd4iaWA+4mgFmZxghMPWIyELRbXGDTbqgKpgvQuN2+nefyJ72r/me+twdvV
	 /Xwp1+FlKd1ryzH8kHJ+lvFtJAgCt3pl8QwI6MQfUFm62VdSxjJCSgn7Q0GmwgJpH8
	 6H6N3UNiFVksj2BWJYemLLfDHXfH+w3SHn9tOJtAP7gvatpYon4RvuzSvXpYm725tS
	 4eON+wUwlBXqTbzH1oVbfWzR0KPtpg5/EEBYZj3uD6nDLnnEqcSLIRlSeZzuIXzUHJ
	 k2/fQK4KK8oqQ==
Date: Sat, 4 Nov 2023 14:39:04 -0400
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <20231104183904.GO891380@kernel.org>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-13-justinlai0215@realtek.com>

On Thu, Nov 02, 2023 at 11:45:04PM +0800, Justin Lai wrote:
> 1. Add the RTASE entry in the Kconfig.
> 2. Add the CONFIG_RTASE entry in the Makefile.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/Kconfig  | 17 +++++++++++++++++
>  drivers/net/ethernet/realtek/Makefile |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index 93d9df55b361..57ef924deebd 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -113,4 +113,21 @@ config R8169
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called r8169.  This is recommended.
>  
> +config RTASE
> +	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> +	depends on PCI
> +	select CRC32
> +	help
> +	  Say Y here if you have a Realtek Ethernet adapter belonging to
> +	  the following families:
> +	  RTL9054 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9072 5GBit Ethernet
> +	  RTL9075 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9071 5GBit Ethernet
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rtase. This is recommended.
> +
>  endif # NET_VENDOR_REALTEK
> diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
> index 2e1d78b106b0..0c1c16f63e9a 100644
> --- a/drivers/net/ethernet/realtek/Makefile
> +++ b/drivers/net/ethernet/realtek/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) += 8139too.o
>  obj-$(CONFIG_ATP) += atp.o
>  r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
>  obj-$(CONFIG_R8169) += r8169.o
> +obj-$(CONFIG_RTASE) += rtase/

An allmodconfig on x86_64 fails to build with the series applied up to this
point.

../drivers/net/ethernet/realtek/rtase/rtase_main.c:68:10: fatal error: net/page_pool.h: No such file or directory    68 | #include <net/page_pool.h>

Please also note that, net-next closed, as per the following:

## Form letter - net-next-closed

The merge window for v6.7 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after November 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: cr

