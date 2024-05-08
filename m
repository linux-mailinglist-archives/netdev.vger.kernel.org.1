Return-Path: <netdev+bounces-94432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7987D8BF73B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB91F2158C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A982C85F;
	Wed,  8 May 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaiOBOFF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF192C197;
	Wed,  8 May 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154087; cv=none; b=noZe6u3J67DZU8gZWmmaqYTM0i/ke40XydovrbFGROB6xc+ZRPvuAmEtiR9huaBiJk/fZhhGP3ALT6hoiLZDaULlRMUrROnVewdxW8751I9QD891bRlOXgSw1/mQRyDmAmxzE3oUgqNrNio4v9t9msRspUMThsJAKRs0OaYyq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154087; c=relaxed/simple;
	bh=hpUE2jTXU0F1c21XagX7+x/2j0uwkL8RIi4dEVUUWjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s82dtUhe2NIOqUuhxZibXLh/yAX9r7oSdksR6Xx8hKU/J2Qkh0VVXHPXjeV1Puvy7d+JJ9P/7i/yeqAPqsdEblQZv9+bVUvj2KPgaiWmOYvFs74amS7rSQChpno6B0a4pm3H5WCYcrDNWn9xIyXCKpfP7zcQlrGjGG9ba12MGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaiOBOFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19113C113CC;
	Wed,  8 May 2024 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715154086;
	bh=hpUE2jTXU0F1c21XagX7+x/2j0uwkL8RIi4dEVUUWjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaiOBOFFPbftdumizgVPQf/0/TNG2AthXwiYZS0H7klZ0CrHAPbEyAtFp0plfzZ2n
	 zNcat72gsbL81UQ47BFr5XAi0HisnZnSZPri4yZ9fJjmI9cX7ELnUzftzjNTM4JRAQ
	 Zdp5Xg4T8SDR0i4xT5iPa1emBQ/KcTyLJnhKmPoOFHLSA0eB7OqGm14iqoqDswL4Ay
	 lhICi1SMAk0BbGBxEeZM91uYn/KFBNWp2Ed1Grq51nn5heACqUsWvVVMOVKcTkRFKz
	 NaQ7ZNCXaNiWPJYegu+eSPBF0o6IFwkTnDN9iAAu4aRVKtZzoVymZL/6n8ymjVYKfP
	 jLu7ixfPNG5ww==
Date: Wed, 8 May 2024 08:39:52 +0100
From: Simon Horman <horms@kernel.org>
To: Kamil =?utf-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <20240508073952.GL15955@kernel.org>
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506144015.2409715-4-kamilh@axis.com>

On Mon, May 06, 2024 at 04:40:15PM +0200, Kamil Horák - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

Hi Kamil,

Some minor feedback from my side.

...

> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c

...

> +/**
> + * bcm_linkmode_adv_to_mii_adv_t
> + * @advertising: the linkmode advertisement settings
> + *
> + * A small helper function that translates linkmode advertisement
> + * settings to phy autonegotiation advertisements for the
> + * MII_BCM54XX_LREANAA register.

Please consider including a Return: section in the Kernel doc.

Flagged by ./scripts/kernel-doc -Wall -none

> + */
> +static inline u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)

...

> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c

...

> +static int bcm_read_master_slave(struct phy_device *phydev)
> +{
> +	int cfg, state;
> +	int val;
> +
> +	/* In BroadR-Reach mode we are always capable of master-slave
> +	 *  and there is no preferred master or slave configuration
> +	 */
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> +
> +	val = phy_read(phydev, MII_BCM54XX_LRECR);
> +	if (val < 0)
> +		return val;
> +
> +	if ((val & LRECR_LDSEN) == 0) {
> +		if (val & LRECR_MASTER)
> +			cfg = MASTER_SLAVE_CFG_MASTER_FORCE;
> +		else
> +			cfg = MASTER_SLAVE_CFG_SLAVE_FORCE;
> +	}
> +
> +	val = phy_read(phydev, MII_BCM54XX_LRELDSE);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & LDSE_MASTER)
> +		state = MASTER_SLAVE_STATE_MASTER;
> +	else
> +		state = MASTER_SLAVE_STATE_SLAVE;
> +
> +	phydev->master_slave_get = cfg;

Perhaps it is not possible, but it appears that if the
((val & LRECR_LDSEN) == 0) condition above is not met then
cfg is used uninitialised here.

Flagged by Smatch.

> +	phydev->master_slave_state = state;
> +
> +	return 0;
> +}

...

