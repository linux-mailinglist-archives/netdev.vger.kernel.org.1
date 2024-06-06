Return-Path: <netdev+bounces-101340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9D8FE2F5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A51C24F2F
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2F15358F;
	Thu,  6 Jun 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwyJArQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DC13F45F;
	Thu,  6 Jun 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666468; cv=none; b=lX/iYw/unUwJ0nGQywFgzDfMfcHguJ/Zov9qoOJ60DIIm1pyPdep4xEf96EUBbLjRbF+NmMHATUIV/T3hVeAXJIIdm2SWUrXX7wMXC+W4phjH0b4XA/ALbpjiAEkFcTn3KwRy+ngkwcSfOnd7DFF+HITK+TXOnRLWeg24UAW9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666468; c=relaxed/simple;
	bh=8DJsXjzVmKHm3RmeoivdI/KL+nfdhfjGYXic0BYOQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKQVOAZENs6OKlQcDwyqFDkH909ucj8c5EvFOdR7sGJQXFAHfbjdl27e0puhgMhAZJEcAJGc3iIZml+C0MJdWBz0G7m7xUE58FSszfZby49VIrzq/KmHgXgEDj8jHds+OJX8ZJeyRAw7C3aW6Igflur+43feNDeXM6NJR9dIAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwyJArQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3103CC2BD10;
	Thu,  6 Jun 2024 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666467;
	bh=8DJsXjzVmKHm3RmeoivdI/KL+nfdhfjGYXic0BYOQLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwyJArQXGBLSXPUar3FTHcQcRsoH3E2NXmELLj7HmIX2GRLZpXmXKCymQUwto6j3g
	 d/2t5nAaZF4M7gaQ9uf2+nOMQnQM7vcV4f8txrR791VwhUNTVbcPUQztTzDoLUbxOj
	 5G7zGxb8FSeGV6qGongBSGB42rB35wQvTBwNVqq5XJ7NkTtXIRfJ9AsAoQCDNug+U/
	 If48Ghb4WcErdQXlILEtA+UrWzeQTpLLcLdRIIg/O4pFSPGFDJG173vQlxCSDHpw0L
	 PRZgOe3OYUplVrONWIcEJoR64ROpfeDOWfnZ8HTU1aer0mEg2A0aNP6Mks5N6FkPkR
	 ur+jcEjPkrUfA==
Date: Thu, 6 Jun 2024 10:34:23 +0100
From: Simon Horman <horms@kernel.org>
To: Kamil =?utf-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <20240606093423.GA875456@kernel.org>
References: <20240605095646.3924454-1-kamilh@axis.com>
 <20240605095646.3924454-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605095646.3924454-4-kamilh@axis.com>

On Wed, Jun 05, 2024 at 11:56:46AM +0200, Kamil Horák - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Change-Id: I592d261bc0d60aaa78fc1717a315b0b1c1449c81

Hi Kamil,

Please don't include tags for external trackers in upstream commit messages.

> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

...

> diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c

...

> +/**
> + * bcm_linkmode_adv_to_mii_adv_t

Please include a short description on the line above.

Flagged by kernel-doc -none -Wall

> + * @advertising: the linkmode advertisement settings
> + * @return: LDS Auto-Negotiation Advertised Ability register value
> + *
> + * A small helper function that translates linkmode advertisement
> + * settings to phy autonegotiation advertisements for the
> + * MII_BCM54XX_LREANAA register of Broadcom PHYs capable of LDS
> + */
> +static u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)

...

> +/**
> + * bcm_config_advert - sanitize and advertise auto-negotiation parameters
> + * @phydev: target phy_device struct
> + *
> + * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
> + *   after sanitizing the values to make sure we only advertise
> + *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
> + *   hasn't changed, and > 0 if it has changed.
> + */
> +int bcm_config_advert(struct phy_device *phydev)

Please consider including a Return: section in Kernel docs
for functions that return a value. Likewise for lre_update_link.

Also flagged by kernel-doc -none -Wall

...

> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c

...

> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	int val, err;
> +	int i;
> +	u8 brr_mode;
> +	static const int modes_array[] = { ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Half_BIT };

Please consider arranging local variables in reverse xmas tree order -
longest like to shortest.

Edward Cree's tool can be useful here:
https://github.com/ecree-solarflare/xmastree

...

