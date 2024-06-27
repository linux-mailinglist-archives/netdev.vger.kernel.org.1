Return-Path: <netdev+bounces-107394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5455391AC83
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C971C2295B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EB199393;
	Thu, 27 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AfIin8oj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE815278F;
	Thu, 27 Jun 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505387; cv=none; b=SQCDNNHNawurxaeNWKK/fgor57cjO7OL8HklIvcTV9JcuqZBwRJz2d1u8SdZP9iStVaimKTlR+wFjog793giO5XiwP3wmPN4fwf69MYtyPELm5ceMhgWDV3fsb3JNwIiNYHCrMKlXlFJAvf1e7ZMi0C4cYe+aeSIGtnesy+rbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505387; c=relaxed/simple;
	bh=ce0Lf6cLG/oWobGf6UUFLUur95J/usihAos6azlJk00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZxjvHMGR9BgIXnCiL1nUiQcckbs3NIEd1LCr3x3WsXjgDy9ousANfjUgcn2PQb2XcO2Yo70nUU9Hf/KjOCFwoeN73a9fw1TzT2gRm06os87u9IY65i86yvoo6kgGTp64mbPzurZrg8V0uU8jZ/9MIc46DX84bhk0mIyZEOLd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AfIin8oj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9yIt2RqXi4xlDWsgfmXanE1cqNWmdPxgfzW0xNM2P0I=; b=AfIin8ojKyz8W63YRMVVq81VJa
	rXGjcHVSDalj6qFaRDfxsmN4NbfICzLNCCs9p/+4U/FJg6vWylFx3OUxc6GyxaLK4Xs37Bz4TS1n3
	kKIQuL5KhAyZ1mZHXkkqNmewmDchMhyZFdMc1kyfCaRO2D2RaAqDl4C4YW8z7tqu2/Qs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMrti-001Bbh-AT; Thu, 27 Jun 2024 18:22:58 +0200
Date: Thu, 27 Jun 2024 18:22:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <ea452581-c903-4106-b912-d307f74f773d@lunn.ch>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113018.25083-4-brgl@bgdev.pl>

On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for a new model to the Aquantia driver. This PHY supports
> Overlocked SGMII mode with 2.5G speeds.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 39 +++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 974795bd0860..98ccefd355d5 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -29,6 +29,7 @@
>  #define PHY_ID_AQR113	0x31c31c40
>  #define PHY_ID_AQR113C	0x31c31c12
>  #define PHY_ID_AQR114C	0x31c31c22
> +#define PHY_ID_AQR115C	0x31c31c33
>  #define PHY_ID_AQR813	0x31c31cb2
>  
>  #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
> @@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phydev, int index)
>  	int len_h = stat->size - len_l;
>  	u64 ret;
>  	int val;
> -
>  	val = phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
>  	if (val < 0)
>  		return U64_MAX;

White space change. And that blank line is actually wanted to separate
the variables from the code.

    Andrew

---
pw-bot: cr

