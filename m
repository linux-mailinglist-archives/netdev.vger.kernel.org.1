Return-Path: <netdev+bounces-96354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18458C5629
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FE51C2177D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4F6CDA3;
	Tue, 14 May 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DqO/Qli5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C806BB39;
	Tue, 14 May 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690848; cv=none; b=bnqz3ApdgoiaOSEeNo2e5j0Wvy4oUz+adOpv8ktuXrLHlQMClZGYHDODoLRpLrI8o+ZFdN3TeOmlUFYCmOqPxQRhyZMbzifAgRjK8cHzj6QloWMNJI/ygqKC2NvDs7Gm5piQKr4PqKUommOeVxk/YyochKnPnCZP0aiLckdknCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690848; c=relaxed/simple;
	bh=tYB1OhNUKDw8GoD1uJ1/9nUQk/BqbBA+1FOGe3FpxuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN43cMZui9C0YpMzQrKD4TN+28i5f4MJHLnncV7dx+veBGeTYToJ+B3TFcpjX2RIj3rGeYLaAjbQJDIILY+SegjAqAjsB5x1/aniv+fOq6lleWAkAbIG9iljgvCffO8t30HcxEbYZ/lrZ+vqE8pudNyBu7+No2dm8IIRAwo69bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DqO/Qli5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ItJZyxADy9lJjdoZnGrHNtUW02zg45BQFvl/bMS5INQ=; b=DqO/Qli5wIMiSwBD8HsI0ETT1W
	ypcul6vfp2S2yoMv2m8iNDdcu8WHzAKuo+bxKVdYYSWjmkWiUCsPolC2zcauD18tNz/1J44VwyYsU
	2a3aXsuBnMPmWFJctcr5eLHVMeZ4UAROM6xhQqgQoq7zpIYPto9/HOLqrulbV1M6bvpA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6rYi-00FO5D-6S; Tue, 14 May 2024 14:47:08 +0200
Date: Tue, 14 May 2024 14:47:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 1/2] net: phy: dp83869: Add PHY ID for chip revision 3
Message-ID: <b2db4e61-8bc1-4076-a2b9-7b6a028461aa@lunn.ch>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>

On Tue, May 14, 2024 at 02:27:27PM +0200, Thomas Gessler wrote:
> The recent silicon revision 3 of the DP83869 has a different PHY ID
> which has to be added to the driver in order for the PHY to be detected.
> There appear to be no documented differences between the revisions,
> although there are some discussions in the TI forum about different
> behavior for some registers.

Do you have the datasheet? What does it say about the ID in registers
2 and 3? Often the lower nibble is the revision. Meaning there can be
16 revisions of a PHY.

>  static struct phy_driver dp83869_driver[] = {
> -	DP83869_PHY_DRIVER(DP83869_PHY_ID, "TI DP83869"),
> +	DP83869_PHY_DRIVER(DP83869REV1_PHY_ID, "TI DP83869 Rev. 1"),
> +	DP83869_PHY_DRIVER(DP83869REV3_PHY_ID, "TI DP83869 Rev. 3"),
>  	DP83869_PHY_DRIVER(DP83561_PHY_ID, "TI DP83561-SP"),

If you look at DP83869_PHY_DRIVER() it uses:

#define DP83869_PHY_DRIVER(_id, _name)                          \
{                                                               \
        PHY_ID_MATCH_MODEL(_id),                                \

As the name suggests, it matches on the model. The revision is
ignored. A mask is applied to ignore the lower nibble. So this change
looks pointless.

>  static struct mdio_device_id __maybe_unused dp83869_tbl[] = {
> -	{ PHY_ID_MATCH_MODEL(DP83869_PHY_ID) },
> +	{ PHY_ID_MATCH_MODEL(DP83869REV1_PHY_ID) },
> +	{ PHY_ID_MATCH_MODEL(DP83869REV3_PHY_ID) },
>  	{ PHY_ID_MATCH_MODEL(DP83561_PHY_ID) },

And this has the same issue. If you want the match to include the
revision, you need to use PHY_ID_MATCH_EXACT(). If the different
revisions are supposed to be compatible, a single PHY_ID_MATCH_MODEL()
is sufficient.

    Andrew

---
pw-bot: cr

