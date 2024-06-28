Return-Path: <netdev+bounces-107710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056591C0E6
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F70B1C21D88
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11061BF336;
	Fri, 28 Jun 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv7msHHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFF14D718;
	Fri, 28 Jun 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584867; cv=none; b=NzPIQGBszSge7z8LsfJbdZi7R9f3IdMueeWTC2cH8DchyBNACEFQhxOpQzbVAzzGMM0hiMlTzo1mCDAifxdNdkySQU65Fm60JGFjHzGascm01UttXhBPb+YVK5kSonb+1uuS7KSvCIV2tRCvKAL4kiC8gZyFIizVIqvhh9Aq0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584867; c=relaxed/simple;
	bh=1Ha5YqmI27/7Y8SSb4D1NvuKFKN/iE/n0d75yTTLZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6SxqoMZX/jyXe7Xw8bXv82PfEzx/apxR/ONQRhEHyCDIgmzIlq0KsCETNXTJrE4V8rw8N9juWuiTDjxUFvfInY1N05fSA3jE2AIurz9tEbA807lRTzOr31P6ypiEthj9Zfpgpb0kZ8gR+Oq/PuhtegeG0VJZ2jvlPYJPt0rWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv7msHHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CE9C116B1;
	Fri, 28 Jun 2024 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719584867;
	bh=1Ha5YqmI27/7Y8SSb4D1NvuKFKN/iE/n0d75yTTLZPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qv7msHHW6ME9IOhpV+DZTsRl/QONElsPKZtEYl+Q+RxHGVr3qEnKHBKOP2UvL0XIc
	 MviaSg4ldwoCTg7m0WT9egeldDokDvNbxycHBntii+GDKBZbi0py6KLLOIEHOOV3qN
	 5HumM9OcsJQQNnl/swAE1nAX31n5xxtXnYOfvdkd80SksjXnSDJKRUYa0sFVRisWSh
	 FtCXGCNxZ905lZsJmUCOYx9MwepedGaDusjTLyiJVksfsDK9gI7aRLfZs8fxGusgOf
	 tjs1PzeqSUQU1PtfMHayEb2fWdmjZk+BhdPMmaR32+fbZ0tQAcHu2FHdC28OwMyJgz
	 hsNiN+R4bROEg==
Date: Fri, 28 Jun 2024 15:27:42 +0100
From: Simon Horman <horms@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2] net: phy: realtek: Add support for PHY LEDs
 on RTL8211F
Message-ID: <20240628142742.GH783093@kernel.org>
References: <20240625204221.265139-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625204221.265139-1-marex@denx.de>

On Tue, Jun 25, 2024 at 10:42:17PM +0200, Marek Vasut wrote:
> Realtek RTL8211F Ethernet PHY supports 3 LED pins which are used to
> indicate link status and activity. Add minimal LED controller driver
> supporting the most common uses with the 'netdev' trigger.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Christophe Roullier <christophe.roullier@foss.st.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
> V2: - RX and TX are not differentiated, either both are set or not set,
>       filter this in rtl8211f_led_hw_is_supported()
> ---
>  drivers/net/phy/realtek.c | 106 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 2174893c974f3..bed839237fb55 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -32,6 +32,15 @@
>  #define RTL8211F_PHYCR2				0x19
>  #define RTL8211F_INSR				0x1d
>  
> +#define RTL8211F_LEDCR				0x10
> +#define RTL8211F_LEDCR_MODE			BIT(15)
> +#define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
> +#define RTL8211F_LEDCR_LINK_1000		BIT(3)
> +#define RTL8211F_LEDCR_LINK_100			BIT(1)
> +#define RTL8211F_LEDCR_LINK_10			BIT(0)
> +#define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
> +#define RTL8211F_LEDCR_SHIFT			5
> +

Hi Marek,

FWIIW, I think that if you use FIELD_PREP and FIELD_GET then
RTL8211F_LEDCR_SHIFT can be removed.

...

