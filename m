Return-Path: <netdev+bounces-194178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84107AC7B23
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85C23A681C
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7921CC4E;
	Thu, 29 May 2025 09:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457DA55;
	Thu, 29 May 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511385; cv=none; b=uhBPRr/oq4eY4ZF8mEtXQ7IE6kEHN9NLYf9XhZVjjQCSAz9um1n5D/e0zXyw1fTu3om8+JTMoYgmWt7DVRBEPsqlKRR4xZAstV7CMNFLHPFz3N5v9SyYtMSoasmvKKFJBGAoUfo76m0L2HeRk2rF9agNW+QSuvf5ys9Me4keHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511385; c=relaxed/simple;
	bh=gaF5Ga/SDYyLA/gy712Lj1wQY110WLuZQSj7+ZURG5w=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U+6e9CffRwYkbSAhROEcD6L0RMRr7m4faBLdr1BHQ+5G+wBDk2Yqj015G6jSzDdkSvggvs1eeZFgZojbDQ7SJM6TdSXUrumI87lryUQreeH1IjFR0YfSBjp+KxRYG8ETJPlovaTQ5VS4yxFURvXnQL86eI8A20bYO+PGTdPeRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b7Lqg0hnZz27hd7;
	Thu, 29 May 2025 17:37:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E769E1401F0;
	Thu, 29 May 2025 17:36:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 May 2025 17:36:11 +0800
Message-ID: <5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
Date: Thu, 29 May 2025 17:36:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?=
	<kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>
