Return-Path: <netdev+bounces-129015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118097CEC2
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFC72849DD
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9A142904;
	Thu, 19 Sep 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vbxDzdS5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8222612
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781216; cv=none; b=F73LxIRvkj8RGkvx/OC24w1gRa04PeBbe23cxFhyHdWu/6iNHIznRGn9u9lDaQcn+R4/dZknKhliJPYohpxOmd8yL/PP68TFYf00f/lduHRgiPNOMT2SUK9OEpwaOCiJi+fGqfGHmGzjLsNQYCRLTTHOkH888DVogEY6k5ZVh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781216; c=relaxed/simple;
	bh=sOcscuqdfTBW/WiGNPUV1bfd2iGy3Po6X5rbuoh4c+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV/rUdWjc5ldPMnfmiMh7sF78Xr2qCeT7sjTgBJFQh9ZaoXA3eF9hhPMCRqOv8VNe8i+0VC0uYUUD5xgbNKTi+KtiMiVu3Iu7ha+rXec2rMO1hiif/X0AK2kSyz05QQAMf7biuSUWm76T9LB8yVmyvN2P0Eb2arxNmNKtu3kEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vbxDzdS5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zzJz6Bvn33NkB2HXzexgOrayU+Fgz/iqPyR2w8elg3w=; b=vbxDzdS5Gnoe0F+bugZzvGeZTc
	tBlX655KvqjWrZ+kDmP17U+aJtQhx7Uo3RnosjrXLZ+5dHTe/k5ySLgsPkZSmiGBZ5Gy3pF2CBweg
	iQOwSGSXTxt91fe49rmUf8rxzpdo9rKITo7622zHwhBsNPZ3PGEzU2T7crZr4ppdmu8A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srOfp-007qpX-P4; Thu, 19 Sep 2024 23:26:49 +0200
Date: Thu, 19 Sep 2024 23:26:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, o.rempel@pengutronix.de,
	spatton@ti.com, r-kommineni@ti.com, e-mayhew@ti.com,
	praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 3/5] net: phy: dp83tg720: Extending support to DP83TG721
 PHY
Message-ID: <0092fd9d-22e4-458a-8227-618fc56f5459@lunn.ch>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <d75b772038e37452f262b6c2d87796966f92a18e.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75b772038e37452f262b6c2d87796966f92a18e.1726263095.git.a-reyes1@ti.com>

On Thu, Sep 19, 2024 at 02:01:17PM -0700, Alvaro (Al-vuh-roe) Reyes wrote:
> The DP83TG721 is the next revision of the DP83TG720 and will share the
> same driver. Added PHY_ID and probe funtion to check which version is
> being loaded. 

Please don't mix whitespace changes with real code changes. It makes
it harder to see the real changes which need reviewing.

> +enum DP83TG720_chip_type {
> +	DP83TG720_CS1_1,
> +	DP83TG721_CS1,
> +};
> +
> +struct DP83TG720_private {
> +	int chip;

I _think_ this should be enum DP83TG720_chip_type chip;

> +	bool is_master;

I think this can be removed and replaced with
phydev->master_slave_set. You probably want to mirror it into
phydev->master_slave_get.

phydev->master_slave_state normally contains the result of auto-neg,
but i expect this PHY forces it, so again, you probably want to mirror
it here as well. Test it out with ethtool and make sure it reports
what you expect.

> +	struct DP83TG720_private *DP83TG720;

Upper case is very unusual in mainline. It is generally only used for
CPP macros.

> +static struct phy_driver dp83tg720_driver[] = {
> +    DP83TG720_PHY_DRIVER(DP83TG720_CS_1_1_PHY_ID, "TI DP83TG720CS1.1"),
> +	DP83TG720_PHY_DRIVER(DP83TG721_CS_1_0_PHY_ID, "TI DP83TG721CS1.0"),
> +};

Indentation is messed up here. I expect checkpatch says something
about this?

>  module_phy_driver(dp83tg720_driver);
>  
>  static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
> -	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
> -	{ }
> +    { PHY_ID_MATCH_EXACT(DP83TG720_CS_1_1_PHY_ID) },
> +	{ PHY_ID_MATCH_EXACT(DP83TG721_CS_1_0_PHY_ID) },
> +	{ },

Here as well.

>  };
>  MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
>  
> +// static struct phy_driver dp83tg720_driver[] = {
> +// {
> +// 	PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID),
> +// 	.name		= "TI DP83TG720",
> +
> +// 	.flags          = PHY_POLL_CABLE_TEST,
> +// 	.config_aneg	= dp83tg720_config_aneg,
> +// 	.read_status	= dp83tg720_read_status,
> +// 	.get_features	= genphy_c45_pma_read_ext_abilities,
> +// 	.config_init	= dp83tg720_config_init,
> +// 	.get_sqi	= dp83tg720_get_sqi,
> +// 	.get_sqi_max	= dp83tg720_get_sqi_max,
> +// 	.cable_test_start = dp83tg720_cable_test_start,
> +// 	.cable_test_get_status = dp83tg720_cable_test_get_status,
> +
> +// 	.suspend	= genphy_suspend,
> +// 	.resume		= genphy_resume,
> +// } };
> +// module_phy_driver(dp83tg720_driver);
> +
> +// static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
> +// 	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
> +// 	{ }
> +// };
> +// MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);

Please don't add code which is commented out.


    Andrew

---
pw-bot: cr

