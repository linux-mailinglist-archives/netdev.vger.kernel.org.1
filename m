Return-Path: <netdev+bounces-93695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D38BCCC6
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 13:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C40C283067
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C589142E85;
	Mon,  6 May 2024 11:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C314262C;
	Mon,  6 May 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994675; cv=none; b=YxBhyl2AtJiDyEuzRlUev1epEFBCGYRyK32Az8nQzNXObKZfCwegaxQeXd+r76VtTpkqGdIRY0vCGoXR+p+hgg3jYhhBNRyJdUDQma/kWV5VP/ElJ4fN6Hggr5iOdsEcv/HN5tPWpT+DcY121WWHzUgScVA8YB3tYFNxm/TjGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994675; c=relaxed/simple;
	bh=eh/Jl7ow3G5csXcfFyd1/lkvB9y3DrTGKYKArXTKXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n43T47lQX0WwAxRawPIzUazTwG0f6w/gPyBvO047oE2nKSQBTuQLI+m3p07Q9VTZgKHBYUKGh0BQr9wGOHrXObJ2JVWUoFXO291aAR3dBzLMu7VtcVqbaEnee6aaAkWG2G1VIRb79eRG3jt9jzykJS2sy4ABAmfo5UNgxXQ/aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s3wSD-000000005mU-15Wb;
	Mon, 06 May 2024 11:24:21 +0000
Date: Mon, 6 May 2024 12:24:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: arinc.unal@arinc9.com
Cc: DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: detect PHY muxing when PHY
 is defined on switch MDIO bus
Message-ID: <Zji94d4yfEBaHlzt@makrotopia.org>
References: <20240430-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v2-1-9104d886d0db@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v2-1-9104d886d0db@arinc9.com>

On Tue, Apr 30, 2024 at 08:01:33AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
> direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
> bus the switch listens on. The PHY muxing feature makes use of this.
> 
> This is problematic as the PHY may be attached before the switch is
> initialised, in which case, the PHY will fail to be attached.
> 
> Since commit 91374ba537bd ("net: dsa: mt7530: support OF-based registration
> of switch MDIO bus"), we can describe the switch PHYs on the MDIO bus of
> the switch on the device tree. Extend the check to detect PHY muxing when
> the PHY is defined on the MDIO bus of the switch on the device tree.
> 
> When the PHY is described this way, the switch will be initialised first,
> then the switch MDIO bus will be registered. Only after these steps, the
> PHY will be attached.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
> Changes in v2:
> - Address the terminology on the patch log.
> - Link to v1: https://lore.kernel.org/r/20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v1-1-1f775983e155@arinc9.com
> ---
>  drivers/net/dsa/mt7530.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 2b9f904a98f0..6cf21c9d523b 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2483,7 +2483,8 @@ mt7530_setup(struct dsa_switch *ds)
>  			if (!phy_node)
>  				continue;
>  
> -			if (phy_node->parent == priv->dev->of_node->parent) {
> +			if (phy_node->parent == priv->dev->of_node->parent ||
> +			    phy_node->parent->parent == priv->dev->of_node) {

I had some concerns about missing check for phy_node->parent != NULL,
but it's impossible in practise. If phy_node exists, it will have a parent
node as well.

To be super extra safe, maybe doing
phy_node->parent && phy_node->parent->parent == priv->dev->of_node
would be better.

>  				ret = of_get_phy_mode(mac_np, &interface);
>  				if (ret && ret != -ENODEV) {
>  					of_node_put(mac_np);
> 
> ---
> base-commit: 5c4c0edca68a5841a8d53ccd49596fe199c8334c
> change-id: 20240429-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-586269371c55
> 
> Best regards,
> -- 
> Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> 
> 