Subject: Re: [PATCH net-next v5 07/13] net: phy: phy_caps: Allow looking-up
 link caps based on speed and duplex
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-8-maxime.chevallier@bootlin.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250307173611.129125-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/3/8 1:36, Maxime Chevallier wrote:
> As the link_caps array is efficient for <speed,duplex> lookups,
> implement a function for speed/duplex lookups that matches a given
> mask. This replicates to some extent the phy_lookup_settings()
> behaviour, matching full link_capabilities instead of a single linkmode.
>
> phy.c's phy_santize_settings() and phylink's
> phylink_ethtool_ksettings_set() performs such lookup using the
> phy_settings table, but are only interested in the actual speed/duplex
> that were matched, rathet than the individual linkmode.
>
> Similar to phy_lookup_settings(), the newly introduced phy_caps_lookup()
> will run through the link_caps[] array by descending speed/duplex order.
>
> If the link_capabilities for a given <speed/duplex> tuple intersects the
> passed linkmodes, we consider that a match.
>
> Similar to phy_lookup_settings(), we also allow passing an 'exact'
> boolean, allowing non-exact match. Here, we MUST always match the
> linkmodes mask, but we allow matching on lower speed settings.
>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>   drivers/net/phy/phy-caps.h |  4 ++++
>   drivers/net/phy/phy.c      | 32 ++++++--------------------
>   drivers/net/phy/phy_caps.c | 47 ++++++++++++++++++++++++++++++++++++++
>   drivers/net/phy/phylink.c  | 17 +++++++-------
>   4 files changed, 67 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> index 8833798f141f..aef4b54a8429 100644
> --- a/drivers/net/phy/phy-caps.h
> +++ b/drivers/net/phy/phy-caps.h
> @@ -51,4 +51,8 @@ phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
>   const struct link_capabilities *
>   phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only);
>   
> +const struct link_capabilities *
> +phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
> +		bool exact);
> +
>   #endif /* __PHY_CAPS_H */
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 8df37d221fba..562acde89224 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -213,25 +213,6 @@ int phy_aneg_done(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL(phy_aneg_done);
>   
> -/**
> - * phy_find_valid - find a PHY setting that matches the requested parameters
> - * @speed: desired speed
> - * @duplex: desired duplex
> - * @supported: mask of supported link modes
> - *
> - * Locate a supported phy setting that is, in priority order:
> - * - an exact match for the specified speed and duplex mode
> - * - a match for the specified speed, or slower speed
> - * - the slowest supported speed
> - * Returns the matched phy_setting entry, or %NULL if no supported phy
> - * settings were found.
> - */
> -static const struct phy_setting *
> -phy_find_valid(int speed, int duplex, unsigned long *supported)
> -{
> -	return phy_lookup_setting(speed, duplex, supported, false);
> -}
> -
>   /**
>    * phy_supported_speeds - return all speeds currently supported by a phy device
>    * @phy: The phy device to return supported speeds of.
> @@ -274,13 +255,14 @@ EXPORT_SYMBOL(phy_check_valid);
>    */
>   static void phy_sanitize_settings(struct phy_device *phydev)
>   {
> -	const struct phy_setting *setting;
> +	const struct link_capabilities *c;
> +
> +	c = phy_caps_lookup(phydev->speed, phydev->duplex, phydev->supported,
> +			    false);
>   
> -	setting = phy_find_valid(phydev->speed, phydev->duplex,
> -				 phydev->supported);
> -	if (setting) {
> -		phydev->speed = setting->speed;
> -		phydev->duplex = setting->duplex;
> +	if (c) {
> +		phydev->speed = c->speed;
> +		phydev->duplex = c->duplex;
>   	} else {
>   		/* We failed to find anything (no supported speeds?) */
>   		phydev->speed = SPEED_UNKNOWN;
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index c39f38c12ef2..0366feee2912 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -170,6 +170,53 @@ phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only)
>   	return NULL;
>   }
>   
> +/**
> + * phy_caps_lookup() - Lookup capabilities by speed/duplex that matches a mask
> + * @speed: Speed to match
> + * @duplex: Duplex to match
> + * @supported: Mask of linkmodes to match
> + * @exact: Perform an exact match or not.
> + *
> + * Lookup a link_capabilities entry that intersect the supported linkmodes mask,
> + * and that matches the passed speed and duplex.
> + *
> + * When @exact is set, an exact match is performed on speed and duplex, meaning
> + * that if the linkmodes for the given speed and duplex intersect the supported
> + * mask, this capability is returned, otherwise we don't have a match and return
> + * NULL.
> + *
> + * When @exact is not set, we return either an exact match, or matching capabilities
> + * at lower speed, or the lowest matching speed, or NULL.
> + *
> + * Returns: a matched link_capabilities according to the above process, NULL
> + *	    otherwise.
> + */
> +const struct link_capabilities *
> +phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
> +		bool exact)
> +{
> +	const struct link_capabilities *lcap, *last = NULL;
> +
> +	for_each_link_caps_desc_speed(lcap) {
> +		if (linkmode_intersects(lcap->linkmodes, supported)) {
> +			last = lcap;
> +			/* exact match on speed and duplex*/
> +			if (lcap->speed == speed && lcap->duplex == duplex) {
> +				return lcap;
> +			} else if (!exact) {
> +				if (lcap->speed <= speed)
> +					return lcap;
> +			}
> +		}
> +	}
> +
> +	if (!exact)
> +		return last;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(phy_caps_lookup);
> +
>   /**
>    * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
>    * @max_speed: Speed limit for the linkmode set
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a3f64b6d2d34..cf9f019382ad 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -20,6 +20,7 @@
>   #include <linux/timer.h>
>   #include <linux/workqueue.h>
>   
> +#include "phy-caps.h"
>   #include "sfp.h"
>   #include "swphy.h"
>   
> @@ -2852,8 +2853,8 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>   				  const struct ethtool_link_ksettings *kset)
>   {
>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
> +	const struct link_capabilities *c;
>   	struct phylink_link_state config;
> -	const struct phy_setting *s;
>   
>   	ASSERT_RTNL();
>   
> @@ -2896,23 +2897,23 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
>   		/* Autonegotiation disabled, select a suitable speed and
>   		 * duplex.
>   		 */
> -		s = phy_lookup_setting(kset->base.speed, kset->base.duplex,
> -				       pl->supported, false);
> -		if (!s)
> +		c = phy_caps_lookup(kset->base.speed, kset->base.duplex,
> +				    pl->supported, false);
> +		if (!c)
>   			return -EINVAL;



Hi Maxime,  fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex") might have different behavior than the modification.
My case is set 10M Half with disable autoneg both sides and I expect it is
link in 10M Half. But now, it is link in 10M Full，which is not what I
expect.

I used followed command and trace how phy worked.
	ethtool -s eth1 autoneg off speed 10 duplex half
The log is showed as followed:
ethtool-13127	[067]	6164.771853: phy_ethtool_ksettings set: (phy_ethtool ksettings set+0x0/0x200) duplex=0 speed=10
kworker/u322:2-11096	[070]	6164.771853:	_phy_start_aneq: ( _phy_start_aneg+0x0/0xb8) duplex=0 speed=10
kworker/u322:2-11096	[070]	6164.771854:	phy_caps_lookup: (phy_caps_lookup+0x0/0xf0) duplex=0 speed=10
kworker/u322:2-11096	[070]	6164.771855:	phy_config_aneg: (phy_config_aneg+0x0/0x70) duplex=1 speed=10
kworker/u322:2-11096	[070]	6164.771856:	genphy_config_aneg:	(__genphy_config_aneg+0X0/0X270) duplex=1 speed=10

I also try to fixed it and it works. Do you have any idea about it.

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0e762fc3a529..2986c41c42a8 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -258,7 +258,7 @@ static void phy_sanitize_settings(struct phy_device *phydev)
         const struct link_capabilities *c;

         c = phy_caps_lookup(phydev->speed, phydev->duplex, phydev->supported,
-                           false);
+                           true);

         if (c) {
                 phydev->speed = c->speed;



>   
>   		/* If we have a fixed link, refuse to change link parameters.
>   		 * If the link parameters match, accept them but do nothing.
>   		 */
>   		if (pl->req_link_an_mode == MLO_AN_FIXED) {
> -			if (s->speed != pl->link_config.speed ||
> -			    s->duplex != pl->link_config.duplex)
> +			if (c->speed != pl->link_config.speed ||
> +			    c->duplex != pl->link_config.duplex)
>   				return -EINVAL;
>   			return 0;
>   		}
>   
> -		config.speed = s->speed;
> -		config.duplex = s->duplex;
> +		config.speed = c->speed;
> +		config.duplex = c->duplex;
>   		break;
>   
>   	case AUTONEG_ENABLE:

